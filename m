Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1YBjPk-0005zp-Vg
	for ltp-list@lists.sourceforge.net; Thu, 15 Jan 2015 12:20:41 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YBjPi-0005Ki-Cs
	for ltp-list@lists.sourceforge.net; Thu, 15 Jan 2015 12:20:40 +0000
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 15 Jan 2015 15:22:38 +0300
Message-Id: <1421324561-6680-2-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1421324561-6680-1-git-send-email-alexey.kodanev@oracle.com>
References: <1421324561-6680-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH 1/4] network/stress/dns: rename dns4-stress script
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: vasily.isaenko@oracle.com, akodanev <akodanev@gmail.com>

From: akodanev <akodanev@gmail.com>

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/stress/dns/dns-stress  |  366 ++++++++++++++++++++++++++++
 testcases/network/stress/dns/dns4-stress |  366 ----------------------------
 testcases/network/stress/dns/dns6-stress |  381 ------------------------------
 3 files changed, 366 insertions(+), 747 deletions(-)
 create mode 100644 testcases/network/stress/dns/dns-stress
 delete mode 100644 testcases/network/stress/dns/dns4-stress
 delete mode 100644 testcases/network/stress/dns/dns6-stress

diff --git a/testcases/network/stress/dns/dns-stress b/testcases/network/stress/dns/dns-stress
new file mode 100644
index 0000000..7b13bff
--- /dev/null
+++ b/testcases/network/stress/dns/dns-stress
@@ -0,0 +1,366 @@
+#!/bin/sh
+
+################################################################################
+##                                                                            ##
+## Copyright (c) International Business Machines  Corp., 2005                 ##
+##                                                                            ##
+## This program is free software;  you can redistribute it and#or modify      ##
+## it under the terms of the GNU General Public License as published by       ##
+## the Free Software Foundation; either version 2 of the License, or          ##
+## (at your option) any later version.                                        ##
+##                                                                            ##
+## This program is distributed in the hope that it will be useful, but        ##
+## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
+## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
+## for more details.                                                          ##
+##                                                                            ##
+## You should have received a copy of the GNU General Public License          ##
+## along with this program;  if not, write to the Free Software               ##
+## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
+##                                                                            ##
+##                                                                            ##
+################################################################################
+#
+# File:
+#   dns4-stress
+#
+# Description:
+#   Stress test for dns over IPv4
+#   test01 - Verify the dns server or the kernel is not down after the dns
+#            server handles a large number of name lookup querys
+#   test02 - Verify the dns server or the kernel is not down after the dns
+#            server handles a large number of reverse lookup querys
+#
+# Author:
+#   Mitsuru Chinen <mitch@jp.ibm.com>
+#
+# History:
+#	Oct 19 2005 - Created (Mitsuru Chinen)
+#
+#-----------------------------------------------------------------------
+# Uncomment line below for debug output.
+#trace_logic=${trace_logic:-"set -x"}
+$trace_logic
+
+# Make sure the value of LTPROOT
+LTPROOT=${LTPROOT:-`(cd ../../../../ ; pwd)`}
+export LTPROOT
+
+# Total number of the test case
+TST_TOTAL=2
+export TST_TOTAL
+
+# Default of the test case ID and the test case count
+TCID=dns4-stress
+TST_COUNT=0
+export TCID
+export TST_COUNT
+
+# Check the environmanet variable
+. check_envval || exit $TST_TOTAL
+
+# The times of query
+NS_TIMES=${NS_TIMES:-10000}
+
+# The number of the test link where tests run
+LINK_NUM=0
+
+# Network portion of the IPv4 address
+IPV4_NETWORK=${IPV4_NETWORK:-"10.0.0"}
+
+# Reverse network portion of the IPv4 address
+IPV4_NETWORK_REVERSE=${IPV4_NETWORK_REVERSE:-"0.0.10"}
+
+# Host portion of the IPv4 address on the local host
+LHOST_IPV4_HOST=${LHOST_IPV4_HOST:-"2"}
+
+# Host portion of the IPv4 address on the remote host
+RHOST_IPV4_HOST=${RHOST_IPV4_HOST:-"1"}
+
+# Minumum host ID in the zone file. The ID is used as the host portion of
+# of the address
+MINIMUM_ID=3
+
+# Maximum host ID in the zone file.
+MAXIMUM_ID=254
+
+# Domain name for testing
+DOMAIN="ltp-ns.org"
+
+
+#-----------------------------------------------------------------------
+#
+# Function:
+#   do_cleanup
+#
+# Description:
+#   Clean up after running dns stress test
+#
+#-----------------------------------------------------------------------
+do_cleanup()
+{
+    # Stop the dns daemon
+    kill `cat ${named_dir}/named.pid` >/dev/null 2>&1
+
+    # Delete the temprary files/direcrories
+    rm -rf $named_dir
+    rm -f $message_file
+
+    # Initialize the interface
+    initialize_if lhost $LINK_NUM
+    initialize_if rhost $LINK_NUM
+}
+
+
+#-----------------------------------------------------------------------
+#
+# Function:
+#   do_setup
+#
+# Description:
+#   Setup for the dns stress tests
+#   - Assign IP address to the interfaces belong to the specified Link
+#   - Run a named daemon for testing
+#
+# Set Values:
+#   lhost_addr: IP address of the local host
+#   rhost_addr: IP address of the remote host
+#   port:	port number to accept the dns query
+#
+#-----------------------------------------------------------------------
+do_setup()
+{
+    trap do_cleanup 0
+
+    # Initialize the interface
+    initialize_if lhost $LINK_NUM
+    initialize_if rhost $LINK_NUM
+
+    # Get the Interface name
+    lhost_ifname=`get_ifname lhost $LINK_NUM`
+    if [ $? -ne 0 ]; then
+	tst_resm TBROK "Failed to get the interface name at the local host"
+	exit $TST_TOTAL
+    fi
+
+    # Set IPv4 address to the interfaces
+    set_ipv4addr lhost $LINK_NUM $IPV4_NETWORK $LHOST_IPV4_HOST
+    if [ $? -ne 0 ]; then
+	tst_resm TBROK "Failed to set an IPv4 address at the local host"
+	exit $TST_TOTAL
+    fi
+    set_ipv4addr rhost $LINK_NUM $IPV4_NETWORK $RHOST_IPV4_HOST
+    if [ $? -ne 0 ]; then
+	tst_resm TBROK "Failed to set an IPv4 address at the remote host"
+	exit $TST_TOTAL
+    fi
+
+    lhost_addr="${IPV4_NETWORK}.${LHOST_IPV4_HOST}"
+    rhost_addr="${IPV4_NETWORK}.${RHOST_IPV4_HOST}"
+    check_icmpv4_connectivity $lhost_ifname $rhost_addr
+    if [ $? -ne 0 ]; then
+	tst_resm TBROK "Failed to ping to $rhost_addr"
+	exit 1
+    fi
+
+    #
+    # Start named for testing
+    #
+    port=`find_portbundle tcp 1025 1`
+    if [ $? -ne 0 ]; then
+	tst_resm TBROK "No port is available."
+	exit 1
+    fi
+
+    named_dir=`mktemp -d -p $TMPDIR`
+
+    # named.conf
+    cat << EOD > ${named_dir}/named.conf
+options {
+    directory "${named_dir}";
+    pid-file "${named_dir}/named.pid";
+    recursion no;
+};
+
+zone "${DOMAIN}" {
+    type master;
+    file "ltp-ns.zone";
+};
+
+zone "${IPV4_NETWORK_REVERSE}.in-addr.arpa" {
+    type master;
+    file "ltp-ns.rev";
+};
+EOD
+
+    # zone file
+    cat << EOD > ${named_dir}/ltp-ns.zone
+\$TTL 10
+@	IN	SOA dns.${DOMAIN}. root.${DOMAIN}. (
+	2005092701 ; serial
+	3600       ; dummy value
+	900        ; dummy value
+	604800     ; dummy value
+	86400      ; dummy value
+)
+	IN	NS	dns.${DOMAIN}.
+dns	IN	A	${lhost_addr}
+client	IN	A	${rhost_addr}
+EOD
+    id=$MINIMUM_ID
+    while [ $id -le $MAXIMUM_ID ]; do
+	printf "node${id}\tIN\tA\t${IPV4_NETWORK}.${id}\n" >> ${named_dir}/ltp-ns.zone
+	id=`expr $id + 1`
+    done
+
+    # reverse zone file
+    cat << EOD > ${named_dir}/ltp-ns.rev
+\$TTL 10
+@	IN	SOA dns.${DOMAIN}. root.${DOMAIN}. (
+	2005092701 ; serial
+	3600       ; dummy value
+	900        ; dummy value
+	604800     ; dummy value
+	86400      ; dummy value
+)
+        IN      NS      dns.${DOMAIN}.
+$LHOST_IPV4_HOST	IN	PTR	dns.${DOMAIN}.
+$RHOST_IPV4_HOST	IN	PTR	client.${DOMAIN}.
+EOD
+    id=$MINIMUM_ID
+    while [ $id -le $MAXIMUM_ID ]; do
+	printf "${id}\tIN\tPTR\tnode${id}.${DOMAIN}.\n" >> ${named_dir}/ltp-ns.rev
+	id=`expr $id + 1`
+    done
+
+    chmod 770 $named_dir
+    chmod 660 $named_dir/*
+
+    # Start named daemon
+    named -c ${named_dir}/named.conf -p $port
+    if [ $? -ne 0 ]; then
+	tst_resm TBROK "Failed to run named daemon."
+	exit 1
+    fi
+
+    # Make sure named.pid is crated.
+    while true ; do
+	if [ -s ${named_dir}/named.pid ]; then
+	    break
+	fi
+    done
+
+}
+
+
+#-----------------------------------------------------------------------
+#
+# Function:
+#   test01
+#
+# Description:
+#   Verify the dns server or the kernel is not down after handling
+#   a large number of name lookup querys
+#
+#-----------------------------------------------------------------------
+test01()
+{
+    TCID=dns4-stress01
+    TST_COUNT=1
+    tst_resm TINFO "Verify the dns server or the kernel is not down after handling $NS_TIMES name lookup querys"
+
+    # Script name at the remote host
+    rmtscript="dns-stress01-rmt"
+
+    # Run the script at the remote host
+    message_file=`mktemp -p $TMPDIR`
+    not_run_rmtscript=true
+    for rmtdir in ${LTPROOT}/testcases/bin ${PWD} ; do
+	ret=`$LTP_RSH $RHOST 'test -x '${rmtdir}/${rmtscript}' ; echo $?'`
+	if [ $ret -eq 0 ]; then
+	    not_run_rmtscript=false
+	    $LTP_RSH $RHOST "${rmtdir}/${rmtscript} 4 $lhost_addr $port $DOMAIN $MINIMUM_ID $MAXIMUM_ID $NS_TIMES" > $message_file
+	    break
+	fi
+    done
+    if $not_run_rmtscript ; then
+	tst_resm TBROK "Failed to run the test script at the remote host"
+	rm -f $message_file
+	exit 1
+    fi
+
+    if [ -s $message_file ]; then
+	tst_resm TFAIL "`cat $message_file`"
+	rm -f $message_file
+	return 1
+    else
+	tst_resm TPASS "Test is finished successfully."
+	rm -f $message_file
+	return 0
+    fi
+}
+
+
+#-----------------------------------------------------------------------
+#
+# Function:
+#   test02
+#
+# Description:
+#   Verify the dns server or the kernel is not down after handling
+#   a large number of reverse lookup querys
+#
+#-----------------------------------------------------------------------
+test02()
+{
+    TCID=dns4-stress02
+    TST_COUNT=2
+    tst_resm TINFO "Verify the dns server or the kernel is not down after handling $NS_TIMES reverse lookup querys"
+
+    # Script name at the remote host
+    rmtscript="dns-stress02-rmt"
+
+    # Run the script at the remote host
+    message_file=`mktemp -p $TMPDIR`
+    not_run_rmtscript=true
+    for rmtdir in ${LTPROOT}/testcases/bin ${PWD} ; do
+	ret=`$LTP_RSH $RHOST 'test -x '${rmtdir}/${rmtscript}' ; echo $?'`
+	if [ $ret -eq 0 ]; then
+	    not_run_rmtscript=false
+	    $LTP_RSH $RHOST "${rmtdir}/${rmtscript} 4 $lhost_addr $port $IPV4_NETWORK $MINIMUM_ID $MAXIMUM_ID $NS_TIMES" > $message_file
+	    break
+	fi
+    done
+    if $not_run_rmtscript ; then
+	tst_resm TBROK "Failed to run the test script at the remote host"
+	rm -f $message_file
+	exit 1
+    fi
+
+    if [ -s $message_file ]; then
+	tst_resm TFAIL "`cat $message_file`"
+	rm -f $message_file
+	return 1
+    else
+	tst_resm TPASS "Test is finished successfully."
+	rm -f $message_file
+	return 0
+    fi
+}
+
+
+#-----------------------------------------------------------------------
+#
+# Main
+#
+# Exit Value:
+#   The number of the failure
+#
+#-----------------------------------------------------------------------
+
+RC=0
+do_setup
+test01 || RC=`expr $RC + 1`
+test02 || RC=`expr $RC + 1`
+
+exit $RC
diff --git a/testcases/network/stress/dns/dns4-stress b/testcases/network/stress/dns/dns4-stress
deleted file mode 100644
index 7b13bff..0000000
--- a/testcases/network/stress/dns/dns4-stress
+++ /dev/null
@@ -1,366 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   dns4-stress
-#
-# Description:
-#   Stress test for dns over IPv4
-#   test01 - Verify the dns server or the kernel is not down after the dns
-#            server handles a large number of name lookup querys
-#   test02 - Verify the dns server or the kernel is not down after the dns
-#            server handles a large number of reverse lookup querys
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-# Make sure the value of LTPROOT
-LTPROOT=${LTPROOT:-`(cd ../../../../ ; pwd)`}
-export LTPROOT
-
-# Total number of the test case
-TST_TOTAL=2
-export TST_TOTAL
-
-# Default of the test case ID and the test case count
-TCID=dns4-stress
-TST_COUNT=0
-export TCID
-export TST_COUNT
-
-# Check the environmanet variable
-. check_envval || exit $TST_TOTAL
-
-# The times of query
-NS_TIMES=${NS_TIMES:-10000}
-
-# The number of the test link where tests run
-LINK_NUM=0
-
-# Network portion of the IPv4 address
-IPV4_NETWORK=${IPV4_NETWORK:-"10.0.0"}
-
-# Reverse network portion of the IPv4 address
-IPV4_NETWORK_REVERSE=${IPV4_NETWORK_REVERSE:-"0.0.10"}
-
-# Host portion of the IPv4 address on the local host
-LHOST_IPV4_HOST=${LHOST_IPV4_HOST:-"2"}
-
-# Host portion of the IPv4 address on the remote host
-RHOST_IPV4_HOST=${RHOST_IPV4_HOST:-"1"}
-
-# Minumum host ID in the zone file. The ID is used as the host portion of
-# of the address
-MINIMUM_ID=3
-
-# Maximum host ID in the zone file.
-MAXIMUM_ID=254
-
-# Domain name for testing
-DOMAIN="ltp-ns.org"
-
-
-#-----------------------------------------------------------------------
-#
-# Function:
-#   do_cleanup
-#
-# Description:
-#   Clean up after running dns stress test
-#
-#-----------------------------------------------------------------------
-do_cleanup()
-{
-    # Stop the dns daemon
-    kill `cat ${named_dir}/named.pid` >/dev/null 2>&1
-
-    # Delete the temprary files/direcrories
-    rm -rf $named_dir
-    rm -f $message_file
-
-    # Initialize the interface
-    initialize_if lhost $LINK_NUM
-    initialize_if rhost $LINK_NUM
-}
-
-
-#-----------------------------------------------------------------------
-#
-# Function:
-#   do_setup
-#
-# Description:
-#   Setup for the dns stress tests
-#   - Assign IP address to the interfaces belong to the specified Link
-#   - Run a named daemon for testing
-#
-# Set Values:
-#   lhost_addr: IP address of the local host
-#   rhost_addr: IP address of the remote host
-#   port:	port number to accept the dns query
-#
-#-----------------------------------------------------------------------
-do_setup()
-{
-    trap do_cleanup 0
-
-    # Initialize the interface
-    initialize_if lhost $LINK_NUM
-    initialize_if rhost $LINK_NUM
-
-    # Get the Interface name
-    lhost_ifname=`get_ifname lhost $LINK_NUM`
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to get the interface name at the local host"
-	exit $TST_TOTAL
-    fi
-
-    # Set IPv4 address to the interfaces
-    set_ipv4addr lhost $LINK_NUM $IPV4_NETWORK $LHOST_IPV4_HOST
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to set an IPv4 address at the local host"
-	exit $TST_TOTAL
-    fi
-    set_ipv4addr rhost $LINK_NUM $IPV4_NETWORK $RHOST_IPV4_HOST
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to set an IPv4 address at the remote host"
-	exit $TST_TOTAL
-    fi
-
-    lhost_addr="${IPV4_NETWORK}.${LHOST_IPV4_HOST}"
-    rhost_addr="${IPV4_NETWORK}.${RHOST_IPV4_HOST}"
-    check_icmpv4_connectivity $lhost_ifname $rhost_addr
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to ping to $rhost_addr"
-	exit 1
-    fi
-
-    #
-    # Start named for testing
-    #
-    port=`find_portbundle tcp 1025 1`
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "No port is available."
-	exit 1
-    fi
-
-    named_dir=`mktemp -d -p $TMPDIR`
-
-    # named.conf
-    cat << EOD > ${named_dir}/named.conf
-options {
-    directory "${named_dir}";
-    pid-file "${named_dir}/named.pid";
-    recursion no;
-};
-
-zone "${DOMAIN}" {
-    type master;
-    file "ltp-ns.zone";
-};
-
-zone "${IPV4_NETWORK_REVERSE}.in-addr.arpa" {
-    type master;
-    file "ltp-ns.rev";
-};
-EOD
-
-    # zone file
-    cat << EOD > ${named_dir}/ltp-ns.zone
-\$TTL 10
-@	IN	SOA dns.${DOMAIN}. root.${DOMAIN}. (
-	2005092701 ; serial
-	3600       ; dummy value
-	900        ; dummy value
-	604800     ; dummy value
-	86400      ; dummy value
-)
-	IN	NS	dns.${DOMAIN}.
-dns	IN	A	${lhost_addr}
-client	IN	A	${rhost_addr}
-EOD
-    id=$MINIMUM_ID
-    while [ $id -le $MAXIMUM_ID ]; do
-	printf "node${id}\tIN\tA\t${IPV4_NETWORK}.${id}\n" >> ${named_dir}/ltp-ns.zone
-	id=`expr $id + 1`
-    done
-
-    # reverse zone file
-    cat << EOD > ${named_dir}/ltp-ns.rev
-\$TTL 10
-@	IN	SOA dns.${DOMAIN}. root.${DOMAIN}. (
-	2005092701 ; serial
-	3600       ; dummy value
-	900        ; dummy value
-	604800     ; dummy value
-	86400      ; dummy value
-)
-        IN      NS      dns.${DOMAIN}.
-$LHOST_IPV4_HOST	IN	PTR	dns.${DOMAIN}.
-$RHOST_IPV4_HOST	IN	PTR	client.${DOMAIN}.
-EOD
-    id=$MINIMUM_ID
-    while [ $id -le $MAXIMUM_ID ]; do
-	printf "${id}\tIN\tPTR\tnode${id}.${DOMAIN}.\n" >> ${named_dir}/ltp-ns.rev
-	id=`expr $id + 1`
-    done
-
-    chmod 770 $named_dir
-    chmod 660 $named_dir/*
-
-    # Start named daemon
-    named -c ${named_dir}/named.conf -p $port
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to run named daemon."
-	exit 1
-    fi
-
-    # Make sure named.pid is crated.
-    while true ; do
-	if [ -s ${named_dir}/named.pid ]; then
-	    break
-	fi
-    done
-
-}
-
-
-#-----------------------------------------------------------------------
-#
-# Function:
-#   test01
-#
-# Description:
-#   Verify the dns server or the kernel is not down after handling
-#   a large number of name lookup querys
-#
-#-----------------------------------------------------------------------
-test01()
-{
-    TCID=dns4-stress01
-    TST_COUNT=1
-    tst_resm TINFO "Verify the dns server or the kernel is not down after handling $NS_TIMES name lookup querys"
-
-    # Script name at the remote host
-    rmtscript="dns-stress01-rmt"
-
-    # Run the script at the remote host
-    message_file=`mktemp -p $TMPDIR`
-    not_run_rmtscript=true
-    for rmtdir in ${LTPROOT}/testcases/bin ${PWD} ; do
-	ret=`$LTP_RSH $RHOST 'test -x '${rmtdir}/${rmtscript}' ; echo $?'`
-	if [ $ret -eq 0 ]; then
-	    not_run_rmtscript=false
-	    $LTP_RSH $RHOST "${rmtdir}/${rmtscript} 4 $lhost_addr $port $DOMAIN $MINIMUM_ID $MAXIMUM_ID $NS_TIMES" > $message_file
-	    break
-	fi
-    done
-    if $not_run_rmtscript ; then
-	tst_resm TBROK "Failed to run the test script at the remote host"
-	rm -f $message_file
-	exit 1
-    fi
-
-    if [ -s $message_file ]; then
-	tst_resm TFAIL "`cat $message_file`"
-	rm -f $message_file
-	return 1
-    else
-	tst_resm TPASS "Test is finished successfully."
-	rm -f $message_file
-	return 0
-    fi
-}
-
-
-#-----------------------------------------------------------------------
-#
-# Function:
-#   test02
-#
-# Description:
-#   Verify the dns server or the kernel is not down after handling
-#   a large number of reverse lookup querys
-#
-#-----------------------------------------------------------------------
-test02()
-{
-    TCID=dns4-stress02
-    TST_COUNT=2
-    tst_resm TINFO "Verify the dns server or the kernel is not down after handling $NS_TIMES reverse lookup querys"
-
-    # Script name at the remote host
-    rmtscript="dns-stress02-rmt"
-
-    # Run the script at the remote host
-    message_file=`mktemp -p $TMPDIR`
-    not_run_rmtscript=true
-    for rmtdir in ${LTPROOT}/testcases/bin ${PWD} ; do
-	ret=`$LTP_RSH $RHOST 'test -x '${rmtdir}/${rmtscript}' ; echo $?'`
-	if [ $ret -eq 0 ]; then
-	    not_run_rmtscript=false
-	    $LTP_RSH $RHOST "${rmtdir}/${rmtscript} 4 $lhost_addr $port $IPV4_NETWORK $MINIMUM_ID $MAXIMUM_ID $NS_TIMES" > $message_file
-	    break
-	fi
-    done
-    if $not_run_rmtscript ; then
-	tst_resm TBROK "Failed to run the test script at the remote host"
-	rm -f $message_file
-	exit 1
-    fi
-
-    if [ -s $message_file ]; then
-	tst_resm TFAIL "`cat $message_file`"
-	rm -f $message_file
-	return 1
-    else
-	tst_resm TPASS "Test is finished successfully."
-	rm -f $message_file
-	return 0
-    fi
-}
-
-
-#-----------------------------------------------------------------------
-#
-# Main
-#
-# Exit Value:
-#   The number of the failure
-#
-#-----------------------------------------------------------------------
-
-RC=0
-do_setup
-test01 || RC=`expr $RC + 1`
-test02 || RC=`expr $RC + 1`
-
-exit $RC
diff --git a/testcases/network/stress/dns/dns6-stress b/testcases/network/stress/dns/dns6-stress
deleted file mode 100644
index 303539e..0000000
--- a/testcases/network/stress/dns/dns6-stress
+++ /dev/null
@@ -1,381 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   dns6-stress
-#
-# Description:
-#   Stress test for dns over IPv6
-#     test01 - Verify the dns server or the kernel is not down after handling
-#     a large number of name lookup querys
-#     test02 - Verify the dns server or the kernel is not down after handling
-#     a large number of reverse lookup querys
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-# Make sure the value of LTPROOT
-LTPROOT=${LTPROOT:-`(cd ../../../../ ; pwd)`}
-export LTPROOT
-
-# Total number of the test case
-TST_TOTAL=2
-export TST_TOTAL
-
-# Default of the test case ID and the test case count
-TCID=dns6-stress
-TST_COUNT=0
-export TCID
-export TST_COUNT
-
-# Added the network stress test tools directory into PATH
-PATH="${LTPROOT}/testcasess/network/stress/ns-tools:${PATH}"
-
-# Check the environmanet variable
-. check_envval || exit $TST_TOTAL
-
-# The times of query
-NS_TIMES=${NS_TIMES:-10000}
-
-# The number of the test link where tests run
-LINK_NUM=0
-
-# Network portion of the IPv6 address
-IPV6_NETWORK="fd00:1:1:1"
-
-# Reverse network portion of the IPv6 address
-IPV6_NETWORK_REVERSE="1.0.0.0.1.0.0.0.1.0.0.0.e.f.f.3"
-
-# Host portion of the IPv6 address of the local host
-LHOST_IPV6_HOST=":2"
-
-# Reverse host portion of the IPv6 address of the local host
-REVERSE_LHOST_IPV6_HOST="2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0"
-
-# Host portion of the IPv6 address of the remote host
-RHOST_IPV6_HOST=":1"
-
-# Reverse host portion of the IPv6 address of the remote host
-REVERSE_RHOST_IPV6_HOST="1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0"
-
-# Minumum host ID in the zone file. The ID is used as the host portion of
-# of the address
-MINIMUM_ID=3
-
-# Maximum host ID in the zone file.
-MAXIMUM_ID=254
-
-# Domain name for testing
-DOMAIN="ltp-ns.org"
-
-
-#-----------------------------------------------------------------------
-#
-# Function:
-#   do_cleanup
-#
-# Description:
-#   Clean up after running dns stress test
-#
-#-----------------------------------------------------------------------
-do_cleanup()
-{
-    # Stop the dns daemon
-    kill `cat ${named_dir}/named.pid`
-
-    # Make sure to delete the temporary files/directory
-    rm -rf $named_dir
-    rm -f $message_file
-
-    # Initialize the interface
-    initialize_if lhost $LINK_NUM
-    initialize_if rhost $LINK_NUM
-}
-
-
-#-----------------------------------------------------------------------
-#
-# Function:
-#   do_setup
-#
-# Description:
-#   Setup for the dns stress tests
-#   - Assign IP address to the interfaces belong to the specified Link
-#   - Run a named daemon for testing
-#
-# Set Values:
-#   lhost_addr: IP address of the local host
-#   rhost_addr: IP address of the remote host
-#   port:	port number to accept the dns query
-#
-#-----------------------------------------------------------------------
-do_setup()
-{
-    # Initialize the interface
-    initialize_if lhost $LINK_NUM
-    initialize_if rhost $LINK_NUM
-
-    # Get the Interface name
-    lhost_ifname=`get_ifname lhost ${LINK_NUM}`
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to get the interface name at the local host"
-	exit $TST_TOTAL
-    fi
-
-    # Set IPv6 address to the interfaces
-    add_ipv6addr lhost ${LINK_NUM} ${IPV6_NETWORK} ${LHOST_IPV6_HOST}
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to add any IP address at the local host"
-	exit 1
-    fi
-
-    add_ipv6addr rhost ${LINK_NUM} ${IPV6_NETWORK} ${RHOST_IPV6_HOST}
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to add any IP address at the remote host"
-	exit 1
-    fi
-
-    lhost_addr="${IPV6_NETWORK}:${LHOST_IPV6_HOST}"
-    rhost_addr="${IPV6_NETWORK}:${RHOST_IPV6_HOST}"
-    check_icmpv6_connectivity $lhost_ifname $rhost_addr
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to ping to $rhost_addr"
-	exit 1
-    fi
-
-    #
-    # Start named for testing
-    #
-    port=`find_portbundle tcp 1025 1`
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "No port is available."
-	exit 1
-    fi
-    named_dir=`mktemp -p $TMPDIR -d`
-
-    # named.conf
-    cat << EOD > ${named_dir}/named.conf
-options {
-    directory "${named_dir}";
-    pid-file "${named_dir}/named.pid";
-    recursion no;
-    listen-on-v6 {
-	any;
-    };
-};
-
-zone "${DOMAIN}" {
-    type master;
-    file "ltp-ns.zone";
-};
-
-zone "${IPV6_NETWORK_REVERSE}.ip6.arpa." {
-    type master;
-    file "ltp-ns.rev";
-};
-EOD
-
-    # zone file
-    cat << EOD > ${named_dir}/ltp-ns.zone
-\$TTL 10
-@	IN	SOA dns.${DOMAIN}. root.${DOMAIN}. (
-	2005092701 ; serial
-	3600       ; dummy value
-	900        ; dummy value
-	604800     ; dummy value
-	86400      ; dummy value
-)
-	IN	NS	dns.${DOMAIN}.
-dns	IN	AAAA	${lhost_addr}
-client	IN	AAAA	${rhost_addr}
-EOD
-    id=$MINIMUM_ID
-    while [ $id -le $MAXIMUM_ID ]; do
-	printf "node${id}\tIN\tAAAA\t${IPV6_NETWORK}::%x\n" $id >> ${named_dir}/ltp-ns.zone
-	id=`expr $id + 1`
-    done
-
-    # reverse zone file
-    cat << EOD > ${named_dir}/ltp-ns.rev
-\$TTL 10
-@	IN	SOA dns.${DOMAIN}. root.${DOMAIN}. (
-	2005092701 ; serial
-	3600       ; dummy value
-	900        ; dummy value
-	604800     ; dummy value
-	86400      ; dummy value
-)
-        IN      NS      dns.${DOMAIN}.
-$REVERSE_LHOST_IPV6_HOST	IN	PTR	dns.${DOMAIN}.
-$REVERSE_RHOST_IPV6_HOST	IN	PTR	client.${DOMAIN}.
-EOD
-    id=$MINIMUM_ID
-    while [ $id -le $MAXIMUM_ID ]; do
-	printf "%x.%x.0.0.0.0.0.0.0.0.0.0.0.0.0.0\tIN\tPTR\tnode${id}.${DOMAIN}.\n" `expr $id % 16` `expr $id \/ 16` >> ${named_dir}/ltp-ns.rev
-	id=`expr $id + 1`
-    done
-
-    chmod 770 $named_dir
-    chmod 660 $named_dir/*
-
-    # Start named daemon
-    named -c ${named_dir}/named.conf -p $port
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to run named daemon."
-	exit 1
-    fi
-
-    # Make sure named.pid is crated.
-    while true ; do
-	if [ -s ${named_dir}/named.pid ]; then
-	    break
-	fi
-    done
-
-    trap do_cleanup 0
-}
-
-
-#-----------------------------------------------------------------------
-#
-# Function:
-#   test01
-#
-# Description:
-#   Verify the dns server or the kernel is not down after handling
-#   a large number of name lookup querys
-#
-#-----------------------------------------------------------------------
-test01()
-{
-    TCID=dns6-stress01
-    TST_COUNT=1
-    tst_resm TINFO "Verify the dns server or the kernel is not down after handling $NS_TIMES name lookup querys"
-
-    # Script name at the remote host
-    rmtscript="dns-stress01-rmt"
-
-    # Run the script at the remote host
-    message_file=`mktemp -p $TMPDIR`
-    not_run_rmtscript=true
-    for rmtdir in ${LTPROOT}/testcases/bin ${PWD} ; do
-	ret=`$LTP_RSH $RHOST 'test -x '${rmtdir}/${rmtscript}' ; echo $?'`
-	if [ $ret -eq 0 ]; then
-	    not_run_rmtscript=false
-	    $LTP_RSH $RHOST "${rmtdir}/${rmtscript} 6 $lhost_addr $port $DOMAIN $MINIMUM_ID $MAXIMUM_ID $NS_TIMES" > $message_file
-	    retval=$?
-	    break
-	fi
-    done
-    if $not_run_rmtscript ; then
-	tst_resm TBROK "Failed to run the test script at the remote host"
-	rm -f $message_file
-	exit 1
-    fi
-
-    if [ $retval -eq 0 ]; then
-	if [ -s $message_file ]; then
-	    tst_resm TINFO "`cat $message_file`"
-	fi
-	tst_resm TPASS "Test is finished successfully."
-    else
-	tst_resm TFAIL "`cat $message_file`"
-    fi
-    rm -f $message_file
-    return $retval
-}
-
-
-#-----------------------------------------------------------------------
-#
-# Function:
-#   test02
-#
-# Description:
-#   Verify the dns server or the kernel is not down after handling
-#   a large number of reverse lookup querys
-#
-#-----------------------------------------------------------------------
-test02()
-{
-    TCID=dns6-stress02
-    TST_COUNT=2
-    tst_resm TINFO "Verify the dns server or the kernel is not down after handling $NS_TIMES reverse lookup querys"
-
-    # Script name at the remote host
-    rmtscript="dns-stress02-rmt"
-
-    # Run the script at the remote host
-    message_file=`mktemp -p $TMPDIR`
-    not_run_rmtscript=true
-    for rmtdir in ${LTPROOT}/testcases/bin ${PWD} ; do
-	ret=`$LTP_RSH $RHOST 'test -x '${rmtdir}/${rmtscript}' ; echo $?'`
-	if [ $ret -eq 0 ]; then
-	    not_run_rmtscript=false
-	    $LTP_RSH $RHOST "${rmtdir}/${rmtscript} 6 $lhost_addr $port $IPV6_NETWORK $MINIMUM_ID $MAXIMUM_ID $NS_TIMES" > $message_file
-	    retval=$?
-	    break
-	fi
-    done
-    if $not_run_rmtscript ; then
-	tst_resm TBROK "Failed to run the test script at the remote host"
-	rm -f $message_file
-	exit 1
-    fi
-
-    if [ $retval -eq 0 ]; then
-	if [ -s $message_file ]; then
-	    tst_resm TINFO "`cat $message_file`"
-	fi
-	tst_resm TPASS "Test is finished successfully."
-    else
-	tst_resm TFAIL "`cat $message_file`"
-    fi
-    rm -f $message_file
-    return $retval
-}
-
-
-#-----------------------------------------------------------------------
-#
-# Main
-#
-# Exit Value:
-#   The number of the failure
-#
-#-----------------------------------------------------------------------
-
-RC=0
-do_setup
-test01 || RC=`expr $RC + 1`
-test02 || RC=`expr $RC + 1`
-
-exit $RC
-- 
1.7.1


------------------------------------------------------------------------------
New Year. New Location. New Benefits. New Data Center in Ashburn, VA.
GigeNET is offering a free month of service with a new server in Ashburn.
Choose from 2 high performing configs, both with 100TB of bandwidth.
Higher redundancy.Lower latency.Increased capacity.Completely compliant.
http://p.sf.net/sfu/gigenet
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
