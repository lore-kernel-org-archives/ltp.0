From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 22 Jun 2018 17:10:43 +0200
Subject: [LTP] [PATCH v2 4/8] net/ipsec: Use ':' as array separator for -s
	parameter
In-Reply-To: <20180622151047.13002-1-pvorel@suse.cz>
References: <20180622151047.13002-1-pvorel@suse.cz>
Message-ID: <20180622151047.13002-5-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This is a preparation for new API, which is not able to handle quoted
parameters (problematic is TST_ARGS="$@").
-s parameter, used for $IPSEC_SIZE_ARRAY use space as array separator.
Use ':' instead, so parameter doesn't have to be quoted.

Fixes: 89a83d8a0 ("net/ipsec_lib.sh: Process getopts parameters with
TST_OPTS and TST_PARSE_ARGS")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 runtest/net_stress.ipsec_dccp               | 212 ++++++++++----------
 runtest/net_stress.ipsec_icmp               | 168 ++++++++--------
 runtest/net_stress.ipsec_sctp               | 212 ++++++++++----------
 runtest/net_stress.ipsec_tcp                | 212 ++++++++++----------
 runtest/net_stress.ipsec_udp                | 208 +++++++++----------
 testcases/network/stress/ipsec/ipsec_lib.sh |  12 +-
 6 files changed, 516 insertions(+), 508 deletions(-)

diff --git a/runtest/net_stress.ipsec_dccp b/runtest/net_stress.ipsec_dccp
index d867ab533..cdd10da26 100644
--- a/runtest/net_stress.ipsec_dccp
+++ b/runtest/net_stress.ipsec_dccp
@@ -1,109 +1,109 @@
-dccp4_ipsec01 dccp_ipsec.sh -s "100 500 1000"
-dccp4_ipsec02 dccp_ipsec.sh -p ah -m transport -s "100 500 1000"
-dccp4_ipsec03 dccp_ipsec.sh -p ah -m tunnel -s "100 500 1000"
-dccp4_ipsec04 dccp_ipsec.sh -p esp -m transport -s "100 500 1000"
-dccp4_ipsec05 dccp_ipsec.sh -p esp -m tunnel -s "100 500 1000"
-dccp4_ipsec06 dccp_ipsec.sh -p comp -m transport -s "100 500 1000"
-dccp4_ipsec07 dccp_ipsec.sh -p comp -m tunnel -s "100 500 1000"
-dccp4_ipsec08 dccp_ipsec.sh -A rfc4106_128 -p esp_aead -m transport -s "100 500 1000"
-dccp4_ipsec09 dccp_ipsec.sh -A rfc4106_128 -p esp_aead -m tunnel -s "100 500 1000"
-dccp4_ipsec10 dccp_ipsec.sh -A rfc4106_192 -p esp_aead -m transport -s "100 500 1000"
-dccp4_ipsec11 dccp_ipsec.sh -A rfc4106_192 -p esp_aead -m tunnel -s "100 500 1000"
-dccp4_ipsec12 dccp_ipsec.sh -A rfc4106_256 -p esp_aead -m transport -s "100 500 1000"
-dccp4_ipsec13 dccp_ipsec.sh -A rfc4106_256 -p esp_aead -m tunnel -s "100 500 1000"
-dccp4_ipsec14 dccp_ipsec.sh -A rfc4309_128 -p esp_aead -m transport -s "100 500 1000"
-dccp4_ipsec15 dccp_ipsec.sh -A rfc4309_128 -p esp_aead -m tunnel -s "100 500 1000"
-dccp4_ipsec16 dccp_ipsec.sh -A rfc4309_192 -p esp_aead -m transport -s "100 500 1000"
-dccp4_ipsec17 dccp_ipsec.sh -A rfc4309_192 -p esp_aead -m tunnel -s "100 500 1000"
-dccp4_ipsec18 dccp_ipsec.sh -A rfc4309_256 -p esp_aead -m transport -s "100 500 1000"
-dccp4_ipsec19 dccp_ipsec.sh -A rfc4309_256 -p esp_aead -m tunnel -s "100 500 1000"
-dccp4_ipsec20 dccp_ipsec.sh -A rfc4543_128 -p esp_aead -m transport -s "100 500 1000"
-dccp4_ipsec21 dccp_ipsec.sh -A rfc4543_128 -p esp_aead -m tunnel -s "100 500 1000"
-dccp4_ipsec22 dccp_ipsec.sh -A rfc4543_192 -p esp_aead -m transport -s "100 500 1000"
-dccp4_ipsec23 dccp_ipsec.sh -A rfc4543_192 -p esp_aead -m tunnel -s "100 500 1000"
-dccp4_ipsec24 dccp_ipsec.sh -A rfc4543_256 -p esp_aead -m transport -s "100 500 1000"
-dccp4_ipsec25 dccp_ipsec.sh -A rfc4543_256 -p esp_aead -m tunnel -s "100 500 1000"
-dccp4_ipsec26 dccp_ipsec.sh -p esp -a sha1 -e cast5 -m transport -s "100 500 1000"
-dccp4_ipsec27 dccp_ipsec.sh -p esp -a sha1 -e cast5 -m tunnel -s "100 500 1000"
-dccp4_ipsec28 dccp_ipsec.sh -p esp -a sha256 -e blowfish -m transport -s "100 500 1000"
-dccp4_ipsec29 dccp_ipsec.sh -p esp -a sha256 -e blowfish -m tunnel -s "100 500 1000"
-dccp4_ipsec30 dccp_ipsec.sh -p esp -a sha384 -e twofish -m transport -s "100 500 1000"
-dccp4_ipsec31 dccp_ipsec.sh -p esp -a sha384 -e twofish -m tunnel -s "100 500 1000"
-dccp4_ipsec32 dccp_ipsec.sh -p esp -a sha512 -e camellia -m transport -s "100 500 1000"
-dccp4_ipsec33 dccp_ipsec.sh -p esp -a sha512 -e camellia -m tunnel -s "100 500 1000"
-dccp4_ipsec34 dccp_ipsec.sh -p esp -a rmd160 -e serpent -m transport -s "100 500 1000"
-dccp4_ipsec35 dccp_ipsec.sh -p esp -a rmd160 -e serpent -m tunnel -s "100 500 1000"
-dccp4_ipsec36 dccp_ipsec.sh -p esp -m beet -s "100 500 1000"
+dccp4_ipsec01 dccp_ipsec.sh -s 100:500:1000
+dccp4_ipsec02 dccp_ipsec.sh -p ah -m transport -s 100:500:1000
+dccp4_ipsec03 dccp_ipsec.sh -p ah -m tunnel -s 100:500:1000
+dccp4_ipsec04 dccp_ipsec.sh -p esp -m transport -s 100:500:1000
+dccp4_ipsec05 dccp_ipsec.sh -p esp -m tunnel -s 100:500:1000
+dccp4_ipsec06 dccp_ipsec.sh -p comp -m transport -s 100:500:1000
+dccp4_ipsec07 dccp_ipsec.sh -p comp -m tunnel -s 100:500:1000
+dccp4_ipsec08 dccp_ipsec.sh -A rfc4106_128 -p esp_aead -m transport -s 100:500:1000
+dccp4_ipsec09 dccp_ipsec.sh -A rfc4106_128 -p esp_aead -m tunnel -s 100:500:1000
+dccp4_ipsec10 dccp_ipsec.sh -A rfc4106_192 -p esp_aead -m transport -s 100:500:1000
+dccp4_ipsec11 dccp_ipsec.sh -A rfc4106_192 -p esp_aead -m tunnel -s 100:500:1000
+dccp4_ipsec12 dccp_ipsec.sh -A rfc4106_256 -p esp_aead -m transport -s 100:500:1000
+dccp4_ipsec13 dccp_ipsec.sh -A rfc4106_256 -p esp_aead -m tunnel -s 100:500:1000
+dccp4_ipsec14 dccp_ipsec.sh -A rfc4309_128 -p esp_aead -m transport -s 100:500:1000
+dccp4_ipsec15 dccp_ipsec.sh -A rfc4309_128 -p esp_aead -m tunnel -s 100:500:1000
+dccp4_ipsec16 dccp_ipsec.sh -A rfc4309_192 -p esp_aead -m transport -s 100:500:1000
+dccp4_ipsec17 dccp_ipsec.sh -A rfc4309_192 -p esp_aead -m tunnel -s 100:500:1000
+dccp4_ipsec18 dccp_ipsec.sh -A rfc4309_256 -p esp_aead -m transport -s 100:500:1000
+dccp4_ipsec19 dccp_ipsec.sh -A rfc4309_256 -p esp_aead -m tunnel -s 100:500:1000
+dccp4_ipsec20 dccp_ipsec.sh -A rfc4543_128 -p esp_aead -m transport -s 100:500:1000
+dccp4_ipsec21 dccp_ipsec.sh -A rfc4543_128 -p esp_aead -m tunnel -s 100:500:1000
+dccp4_ipsec22 dccp_ipsec.sh -A rfc4543_192 -p esp_aead -m transport -s 100:500:1000
+dccp4_ipsec23 dccp_ipsec.sh -A rfc4543_192 -p esp_aead -m tunnel -s 100:500:1000
+dccp4_ipsec24 dccp_ipsec.sh -A rfc4543_256 -p esp_aead -m transport -s 100:500:1000
+dccp4_ipsec25 dccp_ipsec.sh -A rfc4543_256 -p esp_aead -m tunnel -s 100:500:1000
+dccp4_ipsec26 dccp_ipsec.sh -p esp -a sha1 -e cast5 -m transport -s 100:500:1000
+dccp4_ipsec27 dccp_ipsec.sh -p esp -a sha1 -e cast5 -m tunnel -s 100:500:1000
+dccp4_ipsec28 dccp_ipsec.sh -p esp -a sha256 -e blowfish -m transport -s 100:500:1000
+dccp4_ipsec29 dccp_ipsec.sh -p esp -a sha256 -e blowfish -m tunnel -s 100:500:1000
+dccp4_ipsec30 dccp_ipsec.sh -p esp -a sha384 -e twofish -m transport -s 100:500:1000
+dccp4_ipsec31 dccp_ipsec.sh -p esp -a sha384 -e twofish -m tunnel -s 100:500:1000
+dccp4_ipsec32 dccp_ipsec.sh -p esp -a sha512 -e camellia -m transport -s 100:500:1000
+dccp4_ipsec33 dccp_ipsec.sh -p esp -a sha512 -e camellia -m tunnel -s 100:500:1000
+dccp4_ipsec34 dccp_ipsec.sh -p esp -a rmd160 -e serpent -m transport -s 100:500:1000
+dccp4_ipsec35 dccp_ipsec.sh -p esp -a rmd160 -e serpent -m tunnel -s 100:500:1000
+dccp4_ipsec36 dccp_ipsec.sh -p esp -m beet -s 100:500:1000
 
-dccp6_ipsec01 dccp_ipsec.sh -6 -s "100 500 1000"
-dccp6_ipsec02 dccp_ipsec.sh -6 -p ah -m transport -s "100 500 1000"
-dccp6_ipsec03 dccp_ipsec.sh -6 -p ah -m tunnel -s "100 500 1000"
-dccp6_ipsec04 dccp_ipsec.sh -6 -p esp -m transport -s "100 500 1000"
-dccp6_ipsec05 dccp_ipsec.sh -6 -p esp -m tunnel -s "100 500 1000"
-dccp6_ipsec06 dccp_ipsec.sh -6 -p comp -m transport -s "100 500 1000"
-dccp6_ipsec07 dccp_ipsec.sh -6 -p comp -m tunnel -s "100 500 1000"
-dccp6_ipsec08 dccp_ipsec.sh -6 -A rfc4106_128 -p esp_aead -m transport -s "100 500 1000"
-dccp6_ipsec09 dccp_ipsec.sh -6 -A rfc4106_128 -p esp_aead -m tunnel -s "100 500 1000"
-dccp6_ipsec10 dccp_ipsec.sh -6 -A rfc4106_192 -p esp_aead -m transport -s "100 500 1000"
-dccp6_ipsec11 dccp_ipsec.sh -6 -A rfc4106_192 -p esp_aead -m tunnel -s "100 500 1000"
-dccp6_ipsec12 dccp_ipsec.sh -6 -A rfc4106_256 -p esp_aead -m transport -s "100 500 1000"
-dccp6_ipsec13 dccp_ipsec.sh -6 -A rfc4106_256 -p esp_aead -m tunnel -s "100 500 1000"
-dccp6_ipsec14 dccp_ipsec.sh -6 -A rfc4309_128 -p esp_aead -m transport -s "100 500 1000"
-dccp6_ipsec15 dccp_ipsec.sh -6 -A rfc4309_128 -p esp_aead -m tunnel -s "100 500 1000"
-dccp6_ipsec16 dccp_ipsec.sh -6 -A rfc4309_192 -p esp_aead -m transport -s "100 500 1000"
-dccp6_ipsec17 dccp_ipsec.sh -6 -A rfc4309_192 -p esp_aead -m tunnel -s "100 500 1000"
-dccp6_ipsec18 dccp_ipsec.sh -6 -A rfc4309_256 -p esp_aead -m transport -s "100 500 1000"
-dccp6_ipsec19 dccp_ipsec.sh -6 -A rfc4309_256 -p esp_aead -m tunnel -s "100 500 1000"
-dccp6_ipsec20 dccp_ipsec.sh -6 -A rfc4543_128 -p esp_aead -m transport -s "100 500 1000"
-dccp6_ipsec21 dccp_ipsec.sh -6 -A rfc4543_128 -p esp_aead -m tunnel -s "100 500 1000"
-dccp6_ipsec22 dccp_ipsec.sh -6 -A rfc4543_192 -p esp_aead -m transport -s "100 500 1000"
-dccp6_ipsec23 dccp_ipsec.sh -6 -A rfc4543_192 -p esp_aead -m tunnel -s "100 500 1000"
-dccp6_ipsec24 dccp_ipsec.sh -6 -A rfc4543_256 -p esp_aead -m transport -s "100 500 1000"
-dccp6_ipsec25 dccp_ipsec.sh -6 -A rfc4543_256 -p esp_aead -m tunnel -s "100 500 1000"
-dccp6_ipsec26 dccp_ipsec.sh -6 -p esp -a sha1 -e cast5 -m transport -s "100 500 1000"
-dccp6_ipsec27 dccp_ipsec.sh -6 -p esp -a sha1 -e cast5 -m tunnel -s "100 500 1000"
-dccp6_ipsec28 dccp_ipsec.sh -6 -p esp -a sha256 -e blowfish -m transport -s "100 500 1000"
-dccp6_ipsec29 dccp_ipsec.sh -6 -p esp -a sha256 -e blowfish -m tunnel -s "100 500 1000"
-dccp6_ipsec30 dccp_ipsec.sh -6 -p esp -a sha384 -e twofish -m transport -s "100 500 1000"
-dccp6_ipsec31 dccp_ipsec.sh -6 -p esp -a sha384 -e twofish -m tunnel -s "100 500 1000"
-dccp6_ipsec32 dccp_ipsec.sh -6 -p esp -a sha512 -e camellia -m transport -s "100 500 1000"
-dccp6_ipsec33 dccp_ipsec.sh -6 -p esp -a sha512 -e camellia -m tunnel -s "100 500 1000"
-dccp6_ipsec34 dccp_ipsec.sh -6 -p esp -a rmd160 -e serpent -m transport -s "100 500 1000"
-dccp6_ipsec35 dccp_ipsec.sh -6 -p esp -a rmd160 -e serpent -m tunnel -s "100 500 1000"
-dccp6_ipsec36 dccp_ipsec.sh -6 -p esp -m beet -s "100 500 1000"
+dccp6_ipsec01 dccp_ipsec.sh -6 -s 100:500:1000
+dccp6_ipsec02 dccp_ipsec.sh -6 -p ah -m transport -s 100:500:1000
+dccp6_ipsec03 dccp_ipsec.sh -6 -p ah -m tunnel -s 100:500:1000
+dccp6_ipsec04 dccp_ipsec.sh -6 -p esp -m transport -s 100:500:1000
+dccp6_ipsec05 dccp_ipsec.sh -6 -p esp -m tunnel -s 100:500:1000
+dccp6_ipsec06 dccp_ipsec.sh -6 -p comp -m transport -s 100:500:1000
+dccp6_ipsec07 dccp_ipsec.sh -6 -p comp -m tunnel -s 100:500:1000
+dccp6_ipsec08 dccp_ipsec.sh -6 -A rfc4106_128 -p esp_aead -m transport -s 100:500:1000
+dccp6_ipsec09 dccp_ipsec.sh -6 -A rfc4106_128 -p esp_aead -m tunnel -s 100:500:1000
+dccp6_ipsec10 dccp_ipsec.sh -6 -A rfc4106_192 -p esp_aead -m transport -s 100:500:1000
+dccp6_ipsec11 dccp_ipsec.sh -6 -A rfc4106_192 -p esp_aead -m tunnel -s 100:500:1000
+dccp6_ipsec12 dccp_ipsec.sh -6 -A rfc4106_256 -p esp_aead -m transport -s 100:500:1000
+dccp6_ipsec13 dccp_ipsec.sh -6 -A rfc4106_256 -p esp_aead -m tunnel -s 100:500:1000
+dccp6_ipsec14 dccp_ipsec.sh -6 -A rfc4309_128 -p esp_aead -m transport -s 100:500:1000
+dccp6_ipsec15 dccp_ipsec.sh -6 -A rfc4309_128 -p esp_aead -m tunnel -s 100:500:1000
+dccp6_ipsec16 dccp_ipsec.sh -6 -A rfc4309_192 -p esp_aead -m transport -s 100:500:1000
+dccp6_ipsec17 dccp_ipsec.sh -6 -A rfc4309_192 -p esp_aead -m tunnel -s 100:500:1000
+dccp6_ipsec18 dccp_ipsec.sh -6 -A rfc4309_256 -p esp_aead -m transport -s 100:500:1000
+dccp6_ipsec19 dccp_ipsec.sh -6 -A rfc4309_256 -p esp_aead -m tunnel -s 100:500:1000
+dccp6_ipsec20 dccp_ipsec.sh -6 -A rfc4543_128 -p esp_aead -m transport -s 100:500:1000
+dccp6_ipsec21 dccp_ipsec.sh -6 -A rfc4543_128 -p esp_aead -m tunnel -s 100:500:1000
+dccp6_ipsec22 dccp_ipsec.sh -6 -A rfc4543_192 -p esp_aead -m transport -s 100:500:1000
+dccp6_ipsec23 dccp_ipsec.sh -6 -A rfc4543_192 -p esp_aead -m tunnel -s 100:500:1000
+dccp6_ipsec24 dccp_ipsec.sh -6 -A rfc4543_256 -p esp_aead -m transport -s 100:500:1000
+dccp6_ipsec25 dccp_ipsec.sh -6 -A rfc4543_256 -p esp_aead -m tunnel -s 100:500:1000
+dccp6_ipsec26 dccp_ipsec.sh -6 -p esp -a sha1 -e cast5 -m transport -s 100:500:1000
+dccp6_ipsec27 dccp_ipsec.sh -6 -p esp -a sha1 -e cast5 -m tunnel -s 100:500:1000
+dccp6_ipsec28 dccp_ipsec.sh -6 -p esp -a sha256 -e blowfish -m transport -s 100:500:1000
+dccp6_ipsec29 dccp_ipsec.sh -6 -p esp -a sha256 -e blowfish -m tunnel -s 100:500:1000
+dccp6_ipsec30 dccp_ipsec.sh -6 -p esp -a sha384 -e twofish -m transport -s 100:500:1000
+dccp6_ipsec31 dccp_ipsec.sh -6 -p esp -a sha384 -e twofish -m tunnel -s 100:500:1000
+dccp6_ipsec32 dccp_ipsec.sh -6 -p esp -a sha512 -e camellia -m transport -s 100:500:1000
+dccp6_ipsec33 dccp_ipsec.sh -6 -p esp -a sha512 -e camellia -m tunnel -s 100:500:1000
+dccp6_ipsec34 dccp_ipsec.sh -6 -p esp -a rmd160 -e serpent -m transport -s 100:500:1000
+dccp6_ipsec35 dccp_ipsec.sh -6 -p esp -a rmd160 -e serpent -m tunnel -s 100:500:1000
+dccp6_ipsec36 dccp_ipsec.sh -6 -p esp -m beet -s 100:500:1000
 
-dccp4_ipsec_vti01 dccp_ipsec_vti.sh -p ah -m tunnel -s "100 500 1000"
-dccp4_ipsec_vti02 dccp_ipsec_vti.sh -p esp -m tunnel -s "100 500 1000"
-# dccp4_ipsec_vti03 dccp_ipsec_vti.sh -p comp -m tunnel -s "100 500 1000"
-dccp4_ipsec_vti04 dccp_ipsec_vti.sh -A rfc4106_128 -p esp_aead -m tunnel -s "100 500 1000"
-dccp4_ipsec_vti05 dccp_ipsec_vti.sh -A rfc4106_192 -p esp_aead -m tunnel -s "100 500 1000"
-dccp4_ipsec_vti06 dccp_ipsec_vti.sh -A rfc4106_256 -p esp_aead -m tunnel -s "100 500 1000"
-dccp4_ipsec_vti07 dccp_ipsec_vti.sh -A rfc4309_128 -p esp_aead -m tunnel -s "100 500 1000"
-dccp4_ipsec_vti08 dccp_ipsec_vti.sh -A rfc4309_192 -p esp_aead -m tunnel -s "100 500 1000"
-dccp4_ipsec_vti09 dccp_ipsec_vti.sh -A rfc4309_256 -p esp_aead -m tunnel -s "100 500 1000"
-dccp4_ipsec_vti10 dccp_ipsec_vti.sh -A rfc4543_128 -p esp_aead -m tunnel -s "100 500 1000"
-dccp4_ipsec_vti11 dccp_ipsec_vti.sh -A rfc4543_192 -p esp_aead -m tunnel -s "100 500 1000"
-dccp4_ipsec_vti12 dccp_ipsec_vti.sh -A rfc4543_256 -p esp_aead -m tunnel -s "100 500 1000"
-dccp4_ipsec_vti13 dccp_ipsec_vti.sh -p esp -a sha1 -e cast5 -m tunnel -s "100 500 1000"
-dccp4_ipsec_vti14 dccp_ipsec_vti.sh -p esp -a sha256 -e blowfish -m tunnel -s "100 500 1000"
-dccp4_ipsec_vti15 dccp_ipsec_vti.sh -p esp -a sha384 -e twofish -m tunnel -s "100 500 1000"
-dccp4_ipsec_vti16 dccp_ipsec_vti.sh -p esp -a sha512 -e camellia -m tunnel -s "100 500 1000"
-dccp4_ipsec_vti17 dccp_ipsec_vti.sh -p esp -a rmd160 -e serpent -m tunnel -s "100 500 1000"
+dccp4_ipsec_vti01 dccp_ipsec_vti.sh -p ah -m tunnel -s 100:500:1000
+dccp4_ipsec_vti02 dccp_ipsec_vti.sh -p esp -m tunnel -s 100:500:1000
+# dccp4_ipsec_vti03 dccp_ipsec_vti.sh -p comp -m tunnel -s 100:500:1000
+dccp4_ipsec_vti04 dccp_ipsec_vti.sh -A rfc4106_128 -p esp_aead -m tunnel -s 100:500:1000
+dccp4_ipsec_vti05 dccp_ipsec_vti.sh -A rfc4106_192 -p esp_aead -m tunnel -s 100:500:1000
+dccp4_ipsec_vti06 dccp_ipsec_vti.sh -A rfc4106_256 -p esp_aead -m tunnel -s 100:500:1000
+dccp4_ipsec_vti07 dccp_ipsec_vti.sh -A rfc4309_128 -p esp_aead -m tunnel -s 100:500:1000
+dccp4_ipsec_vti08 dccp_ipsec_vti.sh -A rfc4309_192 -p esp_aead -m tunnel -s 100:500:1000
+dccp4_ipsec_vti09 dccp_ipsec_vti.sh -A rfc4309_256 -p esp_aead -m tunnel -s 100:500:1000
+dccp4_ipsec_vti10 dccp_ipsec_vti.sh -A rfc4543_128 -p esp_aead -m tunnel -s 100:500:1000
+dccp4_ipsec_vti11 dccp_ipsec_vti.sh -A rfc4543_192 -p esp_aead -m tunnel -s 100:500:1000
+dccp4_ipsec_vti12 dccp_ipsec_vti.sh -A rfc4543_256 -p esp_aead -m tunnel -s 100:500:1000
+dccp4_ipsec_vti13 dccp_ipsec_vti.sh -p esp -a sha1 -e cast5 -m tunnel -s 100:500:1000
+dccp4_ipsec_vti14 dccp_ipsec_vti.sh -p esp -a sha256 -e blowfish -m tunnel -s 100:500:1000
+dccp4_ipsec_vti15 dccp_ipsec_vti.sh -p esp -a sha384 -e twofish -m tunnel -s 100:500:1000
+dccp4_ipsec_vti16 dccp_ipsec_vti.sh -p esp -a sha512 -e camellia -m tunnel -s 100:500:1000
+dccp4_ipsec_vti17 dccp_ipsec_vti.sh -p esp -a rmd160 -e serpent -m tunnel -s 100:500:1000
 
-dccp6_ipsec_vti01 dccp_ipsec_vti.sh -6 -p ah -m tunnel -s "100 500 1000"
-dccp6_ipsec_vti02 dccp_ipsec_vti.sh -6 -p esp -m tunnel -s "100 500 1000"
-# dccp6_ipsec_vti03 dccp_ipsec_vti.sh -6 -p comp -m tunnel -s "100 500 1000"
-dccp6_ipsec_vti04 dccp_ipsec_vti.sh -6 -A rfc4106_128 -p esp_aead -m tunnel -s "100 500 1000"
-dccp6_ipsec_vti05 dccp_ipsec_vti.sh -6 -A rfc4106_192 -p esp_aead -m tunnel -s "100 500 1000"
-dccp6_ipsec_vti06 dccp_ipsec_vti.sh -6 -A rfc4106_256 -p esp_aead -m tunnel -s "100 500 1000"
-dccp6_ipsec_vti07 dccp_ipsec_vti.sh -6 -A rfc4309_128 -p esp_aead -m tunnel -s "100 500 1000"
-dccp6_ipsec_vti08 dccp_ipsec_vti.sh -6 -A rfc4309_192 -p esp_aead -m tunnel -s "100 500 1000"
-dccp6_ipsec_vti09 dccp_ipsec_vti.sh -6 -A rfc4309_256 -p esp_aead -m tunnel -s "100 500 1000"
-dccp6_ipsec_vti10 dccp_ipsec_vti.sh -6 -A rfc4543_128 -p esp_aead -m tunnel -s "100 500 1000"
-dccp6_ipsec_vti11 dccp_ipsec_vti.sh -6 -A rfc4543_192 -p esp_aead -m tunnel -s "100 500 1000"
-dccp6_ipsec_vti12 dccp_ipsec_vti.sh -6 -A rfc4543_256 -p esp_aead -m tunnel -s "100 500 1000"
-dccp6_ipsec_vti13 dccp_ipsec_vti.sh -6 -p esp -a sha1 -e cast5 -m tunnel -s "100 500 1000"
-dccp6_ipsec_vti14 dccp_ipsec_vti.sh -6 -p esp -a sha256 -e blowfish -m tunnel -s "100 500 1000"
-dccp6_ipsec_vti15 dccp_ipsec_vti.sh -6 -p esp -a sha384 -e twofish -m tunnel -s "100 500 1000"
-dccp6_ipsec_vti16 dccp_ipsec_vti.sh -6 -p esp -a sha512 -e camellia -m tunnel -s "100 500 1000"
-dccp6_ipsec_vti17 dccp_ipsec_vti.sh -6 -p esp -a rmd160 -e serpent -m tunnel -s "100 500 1000"
+dccp6_ipsec_vti01 dccp_ipsec_vti.sh -6 -p ah -m tunnel -s 100:500:1000
+dccp6_ipsec_vti02 dccp_ipsec_vti.sh -6 -p esp -m tunnel -s 100:500:1000
+# dccp6_ipsec_vti03 dccp_ipsec_vti.sh -6 -p comp -m tunnel -s 100:500:1000
+dccp6_ipsec_vti04 dccp_ipsec_vti.sh -6 -A rfc4106_128 -p esp_aead -m tunnel -s 100:500:1000
+dccp6_ipsec_vti05 dccp_ipsec_vti.sh -6 -A rfc4106_192 -p esp_aead -m tunnel -s 100:500:1000
+dccp6_ipsec_vti06 dccp_ipsec_vti.sh -6 -A rfc4106_256 -p esp_aead -m tunnel -s 100:500:1000
+dccp6_ipsec_vti07 dccp_ipsec_vti.sh -6 -A rfc4309_128 -p esp_aead -m tunnel -s 100:500:1000
+dccp6_ipsec_vti08 dccp_ipsec_vti.sh -6 -A rfc4309_192 -p esp_aead -m tunnel -s 100:500:1000
+dccp6_ipsec_vti09 dccp_ipsec_vti.sh -6 -A rfc4309_256 -p esp_aead -m tunnel -s 100:500:1000
+dccp6_ipsec_vti10 dccp_ipsec_vti.sh -6 -A rfc4543_128 -p esp_aead -m tunnel -s 100:500:1000
+dccp6_ipsec_vti11 dccp_ipsec_vti.sh -6 -A rfc4543_192 -p esp_aead -m tunnel -s 100:500:1000
+dccp6_ipsec_vti12 dccp_ipsec_vti.sh -6 -A rfc4543_256 -p esp_aead -m tunnel -s 100:500:1000
+dccp6_ipsec_vti13 dccp_ipsec_vti.sh -6 -p esp -a sha1 -e cast5 -m tunnel -s 100:500:1000
+dccp6_ipsec_vti14 dccp_ipsec_vti.sh -6 -p esp -a sha256 -e blowfish -m tunnel -s 100:500:1000
+dccp6_ipsec_vti15 dccp_ipsec_vti.sh -6 -p esp -a sha384 -e twofish -m tunnel -s 100:500:1000
+dccp6_ipsec_vti16 dccp_ipsec_vti.sh -6 -p esp -a sha512 -e camellia -m tunnel -s 100:500:1000
+dccp6_ipsec_vti17 dccp_ipsec_vti.sh -6 -p esp -a rmd160 -e serpent -m tunnel -s 100:500:1000
diff --git a/runtest/net_stress.ipsec_icmp b/runtest/net_stress.ipsec_icmp
index 0267cf660..58c0924a4 100644
--- a/runtest/net_stress.ipsec_icmp
+++ b/runtest/net_stress.ipsec_icmp
@@ -27,93 +27,93 @@
 # IPsec compression: same message size but different content will result in different data size
 # after compression. So we just use a large enough message size(65000) for testing
 
-icmp4-uni-basic01 icmp-uni-basic.sh -s "10 100 1000 10000 65507"
-icmp4-uni-basic02 icmp-uni-basic.sh -p ah -m transport -s "10 100 1000 10000 65483"
-icmp4-uni-basic03 icmp-uni-basic.sh -p ah -m tunnel -s "10 100 1000 10000 65463"
-icmp4-uni-basic04 icmp-uni-basic.sh -p esp -m transport -s "10 100 1000 10000 65470"
-icmp4-uni-basic05 icmp-uni-basic.sh -p esp -m tunnel -s "10 100 1000 10000 65450"
-icmp4-uni-basic06 icmp-uni-basic.sh -p comp -m transport -s "10 100 1000 10000 65000"
-icmp4-uni-basic07 icmp-uni-basic.sh -p comp -m tunnel -s "10 100 1000 10000 65000"
-icmp4-uni-basic08 icmp-uni-basic.sh -A rfc4106_128 -p esp_aead -m transport -s "10 100 1000 10000 65470"
-icmp4-uni-basic09 icmp-uni-basic.sh -A rfc4106_192 -p esp_aead -m transport -s "10 100 1000 10000 65470"
-icmp4-uni-basic10 icmp-uni-basic.sh -A rfc4106_256 -p esp_aead -m transport -s "10 100 1000 10000 65470"
-icmp4-uni-basic11 icmp-uni-basic.sh -A rfc4309_128 -p esp_aead -m transport -s "10 100 1000 10000 65470"
-icmp4-uni-basic12 icmp-uni-basic.sh -A rfc4309_192 -p esp_aead -m transport -s "10 100 1000 10000 65470"
-icmp4-uni-basic13 icmp-uni-basic.sh -A rfc4309_256 -p esp_aead -m transport -s "10 100 1000 10000 65470"
-icmp4-uni-basic14 icmp-uni-basic.sh -A rfc4543_128 -p esp_aead -m transport -s "10 100 1000 10000 65470"
-icmp4-uni-basic15 icmp-uni-basic.sh -A rfc4543_192 -p esp_aead -m transport -s "10 100 1000 10000 65470"
-icmp4-uni-basic16 icmp-uni-basic.sh -A rfc4543_256 -p esp_aead -m transport -s "10 100 1000 10000 65470"
-icmp4-uni-basic17 icmp-uni-basic.sh -A rfc4106_128 -p esp_aead -m tunnel -s "10 100 1000 10000 65450"
-icmp4-uni-basic18 icmp-uni-basic.sh -A rfc4106_192 -p esp_aead -m tunnel -s "10 100 1000 10000 65450"
-icmp4-uni-basic19 icmp-uni-basic.sh -A rfc4106_256 -p esp_aead -m tunnel -s "10 100 1000 10000 65450"
-icmp4-uni-basic20 icmp-uni-basic.sh -A rfc4309_128 -p esp_aead -m tunnel -s "10 100 1000 10000 65450"
-icmp4-uni-basic21 icmp-uni-basic.sh -A rfc4309_192 -p esp_aead -m tunnel -s "10 100 1000 10000 65450"
-icmp4-uni-basic22 icmp-uni-basic.sh -A rfc4309_256 -p esp_aead -m tunnel -s "10 100 1000 10000 65450"
-icmp4-uni-basic23 icmp-uni-basic.sh -A rfc4543_128 -p esp_aead -m tunnel -s "10 100 1000 10000 65450"
-icmp4-uni-basic24 icmp-uni-basic.sh -A rfc4543_192 -p esp_aead -m tunnel -s "10 100 1000 10000 65450"
-icmp4-uni-basic25 icmp-uni-basic.sh -A rfc4543_256 -p esp_aead -m tunnel -s "10 100 1000 10000 65450"
-icmp4-uni-basic26 icmp-uni-basic.sh -p esp -m beet -s "10 100 1000 10000 65470"
+icmp4-uni-basic01 icmp-uni-basic.sh -s 10:100:1000:10000:65507
+icmp4-uni-basic02 icmp-uni-basic.sh -p ah -m transport -s 10:100:1000:10000:65483
+icmp4-uni-basic03 icmp-uni-basic.sh -p ah -m tunnel -s 10:100:1000:10000:65463
+icmp4-uni-basic04 icmp-uni-basic.sh -p esp -m transport -s 10:100:1000:10000:65470
+icmp4-uni-basic05 icmp-uni-basic.sh -p esp -m tunnel -s 10:100:1000:10000:65450
+icmp4-uni-basic06 icmp-uni-basic.sh -p comp -m transport -s 10:100:1000:10000:65000
+icmp4-uni-basic07 icmp-uni-basic.sh -p comp -m tunnel -s 10:100:1000:10000:65000
+icmp4-uni-basic08 icmp-uni-basic.sh -A rfc4106_128 -p esp_aead -m transport -s 10:100:1000:10000:65470
+icmp4-uni-basic09 icmp-uni-basic.sh -A rfc4106_192 -p esp_aead -m transport -s 10:100:1000:10000:65470
+icmp4-uni-basic10 icmp-uni-basic.sh -A rfc4106_256 -p esp_aead -m transport -s 10:100:1000:10000:65470
+icmp4-uni-basic11 icmp-uni-basic.sh -A rfc4309_128 -p esp_aead -m transport -s 10:100:1000:10000:65470
+icmp4-uni-basic12 icmp-uni-basic.sh -A rfc4309_192 -p esp_aead -m transport -s 10:100:1000:10000:65470
+icmp4-uni-basic13 icmp-uni-basic.sh -A rfc4309_256 -p esp_aead -m transport -s 10:100:1000:10000:65470
+icmp4-uni-basic14 icmp-uni-basic.sh -A rfc4543_128 -p esp_aead -m transport -s 10:100:1000:10000:65470
+icmp4-uni-basic15 icmp-uni-basic.sh -A rfc4543_192 -p esp_aead -m transport -s 10:100:1000:10000:65470
+icmp4-uni-basic16 icmp-uni-basic.sh -A rfc4543_256 -p esp_aead -m transport -s 10:100:1000:10000:65470
+icmp4-uni-basic17 icmp-uni-basic.sh -A rfc4106_128 -p esp_aead -m tunnel -s 10:100:1000:10000:65450
+icmp4-uni-basic18 icmp-uni-basic.sh -A rfc4106_192 -p esp_aead -m tunnel -s 10:100:1000:10000:65450
+icmp4-uni-basic19 icmp-uni-basic.sh -A rfc4106_256 -p esp_aead -m tunnel -s 10:100:1000:10000:65450
+icmp4-uni-basic20 icmp-uni-basic.sh -A rfc4309_128 -p esp_aead -m tunnel -s 10:100:1000:10000:65450
+icmp4-uni-basic21 icmp-uni-basic.sh -A rfc4309_192 -p esp_aead -m tunnel -s 10:100:1000:10000:65450
+icmp4-uni-basic22 icmp-uni-basic.sh -A rfc4309_256 -p esp_aead -m tunnel -s 10:100:1000:10000:65450
+icmp4-uni-basic23 icmp-uni-basic.sh -A rfc4543_128 -p esp_aead -m tunnel -s 10:100:1000:10000:65450
+icmp4-uni-basic24 icmp-uni-basic.sh -A rfc4543_192 -p esp_aead -m tunnel -s 10:100:1000:10000:65450
+icmp4-uni-basic25 icmp-uni-basic.sh -A rfc4543_256 -p esp_aead -m tunnel -s 10:100:1000:10000:65450
+icmp4-uni-basic26 icmp-uni-basic.sh -p esp -m beet -s 10:100:1000:10000:65470
 
-icmp6-uni-basic01 icmp-uni-basic.sh -6 -s "10 100 1000 10000 65527"
-icmp6-uni-basic02 icmp-uni-basic.sh -6 -p ah -m transport -s "10 100 1000 10000 65503"
-icmp6-uni-basic03 icmp-uni-basic.sh -6 -p ah -m tunnel -s "10 100 1000 10000 65527"
-icmp6-uni-basic04 icmp-uni-basic.sh -6 -p esp -m transport -s "10 100 1000 10000 65490"
-icmp6-uni-basic05 icmp-uni-basic.sh -6 -p esp -m tunnel -s "10 100 1000 10000 65527"
-icmp6-uni-basic06 icmp-uni-basic.sh -6 -p comp -m transport -s "10 100 1000 10000 65000"
-icmp6-uni-basic07 icmp-uni-basic.sh -6 -p comp -m tunnel -s "10 100 1000 10000 65000"
-icmp6-uni-basic08 icmp-uni-basic.sh -6 -A rfc4106_128 -p esp_aead -m transport -s "10 100 1000 10000 65490"
-icmp6-uni-basic09 icmp-uni-basic.sh -6 -A rfc4106_192 -p esp_aead -m transport -s "10 100 1000 10000 65490"
-icmp6-uni-basic10 icmp-uni-basic.sh -6 -A rfc4106_256 -p esp_aead -m transport -s "10 100 1000 10000 65490"
-icmp6-uni-basic11 icmp-uni-basic.sh -6 -A rfc4309_128 -p esp_aead -m transport -s "10 100 1000 10000 65490"
-icmp6-uni-basic12 icmp-uni-basic.sh -6 -A rfc4309_192 -p esp_aead -m transport -s "10 100 1000 10000 65490"
-icmp6-uni-basic13 icmp-uni-basic.sh -6 -A rfc4309_256 -p esp_aead -m transport -s "10 100 1000 10000 65490"
-icmp6-uni-basic14 icmp-uni-basic.sh -6 -A rfc4543_128 -p esp_aead -m transport -s "10 100 1000 10000 65490"
-icmp6-uni-basic15 icmp-uni-basic.sh -6 -A rfc4543_192 -p esp_aead -m transport -s "10 100 1000 10000 65490"
-icmp6-uni-basic16 icmp-uni-basic.sh -6 -A rfc4543_256 -p esp_aead -m transport -s "10 100 1000 10000 65490"
-icmp6-uni-basic17 icmp-uni-basic.sh -6 -A rfc4106_128 -p esp_aead -m tunnel -s "10 100 1000 10000 65527"
-icmp6-uni-basic18 icmp-uni-basic.sh -6 -A rfc4106_192 -p esp_aead -m tunnel -s "10 100 1000 10000 65527"
-icmp6-uni-basic19 icmp-uni-basic.sh -6 -A rfc4106_256 -p esp_aead -m tunnel -s "10 100 1000 10000 65527"
-icmp6-uni-basic20 icmp-uni-basic.sh -6 -A rfc4309_128 -p esp_aead -m tunnel -s "10 100 1000 10000 65527"
-icmp6-uni-basic21 icmp-uni-basic.sh -6 -A rfc4309_192 -p esp_aead -m tunnel -s "10 100 1000 10000 65527"
-icmp6-uni-basic22 icmp-uni-basic.sh -6 -A rfc4309_256 -p esp_aead -m tunnel -s "10 100 1000 10000 65527"
-icmp6-uni-basic23 icmp-uni-basic.sh -6 -A rfc4543_128 -p esp_aead -m tunnel -s "10 100 1000 10000 65527"
-icmp6-uni-basic24 icmp-uni-basic.sh -6 -A rfc4543_192 -p esp_aead -m tunnel -s "10 100 1000 10000 65527"
-icmp6-uni-basic25 icmp-uni-basic.sh -6 -A rfc4543_256 -p esp_aead -m tunnel -s "10 100 1000 10000 65527"
-icmp6-uni-basic26 icmp-uni-basic.sh -6 -p esp -m beet -s "10 100 1000 10000 65490"
+icmp6-uni-basic01 icmp-uni-basic.sh -6 -s 10:100:1000:10000:65527
+icmp6-uni-basic02 icmp-uni-basic.sh -6 -p ah -m transport -s 10:100:1000:10000:65503
+icmp6-uni-basic03 icmp-uni-basic.sh -6 -p ah -m tunnel -s 10:100:1000:10000:65527
+icmp6-uni-basic04 icmp-uni-basic.sh -6 -p esp -m transport -s 10:100:1000:10000:65490
+icmp6-uni-basic05 icmp-uni-basic.sh -6 -p esp -m tunnel -s 10:100:1000:10000:65527
+icmp6-uni-basic06 icmp-uni-basic.sh -6 -p comp -m transport -s 10:100:1000:10000:65000
+icmp6-uni-basic07 icmp-uni-basic.sh -6 -p comp -m tunnel -s 10:100:1000:10000:65000
+icmp6-uni-basic08 icmp-uni-basic.sh -6 -A rfc4106_128 -p esp_aead -m transport -s 10:100:1000:10000:65490
+icmp6-uni-basic09 icmp-uni-basic.sh -6 -A rfc4106_192 -p esp_aead -m transport -s 10:100:1000:10000:65490
+icmp6-uni-basic10 icmp-uni-basic.sh -6 -A rfc4106_256 -p esp_aead -m transport -s 10:100:1000:10000:65490
+icmp6-uni-basic11 icmp-uni-basic.sh -6 -A rfc4309_128 -p esp_aead -m transport -s 10:100:1000:10000:65490
+icmp6-uni-basic12 icmp-uni-basic.sh -6 -A rfc4309_192 -p esp_aead -m transport -s 10:100:1000:10000:65490
+icmp6-uni-basic13 icmp-uni-basic.sh -6 -A rfc4309_256 -p esp_aead -m transport -s 10:100:1000:10000:65490
+icmp6-uni-basic14 icmp-uni-basic.sh -6 -A rfc4543_128 -p esp_aead -m transport -s 10:100:1000:10000:65490
+icmp6-uni-basic15 icmp-uni-basic.sh -6 -A rfc4543_192 -p esp_aead -m transport -s 10:100:1000:10000:65490
+icmp6-uni-basic16 icmp-uni-basic.sh -6 -A rfc4543_256 -p esp_aead -m transport -s 10:100:1000:10000:65490
+icmp6-uni-basic17 icmp-uni-basic.sh -6 -A rfc4106_128 -p esp_aead -m tunnel -s 10:100:1000:10000:65527
+icmp6-uni-basic18 icmp-uni-basic.sh -6 -A rfc4106_192 -p esp_aead -m tunnel -s 10:100:1000:10000:65527
+icmp6-uni-basic19 icmp-uni-basic.sh -6 -A rfc4106_256 -p esp_aead -m tunnel -s 10:100:1000:10000:65527
+icmp6-uni-basic20 icmp-uni-basic.sh -6 -A rfc4309_128 -p esp_aead -m tunnel -s 10:100:1000:10000:65527
+icmp6-uni-basic21 icmp-uni-basic.sh -6 -A rfc4309_192 -p esp_aead -m tunnel -s 10:100:1000:10000:65527
+icmp6-uni-basic22 icmp-uni-basic.sh -6 -A rfc4309_256 -p esp_aead -m tunnel -s 10:100:1000:10000:65527
+icmp6-uni-basic23 icmp-uni-basic.sh -6 -A rfc4543_128 -p esp_aead -m tunnel -s 10:100:1000:10000:65527
+icmp6-uni-basic24 icmp-uni-basic.sh -6 -A rfc4543_192 -p esp_aead -m tunnel -s 10:100:1000:10000:65527
+icmp6-uni-basic25 icmp-uni-basic.sh -6 -A rfc4543_256 -p esp_aead -m tunnel -s 10:100:1000:10000:65527
+icmp6-uni-basic26 icmp-uni-basic.sh -6 -p esp -m beet -s 10:100:1000:10000:65490
 
-icmp4-uni-vti01 icmp-uni-vti.sh -p ah -a sha256 -m tunnel -S fffffffe -k 1 -s "10 100 1000 10000 65463"
-icmp4-uni-vti02 icmp-uni-vti.sh -p esp -a sha512 -e des -m tunnel -S fffffffe -k 2 -s "10 100 1000 10000 65450"
-icmp4-uni-vti03 icmp-uni-vti.sh -p esp -a rmd160 -e cast5 -m tunnel -S fffffffe -k 0xffffffff -s "10 100 1000 10000 65463"
-icmp4-uni-vti04 icmp-uni-vti.sh -p esp -e blowfish -m tunnel -S fffffffe -k 3 -s "10 100 1000 10000 65463"
-icmp4-uni-vti05 icmp-uni-vti.sh -p esp -a sha512 -e twofish -m tunnel -S fffffffe -k 0x7fffffff -s "10 100 1000 10000 65463"
-icmp4-uni-vti06 icmp-uni-vti.sh -p esp -a sha384 -e camellia -m tunnel -S fffffffe -k 0x80000000 -s "10 100 1000 10000 65463"
-icmp4-uni-vti07 icmp-uni-vti.sh -p esp -a sha512 -e serpent -m tunnel -S fffffffe -k 0xffff -s "10 100 1000 10000 65463"
-icmp4-uni-vti08 icmp-uni-vti.sh -A rfc4106_128 -p esp_aead -m tunnel -s "10 100 1000 10000 65463"
-icmp4-uni-vti09 icmp-uni-vti.sh -A rfc4106_192 -p esp_aead -m tunnel -s "10 100 1000 10000 65463"
-icmp4-uni-vti10 icmp-uni-vti.sh -A rfc4106_256 -p esp_aead -m tunnel -s "10 100 1000 10000 65463"
-icmp4-uni-vti11 icmp-uni-vti.sh -A rfc4309_128 -p esp_aead -m tunnel -s "10 100 1000 10000 65463"
-icmp4-uni-vti12 icmp-uni-vti.sh -A rfc4309_192 -p esp_aead -m tunnel -s "10 100 1000 10000 65463"
-icmp4-uni-vti13 icmp-uni-vti.sh -A rfc4309_256 -p esp_aead -m tunnel -s "10 100 1000 10000 65463"
-icmp4-uni-vti14 icmp-uni-vti.sh -A rfc4543_128 -p esp_aead -m tunnel -s "10 100 1000 10000 65463"
-icmp4-uni-vti15 icmp-uni-vti.sh -A rfc4543_192 -p esp_aead -m tunnel -s "10 100 1000 10000 65463"
-icmp4-uni-vti16 icmp-uni-vti.sh -A rfc4543_256 -p esp_aead -m tunnel -s "10 100 1000 10000 65463"
+icmp4-uni-vti01 icmp-uni-vti.sh -p ah -a sha256 -m tunnel -S fffffffe -k 1 -s 10:100:1000:10000:65463
+icmp4-uni-vti02 icmp-uni-vti.sh -p esp -a sha512 -e des -m tunnel -S fffffffe -k 2 -s 10:100:1000:10000:65450
+icmp4-uni-vti03 icmp-uni-vti.sh -p esp -a rmd160 -e cast5 -m tunnel -S fffffffe -k 0xffffffff -s 10:100:1000:10000:65463
+icmp4-uni-vti04 icmp-uni-vti.sh -p esp -e blowfish -m tunnel -S fffffffe -k 3 -s 10:100:1000:10000:65463
+icmp4-uni-vti05 icmp-uni-vti.sh -p esp -a sha512 -e twofish -m tunnel -S fffffffe -k 0x7fffffff -s 10:100:1000:10000:65463
+icmp4-uni-vti06 icmp-uni-vti.sh -p esp -a sha384 -e camellia -m tunnel -S fffffffe -k 0x80000000 -s 10:100:1000:10000:65463
+icmp4-uni-vti07 icmp-uni-vti.sh -p esp -a sha512 -e serpent -m tunnel -S fffffffe -k 0xffff -s 10:100:1000:10000:65463
+icmp4-uni-vti08 icmp-uni-vti.sh -A rfc4106_128 -p esp_aead -m tunnel -s 10:100:1000:10000:65463
+icmp4-uni-vti09 icmp-uni-vti.sh -A rfc4106_192 -p esp_aead -m tunnel -s 10:100:1000:10000:65463
+icmp4-uni-vti10 icmp-uni-vti.sh -A rfc4106_256 -p esp_aead -m tunnel -s 10:100:1000:10000:65463
+icmp4-uni-vti11 icmp-uni-vti.sh -A rfc4309_128 -p esp_aead -m tunnel -s 10:100:1000:10000:65463
+icmp4-uni-vti12 icmp-uni-vti.sh -A rfc4309_192 -p esp_aead -m tunnel -s 10:100:1000:10000:65463
+icmp4-uni-vti13 icmp-uni-vti.sh -A rfc4309_256 -p esp_aead -m tunnel -s 10:100:1000:10000:65463
+icmp4-uni-vti14 icmp-uni-vti.sh -A rfc4543_128 -p esp_aead -m tunnel -s 10:100:1000:10000:65463
+icmp4-uni-vti15 icmp-uni-vti.sh -A rfc4543_192 -p esp_aead -m tunnel -s 10:100:1000:10000:65463
+icmp4-uni-vti16 icmp-uni-vti.sh -A rfc4543_256 -p esp_aead -m tunnel -s 10:100:1000:10000:65463
 icmp4-uni-vti17 icmp-uni-vti.sh -p comp -m tunnel -s 1000
 
-icmp6-uni-vti01 icmp-uni-vti.sh -6 -p ah -m tunnel -S fffffffe -k 0xffffffff -s "10 100 1000 10000 65527"
-icmp6-uni-vti02 icmp-uni-vti.sh -6 -p esp -a sha256 -e des3_ede -m tunnel -S fffffffe -k 0xffffffff -s "10 100 1000 10000 65527"
-icmp6-uni-vti03 icmp-uni-vti.sh -6 -p esp -a sha512 -e cast5 -m tunnel -S fffffffe -k 1 -s "10 100 1000 10000 65527"
-icmp6-uni-vti04 icmp-uni-vti.sh -6 -p esp -a rmd160 -e blowfish -m tunnel -S fffffffe -k 0x80000000 -s "10 100 1000 10000 65527"
-icmp6-uni-vti05 icmp-uni-vti.sh -6 -p esp -e twofish -m tunnel -S fffffffe -k 0xffff -s "10 100 1000 10000 65527"
-icmp6-uni-vti06 icmp-uni-vti.sh -6 -p esp -a sha512 -e camellia -m tunnel -S fffffffe -k 0x7fffffff -s "10 100 1000 10000 65527"
-icmp6-uni-vti07 icmp-uni-vti.sh -6 -p esp -a sha384 -e serpent -m tunnel -S ffffffff -k 0x11111111 -s "10 100 1000 10000 65527"
-icmp6-uni-vti08 icmp-uni-vti.sh -6 -A rfc4106_128 -p esp_aead -m tunnel -s "10 100 1000 10000 65527"
-icmp6-uni-vti09 icmp-uni-vti.sh -6 -A rfc4106_192 -p esp_aead -m tunnel -s "10 100 1000 10000 65527"
-icmp6-uni-vti10 icmp-uni-vti.sh -6 -A rfc4106_256 -p esp_aead -m tunnel -s "10 100 1000 10000 65527"
-icmp6-uni-vti11 icmp-uni-vti.sh -6 -A rfc4309_128 -p esp_aead -m tunnel -s "10 100 1000 10000 65527"
-icmp6-uni-vti12 icmp-uni-vti.sh -6 -A rfc4309_192 -p esp_aead -m tunnel -s "10 100 1000 10000 65527"
-icmp6-uni-vti13 icmp-uni-vti.sh -6 -A rfc4309_256 -p esp_aead -m tunnel -s "10 100 1000 10000 65527"
-icmp6-uni-vti14 icmp-uni-vti.sh -6 -A rfc4543_128 -p esp_aead -m tunnel -s "10 100 1000 10000 65527"
-icmp6-uni-vti15 icmp-uni-vti.sh -6 -A rfc4543_192 -p esp_aead -m tunnel -s "10 100 1000 10000 65527"
-icmp6-uni-vti16 icmp-uni-vti.sh -6 -A rfc4543_256 -p esp_aead -m tunnel -s "10 100 1000 10000 65527"
+icmp6-uni-vti01 icmp-uni-vti.sh -6 -p ah -m tunnel -S fffffffe -k 0xffffffff -s 10:100:1000:10000:65527
+icmp6-uni-vti02 icmp-uni-vti.sh -6 -p esp -a sha256 -e des3_ede -m tunnel -S fffffffe -k 0xffffffff -s 10:100:1000:10000:65527
+icmp6-uni-vti03 icmp-uni-vti.sh -6 -p esp -a sha512 -e cast5 -m tunnel -S fffffffe -k 1 -s 10:100:1000:10000:65527
+icmp6-uni-vti04 icmp-uni-vti.sh -6 -p esp -a rmd160 -e blowfish -m tunnel -S fffffffe -k 0x80000000 -s 10:100:1000:10000:65527
+icmp6-uni-vti05 icmp-uni-vti.sh -6 -p esp -e twofish -m tunnel -S fffffffe -k 0xffff -s 10:100:1000:10000:65527
+icmp6-uni-vti06 icmp-uni-vti.sh -6 -p esp -a sha512 -e camellia -m tunnel -S fffffffe -k 0x7fffffff -s 10:100:1000:10000:65527
+icmp6-uni-vti07 icmp-uni-vti.sh -6 -p esp -a sha384 -e serpent -m tunnel -S ffffffff -k 0x11111111 -s 10:100:1000:10000:65527
+icmp6-uni-vti08 icmp-uni-vti.sh -6 -A rfc4106_128 -p esp_aead -m tunnel -s 10:100:1000:10000:65527
+icmp6-uni-vti09 icmp-uni-vti.sh -6 -A rfc4106_192 -p esp_aead -m tunnel -s 10:100:1000:10000:65527
+icmp6-uni-vti10 icmp-uni-vti.sh -6 -A rfc4106_256 -p esp_aead -m tunnel -s 10:100:1000:10000:65527
+icmp6-uni-vti11 icmp-uni-vti.sh -6 -A rfc4309_128 -p esp_aead -m tunnel -s 10:100:1000:10000:65527
+icmp6-uni-vti12 icmp-uni-vti.sh -6 -A rfc4309_192 -p esp_aead -m tunnel -s 10:100:1000:10000:65527
+icmp6-uni-vti13 icmp-uni-vti.sh -6 -A rfc4309_256 -p esp_aead -m tunnel -s 10:100:1000:10000:65527
+icmp6-uni-vti14 icmp-uni-vti.sh -6 -A rfc4543_128 -p esp_aead -m tunnel -s 10:100:1000:10000:65527
+icmp6-uni-vti15 icmp-uni-vti.sh -6 -A rfc4543_192 -p esp_aead -m tunnel -s 10:100:1000:10000:65527
+icmp6-uni-vti16 icmp-uni-vti.sh -6 -A rfc4543_256 -p esp_aead -m tunnel -s 10:100:1000:10000:65527
 icmp6-uni-vti17 icmp-uni-vti.sh -6 -p comp -m tunnel -s 1000
 
diff --git a/runtest/net_stress.ipsec_sctp b/runtest/net_stress.ipsec_sctp
index e71f951c4..a2453fefd 100644
--- a/runtest/net_stress.ipsec_sctp
+++ b/runtest/net_stress.ipsec_sctp
@@ -1,109 +1,109 @@
-sctp4_ipsec01 sctp_ipsec.sh -s "100 1000 65535"
-sctp4_ipsec02 sctp_ipsec.sh -p ah -m transport -s "100 1000 65535"
-sctp4_ipsec03 sctp_ipsec.sh -p ah -m tunnel -s "100 1000 65535"
-sctp4_ipsec04 sctp_ipsec.sh -p esp -m transport -s "100 1000 65535"
-sctp4_ipsec05 sctp_ipsec.sh -p esp -m tunnel -s "100 1000 65535"
-sctp4_ipsec06 sctp_ipsec.sh -p comp -m transport -s "100 1000 65535"
-sctp4_ipsec07 sctp_ipsec.sh -p comp -m tunnel -s "100 1000 65535"
-sctp4_ipsec08 sctp_ipsec.sh -A rfc4106_128 -p esp_aead -m transport -s "100 1000 65535"
-sctp4_ipsec09 sctp_ipsec.sh -A rfc4106_128 -p esp_aead -m tunnel -s "100 1000 65535"
-sctp4_ipsec10 sctp_ipsec.sh -A rfc4106_192 -p esp_aead -m transport -s "100 1000 65535"
-sctp4_ipsec11 sctp_ipsec.sh -A rfc4106_192 -p esp_aead -m tunnel -s "100 1000 65535"
-sctp4_ipsec12 sctp_ipsec.sh -A rfc4106_256 -p esp_aead -m transport -s "100 1000 65535"
-sctp4_ipsec13 sctp_ipsec.sh -A rfc4106_256 -p esp_aead -m tunnel -s "100 1000 65535"
-sctp4_ipsec14 sctp_ipsec.sh -A rfc4309_128 -p esp_aead -m transport -s "100 1000 65535"
-sctp4_ipsec15 sctp_ipsec.sh -A rfc4309_128 -p esp_aead -m tunnel -s "100 1000 65535"
-sctp4_ipsec16 sctp_ipsec.sh -A rfc4309_192 -p esp_aead -m transport -s "100 1000 65535"
-sctp4_ipsec17 sctp_ipsec.sh -A rfc4309_192 -p esp_aead -m tunnel -s "100 1000 65535"
-sctp4_ipsec18 sctp_ipsec.sh -A rfc4309_256 -p esp_aead -m transport -s "100 1000 65535"
-sctp4_ipsec19 sctp_ipsec.sh -A rfc4309_256 -p esp_aead -m tunnel -s "100 1000 65535"
-sctp4_ipsec20 sctp_ipsec.sh -A rfc4543_128 -p esp_aead -m transport -s "100 1000 65535"
-sctp4_ipsec21 sctp_ipsec.sh -A rfc4543_128 -p esp_aead -m tunnel -s "100 1000 65535"
-sctp4_ipsec22 sctp_ipsec.sh -A rfc4543_192 -p esp_aead -m transport -s "100 1000 65535"
-sctp4_ipsec23 sctp_ipsec.sh -A rfc4543_192 -p esp_aead -m tunnel -s "100 1000 65535"
-sctp4_ipsec24 sctp_ipsec.sh -A rfc4543_256 -p esp_aead -m transport -s "100 1000 65535"
-sctp4_ipsec25 sctp_ipsec.sh -A rfc4543_256 -p esp_aead -m tunnel -s "100 1000 65535"
-sctp4_ipsec26 sctp_ipsec.sh -p esp -a sha1 -e cast5 -m transport -s "100 1000 65535"
-sctp4_ipsec27 sctp_ipsec.sh -p esp -a sha1 -e cast5 -m tunnel -s "100 1000 65535"
-sctp4_ipsec28 sctp_ipsec.sh -p esp -a sha256 -e blowfish -m transport -s "100 1000 65535"
-sctp4_ipsec29 sctp_ipsec.sh -p esp -a sha256 -e blowfish -m tunnel -s "100 1000 65535"
-sctp4_ipsec30 sctp_ipsec.sh -p esp -a sha384 -e twofish -m transport -s "100 1000 65535"
-sctp4_ipsec31 sctp_ipsec.sh -p esp -a sha384 -e twofish -m tunnel -s "100 1000 65535"
-sctp4_ipsec32 sctp_ipsec.sh -p esp -a sha512 -e camellia -m transport -s "100 1000 65535"
-sctp4_ipsec33 sctp_ipsec.sh -p esp -a sha512 -e camellia -m tunnel -s "100 1000 65535"
-sctp4_ipsec34 sctp_ipsec.sh -p esp -a rmd160 -e serpent -m transport -s "100 1000 65535"
-sctp4_ipsec35 sctp_ipsec.sh -p esp -a rmd160 -e serpent -m tunnel -s "100 1000 65535"
-sctp4_ipsec36 sctp_ipsec.sh -p esp -m beet -s "100 1000 65535"
+sctp4_ipsec01 sctp_ipsec.sh -s 100:1000:65535
+sctp4_ipsec02 sctp_ipsec.sh -p ah -m transport -s 100:1000:65535
+sctp4_ipsec03 sctp_ipsec.sh -p ah -m tunnel -s 100:1000:65535
+sctp4_ipsec04 sctp_ipsec.sh -p esp -m transport -s 100:1000:65535
+sctp4_ipsec05 sctp_ipsec.sh -p esp -m tunnel -s 100:1000:65535
+sctp4_ipsec06 sctp_ipsec.sh -p comp -m transport -s 100:1000:65535
+sctp4_ipsec07 sctp_ipsec.sh -p comp -m tunnel -s 100:1000:65535
+sctp4_ipsec08 sctp_ipsec.sh -A rfc4106_128 -p esp_aead -m transport -s 100:1000:65535
+sctp4_ipsec09 sctp_ipsec.sh -A rfc4106_128 -p esp_aead -m tunnel -s 100:1000:65535
+sctp4_ipsec10 sctp_ipsec.sh -A rfc4106_192 -p esp_aead -m transport -s 100:1000:65535
+sctp4_ipsec11 sctp_ipsec.sh -A rfc4106_192 -p esp_aead -m tunnel -s 100:1000:65535
+sctp4_ipsec12 sctp_ipsec.sh -A rfc4106_256 -p esp_aead -m transport -s 100:1000:65535
+sctp4_ipsec13 sctp_ipsec.sh -A rfc4106_256 -p esp_aead -m tunnel -s 100:1000:65535
+sctp4_ipsec14 sctp_ipsec.sh -A rfc4309_128 -p esp_aead -m transport -s 100:1000:65535
+sctp4_ipsec15 sctp_ipsec.sh -A rfc4309_128 -p esp_aead -m tunnel -s 100:1000:65535
+sctp4_ipsec16 sctp_ipsec.sh -A rfc4309_192 -p esp_aead -m transport -s 100:1000:65535
+sctp4_ipsec17 sctp_ipsec.sh -A rfc4309_192 -p esp_aead -m tunnel -s 100:1000:65535
+sctp4_ipsec18 sctp_ipsec.sh -A rfc4309_256 -p esp_aead -m transport -s 100:1000:65535
+sctp4_ipsec19 sctp_ipsec.sh -A rfc4309_256 -p esp_aead -m tunnel -s 100:1000:65535
+sctp4_ipsec20 sctp_ipsec.sh -A rfc4543_128 -p esp_aead -m transport -s 100:1000:65535
+sctp4_ipsec21 sctp_ipsec.sh -A rfc4543_128 -p esp_aead -m tunnel -s 100:1000:65535
+sctp4_ipsec22 sctp_ipsec.sh -A rfc4543_192 -p esp_aead -m transport -s 100:1000:65535
+sctp4_ipsec23 sctp_ipsec.sh -A rfc4543_192 -p esp_aead -m tunnel -s 100:1000:65535
+sctp4_ipsec24 sctp_ipsec.sh -A rfc4543_256 -p esp_aead -m transport -s 100:1000:65535
+sctp4_ipsec25 sctp_ipsec.sh -A rfc4543_256 -p esp_aead -m tunnel -s 100:1000:65535
+sctp4_ipsec26 sctp_ipsec.sh -p esp -a sha1 -e cast5 -m transport -s 100:1000:65535
+sctp4_ipsec27 sctp_ipsec.sh -p esp -a sha1 -e cast5 -m tunnel -s 100:1000:65535
+sctp4_ipsec28 sctp_ipsec.sh -p esp -a sha256 -e blowfish -m transport -s 100:1000:65535
+sctp4_ipsec29 sctp_ipsec.sh -p esp -a sha256 -e blowfish -m tunnel -s 100:1000:65535
+sctp4_ipsec30 sctp_ipsec.sh -p esp -a sha384 -e twofish -m transport -s 100:1000:65535
+sctp4_ipsec31 sctp_ipsec.sh -p esp -a sha384 -e twofish -m tunnel -s 100:1000:65535
+sctp4_ipsec32 sctp_ipsec.sh -p esp -a sha512 -e camellia -m transport -s 100:1000:65535
+sctp4_ipsec33 sctp_ipsec.sh -p esp -a sha512 -e camellia -m tunnel -s 100:1000:65535
+sctp4_ipsec34 sctp_ipsec.sh -p esp -a rmd160 -e serpent -m transport -s 100:1000:65535
+sctp4_ipsec35 sctp_ipsec.sh -p esp -a rmd160 -e serpent -m tunnel -s 100:1000:65535
+sctp4_ipsec36 sctp_ipsec.sh -p esp -m beet -s 100:1000:65535
 
-sctp6_ipsec01 sctp_ipsec.sh -6 -s "100 1000 65535"
-sctp6_ipsec02 sctp_ipsec.sh -6 -p ah -m transport -s "100 1000 65535"
-sctp6_ipsec03 sctp_ipsec.sh -6 -p ah -m tunnel -s "100 1000 65535"
-sctp6_ipsec04 sctp_ipsec.sh -6 -p esp -m transport -s "100 1000 65535"
-sctp6_ipsec05 sctp_ipsec.sh -6 -p esp -m tunnel -s "100 1000 65535"
-sctp6_ipsec06 sctp_ipsec.sh -6 -p comp -m transport -s "100 1000 65535"
-sctp6_ipsec07 sctp_ipsec.sh -6 -p comp -m tunnel -s "100 1000 65535"
-sctp6_ipsec08 sctp_ipsec.sh -6 -A rfc4106_128 -p esp_aead -m transport -s "100 1000 65535"
-sctp6_ipsec09 sctp_ipsec.sh -6 -A rfc4106_128 -p esp_aead -m tunnel -s "100 1000 65535"
-sctp6_ipsec10 sctp_ipsec.sh -6 -A rfc4106_192 -p esp_aead -m transport -s "100 1000 65535"
-sctp6_ipsec11 sctp_ipsec.sh -6 -A rfc4106_192 -p esp_aead -m tunnel -s "100 1000 65535"
-sctp6_ipsec12 sctp_ipsec.sh -6 -A rfc4106_256 -p esp_aead -m transport -s "100 1000 65535"
-sctp6_ipsec13 sctp_ipsec.sh -6 -A rfc4106_256 -p esp_aead -m tunnel -s "100 1000 65535"
-sctp6_ipsec14 sctp_ipsec.sh -6 -A rfc4309_128 -p esp_aead -m transport -s "100 1000 65535"
-sctp6_ipsec15 sctp_ipsec.sh -6 -A rfc4309_128 -p esp_aead -m tunnel -s "100 1000 65535"
-sctp6_ipsec16 sctp_ipsec.sh -6 -A rfc4309_192 -p esp_aead -m transport -s "100 1000 65535"
-sctp6_ipsec17 sctp_ipsec.sh -6 -A rfc4309_192 -p esp_aead -m tunnel -s "100 1000 65535"
-sctp6_ipsec18 sctp_ipsec.sh -6 -A rfc4309_256 -p esp_aead -m transport -s "100 1000 65535"
-sctp6_ipsec19 sctp_ipsec.sh -6 -A rfc4309_256 -p esp_aead -m tunnel -s "100 1000 65535"
-sctp6_ipsec20 sctp_ipsec.sh -6 -A rfc4543_128 -p esp_aead -m transport -s "100 1000 65535"
-sctp6_ipsec21 sctp_ipsec.sh -6 -A rfc4543_128 -p esp_aead -m tunnel -s "100 1000 65535"
-sctp6_ipsec22 sctp_ipsec.sh -6 -A rfc4543_192 -p esp_aead -m transport -s "100 1000 65535"
-sctp6_ipsec23 sctp_ipsec.sh -6 -A rfc4543_192 -p esp_aead -m tunnel -s "100 1000 65535"
-sctp6_ipsec24 sctp_ipsec.sh -6 -A rfc4543_256 -p esp_aead -m transport -s "100 1000 65535"
-sctp6_ipsec25 sctp_ipsec.sh -6 -A rfc4543_256 -p esp_aead -m tunnel -s "100 1000 65535"
-sctp6_ipsec26 sctp_ipsec.sh -6 -p esp -a sha1 -e cast5 -m transport -s "100 1000 65535"
-sctp6_ipsec27 sctp_ipsec.sh -6 -p esp -a sha1 -e cast5 -m tunnel -s "100 1000 65535"
-sctp6_ipsec28 sctp_ipsec.sh -6 -p esp -a sha256 -e blowfish -m transport -s "100 1000 65535"
-sctp6_ipsec29 sctp_ipsec.sh -6 -p esp -a sha256 -e blowfish -m tunnel -s "100 1000 65535"
-sctp6_ipsec30 sctp_ipsec.sh -6 -p esp -a sha384 -e twofish -m transport -s "100 1000 65535"
-sctp6_ipsec31 sctp_ipsec.sh -6 -p esp -a sha384 -e twofish -m tunnel -s "100 1000 65535"
-sctp6_ipsec32 sctp_ipsec.sh -6 -p esp -a sha512 -e camellia -m transport -s "100 1000 65535"
-sctp6_ipsec33 sctp_ipsec.sh -6 -p esp -a sha512 -e camellia -m tunnel -s "100 1000 65535"
-sctp6_ipsec34 sctp_ipsec.sh -6 -p esp -a rmd160 -e serpent -m transport -s "100 1000 65535"
-sctp6_ipsec35 sctp_ipsec.sh -6 -p esp -a rmd160 -e serpent -m tunnel -s "100 1000 65535"
-sctp6_ipsec36 sctp_ipsec.sh -6 -p esp -m beet -s "100 1000 65535"
+sctp6_ipsec01 sctp_ipsec.sh -6 -s 100:1000:65535
+sctp6_ipsec02 sctp_ipsec.sh -6 -p ah -m transport -s 100:1000:65535
+sctp6_ipsec03 sctp_ipsec.sh -6 -p ah -m tunnel -s 100:1000:65535
+sctp6_ipsec04 sctp_ipsec.sh -6 -p esp -m transport -s 100:1000:65535
+sctp6_ipsec05 sctp_ipsec.sh -6 -p esp -m tunnel -s 100:1000:65535
+sctp6_ipsec06 sctp_ipsec.sh -6 -p comp -m transport -s 100:1000:65535
+sctp6_ipsec07 sctp_ipsec.sh -6 -p comp -m tunnel -s 100:1000:65535
+sctp6_ipsec08 sctp_ipsec.sh -6 -A rfc4106_128 -p esp_aead -m transport -s 100:1000:65535
+sctp6_ipsec09 sctp_ipsec.sh -6 -A rfc4106_128 -p esp_aead -m tunnel -s 100:1000:65535
+sctp6_ipsec10 sctp_ipsec.sh -6 -A rfc4106_192 -p esp_aead -m transport -s 100:1000:65535
+sctp6_ipsec11 sctp_ipsec.sh -6 -A rfc4106_192 -p esp_aead -m tunnel -s 100:1000:65535
+sctp6_ipsec12 sctp_ipsec.sh -6 -A rfc4106_256 -p esp_aead -m transport -s 100:1000:65535
+sctp6_ipsec13 sctp_ipsec.sh -6 -A rfc4106_256 -p esp_aead -m tunnel -s 100:1000:65535
+sctp6_ipsec14 sctp_ipsec.sh -6 -A rfc4309_128 -p esp_aead -m transport -s 100:1000:65535
+sctp6_ipsec15 sctp_ipsec.sh -6 -A rfc4309_128 -p esp_aead -m tunnel -s 100:1000:65535
+sctp6_ipsec16 sctp_ipsec.sh -6 -A rfc4309_192 -p esp_aead -m transport -s 100:1000:65535
+sctp6_ipsec17 sctp_ipsec.sh -6 -A rfc4309_192 -p esp_aead -m tunnel -s 100:1000:65535
+sctp6_ipsec18 sctp_ipsec.sh -6 -A rfc4309_256 -p esp_aead -m transport -s 100:1000:65535
+sctp6_ipsec19 sctp_ipsec.sh -6 -A rfc4309_256 -p esp_aead -m tunnel -s 100:1000:65535
+sctp6_ipsec20 sctp_ipsec.sh -6 -A rfc4543_128 -p esp_aead -m transport -s 100:1000:65535
+sctp6_ipsec21 sctp_ipsec.sh -6 -A rfc4543_128 -p esp_aead -m tunnel -s 100:1000:65535
+sctp6_ipsec22 sctp_ipsec.sh -6 -A rfc4543_192 -p esp_aead -m transport -s 100:1000:65535
+sctp6_ipsec23 sctp_ipsec.sh -6 -A rfc4543_192 -p esp_aead -m tunnel -s 100:1000:65535
+sctp6_ipsec24 sctp_ipsec.sh -6 -A rfc4543_256 -p esp_aead -m transport -s 100:1000:65535
+sctp6_ipsec25 sctp_ipsec.sh -6 -A rfc4543_256 -p esp_aead -m tunnel -s 100:1000:65535
+sctp6_ipsec26 sctp_ipsec.sh -6 -p esp -a sha1 -e cast5 -m transport -s 100:1000:65535
+sctp6_ipsec27 sctp_ipsec.sh -6 -p esp -a sha1 -e cast5 -m tunnel -s 100:1000:65535
+sctp6_ipsec28 sctp_ipsec.sh -6 -p esp -a sha256 -e blowfish -m transport -s 100:1000:65535
+sctp6_ipsec29 sctp_ipsec.sh -6 -p esp -a sha256 -e blowfish -m tunnel -s 100:1000:65535
+sctp6_ipsec30 sctp_ipsec.sh -6 -p esp -a sha384 -e twofish -m transport -s 100:1000:65535
+sctp6_ipsec31 sctp_ipsec.sh -6 -p esp -a sha384 -e twofish -m tunnel -s 100:1000:65535
+sctp6_ipsec32 sctp_ipsec.sh -6 -p esp -a sha512 -e camellia -m transport -s 100:1000:65535
+sctp6_ipsec33 sctp_ipsec.sh -6 -p esp -a sha512 -e camellia -m tunnel -s 100:1000:65535
+sctp6_ipsec34 sctp_ipsec.sh -6 -p esp -a rmd160 -e serpent -m transport -s 100:1000:65535
+sctp6_ipsec35 sctp_ipsec.sh -6 -p esp -a rmd160 -e serpent -m tunnel -s 100:1000:65535
+sctp6_ipsec36 sctp_ipsec.sh -6 -p esp -m beet -s 100:1000:65535
 
-sctp4_ipsec_vti01 sctp_ipsec_vti.sh -p ah -m tunnel -s "100 1000 65535"
-sctp4_ipsec_vti02 sctp_ipsec_vti.sh -p esp -m tunnel -s "100 1000 65535"
-# sctp4_ipsec_vti03 sctp_ipsec_vti.sh -p comp -m tunnel -s "100 1000 65535"
-sctp4_ipsec_vti04 sctp_ipsec_vti.sh -A rfc4106_128 -p esp_aead -m tunnel -s "100 1000 65535"
-sctp4_ipsec_vti05 sctp_ipsec_vti.sh -A rfc4106_192 -p esp_aead -m tunnel -s "100 1000 65535"
-sctp4_ipsec_vti06 sctp_ipsec_vti.sh -A rfc4106_256 -p esp_aead -m tunnel -s "100 1000 65535"
-sctp4_ipsec_vti07 sctp_ipsec_vti.sh -A rfc4309_128 -p esp_aead -m tunnel -s "100 1000 65535"
-sctp4_ipsec_vti08 sctp_ipsec_vti.sh -A rfc4309_192 -p esp_aead -m tunnel -s "100 1000 65535"
-sctp4_ipsec_vti09 sctp_ipsec_vti.sh -A rfc4309_256 -p esp_aead -m tunnel -s "100 1000 65535"
-sctp4_ipsec_vti10 sctp_ipsec_vti.sh -A rfc4543_128 -p esp_aead -m tunnel -s "100 1000 65535"
-sctp4_ipsec_vti11 sctp_ipsec_vti.sh -A rfc4543_192 -p esp_aead -m tunnel -s "100 1000 65535"
-sctp4_ipsec_vti12 sctp_ipsec_vti.sh -A rfc4543_256 -p esp_aead -m tunnel -s "100 1000 65535"
-sctp4_ipsec_vti13 sctp_ipsec_vti.sh -p esp -a sha1 -e cast5 -m tunnel -s "100 1000 65535"
-sctp4_ipsec_vti14 sctp_ipsec_vti.sh -p esp -a sha256 -e blowfish -m tunnel -s "100 1000 65535"
-sctp4_ipsec_vti15 sctp_ipsec_vti.sh -p esp -a sha384 -e twofish -m tunnel -s "100 1000 65535"
-sctp4_ipsec_vti16 sctp_ipsec_vti.sh -p esp -a sha512 -e camellia -m tunnel -s "100 1000 65535"
-sctp4_ipsec_vti17 sctp_ipsec_vti.sh -p esp -a rmd160 -e serpent -m tunnel -s "100 1000 65535"
+sctp4_ipsec_vti01 sctp_ipsec_vti.sh -p ah -m tunnel -s 100:1000:65535
+sctp4_ipsec_vti02 sctp_ipsec_vti.sh -p esp -m tunnel -s 100:1000:65535
+# sctp4_ipsec_vti03 sctp_ipsec_vti.sh -p comp -m tunnel -s 100:1000:65535
+sctp4_ipsec_vti04 sctp_ipsec_vti.sh -A rfc4106_128 -p esp_aead -m tunnel -s 100:1000:65535
+sctp4_ipsec_vti05 sctp_ipsec_vti.sh -A rfc4106_192 -p esp_aead -m tunnel -s 100:1000:65535
+sctp4_ipsec_vti06 sctp_ipsec_vti.sh -A rfc4106_256 -p esp_aead -m tunnel -s 100:1000:65535
+sctp4_ipsec_vti07 sctp_ipsec_vti.sh -A rfc4309_128 -p esp_aead -m tunnel -s 100:1000:65535
+sctp4_ipsec_vti08 sctp_ipsec_vti.sh -A rfc4309_192 -p esp_aead -m tunnel -s 100:1000:65535
+sctp4_ipsec_vti09 sctp_ipsec_vti.sh -A rfc4309_256 -p esp_aead -m tunnel -s 100:1000:65535
+sctp4_ipsec_vti10 sctp_ipsec_vti.sh -A rfc4543_128 -p esp_aead -m tunnel -s 100:1000:65535
+sctp4_ipsec_vti11 sctp_ipsec_vti.sh -A rfc4543_192 -p esp_aead -m tunnel -s 100:1000:65535
+sctp4_ipsec_vti12 sctp_ipsec_vti.sh -A rfc4543_256 -p esp_aead -m tunnel -s 100:1000:65535
+sctp4_ipsec_vti13 sctp_ipsec_vti.sh -p esp -a sha1 -e cast5 -m tunnel -s 100:1000:65535
+sctp4_ipsec_vti14 sctp_ipsec_vti.sh -p esp -a sha256 -e blowfish -m tunnel -s 100:1000:65535
+sctp4_ipsec_vti15 sctp_ipsec_vti.sh -p esp -a sha384 -e twofish -m tunnel -s 100:1000:65535
+sctp4_ipsec_vti16 sctp_ipsec_vti.sh -p esp -a sha512 -e camellia -m tunnel -s 100:1000:65535
+sctp4_ipsec_vti17 sctp_ipsec_vti.sh -p esp -a rmd160 -e serpent -m tunnel -s 100:1000:65535
 
-sctp6_ipsec_vti01 sctp_ipsec_vti.sh -6 -p ah -m tunnel -s "100 1000 65535"
-sctp6_ipsec_vti02 sctp_ipsec_vti.sh -6 -p esp -m tunnel -s "100 1000 65535"
-# sctp6_ipsec_vti03 sctp_ipsec_vti.sh -6 -p comp -m tunnel -s "100 1000 65535"
-sctp6_ipsec_vti04 sctp_ipsec_vti.sh -6 -A rfc4106_128 -p esp_aead -m tunnel -s "100 1000 65535"
-sctp6_ipsec_vti05 sctp_ipsec_vti.sh -6 -A rfc4106_192 -p esp_aead -m tunnel -s "100 1000 65535"
-sctp6_ipsec_vti06 sctp_ipsec_vti.sh -6 -A rfc4106_256 -p esp_aead -m tunnel -s "100 1000 65535"
-sctp6_ipsec_vti07 sctp_ipsec_vti.sh -6 -A rfc4309_128 -p esp_aead -m tunnel -s "100 1000 65535"
-sctp6_ipsec_vti08 sctp_ipsec_vti.sh -6 -A rfc4309_192 -p esp_aead -m tunnel -s "100 1000 65535"
-sctp6_ipsec_vti09 sctp_ipsec_vti.sh -6 -A rfc4309_256 -p esp_aead -m tunnel -s "100 1000 65535"
-sctp6_ipsec_vti10 sctp_ipsec_vti.sh -6 -A rfc4543_128 -p esp_aead -m tunnel -s "100 1000 65535"
-sctp6_ipsec_vti11 sctp_ipsec_vti.sh -6 -A rfc4543_192 -p esp_aead -m tunnel -s "100 1000 65535"
-sctp6_ipsec_vti12 sctp_ipsec_vti.sh -6 -A rfc4543_256 -p esp_aead -m tunnel -s "100 1000 65535"
-sctp6_ipsec_vti13 sctp_ipsec_vti.sh -6 -p esp -a sha1 -e cast5 -m tunnel -s "100 1000 65535"
-sctp6_ipsec_vti14 sctp_ipsec_vti.sh -6 -p esp -a sha256 -e blowfish -m tunnel -s "100 1000 65535"
-sctp6_ipsec_vti15 sctp_ipsec_vti.sh -6 -p esp -a sha384 -e twofish -m tunnel -s "100 1000 65535"
-sctp6_ipsec_vti16 sctp_ipsec_vti.sh -6 -p esp -a sha512 -e camellia -m tunnel -s "100 1000 65535"
-sctp6_ipsec_vti17 sctp_ipsec_vti.sh -6 -p esp -a rmd160 -e serpent -m tunnel -s "100 1000 65535"
+sctp6_ipsec_vti01 sctp_ipsec_vti.sh -6 -p ah -m tunnel -s 100:1000:65535
+sctp6_ipsec_vti02 sctp_ipsec_vti.sh -6 -p esp -m tunnel -s 100:1000:65535
+# sctp6_ipsec_vti03 sctp_ipsec_vti.sh -6 -p comp -m tunnel -s 100:1000:65535
+sctp6_ipsec_vti04 sctp_ipsec_vti.sh -6 -A rfc4106_128 -p esp_aead -m tunnel -s 100:1000:65535
+sctp6_ipsec_vti05 sctp_ipsec_vti.sh -6 -A rfc4106_192 -p esp_aead -m tunnel -s 100:1000:65535
+sctp6_ipsec_vti06 sctp_ipsec_vti.sh -6 -A rfc4106_256 -p esp_aead -m tunnel -s 100:1000:65535
+sctp6_ipsec_vti07 sctp_ipsec_vti.sh -6 -A rfc4309_128 -p esp_aead -m tunnel -s 100:1000:65535
+sctp6_ipsec_vti08 sctp_ipsec_vti.sh -6 -A rfc4309_192 -p esp_aead -m tunnel -s 100:1000:65535
+sctp6_ipsec_vti09 sctp_ipsec_vti.sh -6 -A rfc4309_256 -p esp_aead -m tunnel -s 100:1000:65535
+sctp6_ipsec_vti10 sctp_ipsec_vti.sh -6 -A rfc4543_128 -p esp_aead -m tunnel -s 100:1000:65535
+sctp6_ipsec_vti11 sctp_ipsec_vti.sh -6 -A rfc4543_192 -p esp_aead -m tunnel -s 100:1000:65535
+sctp6_ipsec_vti12 sctp_ipsec_vti.sh -6 -A rfc4543_256 -p esp_aead -m tunnel -s 100:1000:65535
+sctp6_ipsec_vti13 sctp_ipsec_vti.sh -6 -p esp -a sha1 -e cast5 -m tunnel -s 100:1000:65535
+sctp6_ipsec_vti14 sctp_ipsec_vti.sh -6 -p esp -a sha256 -e blowfish -m tunnel -s 100:1000:65535
+sctp6_ipsec_vti15 sctp_ipsec_vti.sh -6 -p esp -a sha384 -e twofish -m tunnel -s 100:1000:65535
+sctp6_ipsec_vti16 sctp_ipsec_vti.sh -6 -p esp -a sha512 -e camellia -m tunnel -s 100:1000:65535
+sctp6_ipsec_vti17 sctp_ipsec_vti.sh -6 -p esp -a rmd160 -e serpent -m tunnel -s 100:1000:65535
diff --git a/runtest/net_stress.ipsec_tcp b/runtest/net_stress.ipsec_tcp
index 30e0f4af0..ae52de518 100644
--- a/runtest/net_stress.ipsec_tcp
+++ b/runtest/net_stress.ipsec_tcp
@@ -1,109 +1,109 @@
-tcp4_ipsec01 tcp_ipsec.sh -s "100 1000 65535"
-tcp4_ipsec02 tcp_ipsec.sh -p ah -m transport -s "100 1000 65535"
-tcp4_ipsec03 tcp_ipsec.sh -p ah -m tunnel -s "100 1000 65535"
-tcp4_ipsec04 tcp_ipsec.sh -p esp -m transport -s "100 1000 65535"
-tcp4_ipsec05 tcp_ipsec.sh -p esp -m tunnel -s "100 1000 65535"
-tcp4_ipsec06 tcp_ipsec.sh -p comp -m transport -s "100 1000 65535"
-tcp4_ipsec07 tcp_ipsec.sh -p comp -m tunnel -s "100 1000 65535"
-tcp4_ipsec08 tcp_ipsec.sh -A rfc4106_128 -p esp_aead -m transport -s "100 1000 65535"
-tcp4_ipsec09 tcp_ipsec.sh -A rfc4106_128 -p esp_aead -m tunnel -s "100 1000 65535"
-tcp4_ipsec10 tcp_ipsec.sh -A rfc4106_192 -p esp_aead -m transport -s "100 1000 65535"
-tcp4_ipsec11 tcp_ipsec.sh -A rfc4106_192 -p esp_aead -m tunnel -s "100 1000 65535"
-tcp4_ipsec12 tcp_ipsec.sh -A rfc4106_256 -p esp_aead -m transport -s "100 1000 65535"
-tcp4_ipsec13 tcp_ipsec.sh -A rfc4106_256 -p esp_aead -m tunnel -s "100 1000 65535"
-tcp4_ipsec14 tcp_ipsec.sh -A rfc4309_128 -p esp_aead -m transport -s "100 1000 65535"
-tcp4_ipsec15 tcp_ipsec.sh -A rfc4309_128 -p esp_aead -m tunnel -s "100 1000 65535"
-tcp4_ipsec16 tcp_ipsec.sh -A rfc4309_192 -p esp_aead -m transport -s "100 1000 65535"
-tcp4_ipsec17 tcp_ipsec.sh -A rfc4309_192 -p esp_aead -m tunnel -s "100 1000 65535"
-tcp4_ipsec18 tcp_ipsec.sh -A rfc4309_256 -p esp_aead -m transport -s "100 1000 65535"
-tcp4_ipsec19 tcp_ipsec.sh -A rfc4309_256 -p esp_aead -m tunnel -s "100 1000 65535"
-tcp4_ipsec20 tcp_ipsec.sh -A rfc4543_128 -p esp_aead -m transport -s "100 1000 65535"
-tcp4_ipsec21 tcp_ipsec.sh -A rfc4543_128 -p esp_aead -m tunnel -s "100 1000 65535"
-tcp4_ipsec22 tcp_ipsec.sh -A rfc4543_192 -p esp_aead -m transport -s "100 1000 65535"
-tcp4_ipsec23 tcp_ipsec.sh -A rfc4543_192 -p esp_aead -m tunnel -s "100 1000 65535"
-tcp4_ipsec24 tcp_ipsec.sh -A rfc4543_256 -p esp_aead -m transport -s "100 1000 65535"
-tcp4_ipsec25 tcp_ipsec.sh -A rfc4543_256 -p esp_aead -m tunnel -s "100 1000 65535"
-tcp4_ipsec26 tcp_ipsec.sh -p esp -a sha1 -e cast5 -m transport -s "100 1000 65535"
-tcp4_ipsec27 tcp_ipsec.sh -p esp -a sha1 -e cast5 -m tunnel -s "100 1000 65535"
-tcp4_ipsec28 tcp_ipsec.sh -p esp -a sha256 -e blowfish -m transport -s "100 1000 65535"
-tcp4_ipsec29 tcp_ipsec.sh -p esp -a sha256 -e blowfish -m tunnel -s "100 1000 65535"
-tcp4_ipsec30 tcp_ipsec.sh -p esp -a sha384 -e twofish -m transport -s "100 1000 65535"
-tcp4_ipsec31 tcp_ipsec.sh -p esp -a sha384 -e twofish -m tunnel -s "100 1000 65535"
-tcp4_ipsec32 tcp_ipsec.sh -p esp -a sha512 -e camellia -m transport -s "100 1000 65535"
-tcp4_ipsec33 tcp_ipsec.sh -p esp -a sha512 -e camellia -m tunnel -s "100 1000 65535"
-tcp4_ipsec34 tcp_ipsec.sh -p esp -a rmd160 -e serpent -m transport -s "100 1000 65535"
-tcp4_ipsec35 tcp_ipsec.sh -p esp -a rmd160 -e serpent -m tunnel -s "100 1000 65535"
-tcp4_ipsec36 tcp_ipsec.sh -p esp -m beet -s "100 1000 65535"
+tcp4_ipsec01 tcp_ipsec.sh -s 100:1000:65535
+tcp4_ipsec02 tcp_ipsec.sh -p ah -m transport -s 100:1000:65535
+tcp4_ipsec03 tcp_ipsec.sh -p ah -m tunnel -s 100:1000:65535
+tcp4_ipsec04 tcp_ipsec.sh -p esp -m transport -s 100:1000:65535
+tcp4_ipsec05 tcp_ipsec.sh -p esp -m tunnel -s 100:1000:65535
+tcp4_ipsec06 tcp_ipsec.sh -p comp -m transport -s 100:1000:65535
+tcp4_ipsec07 tcp_ipsec.sh -p comp -m tunnel -s 100:1000:65535
+tcp4_ipsec08 tcp_ipsec.sh -A rfc4106_128 -p esp_aead -m transport -s 100:1000:65535
+tcp4_ipsec09 tcp_ipsec.sh -A rfc4106_128 -p esp_aead -m tunnel -s 100:1000:65535
+tcp4_ipsec10 tcp_ipsec.sh -A rfc4106_192 -p esp_aead -m transport -s 100:1000:65535
+tcp4_ipsec11 tcp_ipsec.sh -A rfc4106_192 -p esp_aead -m tunnel -s 100:1000:65535
+tcp4_ipsec12 tcp_ipsec.sh -A rfc4106_256 -p esp_aead -m transport -s 100:1000:65535
+tcp4_ipsec13 tcp_ipsec.sh -A rfc4106_256 -p esp_aead -m tunnel -s 100:1000:65535
+tcp4_ipsec14 tcp_ipsec.sh -A rfc4309_128 -p esp_aead -m transport -s 100:1000:65535
+tcp4_ipsec15 tcp_ipsec.sh -A rfc4309_128 -p esp_aead -m tunnel -s 100:1000:65535
+tcp4_ipsec16 tcp_ipsec.sh -A rfc4309_192 -p esp_aead -m transport -s 100:1000:65535
+tcp4_ipsec17 tcp_ipsec.sh -A rfc4309_192 -p esp_aead -m tunnel -s 100:1000:65535
+tcp4_ipsec18 tcp_ipsec.sh -A rfc4309_256 -p esp_aead -m transport -s 100:1000:65535
+tcp4_ipsec19 tcp_ipsec.sh -A rfc4309_256 -p esp_aead -m tunnel -s 100:1000:65535
+tcp4_ipsec20 tcp_ipsec.sh -A rfc4543_128 -p esp_aead -m transport -s 100:1000:65535
+tcp4_ipsec21 tcp_ipsec.sh -A rfc4543_128 -p esp_aead -m tunnel -s 100:1000:65535
+tcp4_ipsec22 tcp_ipsec.sh -A rfc4543_192 -p esp_aead -m transport -s 100:1000:65535
+tcp4_ipsec23 tcp_ipsec.sh -A rfc4543_192 -p esp_aead -m tunnel -s 100:1000:65535
+tcp4_ipsec24 tcp_ipsec.sh -A rfc4543_256 -p esp_aead -m transport -s 100:1000:65535
+tcp4_ipsec25 tcp_ipsec.sh -A rfc4543_256 -p esp_aead -m tunnel -s 100:1000:65535
+tcp4_ipsec26 tcp_ipsec.sh -p esp -a sha1 -e cast5 -m transport -s 100:1000:65535
+tcp4_ipsec27 tcp_ipsec.sh -p esp -a sha1 -e cast5 -m tunnel -s 100:1000:65535
+tcp4_ipsec28 tcp_ipsec.sh -p esp -a sha256 -e blowfish -m transport -s 100:1000:65535
+tcp4_ipsec29 tcp_ipsec.sh -p esp -a sha256 -e blowfish -m tunnel -s 100:1000:65535
+tcp4_ipsec30 tcp_ipsec.sh -p esp -a sha384 -e twofish -m transport -s 100:1000:65535
+tcp4_ipsec31 tcp_ipsec.sh -p esp -a sha384 -e twofish -m tunnel -s 100:1000:65535
+tcp4_ipsec32 tcp_ipsec.sh -p esp -a sha512 -e camellia -m transport -s 100:1000:65535
+tcp4_ipsec33 tcp_ipsec.sh -p esp -a sha512 -e camellia -m tunnel -s 100:1000:65535
+tcp4_ipsec34 tcp_ipsec.sh -p esp -a rmd160 -e serpent -m transport -s 100:1000:65535
+tcp4_ipsec35 tcp_ipsec.sh -p esp -a rmd160 -e serpent -m tunnel -s 100:1000:65535
+tcp4_ipsec36 tcp_ipsec.sh -p esp -m beet -s 100:1000:65535
 
-tcp6_ipsec01 tcp_ipsec.sh -6 -s "100 1000 65535"
-tcp6_ipsec02 tcp_ipsec.sh -6 -p ah -m transport -s "100 1000 65535"
-tcp6_ipsec03 tcp_ipsec.sh -6 -p ah -m tunnel -s "100 1000 65535"
-tcp6_ipsec04 tcp_ipsec.sh -6 -p esp -m transport -s "100 1000 65535"
-tcp6_ipsec05 tcp_ipsec.sh -6 -p esp -m tunnel -s "100 1000 65535"
-tcp6_ipsec06 tcp_ipsec.sh -6 -p comp -m transport -s "100 1000 65535"
-tcp6_ipsec07 tcp_ipsec.sh -6 -p comp -m tunnel -s "100 1000 65535"
-tcp6_ipsec08 tcp_ipsec.sh -6 -A rfc4106_128 -p esp_aead -m transport -s "100 1000 65535"
-tcp6_ipsec09 tcp_ipsec.sh -6 -A rfc4106_128 -p esp_aead -m tunnel -s "100 1000 65535"
-tcp6_ipsec10 tcp_ipsec.sh -6 -A rfc4106_192 -p esp_aead -m transport -s "100 1000 65535"
-tcp6_ipsec11 tcp_ipsec.sh -6 -A rfc4106_192 -p esp_aead -m tunnel -s "100 1000 65535"
-tcp6_ipsec12 tcp_ipsec.sh -6 -A rfc4106_256 -p esp_aead -m transport -s "100 1000 65535"
-tcp6_ipsec13 tcp_ipsec.sh -6 -A rfc4106_256 -p esp_aead -m tunnel -s "100 1000 65535"
-tcp6_ipsec14 tcp_ipsec.sh -6 -A rfc4309_128 -p esp_aead -m transport -s "100 1000 65535"
-tcp6_ipsec15 tcp_ipsec.sh -6 -A rfc4309_128 -p esp_aead -m tunnel -s "100 1000 65535"
-tcp6_ipsec16 tcp_ipsec.sh -6 -A rfc4309_192 -p esp_aead -m transport -s "100 1000 65535"
-tcp6_ipsec17 tcp_ipsec.sh -6 -A rfc4309_192 -p esp_aead -m tunnel -s "100 1000 65535"
-tcp6_ipsec18 tcp_ipsec.sh -6 -A rfc4309_256 -p esp_aead -m transport -s "100 1000 65535"
-tcp6_ipsec19 tcp_ipsec.sh -6 -A rfc4309_256 -p esp_aead -m tunnel -s "100 1000 65535"
-tcp6_ipsec20 tcp_ipsec.sh -6 -A rfc4543_128 -p esp_aead -m transport -s "100 1000 65535"
-tcp6_ipsec21 tcp_ipsec.sh -6 -A rfc4543_128 -p esp_aead -m tunnel -s "100 1000 65535"
-tcp6_ipsec22 tcp_ipsec.sh -6 -A rfc4543_192 -p esp_aead -m transport -s "100 1000 65535"
-tcp6_ipsec23 tcp_ipsec.sh -6 -A rfc4543_192 -p esp_aead -m tunnel -s "100 1000 65535"
-tcp6_ipsec24 tcp_ipsec.sh -6 -A rfc4543_256 -p esp_aead -m transport -s "100 1000 65535"
-tcp6_ipsec25 tcp_ipsec.sh -6 -A rfc4543_256 -p esp_aead -m tunnel -s "100 1000 65535"
-tcp6_ipsec26 tcp_ipsec.sh -6 -p esp -a sha1 -e cast5 -m transport -s "100 1000 65535"
-tcp6_ipsec27 tcp_ipsec.sh -6 -p esp -a sha1 -e cast5 -m tunnel -s "100 1000 65535"
-tcp6_ipsec28 tcp_ipsec.sh -6 -p esp -a sha256 -e blowfish -m transport -s "100 1000 65535"
-tcp6_ipsec29 tcp_ipsec.sh -6 -p esp -a sha256 -e blowfish -m tunnel -s "100 1000 65535"
-tcp6_ipsec30 tcp_ipsec.sh -6 -p esp -a sha384 -e twofish -m transport -s "100 1000 65535"
-tcp6_ipsec31 tcp_ipsec.sh -6 -p esp -a sha384 -e twofish -m tunnel -s "100 1000 65535"
-tcp6_ipsec32 tcp_ipsec.sh -6 -p esp -a sha512 -e camellia -m transport -s "100 1000 65535"
-tcp6_ipsec33 tcp_ipsec.sh -6 -p esp -a sha512 -e camellia -m tunnel -s "100 1000 65535"
-tcp6_ipsec34 tcp_ipsec.sh -6 -p esp -a rmd160 -e serpent -m transport -s "100 1000 65535"
-tcp6_ipsec35 tcp_ipsec.sh -6 -p esp -a rmd160 -e serpent -m tunnel -s "100 1000 65535"
-tcp6_ipsec36 tcp_ipsec.sh -6 -p esp -m beet -s "100 1000 65535"
+tcp6_ipsec01 tcp_ipsec.sh -6 -s 100:1000:65535
+tcp6_ipsec02 tcp_ipsec.sh -6 -p ah -m transport -s 100:1000:65535
+tcp6_ipsec03 tcp_ipsec.sh -6 -p ah -m tunnel -s 100:1000:65535
+tcp6_ipsec04 tcp_ipsec.sh -6 -p esp -m transport -s 100:1000:65535
+tcp6_ipsec05 tcp_ipsec.sh -6 -p esp -m tunnel -s 100:1000:65535
+tcp6_ipsec06 tcp_ipsec.sh -6 -p comp -m transport -s 100:1000:65535
+tcp6_ipsec07 tcp_ipsec.sh -6 -p comp -m tunnel -s 100:1000:65535
+tcp6_ipsec08 tcp_ipsec.sh -6 -A rfc4106_128 -p esp_aead -m transport -s 100:1000:65535
+tcp6_ipsec09 tcp_ipsec.sh -6 -A rfc4106_128 -p esp_aead -m tunnel -s 100:1000:65535
+tcp6_ipsec10 tcp_ipsec.sh -6 -A rfc4106_192 -p esp_aead -m transport -s 100:1000:65535
+tcp6_ipsec11 tcp_ipsec.sh -6 -A rfc4106_192 -p esp_aead -m tunnel -s 100:1000:65535
+tcp6_ipsec12 tcp_ipsec.sh -6 -A rfc4106_256 -p esp_aead -m transport -s 100:1000:65535
+tcp6_ipsec13 tcp_ipsec.sh -6 -A rfc4106_256 -p esp_aead -m tunnel -s 100:1000:65535
+tcp6_ipsec14 tcp_ipsec.sh -6 -A rfc4309_128 -p esp_aead -m transport -s 100:1000:65535
+tcp6_ipsec15 tcp_ipsec.sh -6 -A rfc4309_128 -p esp_aead -m tunnel -s 100:1000:65535
+tcp6_ipsec16 tcp_ipsec.sh -6 -A rfc4309_192 -p esp_aead -m transport -s 100:1000:65535
+tcp6_ipsec17 tcp_ipsec.sh -6 -A rfc4309_192 -p esp_aead -m tunnel -s 100:1000:65535
+tcp6_ipsec18 tcp_ipsec.sh -6 -A rfc4309_256 -p esp_aead -m transport -s 100:1000:65535
+tcp6_ipsec19 tcp_ipsec.sh -6 -A rfc4309_256 -p esp_aead -m tunnel -s 100:1000:65535
+tcp6_ipsec20 tcp_ipsec.sh -6 -A rfc4543_128 -p esp_aead -m transport -s 100:1000:65535
+tcp6_ipsec21 tcp_ipsec.sh -6 -A rfc4543_128 -p esp_aead -m tunnel -s 100:1000:65535
+tcp6_ipsec22 tcp_ipsec.sh -6 -A rfc4543_192 -p esp_aead -m transport -s 100:1000:65535
+tcp6_ipsec23 tcp_ipsec.sh -6 -A rfc4543_192 -p esp_aead -m tunnel -s 100:1000:65535
+tcp6_ipsec24 tcp_ipsec.sh -6 -A rfc4543_256 -p esp_aead -m transport -s 100:1000:65535
+tcp6_ipsec25 tcp_ipsec.sh -6 -A rfc4543_256 -p esp_aead -m tunnel -s 100:1000:65535
+tcp6_ipsec26 tcp_ipsec.sh -6 -p esp -a sha1 -e cast5 -m transport -s 100:1000:65535
+tcp6_ipsec27 tcp_ipsec.sh -6 -p esp -a sha1 -e cast5 -m tunnel -s 100:1000:65535
+tcp6_ipsec28 tcp_ipsec.sh -6 -p esp -a sha256 -e blowfish -m transport -s 100:1000:65535
+tcp6_ipsec29 tcp_ipsec.sh -6 -p esp -a sha256 -e blowfish -m tunnel -s 100:1000:65535
+tcp6_ipsec30 tcp_ipsec.sh -6 -p esp -a sha384 -e twofish -m transport -s 100:1000:65535
+tcp6_ipsec31 tcp_ipsec.sh -6 -p esp -a sha384 -e twofish -m tunnel -s 100:1000:65535
+tcp6_ipsec32 tcp_ipsec.sh -6 -p esp -a sha512 -e camellia -m transport -s 100:1000:65535
+tcp6_ipsec33 tcp_ipsec.sh -6 -p esp -a sha512 -e camellia -m tunnel -s 100:1000:65535
+tcp6_ipsec34 tcp_ipsec.sh -6 -p esp -a rmd160 -e serpent -m transport -s 100:1000:65535
+tcp6_ipsec35 tcp_ipsec.sh -6 -p esp -a rmd160 -e serpent -m tunnel -s 100:1000:65535
+tcp6_ipsec36 tcp_ipsec.sh -6 -p esp -m beet -s 100:1000:65535
 
-tcp4_ipsec_vti01 tcp_ipsec_vti.sh -p ah -m tunnel -s "100 1000 65535"
-tcp4_ipsec_vti02 tcp_ipsec_vti.sh -p esp -m tunnel -s "100 1000 65535"
-# tcp4_ipsec_vti03 tcp_ipsec_vti.sh -p comp -m tunnel -s "100 1000 65535"
-tcp4_ipsec_vti04 tcp_ipsec_vti.sh -A rfc4106_128 -p esp_aead -m tunnel -s "100 1000 65535"
-tcp4_ipsec_vti05 tcp_ipsec_vti.sh -A rfc4106_192 -p esp_aead -m tunnel -s "100 1000 65535"
-tcp4_ipsec_vti06 tcp_ipsec_vti.sh -A rfc4106_256 -p esp_aead -m tunnel -s "100 1000 65535"
-tcp4_ipsec_vti07 tcp_ipsec_vti.sh -A rfc4309_128 -p esp_aead -m tunnel -s "100 1000 65535"
-tcp4_ipsec_vti08 tcp_ipsec_vti.sh -A rfc4309_192 -p esp_aead -m tunnel -s "100 1000 65535"
-tcp4_ipsec_vti09 tcp_ipsec_vti.sh -A rfc4309_256 -p esp_aead -m tunnel -s "100 1000 65535"
-tcp4_ipsec_vti10 tcp_ipsec_vti.sh -A rfc4543_128 -p esp_aead -m tunnel -s "100 1000 65535"
-tcp4_ipsec_vti11 tcp_ipsec_vti.sh -A rfc4543_192 -p esp_aead -m tunnel -s "100 1000 65535"
-tcp4_ipsec_vti12 tcp_ipsec_vti.sh -A rfc4543_256 -p esp_aead -m tunnel -s "100 1000 65535"
-tcp4_ipsec_vti13 tcp_ipsec_vti.sh -p esp -a sha1 -e cast5 -m tunnel -s "100 1000 65535"
-tcp4_ipsec_vti14 tcp_ipsec_vti.sh -p esp -a sha256 -e blowfish -m tunnel -s "100 1000 65535"
-tcp4_ipsec_vti15 tcp_ipsec_vti.sh -p esp -a sha384 -e twofish -m tunnel -s "100 1000 65535"
-tcp4_ipsec_vti16 tcp_ipsec_vti.sh -p esp -a sha512 -e camellia -m tunnel -s "100 1000 65535"
-tcp4_ipsec_vti17 tcp_ipsec_vti.sh -p esp -a rmd160 -e serpent -m tunnel -s "100 1000 65535"
+tcp4_ipsec_vti01 tcp_ipsec_vti.sh -p ah -m tunnel -s 100:1000:65535
+tcp4_ipsec_vti02 tcp_ipsec_vti.sh -p esp -m tunnel -s 100:1000:65535
+# tcp4_ipsec_vti03 tcp_ipsec_vti.sh -p comp -m tunnel -s 100:1000:65535
+tcp4_ipsec_vti04 tcp_ipsec_vti.sh -A rfc4106_128 -p esp_aead -m tunnel -s 100:1000:65535
+tcp4_ipsec_vti05 tcp_ipsec_vti.sh -A rfc4106_192 -p esp_aead -m tunnel -s 100:1000:65535
+tcp4_ipsec_vti06 tcp_ipsec_vti.sh -A rfc4106_256 -p esp_aead -m tunnel -s 100:1000:65535
+tcp4_ipsec_vti07 tcp_ipsec_vti.sh -A rfc4309_128 -p esp_aead -m tunnel -s 100:1000:65535
+tcp4_ipsec_vti08 tcp_ipsec_vti.sh -A rfc4309_192 -p esp_aead -m tunnel -s 100:1000:65535
+tcp4_ipsec_vti09 tcp_ipsec_vti.sh -A rfc4309_256 -p esp_aead -m tunnel -s 100:1000:65535
+tcp4_ipsec_vti10 tcp_ipsec_vti.sh -A rfc4543_128 -p esp_aead -m tunnel -s 100:1000:65535
+tcp4_ipsec_vti11 tcp_ipsec_vti.sh -A rfc4543_192 -p esp_aead -m tunnel -s 100:1000:65535
+tcp4_ipsec_vti12 tcp_ipsec_vti.sh -A rfc4543_256 -p esp_aead -m tunnel -s 100:1000:65535
+tcp4_ipsec_vti13 tcp_ipsec_vti.sh -p esp -a sha1 -e cast5 -m tunnel -s 100:1000:65535
+tcp4_ipsec_vti14 tcp_ipsec_vti.sh -p esp -a sha256 -e blowfish -m tunnel -s 100:1000:65535
+tcp4_ipsec_vti15 tcp_ipsec_vti.sh -p esp -a sha384 -e twofish -m tunnel -s 100:1000:65535
+tcp4_ipsec_vti16 tcp_ipsec_vti.sh -p esp -a sha512 -e camellia -m tunnel -s 100:1000:65535
+tcp4_ipsec_vti17 tcp_ipsec_vti.sh -p esp -a rmd160 -e serpent -m tunnel -s 100:1000:65535
 
-tcp6_ipsec_vti01 tcp_ipsec_vti.sh -6 -p ah -m tunnel -s "100 1000 65535"
-tcp6_ipsec_vti02 tcp_ipsec_vti.sh -6 -p esp -m tunnel -s "100 1000 65535"
-# tcp6_ipsec_vti03 tcp_ipsec_vti.sh -6 -p comp -m tunnel -s "100 1000 65535"
-tcp6_ipsec_vti04 tcp_ipsec_vti.sh -6 -A rfc4106_128 -p esp_aead -m tunnel -s "100 1000 65535"
-tcp6_ipsec_vti05 tcp_ipsec_vti.sh -6 -A rfc4106_192 -p esp_aead -m tunnel -s "100 1000 65535"
-tcp6_ipsec_vti06 tcp_ipsec_vti.sh -6 -A rfc4106_256 -p esp_aead -m tunnel -s "100 1000 65535"
-tcp6_ipsec_vti07 tcp_ipsec_vti.sh -6 -A rfc4309_128 -p esp_aead -m tunnel -s "100 1000 65535"
-tcp6_ipsec_vti08 tcp_ipsec_vti.sh -6 -A rfc4309_192 -p esp_aead -m tunnel -s "100 1000 65535"
-tcp6_ipsec_vti09 tcp_ipsec_vti.sh -6 -A rfc4309_256 -p esp_aead -m tunnel -s "100 1000 65535"
-tcp6_ipsec_vti10 tcp_ipsec_vti.sh -6 -A rfc4543_128 -p esp_aead -m tunnel -s "100 1000 65535"
-tcp6_ipsec_vti11 tcp_ipsec_vti.sh -6 -A rfc4543_192 -p esp_aead -m tunnel -s "100 1000 65535"
-tcp6_ipsec_vti12 tcp_ipsec_vti.sh -6 -A rfc4543_256 -p esp_aead -m tunnel -s "100 1000 65535"
-tcp6_ipsec_vti13 tcp_ipsec_vti.sh -6 -p esp -a sha1 -e cast5 -m tunnel -s "100 1000 65535"
-tcp6_ipsec_vti14 tcp_ipsec_vti.sh -6 -p esp -a sha256 -e blowfish -m tunnel -s "100 1000 65535"
-tcp6_ipsec_vti15 tcp_ipsec_vti.sh -6 -p esp -a sha384 -e twofish -m tunnel -s "100 1000 65535"
-tcp6_ipsec_vti16 tcp_ipsec_vti.sh -6 -p esp -a sha512 -e camellia -m tunnel -s "100 1000 65535"
-tcp6_ipsec_vti17 tcp_ipsec_vti.sh -6 -p esp -a rmd160 -e serpent -m tunnel -s "100 1000 65535"
+tcp6_ipsec_vti01 tcp_ipsec_vti.sh -6 -p ah -m tunnel -s 100:1000:65535
+tcp6_ipsec_vti02 tcp_ipsec_vti.sh -6 -p esp -m tunnel -s 100:1000:65535
+# tcp6_ipsec_vti03 tcp_ipsec_vti.sh -6 -p comp -m tunnel -s 100:1000:65535
+tcp6_ipsec_vti04 tcp_ipsec_vti.sh -6 -A rfc4106_128 -p esp_aead -m tunnel -s 100:1000:65535
+tcp6_ipsec_vti05 tcp_ipsec_vti.sh -6 -A rfc4106_192 -p esp_aead -m tunnel -s 100:1000:65535
+tcp6_ipsec_vti06 tcp_ipsec_vti.sh -6 -A rfc4106_256 -p esp_aead -m tunnel -s 100:1000:65535
+tcp6_ipsec_vti07 tcp_ipsec_vti.sh -6 -A rfc4309_128 -p esp_aead -m tunnel -s 100:1000:65535
+tcp6_ipsec_vti08 tcp_ipsec_vti.sh -6 -A rfc4309_192 -p esp_aead -m tunnel -s 100:1000:65535
+tcp6_ipsec_vti09 tcp_ipsec_vti.sh -6 -A rfc4309_256 -p esp_aead -m tunnel -s 100:1000:65535
+tcp6_ipsec_vti10 tcp_ipsec_vti.sh -6 -A rfc4543_128 -p esp_aead -m tunnel -s 100:1000:65535
+tcp6_ipsec_vti11 tcp_ipsec_vti.sh -6 -A rfc4543_192 -p esp_aead -m tunnel -s 100:1000:65535
+tcp6_ipsec_vti12 tcp_ipsec_vti.sh -6 -A rfc4543_256 -p esp_aead -m tunnel -s 100:1000:65535
+tcp6_ipsec_vti13 tcp_ipsec_vti.sh -6 -p esp -a sha1 -e cast5 -m tunnel -s 100:1000:65535
+tcp6_ipsec_vti14 tcp_ipsec_vti.sh -6 -p esp -a sha256 -e blowfish -m tunnel -s 100:1000:65535
+tcp6_ipsec_vti15 tcp_ipsec_vti.sh -6 -p esp -a sha384 -e twofish -m tunnel -s 100:1000:65535
+tcp6_ipsec_vti16 tcp_ipsec_vti.sh -6 -p esp -a sha512 -e camellia -m tunnel -s 100:1000:65535
+tcp6_ipsec_vti17 tcp_ipsec_vti.sh -6 -p esp -a rmd160 -e serpent -m tunnel -s 100:1000:65535
diff --git a/runtest/net_stress.ipsec_udp b/runtest/net_stress.ipsec_udp
index 76c393f59..4b88c4d1b 100644
--- a/runtest/net_stress.ipsec_udp
+++ b/runtest/net_stress.ipsec_udp
@@ -1,109 +1,109 @@
-udp4_ipsec01 udp_ipsec.sh -s "100 1000 65507"
-udp4_ipsec02 udp_ipsec.sh -p ah -m transport -s "100 1000 65483"
-udp4_ipsec03 udp_ipsec.sh -p ah -m tunnel -s "100 1000 65463"
-udp4_ipsec04 udp_ipsec.sh -p esp -m transport -s "100 1000 65470"
-udp4_ipsec05 udp_ipsec.sh -p esp -m tunnel -s "100 1000 65450"
-udp4_ipsec06 udp_ipsec.sh -p comp -m transport -s "100 1000 65000"
-udp4_ipsec07 udp_ipsec.sh -p comp -m tunnel -s "100 1000 65000"
-udp4_ipsec08 udp_ipsec.sh -A rfc4106_128 -p esp_aead -m transport -s "100 1000 65470"
-udp4_ipsec09 udp_ipsec.sh -A rfc4106_128 -p esp_aead -m tunnel -s "100 1000 65450"
-udp4_ipsec10 udp_ipsec.sh -A rfc4106_192 -p esp_aead -m transport -s "100 1000 65470"
-udp4_ipsec11 udp_ipsec.sh -A rfc4106_192 -p esp_aead -m tunnel -s "100 1000 65450"
-udp4_ipsec12 udp_ipsec.sh -A rfc4106_256 -p esp_aead -m transport -s "100 1000 65470"
-udp4_ipsec13 udp_ipsec.sh -A rfc4106_256 -p esp_aead -m tunnel -s "100 1000 65450"
-udp4_ipsec14 udp_ipsec.sh -A rfc4309_128 -p esp_aead -m transport -s "100 1000 65470"
-udp4_ipsec15 udp_ipsec.sh -A rfc4309_128 -p esp_aead -m tunnel -s "100 1000 65450"
-udp4_ipsec16 udp_ipsec.sh -A rfc4309_192 -p esp_aead -m transport -s "100 1000 65470"
-udp4_ipsec17 udp_ipsec.sh -A rfc4309_192 -p esp_aead -m tunnel -s "100 1000 65450"
-udp4_ipsec18 udp_ipsec.sh -A rfc4309_256 -p esp_aead -m transport -s "100 1000 65470"
-udp4_ipsec19 udp_ipsec.sh -A rfc4309_256 -p esp_aead -m tunnel -s "100 1000 65450"
-udp4_ipsec20 udp_ipsec.sh -A rfc4543_128 -p esp_aead -m transport -s "100 1000 65470"
-udp4_ipsec21 udp_ipsec.sh -A rfc4543_128 -p esp_aead -m tunnel -s "100 1000 65450"
-udp4_ipsec22 udp_ipsec.sh -A rfc4543_192 -p esp_aead -m transport -s "100 1000 65470"
-udp4_ipsec23 udp_ipsec.sh -A rfc4543_192 -p esp_aead -m tunnel -s "100 1000 65450"
-udp4_ipsec24 udp_ipsec.sh -A rfc4543_256 -p esp_aead -m transport -s "100 1000 65470"
-udp4_ipsec25 udp_ipsec.sh -A rfc4543_256 -p esp_aead -m tunnel -s "100 1000 65450"
-udp4_ipsec26 udp_ipsec.sh -p esp -a sha1 -e cast5 -m transport -s "100 1000 65470"
-udp4_ipsec27 udp_ipsec.sh -p esp -a sha1 -e cast5 -m tunnel -s "100 1000 65450"
-udp4_ipsec28 udp_ipsec.sh -p esp -a sha256 -e blowfish -m transport -s "100 1000 65470"
-udp4_ipsec29 udp_ipsec.sh -p esp -a sha256 -e blowfish -m tunnel -s "100 1000 65426"
-udp4_ipsec30 udp_ipsec.sh -p esp -a sha384 -e twofish -m transport -s "100 1000 65446"
-udp4_ipsec31 udp_ipsec.sh -p esp -a sha384 -e twofish -m tunnel -s "100 1000 65426"
-udp4_ipsec32 udp_ipsec.sh -p esp -a sha512 -e camellia -m transport -s "100 1000 65446"
-udp4_ipsec33 udp_ipsec.sh -p esp -a sha512 -e camellia -m tunnel -s "100 1000 65426"
-udp4_ipsec34 udp_ipsec.sh -p esp -a rmd160 -e serpent -m transport -s "100 1000 65446"
-udp4_ipsec35 udp_ipsec.sh -p esp -a rmd160 -e serpent -m tunnel -s "100 1000 65426"
-udp4_ipsec36 udp_ipsec.sh -p esp -m beet -s "100 1000 65446"
+udp4_ipsec01 udp_ipsec.sh -s 100:1000:65507
+udp4_ipsec02 udp_ipsec.sh -p ah -m transport -s 100:1000:65483
+udp4_ipsec03 udp_ipsec.sh -p ah -m tunnel -s 100:1000:65463
+udp4_ipsec04 udp_ipsec.sh -p esp -m transport -s 100:1000:65470
+udp4_ipsec05 udp_ipsec.sh -p esp -m tunnel -s 100:1000:65450
+udp4_ipsec06 udp_ipsec.sh -p comp -m transport -s 100:1000:65000
+udp4_ipsec07 udp_ipsec.sh -p comp -m tunnel -s 100:1000:65000
+udp4_ipsec08 udp_ipsec.sh -A rfc4106_128 -p esp_aead -m transport -s 100:1000:65470
+udp4_ipsec09 udp_ipsec.sh -A rfc4106_128 -p esp_aead -m tunnel -s 100:1000:65450
+udp4_ipsec10 udp_ipsec.sh -A rfc4106_192 -p esp_aead -m transport -s 100:1000:65470
+udp4_ipsec11 udp_ipsec.sh -A rfc4106_192 -p esp_aead -m tunnel -s 100:1000:65450
+udp4_ipsec12 udp_ipsec.sh -A rfc4106_256 -p esp_aead -m transport -s 100:1000:65470
+udp4_ipsec13 udp_ipsec.sh -A rfc4106_256 -p esp_aead -m tunnel -s 100:1000:65450
+udp4_ipsec14 udp_ipsec.sh -A rfc4309_128 -p esp_aead -m transport -s 100:1000:65470
+udp4_ipsec15 udp_ipsec.sh -A rfc4309_128 -p esp_aead -m tunnel -s 100:1000:65450
+udp4_ipsec16 udp_ipsec.sh -A rfc4309_192 -p esp_aead -m transport -s 100:1000:65470
+udp4_ipsec17 udp_ipsec.sh -A rfc4309_192 -p esp_aead -m tunnel -s 100:1000:65450
+udp4_ipsec18 udp_ipsec.sh -A rfc4309_256 -p esp_aead -m transport -s 100:1000:65470
+udp4_ipsec19 udp_ipsec.sh -A rfc4309_256 -p esp_aead -m tunnel -s 100:1000:65450
+udp4_ipsec20 udp_ipsec.sh -A rfc4543_128 -p esp_aead -m transport -s 100:1000:65470
+udp4_ipsec21 udp_ipsec.sh -A rfc4543_128 -p esp_aead -m tunnel -s 100:1000:65450
+udp4_ipsec22 udp_ipsec.sh -A rfc4543_192 -p esp_aead -m transport -s 100:1000:65470
+udp4_ipsec23 udp_ipsec.sh -A rfc4543_192 -p esp_aead -m tunnel -s 100:1000:65450
+udp4_ipsec24 udp_ipsec.sh -A rfc4543_256 -p esp_aead -m transport -s 100:1000:65470
+udp4_ipsec25 udp_ipsec.sh -A rfc4543_256 -p esp_aead -m tunnel -s 100:1000:65450
+udp4_ipsec26 udp_ipsec.sh -p esp -a sha1 -e cast5 -m transport -s 100:1000:65470
+udp4_ipsec27 udp_ipsec.sh -p esp -a sha1 -e cast5 -m tunnel -s 100:1000:65450
+udp4_ipsec28 udp_ipsec.sh -p esp -a sha256 -e blowfish -m transport -s 100:1000:65470
+udp4_ipsec29 udp_ipsec.sh -p esp -a sha256 -e blowfish -m tunnel -s 100:1000:65426
+udp4_ipsec30 udp_ipsec.sh -p esp -a sha384 -e twofish -m transport -s 100:1000:65446
+udp4_ipsec31 udp_ipsec.sh -p esp -a sha384 -e twofish -m tunnel -s 100:1000:65426
+udp4_ipsec32 udp_ipsec.sh -p esp -a sha512 -e camellia -m transport -s 100:1000:65446
+udp4_ipsec33 udp_ipsec.sh -p esp -a sha512 -e camellia -m tunnel -s 100:1000:65426
+udp4_ipsec34 udp_ipsec.sh -p esp -a rmd160 -e serpent -m transport -s 100:1000:65446
+udp4_ipsec35 udp_ipsec.sh -p esp -a rmd160 -e serpent -m tunnel -s 100:1000:65426
+udp4_ipsec36 udp_ipsec.sh -p esp -m beet -s 100:1000:65446
 
-udp6_ipsec01 udp_ipsec.sh -6 -s "100 1000 65527"
-udp6_ipsec02 udp_ipsec.sh -6 -p ah -m transport -s "100 1000 65503"
-udp6_ipsec03 udp_ipsec.sh -6 -p ah -m tunnel -s "100 1000 65527"
-udp6_ipsec04 udp_ipsec.sh -6 -p esp -m transport -s "100 1000 65490"
-udp6_ipsec05 udp_ipsec.sh -6 -p esp -m tunnel -s "100 1000 65527"
-udp6_ipsec06 udp_ipsec.sh -6 -p comp -m transport -s "100 1000 65000"
-udp6_ipsec07 udp_ipsec.sh -6 -p comp -m tunnel -s "100 1000 65000"
-udp6_ipsec08 udp_ipsec.sh -6 -A rfc4106_128 -p esp_aead -m transport -s "100 1000 65490"
-udp6_ipsec09 udp_ipsec.sh -6 -A rfc4106_128 -p esp_aead -m tunnel -s "100 1000 65527"
-udp6_ipsec10 udp_ipsec.sh -6 -A rfc4106_192 -p esp_aead -m transport -s "100 1000 65490"
-udp6_ipsec11 udp_ipsec.sh -6 -A rfc4106_192 -p esp_aead -m tunnel -s "100 1000 65527"
-udp6_ipsec12 udp_ipsec.sh -6 -A rfc4106_256 -p esp_aead -m transport -s "100 1000 65490"
-udp6_ipsec13 udp_ipsec.sh -6 -A rfc4106_256 -p esp_aead -m tunnel -s "100 1000 65527"
-udp6_ipsec14 udp_ipsec.sh -6 -A rfc4309_128 -p esp_aead -m transport -s "100 1000 65490"
-udp6_ipsec15 udp_ipsec.sh -6 -A rfc4309_128 -p esp_aead -m tunnel -s "100 1000 65527"
-udp6_ipsec16 udp_ipsec.sh -6 -A rfc4309_192 -p esp_aead -m transport -s "100 1000 65490"
-udp6_ipsec17 udp_ipsec.sh -6 -A rfc4309_192 -p esp_aead -m tunnel -s "100 1000 65527"
-udp6_ipsec18 udp_ipsec.sh -6 -A rfc4309_256 -p esp_aead -m transport -s "100 1000 65490"
-udp6_ipsec19 udp_ipsec.sh -6 -A rfc4309_256 -p esp_aead -m tunnel -s "100 1000 65527"
-udp6_ipsec20 udp_ipsec.sh -6 -A rfc4543_128 -p esp_aead -m transport -s "100 1000 65490"
-udp6_ipsec21 udp_ipsec.sh -6 -A rfc4543_128 -p esp_aead -m tunnel -s "100 1000 65527"
-udp6_ipsec22 udp_ipsec.sh -6 -A rfc4543_192 -p esp_aead -m transport -s "100 1000 65490"
-udp6_ipsec23 udp_ipsec.sh -6 -A rfc4543_192 -p esp_aead -m tunnel -s "100 1000 65527"
-udp6_ipsec24 udp_ipsec.sh -6 -A rfc4543_256 -p esp_aead -m transport -s "100 1000 65490"
-udp6_ipsec25 udp_ipsec.sh -6 -A rfc4543_256 -p esp_aead -m tunnel -s "100 1000 65527"
-udp6_ipsec26 udp_ipsec.sh -6 -p esp -a sha1 -e cast5 -m transport -s "100 1000 65490"
-udp6_ipsec27 udp_ipsec.sh -6 -p esp -a sha1 -e cast5 -m tunnel -s "100 1000 65527"
-udp6_ipsec28 udp_ipsec.sh -6 -p esp -a sha256 -e blowfish -m transport -s "100 1000 65490"
-udp6_ipsec29 udp_ipsec.sh -6 -p esp -a sha256 -e blowfish -m tunnel -s "100 1000 65527"
-udp6_ipsec30 udp_ipsec.sh -6 -p esp -a sha384 -e twofish -m transport -s "100 1000 65462"
-udp6_ipsec31 udp_ipsec.sh -6 -p esp -a sha384 -e twofish -m tunnel -s "100 1000 65527"
-udp6_ipsec32 udp_ipsec.sh -6 -p esp -a sha512 -e camellia -m transport -s "100 1000 65462"
-udp6_ipsec33 udp_ipsec.sh -6 -p esp -a sha512 -e camellia -m tunnel -s "100 1000 65527"
-udp6_ipsec34 udp_ipsec.sh -6 -p esp -a rmd160 -e serpent -m transport -s "100 1000 65478"
-udp6_ipsec35 udp_ipsec.sh -6 -p esp -a rmd160 -e serpent -m tunnel -s "100 1000 65527"
-udp6_ipsec36 udp_ipsec.sh -6 -p esp -m beet -s "100 1000 65478"
+udp6_ipsec01 udp_ipsec.sh -6 -s 100:1000:65527
+udp6_ipsec02 udp_ipsec.sh -6 -p ah -m transport -s 100:1000:65503
+udp6_ipsec03 udp_ipsec.sh -6 -p ah -m tunnel -s 100:1000:65527
+udp6_ipsec04 udp_ipsec.sh -6 -p esp -m transport -s 100:1000:65490
+udp6_ipsec05 udp_ipsec.sh -6 -p esp -m tunnel -s 100:1000:65527
+udp6_ipsec06 udp_ipsec.sh -6 -p comp -m transport -s 100:1000:65000
+udp6_ipsec07 udp_ipsec.sh -6 -p comp -m tunnel -s 100:1000:65000
+udp6_ipsec08 udp_ipsec.sh -6 -A rfc4106_128 -p esp_aead -m transport -s 100:1000:65490
+udp6_ipsec09 udp_ipsec.sh -6 -A rfc4106_128 -p esp_aead -m tunnel -s 100:1000:65527
+udp6_ipsec10 udp_ipsec.sh -6 -A rfc4106_192 -p esp_aead -m transport -s 100:1000:65490
+udp6_ipsec11 udp_ipsec.sh -6 -A rfc4106_192 -p esp_aead -m tunnel -s 100:1000:65527
+udp6_ipsec12 udp_ipsec.sh -6 -A rfc4106_256 -p esp_aead -m transport -s 100:1000:65490
+udp6_ipsec13 udp_ipsec.sh -6 -A rfc4106_256 -p esp_aead -m tunnel -s 100:1000:65527
+udp6_ipsec14 udp_ipsec.sh -6 -A rfc4309_128 -p esp_aead -m transport -s 100:1000:65490
+udp6_ipsec15 udp_ipsec.sh -6 -A rfc4309_128 -p esp_aead -m tunnel -s 100:1000:65527
+udp6_ipsec16 udp_ipsec.sh -6 -A rfc4309_192 -p esp_aead -m transport -s 100:1000:65490
+udp6_ipsec17 udp_ipsec.sh -6 -A rfc4309_192 -p esp_aead -m tunnel -s 100:1000:65527
+udp6_ipsec18 udp_ipsec.sh -6 -A rfc4309_256 -p esp_aead -m transport -s 100:1000:65490
+udp6_ipsec19 udp_ipsec.sh -6 -A rfc4309_256 -p esp_aead -m tunnel -s 100:1000:65527
+udp6_ipsec20 udp_ipsec.sh -6 -A rfc4543_128 -p esp_aead -m transport -s 100:1000:65490
+udp6_ipsec21 udp_ipsec.sh -6 -A rfc4543_128 -p esp_aead -m tunnel -s 100:1000:65527
+udp6_ipsec22 udp_ipsec.sh -6 -A rfc4543_192 -p esp_aead -m transport -s 100:1000:65490
+udp6_ipsec23 udp_ipsec.sh -6 -A rfc4543_192 -p esp_aead -m tunnel -s 100:1000:65527
+udp6_ipsec24 udp_ipsec.sh -6 -A rfc4543_256 -p esp_aead -m transport -s 100:1000:65490
+udp6_ipsec25 udp_ipsec.sh -6 -A rfc4543_256 -p esp_aead -m tunnel -s 100:1000:65527
+udp6_ipsec26 udp_ipsec.sh -6 -p esp -a sha1 -e cast5 -m transport -s 100:1000:65490
+udp6_ipsec27 udp_ipsec.sh -6 -p esp -a sha1 -e cast5 -m tunnel -s 100:1000:65527
+udp6_ipsec28 udp_ipsec.sh -6 -p esp -a sha256 -e blowfish -m transport -s 100:1000:65490
+udp6_ipsec29 udp_ipsec.sh -6 -p esp -a sha256 -e blowfish -m tunnel -s 100:1000:65527
+udp6_ipsec30 udp_ipsec.sh -6 -p esp -a sha384 -e twofish -m transport -s 100:1000:65462
+udp6_ipsec31 udp_ipsec.sh -6 -p esp -a sha384 -e twofish -m tunnel -s 100:1000:65527
+udp6_ipsec32 udp_ipsec.sh -6 -p esp -a sha512 -e camellia -m transport -s 100:1000:65462
+udp6_ipsec33 udp_ipsec.sh -6 -p esp -a sha512 -e camellia -m tunnel -s 100:1000:65527
+udp6_ipsec34 udp_ipsec.sh -6 -p esp -a rmd160 -e serpent -m transport -s 100:1000:65478
+udp6_ipsec35 udp_ipsec.sh -6 -p esp -a rmd160 -e serpent -m tunnel -s 100:1000:65527
+udp6_ipsec36 udp_ipsec.sh -6 -p esp -m beet -s 100:1000:65478
 
-udp4_ipsec_vti01 udp_ipsec_vti.sh -p ah -m tunnel -s "100 1000 65463"
-udp4_ipsec_vti02 udp_ipsec_vti.sh -p esp -m tunnel -s "100 1000 65450"
+udp4_ipsec_vti01 udp_ipsec_vti.sh -p ah -m tunnel -s 100:1000:65463
+udp4_ipsec_vti02 udp_ipsec_vti.sh -p esp -m tunnel -s 100:1000:65450
 udp4_ipsec_vti03 udp_ipsec_vti.sh -p comp -m tunnel -s 1500
-udp4_ipsec_vti04 udp_ipsec_vti.sh -A rfc4106_128 -p esp_aead -m tunnel -s "100 1000 65450"
-udp4_ipsec_vti05 udp_ipsec_vti.sh -A rfc4106_192 -p esp_aead -m tunnel -s "100 1000 65450"
-udp4_ipsec_vti06 udp_ipsec_vti.sh -A rfc4106_256 -p esp_aead -m tunnel -s "100 1000 65450"
-udp4_ipsec_vti07 udp_ipsec_vti.sh -A rfc4309_128 -p esp_aead -m tunnel -s "100 1000 65450"
-udp4_ipsec_vti08 udp_ipsec_vti.sh -A rfc4309_192 -p esp_aead -m tunnel -s "100 1000 65450"
-udp4_ipsec_vti09 udp_ipsec_vti.sh -A rfc4309_256 -p esp_aead -m tunnel -s "100 1000 65450"
-udp4_ipsec_vti10 udp_ipsec_vti.sh -A rfc4543_128 -p esp_aead -m tunnel -s "100 1000 65450"
-udp4_ipsec_vti11 udp_ipsec_vti.sh -A rfc4543_192 -p esp_aead -m tunnel -s "100 1000 65450"
-udp4_ipsec_vti12 udp_ipsec_vti.sh -A rfc4543_256 -p esp_aead -m tunnel -s "100 1000 65450"
-udp4_ipsec_vti13 udp_ipsec_vti.sh -p esp -a sha1 -e cast5 -m tunnel -s "100 1000 65450"
-udp4_ipsec_vti14 udp_ipsec_vti.sh -p esp -a sha256 -e blowfish -m tunnel -s "100 1000 65426"
-udp4_ipsec_vti15 udp_ipsec_vti.sh -p esp -a sha384 -e twofish -m tunnel -s "100 1000 65426"
-udp4_ipsec_vti16 udp_ipsec_vti.sh -p esp -a sha512 -e camellia -m tunnel -s "100 1000 65426"
-udp4_ipsec_vti17 udp_ipsec_vti.sh -p esp -a rmd160 -e serpent -m tunnel -s "100 1000 65426"
+udp4_ipsec_vti04 udp_ipsec_vti.sh -A rfc4106_128 -p esp_aead -m tunnel -s 100:1000:65450
+udp4_ipsec_vti05 udp_ipsec_vti.sh -A rfc4106_192 -p esp_aead -m tunnel -s 100:1000:65450
+udp4_ipsec_vti06 udp_ipsec_vti.sh -A rfc4106_256 -p esp_aead -m tunnel -s 100:1000:65450
+udp4_ipsec_vti07 udp_ipsec_vti.sh -A rfc4309_128 -p esp_aead -m tunnel -s 100:1000:65450
+udp4_ipsec_vti08 udp_ipsec_vti.sh -A rfc4309_192 -p esp_aead -m tunnel -s 100:1000:65450
+udp4_ipsec_vti09 udp_ipsec_vti.sh -A rfc4309_256 -p esp_aead -m tunnel -s 100:1000:65450
+udp4_ipsec_vti10 udp_ipsec_vti.sh -A rfc4543_128 -p esp_aead -m tunnel -s 100:1000:65450
+udp4_ipsec_vti11 udp_ipsec_vti.sh -A rfc4543_192 -p esp_aead -m tunnel -s 100:1000:65450
+udp4_ipsec_vti12 udp_ipsec_vti.sh -A rfc4543_256 -p esp_aead -m tunnel -s 100:1000:65450
+udp4_ipsec_vti13 udp_ipsec_vti.sh -p esp -a sha1 -e cast5 -m tunnel -s 100:1000:65450
+udp4_ipsec_vti14 udp_ipsec_vti.sh -p esp -a sha256 -e blowfish -m tunnel -s 100:1000:65426
+udp4_ipsec_vti15 udp_ipsec_vti.sh -p esp -a sha384 -e twofish -m tunnel -s 100:1000:65426
+udp4_ipsec_vti16 udp_ipsec_vti.sh -p esp -a sha512 -e camellia -m tunnel -s 100:1000:65426
+udp4_ipsec_vti17 udp_ipsec_vti.sh -p esp -a rmd160 -e serpent -m tunnel -s 100:1000:65426
 
-udp6_ipsec_vti01 udp_ipsec_vti.sh -6 -p ah -m tunnel -s "100 1000 65527"
-udp6_ipsec_vti02 udp_ipsec_vti.sh -6 -p esp -m tunnel -s "100 1000 65527"
+udp6_ipsec_vti01 udp_ipsec_vti.sh -6 -p ah -m tunnel -s 100:1000:65527
+udp6_ipsec_vti02 udp_ipsec_vti.sh -6 -p esp -m tunnel -s 100:1000:65527
 udp6_ipsec_vti03 udp_ipsec_vti.sh -6 -p comp -m tunnel -s 1500
-udp6_ipsec_vti04 udp_ipsec_vti.sh -6 -A rfc4106_128 -p esp_aead -m tunnel -s "100 1000 65527"
-udp6_ipsec_vti05 udp_ipsec_vti.sh -6 -A rfc4106_192 -p esp_aead -m tunnel -s "100 1000 65527"
-udp6_ipsec_vti06 udp_ipsec_vti.sh -6 -A rfc4106_256 -p esp_aead -m tunnel -s "100 1000 65527"
-udp6_ipsec_vti07 udp_ipsec_vti.sh -6 -A rfc4309_128 -p esp_aead -m tunnel -s "100 1000 65527"
-udp6_ipsec_vti08 udp_ipsec_vti.sh -6 -A rfc4309_192 -p esp_aead -m tunnel -s "100 1000 65527"
-udp6_ipsec_vti09 udp_ipsec_vti.sh -6 -A rfc4309_256 -p esp_aead -m tunnel -s "100 1000 65527"
-udp6_ipsec_vti10 udp_ipsec_vti.sh -6 -A rfc4543_128 -p esp_aead -m tunnel -s "100 1000 65527"
-udp6_ipsec_vti11 udp_ipsec_vti.sh -6 -A rfc4543_192 -p esp_aead -m tunnel -s "100 1000 65527"
-udp6_ipsec_vti12 udp_ipsec_vti.sh -6 -A rfc4543_256 -p esp_aead -m tunnel -s "100 1000 65527"
-udp6_ipsec_vti13 udp_ipsec_vti.sh -6 -p esp -a sha1 -e cast5 -m tunnel -s "100 1000 65527"
-udp6_ipsec_vti14 udp_ipsec_vti.sh -6 -p esp -a sha256 -e blowfish -m tunnel -s "100 1000 65527"
-udp6_ipsec_vti15 udp_ipsec_vti.sh -6 -p esp -a sha384 -e twofish -m tunnel -s "100 1000 65527"
-udp6_ipsec_vti16 udp_ipsec_vti.sh -6 -p esp -a sha512 -e camellia -m tunnel -s "100 1000 65527"
-udp6_ipsec_vti17 udp_ipsec_vti.sh -6 -p esp -a rmd160 -e serpent -m tunnel -s "100 1000 65527"
+udp6_ipsec_vti04 udp_ipsec_vti.sh -6 -A rfc4106_128 -p esp_aead -m tunnel -s 100:1000:65527
+udp6_ipsec_vti05 udp_ipsec_vti.sh -6 -A rfc4106_192 -p esp_aead -m tunnel -s 100:1000:65527
+udp6_ipsec_vti06 udp_ipsec_vti.sh -6 -A rfc4106_256 -p esp_aead -m tunnel -s 100:1000:65527
+udp6_ipsec_vti07 udp_ipsec_vti.sh -6 -A rfc4309_128 -p esp_aead -m tunnel -s 100:1000:65527
+udp6_ipsec_vti08 udp_ipsec_vti.sh -6 -A rfc4309_192 -p esp_aead -m tunnel -s 100:1000:65527
+udp6_ipsec_vti09 udp_ipsec_vti.sh -6 -A rfc4309_256 -p esp_aead -m tunnel -s 100:1000:65527
+udp6_ipsec_vti10 udp_ipsec_vti.sh -6 -A rfc4543_128 -p esp_aead -m tunnel -s 100:1000:65527
+udp6_ipsec_vti11 udp_ipsec_vti.sh -6 -A rfc4543_192 -p esp_aead -m tunnel -s 100:1000:65527
+udp6_ipsec_vti12 udp_ipsec_vti.sh -6 -A rfc4543_256 -p esp_aead -m tunnel -s 100:1000:65527
+udp6_ipsec_vti13 udp_ipsec_vti.sh -6 -p esp -a sha1 -e cast5 -m tunnel -s 100:1000:65527
+udp6_ipsec_vti14 udp_ipsec_vti.sh -6 -p esp -a sha256 -e blowfish -m tunnel -s 100:1000:65527
+udp6_ipsec_vti15 udp_ipsec_vti.sh -6 -p esp -a sha384 -e twofish -m tunnel -s 100:1000:65527
+udp6_ipsec_vti16 udp_ipsec_vti.sh -6 -p esp -a sha512 -e camellia -m tunnel -s 100:1000:65527
+udp6_ipsec_vti17 udp_ipsec_vti.sh -6 -p esp -a rmd160 -e serpent -m tunnel -s 100:1000:65527
diff --git a/testcases/network/stress/ipsec/ipsec_lib.sh b/testcases/network/stress/ipsec/ipsec_lib.sh
index 9c293ca3e..afa7c7c75 100644
--- a/testcases/network/stress/ipsec/ipsec_lib.sh
+++ b/testcases/network/stress/ipsec/ipsec_lib.sh
@@ -30,7 +30,7 @@ AALGO="sha1"
 CALGO="deflate"
 
 IPSEC_REQUESTS="500"
-IPSEC_SIZE_ARRAY="${IPSEC_SIZE_ARRAY:-10 100 1000 2000 10000 65000}"
+IPSEC_SIZE_ARRAY="${IPSEC_SIZE_ARRAY:-10:100:1000:2000:10000:65000}"
 
 ipsec_lib_parse_args()
 {
@@ -41,7 +41,7 @@ ipsec_lib_parse_args()
 		echo "l n      n is the number of test link when tests run"
 		echo "m x      x is ipsec mode, could be transport / tunnel"
 		echo "p x      x is ipsec protocol, could be ah / esp / comp"
-		echo "s x      x is icmp message size array"
+		echo "s x      x is icmp message size array (items separated by ':')"
 		echo "S n      n is IPsec SPI value"
 		echo "k x      key for vti interface"
 		echo "A x      Authenticated encryption with associated data algorithm"
@@ -65,6 +65,14 @@ ipsec_lib_parse_args()
 	r) IPSEC_REQUESTS="$2" ;;
 	*) tst_brkm TBROK "unknown option: $1" ;;
 	esac
+
+	local IFS=":"
+	local tmp="$IPSEC_SIZE_ARRAY"
+	local p
+	for p in $IPSEC_SIZE_ARRAY; do
+		tmp="$p "
+	done
+	IPSEC_SIZE_ARRAY="$tmp"
 }
 
 TST_OPTS="hl:m:p:s:S:k:A:e:a:c:r:"
-- 
2.17.1

