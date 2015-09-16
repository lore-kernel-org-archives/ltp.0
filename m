From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 16 Sep 2015 12:41:47 +0300
Subject: [LTP] [PATCH resend] network/virt/vxlan: add dstport option if ip
	supports it
Message-ID: <1442396507-29678-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Newer versions of 'iproute' complain about not set VxLAN
'dstport' option:

  vxlan: destination port not specified
  Will use Linux kernel default (non-standard value)
  Use 'dstport 4789' to get the IANA assigned value
  Use 'dstport 0' to get default and quiet this message

This message interferes with the actual test output. If 'iproute'
supports the option, set it when adding new VxLAN devices.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/virt/virt_lib.sh |    9 ++++++++-
 testcases/network/virt/vxlan03.sh  |    2 +-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/testcases/network/virt/virt_lib.sh b/testcases/network/virt/virt_lib.sh
index e798b2c..d582284 100644
--- a/testcases/network/virt/virt_lib.sh
+++ b/testcases/network/virt/virt_lib.sh
@@ -43,6 +43,7 @@ client_requests=500000
 max_requests=3
 net_load="TFO"
 virt_threshold=80
+vxlan_dstport=0
 
 while getopts :hsx:i:r:c:R:p:n:l:t:d:6 opt; do
 	case "$opt" in
@@ -105,6 +106,7 @@ virt_add()
 	case $virt_type in
 	vlan|vxlan)
 		[ -z "$opt" ] && opt="id 4094"
+		[ "$vxlan_dstport" -eq 1 ] && opt="dstport 0 $opt"
 	;;
 	gre|ip6gre)
 		[ -z "$opt" ] && \
@@ -127,9 +129,11 @@ virt_add()
 
 virt_add_rhost()
 {
+	local opt=""
 	case $virt_type in
 	vxlan)
-		tst_rhost_run -s -c "ip li add ltp_v0 type $virt_type $@"
+		[ "$vxlan_dstport" -eq 1 ] && opt="dstport 0"
+		tst_rhost_run -s -c "ip li add ltp_v0 type $virt_type $@ $opt"
 	;;
 	gre|ip6gre)
 		tst_rhost_run -s -c "ip -f inet$TST_IPV6 tu add ltp_v0 \
@@ -372,6 +376,9 @@ vxlan)
 		tst_kvercmp 3 12 0 && \
 			tst_brkm TCONF "test must be run with kernels >= 3.12"
 	fi
+
+	# newer versions of 'ip' complain if this option not set
+	ip li add type vxlan help 2>&1 | grep -q dstport && vxlan_dstport=1
 ;;
 esac
 
diff --git a/testcases/network/virt/vxlan03.sh b/testcases/network/virt/vxlan03.sh
index 55523da..65a71aa 100755
--- a/testcases/network/virt/vxlan03.sh
+++ b/testcases/network/virt/vxlan03.sh
@@ -60,7 +60,7 @@ if [ -z $ip_local -o -z $ip_remote ]; then
 	tst_brkm TBROK "you must specify IP address"
 fi
 
-opts=" ,dstport 0 gbp"
+opts=" ,gbp"
 
 for n in $(seq 1 2); do
 	p="$(echo $opts | cut -d',' -f$n)"
-- 
1.7.1

