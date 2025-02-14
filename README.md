# PaxConverter
This script is used specifically for BCIT Network Security Program to make, compile and validate
the submission file based on the requirements listed [here](https://docs.google.com/document/d/1FetwqOGgXSKXtQ53KS0I9BxGFzRNHT30NguP3FZFkME/edit?tab=t.0#heading=h.u614bhlcrspi).

### Cloning
```git clone https://github.com/Matirix/PaxConverter.git```

### Building
To make this into an executable (Ensure you're in the proper directory after cloning)
```chmod +x paxconverter.sh```

### Running
```paxconverter.sh <folder_path> <pax_name> [mode]```


### `paxconverter.sh` Parameters

| Parameter     | Description                                      |
|--------------|--------------------------------------------------|
| `folder_path` | Path to where the subdirectories are located.   |
| `folder_name` | Name of the to-be-created pax file.             |
| `mode` (optional) | Specifies an operation mode (see options below). |

### Mode Options

| Mode | Description                                       |
|------|---------------------------------------------------|
| `1`  | Creates the subdirectories in <folder_path>       |
| `2`  | Validate the pax file*                            |

* Validate will make a copy of the pax.Z file into another folder within <folder_path>,
uncompress it, print out the folder structure and the folder structure of each sub directory.

### Example
This will make the required subdirectories in assn1
```paxconverter.sh user/projects/comp7003/assn1```

This will return a pax.Z file
```paxconverter.sh user/projects/comp7003/assn1 comp7003-assign1-v1```

This will create a folder called validation that will fully unpack the pax.Z file and print out the contents of each directory.
```paxconverter.sh user/projects/comp7003/assn1 comp7003-assign1-v1 2```

This will look for a pax.Z file and create a folder called validation that will fully unpack the pax.Z file and print out the contents of each directory.
```paxconverter.sh user/projects/comp7003/assn1 2```
