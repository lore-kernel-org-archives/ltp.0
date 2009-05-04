Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1MIY3L-0005PF-JR
	for ltp-list@lists.sourceforge.net; Mon, 22 Jun 2009 01:10:31 +0000
Received: from fmmailgate02.web.de ([217.72.192.227])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MIY3K-0001Ik-44
	for ltp-list@lists.sourceforge.net; Mon, 22 Jun 2009 01:10:31 +0000
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate02.web.de (Postfix) with ESMTP id 5E2A910439532
	for <ltp-list@lists.sourceforge.net>;
	Mon, 22 Jun 2009 03:10:29 +0200 (CEST)
Received: from [83.208.36.163] (helo=debian)
	by smtp05.web.de with asmtp (WEB.DE 4.110 #277) id 1MIY3J-0004IP-00
	for ltp-list@lists.sourceforge.net; Mon, 22 Jun 2009 03:10:29 +0200
Date: Tue, 05 May 2009 00:25:51 +0200
From: "Jiri Palecek >" <"<jirka"@suse.de>(none)
MIME-Version: 1.0
Resent-To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>
Resent-Message-ID: <op.uvwiz8lslwynca@debian>
Subject: [LTP] [PATCH] Report error with the correct error file in
	tar_tests.sh
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
Message-ID: <20090504222551.KMiW8zxySjWJ3IIEYZzHEuf6Hu9EmeefpN2qp4ZDAQw@z>

Signed-off-by: Jiri Palecek <jpalecek@web.de>
---
 testcases/commands/tar/tar_tests.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/testcases/commands/tar/tar_tests.sh b/testcases/commands/tar/tar_tests.sh
index a3a197f..6858161 100755
--- a/testcases/commands/tar/tar_tests.sh
+++ b/testcases/commands/tar/tar_tests.sh
@@ -258,7 +258,7 @@ else
 		TFAILCNT=$(( $TFAILCNT+1 ))
 	    fi
 	else
-	    $LTPBIN/tst_brk TBROK $LTPTMP/file.out NULL \
+	    $LTPBIN/tst_brk TBROK $LTPTMP/tar_tst.out NULL \
 		"tar: command failed while creating compressed archive. Reason:"
 	    TFAILCNT=$(( $TFAILCNT+1 ))
 	fi
-- 
1.6.3.1




------------------------------------------------------------------------------
Are you an open source citizen? Join us for the Open Source Bridge conference!
Portland, OR, June 17-19. Two days of sessions, one day of unconference: $250.
Need another reason to go? 24-hour hacker lounge. Register today!
http://ad.doubleclick.net/clk;215844324;13503038;v?http://opensourcebridge.org
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
