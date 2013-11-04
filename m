Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xu.simon@oracle.com>) id 1VdGj5-00032k-81
	for ltp-list@lists.sourceforge.net; Mon, 04 Nov 2013 09:45:39 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VdGj4-0006Da-Ar
	for ltp-list@lists.sourceforge.net; Mon, 04 Nov 2013 09:45:39 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by userp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id rA49jVtm022176
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 4 Nov 2013 09:45:32 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rA49jUql020380
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Mon, 4 Nov 2013 09:45:31 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rA49jUej022396
	for <ltp-list@lists.sourceforge.net>; Mon, 4 Nov 2013 09:45:30 GMT
From: Simon Xu <xu.simon@oracle.com>
Date: Mon,  4 Nov 2013 17:45:21 +0800
Message-Id: <1383558321-1703-1-git-send-email-xu.simon@oracle.com>
Subject: [LTP] [PATCH] rdist01: fix mistakes
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

Fix the following mistakes in the script:
1) the way it gets dirname and basename of files is broken
2) ${FILES} and ${HOSTS} get substituted when generating distfile
3) the way it calculates sum of files on RHOST is broken
4) there is no $DIRECTORIES variable

Signed-off-by: Simon Xu <xu.simon@oracle.com>
---
 testcases/network/tcp_cmds/rdist/rdist01 | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/testcases/network/tcp_cmds/rdist/rdist01 b/testcases/network/tcp_cmds/rdist/rdist01
index 9e30492..27d6270 100755
--- a/testcases/network/tcp_cmds/rdist/rdist01
+++ b/testcases/network/tcp_cmds/rdist/rdist01
@@ -63,8 +63,8 @@ do_setup()
     done
 
     for i in $FILES; do
-        BASE=${i##*/}
-        DIR=${%%/*}
+        BASE=$(basename "$i")
+        DIR=$(dirname "$i")
         test -d "$DIR" || mkdir -p "$DIR"
         if [ $? -ne 0 ] ; then
             end_testcase "failed to create $DIR"
@@ -94,7 +94,7 @@ create_distfile()
 {
     T_FILES="FILES = ( "
     for i in $FILES; do
-        if [ "${i%%*/}" = "." ]; then
+        if [ $(dirname "$i") == "." ]; then
             T_FILES="$T_FILES $i"
         else
             T_FILES="$T_FILES $DIR"
@@ -105,7 +105,7 @@ create_distfile()
     T_HOST="HOSTS = ("
     for c_ruser in $RUSERS; do
         for c_rhost in $HOSTS; do
-         T_HOST=$T_HOST"$c_ruser@$c_rhost "
+         T_HOST=$T_HOST" $c_ruser@$c_rhost"
         done
     done
 
@@ -113,7 +113,7 @@ create_distfile()
     cat <<EOF > "$TCtmp/distfile"
 $T_HOST
 $T_FILES
-${FILES} -> ${HOSTS}
+\${FILES} -> \${HOSTS}
 EOF
 }
 
@@ -130,17 +130,15 @@ check_result()
     cd $TCtmp
     for c_rhost in $HOSTS; do
         for c_ruser in $RUSERS; do
-            TOTAL_SUM=`rsh -n -l $c_ruser $c_rhost \
-            x=0; SUM=\$(sum -s $FILES|awk '{ print \$1 }')
-            for i in \$SUM; do
-                x=\$(( \$x + \$i ))
+            TOTAL_SUM=0
+            for i in $(rsh -n -l $c_ruser $c_rhost sum -s $FILES | awk '{ print $1 }'); do
+                TOTAL_SUM=$(( $TOTAL_SUM + $i ))
             done
-            echo \$x`
-            if [ $TOTAL_SUM = $LSUM ]; then
+            if [ $TOTAL_SUM == $LSUM ]; then
                 tst_resm TINFO "Success rdist in $c_ruser@$c_rhost "
-                rsh -n -l $c_ruser $c_rhost "rm -rf $FILES $DIRECTORIES"
+                rsh -n -l $c_ruser $c_rhost "rm -rf $FILES"
             else
-                end_testcase "Wrong sum doing  rdist in $curr_ruser@$curr_rhost"
+                end_testcase "Wrong sum doing rdist in $curr_ruser@$curr_rhost"
             fi
        done
    done
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
