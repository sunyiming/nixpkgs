{ lib
, buildPythonPackage
, dateparser
, fetchFromGitHub
, importlib-metadata
, numpy
, pytestCheckHook
, python-dateutil
, pythonOlder
, pytz
, requests
, requests-mock
, shapely
, wktutils
}:

buildPythonPackage rec {
  pname = "asf-search";
  version = "4.0.1";
  format = "setuptools";

  disabled = pythonOlder "3.7";

  src = fetchFromGitHub {
    owner = "asfadmin";
    repo = "Discovery-asf_search";
    rev = "refs/tags/v${version}";
    hash = "sha256-58roOxLFTu7WddgifuvaMoFlEh+iHrrL0rSJjAw35d0=";
  };

  propagatedBuildInputs = [
    dateparser
    importlib-metadata
    numpy
    python-dateutil
    pytz
    requests
    shapely
    wktutils
  ];

  checkInputs = [
    pytestCheckHook
    requests-mock
  ];

  postPatch = ''
    substituteInPlace setup.py \
      --replace "WKTUtils==" "WKTUtils>="
  '';

  pythonImportsCheck = [
    "asf_search"
  ];

  meta = with lib; {
    description = "Python wrapper for the ASF SearchAPI";
    homepage = "https://github.com/asfadmin/Discovery-asf_search";
    license = licenses.bsd3;
    maintainers = with maintainers; [ bzizou ];
  };
}
