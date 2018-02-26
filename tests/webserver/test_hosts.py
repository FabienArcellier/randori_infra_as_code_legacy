import pytest

def test_should_listen_on_port_80(host):
    # Assign
    assert host.socket("tcp://80").is_listening