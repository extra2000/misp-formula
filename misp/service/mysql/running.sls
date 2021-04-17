# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import MISP with context %}

mysql-image-present:
  cmd.run:
    - name: podman pull {{ MISP.mysql.image.name }}
    - retry:
        attempts: 10
        interval: 5
        until: true
    - runas: {{ MISP.hostuser.name }}

mysql-pod-destroy-if-exists:
  module.run:
    - state.sls:
      - mods:
        - misp.service.mysql.destroy

mysql-pod-running:
  cmd.run:
    - name: podman play kube --network=mispnet mysql-pod.yaml
    - cwd: /opt/misp
    - runas: {{ MISP.hostuser.name }}
    - require:
      - cmd: mysql-image-present
      - module: mysql-pod-destroy-if-exists
