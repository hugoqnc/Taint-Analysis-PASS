import argparse
import json
from pathlib import Path
import os
from peck.ir import visualizer
from peck.solidity import compile_cfg
from peck.staticanalysis import factencoder, souffle, visualization as fact_visualizer

def get_tainted_sinks(contract_facts):
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


def print_summary(summary):
    if summary:
        print("-------------------------------")
        for contract in summary:
            print(contract)
            print("-------------------------------")
    else:
        print("No errors found!")


def get_encoded_contract(contract_path):
    # Compile source to a control flow graph and Datalog facts.
    compile_output = compile_cfg(str(contract_path))
    contract_graph = compile_output.cfg.contracts[0]
    contract_facts = factencoder.encode(contract_graph)
    return compile_output, contract_graph, contract_facts


def run_custom_tests(file_path):
    print("running custom tests...")
    summary = []
    with open(file_path) as ground_truth_file:
        for line in ground_truth_file:
            contract_name, tainted_sinks = line.split(";")
            contract_name += ".sol"
            tainted_sinks_ground_truth = []
            for sink in tainted_sinks.split(","):
                tainted_sinks_ground_truth.append(sink.strip())
            tainted_sinks_ground_truth = set(tainted_sinks_ground_truth)

            contract_path = os.path.join('test_contracts', contract_name)

            compile_output, contract_graph, contract_facts = get_encoded_contract(contract_path)
            tainted_sinks_predicted = get_tainted_sinks(contract_facts)
            
            if tainted_sinks_predicted != tainted_sinks_ground_truth:
                summary.append(f"Contract {contract_name} has errors. \n Expected: {tainted_sinks_ground_truth}, got: {tainted_sinks_predicted}")
    return summary


def read_ground_truth(folder):
    gt_file = "gt.txt"
    ground_truths = dict()
    with open(os.path.join(folder, gt_file)) as in_file:
        for line in in_file:
            file_name, ground_truth = line.split(" ")
            ground_truths[file_name] = ground_truth
    return ground_truths


def run_preliminary_tests():
    print("running preliminary tests...")
    folder = "preliminary_test_contracts"
    ground_truths = read_ground_truth(folder)
    summary = []
    for file, ground_truth in ground_truths.items():
        ground_truth = ground_truth.strip()
        contract_path = os.path.join(folder, file)
        compile_output, contract_graph, contract_facts = get_encoded_contract(contract_path)
        tainted_sinks_predicted = get_tainted_sinks(contract_facts)
        result = "Safe" if tainted_sinks_predicted == {''} else "Tainted"
        if result != ground_truth:
            summary.append(f"Contract {file} has errors. Expected: {ground_truth}, got: {result}")
    return summary


if __name__ == '__main__':
    # Parse command line.
    parser = argparse.ArgumentParser()
    parser.add_argument('input_file', type=Path)
    args = parser.parse_args()
    ground_truth_file_path = args.input_file
    # print(ground_truth_file_path)

    summary_custom_tests = run_custom_tests(ground_truth_file_path)
    summary_preliminary = run_preliminary_tests()

    print_summary(summary_custom_tests + summary_preliminary)
