Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <geert@sonycom.com>) id 1Me9W7-0008Qy-07
	for Ltp-list@lists.sourceforge.net; Thu, 20 Aug 2009 15:25:31 +0000
Received: from vervifontaine.sonytel.be ([80.88.33.193]
	helo=pophost.sonytel.be) by 29vjzd1.ch3.sourceforge.com with esmtp 
	(Exim 4.69) id 1Me9W2-0004wa-JA
	for Ltp-list@lists.sourceforge.net; Thu, 20 Aug 2009 15:25:30 +0000
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Date: Thu, 20 Aug 2009 17:25:15 +0200
Message-Id: <1250781918-23897-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
Subject: [LTP] [PATCH] cron tests: autodetect crond vs. cron
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
To: Ltp-list@lists.sourceforge.net
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

The cron tests check for Red Hat to decide whether to use /etc/init.d/crond
or /etc/init.d/cron. This fails on other distros that use crond, e.g. on
Yellow Dog Linux.

Replace the distro test by an actual file existence test, as is done in
testcases/kdump/runkdump.sh.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 testcases/commands/cron/cron02 |   17 ++++++-----------
 testcases/commands/cron/cron03 |   17 ++++++-----------
 2 files changed, 12 insertions(+), 22 deletions(-)

diff --git a/testcases/commands/cron/cron02 b/testcases/commands/cron/cron02
index 6e4d8fe..b2656e3 100755
--- a/testcases/commands/cron/cron02
+++ b/testcases/commands/cron/cron02
@@ -53,17 +53,12 @@ do_setup(){
         fi
 
 	# restart cron daemon
-# Red Hat uses crond, SuSE/Other uses cron. Check if this is Red Hat/SuSE/Other
-tvar=${MACHTYPE%-*}
-tvar=${tvar#*-}
-printf "Distro type is: $tvar\n\n"
-
-if [ $tvar != "redhat" -a $tvar != "redhat-linux" ]; then
-
-	/etc/init.d/cron restart
-else
-	/etc/init.d/crond restart
-fi
+	# Red Hat uses crond, SuSE/Other uses cron.
+	if [ -f /etc/init.d/crond ]; then
+		/etc/init.d/crond restart
+	else
+		/etc/init.d/cron restart
+	fi
 }
 
 #-----------------------------------------------------------------------
diff --git a/testcases/commands/cron/cron03 b/testcases/commands/cron/cron03
index 9448cc4..2cb157a 100755
--- a/testcases/commands/cron/cron03
+++ b/testcases/commands/cron/cron03
@@ -56,17 +56,12 @@ do_setup(){
         }
         fi
         # restart cron daemon
-# Red Hat uses crond, SuSE/Other uses cron. Check if this is Red Hat/SuSE/Other
-tvar=${MACHTYPE%-*}
-tvar=${tvar#*-}
-printf "Distro type is: $tvar\n\n"
-
-if [ $tvar != "redhat" -a $tvar != "redhat-linux" ]; then
-
-	/etc/init.d/cron restart
-else
-	/etc/init.d/crond restart
-fi
+	# Red Hat uses crond, SuSE/Other uses cron.
+	if [ -f /etc/init.d/crond ]; then
+		/etc/init.d/crond restart
+	else
+		/etc/init.d/cron restart
+	fi
 }
 
 #-----------------------------------------------------------------------
-- 
1.6.2.4


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
