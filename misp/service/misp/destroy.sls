# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import MISP with context %}

misp-pod-destroy:
  cmd.run:
    - name: podman pod rm --force misp-pod
    - runas: {{ MISP.hostuser.name }}
