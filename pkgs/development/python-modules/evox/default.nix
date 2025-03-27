{
  buildPythonPackage,
  fetchFromGitHub,
  lib,
  pandas,
  plotly,
  pytestCheckHook,
  torch,
  torchvision,
  unittestCheckHook,
}:

let
  version = "1.1.1";
in
buildPythonPackage {
  inherit version;
  pname = "evox";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "EMI-Group";
    repo = "evox";
    tag = "v${version}";
    hash = "sha256-akAjX1MhPqN8DLsrOHRLf9OjMkgS2VN/+xvrS82Des8=";
  };

  dependencies = [
    torch
  ];

  optional-dependencies = rec {
    vis = [
      pandas
      plotly
    ];

    neuroevolution = [
      torchvision
    ];

    default = vis;
  };

  nativeCheckInputs = [
    unittestCheckHook
    torchvision
    plotly
  ];

  disabledTests = [ "unit_test/problems/test_brax.py" ];

  pythonImportsCheck = [ "evox" ];

  meta = {
    description = "EvoX is a distributed GPU-accelerated evolutionary computation framework";
    homepage = "https://github.com/EMI-Group/evox";
    changelog = "https://github.com/EMI-Group/evox/releases/tag/v${version}";
    license = lib.licenses.gpl3;
    maintainers = with lib.maintainers; [ billhuang ];
  };
}
