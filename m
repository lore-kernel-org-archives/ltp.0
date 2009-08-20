Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <geert@sonycom.com>) id 1Me9WB-0003rZ-Lt
	for Ltp-list@lists.sourceforge.net; Thu, 20 Aug 2009 15:25:35 +0000
Received: from vervifontaine.sonytel.be ([80.88.33.193]
	helo=pophost.sonytel.be) by 72vjzd1.ch3.sourceforge.com with esmtp 
	(Exim 4.69) id 1Me9W4-000060-HH
	for Ltp-list@lists.sourceforge.net; Thu, 20 Aug 2009 15:25:35 +0000
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Date: Thu, 20 Aug 2009 17:25:18 +0200
Message-Id: <1250781918-23897-4-git-send-email-Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <1250781918-23897-3-git-send-email-Geert.Uytterhoeven@sonycom.com>
References: <1250781918-23897-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1250781918-23897-2-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1250781918-23897-3-git-send-email-Geert.Uytterhoeven@sonycom.com>
Subject: [LTP] [PATCH] Spelling fixes: brok -> broke
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

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 testcases/commands/ade/file/file_test.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/commands/ade/file/file_test.sh b/testcases/commands/ade/file/file_test.sh
index 6f09f21..b4719fc 100755
--- a/testcases/commands/ade/file/file_test.sh
+++ b/testcases/commands/ade/file/file_test.sh
@@ -532,7 +532,7 @@ fi
 
 if [ $RC -ne 0 ]
 then
-    $LTPBIN/tst_brk TBROK $LTPTMP/file.out NULL "mkdir: brok. Reason:"
+    $LTPBIN/tst_brk TBROK $LTPTMP/file.out NULL "mkdir: broke. Reason:"
 fi
 
 cat > $bDIR/SOURCES/cprog.c <<EOF
@@ -552,7 +552,7 @@ fi
 $bCMD --define "_topdir $bDIR" -bs  $LTPTMP/files.spec > $LTPTMP/file.out 2>&1
 if [ $? -ne 0 ]
 then
-    $LTPBIN/tst_brk TBROK $LTPTMP/file.out NULL "rpm command brok. Reason:"
+    $LTPBIN/tst_brk TBROK $LTPTMP/file.out NULL "rpm command broke. Reason:"
 fi
 
 file $bDIR/SRPMS/cprog-0.0.7-3.src.rpm > $LTPTMP/file.out 2>&1
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
