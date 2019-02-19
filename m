From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 19 Feb 2019 17:47:53 +0300
Subject: [LTP] [PATCH 4/4] network: add new test-cases with randomized
	message length
In-Reply-To: <1550587673-7995-1-git-send-email-alexey.kodanev@oracle.com>
References: <1550587673-7995-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1550587673-7995-5-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* Change test-cases in dctcp01 (TCP). Default size changed to random size.

* New test-cases added to tcp, sctp and udp IPsec tests

* Updated bind_noport01

* New tests: gre02, geneve02, macsec03, vxlan04

* Besides random payload changes:
  - in macsec03, replay window increased from 300 to 1000
  - vxlan04 and geneve02: new checksum testcases
  - new tests use different protocol types

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 runtest/net.features                            |    9 +
 runtest/net_stress.ipsec_dccp                   |  208 +++++++++++-----------
 runtest/net_stress.ipsec_sctp                   |  208 +++++++++++-----------
 runtest/net_stress.ipsec_tcp                    |  208 +++++++++++-----------
 runtest/net_stress.ipsec_udp                    |  212 +++++++++++-----------
 testcases/network/sockets/bind_noport01.sh      |   15 ++-
 testcases/network/stress/dccp/dccp_ipsec.sh     |    6 +-
 testcases/network/stress/dccp/dccp_ipsec_vti.sh |    6 +-
 testcases/network/stress/sctp/sctp_ipsec.sh     |    6 +-
 testcases/network/stress/sctp/sctp_ipsec_vti.sh |    6 +-
 testcases/network/stress/tcp/tcp_ipsec.sh       |    6 +-
 testcases/network/stress/tcp/tcp_ipsec_vti.sh   |    6 +-
 testcases/network/stress/udp/udp_ipsec.sh       |    7 +-
 testcases/network/stress/udp/udp_ipsec_vti.sh   |    7 +-
 testcases/network/virt/geneve02.sh              |   38 ++++
 testcases/network/virt/gre02.sh                 |   11 ++
 testcases/network/virt/macsec03.sh              |   13 ++
 testcases/network/virt/virt_lib.sh              |   10 +
 testcases/network/virt/vxlan04.sh               |   39 ++++
 19 files changed, 592 insertions(+), 429 deletions(-)
 create mode 100755 testcases/network/virt/geneve02.sh
 create mode 100755 testcases/network/virt/gre02.sh
 create mode 100755 testcases/network/virt/macsec03.sh
 create mode 100755 testcases/network/virt/vxlan04.sh

diff --git a/runtest/net.features b/runtest/net.features
index c5a36a6..44a9745 100644
--- a/runtest/net.features
+++ b/runtest/net.features
@@ -38,6 +38,9 @@ vxlan_uni_03 vxlan03.sh -d uni
 vxlan_ipv6_multi_03 vxlan03.sh -6 -d multi
 vxlan_ipv6_uni_03 vxlan03.sh -6 -d uni
 
+vxlan_uni_04 vxlan04.sh -d uni
+vxlan_ipv6_uni_04 vxlan04.sh -6 -d uni
+
 vlan01 vlan01.sh
 vlan02 vlan02.sh
 vlan03 vlan03.sh
@@ -47,17 +50,23 @@ macvtap01 macvtap01.sh
 
 macsec01 macsec01.sh
 macsec02 macsec02.sh
+macsec03 macsec03.sh
 
 ipvlan01 ipvlan01.sh
 
 gre_ipv4_01 gre01.sh
 gre_ipv6_01 gre01.sh -6
 
+gre_ipv4_02 gre02.sh
+gre_ipv6_02 gre02.sh -6
+
 dctcp_ipv4_01 dctcp01.sh
 dctcp_ipv6_01 dctcp01.sh -6
 
 geneve01 geneve01.sh
 geneve01_ipv6 geneve01.sh -6
+geneve02 geneve02.sh
+geneve02_ipv6 geneve02.sh -6
 
 sit01 sit01.sh
 
diff --git a/runtest/net_stress.ipsec_dccp b/runtest/net_stress.ipsec_dccp
index cdd10da..e765d35 100644
--- a/runtest/net_stress.ipsec_dccp
+++ b/runtest/net_stress.ipsec_dccp
@@ -1,109 +1,109 @@
-dccp4_ipsec01 dccp_ipsec.sh -s 100:500:1000
-dccp4_ipsec02 dccp_ipsec.sh -p ah -m transport -s 100:500:1000
-dccp4_ipsec03 dccp_ipsec.sh -p ah -m tunnel -s 100:500:1000
-dccp4_ipsec04 dccp_ipsec.sh -p esp -m transport -s 100:500:1000
-dccp4_ipsec05 dccp_ipsec.sh -p esp -m tunnel -s 100:500:1000
-dccp4_ipsec06 dccp_ipsec.sh -p comp -m transport -s 100:500:1000
-dccp4_ipsec07 dccp_ipsec.sh -p comp -m tunnel -s 100:500:1000
-dccp4_ipsec08 dccp_ipsec.sh -A rfc4106_128 -p esp_aead -m transport -s 100:500:1000
-dccp4_ipsec09 dccp_ipsec.sh -A rfc4106_128 -p esp_aead -m tunnel -s 100:500:1000
-dccp4_ipsec10 dccp_ipsec.sh -A rfc4106_192 -p esp_aead -m transport -s 100:500:1000
-dccp4_ipsec11 dccp_ipsec.sh -A rfc4106_192 -p esp_aead -m tunnel -s 100:500:1000
-dccp4_ipsec12 dccp_ipsec.sh -A rfc4106_256 -p esp_aead -m transport -s 100:500:1000
-dccp4_ipsec13 dccp_ipsec.sh -A rfc4106_256 -p esp_aead -m tunnel -s 100:500:1000
-dccp4_ipsec14 dccp_ipsec.sh -A rfc4309_128 -p esp_aead -m transport -s 100:500:1000
-dccp4_ipsec15 dccp_ipsec.sh -A rfc4309_128 -p esp_aead -m tunnel -s 100:500:1000
-dccp4_ipsec16 dccp_ipsec.sh -A rfc4309_192 -p esp_aead -m transport -s 100:500:1000
-dccp4_ipsec17 dccp_ipsec.sh -A rfc4309_192 -p esp_aead -m tunnel -s 100:500:1000
-dccp4_ipsec18 dccp_ipsec.sh -A rfc4309_256 -p esp_aead -m transport -s 100:500:1000
-dccp4_ipsec19 dccp_ipsec.sh -A rfc4309_256 -p esp_aead -m tunnel -s 100:500:1000
-dccp4_ipsec20 dccp_ipsec.sh -A rfc4543_128 -p esp_aead -m transport -s 100:500:1000
-dccp4_ipsec21 dccp_ipsec.sh -A rfc4543_128 -p esp_aead -m tunnel -s 100:500:1000
-dccp4_ipsec22 dccp_ipsec.sh -A rfc4543_192 -p esp_aead -m transport -s 100:500:1000
-dccp4_ipsec23 dccp_ipsec.sh -A rfc4543_192 -p esp_aead -m tunnel -s 100:500:1000
-dccp4_ipsec24 dccp_ipsec.sh -A rfc4543_256 -p esp_aead -m transport -s 100:500:1000
-dccp4_ipsec25 dccp_ipsec.sh -A rfc4543_256 -p esp_aead -m tunnel -s 100:500:1000
-dccp4_ipsec26 dccp_ipsec.sh -p esp -a sha1 -e cast5 -m transport -s 100:500:1000
-dccp4_ipsec27 dccp_ipsec.sh -p esp -a sha1 -e cast5 -m tunnel -s 100:500:1000
-dccp4_ipsec28 dccp_ipsec.sh -p esp -a sha256 -e blowfish -m transport -s 100:500:1000
-dccp4_ipsec29 dccp_ipsec.sh -p esp -a sha256 -e blowfish -m tunnel -s 100:500:1000
-dccp4_ipsec30 dccp_ipsec.sh -p esp -a sha384 -e twofish -m transport -s 100:500:1000
-dccp4_ipsec31 dccp_ipsec.sh -p esp -a sha384 -e twofish -m tunnel -s 100:500:1000
-dccp4_ipsec32 dccp_ipsec.sh -p esp -a sha512 -e camellia -m transport -s 100:500:1000
-dccp4_ipsec33 dccp_ipsec.sh -p esp -a sha512 -e camellia -m tunnel -s 100:500:1000
-dccp4_ipsec34 dccp_ipsec.sh -p esp -a rmd160 -e serpent -m transport -s 100:500:1000
-dccp4_ipsec35 dccp_ipsec.sh -p esp -a rmd160 -e serpent -m tunnel -s 100:500:1000
-dccp4_ipsec36 dccp_ipsec.sh -p esp -m beet -s 100:500:1000
+dccp4_ipsec01 dccp_ipsec.sh -s 100:500:1000:R1000
+dccp4_ipsec02 dccp_ipsec.sh -p ah -m transport -s 100:500:1000:R1000
+dccp4_ipsec03 dccp_ipsec.sh -p ah -m tunnel -s 100:500:1000:R1000
+dccp4_ipsec04 dccp_ipsec.sh -p esp -m transport -s 100:500:1000:R1000
+dccp4_ipsec05 dccp_ipsec.sh -p esp -m tunnel -s 100:500:1000:R1000
+dccp4_ipsec06 dccp_ipsec.sh -p comp -m transport -s 100:500:1000:R1000
+dccp4_ipsec07 dccp_ipsec.sh -p comp -m tunnel -s 100:500:1000:R1000
+dccp4_ipsec08 dccp_ipsec.sh -A rfc4106_128 -p esp_aead -m transport -s 100:500:1000:R1000
+dccp4_ipsec09 dccp_ipsec.sh -A rfc4106_128 -p esp_aead -m tunnel -s 100:500:1000:R1000
+dccp4_ipsec10 dccp_ipsec.sh -A rfc4106_192 -p esp_aead -m transport -s 100:500:1000:R1000
+dccp4_ipsec11 dccp_ipsec.sh -A rfc4106_192 -p esp_aead -m tunnel -s 100:500:1000:R1000
+dccp4_ipsec12 dccp_ipsec.sh -A rfc4106_256 -p esp_aead -m transport -s 100:500:1000:R1000
+dccp4_ipsec13 dccp_ipsec.sh -A rfc4106_256 -p esp_aead -m tunnel -s 100:500:1000:R1000
+dccp4_ipsec14 dccp_ipsec.sh -A rfc4309_128 -p esp_aead -m transport -s 100:500:1000:R1000
+dccp4_ipsec15 dccp_ipsec.sh -A rfc4309_128 -p esp_aead -m tunnel -s 100:500:1000:R1000
+dccp4_ipsec16 dccp_ipsec.sh -A rfc4309_192 -p esp_aead -m transport -s 100:500:1000:R1000
+dccp4_ipsec17 dccp_ipsec.sh -A rfc4309_192 -p esp_aead -m tunnel -s 100:500:1000:R1000
+dccp4_ipsec18 dccp_ipsec.sh -A rfc4309_256 -p esp_aead -m transport -s 100:500:1000:R1000
+dccp4_ipsec19 dccp_ipsec.sh -A rfc4309_256 -p esp_aead -m tunnel -s 100:500:1000:R1000
+dccp4_ipsec20 dccp_ipsec.sh -A rfc4543_128 -p esp_aead -m transport -s 100:500:1000:R1000
+dccp4_ipsec21 dccp_ipsec.sh -A rfc4543_128 -p esp_aead -m tunnel -s 100:500:1000:R1000
+dccp4_ipsec22 dccp_ipsec.sh -A rfc4543_192 -p esp_aead -m transport -s 100:500:1000:R1000
+dccp4_ipsec23 dccp_ipsec.sh -A rfc4543_192 -p esp_aead -m tunnel -s 100:500:1000:R1000
+dccp4_ipsec24 dccp_ipsec.sh -A rfc4543_256 -p esp_aead -m transport -s 100:500:1000:R1000
+dccp4_ipsec25 dccp_ipsec.sh -A rfc4543_256 -p esp_aead -m tunnel -s 100:500:1000:R1000
+dccp4_ipsec26 dccp_ipsec.sh -p esp -a sha1 -e cast5 -m transport -s 100:500:1000:R1000
+dccp4_ipsec27 dccp_ipsec.sh -p esp -a sha1 -e cast5 -m tunnel -s 100:500:1000:R1000
+dccp4_ipsec28 dccp_ipsec.sh -p esp -a sha256 -e blowfish -m transport -s 100:500:1000:R1000
+dccp4_ipsec29 dccp_ipsec.sh -p esp -a sha256 -e blowfish -m tunnel -s 100:500:1000:R1000
+dccp4_ipsec30 dccp_ipsec.sh -p esp -a sha384 -e twofish -m transport -s 100:500:1000:R1000
+dccp4_ipsec31 dccp_ipsec.sh -p esp -a sha384 -e twofish -m tunnel -s 100:500:1000:R1000
+dccp4_ipsec32 dccp_ipsec.sh -p esp -a sha512 -e camellia -m transport -s 100:500:1000:R1000
+dccp4_ipsec33 dccp_ipsec.sh -p esp -a sha512 -e camellia -m tunnel -s 100:500:1000:R1000
+dccp4_ipsec34 dccp_ipsec.sh -p esp -a rmd160 -e serpent -m transport -s 100:500:1000:R1000
+dccp4_ipsec35 dccp_ipsec.sh -p esp -a rmd160 -e serpent -m tunnel -s 100:500:1000:R1000
+dccp4_ipsec36 dccp_ipsec.sh -p esp -m beet -s 100:500:1000:R1000
 
-dccp6_ipsec01 dccp_ipsec.sh -6 -s 100:500:1000
-dccp6_ipsec02 dccp_ipsec.sh -6 -p ah -m transport -s 100:500:1000
-dccp6_ipsec03 dccp_ipsec.sh -6 -p ah -m tunnel -s 100:500:1000
-dccp6_ipsec04 dccp_ipsec.sh -6 -p esp -m transport -s 100:500:1000
-dccp6_ipsec05 dccp_ipsec.sh -6 -p esp -m tunnel -s 100:500:1000
-dccp6_ipsec06 dccp_ipsec.sh -6 -p comp -m transport -s 100:500:1000
-dccp6_ipsec07 dccp_ipsec.sh -6 -p comp -m tunnel -s 100:500:1000
-dccp6_ipsec08 dccp_ipsec.sh -6 -A rfc4106_128 -p esp_aead -m transport -s 100:500:1000
-dccp6_ipsec09 dccp_ipsec.sh -6 -A rfc4106_128 -p esp_aead -m tunnel -s 100:500:1000
-dccp6_ipsec10 dccp_ipsec.sh -6 -A rfc4106_192 -p esp_aead -m transport -s 100:500:1000
-dccp6_ipsec11 dccp_ipsec.sh -6 -A rfc4106_192 -p esp_aead -m tunnel -s 100:500:1000
-dccp6_ipsec12 dccp_ipsec.sh -6 -A rfc4106_256 -p esp_aead -m transport -s 100:500:1000
-dccp6_ipsec13 dccp_ipsec.sh -6 -A rfc4106_256 -p esp_aead -m tunnel -s 100:500:1000
-dccp6_ipsec14 dccp_ipsec.sh -6 -A rfc4309_128 -p esp_aead -m transport -s 100:500:1000
-dccp6_ipsec15 dccp_ipsec.sh -6 -A rfc4309_128 -p esp_aead -m tunnel -s 100:500:1000
-dccp6_ipsec16 dccp_ipsec.sh -6 -A rfc4309_192 -p esp_aead -m transport -s 100:500:1000
-dccp6_ipsec17 dccp_ipsec.sh -6 -A rfc4309_192 -p esp_aead -m tunnel -s 100:500:1000
-dccp6_ipsec18 dccp_ipsec.sh -6 -A rfc4309_256 -p esp_aead -m transport -s 100:500:1000
-dccp6_ipsec19 dccp_ipsec.sh -6 -A rfc4309_256 -p esp_aead -m tunnel -s 100:500:1000
-dccp6_ipsec20 dccp_ipsec.sh -6 -A rfc4543_128 -p esp_aead -m transport -s 100:500:1000
-dccp6_ipsec21 dccp_ipsec.sh -6 -A rfc4543_128 -p esp_aead -m tunnel -s 100:500:1000
-dccp6_ipsec22 dccp_ipsec.sh -6 -A rfc4543_192 -p esp_aead -m transport -s 100:500:1000
-dccp6_ipsec23 dccp_ipsec.sh -6 -A rfc4543_192 -p esp_aead -m tunnel -s 100:500:1000
-dccp6_ipsec24 dccp_ipsec.sh -6 -A rfc4543_256 -p esp_aead -m transport -s 100:500:1000
-dccp6_ipsec25 dccp_ipsec.sh -6 -A rfc4543_256 -p esp_aead -m tunnel -s 100:500:1000
-dccp6_ipsec26 dccp_ipsec.sh -6 -p esp -a sha1 -e cast5 -m transport -s 100:500:1000
-dccp6_ipsec27 dccp_ipsec.sh -6 -p esp -a sha1 -e cast5 -m tunnel -s 100:500:1000
-dccp6_ipsec28 dccp_ipsec.sh -6 -p esp -a sha256 -e blowfish -m transport -s 100:500:1000
-dccp6_ipsec29 dccp_ipsec.sh -6 -p esp -a sha256 -e blowfish -m tunnel -s 100:500:1000
-dccp6_ipsec30 dccp_ipsec.sh -6 -p esp -a sha384 -e twofish -m transport -s 100:500:1000
-dccp6_ipsec31 dccp_ipsec.sh -6 -p esp -a sha384 -e twofish -m tunnel -s 100:500:1000
-dccp6_ipsec32 dccp_ipsec.sh -6 -p esp -a sha512 -e camellia -m transport -s 100:500:1000
-dccp6_ipsec33 dccp_ipsec.sh -6 -p esp -a sha512 -e camellia -m tunnel -s 100:500:1000
-dccp6_ipsec34 dccp_ipsec.sh -6 -p esp -a rmd160 -e serpent -m transport -s 100:500:1000
-dccp6_ipsec35 dccp_ipsec.sh -6 -p esp -a rmd160 -e serpent -m tunnel -s 100:500:1000
-dccp6_ipsec36 dccp_ipsec.sh -6 -p esp -m beet -s 100:500:1000
+dccp6_ipsec01 dccp_ipsec.sh -6 -s 100:500:1000:R1000
+dccp6_ipsec02 dccp_ipsec.sh -6 -p ah -m transport -s 100:500:1000:R1000
+dccp6_ipsec03 dccp_ipsec.sh -6 -p ah -m tunnel -s 100:500:1000:R1000
+dccp6_ipsec04 dccp_ipsec.sh -6 -p esp -m transport -s 100:500:1000:R1000
+dccp6_ipsec05 dccp_ipsec.sh -6 -p esp -m tunnel -s 100:500:1000:R1000
+dccp6_ipsec06 dccp_ipsec.sh -6 -p comp -m transport -s 100:500:1000:R1000
+dccp6_ipsec07 dccp_ipsec.sh -6 -p comp -m tunnel -s 100:500:1000:R1000
+dccp6_ipsec08 dccp_ipsec.sh -6 -A rfc4106_128 -p esp_aead -m transport -s 100:500:1000:R1000
+dccp6_ipsec09 dccp_ipsec.sh -6 -A rfc4106_128 -p esp_aead -m tunnel -s 100:500:1000:R1000
+dccp6_ipsec10 dccp_ipsec.sh -6 -A rfc4106_192 -p esp_aead -m transport -s 100:500:1000:R1000
+dccp6_ipsec11 dccp_ipsec.sh -6 -A rfc4106_192 -p esp_aead -m tunnel -s 100:500:1000:R1000
+dccp6_ipsec12 dccp_ipsec.sh -6 -A rfc4106_256 -p esp_aead -m transport -s 100:500:1000:R1000
+dccp6_ipsec13 dccp_ipsec.sh -6 -A rfc4106_256 -p esp_aead -m tunnel -s 100:500:1000:R1000
+dccp6_ipsec14 dccp_ipsec.sh -6 -A rfc4309_128 -p esp_aead -m transport -s 100:500:1000:R1000
+dccp6_ipsec15 dccp_ipsec.sh -6 -A rfc4309_128 -p esp_aead -m tunnel -s 100:500:1000:R1000
+dccp6_ipsec16 dccp_ipsec.sh -6 -A rfc4309_192 -p esp_aead -m transport -s 100:500:1000:R1000
+dccp6_ipsec17 dccp_ipsec.sh -6 -A rfc4309_192 -p esp_aead -m tunnel -s 100:500:1000:R1000
+dccp6_ipsec18 dccp_ipsec.sh -6 -A rfc4309_256 -p esp_aead -m transport -s 100:500:1000:R1000
+dccp6_ipsec19 dccp_ipsec.sh -6 -A rfc4309_256 -p esp_aead -m tunnel -s 100:500:1000:R1000
+dccp6_ipsec20 dccp_ipsec.sh -6 -A rfc4543_128 -p esp_aead -m transport -s 100:500:1000:R1000
+dccp6_ipsec21 dccp_ipsec.sh -6 -A rfc4543_128 -p esp_aead -m tunnel -s 100:500:1000:R1000
+dccp6_ipsec22 dccp_ipsec.sh -6 -A rfc4543_192 -p esp_aead -m transport -s 100:500:1000:R1000
+dccp6_ipsec23 dccp_ipsec.sh -6 -A rfc4543_192 -p esp_aead -m tunnel -s 100:500:1000:R1000
+dccp6_ipsec24 dccp_ipsec.sh -6 -A rfc4543_256 -p esp_aead -m transport -s 100:500:1000:R1000
+dccp6_ipsec25 dccp_ipsec.sh -6 -A rfc4543_256 -p esp_aead -m tunnel -s 100:500:1000:R1000
+dccp6_ipsec26 dccp_ipsec.sh -6 -p esp -a sha1 -e cast5 -m transport -s 100:500:1000:R1000
+dccp6_ipsec27 dccp_ipsec.sh -6 -p esp -a sha1 -e cast5 -m tunnel -s 100:500:1000:R1000
+dccp6_ipsec28 dccp_ipsec.sh -6 -p esp -a sha256 -e blowfish -m transport -s 100:500:1000:R1000
+dccp6_ipsec29 dccp_ipsec.sh -6 -p esp -a sha256 -e blowfish -m tunnel -s 100:500:1000:R1000
+dccp6_ipsec30 dccp_ipsec.sh -6 -p esp -a sha384 -e twofish -m transport -s 100:500:1000:R1000
+dccp6_ipsec31 dccp_ipsec.sh -6 -p esp -a sha384 -e twofish -m tunnel -s 100:500:1000:R1000
+dccp6_ipsec32 dccp_ipsec.sh -6 -p esp -a sha512 -e camellia -m transport -s 100:500:1000:R1000
+dccp6_ipsec33 dccp_ipsec.sh -6 -p esp -a sha512 -e camellia -m tunnel -s 100:500:1000:R1000
+dccp6_ipsec34 dccp_ipsec.sh -6 -p esp -a rmd160 -e serpent -m transport -s 100:500:1000:R1000
+dccp6_ipsec35 dccp_ipsec.sh -6 -p esp -a rmd160 -e serpent -m tunnel -s 100:500:1000:R1000
+dccp6_ipsec36 dccp_ipsec.sh -6 -p esp -m beet -s 100:500:1000:R1000
 
-dccp4_ipsec_vti01 dccp_ipsec_vti.sh -p ah -m tunnel -s 100:500:1000
-dccp4_ipsec_vti02 dccp_ipsec_vti.sh -p esp -m tunnel -s 100:500:1000
+dccp4_ipsec_vti01 dccp_ipsec_vti.sh -p ah -m tunnel -s 100:500:1000:R1000
+dccp4_ipsec_vti02 dccp_ipsec_vti.sh -p esp -m tunnel -s 100:500:1000:R1000
 # dccp4_ipsec_vti03 dccp_ipsec_vti.sh -p comp -m tunnel -s 100:500:1000
-dccp4_ipsec_vti04 dccp_ipsec_vti.sh -A rfc4106_128 -p esp_aead -m tunnel -s 100:500:1000
-dccp4_ipsec_vti05 dccp_ipsec_vti.sh -A rfc4106_192 -p esp_aead -m tunnel -s 100:500:1000
-dccp4_ipsec_vti06 dccp_ipsec_vti.sh -A rfc4106_256 -p esp_aead -m tunnel -s 100:500:1000
-dccp4_ipsec_vti07 dccp_ipsec_vti.sh -A rfc4309_128 -p esp_aead -m tunnel -s 100:500:1000
-dccp4_ipsec_vti08 dccp_ipsec_vti.sh -A rfc4309_192 -p esp_aead -m tunnel -s 100:500:1000
-dccp4_ipsec_vti09 dccp_ipsec_vti.sh -A rfc4309_256 -p esp_aead -m tunnel -s 100:500:1000
-dccp4_ipsec_vti10 dccp_ipsec_vti.sh -A rfc4543_128 -p esp_aead -m tunnel -s 100:500:1000
-dccp4_ipsec_vti11 dccp_ipsec_vti.sh -A rfc4543_192 -p esp_aead -m tunnel -s 100:500:1000
-dccp4_ipsec_vti12 dccp_ipsec_vti.sh -A rfc4543_256 -p esp_aead -m tunnel -s 100:500:1000
-dccp4_ipsec_vti13 dccp_ipsec_vti.sh -p esp -a sha1 -e cast5 -m tunnel -s 100:500:1000
-dccp4_ipsec_vti14 dccp_ipsec_vti.sh -p esp -a sha256 -e blowfish -m tunnel -s 100:500:1000
-dccp4_ipsec_vti15 dccp_ipsec_vti.sh -p esp -a sha384 -e twofish -m tunnel -s 100:500:1000
-dccp4_ipsec_vti16 dccp_ipsec_vti.sh -p esp -a sha512 -e camellia -m tunnel -s 100:500:1000
-dccp4_ipsec_vti17 dccp_ipsec_vti.sh -p esp -a rmd160 -e serpent -m tunnel -s 100:500:1000
+dccp4_ipsec_vti04 dccp_ipsec_vti.sh -A rfc4106_128 -p esp_aead -m tunnel -s 100:500:1000:R1000
+dccp4_ipsec_vti05 dccp_ipsec_vti.sh -A rfc4106_192 -p esp_aead -m tunnel -s 100:500:1000:R1000
+dccp4_ipsec_vti06 dccp_ipsec_vti.sh -A rfc4106_256 -p esp_aead -m tunnel -s 100:500:1000:R1000
+dccp4_ipsec_vti07 dccp_ipsec_vti.sh -A rfc4309_128 -p esp_aead -m tunnel -s 100:500:1000:R1000
+dccp4_ipsec_vti08 dccp_ipsec_vti.sh -A rfc4309_192 -p esp_aead -m tunnel -s 100:500:1000:R1000
+dccp4_ipsec_vti09 dccp_ipsec_vti.sh -A rfc4309_256 -p esp_aead -m tunnel -s 100:500:1000:R1000
+dccp4_ipsec_vti10 dccp_ipsec_vti.sh -A rfc4543_128 -p esp_aead -m tunnel -s 100:500:1000:R1000
+dccp4_ipsec_vti11 dccp_ipsec_vti.sh -A rfc4543_192 -p esp_aead -m tunnel -s 100:500:1000:R1000
+dccp4_ipsec_vti12 dccp_ipsec_vti.sh -A rfc4543_256 -p esp_aead -m tunnel -s 100:500:1000:R1000
+dccp4_ipsec_vti13 dccp_ipsec_vti.sh -p esp -a sha1 -e cast5 -m tunnel -s 100:500:1000:R1000
+dccp4_ipsec_vti14 dccp_ipsec_vti.sh -p esp -a sha256 -e blowfish -m tunnel -s 100:500:1000:R1000
+dccp4_ipsec_vti15 dccp_ipsec_vti.sh -p esp -a sha384 -e twofish -m tunnel -s 100:500:1000:R1000
+dccp4_ipsec_vti16 dccp_ipsec_vti.sh -p esp -a sha512 -e camellia -m tunnel -s 100:500:1000:R1000
+dccp4_ipsec_vti17 dccp_ipsec_vti.sh -p esp -a rmd160 -e serpent -m tunnel -s 100:500:1000:R1000
 
-dccp6_ipsec_vti01 dccp_ipsec_vti.sh -6 -p ah -m tunnel -s 100:500:1000
-dccp6_ipsec_vti02 dccp_ipsec_vti.sh -6 -p esp -m tunnel -s 100:500:1000
+dccp6_ipsec_vti01 dccp_ipsec_vti.sh -6 -p ah -m tunnel -s 100:500:1000:R1000
+dccp6_ipsec_vti02 dccp_ipsec_vti.sh -6 -p esp -m tunnel -s 100:500:1000:R1000
 # dccp6_ipsec_vti03 dccp_ipsec_vti.sh -6 -p comp -m tunnel -s 100:500:1000
-dccp6_ipsec_vti04 dccp_ipsec_vti.sh -6 -A rfc4106_128 -p esp_aead -m tunnel -s 100:500:1000
-dccp6_ipsec_vti05 dccp_ipsec_vti.sh -6 -A rfc4106_192 -p esp_aead -m tunnel -s 100:500:1000
-dccp6_ipsec_vti06 dccp_ipsec_vti.sh -6 -A rfc4106_256 -p esp_aead -m tunnel -s 100:500:1000
-dccp6_ipsec_vti07 dccp_ipsec_vti.sh -6 -A rfc4309_128 -p esp_aead -m tunnel -s 100:500:1000
-dccp6_ipsec_vti08 dccp_ipsec_vti.sh -6 -A rfc4309_192 -p esp_aead -m tunnel -s 100:500:1000
-dccp6_ipsec_vti09 dccp_ipsec_vti.sh -6 -A rfc4309_256 -p esp_aead -m tunnel -s 100:500:1000
-dccp6_ipsec_vti10 dccp_ipsec_vti.sh -6 -A rfc4543_128 -p esp_aead -m tunnel -s 100:500:1000
-dccp6_ipsec_vti11 dccp_ipsec_vti.sh -6 -A rfc4543_192 -p esp_aead -m tunnel -s 100:500:1000
-dccp6_ipsec_vti12 dccp_ipsec_vti.sh -6 -A rfc4543_256 -p esp_aead -m tunnel -s 100:500:1000
-dccp6_ipsec_vti13 dccp_ipsec_vti.sh -6 -p esp -a sha1 -e cast5 -m tunnel -s 100:500:1000
-dccp6_ipsec_vti14 dccp_ipsec_vti.sh -6 -p esp -a sha256 -e blowfish -m tunnel -s 100:500:1000
-dccp6_ipsec_vti15 dccp_ipsec_vti.sh -6 -p esp -a sha384 -e twofish -m tunnel -s 100:500:1000
-dccp6_ipsec_vti16 dccp_ipsec_vti.sh -6 -p esp -a sha512 -e camellia -m tunnel -s 100:500:1000
-dccp6_ipsec_vti17 dccp_ipsec_vti.sh -6 -p esp -a rmd160 -e serpent -m tunnel -s 100:500:1000
+dccp6_ipsec_vti04 dccp_ipsec_vti.sh -6 -A rfc4106_128 -p esp_aead -m tunnel -s 100:500:1000:R1000
+dccp6_ipsec_vti05 dccp_ipsec_vti.sh -6 -A rfc4106_192 -p esp_aead -m tunnel -s 100:500:1000:R1000
+dccp6_ipsec_vti06 dccp_ipsec_vti.sh -6 -A rfc4106_256 -p esp_aead -m tunnel -s 100:500:1000:R1000
+dccp6_ipsec_vti07 dccp_ipsec_vti.sh -6 -A rfc4309_128 -p esp_aead -m tunnel -s 100:500:1000:R1000
+dccp6_ipsec_vti08 dccp_ipsec_vti.sh -6 -A rfc4309_192 -p esp_aead -m tunnel -s 100:500:1000:R1000
+dccp6_ipsec_vti09 dccp_ipsec_vti.sh -6 -A rfc4309_256 -p esp_aead -m tunnel -s 100:500:1000:R1000
+dccp6_ipsec_vti10 dccp_ipsec_vti.sh -6 -A rfc4543_128 -p esp_aead -m tunnel -s 100:500:1000:R1000
+dccp6_ipsec_vti11 dccp_ipsec_vti.sh -6 -A rfc4543_192 -p esp_aead -m tunnel -s 100:500:1000:R1000
+dccp6_ipsec_vti12 dccp_ipsec_vti.sh -6 -A rfc4543_256 -p esp_aead -m tunnel -s 100:500:1000:R1000
+dccp6_ipsec_vti13 dccp_ipsec_vti.sh -6 -p esp -a sha1 -e cast5 -m tunnel -s 100:500:1000:R1000
+dccp6_ipsec_vti14 dccp_ipsec_vti.sh -6 -p esp -a sha256 -e blowfish -m tunnel -s 100:500:1000:R1000
+dccp6_ipsec_vti15 dccp_ipsec_vti.sh -6 -p esp -a sha384 -e twofish -m tunnel -s 100:500:1000:R1000
+dccp6_ipsec_vti16 dccp_ipsec_vti.sh -6 -p esp -a sha512 -e camellia -m tunnel -s 100:500:1000:R1000
+dccp6_ipsec_vti17 dccp_ipsec_vti.sh -6 -p esp -a rmd160 -e serpent -m tunnel -s 100:500:1000:R1000
diff --git a/runtest/net_stress.ipsec_sctp b/runtest/net_stress.ipsec_sctp
index a2453fe..b86de0c 100644
--- a/runtest/net_stress.ipsec_sctp
+++ b/runtest/net_stress.ipsec_sctp
@@ -1,109 +1,109 @@
-sctp4_ipsec01 sctp_ipsec.sh -s 100:1000:65535
-sctp4_ipsec02 sctp_ipsec.sh -p ah -m transport -s 100:1000:65535
-sctp4_ipsec03 sctp_ipsec.sh -p ah -m tunnel -s 100:1000:65535
-sctp4_ipsec04 sctp_ipsec.sh -p esp -m transport -s 100:1000:65535
-sctp4_ipsec05 sctp_ipsec.sh -p esp -m tunnel -s 100:1000:65535
-sctp4_ipsec06 sctp_ipsec.sh -p comp -m transport -s 100:1000:65535
-sctp4_ipsec07 sctp_ipsec.sh -p comp -m tunnel -s 100:1000:65535
-sctp4_ipsec08 sctp_ipsec.sh -A rfc4106_128 -p esp_aead -m transport -s 100:1000:65535
-sctp4_ipsec09 sctp_ipsec.sh -A rfc4106_128 -p esp_aead -m tunnel -s 100:1000:65535
-sctp4_ipsec10 sctp_ipsec.sh -A rfc4106_192 -p esp_aead -m transport -s 100:1000:65535
-sctp4_ipsec11 sctp_ipsec.sh -A rfc4106_192 -p esp_aead -m tunnel -s 100:1000:65535
-sctp4_ipsec12 sctp_ipsec.sh -A rfc4106_256 -p esp_aead -m transport -s 100:1000:65535
-sctp4_ipsec13 sctp_ipsec.sh -A rfc4106_256 -p esp_aead -m tunnel -s 100:1000:65535
-sctp4_ipsec14 sctp_ipsec.sh -A rfc4309_128 -p esp_aead -m transport -s 100:1000:65535
-sctp4_ipsec15 sctp_ipsec.sh -A rfc4309_128 -p esp_aead -m tunnel -s 100:1000:65535
-sctp4_ipsec16 sctp_ipsec.sh -A rfc4309_192 -p esp_aead -m transport -s 100:1000:65535
-sctp4_ipsec17 sctp_ipsec.sh -A rfc4309_192 -p esp_aead -m tunnel -s 100:1000:65535
-sctp4_ipsec18 sctp_ipsec.sh -A rfc4309_256 -p esp_aead -m transport -s 100:1000:65535
-sctp4_ipsec19 sctp_ipsec.sh -A rfc4309_256 -p esp_aead -m tunnel -s 100:1000:65535
-sctp4_ipsec20 sctp_ipsec.sh -A rfc4543_128 -p esp_aead -m transport -s 100:1000:65535
-sctp4_ipsec21 sctp_ipsec.sh -A rfc4543_128 -p esp_aead -m tunnel -s 100:1000:65535
-sctp4_ipsec22 sctp_ipsec.sh -A rfc4543_192 -p esp_aead -m transport -s 100:1000:65535
-sctp4_ipsec23 sctp_ipsec.sh -A rfc4543_192 -p esp_aead -m tunnel -s 100:1000:65535
-sctp4_ipsec24 sctp_ipsec.sh -A rfc4543_256 -p esp_aead -m transport -s 100:1000:65535
-sctp4_ipsec25 sctp_ipsec.sh -A rfc4543_256 -p esp_aead -m tunnel -s 100:1000:65535
-sctp4_ipsec26 sctp_ipsec.sh -p esp -a sha1 -e cast5 -m transport -s 100:1000:65535
-sctp4_ipsec27 sctp_ipsec.sh -p esp -a sha1 -e cast5 -m tunnel -s 100:1000:65535
-sctp4_ipsec28 sctp_ipsec.sh -p esp -a sha256 -e blowfish -m transport -s 100:1000:65535
-sctp4_ipsec29 sctp_ipsec.sh -p esp -a sha256 -e blowfish -m tunnel -s 100:1000:65535
-sctp4_ipsec30 sctp_ipsec.sh -p esp -a sha384 -e twofish -m transport -s 100:1000:65535
-sctp4_ipsec31 sctp_ipsec.sh -p esp -a sha384 -e twofish -m tunnel -s 100:1000:65535
-sctp4_ipsec32 sctp_ipsec.sh -p esp -a sha512 -e camellia -m transport -s 100:1000:65535
-sctp4_ipsec33 sctp_ipsec.sh -p esp -a sha512 -e camellia -m tunnel -s 100:1000:65535
-sctp4_ipsec34 sctp_ipsec.sh -p esp -a rmd160 -e serpent -m transport -s 100:1000:65535
-sctp4_ipsec35 sctp_ipsec.sh -p esp -a rmd160 -e serpent -m tunnel -s 100:1000:65535
-sctp4_ipsec36 sctp_ipsec.sh -p esp -m beet -s 100:1000:65535
+sctp4_ipsec01 sctp_ipsec.sh -s 100:1000:65535:R65535
+sctp4_ipsec02 sctp_ipsec.sh -p ah -m transport -s 100:1000:65535:R65535
+sctp4_ipsec03 sctp_ipsec.sh -p ah -m tunnel -s 100:1000:65535:R65535
+sctp4_ipsec04 sctp_ipsec.sh -p esp -m transport -s 100:1000:65535:R65535
+sctp4_ipsec05 sctp_ipsec.sh -p esp -m tunnel -s 100:1000:65535:R65535
+sctp4_ipsec06 sctp_ipsec.sh -p comp -m transport -s 100:1000:65535:R65535
+sctp4_ipsec07 sctp_ipsec.sh -p comp -m tunnel -s 100:1000:65535:R65535
+sctp4_ipsec08 sctp_ipsec.sh -A rfc4106_128 -p esp_aead -m transport -s 100:1000:65535:R65535
+sctp4_ipsec09 sctp_ipsec.sh -A rfc4106_128 -p esp_aead -m tunnel -s 100:1000:65535:R65535
+sctp4_ipsec10 sctp_ipsec.sh -A rfc4106_192 -p esp_aead -m transport -s 100:1000:65535:R65535
+sctp4_ipsec11 sctp_ipsec.sh -A rfc4106_192 -p esp_aead -m tunnel -s 100:1000:65535:R65535
+sctp4_ipsec12 sctp_ipsec.sh -A rfc4106_256 -p esp_aead -m transport -s 100:1000:65535:R65535
+sctp4_ipsec13 sctp_ipsec.sh -A rfc4106_256 -p esp_aead -m tunnel -s 100:1000:65535:R65535
+sctp4_ipsec14 sctp_ipsec.sh -A rfc4309_128 -p esp_aead -m transport -s 100:1000:65535:R65535
+sctp4_ipsec15 sctp_ipsec.sh -A rfc4309_128 -p esp_aead -m tunnel -s 100:1000:65535:R65535
+sctp4_ipsec16 sctp_ipsec.sh -A rfc4309_192 -p esp_aead -m transport -s 100:1000:65535:R65535
+sctp4_ipsec17 sctp_ipsec.sh -A rfc4309_192 -p esp_aead -m tunnel -s 100:1000:65535:R65535
+sctp4_ipsec18 sctp_ipsec.sh -A rfc4309_256 -p esp_aead -m transport -s 100:1000:65535:R65535
+sctp4_ipsec19 sctp_ipsec.sh -A rfc4309_256 -p esp_aead -m tunnel -s 100:1000:65535:R65535
+sctp4_ipsec20 sctp_ipsec.sh -A rfc4543_128 -p esp_aead -m transport -s 100:1000:65535:R65535
+sctp4_ipsec21 sctp_ipsec.sh -A rfc4543_128 -p esp_aead -m tunnel -s 100:1000:65535:R65535
+sctp4_ipsec22 sctp_ipsec.sh -A rfc4543_192 -p esp_aead -m transport -s 100:1000:65535:R65535
+sctp4_ipsec23 sctp_ipsec.sh -A rfc4543_192 -p esp_aead -m tunnel -s 100:1000:65535:R65535
+sctp4_ipsec24 sctp_ipsec.sh -A rfc4543_256 -p esp_aead -m transport -s 100:1000:65535:R65535
+sctp4_ipsec25 sctp_ipsec.sh -A rfc4543_256 -p esp_aead -m tunnel -s 100:1000:65535:R65535
+sctp4_ipsec26 sctp_ipsec.sh -p esp -a sha1 -e cast5 -m transport -s 100:1000:65535:R65535
+sctp4_ipsec27 sctp_ipsec.sh -p esp -a sha1 -e cast5 -m tunnel -s 100:1000:65535:R65535
+sctp4_ipsec28 sctp_ipsec.sh -p esp -a sha256 -e blowfish -m transport -s 100:1000:65535:R65535
+sctp4_ipsec29 sctp_ipsec.sh -p esp -a sha256 -e blowfish -m tunnel -s 100:1000:65535:R65535
+sctp4_ipsec30 sctp_ipsec.sh -p esp -a sha384 -e twofish -m transport -s 100:1000:65535:R65535
+sctp4_ipsec31 sctp_ipsec.sh -p esp -a sha384 -e twofish -m tunnel -s 100:1000:65535:R65535
+sctp4_ipsec32 sctp_ipsec.sh -p esp -a sha512 -e camellia -m transport -s 100:1000:65535:R65535
+sctp4_ipsec33 sctp_ipsec.sh -p esp -a sha512 -e camellia -m tunnel -s 100:1000:65535:R65535
+sctp4_ipsec34 sctp_ipsec.sh -p esp -a rmd160 -e serpent -m transport -s 100:1000:65535:R65535
+sctp4_ipsec35 sctp_ipsec.sh -p esp -a rmd160 -e serpent -m tunnel -s 100:1000:65535:R65535
+sctp4_ipsec36 sctp_ipsec.sh -p esp -m beet -s 100:1000:65535:R65535
 
-sctp6_ipsec01 sctp_ipsec.sh -6 -s 100:1000:65535
-sctp6_ipsec02 sctp_ipsec.sh -6 -p ah -m transport -s 100:1000:65535
-sctp6_ipsec03 sctp_ipsec.sh -6 -p ah -m tunnel -s 100:1000:65535
-sctp6_ipsec04 sctp_ipsec.sh -6 -p esp -m transport -s 100:1000:65535
-sctp6_ipsec05 sctp_ipsec.sh -6 -p esp -m tunnel -s 100:1000:65535
-sctp6_ipsec06 sctp_ipsec.sh -6 -p comp -m transport -s 100:1000:65535
-sctp6_ipsec07 sctp_ipsec.sh -6 -p comp -m tunnel -s 100:1000:65535
-sctp6_ipsec08 sctp_ipsec.sh -6 -A rfc4106_128 -p esp_aead -m transport -s 100:1000:65535
-sctp6_ipsec09 sctp_ipsec.sh -6 -A rfc4106_128 -p esp_aead -m tunnel -s 100:1000:65535
-sctp6_ipsec10 sctp_ipsec.sh -6 -A rfc4106_192 -p esp_aead -m transport -s 100:1000:65535
-sctp6_ipsec11 sctp_ipsec.sh -6 -A rfc4106_192 -p esp_aead -m tunnel -s 100:1000:65535
-sctp6_ipsec12 sctp_ipsec.sh -6 -A rfc4106_256 -p esp_aead -m transport -s 100:1000:65535
-sctp6_ipsec13 sctp_ipsec.sh -6 -A rfc4106_256 -p esp_aead -m tunnel -s 100:1000:65535
-sctp6_ipsec14 sctp_ipsec.sh -6 -A rfc4309_128 -p esp_aead -m transport -s 100:1000:65535
-sctp6_ipsec15 sctp_ipsec.sh -6 -A rfc4309_128 -p esp_aead -m tunnel -s 100:1000:65535
-sctp6_ipsec16 sctp_ipsec.sh -6 -A rfc4309_192 -p esp_aead -m transport -s 100:1000:65535
-sctp6_ipsec17 sctp_ipsec.sh -6 -A rfc4309_192 -p esp_aead -m tunnel -s 100:1000:65535
-sctp6_ipsec18 sctp_ipsec.sh -6 -A rfc4309_256 -p esp_aead -m transport -s 100:1000:65535
-sctp6_ipsec19 sctp_ipsec.sh -6 -A rfc4309_256 -p esp_aead -m tunnel -s 100:1000:65535
-sctp6_ipsec20 sctp_ipsec.sh -6 -A rfc4543_128 -p esp_aead -m transport -s 100:1000:65535
-sctp6_ipsec21 sctp_ipsec.sh -6 -A rfc4543_128 -p esp_aead -m tunnel -s 100:1000:65535
-sctp6_ipsec22 sctp_ipsec.sh -6 -A rfc4543_192 -p esp_aead -m transport -s 100:1000:65535
-sctp6_ipsec23 sctp_ipsec.sh -6 -A rfc4543_192 -p esp_aead -m tunnel -s 100:1000:65535
-sctp6_ipsec24 sctp_ipsec.sh -6 -A rfc4543_256 -p esp_aead -m transport -s 100:1000:65535
-sctp6_ipsec25 sctp_ipsec.sh -6 -A rfc4543_256 -p esp_aead -m tunnel -s 100:1000:65535
-sctp6_ipsec26 sctp_ipsec.sh -6 -p esp -a sha1 -e cast5 -m transport -s 100:1000:65535
-sctp6_ipsec27 sctp_ipsec.sh -6 -p esp -a sha1 -e cast5 -m tunnel -s 100:1000:65535
-sctp6_ipsec28 sctp_ipsec.sh -6 -p esp -a sha256 -e blowfish -m transport -s 100:1000:65535
-sctp6_ipsec29 sctp_ipsec.sh -6 -p esp -a sha256 -e blowfish -m tunnel -s 100:1000:65535
-sctp6_ipsec30 sctp_ipsec.sh -6 -p esp -a sha384 -e twofish -m transport -s 100:1000:65535
-sctp6_ipsec31 sctp_ipsec.sh -6 -p esp -a sha384 -e twofish -m tunnel -s 100:1000:65535
-sctp6_ipsec32 sctp_ipsec.sh -6 -p esp -a sha512 -e camellia -m transport -s 100:1000:65535
-sctp6_ipsec33 sctp_ipsec.sh -6 -p esp -a sha512 -e camellia -m tunnel -s 100:1000:65535
-sctp6_ipsec34 sctp_ipsec.sh -6 -p esp -a rmd160 -e serpent -m transport -s 100:1000:65535
-sctp6_ipsec35 sctp_ipsec.sh -6 -p esp -a rmd160 -e serpent -m tunnel -s 100:1000:65535
-sctp6_ipsec36 sctp_ipsec.sh -6 -p esp -m beet -s 100:1000:65535
+sctp6_ipsec01 sctp_ipsec.sh -6 -s 100:1000:65535:R65535
+sctp6_ipsec02 sctp_ipsec.sh -6 -p ah -m transport -s 100:1000:65535:R65535
+sctp6_ipsec03 sctp_ipsec.sh -6 -p ah -m tunnel -s 100:1000:65535:R65535
+sctp6_ipsec04 sctp_ipsec.sh -6 -p esp -m transport -s 100:1000:65535:R65535
+sctp6_ipsec05 sctp_ipsec.sh -6 -p esp -m tunnel -s 100:1000:65535:R65535
+sctp6_ipsec06 sctp_ipsec.sh -6 -p comp -m transport -s 100:1000:65535:R65535
+sctp6_ipsec07 sctp_ipsec.sh -6 -p comp -m tunnel -s 100:1000:65535:R65535
+sctp6_ipsec08 sctp_ipsec.sh -6 -A rfc4106_128 -p esp_aead -m transport -s 100:1000:65535:R65535
+sctp6_ipsec09 sctp_ipsec.sh -6 -A rfc4106_128 -p esp_aead -m tunnel -s 100:1000:65535:R65535
+sctp6_ipsec10 sctp_ipsec.sh -6 -A rfc4106_192 -p esp_aead -m transport -s 100:1000:65535:R65535
+sctp6_ipsec11 sctp_ipsec.sh -6 -A rfc4106_192 -p esp_aead -m tunnel -s 100:1000:65535:R65535
+sctp6_ipsec12 sctp_ipsec.sh -6 -A rfc4106_256 -p esp_aead -m transport -s 100:1000:65535:R65535
+sctp6_ipsec13 sctp_ipsec.sh -6 -A rfc4106_256 -p esp_aead -m tunnel -s 100:1000:65535:R65535
+sctp6_ipsec14 sctp_ipsec.sh -6 -A rfc4309_128 -p esp_aead -m transport -s 100:1000:65535:R65535
+sctp6_ipsec15 sctp_ipsec.sh -6 -A rfc4309_128 -p esp_aead -m tunnel -s 100:1000:65535:R65535
+sctp6_ipsec16 sctp_ipsec.sh -6 -A rfc4309_192 -p esp_aead -m transport -s 100:1000:65535:R65535
+sctp6_ipsec17 sctp_ipsec.sh -6 -A rfc4309_192 -p esp_aead -m tunnel -s 100:1000:65535:R65535
+sctp6_ipsec18 sctp_ipsec.sh -6 -A rfc4309_256 -p esp_aead -m transport -s 100:1000:65535:R65535
+sctp6_ipsec19 sctp_ipsec.sh -6 -A rfc4309_256 -p esp_aead -m tunnel -s 100:1000:65535:R65535
+sctp6_ipsec20 sctp_ipsec.sh -6 -A rfc4543_128 -p esp_aead -m transport -s 100:1000:65535:R65535
+sctp6_ipsec21 sctp_ipsec.sh -6 -A rfc4543_128 -p esp_aead -m tunnel -s 100:1000:65535:R65535
+sctp6_ipsec22 sctp_ipsec.sh -6 -A rfc4543_192 -p esp_aead -m transport -s 100:1000:65535:R65535
+sctp6_ipsec23 sctp_ipsec.sh -6 -A rfc4543_192 -p esp_aead -m tunnel -s 100:1000:65535:R65535
+sctp6_ipsec24 sctp_ipsec.sh -6 -A rfc4543_256 -p esp_aead -m transport -s 100:1000:65535:R65535
+sctp6_ipsec25 sctp_ipsec.sh -6 -A rfc4543_256 -p esp_aead -m tunnel -s 100:1000:65535:R65535
+sctp6_ipsec26 sctp_ipsec.sh -6 -p esp -a sha1 -e cast5 -m transport -s 100:1000:65535:R65535
+sctp6_ipsec27 sctp_ipsec.sh -6 -p esp -a sha1 -e cast5 -m tunnel -s 100:1000:65535:R65535
+sctp6_ipsec28 sctp_ipsec.sh -6 -p esp -a sha256 -e blowfish -m transport -s 100:1000:65535:R65535
+sctp6_ipsec29 sctp_ipsec.sh -6 -p esp -a sha256 -e blowfish -m tunnel -s 100:1000:65535:R65535
+sctp6_ipsec30 sctp_ipsec.sh -6 -p esp -a sha384 -e twofish -m transport -s 100:1000:65535:R65535
+sctp6_ipsec31 sctp_ipsec.sh -6 -p esp -a sha384 -e twofish -m tunnel -s 100:1000:65535:R65535
+sctp6_ipsec32 sctp_ipsec.sh -6 -p esp -a sha512 -e camellia -m transport -s 100:1000:65535:R65535
+sctp6_ipsec33 sctp_ipsec.sh -6 -p esp -a sha512 -e camellia -m tunnel -s 100:1000:65535:R65535
+sctp6_ipsec34 sctp_ipsec.sh -6 -p esp -a rmd160 -e serpent -m transport -s 100:1000:65535:R65535
+sctp6_ipsec35 sctp_ipsec.sh -6 -p esp -a rmd160 -e serpent -m tunnel -s 100:1000:65535:R65535
+sctp6_ipsec36 sctp_ipsec.sh -6 -p esp -m beet -s 100:1000:65535:R65535
 
-sctp4_ipsec_vti01 sctp_ipsec_vti.sh -p ah -m tunnel -s 100:1000:65535
-sctp4_ipsec_vti02 sctp_ipsec_vti.sh -p esp -m tunnel -s 100:1000:65535
+sctp4_ipsec_vti01 sctp_ipsec_vti.sh -p ah -m tunnel -s 100:1000:65535:R65535
+sctp4_ipsec_vti02 sctp_ipsec_vti.sh -p esp -m tunnel -s 100:1000:65535:R65535
 # sctp4_ipsec_vti03 sctp_ipsec_vti.sh -p comp -m tunnel -s 100:1000:65535
-sctp4_ipsec_vti04 sctp_ipsec_vti.sh -A rfc4106_128 -p esp_aead -m tunnel -s 100:1000:65535
-sctp4_ipsec_vti05 sctp_ipsec_vti.sh -A rfc4106_192 -p esp_aead -m tunnel -s 100:1000:65535
-sctp4_ipsec_vti06 sctp_ipsec_vti.sh -A rfc4106_256 -p esp_aead -m tunnel -s 100:1000:65535
-sctp4_ipsec_vti07 sctp_ipsec_vti.sh -A rfc4309_128 -p esp_aead -m tunnel -s 100:1000:65535
-sctp4_ipsec_vti08 sctp_ipsec_vti.sh -A rfc4309_192 -p esp_aead -m tunnel -s 100:1000:65535
-sctp4_ipsec_vti09 sctp_ipsec_vti.sh -A rfc4309_256 -p esp_aead -m tunnel -s 100:1000:65535
-sctp4_ipsec_vti10 sctp_ipsec_vti.sh -A rfc4543_128 -p esp_aead -m tunnel -s 100:1000:65535
-sctp4_ipsec_vti11 sctp_ipsec_vti.sh -A rfc4543_192 -p esp_aead -m tunnel -s 100:1000:65535
-sctp4_ipsec_vti12 sctp_ipsec_vti.sh -A rfc4543_256 -p esp_aead -m tunnel -s 100:1000:65535
-sctp4_ipsec_vti13 sctp_ipsec_vti.sh -p esp -a sha1 -e cast5 -m tunnel -s 100:1000:65535
-sctp4_ipsec_vti14 sctp_ipsec_vti.sh -p esp -a sha256 -e blowfish -m tunnel -s 100:1000:65535
-sctp4_ipsec_vti15 sctp_ipsec_vti.sh -p esp -a sha384 -e twofish -m tunnel -s 100:1000:65535
-sctp4_ipsec_vti16 sctp_ipsec_vti.sh -p esp -a sha512 -e camellia -m tunnel -s 100:1000:65535
-sctp4_ipsec_vti17 sctp_ipsec_vti.sh -p esp -a rmd160 -e serpent -m tunnel -s 100:1000:65535
+sctp4_ipsec_vti04 sctp_ipsec_vti.sh -A rfc4106_128 -p esp_aead -m tunnel -s 100:1000:65535:R65535
+sctp4_ipsec_vti05 sctp_ipsec_vti.sh -A rfc4106_192 -p esp_aead -m tunnel -s 100:1000:65535:R65535
+sctp4_ipsec_vti06 sctp_ipsec_vti.sh -A rfc4106_256 -p esp_aead -m tunnel -s 100:1000:65535:R65535
+sctp4_ipsec_vti07 sctp_ipsec_vti.sh -A rfc4309_128 -p esp_aead -m tunnel -s 100:1000:65535:R65535
+sctp4_ipsec_vti08 sctp_ipsec_vti.sh -A rfc4309_192 -p esp_aead -m tunnel -s 100:1000:65535:R65535
+sctp4_ipsec_vti09 sctp_ipsec_vti.sh -A rfc4309_256 -p esp_aead -m tunnel -s 100:1000:65535:R65535
+sctp4_ipsec_vti10 sctp_ipsec_vti.sh -A rfc4543_128 -p esp_aead -m tunnel -s 100:1000:65535:R65535
+sctp4_ipsec_vti11 sctp_ipsec_vti.sh -A rfc4543_192 -p esp_aead -m tunnel -s 100:1000:65535:R65535
+sctp4_ipsec_vti12 sctp_ipsec_vti.sh -A rfc4543_256 -p esp_aead -m tunnel -s 100:1000:65535:R65535
+sctp4_ipsec_vti13 sctp_ipsec_vti.sh -p esp -a sha1 -e cast5 -m tunnel -s 100:1000:65535:R65535
+sctp4_ipsec_vti14 sctp_ipsec_vti.sh -p esp -a sha256 -e blowfish -m tunnel -s 100:1000:65535:R65535
+sctp4_ipsec_vti15 sctp_ipsec_vti.sh -p esp -a sha384 -e twofish -m tunnel -s 100:1000:65535:R65535
+sctp4_ipsec_vti16 sctp_ipsec_vti.sh -p esp -a sha512 -e camellia -m tunnel -s 100:1000:65535:R65535
+sctp4_ipsec_vti17 sctp_ipsec_vti.sh -p esp -a rmd160 -e serpent -m tunnel -s 100:1000:65535:R65535
 
-sctp6_ipsec_vti01 sctp_ipsec_vti.sh -6 -p ah -m tunnel -s 100:1000:65535
-sctp6_ipsec_vti02 sctp_ipsec_vti.sh -6 -p esp -m tunnel -s 100:1000:65535
+sctp6_ipsec_vti01 sctp_ipsec_vti.sh -6 -p ah -m tunnel -s 100:1000:65535:R65535
+sctp6_ipsec_vti02 sctp_ipsec_vti.sh -6 -p esp -m tunnel -s 100:1000:65535:R65535
 # sctp6_ipsec_vti03 sctp_ipsec_vti.sh -6 -p comp -m tunnel -s 100:1000:65535
-sctp6_ipsec_vti04 sctp_ipsec_vti.sh -6 -A rfc4106_128 -p esp_aead -m tunnel -s 100:1000:65535
-sctp6_ipsec_vti05 sctp_ipsec_vti.sh -6 -A rfc4106_192 -p esp_aead -m tunnel -s 100:1000:65535
-sctp6_ipsec_vti06 sctp_ipsec_vti.sh -6 -A rfc4106_256 -p esp_aead -m tunnel -s 100:1000:65535
-sctp6_ipsec_vti07 sctp_ipsec_vti.sh -6 -A rfc4309_128 -p esp_aead -m tunnel -s 100:1000:65535
-sctp6_ipsec_vti08 sctp_ipsec_vti.sh -6 -A rfc4309_192 -p esp_aead -m tunnel -s 100:1000:65535
-sctp6_ipsec_vti09 sctp_ipsec_vti.sh -6 -A rfc4309_256 -p esp_aead -m tunnel -s 100:1000:65535
-sctp6_ipsec_vti10 sctp_ipsec_vti.sh -6 -A rfc4543_128 -p esp_aead -m tunnel -s 100:1000:65535
-sctp6_ipsec_vti11 sctp_ipsec_vti.sh -6 -A rfc4543_192 -p esp_aead -m tunnel -s 100:1000:65535
-sctp6_ipsec_vti12 sctp_ipsec_vti.sh -6 -A rfc4543_256 -p esp_aead -m tunnel -s 100:1000:65535
-sctp6_ipsec_vti13 sctp_ipsec_vti.sh -6 -p esp -a sha1 -e cast5 -m tunnel -s 100:1000:65535
-sctp6_ipsec_vti14 sctp_ipsec_vti.sh -6 -p esp -a sha256 -e blowfish -m tunnel -s 100:1000:65535
-sctp6_ipsec_vti15 sctp_ipsec_vti.sh -6 -p esp -a sha384 -e twofish -m tunnel -s 100:1000:65535
-sctp6_ipsec_vti16 sctp_ipsec_vti.sh -6 -p esp -a sha512 -e camellia -m tunnel -s 100:1000:65535
-sctp6_ipsec_vti17 sctp_ipsec_vti.sh -6 -p esp -a rmd160 -e serpent -m tunnel -s 100:1000:65535
+sctp6_ipsec_vti04 sctp_ipsec_vti.sh -6 -A rfc4106_128 -p esp_aead -m tunnel -s 100:1000:65535:R65535
+sctp6_ipsec_vti05 sctp_ipsec_vti.sh -6 -A rfc4106_192 -p esp_aead -m tunnel -s 100:1000:65535:R65535
+sctp6_ipsec_vti06 sctp_ipsec_vti.sh -6 -A rfc4106_256 -p esp_aead -m tunnel -s 100:1000:65535:R65535
+sctp6_ipsec_vti07 sctp_ipsec_vti.sh -6 -A rfc4309_128 -p esp_aead -m tunnel -s 100:1000:65535:R65535
+sctp6_ipsec_vti08 sctp_ipsec_vti.sh -6 -A rfc4309_192 -p esp_aead -m tunnel -s 100:1000:65535:R65535
+sctp6_ipsec_vti09 sctp_ipsec_vti.sh -6 -A rfc4309_256 -p esp_aead -m tunnel -s 100:1000:65535:R65535
+sctp6_ipsec_vti10 sctp_ipsec_vti.sh -6 -A rfc4543_128 -p esp_aead -m tunnel -s 100:1000:65535:R65535
+sctp6_ipsec_vti11 sctp_ipsec_vti.sh -6 -A rfc4543_192 -p esp_aead -m tunnel -s 100:1000:65535:R65535
+sctp6_ipsec_vti12 sctp_ipsec_vti.sh -6 -A rfc4543_256 -p esp_aead -m tunnel -s 100:1000:65535:R65535
+sctp6_ipsec_vti13 sctp_ipsec_vti.sh -6 -p esp -a sha1 -e cast5 -m tunnel -s 100:1000:65535:R65535
+sctp6_ipsec_vti14 sctp_ipsec_vti.sh -6 -p esp -a sha256 -e blowfish -m tunnel -s 100:1000:65535:R65535
+sctp6_ipsec_vti15 sctp_ipsec_vti.sh -6 -p esp -a sha384 -e twofish -m tunnel -s 100:1000:65535:R65535
+sctp6_ipsec_vti16 sctp_ipsec_vti.sh -6 -p esp -a sha512 -e camellia -m tunnel -s 100:1000:65535:R65535
+sctp6_ipsec_vti17 sctp_ipsec_vti.sh -6 -p esp -a rmd160 -e serpent -m tunnel -s 100:1000:65535:R65535
diff --git a/runtest/net_stress.ipsec_tcp b/runtest/net_stress.ipsec_tcp
index ae52de5..09d2384 100644
--- a/runtest/net_stress.ipsec_tcp
+++ b/runtest/net_stress.ipsec_tcp
@@ -1,109 +1,109 @@
-tcp4_ipsec01 tcp_ipsec.sh -s 100:1000:65535
-tcp4_ipsec02 tcp_ipsec.sh -p ah -m transport -s 100:1000:65535
-tcp4_ipsec03 tcp_ipsec.sh -p ah -m tunnel -s 100:1000:65535
-tcp4_ipsec04 tcp_ipsec.sh -p esp -m transport -s 100:1000:65535
-tcp4_ipsec05 tcp_ipsec.sh -p esp -m tunnel -s 100:1000:65535
-tcp4_ipsec06 tcp_ipsec.sh -p comp -m transport -s 100:1000:65535
-tcp4_ipsec07 tcp_ipsec.sh -p comp -m tunnel -s 100:1000:65535
-tcp4_ipsec08 tcp_ipsec.sh -A rfc4106_128 -p esp_aead -m transport -s 100:1000:65535
-tcp4_ipsec09 tcp_ipsec.sh -A rfc4106_128 -p esp_aead -m tunnel -s 100:1000:65535
-tcp4_ipsec10 tcp_ipsec.sh -A rfc4106_192 -p esp_aead -m transport -s 100:1000:65535
-tcp4_ipsec11 tcp_ipsec.sh -A rfc4106_192 -p esp_aead -m tunnel -s 100:1000:65535
-tcp4_ipsec12 tcp_ipsec.sh -A rfc4106_256 -p esp_aead -m transport -s 100:1000:65535
-tcp4_ipsec13 tcp_ipsec.sh -A rfc4106_256 -p esp_aead -m tunnel -s 100:1000:65535
-tcp4_ipsec14 tcp_ipsec.sh -A rfc4309_128 -p esp_aead -m transport -s 100:1000:65535
-tcp4_ipsec15 tcp_ipsec.sh -A rfc4309_128 -p esp_aead -m tunnel -s 100:1000:65535
-tcp4_ipsec16 tcp_ipsec.sh -A rfc4309_192 -p esp_aead -m transport -s 100:1000:65535
-tcp4_ipsec17 tcp_ipsec.sh -A rfc4309_192 -p esp_aead -m tunnel -s 100:1000:65535
-tcp4_ipsec18 tcp_ipsec.sh -A rfc4309_256 -p esp_aead -m transport -s 100:1000:65535
-tcp4_ipsec19 tcp_ipsec.sh -A rfc4309_256 -p esp_aead -m tunnel -s 100:1000:65535
-tcp4_ipsec20 tcp_ipsec.sh -A rfc4543_128 -p esp_aead -m transport -s 100:1000:65535
-tcp4_ipsec21 tcp_ipsec.sh -A rfc4543_128 -p esp_aead -m tunnel -s 100:1000:65535
-tcp4_ipsec22 tcp_ipsec.sh -A rfc4543_192 -p esp_aead -m transport -s 100:1000:65535
-tcp4_ipsec23 tcp_ipsec.sh -A rfc4543_192 -p esp_aead -m tunnel -s 100:1000:65535
-tcp4_ipsec24 tcp_ipsec.sh -A rfc4543_256 -p esp_aead -m transport -s 100:1000:65535
-tcp4_ipsec25 tcp_ipsec.sh -A rfc4543_256 -p esp_aead -m tunnel -s 100:1000:65535
-tcp4_ipsec26 tcp_ipsec.sh -p esp -a sha1 -e cast5 -m transport -s 100:1000:65535
-tcp4_ipsec27 tcp_ipsec.sh -p esp -a sha1 -e cast5 -m tunnel -s 100:1000:65535
-tcp4_ipsec28 tcp_ipsec.sh -p esp -a sha256 -e blowfish -m transport -s 100:1000:65535
-tcp4_ipsec29 tcp_ipsec.sh -p esp -a sha256 -e blowfish -m tunnel -s 100:1000:65535
-tcp4_ipsec30 tcp_ipsec.sh -p esp -a sha384 -e twofish -m transport -s 100:1000:65535
-tcp4_ipsec31 tcp_ipsec.sh -p esp -a sha384 -e twofish -m tunnel -s 100:1000:65535
-tcp4_ipsec32 tcp_ipsec.sh -p esp -a sha512 -e camellia -m transport -s 100:1000:65535
-tcp4_ipsec33 tcp_ipsec.sh -p esp -a sha512 -e camellia -m tunnel -s 100:1000:65535
-tcp4_ipsec34 tcp_ipsec.sh -p esp -a rmd160 -e serpent -m transport -s 100:1000:65535
-tcp4_ipsec35 tcp_ipsec.sh -p esp -a rmd160 -e serpent -m tunnel -s 100:1000:65535
-tcp4_ipsec36 tcp_ipsec.sh -p esp -m beet -s 100:1000:65535
+tcp4_ipsec01 tcp_ipsec.sh -s 100:1000:65535:R65535
+tcp4_ipsec02 tcp_ipsec.sh -p ah -m transport -s 100:1000:65535:R65535
+tcp4_ipsec03 tcp_ipsec.sh -p ah -m tunnel -s 100:1000:65535:R65535
+tcp4_ipsec04 tcp_ipsec.sh -p esp -m transport -s 100:1000:65535:R65535
+tcp4_ipsec05 tcp_ipsec.sh -p esp -m tunnel -s 100:1000:65535:R65535
+tcp4_ipsec06 tcp_ipsec.sh -p comp -m transport -s 100:1000:65535:R65535
+tcp4_ipsec07 tcp_ipsec.sh -p comp -m tunnel -s 100:1000:65535:R65535
+tcp4_ipsec08 tcp_ipsec.sh -A rfc4106_128 -p esp_aead -m transport -s 100:1000:65535:R65535
+tcp4_ipsec09 tcp_ipsec.sh -A rfc4106_128 -p esp_aead -m tunnel -s 100:1000:65535:R65535
+tcp4_ipsec10 tcp_ipsec.sh -A rfc4106_192 -p esp_aead -m transport -s 100:1000:65535:R65535
+tcp4_ipsec11 tcp_ipsec.sh -A rfc4106_192 -p esp_aead -m tunnel -s 100:1000:65535:R65535
+tcp4_ipsec12 tcp_ipsec.sh -A rfc4106_256 -p esp_aead -m transport -s 100:1000:65535:R65535
+tcp4_ipsec13 tcp_ipsec.sh -A rfc4106_256 -p esp_aead -m tunnel -s 100:1000:65535:R65535
+tcp4_ipsec14 tcp_ipsec.sh -A rfc4309_128 -p esp_aead -m transport -s 100:1000:65535:R65535
+tcp4_ipsec15 tcp_ipsec.sh -A rfc4309_128 -p esp_aead -m tunnel -s 100:1000:65535:R65535
+tcp4_ipsec16 tcp_ipsec.sh -A rfc4309_192 -p esp_aead -m transport -s 100:1000:65535:R65535
+tcp4_ipsec17 tcp_ipsec.sh -A rfc4309_192 -p esp_aead -m tunnel -s 100:1000:65535:R65535
+tcp4_ipsec18 tcp_ipsec.sh -A rfc4309_256 -p esp_aead -m transport -s 100:1000:65535:R65535
+tcp4_ipsec19 tcp_ipsec.sh -A rfc4309_256 -p esp_aead -m tunnel -s 100:1000:65535:R65535
+tcp4_ipsec20 tcp_ipsec.sh -A rfc4543_128 -p esp_aead -m transport -s 100:1000:65535:R65535
+tcp4_ipsec21 tcp_ipsec.sh -A rfc4543_128 -p esp_aead -m tunnel -s 100:1000:65535:R65535
+tcp4_ipsec22 tcp_ipsec.sh -A rfc4543_192 -p esp_aead -m transport -s 100:1000:65535:R65535
+tcp4_ipsec23 tcp_ipsec.sh -A rfc4543_192 -p esp_aead -m tunnel -s 100:1000:65535:R65535
+tcp4_ipsec24 tcp_ipsec.sh -A rfc4543_256 -p esp_aead -m transport -s 100:1000:65535:R65535
+tcp4_ipsec25 tcp_ipsec.sh -A rfc4543_256 -p esp_aead -m tunnel -s 100:1000:65535:R65535
+tcp4_ipsec26 tcp_ipsec.sh -p esp -a sha1 -e cast5 -m transport -s 100:1000:65535:R65535
+tcp4_ipsec27 tcp_ipsec.sh -p esp -a sha1 -e cast5 -m tunnel -s 100:1000:65535:R65535
+tcp4_ipsec28 tcp_ipsec.sh -p esp -a sha256 -e blowfish -m transport -s 100:1000:65535:R65535
+tcp4_ipsec29 tcp_ipsec.sh -p esp -a sha256 -e blowfish -m tunnel -s 100:1000:65535:R65535
+tcp4_ipsec30 tcp_ipsec.sh -p esp -a sha384 -e twofish -m transport -s 100:1000:65535:R65535
+tcp4_ipsec31 tcp_ipsec.sh -p esp -a sha384 -e twofish -m tunnel -s 100:1000:65535:R65535
+tcp4_ipsec32 tcp_ipsec.sh -p esp -a sha512 -e camellia -m transport -s 100:1000:65535:R65535
+tcp4_ipsec33 tcp_ipsec.sh -p esp -a sha512 -e camellia -m tunnel -s 100:1000:65535:R65535
+tcp4_ipsec34 tcp_ipsec.sh -p esp -a rmd160 -e serpent -m transport -s 100:1000:65535:R65535
+tcp4_ipsec35 tcp_ipsec.sh -p esp -a rmd160 -e serpent -m tunnel -s 100:1000:65535:R65535
+tcp4_ipsec36 tcp_ipsec.sh -p esp -m beet -s 100:1000:65535:R65535
 
-tcp6_ipsec01 tcp_ipsec.sh -6 -s 100:1000:65535
-tcp6_ipsec02 tcp_ipsec.sh -6 -p ah -m transport -s 100:1000:65535
-tcp6_ipsec03 tcp_ipsec.sh -6 -p ah -m tunnel -s 100:1000:65535
-tcp6_ipsec04 tcp_ipsec.sh -6 -p esp -m transport -s 100:1000:65535
-tcp6_ipsec05 tcp_ipsec.sh -6 -p esp -m tunnel -s 100:1000:65535
-tcp6_ipsec06 tcp_ipsec.sh -6 -p comp -m transport -s 100:1000:65535
-tcp6_ipsec07 tcp_ipsec.sh -6 -p comp -m tunnel -s 100:1000:65535
-tcp6_ipsec08 tcp_ipsec.sh -6 -A rfc4106_128 -p esp_aead -m transport -s 100:1000:65535
-tcp6_ipsec09 tcp_ipsec.sh -6 -A rfc4106_128 -p esp_aead -m tunnel -s 100:1000:65535
-tcp6_ipsec10 tcp_ipsec.sh -6 -A rfc4106_192 -p esp_aead -m transport -s 100:1000:65535
-tcp6_ipsec11 tcp_ipsec.sh -6 -A rfc4106_192 -p esp_aead -m tunnel -s 100:1000:65535
-tcp6_ipsec12 tcp_ipsec.sh -6 -A rfc4106_256 -p esp_aead -m transport -s 100:1000:65535
-tcp6_ipsec13 tcp_ipsec.sh -6 -A rfc4106_256 -p esp_aead -m tunnel -s 100:1000:65535
-tcp6_ipsec14 tcp_ipsec.sh -6 -A rfc4309_128 -p esp_aead -m transport -s 100:1000:65535
-tcp6_ipsec15 tcp_ipsec.sh -6 -A rfc4309_128 -p esp_aead -m tunnel -s 100:1000:65535
-tcp6_ipsec16 tcp_ipsec.sh -6 -A rfc4309_192 -p esp_aead -m transport -s 100:1000:65535
-tcp6_ipsec17 tcp_ipsec.sh -6 -A rfc4309_192 -p esp_aead -m tunnel -s 100:1000:65535
-tcp6_ipsec18 tcp_ipsec.sh -6 -A rfc4309_256 -p esp_aead -m transport -s 100:1000:65535
-tcp6_ipsec19 tcp_ipsec.sh -6 -A rfc4309_256 -p esp_aead -m tunnel -s 100:1000:65535
-tcp6_ipsec20 tcp_ipsec.sh -6 -A rfc4543_128 -p esp_aead -m transport -s 100:1000:65535
-tcp6_ipsec21 tcp_ipsec.sh -6 -A rfc4543_128 -p esp_aead -m tunnel -s 100:1000:65535
-tcp6_ipsec22 tcp_ipsec.sh -6 -A rfc4543_192 -p esp_aead -m transport -s 100:1000:65535
-tcp6_ipsec23 tcp_ipsec.sh -6 -A rfc4543_192 -p esp_aead -m tunnel -s 100:1000:65535
-tcp6_ipsec24 tcp_ipsec.sh -6 -A rfc4543_256 -p esp_aead -m transport -s 100:1000:65535
-tcp6_ipsec25 tcp_ipsec.sh -6 -A rfc4543_256 -p esp_aead -m tunnel -s 100:1000:65535
-tcp6_ipsec26 tcp_ipsec.sh -6 -p esp -a sha1 -e cast5 -m transport -s 100:1000:65535
-tcp6_ipsec27 tcp_ipsec.sh -6 -p esp -a sha1 -e cast5 -m tunnel -s 100:1000:65535
-tcp6_ipsec28 tcp_ipsec.sh -6 -p esp -a sha256 -e blowfish -m transport -s 100:1000:65535
-tcp6_ipsec29 tcp_ipsec.sh -6 -p esp -a sha256 -e blowfish -m tunnel -s 100:1000:65535
-tcp6_ipsec30 tcp_ipsec.sh -6 -p esp -a sha384 -e twofish -m transport -s 100:1000:65535
-tcp6_ipsec31 tcp_ipsec.sh -6 -p esp -a sha384 -e twofish -m tunnel -s 100:1000:65535
-tcp6_ipsec32 tcp_ipsec.sh -6 -p esp -a sha512 -e camellia -m transport -s 100:1000:65535
-tcp6_ipsec33 tcp_ipsec.sh -6 -p esp -a sha512 -e camellia -m tunnel -s 100:1000:65535
-tcp6_ipsec34 tcp_ipsec.sh -6 -p esp -a rmd160 -e serpent -m transport -s 100:1000:65535
-tcp6_ipsec35 tcp_ipsec.sh -6 -p esp -a rmd160 -e serpent -m tunnel -s 100:1000:65535
-tcp6_ipsec36 tcp_ipsec.sh -6 -p esp -m beet -s 100:1000:65535
+tcp6_ipsec01 tcp_ipsec.sh -6 -s 100:1000:65535:R65535
+tcp6_ipsec02 tcp_ipsec.sh -6 -p ah -m transport -s 100:1000:65535:R65535
+tcp6_ipsec03 tcp_ipsec.sh -6 -p ah -m tunnel -s 100:1000:65535:R65535
+tcp6_ipsec04 tcp_ipsec.sh -6 -p esp -m transport -s 100:1000:65535:R65535
+tcp6_ipsec05 tcp_ipsec.sh -6 -p esp -m tunnel -s 100:1000:65535:R65535
+tcp6_ipsec06 tcp_ipsec.sh -6 -p comp -m transport -s 100:1000:65535:R65535
+tcp6_ipsec07 tcp_ipsec.sh -6 -p comp -m tunnel -s 100:1000:65535:R65535
+tcp6_ipsec08 tcp_ipsec.sh -6 -A rfc4106_128 -p esp_aead -m transport -s 100:1000:65535:R65535
+tcp6_ipsec09 tcp_ipsec.sh -6 -A rfc4106_128 -p esp_aead -m tunnel -s 100:1000:65535:R65535
+tcp6_ipsec10 tcp_ipsec.sh -6 -A rfc4106_192 -p esp_aead -m transport -s 100:1000:65535:R65535
+tcp6_ipsec11 tcp_ipsec.sh -6 -A rfc4106_192 -p esp_aead -m tunnel -s 100:1000:65535:R65535
+tcp6_ipsec12 tcp_ipsec.sh -6 -A rfc4106_256 -p esp_aead -m transport -s 100:1000:65535:R65535
+tcp6_ipsec13 tcp_ipsec.sh -6 -A rfc4106_256 -p esp_aead -m tunnel -s 100:1000:65535:R65535
+tcp6_ipsec14 tcp_ipsec.sh -6 -A rfc4309_128 -p esp_aead -m transport -s 100:1000:65535:R65535
+tcp6_ipsec15 tcp_ipsec.sh -6 -A rfc4309_128 -p esp_aead -m tunnel -s 100:1000:65535:R65535
+tcp6_ipsec16 tcp_ipsec.sh -6 -A rfc4309_192 -p esp_aead -m transport -s 100:1000:65535:R65535
+tcp6_ipsec17 tcp_ipsec.sh -6 -A rfc4309_192 -p esp_aead -m tunnel -s 100:1000:65535:R65535
+tcp6_ipsec18 tcp_ipsec.sh -6 -A rfc4309_256 -p esp_aead -m transport -s 100:1000:65535:R65535
+tcp6_ipsec19 tcp_ipsec.sh -6 -A rfc4309_256 -p esp_aead -m tunnel -s 100:1000:65535:R65535
+tcp6_ipsec20 tcp_ipsec.sh -6 -A rfc4543_128 -p esp_aead -m transport -s 100:1000:65535:R65535
+tcp6_ipsec21 tcp_ipsec.sh -6 -A rfc4543_128 -p esp_aead -m tunnel -s 100:1000:65535:R65535
+tcp6_ipsec22 tcp_ipsec.sh -6 -A rfc4543_192 -p esp_aead -m transport -s 100:1000:65535:R65535
+tcp6_ipsec23 tcp_ipsec.sh -6 -A rfc4543_192 -p esp_aead -m tunnel -s 100:1000:65535:R65535
+tcp6_ipsec24 tcp_ipsec.sh -6 -A rfc4543_256 -p esp_aead -m transport -s 100:1000:65535:R65535
+tcp6_ipsec25 tcp_ipsec.sh -6 -A rfc4543_256 -p esp_aead -m tunnel -s 100:1000:65535:R65535
+tcp6_ipsec26 tcp_ipsec.sh -6 -p esp -a sha1 -e cast5 -m transport -s 100:1000:65535:R65535
+tcp6_ipsec27 tcp_ipsec.sh -6 -p esp -a sha1 -e cast5 -m tunnel -s 100:1000:65535:R65535
+tcp6_ipsec28 tcp_ipsec.sh -6 -p esp -a sha256 -e blowfish -m transport -s 100:1000:65535:R65535
+tcp6_ipsec29 tcp_ipsec.sh -6 -p esp -a sha256 -e blowfish -m tunnel -s 100:1000:65535:R65535
+tcp6_ipsec30 tcp_ipsec.sh -6 -p esp -a sha384 -e twofish -m transport -s 100:1000:65535:R65535
+tcp6_ipsec31 tcp_ipsec.sh -6 -p esp -a sha384 -e twofish -m tunnel -s 100:1000:65535:R65535
+tcp6_ipsec32 tcp_ipsec.sh -6 -p esp -a sha512 -e camellia -m transport -s 100:1000:65535:R65535
+tcp6_ipsec33 tcp_ipsec.sh -6 -p esp -a sha512 -e camellia -m tunnel -s 100:1000:65535:R65535
+tcp6_ipsec34 tcp_ipsec.sh -6 -p esp -a rmd160 -e serpent -m transport -s 100:1000:65535:R65535
+tcp6_ipsec35 tcp_ipsec.sh -6 -p esp -a rmd160 -e serpent -m tunnel -s 100:1000:65535:R65535
+tcp6_ipsec36 tcp_ipsec.sh -6 -p esp -m beet -s 100:1000:65535:R65535
 
-tcp4_ipsec_vti01 tcp_ipsec_vti.sh -p ah -m tunnel -s 100:1000:65535
-tcp4_ipsec_vti02 tcp_ipsec_vti.sh -p esp -m tunnel -s 100:1000:65535
+tcp4_ipsec_vti01 tcp_ipsec_vti.sh -p ah -m tunnel -s 100:1000:65535:R65535
+tcp4_ipsec_vti02 tcp_ipsec_vti.sh -p esp -m tunnel -s 100:1000:65535:R65535
 # tcp4_ipsec_vti03 tcp_ipsec_vti.sh -p comp -m tunnel -s 100:1000:65535
-tcp4_ipsec_vti04 tcp_ipsec_vti.sh -A rfc4106_128 -p esp_aead -m tunnel -s 100:1000:65535
-tcp4_ipsec_vti05 tcp_ipsec_vti.sh -A rfc4106_192 -p esp_aead -m tunnel -s 100:1000:65535
-tcp4_ipsec_vti06 tcp_ipsec_vti.sh -A rfc4106_256 -p esp_aead -m tunnel -s 100:1000:65535
-tcp4_ipsec_vti07 tcp_ipsec_vti.sh -A rfc4309_128 -p esp_aead -m tunnel -s 100:1000:65535
-tcp4_ipsec_vti08 tcp_ipsec_vti.sh -A rfc4309_192 -p esp_aead -m tunnel -s 100:1000:65535
-tcp4_ipsec_vti09 tcp_ipsec_vti.sh -A rfc4309_256 -p esp_aead -m tunnel -s 100:1000:65535
-tcp4_ipsec_vti10 tcp_ipsec_vti.sh -A rfc4543_128 -p esp_aead -m tunnel -s 100:1000:65535
-tcp4_ipsec_vti11 tcp_ipsec_vti.sh -A rfc4543_192 -p esp_aead -m tunnel -s 100:1000:65535
-tcp4_ipsec_vti12 tcp_ipsec_vti.sh -A rfc4543_256 -p esp_aead -m tunnel -s 100:1000:65535
-tcp4_ipsec_vti13 tcp_ipsec_vti.sh -p esp -a sha1 -e cast5 -m tunnel -s 100:1000:65535
-tcp4_ipsec_vti14 tcp_ipsec_vti.sh -p esp -a sha256 -e blowfish -m tunnel -s 100:1000:65535
-tcp4_ipsec_vti15 tcp_ipsec_vti.sh -p esp -a sha384 -e twofish -m tunnel -s 100:1000:65535
-tcp4_ipsec_vti16 tcp_ipsec_vti.sh -p esp -a sha512 -e camellia -m tunnel -s 100:1000:65535
-tcp4_ipsec_vti17 tcp_ipsec_vti.sh -p esp -a rmd160 -e serpent -m tunnel -s 100:1000:65535
+tcp4_ipsec_vti04 tcp_ipsec_vti.sh -A rfc4106_128 -p esp_aead -m tunnel -s 100:1000:65535:R65535
+tcp4_ipsec_vti05 tcp_ipsec_vti.sh -A rfc4106_192 -p esp_aead -m tunnel -s 100:1000:65535:R65535
+tcp4_ipsec_vti06 tcp_ipsec_vti.sh -A rfc4106_256 -p esp_aead -m tunnel -s 100:1000:65535:R65535
+tcp4_ipsec_vti07 tcp_ipsec_vti.sh -A rfc4309_128 -p esp_aead -m tunnel -s 100:1000:65535:R65535
+tcp4_ipsec_vti08 tcp_ipsec_vti.sh -A rfc4309_192 -p esp_aead -m tunnel -s 100:1000:65535:R65535
+tcp4_ipsec_vti09 tcp_ipsec_vti.sh -A rfc4309_256 -p esp_aead -m tunnel -s 100:1000:65535:R65535
+tcp4_ipsec_vti10 tcp_ipsec_vti.sh -A rfc4543_128 -p esp_aead -m tunnel -s 100:1000:65535:R65535
+tcp4_ipsec_vti11 tcp_ipsec_vti.sh -A rfc4543_192 -p esp_aead -m tunnel -s 100:1000:65535:R65535
+tcp4_ipsec_vti12 tcp_ipsec_vti.sh -A rfc4543_256 -p esp_aead -m tunnel -s 100:1000:65535:R65535
+tcp4_ipsec_vti13 tcp_ipsec_vti.sh -p esp -a sha1 -e cast5 -m tunnel -s 100:1000:65535:R65535
+tcp4_ipsec_vti14 tcp_ipsec_vti.sh -p esp -a sha256 -e blowfish -m tunnel -s 100:1000:65535:R65535
+tcp4_ipsec_vti15 tcp_ipsec_vti.sh -p esp -a sha384 -e twofish -m tunnel -s 100:1000:65535:R65535
+tcp4_ipsec_vti16 tcp_ipsec_vti.sh -p esp -a sha512 -e camellia -m tunnel -s 100:1000:65535:R65535
+tcp4_ipsec_vti17 tcp_ipsec_vti.sh -p esp -a rmd160 -e serpent -m tunnel -s 100:1000:65535:R65535
 
-tcp6_ipsec_vti01 tcp_ipsec_vti.sh -6 -p ah -m tunnel -s 100:1000:65535
-tcp6_ipsec_vti02 tcp_ipsec_vti.sh -6 -p esp -m tunnel -s 100:1000:65535
+tcp6_ipsec_vti01 tcp_ipsec_vti.sh -6 -p ah -m tunnel -s 100:1000:65535:R65535
+tcp6_ipsec_vti02 tcp_ipsec_vti.sh -6 -p esp -m tunnel -s 100:1000:65535:R65535
 # tcp6_ipsec_vti03 tcp_ipsec_vti.sh -6 -p comp -m tunnel -s 100:1000:65535
-tcp6_ipsec_vti04 tcp_ipsec_vti.sh -6 -A rfc4106_128 -p esp_aead -m tunnel -s 100:1000:65535
-tcp6_ipsec_vti05 tcp_ipsec_vti.sh -6 -A rfc4106_192 -p esp_aead -m tunnel -s 100:1000:65535
-tcp6_ipsec_vti06 tcp_ipsec_vti.sh -6 -A rfc4106_256 -p esp_aead -m tunnel -s 100:1000:65535
-tcp6_ipsec_vti07 tcp_ipsec_vti.sh -6 -A rfc4309_128 -p esp_aead -m tunnel -s 100:1000:65535
-tcp6_ipsec_vti08 tcp_ipsec_vti.sh -6 -A rfc4309_192 -p esp_aead -m tunnel -s 100:1000:65535
-tcp6_ipsec_vti09 tcp_ipsec_vti.sh -6 -A rfc4309_256 -p esp_aead -m tunnel -s 100:1000:65535
-tcp6_ipsec_vti10 tcp_ipsec_vti.sh -6 -A rfc4543_128 -p esp_aead -m tunnel -s 100:1000:65535
-tcp6_ipsec_vti11 tcp_ipsec_vti.sh -6 -A rfc4543_192 -p esp_aead -m tunnel -s 100:1000:65535
-tcp6_ipsec_vti12 tcp_ipsec_vti.sh -6 -A rfc4543_256 -p esp_aead -m tunnel -s 100:1000:65535
-tcp6_ipsec_vti13 tcp_ipsec_vti.sh -6 -p esp -a sha1 -e cast5 -m tunnel -s 100:1000:65535
-tcp6_ipsec_vti14 tcp_ipsec_vti.sh -6 -p esp -a sha256 -e blowfish -m tunnel -s 100:1000:65535
-tcp6_ipsec_vti15 tcp_ipsec_vti.sh -6 -p esp -a sha384 -e twofish -m tunnel -s 100:1000:65535
-tcp6_ipsec_vti16 tcp_ipsec_vti.sh -6 -p esp -a sha512 -e camellia -m tunnel -s 100:1000:65535
-tcp6_ipsec_vti17 tcp_ipsec_vti.sh -6 -p esp -a rmd160 -e serpent -m tunnel -s 100:1000:65535
+tcp6_ipsec_vti04 tcp_ipsec_vti.sh -6 -A rfc4106_128 -p esp_aead -m tunnel -s 100:1000:65535:R65535
+tcp6_ipsec_vti05 tcp_ipsec_vti.sh -6 -A rfc4106_192 -p esp_aead -m tunnel -s 100:1000:65535:R65535
+tcp6_ipsec_vti06 tcp_ipsec_vti.sh -6 -A rfc4106_256 -p esp_aead -m tunnel -s 100:1000:65535:R65535
+tcp6_ipsec_vti07 tcp_ipsec_vti.sh -6 -A rfc4309_128 -p esp_aead -m tunnel -s 100:1000:65535:R65535
+tcp6_ipsec_vti08 tcp_ipsec_vti.sh -6 -A rfc4309_192 -p esp_aead -m tunnel -s 100:1000:65535:R65535
+tcp6_ipsec_vti09 tcp_ipsec_vti.sh -6 -A rfc4309_256 -p esp_aead -m tunnel -s 100:1000:65535:R65535
+tcp6_ipsec_vti10 tcp_ipsec_vti.sh -6 -A rfc4543_128 -p esp_aead -m tunnel -s 100:1000:65535:R65535
+tcp6_ipsec_vti11 tcp_ipsec_vti.sh -6 -A rfc4543_192 -p esp_aead -m tunnel -s 100:1000:65535:R65535
+tcp6_ipsec_vti12 tcp_ipsec_vti.sh -6 -A rfc4543_256 -p esp_aead -m tunnel -s 100:1000:65535:R65535
+tcp6_ipsec_vti13 tcp_ipsec_vti.sh -6 -p esp -a sha1 -e cast5 -m tunnel -s 100:1000:65535:R65535
+tcp6_ipsec_vti14 tcp_ipsec_vti.sh -6 -p esp -a sha256 -e blowfish -m tunnel -s 100:1000:65535:R65535
+tcp6_ipsec_vti15 tcp_ipsec_vti.sh -6 -p esp -a sha384 -e twofish -m tunnel -s 100:1000:65535:R65535
+tcp6_ipsec_vti16 tcp_ipsec_vti.sh -6 -p esp -a sha512 -e camellia -m tunnel -s 100:1000:65535:R65535
+tcp6_ipsec_vti17 tcp_ipsec_vti.sh -6 -p esp -a rmd160 -e serpent -m tunnel -s 100:1000:65535:R65535
diff --git a/runtest/net_stress.ipsec_udp b/runtest/net_stress.ipsec_udp
index 4b88c4d..37b4490 100644
--- a/runtest/net_stress.ipsec_udp
+++ b/runtest/net_stress.ipsec_udp
@@ -1,109 +1,109 @@
-udp4_ipsec01 udp_ipsec.sh -s 100:1000:65507
-udp4_ipsec02 udp_ipsec.sh -p ah -m transport -s 100:1000:65483
-udp4_ipsec03 udp_ipsec.sh -p ah -m tunnel -s 100:1000:65463
-udp4_ipsec04 udp_ipsec.sh -p esp -m transport -s 100:1000:65470
-udp4_ipsec05 udp_ipsec.sh -p esp -m tunnel -s 100:1000:65450
-udp4_ipsec06 udp_ipsec.sh -p comp -m transport -s 100:1000:65000
-udp4_ipsec07 udp_ipsec.sh -p comp -m tunnel -s 100:1000:65000
-udp4_ipsec08 udp_ipsec.sh -A rfc4106_128 -p esp_aead -m transport -s 100:1000:65470
-udp4_ipsec09 udp_ipsec.sh -A rfc4106_128 -p esp_aead -m tunnel -s 100:1000:65450
-udp4_ipsec10 udp_ipsec.sh -A rfc4106_192 -p esp_aead -m transport -s 100:1000:65470
-udp4_ipsec11 udp_ipsec.sh -A rfc4106_192 -p esp_aead -m tunnel -s 100:1000:65450
-udp4_ipsec12 udp_ipsec.sh -A rfc4106_256 -p esp_aead -m transport -s 100:1000:65470
-udp4_ipsec13 udp_ipsec.sh -A rfc4106_256 -p esp_aead -m tunnel -s 100:1000:65450
-udp4_ipsec14 udp_ipsec.sh -A rfc4309_128 -p esp_aead -m transport -s 100:1000:65470
-udp4_ipsec15 udp_ipsec.sh -A rfc4309_128 -p esp_aead -m tunnel -s 100:1000:65450
-udp4_ipsec16 udp_ipsec.sh -A rfc4309_192 -p esp_aead -m transport -s 100:1000:65470
-udp4_ipsec17 udp_ipsec.sh -A rfc4309_192 -p esp_aead -m tunnel -s 100:1000:65450
-udp4_ipsec18 udp_ipsec.sh -A rfc4309_256 -p esp_aead -m transport -s 100:1000:65470
-udp4_ipsec19 udp_ipsec.sh -A rfc4309_256 -p esp_aead -m tunnel -s 100:1000:65450
-udp4_ipsec20 udp_ipsec.sh -A rfc4543_128 -p esp_aead -m transport -s 100:1000:65470
-udp4_ipsec21 udp_ipsec.sh -A rfc4543_128 -p esp_aead -m tunnel -s 100:1000:65450
-udp4_ipsec22 udp_ipsec.sh -A rfc4543_192 -p esp_aead -m transport -s 100:1000:65470
-udp4_ipsec23 udp_ipsec.sh -A rfc4543_192 -p esp_aead -m tunnel -s 100:1000:65450
-udp4_ipsec24 udp_ipsec.sh -A rfc4543_256 -p esp_aead -m transport -s 100:1000:65470
-udp4_ipsec25 udp_ipsec.sh -A rfc4543_256 -p esp_aead -m tunnel -s 100:1000:65450
-udp4_ipsec26 udp_ipsec.sh -p esp -a sha1 -e cast5 -m transport -s 100:1000:65470
-udp4_ipsec27 udp_ipsec.sh -p esp -a sha1 -e cast5 -m tunnel -s 100:1000:65450
-udp4_ipsec28 udp_ipsec.sh -p esp -a sha256 -e blowfish -m transport -s 100:1000:65470
-udp4_ipsec29 udp_ipsec.sh -p esp -a sha256 -e blowfish -m tunnel -s 100:1000:65426
-udp4_ipsec30 udp_ipsec.sh -p esp -a sha384 -e twofish -m transport -s 100:1000:65446
-udp4_ipsec31 udp_ipsec.sh -p esp -a sha384 -e twofish -m tunnel -s 100:1000:65426
-udp4_ipsec32 udp_ipsec.sh -p esp -a sha512 -e camellia -m transport -s 100:1000:65446
-udp4_ipsec33 udp_ipsec.sh -p esp -a sha512 -e camellia -m tunnel -s 100:1000:65426
-udp4_ipsec34 udp_ipsec.sh -p esp -a rmd160 -e serpent -m transport -s 100:1000:65446
-udp4_ipsec35 udp_ipsec.sh -p esp -a rmd160 -e serpent -m tunnel -s 100:1000:65426
-udp4_ipsec36 udp_ipsec.sh -p esp -m beet -s 100:1000:65446
+udp4_ipsec01 udp_ipsec.sh -s 100:1000:65507:R65507
+udp4_ipsec02 udp_ipsec.sh -p ah -m transport -s 100:1000:65483:R65483
+udp4_ipsec03 udp_ipsec.sh -p ah -m tunnel -s 100:1000:65463:R65463
+udp4_ipsec04 udp_ipsec.sh -p esp -m transport -s 100:1000:65470:R65470
+udp4_ipsec05 udp_ipsec.sh -p esp -m tunnel -s 100:1000:65450:R65450
+udp4_ipsec06 udp_ipsec.sh -p comp -m transport -s 100:1000:65000:R65000
+udp4_ipsec07 udp_ipsec.sh -p comp -m tunnel -s 100:1000:65000:R65000
+udp4_ipsec08 udp_ipsec.sh -A rfc4106_128 -p esp_aead -m transport -s 100:1000:65470:R65470
+udp4_ipsec09 udp_ipsec.sh -A rfc4106_128 -p esp_aead -m tunnel -s 100:1000:65450:R65450
+udp4_ipsec10 udp_ipsec.sh -A rfc4106_192 -p esp_aead -m transport -s 100:1000:65470:R65470
+udp4_ipsec11 udp_ipsec.sh -A rfc4106_192 -p esp_aead -m tunnel -s 100:1000:65450:R65450
+udp4_ipsec12 udp_ipsec.sh -A rfc4106_256 -p esp_aead -m transport -s 100:1000:65470:R65470
+udp4_ipsec13 udp_ipsec.sh -A rfc4106_256 -p esp_aead -m tunnel -s 100:1000:65450:R65450
+udp4_ipsec14 udp_ipsec.sh -A rfc4309_128 -p esp_aead -m transport -s 100:1000:65470:R65470
+udp4_ipsec15 udp_ipsec.sh -A rfc4309_128 -p esp_aead -m tunnel -s 100:1000:65450:R65450
+udp4_ipsec16 udp_ipsec.sh -A rfc4309_192 -p esp_aead -m transport -s 100:1000:65470:R65470
+udp4_ipsec17 udp_ipsec.sh -A rfc4309_192 -p esp_aead -m tunnel -s 100:1000:65450:R65450
+udp4_ipsec18 udp_ipsec.sh -A rfc4309_256 -p esp_aead -m transport -s 100:1000:65470:R65470
+udp4_ipsec19 udp_ipsec.sh -A rfc4309_256 -p esp_aead -m tunnel -s 100:1000:65450:R65450
+udp4_ipsec20 udp_ipsec.sh -A rfc4543_128 -p esp_aead -m transport -s 100:1000:65470:R65470
+udp4_ipsec21 udp_ipsec.sh -A rfc4543_128 -p esp_aead -m tunnel -s 100:1000:65450:R65450
+udp4_ipsec22 udp_ipsec.sh -A rfc4543_192 -p esp_aead -m transport -s 100:1000:65470:R65470
+udp4_ipsec23 udp_ipsec.sh -A rfc4543_192 -p esp_aead -m tunnel -s 100:1000:65450:R65450
+udp4_ipsec24 udp_ipsec.sh -A rfc4543_256 -p esp_aead -m transport -s 100:1000:65470:R65470
+udp4_ipsec25 udp_ipsec.sh -A rfc4543_256 -p esp_aead -m tunnel -s 100:1000:65450:R65450
+udp4_ipsec26 udp_ipsec.sh -p esp -a sha1 -e cast5 -m transport -s 100:1000:65470:R65470
+udp4_ipsec27 udp_ipsec.sh -p esp -a sha1 -e cast5 -m tunnel -s 100:1000:65450:R65450
+udp4_ipsec28 udp_ipsec.sh -p esp -a sha256 -e blowfish -m transport -s 100:1000:65470:R65470
+udp4_ipsec29 udp_ipsec.sh -p esp -a sha256 -e blowfish -m tunnel -s 100:1000:65426:R65426
+udp4_ipsec30 udp_ipsec.sh -p esp -a sha384 -e twofish -m transport -s 100:1000:65446:R65446
+udp4_ipsec31 udp_ipsec.sh -p esp -a sha384 -e twofish -m tunnel -s 100:1000:65426:R65426
+udp4_ipsec32 udp_ipsec.sh -p esp -a sha512 -e camellia -m transport -s 100:1000:65446:R65446
+udp4_ipsec33 udp_ipsec.sh -p esp -a sha512 -e camellia -m tunnel -s 100:1000:65426:R65426
+udp4_ipsec34 udp_ipsec.sh -p esp -a rmd160 -e serpent -m transport -s 100:1000:65446:R65446
+udp4_ipsec35 udp_ipsec.sh -p esp -a rmd160 -e serpent -m tunnel -s 100:1000:65426:R65426
+udp4_ipsec36 udp_ipsec.sh -p esp -m beet -s 100:1000:65446:R65446
 
-udp6_ipsec01 udp_ipsec.sh -6 -s 100:1000:65527
-udp6_ipsec02 udp_ipsec.sh -6 -p ah -m transport -s 100:1000:65503
-udp6_ipsec03 udp_ipsec.sh -6 -p ah -m tunnel -s 100:1000:65527
-udp6_ipsec04 udp_ipsec.sh -6 -p esp -m transport -s 100:1000:65490
-udp6_ipsec05 udp_ipsec.sh -6 -p esp -m tunnel -s 100:1000:65527
-udp6_ipsec06 udp_ipsec.sh -6 -p comp -m transport -s 100:1000:65000
-udp6_ipsec07 udp_ipsec.sh -6 -p comp -m tunnel -s 100:1000:65000
-udp6_ipsec08 udp_ipsec.sh -6 -A rfc4106_128 -p esp_aead -m transport -s 100:1000:65490
-udp6_ipsec09 udp_ipsec.sh -6 -A rfc4106_128 -p esp_aead -m tunnel -s 100:1000:65527
-udp6_ipsec10 udp_ipsec.sh -6 -A rfc4106_192 -p esp_aead -m transport -s 100:1000:65490
-udp6_ipsec11 udp_ipsec.sh -6 -A rfc4106_192 -p esp_aead -m tunnel -s 100:1000:65527
-udp6_ipsec12 udp_ipsec.sh -6 -A rfc4106_256 -p esp_aead -m transport -s 100:1000:65490
-udp6_ipsec13 udp_ipsec.sh -6 -A rfc4106_256 -p esp_aead -m tunnel -s 100:1000:65527
-udp6_ipsec14 udp_ipsec.sh -6 -A rfc4309_128 -p esp_aead -m transport -s 100:1000:65490
-udp6_ipsec15 udp_ipsec.sh -6 -A rfc4309_128 -p esp_aead -m tunnel -s 100:1000:65527
-udp6_ipsec16 udp_ipsec.sh -6 -A rfc4309_192 -p esp_aead -m transport -s 100:1000:65490
-udp6_ipsec17 udp_ipsec.sh -6 -A rfc4309_192 -p esp_aead -m tunnel -s 100:1000:65527
-udp6_ipsec18 udp_ipsec.sh -6 -A rfc4309_256 -p esp_aead -m transport -s 100:1000:65490
-udp6_ipsec19 udp_ipsec.sh -6 -A rfc4309_256 -p esp_aead -m tunnel -s 100:1000:65527
-udp6_ipsec20 udp_ipsec.sh -6 -A rfc4543_128 -p esp_aead -m transport -s 100:1000:65490
-udp6_ipsec21 udp_ipsec.sh -6 -A rfc4543_128 -p esp_aead -m tunnel -s 100:1000:65527
-udp6_ipsec22 udp_ipsec.sh -6 -A rfc4543_192 -p esp_aead -m transport -s 100:1000:65490
-udp6_ipsec23 udp_ipsec.sh -6 -A rfc4543_192 -p esp_aead -m tunnel -s 100:1000:65527
-udp6_ipsec24 udp_ipsec.sh -6 -A rfc4543_256 -p esp_aead -m transport -s 100:1000:65490
-udp6_ipsec25 udp_ipsec.sh -6 -A rfc4543_256 -p esp_aead -m tunnel -s 100:1000:65527
-udp6_ipsec26 udp_ipsec.sh -6 -p esp -a sha1 -e cast5 -m transport -s 100:1000:65490
-udp6_ipsec27 udp_ipsec.sh -6 -p esp -a sha1 -e cast5 -m tunnel -s 100:1000:65527
-udp6_ipsec28 udp_ipsec.sh -6 -p esp -a sha256 -e blowfish -m transport -s 100:1000:65490
-udp6_ipsec29 udp_ipsec.sh -6 -p esp -a sha256 -e blowfish -m tunnel -s 100:1000:65527
-udp6_ipsec30 udp_ipsec.sh -6 -p esp -a sha384 -e twofish -m transport -s 100:1000:65462
-udp6_ipsec31 udp_ipsec.sh -6 -p esp -a sha384 -e twofish -m tunnel -s 100:1000:65527
-udp6_ipsec32 udp_ipsec.sh -6 -p esp -a sha512 -e camellia -m transport -s 100:1000:65462
-udp6_ipsec33 udp_ipsec.sh -6 -p esp -a sha512 -e camellia -m tunnel -s 100:1000:65527
-udp6_ipsec34 udp_ipsec.sh -6 -p esp -a rmd160 -e serpent -m transport -s 100:1000:65478
-udp6_ipsec35 udp_ipsec.sh -6 -p esp -a rmd160 -e serpent -m tunnel -s 100:1000:65527
-udp6_ipsec36 udp_ipsec.sh -6 -p esp -m beet -s 100:1000:65478
+udp6_ipsec01 udp_ipsec.sh -6 -s 100:1000:65527:R65527
+udp6_ipsec02 udp_ipsec.sh -6 -p ah -m transport -s 100:1000:65503:R65503
+udp6_ipsec03 udp_ipsec.sh -6 -p ah -m tunnel -s 100:1000:65527:R65527
+udp6_ipsec04 udp_ipsec.sh -6 -p esp -m transport -s 100:1000:65490:R65490
+udp6_ipsec05 udp_ipsec.sh -6 -p esp -m tunnel -s 100:1000:65527:R65527
+udp6_ipsec06 udp_ipsec.sh -6 -p comp -m transport -s 100:1000:65000:R65000
+udp6_ipsec07 udp_ipsec.sh -6 -p comp -m tunnel -s 100:1000:65000:R65000
+udp6_ipsec08 udp_ipsec.sh -6 -A rfc4106_128 -p esp_aead -m transport -s 100:1000:65490:R65490
+udp6_ipsec09 udp_ipsec.sh -6 -A rfc4106_128 -p esp_aead -m tunnel -s 100:1000:65527:R65527
+udp6_ipsec10 udp_ipsec.sh -6 -A rfc4106_192 -p esp_aead -m transport -s 100:1000:65490:R65490
+udp6_ipsec11 udp_ipsec.sh -6 -A rfc4106_192 -p esp_aead -m tunnel -s 100:1000:65527:R65527
+udp6_ipsec12 udp_ipsec.sh -6 -A rfc4106_256 -p esp_aead -m transport -s 100:1000:65490:R65490
+udp6_ipsec13 udp_ipsec.sh -6 -A rfc4106_256 -p esp_aead -m tunnel -s 100:1000:65527:R65527
+udp6_ipsec14 udp_ipsec.sh -6 -A rfc4309_128 -p esp_aead -m transport -s 100:1000:65490:R65490
+udp6_ipsec15 udp_ipsec.sh -6 -A rfc4309_128 -p esp_aead -m tunnel -s 100:1000:65527:R65527
+udp6_ipsec16 udp_ipsec.sh -6 -A rfc4309_192 -p esp_aead -m transport -s 100:1000:65490:R65490
+udp6_ipsec17 udp_ipsec.sh -6 -A rfc4309_192 -p esp_aead -m tunnel -s 100:1000:65527:R65527
+udp6_ipsec18 udp_ipsec.sh -6 -A rfc4309_256 -p esp_aead -m transport -s 100:1000:65490:R65490
+udp6_ipsec19 udp_ipsec.sh -6 -A rfc4309_256 -p esp_aead -m tunnel -s 100:1000:65527:R65527
+udp6_ipsec20 udp_ipsec.sh -6 -A rfc4543_128 -p esp_aead -m transport -s 100:1000:65490:R65490
+udp6_ipsec21 udp_ipsec.sh -6 -A rfc4543_128 -p esp_aead -m tunnel -s 100:1000:65527:R65527
+udp6_ipsec22 udp_ipsec.sh -6 -A rfc4543_192 -p esp_aead -m transport -s 100:1000:65490:R65490
+udp6_ipsec23 udp_ipsec.sh -6 -A rfc4543_192 -p esp_aead -m tunnel -s 100:1000:65527:R65527
+udp6_ipsec24 udp_ipsec.sh -6 -A rfc4543_256 -p esp_aead -m transport -s 100:1000:65490:R65490
+udp6_ipsec25 udp_ipsec.sh -6 -A rfc4543_256 -p esp_aead -m tunnel -s 100:1000:65527:R65527
+udp6_ipsec26 udp_ipsec.sh -6 -p esp -a sha1 -e cast5 -m transport -s 100:1000:65490:R65490
+udp6_ipsec27 udp_ipsec.sh -6 -p esp -a sha1 -e cast5 -m tunnel -s 100:1000:65527:R65527
+udp6_ipsec28 udp_ipsec.sh -6 -p esp -a sha256 -e blowfish -m transport -s 100:1000:65490:R65490
+udp6_ipsec29 udp_ipsec.sh -6 -p esp -a sha256 -e blowfish -m tunnel -s 100:1000:65527:R65527
+udp6_ipsec30 udp_ipsec.sh -6 -p esp -a sha384 -e twofish -m transport -s 100:1000:65462:R65462
+udp6_ipsec31 udp_ipsec.sh -6 -p esp -a sha384 -e twofish -m tunnel -s 100:1000:65527:R65527
+udp6_ipsec32 udp_ipsec.sh -6 -p esp -a sha512 -e camellia -m transport -s 100:1000:65462:R65462
+udp6_ipsec33 udp_ipsec.sh -6 -p esp -a sha512 -e camellia -m tunnel -s 100:1000:65527:R65527
+udp6_ipsec34 udp_ipsec.sh -6 -p esp -a rmd160 -e serpent -m transport -s 100:1000:65478:R65478
+udp6_ipsec35 udp_ipsec.sh -6 -p esp -a rmd160 -e serpent -m tunnel -s 100:1000:65527:R65527
+udp6_ipsec36 udp_ipsec.sh -6 -p esp -m beet -s 100:1000:65478:R65478
 
-udp4_ipsec_vti01 udp_ipsec_vti.sh -p ah -m tunnel -s 100:1000:65463
-udp4_ipsec_vti02 udp_ipsec_vti.sh -p esp -m tunnel -s 100:1000:65450
-udp4_ipsec_vti03 udp_ipsec_vti.sh -p comp -m tunnel -s 1500
-udp4_ipsec_vti04 udp_ipsec_vti.sh -A rfc4106_128 -p esp_aead -m tunnel -s 100:1000:65450
-udp4_ipsec_vti05 udp_ipsec_vti.sh -A rfc4106_192 -p esp_aead -m tunnel -s 100:1000:65450
-udp4_ipsec_vti06 udp_ipsec_vti.sh -A rfc4106_256 -p esp_aead -m tunnel -s 100:1000:65450
-udp4_ipsec_vti07 udp_ipsec_vti.sh -A rfc4309_128 -p esp_aead -m tunnel -s 100:1000:65450
-udp4_ipsec_vti08 udp_ipsec_vti.sh -A rfc4309_192 -p esp_aead -m tunnel -s 100:1000:65450
-udp4_ipsec_vti09 udp_ipsec_vti.sh -A rfc4309_256 -p esp_aead -m tunnel -s 100:1000:65450
-udp4_ipsec_vti10 udp_ipsec_vti.sh -A rfc4543_128 -p esp_aead -m tunnel -s 100:1000:65450
-udp4_ipsec_vti11 udp_ipsec_vti.sh -A rfc4543_192 -p esp_aead -m tunnel -s 100:1000:65450
-udp4_ipsec_vti12 udp_ipsec_vti.sh -A rfc4543_256 -p esp_aead -m tunnel -s 100:1000:65450
-udp4_ipsec_vti13 udp_ipsec_vti.sh -p esp -a sha1 -e cast5 -m tunnel -s 100:1000:65450
-udp4_ipsec_vti14 udp_ipsec_vti.sh -p esp -a sha256 -e blowfish -m tunnel -s 100:1000:65426
-udp4_ipsec_vti15 udp_ipsec_vti.sh -p esp -a sha384 -e twofish -m tunnel -s 100:1000:65426
-udp4_ipsec_vti16 udp_ipsec_vti.sh -p esp -a sha512 -e camellia -m tunnel -s 100:1000:65426
-udp4_ipsec_vti17 udp_ipsec_vti.sh -p esp -a rmd160 -e serpent -m tunnel -s 100:1000:65426
+udp4_ipsec_vti01 udp_ipsec_vti.sh -p ah -m tunnel -s 100:1000:65463:R65463
+udp4_ipsec_vti02 udp_ipsec_vti.sh -p esp -m tunnel -s 100:1000:65450:R65450
+udp4_ipsec_vti03 udp_ipsec_vti.sh -p comp -m tunnel -s 1000
+udp4_ipsec_vti04 udp_ipsec_vti.sh -A rfc4106_128 -p esp_aead -m tunnel -s 100:1000:65450:R65450
+udp4_ipsec_vti05 udp_ipsec_vti.sh -A rfc4106_192 -p esp_aead -m tunnel -s 100:1000:65450:R65450
+udp4_ipsec_vti06 udp_ipsec_vti.sh -A rfc4106_256 -p esp_aead -m tunnel -s 100:1000:65450:R65450
+udp4_ipsec_vti07 udp_ipsec_vti.sh -A rfc4309_128 -p esp_aead -m tunnel -s 100:1000:65450:R65450
+udp4_ipsec_vti08 udp_ipsec_vti.sh -A rfc4309_192 -p esp_aead -m tunnel -s 100:1000:65450:R65450
+udp4_ipsec_vti09 udp_ipsec_vti.sh -A rfc4309_256 -p esp_aead -m tunnel -s 100:1000:65450:R65450
+udp4_ipsec_vti10 udp_ipsec_vti.sh -A rfc4543_128 -p esp_aead -m tunnel -s 100:1000:65450:R65450
+udp4_ipsec_vti11 udp_ipsec_vti.sh -A rfc4543_192 -p esp_aead -m tunnel -s 100:1000:65450:R65450
+udp4_ipsec_vti12 udp_ipsec_vti.sh -A rfc4543_256 -p esp_aead -m tunnel -s 100:1000:65450:R65450
+udp4_ipsec_vti13 udp_ipsec_vti.sh -p esp -a sha1 -e cast5 -m tunnel -s 100:1000:65450:R65450
+udp4_ipsec_vti14 udp_ipsec_vti.sh -p esp -a sha256 -e blowfish -m tunnel -s 100:1000:65426:R65426
+udp4_ipsec_vti15 udp_ipsec_vti.sh -p esp -a sha384 -e twofish -m tunnel -s 100:1000:65426:R65426
+udp4_ipsec_vti16 udp_ipsec_vti.sh -p esp -a sha512 -e camellia -m tunnel -s 100:1000:65426:R65426
+udp4_ipsec_vti17 udp_ipsec_vti.sh -p esp -a rmd160 -e serpent -m tunnel -s 100:1000:65426:R65426
 
-udp6_ipsec_vti01 udp_ipsec_vti.sh -6 -p ah -m tunnel -s 100:1000:65527
-udp6_ipsec_vti02 udp_ipsec_vti.sh -6 -p esp -m tunnel -s 100:1000:65527
-udp6_ipsec_vti03 udp_ipsec_vti.sh -6 -p comp -m tunnel -s 1500
-udp6_ipsec_vti04 udp_ipsec_vti.sh -6 -A rfc4106_128 -p esp_aead -m tunnel -s 100:1000:65527
-udp6_ipsec_vti05 udp_ipsec_vti.sh -6 -A rfc4106_192 -p esp_aead -m tunnel -s 100:1000:65527
-udp6_ipsec_vti06 udp_ipsec_vti.sh -6 -A rfc4106_256 -p esp_aead -m tunnel -s 100:1000:65527
-udp6_ipsec_vti07 udp_ipsec_vti.sh -6 -A rfc4309_128 -p esp_aead -m tunnel -s 100:1000:65527
-udp6_ipsec_vti08 udp_ipsec_vti.sh -6 -A rfc4309_192 -p esp_aead -m tunnel -s 100:1000:65527
-udp6_ipsec_vti09 udp_ipsec_vti.sh -6 -A rfc4309_256 -p esp_aead -m tunnel -s 100:1000:65527
-udp6_ipsec_vti10 udp_ipsec_vti.sh -6 -A rfc4543_128 -p esp_aead -m tunnel -s 100:1000:65527
-udp6_ipsec_vti11 udp_ipsec_vti.sh -6 -A rfc4543_192 -p esp_aead -m tunnel -s 100:1000:65527
-udp6_ipsec_vti12 udp_ipsec_vti.sh -6 -A rfc4543_256 -p esp_aead -m tunnel -s 100:1000:65527
-udp6_ipsec_vti13 udp_ipsec_vti.sh -6 -p esp -a sha1 -e cast5 -m tunnel -s 100:1000:65527
-udp6_ipsec_vti14 udp_ipsec_vti.sh -6 -p esp -a sha256 -e blowfish -m tunnel -s 100:1000:65527
-udp6_ipsec_vti15 udp_ipsec_vti.sh -6 -p esp -a sha384 -e twofish -m tunnel -s 100:1000:65527
-udp6_ipsec_vti16 udp_ipsec_vti.sh -6 -p esp -a sha512 -e camellia -m tunnel -s 100:1000:65527
-udp6_ipsec_vti17 udp_ipsec_vti.sh -6 -p esp -a rmd160 -e serpent -m tunnel -s 100:1000:65527
+udp6_ipsec_vti01 udp_ipsec_vti.sh -6 -p ah -m tunnel -s 100:1000:65527:R65527
+udp6_ipsec_vti02 udp_ipsec_vti.sh -6 -p esp -m tunnel -s 100:1000:65527:R65527
+udp6_ipsec_vti03 udp_ipsec_vti.sh -6 -p comp -m tunnel -s 1000
+udp6_ipsec_vti04 udp_ipsec_vti.sh -6 -A rfc4106_128 -p esp_aead -m tunnel -s 100:1000:65527:R65527
+udp6_ipsec_vti05 udp_ipsec_vti.sh -6 -A rfc4106_192 -p esp_aead -m tunnel -s 100:1000:65527:R65527
+udp6_ipsec_vti06 udp_ipsec_vti.sh -6 -A rfc4106_256 -p esp_aead -m tunnel -s 100:1000:65527:R65527
+udp6_ipsec_vti07 udp_ipsec_vti.sh -6 -A rfc4309_128 -p esp_aead -m tunnel -s 100:1000:65527:R65527
+udp6_ipsec_vti08 udp_ipsec_vti.sh -6 -A rfc4309_192 -p esp_aead -m tunnel -s 100:1000:65527:R65527
+udp6_ipsec_vti09 udp_ipsec_vti.sh -6 -A rfc4309_256 -p esp_aead -m tunnel -s 100:1000:65527:R65527
+udp6_ipsec_vti10 udp_ipsec_vti.sh -6 -A rfc4543_128 -p esp_aead -m tunnel -s 100:1000:65527:R65527
+udp6_ipsec_vti11 udp_ipsec_vti.sh -6 -A rfc4543_192 -p esp_aead -m tunnel -s 100:1000:65527:R65527
+udp6_ipsec_vti12 udp_ipsec_vti.sh -6 -A rfc4543_256 -p esp_aead -m tunnel -s 100:1000:65527:R65527
+udp6_ipsec_vti13 udp_ipsec_vti.sh -6 -p esp -a sha1 -e cast5 -m tunnel -s 100:1000:65527:R65527
+udp6_ipsec_vti14 udp_ipsec_vti.sh -6 -p esp -a sha256 -e blowfish -m tunnel -s 100:1000:65527:R65527
+udp6_ipsec_vti15 udp_ipsec_vti.sh -6 -p esp -a sha384 -e twofish -m tunnel -s 100:1000:65527:R65527
+udp6_ipsec_vti16 udp_ipsec_vti.sh -6 -p esp -a sha512 -e camellia -m tunnel -s 100:1000:65527:R65527
+udp6_ipsec_vti17 udp_ipsec_vti.sh -6 -p esp -a rmd160 -e serpent -m tunnel -s 100:1000:65527:R65527
diff --git a/testcases/network/sockets/bind_noport01.sh b/testcases/network/sockets/bind_noport01.sh
index 67b12be..4eec4fd 100755
--- a/testcases/network/sockets/bind_noport01.sh
+++ b/testcases/network/sockets/bind_noport01.sh
@@ -2,6 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2018 Oracle and/or its affiliates.
 
+TST_CNT=2
 TST_TESTFUNC="test"
 TST_MIN_KVER="4.2"
 TST_NEEDS_TMPDIR=1
@@ -9,7 +10,7 @@ TST_TEST_DATA="tcp udp udp_lite dccp"
 
 . tst_net.sh
 
-test()
+test1()
 {
 	local type="$2"
 
@@ -18,4 +19,16 @@ test()
 	tst_netload -T $type -S $(tst_ipaddr) -H $(tst_ipaddr rhost)
 }
 
+test2()
+{
+	local type="$2"
+	local rsize="65000"
+
+	[ "$type" = "dccp" ] && rsize=1300
+
+	tst_res TINFO "test bind() with $type socket and random size payload"
+	tst_netload -T $type -S $(tst_ipaddr) -H $(tst_ipaddr rhost) -A $rsize
+}
+
+
 tst_run
diff --git a/testcases/network/stress/dccp/dccp_ipsec.sh b/testcases/network/stress/dccp/dccp_ipsec.sh
index ef80bf9..ff86063 100755
--- a/testcases/network/stress/dccp/dccp_ipsec.sh
+++ b/testcases/network/stress/dccp/dccp_ipsec.sh
@@ -12,7 +12,11 @@ TST_CLEANUP=tst_ipsec_cleanup
 
 do_test()
 {
-	tst_netload -H $(tst_ipaddr rhost) -T dccp -n $2 -N $2 -r $IPSEC_REQUESTS
+	local opts="-n $2 -N $2"
+	local rand_opt="$(echo $2 | cut -d'R' -f2)"
+
+	[ "$2" != "$rand_opt" ] && opts="-A $rand_opt"
+	tst_netload -H $(tst_ipaddr rhost) -T dccp $opts -r $IPSEC_REQUESTS
 }
 
 tst_run
diff --git a/testcases/network/stress/dccp/dccp_ipsec_vti.sh b/testcases/network/stress/dccp/dccp_ipsec_vti.sh
index ee2b0d4..5c8f782 100755
--- a/testcases/network/stress/dccp/dccp_ipsec_vti.sh
+++ b/testcases/network/stress/dccp/dccp_ipsec_vti.sh
@@ -12,7 +12,11 @@ TST_CLEANUP=tst_ipsec_cleanup
 
 do_test()
 {
-	tst_netload -H $ip_rmt_tun -T dccp -n $2 -N $2 -r $IPSEC_REQUESTS
+	local opts="-n $2 -N $2"
+	local rand_opt="$(echo $2 | cut -d'R' -f2)"
+
+	[ "$2" != "$rand_opt" ] && opts="-A $rand_opt"
+	tst_netload -H $ip_rmt_tun -T dccp $opts -r $IPSEC_REQUESTS
 }
 
 tst_run
diff --git a/testcases/network/stress/sctp/sctp_ipsec.sh b/testcases/network/stress/sctp/sctp_ipsec.sh
index 8a7b885..4ec2041 100755
--- a/testcases/network/stress/sctp/sctp_ipsec.sh
+++ b/testcases/network/stress/sctp/sctp_ipsec.sh
@@ -12,7 +12,11 @@ TST_CLEANUP=tst_ipsec_cleanup
 
 do_test()
 {
-	tst_netload -H $(tst_ipaddr rhost) -T sctp -n $2 -N $2 \
+	local opts="-n $2 -N $2"
+	local rand_opt="$(echo $2 | cut -d'R' -f2)"
+
+	[ "$2" != "$rand_opt" ] && opts="-A $rand_opt"
+	tst_netload -H $(tst_ipaddr rhost) -T sctp $opts \
 		-r $IPSEC_REQUESTS -S $(tst_ipaddr)
 }
 
diff --git a/testcases/network/stress/sctp/sctp_ipsec_vti.sh b/testcases/network/stress/sctp/sctp_ipsec_vti.sh
index d0f24c7..fe6135a 100755
--- a/testcases/network/stress/sctp/sctp_ipsec_vti.sh
+++ b/testcases/network/stress/sctp/sctp_ipsec_vti.sh
@@ -12,7 +12,11 @@ TST_TESTFUNC=do_test
 
 do_test()
 {
-	tst_netload -H $ip_rmt_tun -T sctp -n $2 -N $2 -r $IPSEC_REQUESTS \
+	local opts="-n $2 -N $2"
+	local rand_opt="$(echo $2 | cut -d'R' -f2)"
+
+	[ "$2" != "$rand_opt" ] && opts="-A $rand_opt"
+	tst_netload -H $ip_rmt_tun -T sctp $opts -r $IPSEC_REQUESTS \
 		-S $ip_loc_tun
 }
 
diff --git a/testcases/network/stress/tcp/tcp_ipsec.sh b/testcases/network/stress/tcp/tcp_ipsec.sh
index d62272d..5c46703 100755
--- a/testcases/network/stress/tcp/tcp_ipsec.sh
+++ b/testcases/network/stress/tcp/tcp_ipsec.sh
@@ -14,7 +14,11 @@ max_requests=10
 
 do_test()
 {
-	tst_netload -H $(tst_ipaddr rhost) -n $2 -N $2 -r $IPSEC_REQUESTS \
+	local opts="-n $2 -N $2"
+	local rand_opt="$(echo $2 | cut -d'R' -f2)"
+
+	[ "$2" != "$rand_opt" ] && opts="-A $rand_opt"
+	tst_netload -H $(tst_ipaddr rhost) $opts -r $IPSEC_REQUESTS \
 		-R $max_requests
 }
 
diff --git a/testcases/network/stress/tcp/tcp_ipsec_vti.sh b/testcases/network/stress/tcp/tcp_ipsec_vti.sh
index f7bbbc6..118db54 100755
--- a/testcases/network/stress/tcp/tcp_ipsec_vti.sh
+++ b/testcases/network/stress/tcp/tcp_ipsec_vti.sh
@@ -14,7 +14,11 @@ max_requests=10
 
 do_test()
 {
-	tst_netload -H $ip_rmt_tun -n $2 -N $2 -r $IPSEC_REQUESTS -R $max_requests
+	local opts="-n $2 -N $2"
+	local rand_opt="$(echo $2 | cut -d'R' -f2)"
+
+	[ "$2" != "$rand_opt" ] && opts="-A $rand_opt"
+	tst_netload -H $ip_rmt_tun $opts -r $IPSEC_REQUESTS -R $max_requests
 }
 
 tst_run
diff --git a/testcases/network/stress/udp/udp_ipsec.sh b/testcases/network/stress/udp/udp_ipsec.sh
index b59070e..1e10d20 100755
--- a/testcases/network/stress/udp/udp_ipsec.sh
+++ b/testcases/network/stress/udp/udp_ipsec.sh
@@ -13,10 +13,13 @@ TST_CLEANUP=tst_ipsec_cleanup
 
 do_test()
 {
+	local opts="-n $2 -N $2"
+	local rand_opt="$(echo $2 | cut -d'R' -f2)"
 	local type="udp"
-	[ $1 -eq 2 ] && type="udp_lite"
 
-	tst_netload -H $(tst_ipaddr rhost) -T $type -n $2 -N $2 -r $IPSEC_REQUESTS
+	[ $1 -eq 2 ] && type="udp_lite"
+	[ "$2" != "$rand_opt" ] && opts="-A $rand_opt"
+	tst_netload -H $(tst_ipaddr rhost) -T $type $opts -r $IPSEC_REQUESTS
 }
 
 tst_run
diff --git a/testcases/network/stress/udp/udp_ipsec_vti.sh b/testcases/network/stress/udp/udp_ipsec_vti.sh
index 65b48ea..2afe70e 100755
--- a/testcases/network/stress/udp/udp_ipsec_vti.sh
+++ b/testcases/network/stress/udp/udp_ipsec_vti.sh
@@ -13,10 +13,13 @@ TST_CLEANUP=tst_ipsec_cleanup
 
 do_test()
 {
+	local opts="-n $2 -N $2"
+	local rand_opt="$(echo $2 | cut -d'R' -f2)"
 	local type="udp"
-	[ $1 -eq 2 ] && type="udp_lite"
 
-	tst_netload -H $ip_rmt_tun -T $type -n $2 -N $2 -r $IPSEC_REQUESTS
+	[ $1 -eq 2 ] && type="udp_lite"
+	[ "$2" != "$rand_opt" ] && opts="-A $rand_opt"
+	tst_netload -H $ip_rmt_tun -T $type $opts -r $IPSEC_REQUESTS
 }
 
 tst_run
diff --git a/testcases/network/virt/geneve02.sh b/testcases/network/virt/geneve02.sh
new file mode 100755
index 0000000..615f0db
--- /dev/null
+++ b/testcases/network/virt/geneve02.sh
@@ -0,0 +1,38 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2019 Oracle and/or its affiliates.
+
+TST_NEEDS_TMPDIR=1
+TST_OPTS="hi:d:"
+TST_PARSE_ARGS=virt_lib_parse_args
+TST_NEEDS_DRIVERS="geneve"
+virt_type="geneve"
+start_id=16700000
+
+# Setting GENEVE tunnel with 'ip' command is very similar to VxLAN
+# that is why using here 'vxlan_*' library functions.
+vxlan_dst_addr="uni"
+
+TST_TESTFUNC=do_test
+TST_CLEANUP=virt_cleanup
+TST_TEST_DATA="noudpcsum udp6zerocsumtx udp6zerocsumrx, udpcsum"
+TST_TEST_DATA_IFS=","
+
+. virt_lib.sh
+
+VIRT_PERF_THRESHOLD=${VIRT_PERF_THRESHOLD:-160}
+[ "$VIRT_PERF_THRESHOLD" -lt 160 ] && VIRT_PERF_THRESHOLD=160
+
+do_test()
+{
+	virt_check_cmd virt_add ltp_v0 id 1 $2 remote \
+		$(tst_ipaddr rhost) || return 1
+
+	vxlan_setup_subnet_$vxlan_dst_addr "id 0xFFFFFE $2" "id 0xFFFFFE $2"
+	virt_netperf_rand_sizes
+	virt_cleanup_rmt
+
+	return 0
+}
+
+tst_run
diff --git a/testcases/network/virt/gre02.sh b/testcases/network/virt/gre02.sh
new file mode 100755
index 0000000..d556606
--- /dev/null
+++ b/testcases/network/virt/gre02.sh
@@ -0,0 +1,11 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2019 Oracle and/or its affiliates.
+
+TST_NEEDS_TMPDIR=1
+TST_TESTFUNC=virt_netperf_rand_sizes
+TST_SETUP=virt_gre_setup
+TST_CLEANUP=virt_cleanup
+. virt_lib.sh
+
+tst_run
diff --git a/testcases/network/virt/macsec03.sh b/testcases/network/virt/macsec03.sh
new file mode 100755
index 0000000..b7bd8fe
--- /dev/null
+++ b/testcases/network/virt/macsec03.sh
@@ -0,0 +1,13 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2019 Oracle and/or its affiliates.
+
+IPSEC_PROTO="esp_aead"
+EALGO="aes"
+MACSEC_LIB_SETUP="replay on window 1000 encrypt on protect on"
+
+. macsec_lib.sh
+
+TST_TESTFUNC=virt_netperf_rand_sizes
+
+tst_run
diff --git a/testcases/network/virt/virt_lib.sh b/testcases/network/virt/virt_lib.sh
index 92942d3..12512db 100644
--- a/testcases/network/virt/virt_lib.sh
+++ b/testcases/network/virt/virt_lib.sh
@@ -335,6 +335,16 @@ virt_netperf_msg_sizes()
 	done
 }
 
+virt_netperf_rand_sizes()
+{
+	local max_pkt_size="$TST_NET_MAX_PKT"
+	local types="tcp udp udp_lite"
+
+	for t in $types; do
+		virt_compare_netperf pass "-A $max_pkt_size -T $t"
+	done
+}
+
 # Check if we can create then delete virtual interface.
 virt_test_01()
 {
diff --git a/testcases/network/virt/vxlan04.sh b/testcases/network/virt/vxlan04.sh
new file mode 100755
index 0000000..45d3592
--- /dev/null
+++ b/testcases/network/virt/vxlan04.sh
@@ -0,0 +1,39 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2019 Oracle and/or its affiliates.
+
+TST_NEEDS_TMPDIR=1
+TST_OPTS="hi:d:"
+TST_PARSE_ARGS=virt_lib_parse_args
+TST_USAGE=virt_lib_usage
+TST_NEEDS_TMPDIR=1
+TST_TESTFUNC=do_test
+TST_CLEANUP=virt_cleanup
+TST_TEST_DATA="noudpcsum udp6zerocsumtx udp6zerocsumrx, udpcsum"
+TST_TEST_DATA_IFS=","
+
+virt_type="vxlan"
+start_id=16700000
+vxlan_dst_addr="uni"
+
+. virt_lib.sh
+
+VIRT_PERF_THRESHOLD=${VIRT_PERF_THRESHOLD:-160}
+[ "$VIRT_PERF_THRESHOLD" -lt 160 ] && VIRT_PERF_THRESHOLD=160
+
+do_test()
+{
+	if [ -z $ip_local -o -z $ip_remote ]; then
+		tst_brk TBROK "you must specify IP address"
+	fi
+
+	virt_check_cmd virt_add ltp_v0 id 0 $2 || continue
+
+	tst_res TINFO "the same VNI must work"
+	# VNI is 24 bits long, so max value, which is not reserved, is 0xFFFFFE
+	vxlan_setup_subnet_$vxlan_dst_addr "id 0xFFFFFE $2" "id 0xFFFFFE $2"
+	virt_netperf_rand_sizes
+	virt_cleanup_rmt
+}
+
+tst_run
-- 
1.7.1

