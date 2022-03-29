# Documentation

This is an example about a module documentation

Here we will find the values that must me required and optional to use this module

## Attributes

### VCN - Module Attributes
Those are the attributes to set on VCN modules

<!--START-->
| Attributes           | Description | Type             |
| :-----------------   | :---------- | :--------------- |
| compartment_id       | Compartment for this subnet    | String           |
| cidr_blocks          | IP Range of the CIDR block    | String           |
| display_name         | User-friendly name    | String           |
<!--END-->

With those information will be enogth to use the module


### SUBNET - Module Attributes
Those are the attributes to set on VCN modules

Those are the attributes to set on VCN modules

<!--START-->
| Attributes           | Description | Type             |
| :-----------------   | :---------- | :--------------- |
| compartment_id       | Compartment for this subnet    | String           |
| cidr                 | IP Range of the CIDR block    | String           |
| name                 | User-friendly name    | String           |
<!--END-->

## Inputs

The inputs to use this module must be on the next form:

```JSON:
map(object({
    compartment_id    = string,
    cidr              = string,
    display_name      = string,
    subnets = map(object({
        compartment_id    = string,
        name              = string,
        cidr              = string
    }))
}))
```

## Example

```JSON:
locals {
  vcn_keys = {
    vcn_poc1 = {
      compartment_id = "ocid.xxxx...xxxxxxxxq"
      cidr  = "10.0.0.0/16"
      display_name = "vcn_1"
      subnets = {
        sub_poc1_1 = {
          compartment_id  = "ocid.xxxx...xxxxxxxxq"
          name            = "sub_tpoc1_1"
          cidr            = "10.0.0.0/24"
        },
        sub_poc1_2 = {
          compartment_id  = "ocid.xxxx...xxxxxxxxq"
          name            = "sub_tpoc1_2"
          cidr            = "10.0.1.0/24"
        }
      }
    },
    vcn_poc2 = {
      compartment_id = "ocid.xxxx...xxxxxxxxq"
      cidr  = "11.0.0.0/22"
      display_name = "vcn_2"
      subnets = {
        sub_poc2_1 = {
          compartment_id  = "ocid.xxxx...xxxxxxxxq"
          name            = "sub_tpoc2_1"
          cidr            = "11.0.0.0/24"
        }
      }
    }
  }
}
```

## Validations

For this step, you should have on the same folder 3 files:

1. Json schema file
2. Python script
3. Input json/yaml file

To execute the validations you have to use on a terminal:

```python:
python3 <python_script_name_file.py>
```


### Json Schema

To validate all the inputs used for this module, you have to use the next json schema file


```json:
{
  "$schema": "http://json-schema.org/draft-04/schema#",
  "title": "User",
  "description": "A user request json",
  "type": "object",
  "properties": {
    "vcn_keys": {
      "type": "object",
      "patternProperties": {
        "[a-zA-Z0-9_]+": {
          "type": "object",
          "properties": {
            "compartment_id": {
              "description": "ocid info",
              "type": "string"
            },
            "cidr": {
              "description": "cdir range",
              "type": "string"
            },
            "subnets": {
              "type": "object",
              "patternProperties": {
                "[a-zA-Z0-9_]+": {
                  "type": "object",
                  "properties": {
                    "compartment_id": {
                      "description": "ocid info",
                      "type": "string"
                    },
                    "name": {
                      "description": "ocid info",
                      "type": "string"
                    },
                    "cidr": {
                      "description": "cdir range",
                      "type": "string"
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}
```

### Python script

To validate your inputs variable, you have to use the next python example:

````python:
import json
import jsonschema
from jsonschema import validate

def get_schema():
    with open('<input_json_file.json>', 'r') as file:
        schema = json.load(file)
    return schema

def validate_json(json_data):
    execute_api_schema = get_schema()
    try:
        validate(instance=json_data, schema=execute_api_schema)
    except jsonschema.exceptions.ValidationError as err:
        print(err)
        err = "Given JSON data is InValid"
        return False, err

    message = "Given JSON data is Valid"
    return True, message

f = open('<json_schema_file.json>')

data = json.load(f)

for i, obj in enumerate(data['vcn_keys']):
    try:
        # validate(instance=obj, schema=schema)
        print(data)
        validate_json(data)
    except Exception as e:
        print(f"obj {i} invalid: {e}")
    else:
        print(f"obj {i} valid")

for obj in data['vcn_keys']:
    print(data)
````


