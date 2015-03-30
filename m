Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <a0850405@a0850405-off1>) id 1Ychxo-0004AY-M3
	for ltp-list@lists.sourceforge.net; Mon, 30 Mar 2015 22:15:20 +0000
Received: from comal.ext.ti.com ([198.47.26.152])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Ychxl-0003Yg-OE
	for ltp-list@lists.sourceforge.net; Mon, 30 Mar 2015 22:15:20 +0000
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id t2UM0ZWk001952
	for <ltp-list@lists.sourceforge.net>; Mon, 30 Mar 2015 17:00:37 -0500
Received: from DLEE70.ent.ti.com (dlemailx.itg.ti.com [157.170.170.113])
	by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id t2UM0Y0H002652
	for <ltp-list@lists.sourceforge.net>; Mon, 30 Mar 2015 17:00:34 -0500
From: Carlos Hernandez <ceh@ti.com>
Date: Mon, 30 Mar 2015 18:00:30 -0400
Message-ID: <1427752830-21595-1-git-send-email-ceh@ti.com>
MIME-Version: 1.0
Subject: [LTP] [ltp][PATCH] daemonlib.sh: Don't assume service support
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
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

Some systems (i.e. embedded distributions) do not support service.
Instead /etc/init.d/ scripts are called directly. So use service if
available otherwise try to start daemon by calling /etc/init.d/
script.

Signed-off-by: Carlos Hernandez <ceh@ti.com>
---
 testcases/lib/daemonlib.sh | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/testcases/lib/daemonlib.sh b/testcases/lib/daemonlib.sh
index b924e17..3d67125 100644
--- a/testcases/lib/daemonlib.sh
+++ b/testcases/lib/daemonlib.sh
@@ -48,8 +48,10 @@ start_daemon()
 {
 	if [ $HAVE_SYSTEMCTL -eq 1 ]; then
 		systemctl start $1.service > /dev/null 2>&1
-	else
+	elif command -v service &> /dev/null; then
 		service $1 start > /dev/null 2>&1
+	else
+		/etc/init.d/$1 start > /dev/null 2>&1
 	fi
 }
 
@@ -57,8 +59,10 @@ stop_daemon()
 {
 	if [ $HAVE_SYSTEMCTL -eq 1 ]; then
 		systemctl stop $1.service > /dev/null 2>&1
-	else
+	elif command -v service &> /dev/null; then
 		service $1 stop > /dev/null 2>&1
+	else
+		/etc/init.d/$1 stop > /dev/null 2>&1
 	fi
 }
 
@@ -66,8 +70,10 @@ status_daemon()
 {
 	if [ $HAVE_SYSTEMCTL -eq 1 ]; then
 		systemctl status $1.service > /dev/null 2>&1
-	else
+	elif command -v service &> /dev/null; then
 		service $1 status > /dev/null 2>&1
+	else
+		/etc/init.d/$1 status > /dev/null 2>&1
 	fi
 }
 
@@ -75,7 +81,9 @@ restart_daemon()
 {
 	if [ $HAVE_SYSTEMCTL -eq 1 ]; then
 		systemctl restart $1.service > /dev/null 2>&1
-	else
+	elif command -v service &> /dev/null; then
 		service $1 restart > /dev/null 2>&1
+	else
+		/etc/init.d/$1 restart > /dev/null 2>&1
 	fi
 }
-- 
1.9.1


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
