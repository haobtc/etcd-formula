# -*- coding: utf-8 -*-
# vim: ft=yaml
{% from "etcd/map.jinja" import etcd_settings,systemd with context -%}

include:
  - etcd.install

{% if systemd -%}
etcd-systemd-conf-file:
  file.managed:
    - name: /etc/default/etcd
    - source: salt://etcd/files/etcd.service.conf.static.jinja
    - user: root
    - group: root
    - mode: 0644
    - template: jinja
    - watch_in:
        service: etcd-service
{% else -%}
etcd-upstart-override:
  file.managed:
    - name: /etc/init/etcd.override
    - source: salt://etcd/files/etcd.override.static.jinja
    - user: root
    - group: root
    - mode: 0644
    - template: jinja
    - watch_in:
        service: etcd-service
{% endif -%}
