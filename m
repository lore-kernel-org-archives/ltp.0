Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <liuhangbin@gmail.com>) id 1UrO0f-0006Oo-Cz
	for ltp-list@lists.sourceforge.net; Tue, 25 Jun 2013 07:49:53 +0000
Received: from mail-pa0-f42.google.com ([209.85.220.42])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UrO0c-0004LZ-Of
	for ltp-list@lists.sourceforge.net; Tue, 25 Jun 2013 07:49:52 +0000
Received: by mail-pa0-f42.google.com with SMTP id rl6so12277530pac.15
	for <ltp-list@lists.sourceforge.net>;
	Tue, 25 Jun 2013 00:49:44 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
Date: Tue, 25 Jun 2013 15:49:36 +0800
Message-Id: <1372146576-3533-1-git-send-email-liuhangbin@gmail.com>
Subject: [LTP] [PATCH] networking/stress/udp: make sure we will kill the
	test case after timeout
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
To: LTP list <ltp-list@lists.sourceforge.net>

The same as tcp, put the connecting setup while loop into whatchdog while
loop and make sure we can kill all the connections immediately after timeout.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 .../stress/udp/multi-diffip/udp4-multi-diffip01    | 64 +++++++++++-----------
 .../stress/udp/multi-diffnic/udp4-multi-diffnic01  | 26 ++++-----
 .../udp/multi-diffport/udp4-multi-diffport01       | 50 ++++++++---------
 3 files changed, 70 insertions(+), 70 deletions(-)

diff --git a/testcases/network/stress/udp/multi-diffip/udp4-multi-diffip01 b/testcases/network/stress/udp/multi-diffip/udp4-multi-diffip01
index 33d2265..2c7f6af 100644
--- a/testcases/network/stress/udp/multi-diffip/udp4-multi-diffip01
+++ b/testcases/network/stress/udp/multi-diffip/udp4-multi-diffip01
@@ -356,43 +356,43 @@ done
 server_pid=`grep PID: $info_file | cut -f 2 -d ' '`
 rm -f $info_file
 
-# Make connections
 connection_num=0
-while [ $connection_num -lt $ipaddr_pair_num ]; do
-    # IP addresses
-    x=`expr $connection_num \/ 255 % 255`
-    y=`expr $connection_num % 255`
-
-    case $IP_VER in
-	4)
-	lhost_addr="10.${x}.${y}.2"
-	;;
-
-	6)
-	hex_x=`printf %x $x`
-	hex_y=`printf %x $y`
-	lhost_addr="fd00:1:${hex_x}:${hex_y}::2"
-	;;
-    esac
-
-    # Run a client
-    ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/ns-udpclient -b -f $IP_VER -S $lhost_addr -p $server_port' ; echo $?'`
-    if [ $ret -ne 0 ]; then
-	if [ $connection_num -eq 0 ]; then
-	    tst_resm TFAIL "Failed to run any client"
-	    exit 1
-	else
-	    tst_resm TINFO "$connection_num seems the maximum number of the client"
-	fi
-	break
-    fi
-    connection_num=`expr $connection_num + 1`
-done
-
 
 # Watch the UDP traffic server
 start_epoc=`date +%s`
 while true ; do
+	# Make connections
+	if [ $connection_num -lt $ipaddr_pair_num ]; then
+		# IP addresses
+		x=`expr $connection_num \/ 255 % 255`
+		y=`expr $connection_num % 255`
+
+		case $IP_VER in
+			4)
+				lhost_addr="10.${x}.${y}.2"
+				;;
+
+			6)
+				hex_x=`printf %x $x`
+				hex_y=`printf %x $y`
+				lhost_addr="fd00:1:${hex_x}:${hex_y}::2"
+				;;
+		esac
+
+		# Run a client
+		ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/ns-udpclient -b -f $IP_VER -S $lhost_addr -p $server_port' ; echo $?'`
+		if [ $ret -ne 0 ]; then
+			if [ $connection_num -eq 0 ]; then
+				tst_resm TFAIL "Failed to run any client"
+				exit 1
+			else
+				tst_resm TINFO "$connection_num seems the maximum number of the client"
+			fi
+			break
+		fi
+		connection_num=`expr $connection_num + 1`
+	fi
+
     current_epoc=`date +%s`
     elapse_epoc=`expr $current_epoc - $start_epoc`
 
diff --git a/testcases/network/stress/udp/multi-diffnic/udp4-multi-diffnic01 b/testcases/network/stress/udp/multi-diffnic/udp4-multi-diffnic01
index 20ff259..d25ce3e 100644
--- a/testcases/network/stress/udp/multi-diffnic/udp4-multi-diffnic01
+++ b/testcases/network/stress/udp/multi-diffnic/udp4-multi-diffnic01
@@ -308,23 +308,23 @@ rm -f $info_file
 
 # Main loop
 connection_num=0
-while [ $connection_num -lt $link_total ]; do
-    field=`expr $connection_num + 1`
-    lhost_addr=`echo $lhost_addrs | cut -d ' ' -f $field`
-
-    # Run a client
-    ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/ns-udpclient -b -f $IP_VER -S $lhost_addr -p $server_port' ; echo $?'`
-    if [ $ret -ne 0 ]; then
-	tst_resm TFAIL "Failed to run client on Link${connection_num}"
-	exit 1
-    fi
-    connection_num=`expr $connection_num + 1`
-done
-
 
 # Watch the UDP traffic server
 start_epoc=`date +%s`
 while true ; do
+	if [ $connection_num -lt $link_total ]; then
+		field=`expr $connection_num + 1`
+		lhost_addr=`echo $lhost_addrs | cut -d ' ' -f $field`
+
+		# Run a client
+		ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/ns-udpclient -b -f $IP_VER -S $lhost_addr -p $server_port' ; echo $?'`
+		if [ $ret -ne 0 ]; then
+			tst_resm TFAIL "Failed to run client on Link${connection_num}"
+			exit 1
+		fi
+		connection_num=`expr $connection_num + 1`
+	fi
+
     current_epoc=`date +%s`
     elapse_epoc=`expr $current_epoc - $start_epoc`
 
diff --git a/testcases/network/stress/udp/multi-diffport/udp4-multi-diffport01 b/testcases/network/stress/udp/multi-diffport/udp4-multi-diffport01
index d130ff9..e3efb2e 100644
--- a/testcases/network/stress/udp/multi-diffport/udp4-multi-diffport01
+++ b/testcases/network/stress/udp/multi-diffport/udp4-multi-diffport01
@@ -291,35 +291,35 @@ end_port=`echo $portbundle | cut -f 2 -d '-'`
 # Run the pair of server and client
 connection_num=0
 current_port=$start_port
-while [ $current_port -le $end_port ]; do
-    # Run a UDP traffic server
-    ns-udpserver -b -f $IP_VER -p $current_port
-    if [ $? -ne 0 ]; then
-	if [ $connection_num -eq 0 ]; then
-	    tst_resm TFAIL "Failed to run a server"
-	    exit 1
-	fi
-	tst_resm TINFO "$connection_num seems the maximum number of the client"
-	break
-    fi
-
-    ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/ns-udpclient -b -f $IP_VER -S $lhost_addr -p $current_port'; echo $?'`
-    if [ $ret -ne 0 ]; then
-	if [ $connection_num -eq 0 ]; then
-	    tst_resm TFAIL "Failed to run a client"
-	    exit 1
-	fi
-	tst_resm TINFO "$connection_num seems the maximum number of the client"
-	break
-    fi
-    current_port=`expr $current_port + 1`
-    connection_num=`expr $connection_num + 1`
-done
-
 
 # Watch the UDP traffic server
 start_epoc=`date +%s`
 while true ; do
+	if [ $current_port -le $end_port ]; then
+		# Run a UDP traffic server
+		ns-udpserver -b -f $IP_VER -p $current_port
+		if [ $? -ne 0 ]; then
+			if [ $connection_num -eq 0 ]; then
+				tst_resm TFAIL "Failed to run a server"
+				exit 1
+			fi
+			tst_resm TINFO "$connection_num seems the maximum number of the client"
+			break
+		fi
+
+		ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/ns-udpclient -b -f $IP_VER -S $lhost_addr -p $current_port'; echo $?'`
+		if [ $ret -ne 0 ]; then
+			if [ $connection_num -eq 0 ]; then
+				tst_resm TFAIL "Failed to run a client"
+				exit 1
+			fi
+			tst_resm TINFO "$connection_num seems the maximum number of the client"
+			break
+		fi
+		current_port=`expr $current_port + 1`
+		connection_num=`expr $connection_num + 1`
+	fi
+
     current_epoc=`date +%s`
     elapse_epoc=`expr $current_epoc - $start_epoc`
     if [ $elapse_epoc -ge $NS_DURATION ]; then
-- 
1.8.1.4


------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
