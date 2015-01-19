Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1YDDcH-0002Fn-5g
	for ltp-list@lists.sourceforge.net; Mon, 19 Jan 2015 14:47:45 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YDDcE-0006Y8-3F
	for ltp-list@lists.sourceforge.net; Mon, 19 Jan 2015 14:47:45 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t0JElZZU029040
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 19 Jan 2015 14:47:36 GMT
Received: from userz7022.oracle.com (userz7022.oracle.com [156.151.31.86])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	t0JElYrT012890
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Mon, 19 Jan 2015 14:47:35 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
	by userz7022.oracle.com (8.14.5+Sun/8.14.4) with ESMTP id
	t0JElXRA026961
	for <ltp-list@lists.sourceforge.net>; Mon, 19 Jan 2015 14:47:33 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 19 Jan 2015 17:49:47 +0300
Message-Id: <1421678989-28577-2-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1421678989-28577-1-git-send-email-alexey.kodanev@oracle.com>
References: <1421678989-28577-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH 2/4] network/stress/ssh: cleanup,
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
 testcases/network/stress/ssh/00_Descriptions.txt |   28 +-
 testcases/network/stress/ssh/ssh-stress          |  513 +++++-----------------
 testcases/network/stress/ssh/ssh-stress01-rmt    |  128 ++----
 testcases/network/stress/ssh/ssh-stress02-rmt    |  148 ++-----
 testcases/network/stress/ssh/ssh-stress03-rmt    |  179 +++------
 5 files changed, 251 insertions(+), 745 deletions(-)

diff --git a/testcases/network/stress/ssh/00_Descriptions.txt b/testcases/network/stress/ssh/00_Descriptions.txt
index b3a2f31..543e60d 100644
--- a/testcases/network/stress/ssh/00_Descriptions.txt
+++ b/testcases/network/stress/ssh/00_Descriptions.txt
@@ -1,21 +1,11 @@
-ssh4-stress01
-	Verify the ssh connectivity over IPv4 is not broken after creating
-	many ssh sessions
-ssh4-stress02
-	Verify the ssh connectivity over IPv4 is not broken after logged
-	in/out by many clients asynchronously for a long time
+ssh-stress01
+	Verify the ssh connectivity over IPv4/IPv6 is not broken
+	after creating many ssh sessions
 
-ssh4-stress03
-	Verify the ssh connectivity over IPv4 is not broken after forwarding
-	TCP traffic for a long time
+ssh-stress02
+	Verify the ssh connectivity over IPv4/IPv6 is not broken
+	after logged in/out by many clients asynchronously for a long time
 
-ssh6-stress01
-	Verify the ssh connectivity over IPv6 is not broken after creating
-	many ssh sessions
-ssh6-stress02
-	Verify the ssh connectivity over IPv6 is not broken after logged
-	in/out by many clients asynchronously for a long time
-
-ssh6-stress03
-	Verify the ssh connectivity over IPv6 is not broken after forwarding
-	TCP traffic for a long time
+ssh-stress03
+	Verify the ssh connectivity over IPv4/IPv6 is not broken
+	after forwarding TCP traffic for a long time
diff --git a/testcases/network/stress/ssh/ssh-stress b/testcases/network/stress/ssh/ssh-stress
index 8521b75..72bef25 100644
--- a/testcases/network/stress/ssh/ssh-stress
+++ b/testcases/network/stress/ssh/ssh-stress
@@ -1,461 +1,148 @@
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
-#   ssh4-stress
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
 #
-# Description:
-#   Stress test for SSH over IPv4
-#   test01 - Verify the ssh server or the kernel is not down after a large
-#            number of ssh sessions are created.
-#   test02 - Verify the ssh server or the kernel is not down after a large
-#            number of clients log in/out asynchronously for a long time.
-#   test03 - Verify the ssh server or the kernek is not down after a TCP
-#            traffic is forwarded via ssh port-forwarding for a long time
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
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
+# Author: Mitsuru Chinen <mitch@jp.ibm.com>
 #
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
 
-# Make sure the value of LTPROOT
-LTPROOT=${LTPROOT:-`(cd ../../../../ ; pwd)`}
-export LTPROOT
-
-# Total number of the test case
+TCID=ssh-stress
 TST_TOTAL=3
-export TST_TOTAL
-
-# The version of IP
-IP_VER=${IP_VER:-4}
-
-# Default of the test case ID and the test case count
-TCID=ssh${IP_VER}-stress
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
-# Temporary direcotry to store sshd setting or ssh key
-# Note: ssh doesn't work when those directory are under /tmp.
-SSH_TMPDIR_PARENT="/root"
+TST_CLEANUP="cleanup"
 
-# The number of the test link where tests run
-LINK_NUM=${LINK_NUM:-0}
+. test_net.sh
 
-# Network portion of the IPv4 address
-IPV4_NETWORK=${IPV4_NETWORK:-"10.0.0"}
+# Temporary directory to store sshd setting or ssh key
+# Note: ssh doesn't work when those directory is under /tmp.
+TMPDIR="/root"
 
-# Host portion of the IPv4 address on the local host
-LHOST_IPV4_HOST=${LHOST_IPV4_HOST:-"2"}
-
-# Host portion of the IPv4 address on the remote host
-RHOST_IPV4_HOST=${RHOST_IPV4_HOST:-"1"}
-
-# Network portion of the IPv6 address
-IPV6_NETWORK="fd00:1:1:1"
+cleanup()
+{
+	# Stop the ssh daemon
+	test -s sshd.pid && kill $(cat sshd.pid)
+	test "$server_pid" && kill -9 $server_pid > /dev/null 2>&1
+	tst_rmdir
+	TMPDIR=
+}
 
-# Host portion of the IPv6 address of the local host
-LHOST_IPV6_HOST=":2"
+setup()
+{
+	trap "tst_brkm TBROK 'test interrupted'" INT
 
-# Host portion of the IPv6 address of the remote host
-RHOST_IPV6_HOST=":1"
+	tst_require_root
+	tst_check_cmds sshd ssh od
 
-#-----------------------------------------------------------------------
-#
-# Function:
-#   do_cleanup
-#
-# Description:
-#   Clean up after running ssh stress test
-#
-#-----------------------------------------------------------------------
-do_cleanup()
-{
-    # Stop the ssh daemon
-    kill `cat ${sshd_dir}/sshd.pid`
+	ipver=${TST_IPV6:-"4"}
 
-    # Delete the dictory that stores configuration files
-    rm -rf $sshd_dir
-    $LTP_RSH $RHOST "rm -rf $rhost_ssh_dir"
+	# Get the sshd command with absolute path
+	SSHD=$(which sshd)
+	test "$SSHD" || tst_brkm TBROK "sshd daemon is not found"
 
-    # Delete the temporary files
-    rm -f $message_file
+	check_icmpv${ipver}_connectivity $(tst_iface) $(tst_ipaddr rhost) || \
+		tst_brkm TBROK "Failed to ping to $(tst_ipaddr rhost)"
 
-    # Initialize the interface
-    initialize_if lhost ${LINK_NUM}
-    initialize_if rhost ${LINK_NUM}
+	port=$(tst_rhost_run -c "tst_get_unused_port ipv${ipver} stream")
 
-    # Kill the tcp traffic server
-    killall_tcp_traffic
-}
+	tst_tmpdir
 
+	tmpdir=$TST_TMPDIR
 
-#-----------------------------------------------------------------------
-#
-# Function:
-#   do_setup
-#
-# Description:
-#   Setup for the ssh stress tests
-#   - Assign IP address to the interfaces belong to the specified Link
-#   - Run a sshd daemon for testing
-#   - Create keys for password-less login
-#
-# Set Values:
-#   lhost_addr:   IP address of the local host
-#   rhost_addr:   IP address of the remote host
-#   rhost_config: ssh_config at the remote host
-#
-#-----------------------------------------------------------------------
-do_setup()
-{
-    trap do_cleanup 0
-
-    # Get the sshd command with absolute path
-    SSHD=`which sshd`
-    if [ x"${SSHD}" = x ]; then
-	tst_resm TBROK "sshd daemon is not found"
-	exit $TST_TOTAL
-    fi
-
-    # Kill the tcp traffic server
-    killall_tcp_traffic
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
-	    exit 1
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
-
-    #
-    # Start sshd for testing
-    #
-    port=`find_portbundle tcp 1025 1`
-    if [ $? -ne 0 ]; then
-	tst_resm TFAIL "No port is available."
-	exit 1
-    fi
-    sshd_dir=`TMPDIR="$SSH_TMPDIR_PARENT" mktemp -d`
-    cat << EOD > ${sshd_dir}/sshd_config
+	cat << EOD > $tmpdir/sshd_config
 Port $port
-ListenAddress $lhost_addr
+ListenAddress $(tst_ipaddr)
 PermitRootLogin yes
-AuthorizedKeysFile ${sshd_dir}/authorized_keys
+AuthorizedKeysFile $tmpdir/authorized_keys
 PasswordAuthentication no
 AllowTcpForwarding yes
 TCPKeepAlive yes
 UseDNS no
-PidFile ${sshd_dir}/sshd.pid
+PidFile $tmpdir/sshd.pid
 EOD
 
+	$SSHD -f $tmpdir/sshd_config || \
+		tst_brkm TBROK "Failed to run sshd daemon"
 
-    $SSHD -f ${sshd_dir}/sshd_config
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to run sshd daemon."
-	exit 1
-    fi
-
-    #
-    # Generate configuration file and key at the remote host
-    #
-    rhost_ssh_dir=`$LTP_RSH $RHOST "mktemp -d -p $SSH_TMPDIR_PARENT"`
-    ret=`$LTP_RSH $RHOST '( cd '$rhost_ssh_dir' && ssh-keygen -t rsa -N "" -f id_rsa ) >/dev/null 2>&1 ; echo $?'`
-    if [ $ret -ne 0 ]; then
-	tst_resm TBROK "Failed to generate key."
-	exit 1
-    fi
-
-    rhost_config=${rhost_ssh_dir}/ssh_config
-    rmtshell="$LTP_RSH"
-    echo $LTP_RSH | grep "rsh.*-n" >/dev/null 2>&1
-    if [ $? -eq 0 ]; then
-	rmtshell="`echo $LTP_RSH | sed "s/-n//"`"
-    fi
-
-    cat << EOD | $rmtshell $RHOST "cat > $rhost_config"
-Port $port
-StrictHostKeyChecking no
-PasswordAuthentication no
-UserKnownHostsFile $rhost_ssh_dir/known_hosts
-IdentityFile $rhost_ssh_dir/id_rsa
-EOD
-    $LTP_RSH $RHOST "cd $rhost_ssh_dir && cat id_rsa.pub" > ${sshd_dir}/authorized_keys
-    $LTP_RSH $RHOST "chmod 700 $rhost_ssh_dir ; chmod 600 $rhost_ssh_dir/*"
+	tst_resm TINFO "Generate configuration file and key at the remote host"
+	rtmpdir=$(tst_rhost_run -c "mktemp -d -p $TMPDIR")
+	tst_rhost_run -s -c "ssh-keygen -t rsa -N \"\" -f $rtmpdir/id_rsa > /dev/null"
 
-    chmod 700 $sshd_dir
-    chmod 600 $sshd_dir/*
-}
+	rconfig=$rtmpdir/ssh_config
 
+	tst_rhost_run -s -c "printf \"\
+Port $port\n\
+StrictHostKeyChecking no\n\
+PasswordAuthentication no\n\
+UserKnownHostsFile $rtmpdir/known_hosts\n\
+IdentityFile $rtmpdir/id_rsa\n\" > $rconfig"
+
+	tst_rhost_run -s -c "chmod 700 $rtmpdir; chmod 600 $rtmpdir/*"
+
+	tst_resm TINFO "Generate authorized_keys"
+	tst_rhost_run -c "cat ${rtmpdir}/id_rsa.pub" > $tmpdir/authorized_keys
+
+	tst_resm TINFO "restore context of authorized_keys"
+	local rc=$(which restorecon)
+	test "$rc" && $rc $tmpdir/authorized_keys
+
+	chmod 700 $tmpdir
+	chmod 600 $tmpdir/*
+}
 
-#-----------------------------------------------------------------------
-#
-# Function:
-#   test01
-#
-# Description:
-#   Verify the ssh connectivity is not broken after creating a large
-#   number of ssh sessions
-#
-#-----------------------------------------------------------------------
 test01()
 {
-    TCID=ssh${IP_VER}-stress01
-    TST_COUNT=1
-    tst_resm TINFO "Verify the ssh connectivity over IPv${IP_VER} is not broken after creating ${CONNECTION_TOTAL} ssh sessions"
-
-    # Script name at the remote host
-    rmtscript="ssh-stress01-rmt"
-
-    # Run the script at the remote host
-    message_file=`mktemp -p $TMPDIR`
-    not_run_rmtscript=true
-    for rmtdir in ${LTPROOT}/testcases/bin ${PWD} ; do
-	ret=`$LTP_RSH $RHOST 'test -x '${rmtdir}/${rmtscript}' ; echo $?'`
-	if [ $ret -eq 0 ]; then
-	    not_run_rmtscript=false
-	    $LTP_RSH $RHOST "${rmtdir}/${rmtscript} $IP_VER $lhost_addr $rhost_config $CONNECTION_TOTAL" > $message_file
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
+	tst_resm TINFO "Creating '$CONNECTION_TOTAL' ssh sessions"
 
-}
+	tst_rhost_run -s -c "ssh-stress01-rmt $ipver $(tst_ipaddr) \
+		$rconfig $CONNECTION_TOTAL"
 
+	tst_resm TPASS "Test is finished successfully"
+}
 
-#-----------------------------------------------------------------------
-#
-# Function:
-#   test02
-#
-# Description:
-#   Verify the ssh connectivity is not broken after logged in/out
-#   by many clients asynchronously for a long time
-#
-#-----------------------------------------------------------------------
 test02()
 {
-    TCID=ssh${IP_VER}-stress02
-    TST_COUNT=2
-    tst_resm TINFO "Verify the ssh connectivity over IPv${IP_VER} is not broken after logged in/out by many clients asynchronously in ${NS_DURATION}[sec]"
-    tst_resm TINFO "The number of client is not over $CONNECTION_TOTAL"
-
-    # Script name at the remote host
-    rmtscript="ssh-stress02-rmt"
-
-    # Run the script at the remote host
-    message_file=`mktemp -p $TMPDIR`
-    not_run_rmtscript=true
-    for rmtdir in ${LTPROOT}/testcases/bin ${PWD} ; do
-	ret=`$LTP_RSH $RHOST 'test -x '${rmtdir}/${rmtscript}' ; echo $?'`
-	if [ $ret -eq 0 ]; then
-	    not_run_rmtscript=false
-	    $LTP_RSH $RHOST "${rmtdir}/${rmtscript} $IP_VER $lhost_addr $rhost_config $CONNECTION_TOTAL $NS_DURATION" > $message_file
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
+	tst_resm TINFO "Log in/out by many clients asynchronously"
+	tst_resm TINFO "'$CONNECTION_TOTAL' clients, time $NS_DURATION sec"
 
+	tst_rhost_run -s -c "ssh-stress02-rmt $ipver $(tst_ipaddr) \
+		$rconfig $CONNECTION_TOTAL $NS_DURATION"
+
+	tst_resm TPASS "Test is finished successfully"
+}
 
-#-----------------------------------------------------------------------
-#
-# Function:
-#   test03
-#
-# Description:
-#   Verify the ssh connectivity is not broken after forwarding TCP traffic
-#   for a long time
-#
-#-----------------------------------------------------------------------
 test03()
 {
-    TCID=ssh${IP_VER}-stress03
-    TST_COUNT=3
-    tst_resm TINFO "Verify the ssh connectivity over IPv${IP_VER} is not broken after forwarding TCP traffic in ${NS_DURATION}[sec]"
-
-    # Script name at the remote host
-    rmtscript="ssh-stress03-rmt"
-
-    # Run a TCP traffic server
-    traffic_port=`find_portbundle tcp 1025 1` || exit 1
-    info_file=`mktemp -p $TMPDIR`
-    ns-tcpserver -b -f $IP_VER -p $traffic_port -o $info_file
-    if [ $? -ne 0 ]; then
-	tst_resm TFAIL "Failed to run a tcp traffic server."
-	rm -f $info_file
-	exit 1
-    fi
-
-    while true ; do
-	if [ -s $info_file ]; then
-	    break
-	fi
-    done
-
-    server_pid=`grep PID: $info_file | cut -f 2 -d ' '`
-    rm -f $info_file
-
-    # Run the script at the remote host
-    message_file=`mktemp -p $TMPDIR`
-    not_run_rmtscript=true
-    for rmtdir in ${LTPROOT}/testcases/bin ${PWD} ; do
-	ret=`$LTP_RSH $RHOST 'test -x '${rmtdir}/${rmtscript}' ; echo $?'`
-	if [ $ret -eq 0 ]; then
-	    not_run_rmtscript=false
-	    $LTP_RSH $RHOST "${rmtdir}/${rmtscript} $LTPROOT $IP_VER $lhost_addr $rhost_config $traffic_port $NS_DURATION" > $message_file
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
+	tst_resm TINFO "Forwarding TCP traffic in $NS_DURATION sec"
 
+	# Run a TCP traffic server
+	port=$(tst_get_unused_port ipv${ipver} stream)
 
-#-----------------------------------------------------------------------
-#
-# Main
-#
-# Exit Value:
-#   The number of the failure
-#
-#-----------------------------------------------------------------------
+	ns-tcpserver -b -f $ipver -p $port -o info_file || \
+		tst_brkm TBROK "Failed to run a tcp traffic server"
+	server_pid=$(grep 'PID:' info_file | cut -f 2 -d ' ')
+	tst_rhost_run -s -c "ssh-stress03-rmt $ipver $(tst_ipaddr) \
+		$rconfig $port $NS_DURATION"
+
+	tst_resm TPASS "Test is finished successfully"
+}
+
+setup
 
-RC=0
-do_setup
-test01 || RC=`expr $RC + 1`
-test02 || RC=`expr $RC + 1`
-test03 || RC=`expr $RC + 1`
+test01
+test02
+test03
 
-exit $RC
+tst_exit
diff --git a/testcases/network/stress/ssh/ssh-stress01-rmt b/testcases/network/stress/ssh/ssh-stress01-rmt
index a20d7a1..2a84957 100644
--- a/testcases/network/stress/ssh/ssh-stress01-rmt
+++ b/testcases/network/stress/ssh/ssh-stress01-rmt
@@ -1,114 +1,68 @@
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
-#   ssh-stress01-rmt
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
 #
-# Description:
-#   This is the remote script for ssh-ipv${IP_VER}-stress01
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
-#   $1: version of IP
-#   $2: IP address log into
-#   $3: ssh_config file
-#   $4: quantity of connection
+# Author: Mitsuru Chinen <mitch@jp.ibm.com>
 #
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
 
-# Check the arguments
+TCID="ssh_stress01_rmt"
+TST_TOTAL=1
+
+. test.sh
+
 if [ $# -ne 4 ]; then
-    echo "Usage: $0 IP_version server_addr config_dir connect_quantity"
-    exit 1
+	tst_brkm TBROK "Usage: $0 ipver rhost config connections"
 fi
+
 ip_ver="$1"
 server_ipaddr="$2"
 ssh_config="$3"
-connect_quontity="$4"
-
-# Unset the maximum number of processes
-ulimit -u unlimited
+connections="$4"
 
-# Specify the option of ssh accoring to the version of IP
-case $ip_ver in
-    4)
-    ver_opt="-4"
-    ;;
-    6)
-    ver_opt="-6"
-    ;;
-    *)
-    echo "$ver_opt is unknown IP version"
-    exit 1
-    ;;
-esac
+ssh -$ip_ver -F $ssh_config $server_ipaddr \
+	"true < /dev/null > /dev/null 2>&1" > /dev/null
 
-# Check the connectivity first
-if [ ! -f $ssh_config ]; then
-    echo "$ssh_config is something wrong."
-    exit 1
-fi
-ssh $ver_opt -F $ssh_config $server_ipaddr "true </dev/null >/dev/null 2>&1" >/dev/null 2>&1
-if [ $? -ne 0 ]; then
-    echo "Failed to connect $server_ipaddr"
-    exit 1
-fi
+[ $? -ne 0 ] && tst_brkm TBROK "Can't connect to '$server_ipaddr'"
 
-#
 # Make ssh connections
-#
 num=0
-while [ $num -lt $connect_quontity ]; do
-    ssh $ver_opt -f -N -F $ssh_config $server_ipaddr
-    if [ $? -ne 0 ]; then
-	echo "$num seems the maximun number of ssh connection." >&2
-	break
-    fi
-    num=`expr $num + 1`
+while [ $num -lt $connections ]; do
+	ssh -$ip_ver -f -N -F $ssh_config $server_ipaddr
+	if [ $? -ne 0 ]; then
+		tst_resm TINFO "'$num' seems the max num of ssh conn"
+		break
+	fi
+	num=$(($num + 1))
 done
 
 # Disconnect all ssh connection
-for ssh_pid in `ps auxw | fgrep -v grep | grep "ssh[[:blank:]].*${ssh_config}" | awk '{print $2}'` ; do
-    kill $ssh_pid
+all_conn=$(ps auxw | grep -Fv grep | \
+	grep "ssh[[:blank:]].*${ssh_config}" | awk '{print $2}')
+
+for ssh_pid in "$all_conn"; do
+	kill $ssh_pid
 done
 
 # Check the connectivity again
-ssh $ver_opt -F $ssh_config $server_ipaddr "true </dev/null >/dev/null 2>&1" >/dev/null 2>&1
+ssh -$ip_ver -F $ssh_config $server_ipaddr \
+	"true < /dev/null > /dev/null 2>&1" > /dev/null
 if [ $? -ne 0 ]; then
-    echo "Failed to connect $server_ipaddr. ssh connectivity is lost."
-    exit 1
+	tst_brkm TBROK "Failed to connect $server_ipaddr"
 fi
 
-exit 0
+tst_exit
diff --git a/testcases/network/stress/ssh/ssh-stress02-rmt b/testcases/network/stress/ssh/ssh-stress02-rmt
index 1984552..05f4c38 100644
--- a/testcases/network/stress/ssh/ssh-stress02-rmt
+++ b/testcases/network/stress/ssh/ssh-stress02-rmt
@@ -1,128 +1,76 @@
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
-#   ssh-stress02-rmt
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
 #
-# Description:
-#   This is the remote script for ssh-ipv${IP_VER}-stress02
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
-#   $1: version of IP
-#   $2: IP address log into
-#   $3: ssh_config file
-#   $4: quantity of connection
-#   $5: duration
+# Author: Mitsuru Chinen <mitch@jp.ibm.com>
 #
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
+
+TCID="ssh_stress02_rmt"
+TST_TOTAL=1
+
+. test.sh
 
 # Check the arguments
 if [ $# -ne 5 ]; then
-    echo "Usage: $0 IP_version server_addr config_dir connect_quantity duration"
-    exit 1
+	tst_brkm TBROK "Usage: $0 ipver rhost config connections duration"
 fi
+
 ip_ver="$1"
 server_ipaddr="$2"
 ssh_config="$3"
-connect_quontity="$4"
+connections="$4"
 duration="$5"
 
-# Unset the maximum number of processes
-ulimit -u unlimited
-
-# Specify the option of ssh accoring to the version of IP
-case $ip_ver in
-    4)
-    ver_opt="-4"
-    ;;
-    6)
-    ver_opt="-6"
-    ;;
-    *)
-    echo "$ver_opt is unknown IP version"
-    exit 1
-    ;;
-esac
+ssh -$ip_ver -F $ssh_config $server_ipaddr \
+	"true < /dev/null > /dev/null 2>&1" > /dev/null
+[ $? -ne 0 ] && tst_brkm TBROK "Failed to connect '$server_ipaddr'"
 
-# Check the connectivity first
-if [ ! -f $ssh_config ]; then
-    echo "$ssh_config is something wrong."
-    exit 1
-fi
-ssh $ver_opt -F $ssh_config $server_ipaddr "true </dev/null >/dev/null 2>&1" >/dev/null 2>&1
-if [ $? -ne 0 ]; then
-    echo "Failed to connect $server_ipaddr"
-    exit 1
-fi
-
-#
-# Mail loop
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
 
-    # Do not make ssh connection over the specified quontity
-    ssh_num=`jobs | wc -l`
-    if [ $ssh_num -ge $connect_quontity ]; then
-	sleep 1
-	continue;
-    fi
+	# Do not make ssh connection over the specified quantity
+	ssh_num=$(jobs | wc -l)
+	if [ $ssh_num -ge $connections ]; then
+		sleep 1
+		continue;
+	fi
 
-    # specified wait time and login time
-    wait_sec=`expr $RANDOM \* 3 / 32768`
-    login_sec=`expr $RANDOM \* 10 / 32768`
+	# specified wait time and login time
+	wait_sec=$(($(od -A n -d -N 1 /dev/random) * 3 / 255))
+	login_sec=$(($(od -A n -d -N 1 /dev/random) * 10 / 255))
 
-    # Login to the server
-    (sleep $wait_sec ; ssh $ver_opt -F $ssh_config -l root $server_ipaddr "sleep $login_sec </dev/null >/dev/null 2>&1") >/dev/null 2>&1  &
+	# Login to the server
+	(sleep $wait_sec ; ssh -$ip_ver -F $ssh_config -l root $server_ipaddr \
+		"sleep $login_sec < /dev/null > /dev/null 2>&1") > \
+		/dev/null 2>&1 &
 done
 
 # wait for the finish of all process
 wait
 
 # Check the connectivity again
-ssh $ver_opt -F $ssh_config $server_ipaddr "true </dev/null >/dev/null 2>&1" >/dev/null 2>&1
-if [ $? -ne 0 ]; then
-    echo "Failed to connect $server_ipaddr. ssh connectivity is lost."
-    exit 1
-fi
+ssh -$ip_ver -F $ssh_config $server_ipaddr \
+	"true < /dev/null > /dev/null 2>&1" > /dev/null
+[ $? -ne 0 ] && tst_brkm TBROK "Failed to connect '$server_ipaddr'"
 
-exit 0
+tst_exit
diff --git a/testcases/network/stress/ssh/ssh-stress03-rmt b/testcases/network/stress/ssh/ssh-stress03-rmt
index 3ec263d..9dcebe7 100644
--- a/testcases/network/stress/ssh/ssh-stress03-rmt
+++ b/testcases/network/stress/ssh/ssh-stress03-rmt
@@ -1,150 +1,77 @@
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
-## Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 03111-1307 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
+# Copyright (c) 2015 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) International Business Machines  Corp., 2005
 #
-# File:
-#   ssh-stress03-rmt
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
 #
-# Description:
-#   This is the remote script for ssh-ipv${IP_VER}-stress03
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
-#   $1: version of IP
-#   $2: IP address log into
-#   $3: ssh_config file
-#   $4: quantity of connection
-#   $5: duration
+# Author: Mitsuru Chinen <mitch@jp.ibm.com>
 #
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
+
+TCID="ssh_stress03_rmt"
+TST_TOTAL=1
+
+. test.sh
 
 # Check the arguments
-if [ $# -ne 6 ]; then
-    echo "Usage: $0 LTPROOT IP_version server_addr ssh_config remote_port duration"
-    exit 1
+if [ $# -ne 5 ]; then
+	tst_brkm TBROK "Usage: $0 ipver rhost config port duration"
 fi
-ltproot="$1"
-ip_ver="$2"
-server_ipaddr="$3"
-ssh_config="$4"
-remote_port="$5"
-duration="$6"
 
-# Check the connectivity first
-if [ ! -f $ssh_config ]; then
-    echo "$ssh_config is something wrong."
-    exit 1
-fi
-ssh $ver_opt -F $ssh_config $server_ipaddr "true </dev/null >/dev/null 2>&1" >/dev/null 2>&1
-if [ $? -ne 0 ]; then
-    echo "Failed to connect $server_ipaddr"
-    exit 1
-fi
+ip_ver="$1"
+server_ipaddr="$2"
+ssh_config="$3"
+rport="$4"
+duration="$5"
 
-# Find an available port
-stat_file=`mktemp`
-netstat -a -n -t | awk '{ print $4 }' | sed "s/^.*://" >$stat_file 2>/dev/null
-local_port=1025
-while true ; do
-    grep -l "^${local_port}$" $stat_file >/dev/null 2>&1
-    if [ $? -eq 0 ]; then
-	local_port=`expr $local_port + 1`
-	if [ $local_port -gt 65535 ]; then
-	    echo "No port is avaiable"
-	    rm -f $stat_file
-	    exit 1
-	fi
-    else
-	rm -f $stat_file
-	break
-    fi
-done
+ssh -$ip_ver -F $ssh_config $server_ipaddr \
+	"true < /dev/null > /dev/null 2>&1" > /dev/null
+[ $? -ne 0 ] && tst_brkm TBROK "Failed to connect '$server_ipaddr'"
 
-# Search the TCP traffic client
-client_not_found=true
-for clientdir in ${ltproot}/testcases/bin ${ltproot}/testcases/network/stress/bin ; do
-    client="${clientdir}/ns-tcpclient"
-    if [ -x $client ]; then
-	client_not_found=false
-	break
-    fi
-done
-if $client_not_found ; then
-    echo "TCP traffic client is not found"
-    exit 1
-fi
+lport=$(tst_get_unused_port ipv${ip_ver} stream)
 
-# Set the ssh portforwarding
+# Set the ssh port-forwarding
 case $ip_ver in
-    4)
-    localhost="127.0.0.1"
-    ssh -4 -f -N -L ${local_port}:${server_ipaddr}:${remote_port} root@${server_ipaddr} -F $ssh_config
-    ;;
-    6)
-    localhost="::1"
-    ssh -6 -f -N -L ${local_port}/[${server_ipaddr}]/${remote_port} root@${server_ipaddr} -F $ssh_config
-    ;;
-    *)
-    echo "$ver_opt is unknown IP version"
-    exit 1
-    ;;
+4)
+	localhost="127.0.0.1"
+	ssh -4 -f -N -L $lport:$server_ipaddr:$rport \
+		root@$server_ipaddr -F $ssh_config
+;;
+6)
+	localhost="::1"
+	ssh -6 -f -N -L $lport/[$server_ipaddr]/$rport \
+		root@$server_ipaddr -F $ssh_config
+;;
 esac
 
-
-
 # Start the TCP traffic client
-$client -S $localhost -p ${local_port} -f $ip_ver -t $duration
-if [ $? -ne 0 ]; then
-    echo "TCP traffic client is dead."
+ns-tcpclient -S $localhost -p $lport -f $ip_ver -t $duration
+ret=$?
 
-    # Stop the ssh port forwording
-    for ssh_pid in `ps auxw | fgrep -v grep | grep "ssh[[:blank:]].*${ssh_config}" | awk '{print $2}'` ; do
+# Stop the ssh port forwarding
+all_conn=$(ps auxw | grep -Fv grep | \
+	grep "ssh[[:blank:]].*${ssh_config}" | awk '{print $2}')
+for ssh_pid in $all_conn ; do
 	kill $ssh_pid
-    done
-    exit 1
-fi
-
-# Stop the ssh port forwording
-for ssh_pid in `ps auxw | fgrep -v grep | grep "ssh[[:blank:]].*${ssh_config}" | awk '{print $2}'` ; do
-    kill $ssh_pid
 done
 
+[ $ret -ne 0 ] && tst_brkm TBROK "TCP traffic client is dead"
+
 # Check the connectivity again
-ssh $ver_opt -F $ssh_config $server_ipaddr "true </dev/null >/dev/null 2>&1" >/dev/null 2>&1
-if [ $? -ne 0 ]; then
-    echo "Failed to connect $server_ipaddr. ssh connectivity is lost."
-    exit 1
-fi
+ssh -$ip_ver -F $ssh_config $server_ipaddr \
+	"true < /dev/null > /dev/null 2>&1" > /dev/null
+[ $? -ne 0 ] && tst_brkm TBROK "Failed to connect '$server_ipaddr'"
 
-exit 0
+tst_exit
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

