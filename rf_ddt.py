import re
import sys

def read_file_append_lf(filename):

    combined_lines = ""
    with open(filename, "r", encoding="utf-8") as file:
        for line in file:
            combined_lines += line.rstrip("\n") + "###LF###"

    return combined_lines

def de_lf(content):

    return re.sub("###LF###", "\n", content)

def parse_data(data_part):

    rows = data_part.split("###LF###")
    header_row = parse_data_row(rows[0])
    data_rows = parse_data_rows(header_row, rows[1:])

    return data_rows

def parse_data_row(row):

    columns = []
    row = re.sub("^#", "", row)
    for column in row.split("|"):
        columns.append(column.strip())

    return columns

def parse_data_rows(headers, rows):

    value_maps = []
    for row in rows:
        values = parse_data_row(row)
        if len(headers) == len(values):
            value_map = {}
            for i, value in enumerate(values):
                value_map[headers[i]] = value
            value_maps.append(value_map)

        else:
            if len(values) > 1:
                print("Length of headers does not match values: " + str(len(headers)) + " != " + str(len(values)))
                print("row: " + row)

    return value_maps

def create_expanded_test_set(test_part, data_part):

    test_parameters = parse_data(data_part)

    expanded_tests = ""

    test_number = 0
    for value_map in test_parameters:
        test_number += 1
        expanded_test = expand_test_title(test_number, value_map, test_part)
        expanded_test = populate_test_data(value_map, expanded_test)
        expanded_tests += expanded_test

    return expanded_tests

def expand_test_title(test_number, value_map, test_part):

    if "ID" in value_map.keys():
        test_id = value_map["ID"]
    else:
        test_id = "(" + str(test_number) + ")"

    return test_id + " " + test_part

def populate_test_data(value_map, test_part):

    for key, value in value_map.items():
        rf_variable = "${" + key + "}"
        test_part = test_part.replace(rf_variable, value)

    return test_part

def extract_sections(data):

    sections = re.search(r"(.*?)#@DDT-Test:###LF###(.*?)#@DDT-Data:###LF###(.*?)#@DDT-Data-end###LF###(.*)", data)

    if sections:
        return True, sections.group(1), sections.group(2), sections.group(3), sections.group(4)

    else:
        return False, None, None, None, None

def main():

    if len(sys.argv) > 1:
        filename = sys.argv[1]
    else:
        print("  usage: python rf_ext.py [robot_file]")
        sys.exit(1)

    data = read_file_append_lf(filename)
    has_ddt, start_part, test_part, data_part, end_part = extract_sections(data)
    if has_ddt:
        expanded_tests = create_expanded_test_set(test_part, data_part)
        data = start_part + expanded_tests + end_part

    print(de_lf(data))

main()
