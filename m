Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <liuhangbin@gmail.com>) id 1Uuwz5-0000u6-Lp
	for ltp-list@lists.sourceforge.net; Fri, 05 Jul 2013 03:46:59 +0000
Received: from mail-pb0-f54.google.com ([209.85.160.54])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Uuwz3-0007AQ-Pp
	for ltp-list@lists.sourceforge.net; Fri, 05 Jul 2013 03:46:59 +0000
Received: by mail-pb0-f54.google.com with SMTP id ro2so1737168pbb.41
	for <ltp-list@lists.sourceforge.net>;
	Thu, 04 Jul 2013 20:46:51 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
Date: Fri,  5 Jul 2013 11:46:35 +0800
Message-Id: <1372995995-8270-1-git-send-email-liuhangbin@gmail.com>
Subject: [LTP] [Patch v2] networking/stress: make sure we will kill the test
	case after timeout
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

In some old machines or guests, the system may not have the ability to set up
all the connections, e.g. 4000 tcp connections, quickly. Then the system will
take lots of time to try setup the connections or just huang there.

I think we should just kill all the connections after testing timeout, no
matter how many connections we have setup.

So mv the connecting setup while loop into whatchdog while loop. If we check
timeout every connection, it will spend too much time on sleep 1. So we only
check timeout every 100 connections.

Also, I will only modify tcp/udp4-multi-diffport01, tcp4-multi-sameport01. For
other tests like tcp4-multi-diffip01 or diffnic, these tests only setup total
ip/nic connections, which will be only 1 or 2 normally.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 .../tcp/multi-diffport/tcp4-multi-diffport01       | 67 ++++++++++++----------
 .../tcp/multi-sameport/tcp4-multi-sameport01       | 36 +++++++-----
 .../udp/multi-diffport/udp4-multi-diffport01       | 55 ++++++++++--------
 3 files changed, 87 insertions(+), 71 deletions(-)

diff --git a/testcases/network/stress/tcp/multi-diffport/tcp4-multi-diffport01 b/testcases/network/stress/tcp/multi-diffport/tcp4-multi-diffport01
index e260d35..a77fc8c 100644
--- a/testcases/network/stress/tcp/multi-diffport/tcp4-multi-diffport01
+++ b/testcases/network/stress/tcp/multi-diffport/tcp4-multi-diffport01
@@ -323,41 +323,46 @@ end_port=`echo $portbundle | cut -f 2 -d '-'`
 # Making connections
 connection_num=0
 current_port=$start_port
-while [ $current_port -le $end_port ]; do
-    # Run a server
-    ns-tcpserver -b -f $IP_VER -p $current_port
-    if [ $? -ne 0 ]; then
-	# Failed to start no server
-	if [ $connection_num -eq 0 ]; then
-	    tst_resm TFAIL "Failed to run a server"
-	    exit 1
-	fi
-	# Failed to start a server
-	tst_resm TINFO "$connection_num seems the maximum number of the server"
-	break
-    fi
-
-    # Run a clinet
-    ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/ns-tcpclient -b -f $IP_VER -S $lhost_addr -p $current_port' ; echo $?'`
-    if [ $ret -ne 0 ]; then
-	# Failed to start any client
-	if [ $connection_num -eq 0 ]; then
-	    tst_resm TFAIL "Failed to run any client."
-	    exit 1
-	fi
-	# Failed to start a client
-	tst_resm TINFO "$connection_num seems the maximum number of the client"
-	break
-    fi
-
-    current_port=`expr $current_port + 1`
-    connection_num=`expr $connection_num + 1`
-done
-
 
 # Watch the TCP traffic server
 start_epoc=`date +%s`
 while true ; do
+	while [ $current_port -le $end_port ]; do
+		# Run a server
+		ns-tcpserver -b -f $IP_VER -p $current_port
+		if [ $? -ne 0 ]; then
+			# Failed to start no server
+			if [ $connection_num -eq 0 ]; then
+				tst_resm TFAIL "Failed to run a server"
+				exit 1
+			fi
+			# Failed to start a server
+			tst_resm TINFO "$connection_num seems the maximum number of the server"
+			break
+		fi
+
+		# Run a clinet
+		ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/ns-tcpclient -b -f $IP_VER -S $lhost_addr -p $current_port' ; echo $?'`
+		if [ $ret -ne 0 ]; then
+			# Failed to start any client
+			if [ $connection_num -eq 0 ]; then
+				tst_resm TFAIL "Failed to run any client."
+				exit 1
+			fi
+			# Failed to start a client
+			tst_resm TINFO "$connection_num seems the maximum number of the client"
+			break
+		fi
+
+		current_port=`expr $current_port + 1`
+		connection_num=`expr $connection_num + 1`
+
+		# check timeout every 100 times
+		if [ $(($connection_num % 100)) -eq 0 ]; then
+			break
+		fi
+	done
+
     current_epoc=`date +%s`
     elapse_epoc=`expr $current_epoc - $start_epoc`
     if [ $elapse_epoc -ge $NS_DURATION ]; then
diff --git a/testcases/network/stress/tcp/multi-sameport/tcp4-multi-sameport01 b/testcases/network/stress/tcp/multi-sameport/tcp4-multi-sameport01
index aff2481..b8a5204 100644
--- a/testcases/network/stress/tcp/multi-sameport/tcp4-multi-sameport01
+++ b/testcases/network/stress/tcp/multi-sameport/tcp4-multi-sameport01
@@ -336,25 +336,31 @@ rm -f $info_file
 
 # Making connections
 connection_num=0
-while [ $connection_num -lt $CONNECTION_TOTAL ]; do
-    # Run a client
-    ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/ns-tcpclient -b -f $IP_VER -S $lhost_addr -p $server_port' ; echo $?'`
-    if [ $ret -ne 0 ]; then
-	# Failed to start any client
-	if [ $connection_num -eq 0 ]; then
-	    tst_resm TFAIL "Failed to run any client"
-	    exit 1
-	fi
-	# Failed to start a client
-	tst_resm TINFO "$connection_num seems the maximum number of the client"
-	break
-    fi
-    connection_num=`expr $connection_num + 1`
-done
 
 # Watch the TCP traffic server
 start_epoc=`date +%s`
 while true ; do
+	while [ $connection_num -lt $CONNECTION_TOTAL ]; do
+		# Run a client
+		ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/ns-tcpclient -b -f $IP_VER -S $lhost_addr -p $server_port' ; echo $?'`
+		if [ $ret -ne 0 ]; then
+			# Failed to start any client
+			if [ $connection_num -eq 0 ]; then
+				tst_resm TFAIL "Failed to run any client"
+				exit 1
+			fi
+			# Failed to start a client
+			tst_resm TINFO "$connection_num seems the maximum number of the client"
+			break
+		fi
+		connection_num=`expr $connection_num + 1`
+
+		# check timeout every 100 times
+		if [ $(($connection_num % 100)) -eq 0 ]; then
+			break
+		fi
+	done
+
     current_epoc=`date +%s`
     elapse_epoc=`expr $current_epoc - $start_epoc`
 
diff --git a/testcases/network/stress/udp/multi-diffport/udp4-multi-diffport01 b/testcases/network/stress/udp/multi-diffport/udp4-multi-diffport01
index d130ff9..7df2b3d 100644
--- a/testcases/network/stress/udp/multi-diffport/udp4-multi-diffport01
+++ b/testcases/network/stress/udp/multi-diffport/udp4-multi-diffport01
@@ -291,35 +291,40 @@ end_port=`echo $portbundle | cut -f 2 -d '-'`
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
+	while [ $current_port -le $end_port ]; do
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
+
+		# check timeout every 100 times
+		if [ $(($connection_num % 100)) -eq 0 ]; then
+			break
+		fi
+	done
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
