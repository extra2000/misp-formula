# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import MISP with context %}

/etc/sysctl.d/02-unprivileged-port-start-80.conf:
  file.managed:
    - source: salt://misp/files/02-unprivileged-port-start-80.conf

sysctl -w net.ipv4.ip_unprivileged_port_start=80:
  cmd.run
