Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1YIeDT-0005W2-3P
	for ltp-list@lists.sourceforge.net; Tue, 03 Feb 2015 14:12:35 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YIeDN-0006vu-Vf
	for ltp-list@lists.sourceforge.net; Tue, 03 Feb 2015 14:12:35 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t13ECNQo030934
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 3 Feb 2015 14:12:24 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	t13ECNDb013524
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Tue, 3 Feb 2015 14:12:23 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	t13ECNwp013515
	for <ltp-list@lists.sourceforge.net>; Tue, 3 Feb 2015 14:12:23 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue,  3 Feb 2015 17:14:39 +0300
Message-Id: <1422972883-12173-2-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1422972883-12173-1-git-send-email-alexey.kodanev@oracle.com>
References: <1422972883-12173-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH 2/6] network/stress/http: cleanup,
	use test_net.sh library
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
 testcases/network/stress/http/00_Descriptions.txt |   16 +-
 testcases/network/stress/http/http-stress         |  366 +++------------------
 testcases/network/stress/http/http-stress01-rmt   |   91 ++----
 testcases/network/stress/http/http-stress02-rmt   |  126 +++-----
 4 files changed, 121 insertions(+), 478 deletions(-)

diff --git a/testcases/network/stress/http/00_Descriptions.txt b/testcases/network/stress/http/00_Descriptions.txt
index 2823987..a0b2032 100644
--- a/testcases/network/stress/http/00_Descriptions.txt
+++ b/testcases/network/stress/http/00_Descriptions.txt
@@ -1,15 +1,7 @@
-http4-stress01
+http-stress01
 	Verify the http server or the kernel is not down after a http client
-	requests large data via IPv4
+	requests large data via IPv4/IPv6
 
-http4-stress02
+http-stress02
 	Verify the http server or the kernel is not down after many http
-	clients request data over IPv4 asynchronously for a long time
-
-http6-stress01
-	Verify the http server or the kernel is not down after a http client
-	requests large data via IPv6
-
-http6-stress02
-	Verify the http server or the kernel is not down after many http
-	clients request data over IPv6 asynchronously for a long time
+	clients request data over IPv4/IPv6 asynchronously for a long time
diff --git a/testcases/network/stress/http/http-stress b/testcases/network/stress/http/http-stress
index 07c812f..1dd2f4b 100644
--- a/testcases/network/stress/http/http-stress
+++ b/testcases/network/stress/http/http-stress
@@ -1,357 +1,81 @@
 #!/bin/sh
 
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
+# Copyright (c) 2015 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) International Business Machines  Corp., 2005
 #
-# File:
-#   http4-stress
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
 #
-# Description:
-#   Stress test for http over IPv4
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
 #
-#   test01 - Verify the http server or the kernel is not down after
-#            a http client requests large data
-#   test02 - Verify the http server or the kernel is not down after
-#            many http clients request data asynchronously for a long time
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 #
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
+# Author: Mitsuru Chinen <mitch@jp.ibm.com>
 
-# Make sure the value of LTPROOT
-LTPROOT=${LTPROOT:-`(cd ../../../../ ; pwd)`}
-export LTPROOT
-
-# Total number of the test case
+TCID=http-stress
 TST_TOTAL=2
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
+TST_CLEANUP="cleanup"
 
-# Host portion of the IPv6 address of the local host
-LHOST_IPV6_HOST=":2"
+. test_net.sh
 
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
+cleanup()
 {
-    # Delete the test file
-    rm -f $HTTP_DOWNLOAD_DIR/$TESTFILE
-
-    # Make sure to delete the temporary files
-    rm -f $message_file
-
-    # Initialize the interface
-    initialize_if lhost ${LINK_NUM}
-    initialize_if rhost ${LINK_NUM}
+	rm -f $HTTP_DOWNLOAD_DIR/http_file
 }
 
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
+setup()
 {
-    trap do_cleanup 0
+	tst_require_root
 
-    # Check the environment variable HTTP_DOWNLOAD_DIR is set
-    if [ x$HTTP_DOWNLOAD_DIR = x ]; then
-	tst_resm TINFO "*) At this http stress test, the http server program does not run automatically. Please start the server manually and set the document root directory in the environment variable, HTTP_DOWNLOAD_DIR."
-	tst_resm TBROK "The environment variable HTTP_DOWNLOAD_DIR is not set"
-	exit 1
-    fi
+	ipver=${TST_IPV6:-'4'}
+	tst_resm TINFO "run over IPv$ipver"
 
-    # Initialize the interface
-    initialize_if lhost ${LINK_NUM}
-    initialize_if rhost ${LINK_NUM}
+	trap "tst_brkm TBROK 'test interrupted'" INT
 
-    # Get the Interface name
-    lhost_ifname=`get_ifname lhost ${LINK_NUM}`
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to get the interface name at the local host"
-	exit $TST_TOTAL
-    fi
+	[ -d "$HTTP_DOWNLOAD_DIR" ] || \
+		tst_brkm TCONF "Start server manually, set HTTP_DOWNLOAD_DIR"
 
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
+	# As the apache with normal setting cannot handle the file whose size
+	# is bigger than or equal to 2G byte. Therefore, the file size is
+	# resetted into 2G - 1 byte."
+	if [ $DOWNLOAD_BIGFILESIZE -gt 2147483647 ]; then
+		tst_resm TINFO "Setting file size to 2G - 1 byte"
+		DOWNLOAD_BIGFILESIZE=2147483647
 	fi
 
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
+	create_file $HTTP_DOWNLOAD_DIR/http_file $DOWNLOAD_BIGFILESIZE || \
+		tst_resm TBROK "Failed to create test file"
 }
 
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
 test01()
 {
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
+	tst_resm TINFO "http client download test file"
 
-    rm -f $HTTP_DOWNLOAD_DIR/$TESTFILE
+	tst_rhost_run -s -c "http-stress01-rmt $(tst_ipaddr) http_file"
 
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
+	tst_resm TPASS "Test is finished successfully"
 }
 
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
 test02()
 {
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
+	tst_resm TINFO "clients request data asynchronously $NS_DURATION sec"
 
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
+	tst_rhost_run -s -c "http-stress02-rmt $(tst_ipaddr) http_file \
+		$NS_DURATION $CONNECTION_TOTAL"
 
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
+	tst_resm TPASS "Test is finished successfully"
 }
 
+setup
 
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
+test01
+test02
 
-exit $RC
+tst_exit
diff --git a/testcases/network/stress/http/http-stress01-rmt b/testcases/network/stress/http/http-stress01-rmt
index 4a6be45..2567889 100644
--- a/testcases/network/stress/http/http-stress01-rmt
+++ b/testcases/network/stress/http/http-stress01-rmt
@@ -1,78 +1,43 @@
 #!/bin/sh
 
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
+# Copyright (c) 2015 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) International Business Machines  Corp., 2005
 #
-# File:
-#   http-stress01-rmt
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
 #
-# Description:
-#   This is the remote script for http-ipv${IP_VER}-stress01
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
 #
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 #
-# Arguments:
-#   $1:	ip address of the server
-#   $2: filename to download
-#
-# Exit Value:
-#    0: Success
-#   >0: Fail
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
+# Author: Mitsuru Chinen <mitch@jp.ibm.com>
+
+TCID="http-stress01-rmt"
+TST_TOTAL=1
+
+. test_net.sh
+
+tst_check_cmds curl
 
 # Check the arguments
-if [ $# -ne 2 ]; then
-    echo "Usage: $0 server_ipaddr filename"
-    exit 1
-fi
+[ $# -ne 2 ] && tst_brkm TBROK "Usage: $0 server_ipaddr filename"
+
 server_ipaddr="$1"
 filename="$2"
 
-echo $server_ipaddr | fgrep ':' >/dev/null 2>&1
+echo $server_ipaddr | grep -F ':' > /dev/null
 if [ $? -eq 0 ]; then
-    server_ipaddr='['$server_ipaddr']'
-fi
-
-# Check the curl command is available
-which curl >/dev/null 2>&1
-if [ $? -ne 0 ]; then
-    echo "The remote host does not have curl command."
-    exit 1
+	server_ipaddr='['$server_ipaddr']'
 fi
 
-#
-# Download the test file
-#
-curl -g "http://${server_ipaddr}/${filename}" -o /dev/null >/dev/null 2>&1
-if [ $? -ne 0 ]; then
-    echo "Failed to download the file from http://${server_ipaddr}/${filename}"
-    exit 1
-fi
+curl -g "http://$server_ipaddr/$filename" -o /dev/null || \
+	tst_brkm TBROK "Failed to get http://${server_ipaddr}/${filename}"
 
-exit 0
+tst_exit
diff --git a/testcases/network/stress/http/http-stress02-rmt b/testcases/network/stress/http/http-stress02-rmt
index f2c1296..b59a75e 100644
--- a/testcases/network/stress/http/http-stress02-rmt
+++ b/testcases/network/stress/http/http-stress02-rmt
@@ -1,105 +1,67 @@
 #!/bin/sh
 
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
+# Copyright (c) 2015 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) International Business Machines  Corp., 2005
 #
-# File:
-#   http-stress02-rmt
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
 #
-# Description:
-#   This is the remote script for http-ipv${IP_VER}-stress02
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
 #
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 #
-# Arguments:
-#   $1: ip address of the server
-#   $2: filename to download
-#   $3: duration
-#   $4: connect quantity
-#
-# Exit Value:
-#    0: Success
-#   >0: Fail
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
+# Author: Mitsuru Chinen <mitch@jp.ibm.com>
+
+TCID="http-stress02-rmt"
+TST_TOTAL=1
+
+. test_net.sh
+
+tst_check_cmds curl
 
-# Check the arguments
 if [ $# -ne 4 ]; then
-    echo "Usage: $0 server_addr filename duration connect_quantity"
-    exit 1
+	tst_brkm TBROK "Usage: $0 server_addr filename duration connections"
 fi
+
 server_ipaddr="$1"
 filename="$2"
 duration="$3"
-connect_quantity="$4"
+connections="$4"
 
-echo $server_ipaddr | fgrep ':' >/dev/null 2>&1
+echo $server_ipaddr | grep -F ':' > /dev/null
 if [ $? -eq 0 ]; then
-    server_ipaddr='['$server_ipaddr']'
+	server_ipaddr='['$server_ipaddr']'
 fi
 
-# Unset the maximum number of processes
-ulimit -u unlimited
-
-#
-# Main loop
-#
-start_epoc=`date +%s`
+start_epoc=$(date +%s)
 while true ; do
-    # Exit when the specified seconds have passed.
-    current_epoc=`date +%s`
-    elapse_epoc=`expr $current_epoc - $start_epoc`
-    if [ $elapse_epoc -ge $duration ]; then
-	break
-    fi
+	# Exit when the specified seconds have passed.
+	current_epoc=$(date +%s)
+	elapse_epoc=$(($current_epoc - $start_epoc))
+
+	[ $elapse_epoc -ge $duration ] && break
 
-    # Do not request the file over the specified quontity
-    http_num=`ps auxw | grep -v grep | grep -- "curl -g.*$filename" | wc -l`
-    if [ $http_num -ge $connect_quantity ]; then
-	sleep 1
-	continue;
-    fi
+	# Do not request the file over the specified quantity
+	http_num=$(jobs | wc -l)
+	if [ $http_num -ge $connections ]; then
+		sleep 1
+		continue;
+	fi
 
-    # Login to the server
-    curl -g "http://${server_ipaddr}/${filename}" -o /dev/null >/dev/null 2>&1 &
+	# Login to the server
+	curl -s -g "http://$server_ipaddr/$filename" > /dev/null 2>&1 &
 done
 
-# kill the curl command
-killall -SIGINT curl >/dev/null 2>&1
-sleep 3
-killall -SIGKILL curl >/dev/null 2>&1
-wait
+killall -qw -s SIGPIPE curl
 
-# Check the test file is abole to be downloaded
-curl -g "http://${server_ipaddr}/${filename}" -o /dev/null >/dev/null 2>&1
-if [ $? -ne 0 ]; then
-    echo "Failed to download the file from http://${server_ipaddr}/${filename}"
-    exit 1
-fi
+curl -g "http://$server_ipaddr/$filename" -o /dev/null || \
+	tst_brkm TBROK "Failed to get http://$server_ipaddr/$filename"
 
-exit 0
+tst_exit
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
