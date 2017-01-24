{% from "icinga2/map.jinja" import icinga2 with context %}

{% if grains['os_family'] == 'Debian' %}
icinga2_repo:
  pkgrepo.managed:
    - humanname: Icinga2 official repo
    - name: {{ icinga2.pkg_repo }}
    - file: {{ icinga2.repo_file }}
    - key_url: http://packages.icinga.org/icinga.key
{% elif grains['os_family'] == 'RedHat' %}
icinga2_repo:
  pkgrepo.managed:
    - humanname: Icinga2 official repo
    - baseurl: {{ icinga2.pkg_repo }}
    - gpgkey: http://packages.icinga.org/icinga.key
    - gpgcheck: 1
{% endif %}

icinga2_pkg:
  pkg.installed:
    - name: icinga2
    - require:
      - pkgrepo: icinga2_repo

icinga2_service:
  service.running:
    - name: icinga2
    - enable: True
    - reload: True
