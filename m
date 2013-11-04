Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xu.simon@oracle.com>) id 1VdGah-0002eB-2F
	for ltp-list@lists.sourceforge.net; Mon, 04 Nov 2013 09:36:59 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VdGaf-0005lw-0y
	for ltp-list@lists.sourceforge.net; Mon, 04 Nov 2013 09:36:59 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id rA49aoVn018468
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 4 Nov 2013 09:36:51 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rA49aopu028947
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Mon, 4 Nov 2013 09:36:50 GMT
Received: from abhmt106.oracle.com (abhmt106.oracle.com [141.146.116.58])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rA49aoeO028944
	for <ltp-list@lists.sourceforge.net>; Mon, 4 Nov 2013 09:36:50 GMT
From: Simon Xu <xu.simon@oracle.com>
Date: Mon,  4 Nov 2013 17:36:41 +0800
Message-Id: <1383557801-1603-1-git-send-email-xu.simon@oracle.com>
Subject: [LTP] [PATCH] tcpdump01: fix the way to identify network interface
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

The script tries to identify network interface that can communicate with RHOST
by searching for the IP of RHOST in ifconfig output on localhost, which doesn't
make any sense when RHOST is not localhost.  This patch changes the script to
indetify the network interface by ping RHOST.

Signed-off-by: Simon Xu <xu.simon@oracle.com>
---
 testcases/network/tcp_cmds/tcpdump/tcpdump01 | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/testcases/network/tcp_cmds/tcpdump/tcpdump01 b/testcases/network/tcp_cmds/tcpdump/tcpdump01
index 4866720..6d6d399 100755
--- a/testcases/network/tcp_cmds/tcpdump/tcpdump01
+++ b/testcases/network/tcp_cmds/tcpdump/tcpdump01
@@ -48,22 +48,12 @@ do_setup()
 
     exists awk grep host hostname ifconfig netstat ping tail tcpdump
     RHOST=${RHOST:-`hostname`}
-    IP=`host ${RHOST} 2>/dev/null | awk '{print $4}'`
-    IFNUMS=`netstat -i|wc -l`
-    IFNUMS=$(( $IFNUMS - 2 ))
-    IFNAME=${IFNAME:-$(netstat -i | awk '{print $1}' | tail -n ${IFNUMS})}
-
-    for i in ${IFNAME}; do
-        if ifconfig ${i} | grep $IP; then
-            IF=$i
-            break
-        fi
+    # Find the first interface that can ping RHOST
+    IF=""
+    for i in $(netstat -i | tail -n+3 | sed '/^lo/d' | cut -f1 -d' '); do
+        ping -I $i -c 3 $RHOST && { IF="$i"; break; }
     done
-    # Default to empty string if unset, to avoid errors caused by set -u, which we use (see cmdlib.sh)
-    if [ -z "${IF:-}" ]; then
-        end_testcase "Could not identify interface"
-        exit 1
-    fi
+    test -z $IF && end_testcase "Could not find an interface that can ping remote host $RHOST"
     IFNAME=${IF}
     NUMLOOPS=${NUMLOOPS:-20}
     OUTFILE=$TCtmp/tcpdump_out
-- 
1.8.4.2


------------------------------------------------------------------------------
Android is increasing in popularity, but the open development platform that
developers love is also attractive to malware creators. Download this white
paper to learn more about secure code signing practices that can help keep
Android apps secure.
http://pubads.g.doubleclick.net/gampad/clk?id=65839951&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
