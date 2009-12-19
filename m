Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1NLotE-0004XK-GL
	for ltp-list@lists.sourceforge.net; Sat, 19 Dec 2009 02:17:52 +0000
Received: from fmmailgate02.web.de ([217.72.192.227])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NLot7-00041f-Qj
	for ltp-list@lists.sourceforge.net; Sat, 19 Dec 2009 02:17:52 +0000
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate02.web.de (Postfix) with ESMTP id 6035C1496FF17
	for <ltp-list@lists.sourceforge.net>;
	Sat, 19 Dec 2009 03:17:40 +0100 (CET)
Received: from [90.180.172.144] (helo=debian)
	by smtp08.web.de with asmtp (WEB.DE 4.110 #314) id 1NLot2-0006WE-00
	for ltp-list@lists.sourceforge.net; Sat, 19 Dec 2009 03:17:40 +0100
Date: Sat, 19 Dec 2009 03:16:05 +0100
From: "Jiri Palecek" <jpalecek@web.de>
MIME-Version: 1.0
Resent-To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>
Resent-Message-ID: <op.u45x0uc4cfnueu@debian>
Subject: [LTP] [PATCH] Fixes of the sendfile01 test
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: ltp-list-bounces@lists.sourceforge.net
Errors-To: ltp-list-bounces@lists.sourceforge.net
Cc: ltp-list@lists.sourceforge.net
Message-ID: <20091219021605.YHYtDZZHPDiABWudzPdqOk9VganSNpt1NsOEMLN9nK0@z>

Hello,

I've found some problems with the sendfile01 testcase (the one under network/tcp_cmds). This patch fixes them:

 Pass the -6 parameter to gethost if we are to use ipv6 and run the
 ipv6 server in that case. Also, fix the awk code for getting the PID:
 The PID is the second column, which is $2, not $1.

Also:

 - initialize addrlen for accept syscall in the server (=> avoid EINVAL)

 - use tst_resm in the client instead of tst_res, to avoid an error message interpreted as a filename

Regards
    Jiri Palecek

Signed-off-by: Jiri Palecek <jpalecek@web.de>
---
 testcases/network/tcp_cmds/sendfile/SF_Server  |    2 +-
 testcases/network/tcp_cmds/sendfile/sendfile01 |   10 +++++-----
 testcases/network/tcp_cmds/sendfile/testsf_c.c |    2 +-
 testcases/network/tcp_cmds/sendfile/testsf_s.c |    2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/testcases/network/tcp_cmds/sendfile/SF_Server b/testcases/network/tcp_cmds/sendfile/SF_Server
index 2383ce4..9933db4 100755
--- a/testcases/network/tcp_cmds/sendfile/SF_Server
+++ b/testcases/network/tcp_cmds/sendfile/SF_Server
@@ -3,4 +3,4 @@
 cd $3
 exec 1< /dev/null       # open descriptor 1
 exec 2< /dev/null       # open descriptor 1
-nohup ./testsf_s $1 $2 &
+nohup ./$4 $1 $2 &
diff --git a/testcases/network/tcp_cmds/sendfile/sendfile01 b/testcases/network/tcp_cmds/sendfile/sendfile01
index 4e93447..7dd4fee 100755
--- a/testcases/network/tcp_cmds/sendfile/sendfile01
+++ b/testcases/network/tcp_cmds/sendfile/sendfile01
@@ -61,7 +61,7 @@ do_setup()
 
     exists awk diff gethost grep rsh stat
 
-    IPADDR=$(gethost $RHOST | awk '/addresses:/ {print $2}')
+    IPADDR=$(gethost ${EXEC_SUFFIX:+-6} $RHOST | awk '/addresses:/ {print $2}')
 
 }
 
@@ -81,17 +81,17 @@ do_test()
   
     mkdir -p $TCtmp
     PORT=$$ 
-    if ! rsh -l root $IPADDR "$LTPROOT/testcases/bin/SF_Server $IPADDR $PORT $LTPROOT/testcases/bin"; then
+    if ! rsh -l root $IPADDR "$LTPROOT/testcases/bin/SF_Server $IPADDR $PORT $LTPROOT/testcases/bin $SERVER"; then
         end_testcase "rsh failed to $IPADDR as root failed"
     fi
     sleep 10
-    PID=$(rsh -l root $IPADDR "ps -ef" | awk "\$0 !~ /awk/ && /$SERVER/ && /$PORT/ {print \$1}")
+    PID=$(rsh -l root $IPADDR "ps -ef" | awk "\$0 !~ /awk/ && /$SERVER/ && /$PORT/ {print \$2}")
     [ -n "$PID" ] || end_testcase "Could not start server"
 
     for clnt_fname in $FILES; do
         serv_fname=$TCdat/$clnt_fname
         SIZE=`stat -c '%s' $serv_fname`
-        tst_resm TINFO "Starting $SERVER $IPADDR Client_filename Server_filename Size "
+        tst_resm TINFO "Starting $CLIENT $IPADDR Client_filename Server_filename Size "
   
         $CLIENT $IPADDR $PORT "$TCtmp/$clnt_fname" $serv_fname $SIZE 
         RetVal=$?
@@ -118,7 +118,7 @@ do_test()
 
 do_cleanup()
 {
-      PID=$(rsh -n -l root $RHOST "ps -ef" | awk "\$0 !~ /awk/ && /$SERVER/ && /$PORT/ {print \$1}")
+      PID=$(rsh -n -l root $RHOST "ps -ef" | awk "\$0 !~ /awk/ && /$SERVER/ && /$PORT/ {print \$2}")
       [ -n "$PID" ] && rsh -n -l root $RHOST kill -9 $PID
       tst_cleanup
 }
diff --git a/testcases/network/tcp_cmds/sendfile/testsf_c.c b/testcases/network/tcp_cmds/sendfile/testsf_c.c
index 52b9ecf..7683927 100644
--- a/testcases/network/tcp_cmds/sendfile/testsf_c.c
+++ b/testcases/network/tcp_cmds/sendfile/testsf_c.c
@@ -120,7 +120,7 @@ main (int argc, char *argv[])
 		}
 	}
 
-	tst_res(TINFO, "Asking for remote file: %s", serv_fname);
+	tst_resm(TINFO, "Asking for remote file: %s", serv_fname);
 
 	tst_resm(TINFO, "File %s received\n", argv[4]);
 
diff --git a/testcases/network/tcp_cmds/sendfile/testsf_s.c b/testcases/network/tcp_cmds/sendfile/testsf_s.c
index bc77712..38baf8c 100644
--- a/testcases/network/tcp_cmds/sendfile/testsf_s.c
+++ b/testcases/network/tcp_cmds/sendfile/testsf_s.c
@@ -92,7 +92,7 @@ main(int argc, char *argv[])
 		tst_exit();
 	}
 
-	socklen_t fromlen;
+	socklen_t fromlen = sizeof(from);
 
 	/* process connections */
 	while (1) {
-- 
1.6.4.3



------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
