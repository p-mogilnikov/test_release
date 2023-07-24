import configparser

def read_version_from_pyproject_toml():
    config = configparser.ConfigParser()
    config.read("pyproject.toml")

    try:
        version = config["tool.poetry"]["version"]
        return version
    except KeyError:
        raise ValueError("Version not found in pyproject.toml")

if __name__ == "__main__":
    version = read_version_from_pyproject_toml()
    print("Version from pyproject.toml:", version)
