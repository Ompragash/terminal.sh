subscription-manager register --username=rhn-support-oviswana --password='##21221544bB$$'

sudo subscription-manager repos --enable rhel-7-server-optional-rpms --enable rhel-server-rhscl-7-rpms

sudo yum -y install @development

sudo yum -y install rh-python36

sudo yum -y install rh-python36-numpy rh-python36-scipy rh-python36-python-tools rh-python36-python-six
