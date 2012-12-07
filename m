Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <penght@cn.fujitsu.com>) id 1Tgp16-0005GL-9p
	for ltp-list@lists.sourceforge.net; Fri, 07 Dec 2012 03:54:24 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Tgp14-0000Ld-OT
	for ltp-list@lists.sourceforge.net; Fri, 07 Dec 2012 03:54:24 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id qB73Pbkt025050
	for <ltp-list@lists.sourceforge.net>; Fri, 7 Dec 2012 11:25:38 +0800
From: Peng Haitao <penght@cn.fujitsu.com>
Date: Fri, 7 Dec 2012 11:24:00 +0800
Message-Id: <1354850641-15547-1-git-send-email-penght@cn.fujitsu.com>
Subject: [LTP] [PATCH v2 1/2] at_allow01: Use lib to restart atd service
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

Use restart_daemon() to restart atd service.

Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>
---
 testcases/commands/at/at_allow01 | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/testcases/commands/at/at_allow01 b/testcases/commands/at/at_allow01
index 43b3428..c0e9335 100755
--- a/testcases/commands/at/at_allow01
+++ b/testcases/commands/at/at_allow01
@@ -38,6 +38,10 @@ test_user1_home="/home/${test_user1}"
 test_user2_home="/home/${test_user2}"
 tmpfile="$TMP/at_allow_test"
 
+if [ "$(id -ru)" = 0 ]; then
+	. cmdlib.sh
+fi
+
 #-----------------------------------------------------------------------
 # FUNCTION:  do_setup
 #-----------------------------------------------------------------------
@@ -80,19 +84,7 @@ do_setup()
 		exit 1
 	fi
 
-	# running under systemd?
-	if command -v systemctl >/dev/null 2>&1; then
-		HAVE_SYSTEMCTL=true
-	else
-		HAVE_SYSTEMCTL=false
-	fi
-
-	# Restart atd daemon.
-	if $HAVE_SYSTEMCTL; then
-		systemctl restart atd.service
-	else
-		/etc/init.d/atd restart
-	fi
+	restart_daemon atd
 }
 
 #-----------------------------------------------------------------------
-- 
1.8.0.1


------------------------------------------------------------------------------
LogMeIn Rescue: Anywhere, Anytime Remote support for IT. Free Trial
Remotely access PCs and mobile devices and provide instant support
Improve your efficiency, and focus on delivering more value-add services
Discover what IT Professionals Know. Rescue delivers
http://p.sf.net/sfu/logmein_12329d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
