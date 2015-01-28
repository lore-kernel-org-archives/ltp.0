Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1YGRQK-0000J1-IG
	for ltp-list@lists.sourceforge.net; Wed, 28 Jan 2015 12:08:44 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YGRQH-0003ve-3o
	for ltp-list@lists.sourceforge.net; Wed, 28 Jan 2015 12:08:44 +0000
Received: from ucsinet22.oracle.com (ucsinet22.oracle.com [156.151.31.94])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t0SC8ZMp005027
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 28 Jan 2015 12:08:36 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by ucsinet22.oracle.com (8.14.5+Sun/8.14.5) with ESMTP id
	t0SC8ZvW010585
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Wed, 28 Jan 2015 12:08:35 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	t0SC8YZm020832
	for <ltp-list@lists.sourceforge.net>; Wed, 28 Jan 2015 12:08:34 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 28 Jan 2015 15:10:52 +0300
Message-Id: <1422447054-9775-2-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1422447054-9775-1-git-send-email-alexey.kodanev@oracle.com>
References: <1422447054-9775-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH 2/4] network/stress/ftp: cleanup,
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
 testcases/network/stress/ftp/00_Descriptions.txt   |   33 +--
 testcases/network/stress/ftp/ftp-download-stress   |  364 +++-----------------
 .../network/stress/ftp/ftp-download-stress01-rmt   |   89 ++----
 .../network/stress/ftp/ftp-download-stress02-rmt   |  127 +++-----
 testcases/network/stress/ftp/ftp-upload-stress     |  344 ++++---------------
 .../network/stress/ftp/ftp-upload-stress01-rmt     |  105 ++----
 .../network/stress/ftp/ftp-upload-stress02-rmt     |  144 +++-----
 7 files changed, 286 insertions(+), 920 deletions(-)

diff --git a/testcases/network/stress/ftp/00_Descriptions.txt b/testcases/network/stress/ftp/00_Descriptions.txt
index b86a58a..f244042 100644
--- a/testcases/network/stress/ftp/00_Descriptions.txt
+++ b/testcases/network/stress/ftp/00_Descriptions.txt
@@ -1,32 +1,15 @@
-ftp4-download-stress01
+ftp-download-stress01
 	Verify the ftp server or the kernel is not down after a ftp client
-	requests large data via IPv4
+	requests large data via IPv4/IPv6
 
-ftp4-download-stress02
+ftp-download-stress02
 	Verify the ftp server or the kernel is not down after many ftp
-	clients request data over IPv4 asynchronously for a long time
+	clients request data over IPv4/IPv6 asynchronously for a long time
 
-ftp6-download-stress01
+ftp-upload-stress01
 	Verify the ftp server or the kernel is not down after a ftp client
-	requests large data via IPv6
+	uploads a large data via IPv4/IPv6
 
-ftp6-download-stress02
-	Verify the ftp server or the kernel is not down after many ftp
-	clients request data over IPv6 asynchronously for a long time
-
-
-ftp4-upload-stress01
-	Verify the ftp server or the kernel is not down after a ftp client
-	uploads a large data via IPv4
-
-ftp4-upload-stress02
-	Verify the ftp server or the kernel is not down after many ftp clients
-	uploads data over IPv4 asynchronously for a long time
-
-ftp6-upload-stress01
-	Verify the ftp server or the kernel is not down after a ftp client
-	uploads a large data via IPv6
-
-ftp6-upload-stress02
+ftp-upload-stress02
 	Verify the ftp server or the kernel is not down after many ftp clients
-	uploads data over IPv6 asynchronously for a long time
+	uploads data over IPv4/IPv6 asynchronously for a long time
diff --git a/testcases/network/stress/ftp/ftp-download-stress b/testcases/network/stress/ftp/ftp-download-stress
index 0e4812c..0943e24 100644
--- a/testcases/network/stress/ftp/ftp-download-stress
+++ b/testcases/network/stress/ftp/ftp-download-stress
@@ -1,349 +1,97 @@
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
-#   ftp4-download-stress
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
 #
-# Description:
-#   Stress test for ftp over IPv4
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
 #
-#   test01 - Verify the ftp server or the kernel is not down after
-#            a ftp client requests large data
-#   test02 - Verify the ftp server or the kernel is not down after
-#            many ftp clients request data asynchronously for a long time
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
-
-# Make sure the value of LTPROOT
-LTPROOT=${LTPROOT:-`(cd ../../../../ ; pwd)`}
-export LTPROOT
+# Author: Mitsuru Chinen <mitch@jp.ibm.com>
 
-# Total number of the test case
+TCID=ftp-download-stress
 TST_TOTAL=2
-export TST_TOTAL
-
-# The version of IP
-IP_VER=${IP_VER:-4}
-
-# Default of the test case ID and the test case count
-TCID=ftp${IP_VER}-download-stress
-TST_COUNT=0
-export TCID
-export TST_COUNT
-
-# Check the environmanet variable
-. check_envval || exit $TST_TOTAL
+TST_CLEANUP="cleanup"
 
-# Dulation of the test [sec]
-NS_DURATION=${NS_DURATION:-3600}      # 1 hour
-
-# Quantity of the connection for multi connection test
-CONNECTION_TOTAL=${CONNECTION_TOTAL:-4000}
+. test_net.sh
 
 # Big file size to upload/download in ftp tests (byte)
-DOWNLOAD_BIGFILESIZE=${DOWNLOAD_BIGFILESIZE:-2147483647}        # 2GB - 1byte
-
+DOWNLOAD_BIGFILESIZE=${DOWNLOAD_BIGFILESIZE:-2147483647}
 # Regular file size to upload/download in ftp tests (byte)
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
+DOWNLOAD_REGFILESIZE=${DOWNLOAD_REGFILESIZE:-1048576}
 
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
-TESTFILE="ftp-download-stress.txt"
-
-#-----------------------------------------------------------------------
-#
-# Function:
-#   do_cleanup
-#
-# Description:
-#   Clean up after running ftp stress test
-#
-#-----------------------------------------------------------------------
-do_cleanup()
+cleanup()
 {
-    # Delete the test file
-    rm -f $FTP_DOWNLOAD_DIR/$TESTFILE
-
-    # Make sure to delete the temporary files
-    rm -f $message_file
-
-    # Initialize the interface
-    initialize_if lhost ${LINK_NUM}
-    initialize_if rhost ${LINK_NUM}
+	rm -f $FTP_DOWNLOAD_DIR/ftp_file*
+	rm -f $FTP_DOWNLOAD_DIR/ftp_reg_file*
+	tst_rmdir
+	pkill vsftpd
 }
 
-
-#-----------------------------------------------------------------------
-#
-# Function:
-#   do_setup
-#
-# Description:
-#   Setup for the ftp stress tests
-#   - Assign IP address to the interfaces belong to the specified Link
-#   - Run a ftpd daemon for testing
-#   - Create keys for password-less login
-#
-# Set Values:
-#   lhost_addr:   IP address of the local host
-#   rhost_addr:   IP address of the remote host
-#   rhost_config: ftp_config at the remote host
-#
-#-----------------------------------------------------------------------
-do_setup()
+setup()
 {
-    trap do_cleanup 0
+	tst_require_root
+	tst_check_cmds pkill vsftpd
+	tst_tmpdir
 
-    # Check the environment variable FTP_DOWNLOAD_DIR is set
-    if [ x$FTP_DOWNLOAD_DIR = x ]; then
-	tst_resm TINFO "*) At this ftp stress test, the ftp server program does not run automatically. Please start the server manually and set the document root directory in the environment variable, FTP_DOWNLOAD_DIR."
-	tst_resm TBROK "The environment variable FTP_DOWNLOAD_DIR is not set"
-	exit 1
-    fi
+	ipver=${TST_IPV6:-'4'}
+	tst_resm TINFO "run FTP over IPv$ipver"
 
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
+	[ "$FTP_DOWNLOAD_DIR" ] || \
+		tst_brkm TCONF "Start ftp server and set FTP_DOWNLOAD_DIR var"
 
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
+	tst_resm TINFO "restart vsftpd with custom options"
+	pkill vsftpd
+	touch vsftpd.conf
 
-	lhost_addr="${IPV4_NETWORK}.${LHOST_IPV4_HOST}"
-	rhost_addr="${IPV4_NETWORK}.${RHOST_IPV4_HOST}"
-	check_icmpv4_connectivity $lhost_ifname $rhost_addr
-	if [ $? -ne 0 ]; then
-	    tst_resm TBROK "Failed to ping to $rhost_addr"
-	    exit 1
-	fi
-	;;
+	local ip_opt="-olisten=YES -olisten_ipv6=NO"
+	[ $TST_IPV6 ] && ip_opt="-olisten=NO -olisten_ipv6=YES"
 
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
+	vsftpd $ip_opt -oanonymous_enable=YES vsftpd.conf
 }
 
-
-#-----------------------------------------------------------------------
-#
-# Function:
-#   test01
-#
-# Description:
-#   Verify the ftp server or the kernel is not down after a ftp
-#   client requests large data
-#
-#-----------------------------------------------------------------------
 test01()
 {
-    TCID=ftp${IP_VER}-download-stress01
-    TST_COUNT=1
-    tst_resm TINFO "Verify the ftp server or the kernel is not down after a ftp client requests data whose size is $DOWNLOAD_BIGFILESIZE byte via IPv${IP_VER}"
-
-    # Create a test file for download
-    rm -f $FTP_DOWNLOAD_DIR/$TESTFILE
-    create_file $FTP_DOWNLOAD_DIR/$TESTFILE $DOWNLOAD_BIGFILESIZE
-    if [ $? -ne 0 ]; then
-      tst_resm TBROK "Failed to create $FTP_DOWNLOAD_DIR/$TESTFILE"
-    fi
-
-    # Script name at the remote host
-    rmtscript="ftp-download-stress01-rmt"
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
+	tst_resm TINFO "download file with size '$DOWNLOAD_BIGFILESIZE'"
 
-    rm -f $FTP_DOWNLOAD_DIR/$TESTFILE
+	create_file $FTP_DOWNLOAD_DIR/ftp_file $DOWNLOAD_BIGFILESIZE || \
+		tst_resm TBROK "Failed to create test file"
 
-    if $not_run_rmtscript ; then
-	tst_resm TBROK "Failed to run the test script at the remote host"
-	rm -f $message_file
-	exit 1
-    fi
+	# Run the script at the remote host
+	tst_rhost_run -s -c "ftp-download-stress01-rmt \
+		$(tst_ipaddr) ftp_file"
 
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
-#   Verify the ftp server or the kernel is not down after many ftp
-#   clients request data asynchronously for a long time
-#
-#-----------------------------------------------------------------------
 test02()
 {
-    TCID=ftp${IP_VER}-download-stress02
-    TST_COUNT=2
-    tst_resm TINFO "Verify the ftp server or the kernel is not down after many ftp clients request data over IPv${IP_VER} asynchronously in ${NS_DURATION}[sec]"
-    tst_resm TINFO "The number of client is not over $CONNECTION_TOTAL"
-
-    # Create a test file for download
-    rm -f $FTP_DOWNLOAD_DIR/$TESTFILE
-    create_file $FTP_DOWNLOAD_DIR/$TESTFILE $DOWNLOAD_REGFILESIZE
-    if [ $? -ne 0 ]; then
-      tst_resm TBROK "Failed to create $FTP_DOWNLOAD_DIR/$TESTFILE"
-    fi
-
-    # Script name at the remote host
-    rmtscript="ftp-download-stress02-rmt"
+	tst_resm TINFO "Download data asynchronously in $NS_DURATION sec"
 
-    # Run the script at the remote host
-    message_file=`mktemp -p $TMPDIR`
-    not_run_rmtscript=true
-    for rmtdir in ${LTPROOT}/testcases/bin ${PWD} ; do
-	ret=`$LTP_RSH $RHOST 'test -x '${rmtdir}/${rmtscript}' ; echo $?'`
-	if [ $ret -eq 0 ]; then
-	    not_run_rmtscript=false
-	    $LTP_RSH $RHOST "${rmtdir}/${rmtscript} $lhost_addr $TESTFILE $NS_DURATION $CONNECTION_TOTAL" > $message_file 2>/dev/null
-	    retval=$?
-	    break
-	fi
-    done
+	create_file $FTP_DOWNLOAD_DIR/ftp_reg_file $DOWNLOAD_REGFILESIZE || \
+		tst_resm TBROK "Failed to create test file"
 
-    rm -f $FTP_DOWNLOAD_DIR/$TESTFILE
+	tst_rhost_run -s -c "ftp-download-stress02-rmt $(tst_ipaddr) \
+		ftp_reg_file $NS_DURATION $CONNECTION_TOTAL"
 
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
diff --git a/testcases/network/stress/ftp/ftp-download-stress01-rmt b/testcases/network/stress/ftp/ftp-download-stress01-rmt
index dd50925..1619da2 100644
--- a/testcases/network/stress/ftp/ftp-download-stress01-rmt
+++ b/testcases/network/stress/ftp/ftp-download-stress01-rmt
@@ -1,78 +1,41 @@
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
-#   ftp-download-stress01-rmt
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
 #
-# Description:
-#   This is the remote script for ftp-download-ipv${IP_VER}-stress01
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
+TCID=ftp-download-stress01-rmt
+TST_TOTAL=1
+
+. test_net.sh
 
-# Check the arguments
-if [ $# -ne 2 ]; then
-    echo "Usage: $0 server_ipaddr filename"
-    exit 1
-fi
 server_ipaddr="$1"
 filename="$2"
 
-echo $server_ipaddr | fgrep ':' >/dev/null 2>&1
-if [ $? -eq 0 ]; then
-    server_ipaddr='['$server_ipaddr']'
-fi
+tst_check_cmds curl
 
-# Check the curl command is available
-which curl >/dev/null 2>&1
-if [ $? -ne 0 ]; then
-    echo "The remote host does not have curl command."
-    exit 1
+echo $server_ipaddr | grep ':' > /dev/null
+if [ $? -eq 0 ]; then
+	server_ipaddr='['$server_ipaddr']'
 fi
 
-#
 # Download the test file
-#
-curl -g "ftp://${server_ipaddr}/${filename}" -o /dev/null >/dev/null 2>&1
-if [ $? -ne 0 ]; then
-    echo "Failed to download the file from ftp://${server_ipaddr}/${filename}"
-    exit 1
-fi
+curl -s -g "ftp://$server_ipaddr/$filename" -o /dev/null > /dev/null || \
+	tst_brkm TBROK "Failed to download ftp://$server_ipaddr/$filename"
 
-exit 0
+tst_exit
diff --git a/testcases/network/stress/ftp/ftp-download-stress02-rmt b/testcases/network/stress/ftp/ftp-download-stress02-rmt
index 95a8748..c0ed782 100644
--- a/testcases/network/stress/ftp/ftp-download-stress02-rmt
+++ b/testcases/network/stress/ftp/ftp-download-stress02-rmt
@@ -1,105 +1,66 @@
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
-#   ftp-download-stress02-rmt
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
 #
-# Description:
-#   This is the remote script for ftp-download-ipv${IP_VER}-stress02
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
+TCID=ftp-download-stress02-rmt
+TST_TOTAL=1
+
+. test_net.sh
+
+tst_check_cmds killall
 
-# Check the arguments
-if [ $# -ne 4 ]; then
-    echo "Usage: $0 server_addr filename duration connect_quantity"
-    exit 1
-fi
 server_ipaddr="$1"
 filename="$2"
 duration="$3"
 connect_quantity="$4"
 
-echo $server_ipaddr | fgrep ':' >/dev/null 2>&1
+echo $server_ipaddr | grep ':' > /dev/null
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
+	if [ $elapse_epoc -ge $duration ]; then
+		break
+	fi
 
-    # Do not request the file over the specified quontity
-    ftp_num=`ps auxw | grep -v grep | grep -- "curl -g.*$filename" | wc -l`
-    if [ $ftp_num -ge $connect_quantity ]; then
-	sleep 1
-	continue;
-    fi
+	# Do not request the file over the specified quantity
+	ftp_num=$(ps auxw | grep -v grep | grep -- "curl -g.*$filename" | wc -l)
+	if [ $ftp_num -ge $connect_quantity ]; then
+		sleep 1
+		continue;
+	fi
 
-    # Login to the server
-    curl -g "ftp://${server_ipaddr}/${filename}" -o /dev/null >/dev/null 2>&1 &
+	# Login to the server
+	curl -s -g "ftp://${server_ipaddr}/${filename}" \
+		-o /dev/null >/dev/null 2>&1 &
 done
 
-# kill the curl command
-killall -SIGINT curl >/dev/null 2>&1
-sleep 3
-killall -SIGKILL curl >/dev/null 2>&1
-wait
+killall -qw -s SIGPIPE curl
 
-# Check the test file is abole to be downloaded
-curl -g "ftp://${server_ipaddr}/${filename}" -o /dev/null >/dev/null 2>&1
-if [ $? -ne 0 ]; then
-    echo "Failed to download the file from ftp://${server_ipaddr}/${filename}"
-    exit 1
-fi
+# Check the test file
+curl -s -g "ftp://${server_ipaddr}/${filename}" -o /dev/null || \
+	tst_brkm TBROK "Failed to download ftp://${server_ipaddr}/${filename}"
 
-exit 0
+tst_exit
diff --git a/testcases/network/stress/ftp/ftp-upload-stress b/testcases/network/stress/ftp/ftp-upload-stress
index 9e3c8c7..c8c64be 100644
--- a/testcases/network/stress/ftp/ftp-upload-stress
+++ b/testcases/network/stress/ftp/ftp-upload-stress
@@ -1,326 +1,106 @@
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
-#   ftp-upload-stress-ipv4
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
 #
-# Description:
-#   Stress test for ftp over IPv4
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
 #
-#   test01 - Verify the ftp server or the kernel is not down after
-#            a ftp client puts large data
-#   test02 - Verify the ftp server or the kernel is not down after
-#            many ftp clients puts data asynchronously for a long time
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
+TCID=ftp-upload-stress
 TST_TOTAL=2
-export TST_TOTAL
-
-# The version of IP
-IP_VER=${IP_VER:-4}
-
-# Default of the test case ID and the test case count
-TCID=ftp${IP_VER}-upload-stress
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
-# The number of the test link where tests run
-LINK_NUM=0
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
-
-# Host portion of the IPv6 address of the remote host
-RHOST_IPV6_HOST=":1"
-
-# The test file name for uploading
-TESTFILE="ftp-upload-stress.txt"
+. test_net.sh
 
 # Big file size to upload (byte)
 UPLOAD_BIGFILESIZE=${UPLOAD_BIGFILESIZE:-2147483647}  # 2GB - 1
-
 # Regular file size to upload(byte)
 UPLOAD_REGFILESIZE=${UPLOAD_REGFILESIZE:-1024}     # 1K byte
 
-
-#-----------------------------------------------------------------------
-#
-# Function:
-#   do_cleanup
-#
-# Description:
-#   Clean up after running ftp stress test
-#
-#-----------------------------------------------------------------------
-do_cleanup()
+cleanup()
 {
-    # Delete the test file
-    rm -f $FTP_UPLOAD_DIR/${TESTFILE}*
-
-    # Make sure to delete the temporary files
-    rm -f $message_file
-
-    # Initialize the interface
-    initialize_if lhost ${LINK_NUM}
-    initialize_if rhost ${LINK_NUM}
+	rm -f $FTP_UPLOAD_DIR/ftp_file*
+	rm -f $FTP_UPLOAD_DIR/ftp_reg_file*
+	tst_rmdir
+	pkill vsftpd
 }
 
-
-#-----------------------------------------------------------------------
-#
-# Function:
-#   do_setup
-#
-# Description:
-#   Setup for the ftp stress tests
-#   - Assign IP address to the interfaces belong to the specified Link
-#   - Run a ftpd daemon for testing
-#   - Create keys for password-less login
-#
-# Set Values:
-#   lhost_addr:   IP address of the local host
-#   rhost_addr:   IP address of the remote host
-#   rhost_config: ftp_config at the remote host
-#
-#-----------------------------------------------------------------------
-do_setup()
+setup()
 {
-    trap do_cleanup 0
+	tst_require_root
+	tst_check_cmds pkill vsftpd
+	tst_tmpdir
 
-    # Check the environment variable FTP_UPLOAD_DIR is set
-    if [ x$FTP_UPLOAD_DIR = x ]; then
-	tst_resm TINFO "*) At this ftp stress test, the ftp server program does not run automatically. Please start the server manually and set the document root directory in the environment variable, FTP_UPLOAD_DIR."
-	tst_resm TBROK "The environment variable FTP_UPLOAD_DIR is not set"
-	exit 1
-    fi
+	ipver=${TST_IPV6:-'4'}
+	tst_resm TINFO "run FTP over IPv$ipver"
 
-    # Check the environment variable FTP_UPLOAD_URLDIR is set
-    if [ x$FTP_UPLOAD_URLDIR = x ]; then
-	tst_resm TINFO "*) At this ftp stress test, the ftp server program does not run automatically. Please start the server manually and set the directory part of the url in the environment variable, FTP_UPLOAD_URLDIR."
-	tst_resm TBROK "The environment variable FTP_UPLOAD_URLDIR is not set"
-	exit 1
-    fi
+	trap "tst_brkm TBROK 'test interrupted'" INT
 
-    # Initialize the interface
-    initialize_if lhost ${LINK_NUM} || exit 1
-    initialize_if rhost ${LINK_NUM} || exit 1
+	[ -d "$FTP_UPLOAD_DIR" ] || \
+		tst_brkm TCONF "Start ftp server and set FTP_UPLOAD_DIR var"
 
-    # Get the Interface name
-    lhost_ifname=`get_ifname lhost ${LINK_NUM}` || exit 1
+	chmod o+w $FTP_UPLOAD_DIR
 
-    case $IP_VER in
-	4)
-	# Set IPv4 address to the interfaces
-	set_ipv4addr lhost ${LINK_NUM} ${IPV4_NETWORK} ${LHOST_IPV4_HOST} \
-	    || exit 1
-	set_ipv4addr rhost ${LINK_NUM} ${IPV4_NETWORK} ${RHOST_IPV4_HOST} \
-	    || exit 1
-
-	lhost_addr="${IPV4_NETWORK}.${LHOST_IPV4_HOST}"
-	rhost_addr="${IPV4_NETWORK}.${RHOST_IPV4_HOST}"
-	check_icmpv4_connectivity $lhost_ifname $rhost_addr
-	if [ $? -ne 0 ]; then
-	    tst_resm TBROK "Failed to ping to $rhost_addr"
-	    exit 1
+	getenforce 2> /dev/null | grep -q Enforcing
+	if [ $? -eq 0 ]; then
+		tst_resm TINFO "configuring SELinux FTP parameters"
+		tst_check_cmds chcon setsebool
+		setsebool allow_ftpd_anon_write 1 || \
+			tst_brkm TBROK "Failed to allow ftpd anonymous write"
+		chcon -R -t public_content_rw_t $FTP_UPLOAD_DIR || \
+			tst_brkm TBROK "Failed to apply public_content_rw_t"
 	fi
-	;;
 
-	6)
-	# Set IPv6 address to the interfaces
-	add_ipv6addr lhost ${LINK_NUM} ${IPV6_NETWORK} ${LHOST_IPV6_HOST} \
-	    || exit 1
-	add_ipv6addr rhost ${LINK_NUM} ${IPV6_NETWORK} ${RHOST_IPV6_HOST} \
-	    || exit 1
+	tst_resm TINFO "restart vsftpd with custom options"
+	pkill vsftpd
+	touch vsftpd.conf
 
-	lhost_addr="${IPV6_NETWORK}:${LHOST_IPV6_HOST}"
-	rhost_addr="${IPV6_NETWORK}:${RHOST_IPV6_HOST}"
-	check_icmpv6_connectivity $lhost_ifname $rhost_addr
-	if [ $? -ne 0 ]; then
-	    tst_resm TBROK "Failed to ping to $rhost_addr"
-	    exit 1
-	fi
-	;;
+	local ip_opt="-olisten=YES -olisten_ipv6=NO"
+	[ $TST_IPV6 ] && ip_opt="-olisten=NO -olisten_ipv6=YES"
 
-	*)
-	tst_resm TBROK "Unknown IP version: $IP_VER"
-	exit 1
-	;;
-    esac
-}
+	upload_opt="-owrite_enable=YES -oanon_upload_enable=YES"
 
+	vsftpd $ip_opt $upload_opt -oanonymous_enable=YES vsftpd.conf
+}
 
-#-----------------------------------------------------------------------
-#
-# Function:
-#   test01
-#
-# Description:
-#   Verify the ftp server or the kernel is not down after a ftp
-#   client uploads large data
-#
-#-----------------------------------------------------------------------
 test01()
 {
-    TCID=ftp${IP_VER}-upload-stress01
-    TST_COUNT=1
-    tst_resm TINFO "Verify the ftp server or the kernel is not down after a ftp client uploads data whose size is $UPLOAD_BIGFILESIZE byte via IPv${IP_VER}"
-
-    # Script name at the remote host
-    rmtscript="ftp-upload-stress01-rmt"
-
-    # Run the script at the remote host
-    message_file=`mktemp -p $TMPDIR`
-    not_run_rmtscript=true
-    for rmtdir in ${LTPROOT}/testcases/bin ${PWD} ; do
-	ret=`$LTP_RSH $RHOST 'test -x '${rmtdir}/${rmtscript}' ; echo $?'`
-	if [ $ret -eq 0 ]; then
-	    not_run_rmtscript=false
-	    $LTP_RSH $RHOST "${rmtdir}/${rmtscript} $lhost_addr $FTP_UPLOAD_URLDIR $TESTFILE $UPLOAD_BIGFILESIZE" > $message_file
-	    break
-	fi
-    done
-
-    rm -f $FTP_UPLOAD_DIR/$TESTFILE
+	tst_resm TINFO "upload file with size '$UPLOAD_BIGFILESIZE'"
 
-    if $not_run_rmtscript ; then
-	tst_resm TBROK "Failed to run the test script at the remote host"
-	rm -f $message_file
-	exit 1
-    fi
+	# Run the script at the remote host
+	tst_rhost_run -s -c "ftp-upload-stress01-rmt $(tst_ipaddr) \
+		$FTP_UPLOAD_URLDIR ftp_file $UPLOAD_BIGFILESIZE"
 
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
-#   Verify the ftp server or the kernel is not down after many ftp
-#   clients uploads data asynchronously for a long time
-#
-#-----------------------------------------------------------------------
 test02()
 {
-    TCID=ftp${IP_VER}-upload-stress02
-    TST_COUNT=2
-    tst_resm TINFO "Verify the ftp server or the kernel is not down after many ftp clients uploads data over IPv${IP_VER} asynchronously in ${NS_DURATION}[sec]"
-    tst_resm TINFO "The number of client is not over $CONNECTION_TOTAL"
-
-    # Script name at the remote host
-    rmtscript="ftp-upload-stress02-rmt"
-
-    # Run the script at the remote host
-    message_file=`mktemp -p $TMPDIR`
-    not_run_rmtscript=true
-    for rmtdir in ${LTPROOT}/testcases/bin ${PWD} ; do
-	ret=`$LTP_RSH $RHOST 'test -x '${rmtdir}/${rmtscript}' ; echo $?'`
-	if [ $ret -eq 0 ]; then
-	    not_run_rmtscript=false
-	    $LTP_RSH $RHOST "${rmtdir}/${rmtscript} $lhost_addr $FTP_UPLOAD_URLDIR $TESTFILE $UPLOAD_REGFILESIZE $NS_DURATION $CONNECTION_TOTAL" > $message_file 2>/dev/null
-	    break
-	fi
-    done
-
-    rm -f $FTP_UPLOAD_DIR/${TESTFILE}*
+	tst_resm TINFO "Upload data asynchronously in $NS_DURATION sec"
 
-    if $not_run_rmtscript ; then
-	tst_resm TBROK "Failed to run the test script at the remote host"
-	rm -f $message_file
-	exit 1
-    fi
+	tst_rhost_run -s -c "ftp-upload-stress02-rmt \
+		$(tst_ipaddr) $FTP_UPLOAD_URLDIR ftp_reg_file \
+		$UPLOAD_REGFILESIZE $NS_DURATION $CONNECTION_TOTAL"
 
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
diff --git a/testcases/network/stress/ftp/ftp-upload-stress01-rmt b/testcases/network/stress/ftp/ftp-upload-stress01-rmt
index 7cafa73..70a52ac 100644
--- a/testcases/network/stress/ftp/ftp-upload-stress01-rmt
+++ b/testcases/network/stress/ftp/ftp-upload-stress01-rmt
@@ -1,91 +1,56 @@
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
-#   ftp-upload-stress01-rmt
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
 #
-# Description:
-#   This is the remote script for ftp-upload-ipv${IP_VER}-stress01
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
-#   $2: filename to upload
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
+TCID=ftp-upload-stress01-rmt
+TST_TOTAL=1
+TST_CLEANUP="cleanup"
+
+. test_net.sh
 
-# Check the arguments
-if [ $# -ne 4 ]; then
-    echo "Usage: $0 server_ipaddr urldir filename filesize"
-    exit 1
-fi
 server_ipaddr="$1"
 urldir="$2"
 filename="$3"
 filesize="$4"
 
-echo $server_ipaddr | fgrep ':' >/dev/null 2>&1
-if [ $? -eq 0 ]; then
-    server_ipaddr='['$server_ipaddr']'
-fi
+tst_check_cmds curl
 
-# Check the curl command is available
-which curl >/dev/null 2>&1
-if [ $? -ne 0 ]; then
-    echo "The remote host does not have curl command."
-    exit 1
+cleanup()
+{
+	rm -f $filename
+}
+
+echo $server_ipaddr | grep ':' > /dev/null
+if [ $? -eq 0 ]; then
+	server_ipaddr='['$server_ipaddr']'
 fi
 
 # Create a file to upload
 echo -n "A" > $filename
-echo -n "Z" | dd of=$filename bs=1 seek=`expr $filesize - 1` >/dev/null 2>&1
-if [ $? -ne 0 ]; then
-    echo "Failed to create $filename"
-    exit 1
-fi
-
+echo -n "Z" | dd of=$filename bs=1 seek=$(($filesize - 1)) > /dev/null 2>&1 || \
+	tst_brkm TBROK "Failed to create $filename"
 
-#
-# Download the test file
-#
-curl -u anonymous:ftp@ltp-ns.org -T $filename -g "ftp://${server_ipaddr}/${urldir}/" >/dev/null 2>&1
+curl -u anonymous:ftp@ltp-ns.org -T $filename \
+	-g "ftp://$server_ipaddr/$urldir/" > /dev/null 2>&1
 if [ $? -ne 0 ]; then
-    echo "Failed to upload the file to ftp://${server_ipaddr}/${urldir}/"
-    rm -f $filename
-    exit 1
+	tst_brkm TBROK "Failed to upload ftp://$server_ipaddr/$urldir/"
 fi
 
-rm -f $filename
-exit 0
+tst_exit
diff --git a/testcases/network/stress/ftp/ftp-upload-stress02-rmt b/testcases/network/stress/ftp/ftp-upload-stress02-rmt
index 76b9e4d..be4b1cd 100644
--- a/testcases/network/stress/ftp/ftp-upload-stress02-rmt
+++ b/testcases/network/stress/ftp/ftp-upload-stress02-rmt
@@ -1,58 +1,32 @@
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
-#   ftp-upload-stress02-rmt
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
 #
-# Description:
-#   This is the remote script for ftp-upload-ipv${IP_VER}-stress02
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
-#   $2: filename to upload
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
+TCID=ftp-upload-stress02-rmt
+TST_TOTAL=1
+TST_CLEANUP="cleanup"
+
+. test_net.sh
+
+tst_check_cmds killall
 
-# Check the arguments
-if [ $# -ne 6 ]; then
-  echo "Usage: $0 server_addr urldir filename filesize duration client_num"
-    exit 1
-fi
 server_ipaddr="$1"
 urldir="$2"
 filename="$3"
@@ -60,58 +34,50 @@ filesize="$4"
 duration="$5"
 client_num="$6"
 
-echo $server_ipaddr | fgrep ':' >/dev/null 2>&1
+cleanup()
+{
+	rm -f $filename
+}
+
+echo $server_ipaddr | grep ':' > /dev/null
 if [ $? -eq 0 ]; then
-    server_ipaddr='['$server_ipaddr']'
+	server_ipaddr='['$server_ipaddr']'
 fi
 
-# Unset the maximum number of processes
-ulimit -u unlimited
-
 # Create a file to upload
 echo -n "A" > $filename
-echo -n "Z" | dd of=$filename bs=1 seek=`expr $filesize - 1` >/dev/null 2>&1
-if [ $? -ne 0 ]; then
-    echo "Failed to create $filename"
-    exit 1
-fi
+echo -n "Z" | dd of=$filename bs=1 seek=$(($filesize - 1)) > /dev/null 2>&1 || \
+	tst_brkm TBROK "Failed to create $filename"
 
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
-
-    num=0
-    while [ $num -lt $client_num ]; do
-	ps auxw | grep -l -- "curl.*${filename}${num}" >/dev/null 2>&1
-	if [ $? -eq 0 ]; then
-	    num=`expr $num + 1`
-	    continue
+	# Exit when the specified seconds have passed.
+	current_epoc=$(date +%s)
+	elapse_epoc=$(($current_epoc - $start_epoc))
+	if [ $elapse_epoc -ge $duration ]; then
+		break
 	fi
-	curl -u anonymous:ftp@ltp-ns.org -T $filename -g "ftp://${server_ipaddr}/${urldir}/${filename}${num}" >/dev/null 2>&1
-	num=`expr $num + 1`
-    done
+
+	num=0
+	while [ $num -lt $client_num ]; do
+		ps auxw | grep -l -- "curl.*${filename}${num}" >/dev/null 2>&1
+		if [ $? -eq 0 ]; then
+			num=$(($num + 1))
+			continue
+		fi
+		curl -u anonymous:ftp@ltp-ns.org -T $filename \
+			-g "ftp://${server_ipaddr}/${urldir}/${filename}${num}" \
+			>/dev/null 2>&1 &
+		num=$(($num + 1))
+	done
 done
 
-# kill the curl command
-killall -SIGINT curl >/dev/null 2>&1
-sleep 3
-killall -SIGKILL curl >/dev/null 2>&1
-wait
+killall -qw -s SIGPIPE curl
 
-# Check the test file is abole to be uploaded
-curl -u anonymous:ftp@ltp-ns.org -T $filename -g "ftp://${server_ipaddr}/${urldir}/" >/dev/null 2>&1
+curl -u anonymous:ftp@ltp-ns.org -T $filename \
+	-g "ftp://$server_ipaddr/$urldir/" >/dev/null 2>&1
 if [ $? -ne 0 ]; then
-    echo "Failed to upload the file to ftp://${server_ipaddr}/${urldir}/"
-    rm -f $filename
-    exit 1
+	tst_brkm TBROK "Failed to upload ftp://$server_ipaddr/$urldir/"
 fi
 
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
