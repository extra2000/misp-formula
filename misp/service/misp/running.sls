# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import MISP with context %}

misp-pod-destroy-if-exists:
  module.run:
    - state.sls:
      - mods:
        - misp.service.misp.destroy

misp-containers-running:
  cmd.run:
    - name: podman play kube --network=mispnet misp-pod.yaml
    - cwd: /opt/misp
    - runas: {{ MISP.hostuser.name }}
    - require:
      - module: misp-pod-destroy-if-exists
