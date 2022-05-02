import argparse
import json
from pathlib import Path
import os
from peck.ir import visualizer
from peck.solidity import compile_cfg
from peck.staticanalysis import factencoder, souffle, visualization as fact_visualizer

def get_tainted_sinks(compile_output, contract_graph, contract_facts, *, input_file):
    # Run the Datalog analyzer
    datalog_analyzer = Path(__file__).parent / "analyze.dl"
    output, facts_out = souffle.run_souffle(
        datalog_analyzer,
        facts=contract_facts)

    # The output must be either 'Tainted' or 'Safe':
    tainted_sinks = set()
    if not facts_out['tainted_sinks']:
        tainted_sinks.add('')
    else:
        for sink_tuple in facts_out['tainted_sinks']:
            sink = sink_tuple[0]
            tainted_sinks.add(sink)
    return tainted_sinks


if __name__ == '__main__':
    # Parse command line.
    parser = argparse.ArgumentParser()
    parser.add_argument('input_file', type=Path)
    args = parser.parse_args()
    ground_truth_file_path = args.input_file
    # print(ground_truth_file_path)

    summary = []

    with open(ground_truth_file_path) as ground_truth_file:
        for line in ground_truth_file:
            contract_name, tainted_sinks = line.split(";")
            contract_name += ".sol"
            tainted_sinks_ground_truth = []
            for sink in tainted_sinks.split(","):
                tainted_sinks_ground_truth.append(sink.strip())
            tainted_sinks_ground_truth = set(tainted_sinks_ground_truth)

            contract_path = os.path.join('test_contracts', contract_name)

            # Compile source to a control flow graph and Datalog facts.
            compile_output = compile_cfg(str(contract_path))
            contract_graph = compile_output.cfg.contracts[0]
            contract_facts = factencoder.encode(contract_graph)

            tainted_sinks_predicted = get_tainted_sinks(compile_output, contract_graph, contract_facts, input_file=args.input_file)
            
            if tainted_sinks_predicted != tainted_sinks_ground_truth:
                print(tainted_sinks_predicted, tainted_sinks_ground_truth)
                summary.append(f"Contract {contract_name} has errors. \n expected: {tainted_sinks_ground_truth}, got: {tainted_sinks_predicted}")
    
    if summary:
        print("-------------------------------")
        for contract in summary:
            print(contract)
            print("-------------------------------")
    else:
        print("No errors found!")
