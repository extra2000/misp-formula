# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import MISP with context %}

misp-image-present:
  cmd.run:
    - name: podman build -t {{ MISP.misp.image.name }} -f Dockerfile .
    - cwd: /opt/misp/misp-docker/web
    - runas: {{ MISP.hostuser.name }}
