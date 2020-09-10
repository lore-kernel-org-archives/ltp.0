From: Chen Hanxiao <chen_han_xiao@126.com>
Date: Thu, 10 Sep 2020 09:56:31 -0400
Subject: [LTP] [PATCH] ns-tools/set_ipv4addr: Use ip command as default
Message-ID: <1599746191-2012-1-git-send-email-chen_han_xiao@126.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Chen Hanxiao <chenhx.fnst@cn.fujitsu.com>

Set iproute as the default as ifconfig
has been deprecated on some of the distributions.

Signed-off-by: Chen Hanxiao <chenhx.fnst@cn.fujitsu.com>
---
 testcases/network/stress/ns-tools/set_ipv4addr | 40 +++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 7 deletions(-)

diff --git a/testcases/network/stress/ns-tools/set_ipv4addr b/testcases/network/stress/ns-tools/set_ipv4addr
index 1ec0769..baf5d4a 100644
--- a/testcases/network/stress/ns-tools/set_ipv4addr
+++ b/testcases/network/stress/ns-tools/set_ipv4addr
@@ -57,6 +57,8 @@ export LTPROOT
 # Check the environmanet variable for the test
 . check_envval || exit 1
 
+CMD="${CMD:-ip}"
+
 # Arguments
 if [ $# -ne 4 ]; then
     echo "Usage: $0 host_type link_num network_portion host_portion" >&2
@@ -77,17 +79,41 @@ fi
 addr=${network_part}.${host_part}
 netmask=`echo $network_part | sed "s/[[:digit:]]*/255/g"`.`echo $host_part | sed "s/[[:digit:]]*/0/g"`
 broadcast=${network_part}.`echo $host_part | sed "s/[[:digit:]]*/255/g"`
+prefix=0
+
+netmask_to_prefix()
+{
+    bits=0
+    for octet in $(echo $1| sed 's/\./ /g'); do
+        binbits=$(echo "obase=2; ibase=10; ${octet}"| bc | sed 's/0//g')
+        let bits+=${#binbits}
+    done
+    prefix=$bits
+}
+
+netmask_to_prefix $netmask
 
 # Assign IPv4 address to the interface belongs the link_num Test Link
 ifname=`get_ifname $host_type $link_num` || exit 1
 
-if [ $host_type = lhost ]; then
-    ifconfig $ifname up
-    ifconfig $ifname $addr netmask $netmask broadcast $broadcast
-    ret=$?
-else
-    ret=`$LTP_RSH $RHOST '( PATH=/sbin:/usr/sbin:$PATH ; ifconfig '$ifname' up && ifconfig '$ifname $addr' netmask '$netmask' broadcast '$broadcast' ) >/dev/null 2>&1; echo $?'`
-fi
+case $CMD in
+    ip)
+        if [ $host_type = lhost ]; then
+            ip link set $ifname up
+            ip address add $addr'/'$prefix dev $ifname broadcast $broadcast
+            ret=$?
+        else
+            ret=`$LTP_RSH $RHOST '( PATH=/sbin:/usr/sbin:$PATH ; ip link set '$ifname' up && ip address add '$addr'/'$prefix' dev '$ifname' broadcast '$broadcast' ) >/dev/null 2>&1; echo $?'`
+        fi ;;
+ifconfig)
+        if [ $host_type = lhost ]; then
+            ifconfig $ifname up
+            ifconfig $ifname $addr netmask $netmask broadcast $broadcast
+            ret=$?
+        else
+            ret=`$LTP_RSH $RHOST '( PATH=/sbin:/usr/sbin:$PATH ; ifconfig '$ifname' up && ifconfig '$ifname $addr' netmask '$netmask' broadcast '$broadcast' ) >/dev/null 2>&1; echo $?'`
+        fi ;;
+esac
 
 if [ $ret -gt 0 ]; then
     echo "Cannot set $addr to $ifname" >&2
-- 
1.8.3.1

