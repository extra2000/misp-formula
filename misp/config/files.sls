# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import MISP with context %}

/opt/misp:
  file.directory:
    - user: {{ MISP.hostuser.name }}
    - group: {{ MISP.hostuser.group }}

/home/{{ MISP.hostuser.name }}/.config/cni/net.d:
  file.directory:
    - user: {{ MISP.hostuser.name }}
    - group: {{ MISP.hostuser.group }}
    - makedirs: true

/home/{{ MISP.hostuser.name }}/.config/cni/net.d/podman-network-mispnet.conflist:
  file.managed:
    - source: salt://misp/files/podman-network-mispnet.conflist.jinja
    - user: {{ MISP.hostuser.name }}
    - group: {{ MISP.hostuser.group }}
    - template: jinja
    - context:
      pod: {{ MISP.pod }}

/opt/misp/misp-docker:
  file.recurse:
    - source: salt://misp/files/misp-docker
    - user: {{ MISP.hostuser.name }}
    - group: {{ MISP.hostuser.group }}
    - show_changes: false
    - file_mode: keep

/opt/misp/mysql-pod.yaml:
  file.managed:
    - source: salt://misp/files/mysql-pod.yaml
    - user: {{ MISP.hostuser.name }}
    - group: {{ MISP.hostuser.group }}
    - template: jinja
    - context:
      mysql: {{ MISP.mysql }}

/opt/misp/misp-pod.yaml:
  file.managed:
    - source: salt://misp/files/misp-pod.yaml
    - user: {{ MISP.hostuser.name }}
    - group: {{ MISP.hostuser.group }}
    - template: jinja
    - context:
      misp: {{ MISP.misp }}
