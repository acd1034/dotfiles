import argparse
from pathlib import Path

import json5 as json
import yaml


def yaml_to_json(input_path: Path, output_path: Path):
    with input_path.open("r", encoding="utf-8") as f:
        data = yaml.safe_load(f)

    with output_path.open("w", encoding="utf-8") as f:
        json.dump(data, f, ensure_ascii=False, quote_keys=True, indent=2)

    print(f"Converted YAML -> JSON: {output_path}")


def json_to_yaml(input_path: Path, output_path: Path):
    with input_path.open("r", encoding="utf-8") as f:
        data = json.load(f)

    with output_path.open("w", encoding="utf-8") as f:
        yaml.safe_dump(data, f, allow_unicode=True, sort_keys=False, indent=2)

    print(f"Converted JSON -> YAML: {output_path}")


def main():
    parser = argparse.ArgumentParser(description="Convert YAML <-> JSON")
    parser.add_argument("input_file", help="Input file (.yaml/.yml/.json)")
    parser.add_argument("-o", "--output", help="Output file path (optional)")

    args = parser.parse_args()

    input_path = Path(args.input_file)
    suffix = input_path.suffix.lower()

    if suffix in [".yaml", ".yml"]:
        output_path = (
            Path(args.output) if args.output else input_path.with_suffix(".json")
        )
        yaml_to_json(input_path, output_path)

    elif suffix == ".json":
        output_path = (
            Path(args.output) if args.output else input_path.with_suffix(".yaml")
        )
        json_to_yaml(input_path, output_path)

    else:
        raise ValueError("Unsupported file type. Use .yaml, .yml, or .json")


if __name__ == "__main__":
    main()
