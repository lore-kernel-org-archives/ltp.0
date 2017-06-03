From: Petr Vorel <pvorel@suse.cz>
Date: Sat,  3 Jun 2017 14:00:16 +0200
Subject: [LTP] [RFC PATCH v6 05/11] network/stress: Remove bg_tcp_traffic
	script
In-Reply-To: <20170603120022.13415-1-pvorel@suse.cz>
References: <20170603120022.13415-1-pvorel@suse.cz>
Message-ID: <20170603120022.13415-6-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Script has been unused since:
commit 5fe27d6a193d12e265509d04f1d7fab980ba5fae
Author: Alexey Kodanev <alexey.kodanev@oracle.com>
Date:   Sun Feb 1 13:10:36 2015 +0300

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../network/stress/ns-tools/00_Descriptions.txt    |   3 -
 testcases/network/stress/ns-tools/Makefile         |   8 +-
 testcases/network/stress/ns-tools/bg_tcp_traffic   | 275 ---------------------
 3 files changed, 4 insertions(+), 282 deletions(-)
 delete mode 100644 testcases/network/stress/ns-tools/bg_tcp_traffic

diff --git a/testcases/network/stress/ns-tools/00_Descriptions.txt b/testcases/network/stress/ns-tools/00_Descriptions.txt
index 85f69ad59..ab9c3ce8e 100644
--- a/testcases/network/stress/ns-tools/00_Descriptions.txt
+++ b/testcases/network/stress/ns-tools/00_Descriptions.txt
@@ -37,9 +37,6 @@ create_file
 find_portbundle
 	Find a bundle of consecutive ports
 
-bg_tcp_traffic
-	Control the background TCP traffic
-
 killall_icmp_traffic
 	Kill all of the icmp traffic utilities (ping or ping6)
 
diff --git a/testcases/network/stress/ns-tools/Makefile b/testcases/network/stress/ns-tools/Makefile
index df9ba42e3..61f85634a 100644
--- a/testcases/network/stress/ns-tools/Makefile
+++ b/testcases/network/stress/ns-tools/Makefile
@@ -25,11 +25,11 @@ top_srcdir		?= ../../../..
 include $(top_srcdir)/include/mk/env_pre.mk
 
 INSTALL_TARGETS		:= check_envval get_ifname initialize_if set_ipv4addr \
-		   	   add_ipv6addr check_icmpv4_connectivity \
+			   add_ipv6addr check_icmpv4_connectivity \
 			   check_icmpv6_connectivity check_netem check_setkey \
-			   create_file find_portbundle bg_tcp_traffic \
-			   killall_icmp_traffic killall_tcp_traffic \
-			   killall_udp_traffic output_ipsec_conf ns-echoclient
+			   create_file find_portbundle killall_icmp_traffic \
+			   killall_tcp_traffic killall_udp_traffic output_ipsec_conf \
+			   ns-echoclient
 
 FILTER_OUT_MAKE_TARGETS	:= ns-common
 
diff --git a/testcases/network/stress/ns-tools/bg_tcp_traffic b/testcases/network/stress/ns-tools/bg_tcp_traffic
deleted file mode 100644
index 630378c9d..000000000
--- a/testcases/network/stress/ns-tools/bg_tcp_traffic
+++ /dev/null
@@ -1,275 +0,0 @@
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
-#   bg_tcp_traffic
-#
-# Description:
-#   Control the background TCP traffic
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# Arguments:
-#   $1: command (make/check/kill/killall)
-#   $2: IP address when the command is make
-#       Process ID when the command is check or kill
-#
-# Outputs:
-#   Process ID of the TCP traffic server when the command is make
-#
-# Exit Value:
-#    0: Exit normally
-#   >0: Exit abnormally
-#
-# History:
-#   Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-#Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-# Make sure the value of LTPROOT
-LTPROOT=${LTPROOT:-`(cd ../../../../ ; pwd)`}
-export LTPROOT
-
-# Check the environmanet variable for the test
-. check_envval || exit 1
-
-# Timeout till client starts up [sec]
-CLIENT_TIMEOUT=10
-
-
-#-----------------------------------------------------------------------
-#
-# Function: usage
-#
-# Description:
-#   Print the usage of this script, then exit
-#
-#-----------------------------------------------------------------------
-usage(){
-    cat << EOD >&2
-bg_tcp_traffic command [argument]
-  command:  make / check / kill / killall
-  argument: IP address of the server (if command is make)
-            Process ID (if command is check/kill)
-            (none)  (if command is killall)
-EOD
-
-    exit 1
-}
-
-
-#-----------------------------------------------------------------------
-#
-# Function: make_traffic
-#
-# Description:
-#   Make a background tcp traffic.
-#   The local host will be a server, and the remote host will be a client
-#
-# Arguments:
-#   $1: IP address of the server
-#
-# Exit Value:
-#   0: Success
-#   1: Fail
-#
-#-----------------------------------------------------------------------
-make_traffic() {
-    server_ipaddr=$1
-
-    # Identify the family is ipv4 or ipv6
-    family=0
-    echo $server_ipaddr | fgrep "." >/dev/null 2>&1
-    if [ $? -eq 0 ]; then
-	family=4
-    else
-	echo $server_ipaddr | fgrep ":" >/dev/null 2>&1
-	if [ $? -eq 0 ]; then
-	    family=6
-	fi
-    fi
-
-    if [ $family -eq 0 ]; then
-	echo "The IP address of the server is something wrong." >&2
-	exit 1
-    fi
-
-    # Find the available consecutive ports
-    server_port=`find_portbundle tcp 1025 1`
-    if [ $? -ne 0 ]; then
-	echo "No port is available." >&2
-	exit 1
-    fi
-
-    # Start up a server
-    infofile=`mktemp -p $TMPDIR`
-    ns-tcpserver -b -f $family -p ${server_port} -o $infofile
-
-    while true ; do	# Wait till ns-tcpserver outputs the information
-	if [ -s $infofile ]; then
-	    break
-	fi
-    done
-
-    server_pid=`fgrep PID: $infofile | awk '{ print $2 }'`
-
-    rm -f $infofile
-
-    if [ x$server_pid = x ]; then
-	echo "TCP traffic server does not run" >&2
-	exit 1
-    fi
-
-    # Start up a client
-    $LTP_RSH $RHOST "${LTPROOT}/testcases/bin/ns-tcpclient -b -S $server_ipaddr -f $family -p $server_port"
-
-    count=0
-    while true ; do
-	$LTP_RSH $RHOST "ps auxw | fgrep -v grep | fgrep -l ns-tcpclient >/dev/null 2>&1"
-	if [ $? -ne 0 ]; then
-	    if [ $count -lt $CLIENT_TIMEOUT ]; then
-		count=`expr $count + 1`
-		sleep 1
-		continue
-	    else
-		echo "TCP traffic client does not run" >&2
-		kill -SIGHUP $server_pid
-		exit 1
-	    fi
-	else
-	    # Output the process ID of the server, the finished
-	    echo $server_pid
-	    exit 0
-	fi
-    done
-}
-
-
-#-----------------------------------------------------------------------
-#
-# Function: check_traffic
-#
-# Description:
-#   Check the TCP traffic exists
-#
-# Arguments:
-#   $1: Process ID of the TCP traffic server
-#
-# Exit Value:
-#   0: The connectivity is good.
-#   1: The connectivity is something wrong.
-#
-#-----------------------------------------------------------------------
-check_traffic()
-{
-    server_pid=$1
-
-    if [ ! -d /proc/$server_pid ]; then
-	echo "TCP traffic server has gone." >&2
-	exit 1
-    fi
-    exit 0
-}
-
-
-#-----------------------------------------------------------------------
-#
-# Function: kill_traffic
-#
-# Description:
-#   Kill the TCP traffic
-#
-# Arguments:
-#   $1: Process ID of the TCP traffic server
-#
-# Exit Value:
-#   Always 0
-#
-#-----------------------------------------------------------------------
-kill_traffic()
-{
-    server_pid=$1
-
-    kill -SIGHUP $server_pid >/dev/null 2>&1
-    exit 0
-}
-
-
-#-----------------------------------------------------------------------
-#
-# Function: killall_traffic
-#
-# Description:
-#   Kill all of the TCP traffic
-#
-# Exit Value:
-#   Always 0
-#
-#-----------------------------------------------------------------------
-killall_traffic()
-{
-    killall_tcp_traffic
-}
-
-#
-# Main
-#
-command=$1
-
-case $command in
-    make)
-    if [ $# -ne 2 ]; then
-	usage
-    fi
-    make_traffic $2
-    ;;
-
-    check)
-    if [ $# -ne 2 ]; then
-	usage
-    fi
-    check_traffic $2
-    ;;
-
-    kill)
-    if [ $# -ne 2 ]; then
-	usage
-    fi
-    kill_traffic $2
-    ;;
-
-    killall)
-    if [ $# -ne 1 ]; then
-	usage
-    fi
-    killall_traffic $2
-    ;;
-
-    *)
-    usage
-    ;;
-esac
-- 
2.12.2

