Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1YIeDT-00021h-3s
	for ltp-list@lists.sourceforge.net; Tue, 03 Feb 2015 14:12:35 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YIeDN-0006s7-KT
	for ltp-list@lists.sourceforge.net; Tue, 03 Feb 2015 14:12:35 +0000
Received: from ucsinet22.oracle.com (ucsinet22.oracle.com [156.151.31.94])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t13ECNwa030905
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 3 Feb 2015 14:12:23 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by ucsinet22.oracle.com (8.14.5+Sun/8.14.5) with ESMTP id
	t13ECMnV013054
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Tue, 3 Feb 2015 14:12:22 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	t13ECLG7002133
	for <ltp-list@lists.sourceforge.net>; Tue, 3 Feb 2015 14:12:21 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue,  3 Feb 2015 17:14:38 +0300
Message-Id: <1422972883-12173-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH 1/6] network/stress/http: rename http4-stress
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
Cc: vasily.isaenko@oracle.com

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/stress/http/http-stress  |  357 ++++++++++++++++++++++++++++
 testcases/network/stress/http/http4-stress |  357 ----------------------------
 2 files changed, 357 insertions(+), 357 deletions(-)
 create mode 100644 testcases/network/stress/http/http-stress
 delete mode 100644 testcases/network/stress/http/http4-stress

diff --git a/testcases/network/stress/http/http-stress b/testcases/network/stress/http/http-stress
new file mode 100644
index 0000000..07c812f
--- /dev/null
+++ b/testcases/network/stress/http/http-stress
@@ -0,0 +1,357 @@
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
+#   http4-stress
+#
+# Description:
+#   Stress test for http over IPv4
+#
+#   test01 - Verify the http server or the kernel is not down after
+#            a http client requests large data
+#   test02 - Verify the http server or the kernel is not down after
+#            many http clients request data asynchronously for a long time
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
+# The version of IP
+IP_VER=${IP_VER:-4}
+
+# Default of the test case ID and the test case count
+TCID=http${IP_VER}-stress
+TST_COUNT=0
+export TCID
+export TST_COUNT
+
+# Check the environmanet variable
+. check_envval || exit $TST_TOTAL
+
+# Dulation of the test [sec]
+NS_DURATION=${NS_DURATION:-3600}      # 1 hour
+
+# Quantity of the connection for multi connection test
+CONNECTION_TOTAL=${CONNECTION_TOTAL:-4000}
+
+# Big file size to upload/download in ftp tests (byte)
+DOWNLOAD_BIGFILESIZE=${DOWNLOAD_BIGFILESIZE:-2147483647}        # 2GB - 1byte
+
+# Regular file size to upload/download in ftp tests (byte)
+DOWNLOAD_REGFILESIZE=${DOWNLOAD_REGFILESIZE:-1048576}        # 1MB
+
+# The number of the test link where tests run
+LINK_NUM=${LINK_NUM:-0}
+
+# Network portion of the IPv4 address
+IPV4_NETWORK=${IPV4_NETWORK:-"10.0.0"}
+
+# Host portion of the IPv4 address on the local host
+LHOST_IPV4_HOST=${LHOST_IPV4_HOST:-"2"}
+
+# Host portion of the IPv4 address on the remote host
+RHOST_IPV4_HOST=${RHOST_IPV4_HOST:-"1"}
+
+# Network portion of the IPv6 address
+IPV6_NETWORK="fd00:1:1:1"
+
+# Host portion of the IPv6 address of the local host
+LHOST_IPV6_HOST=":2"
+
+# Host portion of the IPv6 address of the remote host
+RHOST_IPV6_HOST=":1"
+
+# The test file name for downloading
+TESTFILE="http-stress.txt"
+
+#-----------------------------------------------------------------------
+#
+# Function:
+#   do_cleanup
+#
+# Description:
+#   Clean up after running http stress test
+#
+#-----------------------------------------------------------------------
+do_cleanup()
+{
+    # Delete the test file
+    rm -f $HTTP_DOWNLOAD_DIR/$TESTFILE
+
+    # Make sure to delete the temporary files
+    rm -f $message_file
+
+    # Initialize the interface
+    initialize_if lhost ${LINK_NUM}
+    initialize_if rhost ${LINK_NUM}
+}
+
+
+#-----------------------------------------------------------------------
+#
+# Function:
+#   do_setup
+#
+# Description:
+#   Setup for the http stress tests
+#   - Assign IP address to the interfaces belong to the specified Link
+#   - Run a httpd daemon for testing
+#   - Create keys for password-less login
+#
+# Set Values:
+#   lhost_addr:   IP address of the local host
+#   rhost_addr:   IP address of the remote host
+#   rhost_config: http_config at the remote host
+#
+#-----------------------------------------------------------------------
+do_setup()
+{
+    trap do_cleanup 0
+
+    # Check the environment variable HTTP_DOWNLOAD_DIR is set
+    if [ x$HTTP_DOWNLOAD_DIR = x ]; then
+	tst_resm TINFO "*) At this http stress test, the http server program does not run automatically. Please start the server manually and set the document root directory in the environment variable, HTTP_DOWNLOAD_DIR."
+	tst_resm TBROK "The environment variable HTTP_DOWNLOAD_DIR is not set"
+	exit 1
+    fi
+
+    # Initialize the interface
+    initialize_if lhost ${LINK_NUM}
+    initialize_if rhost ${LINK_NUM}
+
+    # Get the Interface name
+    lhost_ifname=`get_ifname lhost ${LINK_NUM}`
+    if [ $? -ne 0 ]; then
+	tst_resm TBROK "Failed to get the interface name at the local host"
+	exit $TST_TOTAL
+    fi
+
+    case $IP_VER in
+	4)
+	# Set IPv4 address to the interfaces
+	set_ipv4addr lhost $LINK_NUM ${IPV4_NETWORK} ${LHOST_IPV4_HOST}
+	if [ $? -ne 0 ]; then
+	    tst_resm TBROK "Failed to add any IP address at the local host"
+	    exit 1
+	fi
+	set_ipv4addr rhost $LINK_NUM ${IPV4_NETWORK} ${RHOST_IPV4_HOST}
+	if [ $? -ne 0 ]; then
+	    tst_resm TBROK "Failed to add any IP address at the remote host"
+	    exit 1
+	fi
+
+	lhost_addr="${IPV4_NETWORK}.${LHOST_IPV4_HOST}"
+	rhost_addr="${IPV4_NETWORK}.${RHOST_IPV4_HOST}"
+	check_icmpv4_connectivity $lhost_ifname $rhost_addr
+	if [ $? -ne 0 ]; then
+	    tst_resm TBROK "Failed to ping to $rhost_addr"
+    exit 1
+	fi
+	;;
+
+	6)
+	# Set IPv6 address to the interfaces
+	add_ipv6addr lhost $LINK_NUM ${IPV6_NETWORK} ${LHOST_IPV6_HOST}
+	if [ $? -ne 0 ]; then
+	    tst_resm TBROK "Failed to add any IP address at the local host"
+	    exit 1
+	fi
+	add_ipv6addr rhost $LINK_NUM ${IPV6_NETWORK} ${RHOST_IPV6_HOST}
+	if [ $? -ne 0 ]; then
+	    tst_resm TBROK "Failed to add any IP address at the remote host"
+	    exit 1
+	fi
+
+	lhost_addr="${IPV6_NETWORK}:${LHOST_IPV6_HOST}"
+	rhost_addr="${IPV6_NETWORK}:${RHOST_IPV6_HOST}"
+	check_icmpv6_connectivity $lhost_ifname $rhost_addr
+	if [ $? -ne 0 ]; then
+	    tst_resm TBROK "Failed to ping to $rhost_addr"
+	    exit 1
+	fi
+	;;
+
+	*)
+	tst_resm TBROK "Unknown IP version: $IP_VER"
+	exit 1
+	;;
+    esac
+}
+
+
+#-----------------------------------------------------------------------
+#
+# Function:
+#   test01
+#
+# Description:
+#   Verify the http server or the kernel is not down after a http
+#   client requests large data
+#
+#-----------------------------------------------------------------------
+test01()
+{
+    TCID=http${IP_VER}-stress01
+    TST_COUNT=1
+    tst_resm TINFO "Verify the http server or the kernel is not down after a http client requests data whose size is $DOWNLOAD_BIGFILESIZE byte via IPv${IP_VER}"
+
+    # Create a test file for download
+    if [ $DOWNLOAD_BIGFILESIZE -gt 2147483647 ]; then
+      tst_resm TINFO "As the apache with normal setting cannot handle the file whose size is bigger than or equal to 2G byte. Therefore, the file size is resetted into 2G - 1 byte."
+      DOWNLOAD_BIGFILESIZE=2147483647
+    fi
+    rm -f $HTTP_DOWNLOAD_DIR/$TESTFILE
+    create_file $HTTP_DOWNLOAD_DIR/$TESTFILE $DOWNLOAD_BIGFILESIZE
+    if [ $? -ne 0 ]; then
+      tst_resm TBROK "Failed to create $HTTP_DOWNLOAD_DIR/$TESTFILE"
+    fi
+
+    # Script name at the remote host
+    rmtscript="http-stress01-rmt"
+
+    # Run the script at the remote host
+    message_file=`mktemp -p $TMPDIR`
+    not_run_rmtscript=true
+    for rmtdir in ${LTPROOT}/testcases/bin ${PWD} ; do
+	ret=`$LTP_RSH $RHOST 'test -x '${rmtdir}/${rmtscript}' ; echo $?'`
+	if [ $ret -eq 0 ]; then
+	    not_run_rmtscript=false
+	    $LTP_RSH $RHOST "${rmtdir}/${rmtscript} $lhost_addr $TESTFILE" > $message_file
+	    break
+	fi
+    done
+
+    rm -f $HTTP_DOWNLOAD_DIR/$TESTFILE
+
+    if $not_run_rmtscript ; then
+	tst_resm TBROK "Failed to run the test script at the remote host"
+	rm -f $message_file
+	rm -f $HTTP_DOWNLOAD_DIR/$TESTFILE
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
+#   Verify the http server or the kernel is not down after many http
+#   clients request data asynchronously for a long time
+#
+#-----------------------------------------------------------------------
+test02()
+{
+    TCID=http${IP_VER}-stress02
+    TST_COUNT=2
+    tst_resm TINFO "Verify the http server or the kernel is not down after many http clients request data over IPv${IP_VER} asynchronously in ${NS_DURATION}[sec]"
+    tst_resm TINFO "The number of client is not over $CONNECTION_TOTAL"
+
+    # Create a test file for download
+    if [ $DOWNLOAD_REGFILESIZE -gt 2147483647 ]; then
+      tst_resm TINFO "As the apache with normal setting cannot handle the file whose size is bigger than or equal to 2G byte. Therefore, the file size is resetted into 2G - 1 byte."
+      DOWNLOAD_REGFILESIZE=2147483647
+    fi
+    rm -f $HTTP_DOWNLOAD_DIR/$TESTFILE
+    create_file $HTTP_DOWNLOAD_DIR/$TESTFILE $DOWNLOAD_REGFILESIZE
+    if [ $? -ne 0 ]; then
+      tst_resm TBROK "Failed to create $HTTP_DOWNLOAD_DIR/$TESTFILE"
+    fi
+
+    # Script name at the remote host
+    rmtscript="http-stress02-rmt"
+
+    # Run the script at the remote host
+    message_file=`mktemp -p $TMPDIR`
+    not_run_rmtscript=true
+    for rmtdir in ${LTPROOT}/testcases/bin ${PWD} ; do
+	ret=`$LTP_RSH $RHOST 'test -x '${rmtdir}/${rmtscript}' ; echo $?'`
+	if [ $ret -eq 0 ]; then
+	    not_run_rmtscript=false
+	    $LTP_RSH $RHOST "${rmtdir}/${rmtscript} $lhost_addr $TESTFILE $NS_DURATION $CONNECTION_TOTAL" > $message_file 2>/dev/null
+	    break
+	fi
+    done
+
+    rm -f $HTTP_DOWNLOAD_DIR/$TESTFILE
+
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
diff --git a/testcases/network/stress/http/http4-stress b/testcases/network/stress/http/http4-stress
deleted file mode 100644
index 07c812f..0000000
--- a/testcases/network/stress/http/http4-stress
+++ /dev/null
@@ -1,357 +0,0 @@
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
-#   http4-stress
-#
-# Description:
-#   Stress test for http over IPv4
-#
-#   test01 - Verify the http server or the kernel is not down after
-#            a http client requests large data
-#   test02 - Verify the http server or the kernel is not down after
-#            many http clients request data asynchronously for a long time
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
-# The version of IP
-IP_VER=${IP_VER:-4}
-
-# Default of the test case ID and the test case count
-TCID=http${IP_VER}-stress
-TST_COUNT=0
-export TCID
-export TST_COUNT
-
-# Check the environmanet variable
-. check_envval || exit $TST_TOTAL
-
-# Dulation of the test [sec]
-NS_DURATION=${NS_DURATION:-3600}      # 1 hour
-
-# Quantity of the connection for multi connection test
-CONNECTION_TOTAL=${CONNECTION_TOTAL:-4000}
-
-# Big file size to upload/download in ftp tests (byte)
-DOWNLOAD_BIGFILESIZE=${DOWNLOAD_BIGFILESIZE:-2147483647}        # 2GB - 1byte
-
-# Regular file size to upload/download in ftp tests (byte)
-DOWNLOAD_REGFILESIZE=${DOWNLOAD_REGFILESIZE:-1048576}        # 1MB
-
-# The number of the test link where tests run
-LINK_NUM=${LINK_NUM:-0}
-
-# Network portion of the IPv4 address
-IPV4_NETWORK=${IPV4_NETWORK:-"10.0.0"}
-
-# Host portion of the IPv4 address on the local host
-LHOST_IPV4_HOST=${LHOST_IPV4_HOST:-"2"}
-
-# Host portion of the IPv4 address on the remote host
-RHOST_IPV4_HOST=${RHOST_IPV4_HOST:-"1"}
-
-# Network portion of the IPv6 address
-IPV6_NETWORK="fd00:1:1:1"
-
-# Host portion of the IPv6 address of the local host
-LHOST_IPV6_HOST=":2"
-
-# Host portion of the IPv6 address of the remote host
-RHOST_IPV6_HOST=":1"
-
-# The test file name for downloading
-TESTFILE="http-stress.txt"
-
-#-----------------------------------------------------------------------
-#
-# Function:
-#   do_cleanup
-#
-# Description:
-#   Clean up after running http stress test
-#
-#-----------------------------------------------------------------------
-do_cleanup()
-{
-    # Delete the test file
-    rm -f $HTTP_DOWNLOAD_DIR/$TESTFILE
-
-    # Make sure to delete the temporary files
-    rm -f $message_file
-
-    # Initialize the interface
-    initialize_if lhost ${LINK_NUM}
-    initialize_if rhost ${LINK_NUM}
-}
-
-
-#-----------------------------------------------------------------------
-#
-# Function:
-#   do_setup
-#
-# Description:
-#   Setup for the http stress tests
-#   - Assign IP address to the interfaces belong to the specified Link
-#   - Run a httpd daemon for testing
-#   - Create keys for password-less login
-#
-# Set Values:
-#   lhost_addr:   IP address of the local host
-#   rhost_addr:   IP address of the remote host
-#   rhost_config: http_config at the remote host
-#
-#-----------------------------------------------------------------------
-do_setup()
-{
-    trap do_cleanup 0
-
-    # Check the environment variable HTTP_DOWNLOAD_DIR is set
-    if [ x$HTTP_DOWNLOAD_DIR = x ]; then
-	tst_resm TINFO "*) At this http stress test, the http server program does not run automatically. Please start the server manually and set the document root directory in the environment variable, HTTP_DOWNLOAD_DIR."
-	tst_resm TBROK "The environment variable HTTP_DOWNLOAD_DIR is not set"
-	exit 1
-    fi
-
-    # Initialize the interface
-    initialize_if lhost ${LINK_NUM}
-    initialize_if rhost ${LINK_NUM}
-
-    # Get the Interface name
-    lhost_ifname=`get_ifname lhost ${LINK_NUM}`
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to get the interface name at the local host"
-	exit $TST_TOTAL
-    fi
-
-    case $IP_VER in
-	4)
-	# Set IPv4 address to the interfaces
-	set_ipv4addr lhost $LINK_NUM ${IPV4_NETWORK} ${LHOST_IPV4_HOST}
-	if [ $? -ne 0 ]; then
-	    tst_resm TBROK "Failed to add any IP address at the local host"
-	    exit 1
-	fi
-	set_ipv4addr rhost $LINK_NUM ${IPV4_NETWORK} ${RHOST_IPV4_HOST}
-	if [ $? -ne 0 ]; then
-	    tst_resm TBROK "Failed to add any IP address at the remote host"
-	    exit 1
-	fi
-
-	lhost_addr="${IPV4_NETWORK}.${LHOST_IPV4_HOST}"
-	rhost_addr="${IPV4_NETWORK}.${RHOST_IPV4_HOST}"
-	check_icmpv4_connectivity $lhost_ifname $rhost_addr
-	if [ $? -ne 0 ]; then
-	    tst_resm TBROK "Failed to ping to $rhost_addr"
-    exit 1
-	fi
-	;;
-
-	6)
-	# Set IPv6 address to the interfaces
-	add_ipv6addr lhost $LINK_NUM ${IPV6_NETWORK} ${LHOST_IPV6_HOST}
-	if [ $? -ne 0 ]; then
-	    tst_resm TBROK "Failed to add any IP address at the local host"
-	    exit 1
-	fi
-	add_ipv6addr rhost $LINK_NUM ${IPV6_NETWORK} ${RHOST_IPV6_HOST}
-	if [ $? -ne 0 ]; then
-	    tst_resm TBROK "Failed to add any IP address at the remote host"
-	    exit 1
-	fi
-
-	lhost_addr="${IPV6_NETWORK}:${LHOST_IPV6_HOST}"
-	rhost_addr="${IPV6_NETWORK}:${RHOST_IPV6_HOST}"
-	check_icmpv6_connectivity $lhost_ifname $rhost_addr
-	if [ $? -ne 0 ]; then
-	    tst_resm TBROK "Failed to ping to $rhost_addr"
-	    exit 1
-	fi
-	;;
-
-	*)
-	tst_resm TBROK "Unknown IP version: $IP_VER"
-	exit 1
-	;;
-    esac
-}
-
-
-#-----------------------------------------------------------------------
-#
-# Function:
-#   test01
-#
-# Description:
-#   Verify the http server or the kernel is not down after a http
-#   client requests large data
-#
-#-----------------------------------------------------------------------
-test01()
-{
-    TCID=http${IP_VER}-stress01
-    TST_COUNT=1
-    tst_resm TINFO "Verify the http server or the kernel is not down after a http client requests data whose size is $DOWNLOAD_BIGFILESIZE byte via IPv${IP_VER}"
-
-    # Create a test file for download
-    if [ $DOWNLOAD_BIGFILESIZE -gt 2147483647 ]; then
-      tst_resm TINFO "As the apache with normal setting cannot handle the file whose size is bigger than or equal to 2G byte. Therefore, the file size is resetted into 2G - 1 byte."
-      DOWNLOAD_BIGFILESIZE=2147483647
-    fi
-    rm -f $HTTP_DOWNLOAD_DIR/$TESTFILE
-    create_file $HTTP_DOWNLOAD_DIR/$TESTFILE $DOWNLOAD_BIGFILESIZE
-    if [ $? -ne 0 ]; then
-      tst_resm TBROK "Failed to create $HTTP_DOWNLOAD_DIR/$TESTFILE"
-    fi
-
-    # Script name at the remote host
-    rmtscript="http-stress01-rmt"
-
-    # Run the script at the remote host
-    message_file=`mktemp -p $TMPDIR`
-    not_run_rmtscript=true
-    for rmtdir in ${LTPROOT}/testcases/bin ${PWD} ; do
-	ret=`$LTP_RSH $RHOST 'test -x '${rmtdir}/${rmtscript}' ; echo $?'`
-	if [ $ret -eq 0 ]; then
-	    not_run_rmtscript=false
-	    $LTP_RSH $RHOST "${rmtdir}/${rmtscript} $lhost_addr $TESTFILE" > $message_file
-	    break
-	fi
-    done
-
-    rm -f $HTTP_DOWNLOAD_DIR/$TESTFILE
-
-    if $not_run_rmtscript ; then
-	tst_resm TBROK "Failed to run the test script at the remote host"
-	rm -f $message_file
-	rm -f $HTTP_DOWNLOAD_DIR/$TESTFILE
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
-#   Verify the http server or the kernel is not down after many http
-#   clients request data asynchronously for a long time
-#
-#-----------------------------------------------------------------------
-test02()
-{
-    TCID=http${IP_VER}-stress02
-    TST_COUNT=2
-    tst_resm TINFO "Verify the http server or the kernel is not down after many http clients request data over IPv${IP_VER} asynchronously in ${NS_DURATION}[sec]"
-    tst_resm TINFO "The number of client is not over $CONNECTION_TOTAL"
-
-    # Create a test file for download
-    if [ $DOWNLOAD_REGFILESIZE -gt 2147483647 ]; then
-      tst_resm TINFO "As the apache with normal setting cannot handle the file whose size is bigger than or equal to 2G byte. Therefore, the file size is resetted into 2G - 1 byte."
-      DOWNLOAD_REGFILESIZE=2147483647
-    fi
-    rm -f $HTTP_DOWNLOAD_DIR/$TESTFILE
-    create_file $HTTP_DOWNLOAD_DIR/$TESTFILE $DOWNLOAD_REGFILESIZE
-    if [ $? -ne 0 ]; then
-      tst_resm TBROK "Failed to create $HTTP_DOWNLOAD_DIR/$TESTFILE"
-    fi
-
-    # Script name at the remote host
-    rmtscript="http-stress02-rmt"
-
-    # Run the script at the remote host
-    message_file=`mktemp -p $TMPDIR`
-    not_run_rmtscript=true
-    for rmtdir in ${LTPROOT}/testcases/bin ${PWD} ; do
-	ret=`$LTP_RSH $RHOST 'test -x '${rmtdir}/${rmtscript}' ; echo $?'`
-	if [ $ret -eq 0 ]; then
-	    not_run_rmtscript=false
-	    $LTP_RSH $RHOST "${rmtdir}/${rmtscript} $lhost_addr $TESTFILE $NS_DURATION $CONNECTION_TOTAL" > $message_file 2>/dev/null
-	    break
-	fi
-    done
-
-    rm -f $HTTP_DOWNLOAD_DIR/$TESTFILE
-
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
-- 
1.7.1


------------------------------------------------------------------------------
Dive into the World of Parallel Programming. The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
