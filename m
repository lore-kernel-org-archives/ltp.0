From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 28 Nov 2017 18:05:04 +0300
Subject: [LTP] [PATCH] ipsec: fix vti ipcomp test-cases
Message-ID: <1511881504-13160-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

VTI is not designed to handle ipcomp when packets sent without
transformation, see also: https://patchwork.ozlabs.org/patch/840445/

Adjust test-cases so that ipcomp header always used.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 runtest/net_stress.ipsec_dccp |    4 ++--
 runtest/net_stress.ipsec_icmp |    3 +++
 runtest/net_stress.ipsec_sctp |    4 ++--
 runtest/net_stress.ipsec_tcp  |    4 ++--
 runtest/net_stress.ipsec_udp  |    4 ++--
 5 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/runtest/net_stress.ipsec_dccp b/runtest/net_stress.ipsec_dccp
index f736c8a..d867ab5 100644
--- a/runtest/net_stress.ipsec_dccp
+++ b/runtest/net_stress.ipsec_dccp
@@ -74,7 +74,7 @@ dccp6_ipsec36 dccp_ipsec.sh -6 -p esp -m beet -s "100 500 1000"
 
 dccp4_ipsec_vti01 dccp_ipsec_vti.sh -p ah -m tunnel -s "100 500 1000"
 dccp4_ipsec_vti02 dccp_ipsec_vti.sh -p esp -m tunnel -s "100 500 1000"
-dccp4_ipsec_vti03 dccp_ipsec_vti.sh -p comp -m tunnel -s "100 500 1000"
+# dccp4_ipsec_vti03 dccp_ipsec_vti.sh -p comp -m tunnel -s "100 500 1000"
 dccp4_ipsec_vti04 dccp_ipsec_vti.sh -A rfc4106_128 -p esp_aead -m tunnel -s "100 500 1000"
 dccp4_ipsec_vti05 dccp_ipsec_vti.sh -A rfc4106_192 -p esp_aead -m tunnel -s "100 500 1000"
 dccp4_ipsec_vti06 dccp_ipsec_vti.sh -A rfc4106_256 -p esp_aead -m tunnel -s "100 500 1000"
@@ -92,7 +92,7 @@ dccp4_ipsec_vti17 dccp_ipsec_vti.sh -p esp -a rmd160 -e serpent -m tunnel -s "10
 
 dccp6_ipsec_vti01 dccp_ipsec_vti.sh -6 -p ah -m tunnel -s "100 500 1000"
 dccp6_ipsec_vti02 dccp_ipsec_vti.sh -6 -p esp -m tunnel -s "100 500 1000"
-dccp6_ipsec_vti03 dccp_ipsec_vti.sh -6 -p comp -m tunnel -s "100 500 1000"
+# dccp6_ipsec_vti03 dccp_ipsec_vti.sh -6 -p comp -m tunnel -s "100 500 1000"
 dccp6_ipsec_vti04 dccp_ipsec_vti.sh -6 -A rfc4106_128 -p esp_aead -m tunnel -s "100 500 1000"
 dccp6_ipsec_vti05 dccp_ipsec_vti.sh -6 -A rfc4106_192 -p esp_aead -m tunnel -s "100 500 1000"
 dccp6_ipsec_vti06 dccp_ipsec_vti.sh -6 -A rfc4106_256 -p esp_aead -m tunnel -s "100 500 1000"
diff --git a/runtest/net_stress.ipsec_icmp b/runtest/net_stress.ipsec_icmp
index 9c9a4ab..a765903 100644
--- a/runtest/net_stress.ipsec_icmp
+++ b/runtest/net_stress.ipsec_icmp
@@ -97,6 +97,7 @@ icmp4-uni-vti13 icmp-uni-vti.sh -A rfc4309_256 -p esp_aead -m tunnel -s "10 100
 icmp4-uni-vti14 icmp-uni-vti.sh -A rfc4543_128 -p esp_aead -m tunnel -s "10 100 1000 10000 65463"
 icmp4-uni-vti15 icmp-uni-vti.sh -A rfc4543_192 -p esp_aead -m tunnel -s "10 100 1000 10000 65463"
 icmp4-uni-vti16 icmp-uni-vti.sh -A rfc4543_256 -p esp_aead -m tunnel -s "10 100 1000 10000 65463"
+icmp4-uni-vti17 icmp-uni-vti.sh -p comp -m tunnel -s 1500
 
 icmp6-uni-vti01 icmp-uni-vti.sh -6 -p ah -m tunnel -S fffffffe -k 0xffffffff -s "10 100 1000 10000 65527"
 icmp6-uni-vti02 icmp-uni-vti.sh -6 -p esp -a sha256 -e des3_ede -m tunnel -S fffffffe -k 0xffffffff -s "10 100 1000 10000 65527"
@@ -114,3 +115,5 @@ icmp6-uni-vti13 icmp-uni-vti.sh -6 -A rfc4309_256 -p esp_aead -m tunnel -s "10 1
 icmp6-uni-vti14 icmp-uni-vti.sh -6 -A rfc4543_128 -p esp_aead -m tunnel -s "10 100 1000 10000 65527"
 icmp6-uni-vti15 icmp-uni-vti.sh -6 -A rfc4543_192 -p esp_aead -m tunnel -s "10 100 1000 10000 65527"
 icmp6-uni-vti16 icmp-uni-vti.sh -6 -A rfc4543_256 -p esp_aead -m tunnel -s "10 100 1000 10000 65527"
+icmp6-uni-vti17 icmp-uni-vti.sh -6 -p comp -m tunnel -s 1500
+
diff --git a/runtest/net_stress.ipsec_sctp b/runtest/net_stress.ipsec_sctp
index b72fb7e..e71f951 100644
--- a/runtest/net_stress.ipsec_sctp
+++ b/runtest/net_stress.ipsec_sctp
@@ -74,7 +74,7 @@ sctp6_ipsec36 sctp_ipsec.sh -6 -p esp -m beet -s "100 1000 65535"
 
 sctp4_ipsec_vti01 sctp_ipsec_vti.sh -p ah -m tunnel -s "100 1000 65535"
 sctp4_ipsec_vti02 sctp_ipsec_vti.sh -p esp -m tunnel -s "100 1000 65535"
-sctp4_ipsec_vti03 sctp_ipsec_vti.sh -p comp -m tunnel -s "100 1000 65535"
+# sctp4_ipsec_vti03 sctp_ipsec_vti.sh -p comp -m tunnel -s "100 1000 65535"
 sctp4_ipsec_vti04 sctp_ipsec_vti.sh -A rfc4106_128 -p esp_aead -m tunnel -s "100 1000 65535"
 sctp4_ipsec_vti05 sctp_ipsec_vti.sh -A rfc4106_192 -p esp_aead -m tunnel -s "100 1000 65535"
 sctp4_ipsec_vti06 sctp_ipsec_vti.sh -A rfc4106_256 -p esp_aead -m tunnel -s "100 1000 65535"
@@ -92,7 +92,7 @@ sctp4_ipsec_vti17 sctp_ipsec_vti.sh -p esp -a rmd160 -e serpent -m tunnel -s "10
 
 sctp6_ipsec_vti01 sctp_ipsec_vti.sh -6 -p ah -m tunnel -s "100 1000 65535"
 sctp6_ipsec_vti02 sctp_ipsec_vti.sh -6 -p esp -m tunnel -s "100 1000 65535"
-sctp6_ipsec_vti03 sctp_ipsec_vti.sh -6 -p comp -m tunnel -s "100 1000 65535"
+# sctp6_ipsec_vti03 sctp_ipsec_vti.sh -6 -p comp -m tunnel -s "100 1000 65535"
 sctp6_ipsec_vti04 sctp_ipsec_vti.sh -6 -A rfc4106_128 -p esp_aead -m tunnel -s "100 1000 65535"
 sctp6_ipsec_vti05 sctp_ipsec_vti.sh -6 -A rfc4106_192 -p esp_aead -m tunnel -s "100 1000 65535"
 sctp6_ipsec_vti06 sctp_ipsec_vti.sh -6 -A rfc4106_256 -p esp_aead -m tunnel -s "100 1000 65535"
diff --git a/runtest/net_stress.ipsec_tcp b/runtest/net_stress.ipsec_tcp
index 9b1a615..30e0f4a 100644
--- a/runtest/net_stress.ipsec_tcp
+++ b/runtest/net_stress.ipsec_tcp
@@ -74,7 +74,7 @@ tcp6_ipsec36 tcp_ipsec.sh -6 -p esp -m beet -s "100 1000 65535"
 
 tcp4_ipsec_vti01 tcp_ipsec_vti.sh -p ah -m tunnel -s "100 1000 65535"
 tcp4_ipsec_vti02 tcp_ipsec_vti.sh -p esp -m tunnel -s "100 1000 65535"
-tcp4_ipsec_vti03 tcp_ipsec_vti.sh -p comp -m tunnel -s "100 1000 65535"
+# tcp4_ipsec_vti03 tcp_ipsec_vti.sh -p comp -m tunnel -s "100 1000 65535"
 tcp4_ipsec_vti04 tcp_ipsec_vti.sh -A rfc4106_128 -p esp_aead -m tunnel -s "100 1000 65535"
 tcp4_ipsec_vti05 tcp_ipsec_vti.sh -A rfc4106_192 -p esp_aead -m tunnel -s "100 1000 65535"
 tcp4_ipsec_vti06 tcp_ipsec_vti.sh -A rfc4106_256 -p esp_aead -m tunnel -s "100 1000 65535"
@@ -92,7 +92,7 @@ tcp4_ipsec_vti17 tcp_ipsec_vti.sh -p esp -a rmd160 -e serpent -m tunnel -s "100
 
 tcp6_ipsec_vti01 tcp_ipsec_vti.sh -6 -p ah -m tunnel -s "100 1000 65535"
 tcp6_ipsec_vti02 tcp_ipsec_vti.sh -6 -p esp -m tunnel -s "100 1000 65535"
-tcp6_ipsec_vti03 tcp_ipsec_vti.sh -6 -p comp -m tunnel -s "100 1000 65535"
+# tcp6_ipsec_vti03 tcp_ipsec_vti.sh -6 -p comp -m tunnel -s "100 1000 65535"
 tcp6_ipsec_vti04 tcp_ipsec_vti.sh -6 -A rfc4106_128 -p esp_aead -m tunnel -s "100 1000 65535"
 tcp6_ipsec_vti05 tcp_ipsec_vti.sh -6 -A rfc4106_192 -p esp_aead -m tunnel -s "100 1000 65535"
 tcp6_ipsec_vti06 tcp_ipsec_vti.sh -6 -A rfc4106_256 -p esp_aead -m tunnel -s "100 1000 65535"
diff --git a/runtest/net_stress.ipsec_udp b/runtest/net_stress.ipsec_udp
index 3f529ea..76c393f 100644
--- a/runtest/net_stress.ipsec_udp
+++ b/runtest/net_stress.ipsec_udp
@@ -74,7 +74,7 @@ udp6_ipsec36 udp_ipsec.sh -6 -p esp -m beet -s "100 1000 65478"
 
 udp4_ipsec_vti01 udp_ipsec_vti.sh -p ah -m tunnel -s "100 1000 65463"
 udp4_ipsec_vti02 udp_ipsec_vti.sh -p esp -m tunnel -s "100 1000 65450"
-udp4_ipsec_vti03 udp_ipsec_vti.sh -p comp -m tunnel -s "100 1000 65000"
+udp4_ipsec_vti03 udp_ipsec_vti.sh -p comp -m tunnel -s 1500
 udp4_ipsec_vti04 udp_ipsec_vti.sh -A rfc4106_128 -p esp_aead -m tunnel -s "100 1000 65450"
 udp4_ipsec_vti05 udp_ipsec_vti.sh -A rfc4106_192 -p esp_aead -m tunnel -s "100 1000 65450"
 udp4_ipsec_vti06 udp_ipsec_vti.sh -A rfc4106_256 -p esp_aead -m tunnel -s "100 1000 65450"
@@ -92,7 +92,7 @@ udp4_ipsec_vti17 udp_ipsec_vti.sh -p esp -a rmd160 -e serpent -m tunnel -s "100
 
 udp6_ipsec_vti01 udp_ipsec_vti.sh -6 -p ah -m tunnel -s "100 1000 65527"
 udp6_ipsec_vti02 udp_ipsec_vti.sh -6 -p esp -m tunnel -s "100 1000 65527"
-udp6_ipsec_vti03 udp_ipsec_vti.sh -6 -p comp -m tunnel -s "100 1000 65000"
+udp6_ipsec_vti03 udp_ipsec_vti.sh -6 -p comp -m tunnel -s 1500
 udp6_ipsec_vti04 udp_ipsec_vti.sh -6 -A rfc4106_128 -p esp_aead -m tunnel -s "100 1000 65527"
 udp6_ipsec_vti05 udp_ipsec_vti.sh -6 -A rfc4106_192 -p esp_aead -m tunnel -s "100 1000 65527"
 udp6_ipsec_vti06 udp_ipsec_vti.sh -6 -A rfc4106_256 -p esp_aead -m tunnel -s "100 1000 65527"
-- 
1.7.1

