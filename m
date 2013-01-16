Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sedat.dilek@gmail.com>) id 1TvUNy-00044U-38
	for ltp-list@lists.sourceforge.net; Wed, 16 Jan 2013 14:54:38 +0000
Received: from mail-bk0-f54.google.com ([209.85.214.54])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1TvUNu-00020W-La
	for ltp-list@lists.sourceforge.net; Wed, 16 Jan 2013 14:54:38 +0000
Received: by mail-bk0-f54.google.com with SMTP id je9so746699bkc.27
	for <ltp-list@lists.sourceforge.net>;
	Wed, 16 Jan 2013 06:54:28 -0800 (PST)
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Wed, 16 Jan 2013 15:54:15 +0100
Message-Id: <1358348055-7882-1-git-send-email-sedat.dilek@gmail.com>
Subject: [LTP] [PATCH] flock/flock01.c: Trivial: Fix spelling of "succeed"
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

While grepping for "succeeded" in my LTP-lite results I noticed
the different spelling.

According to my spell-checker integrated in Firefox v18.x the word
"succeed" is written with double "e" correctly.

Signed-off-by: Sedat Dilek <sedat.dilek@gmail.com>
---
 testcases/kernel/syscalls/flock/flock01.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/flock/flock01.c b/testcases/kernel/syscalls/flock/flock01.c
index 9bf4db3..be2e249 100644
--- a/testcases/kernel/syscalls/flock/flock01.c
+++ b/testcases/kernel/syscalls/flock/flock01.c
@@ -31,7 +31,7 @@
  *      (See the parse_opts(3) man page).
  *
  *    DESCRIPTION
- * 	Test to verify flock(2) succeds with all kind of locks.
+ * 	Test to verify flock(2) succeeds with all kind of locks.
  *	Intends to provide a limited exposure of system call.
  *    $
  *	Setup:
@@ -126,7 +126,7 @@ int main(int argc, char **argv)
 				continue;	/*next loop for MTKERNEL  */
 			} else {
 				tst_resm(TPASS,
-					 "flock() succeded with %s, returned error number=%d",
+					 "flock() succeeded with %s, returned error number=%d",
 					 test_cases[i].opt, TEST_ERRNO);
 			}
 
-- 
1.8.1.1


------------------------------------------------------------------------------
Master Java SE, Java EE, Eclipse, Spring, Hibernate, JavaScript, jQuery
and much more. Keep your Java skills current with LearnJavaNow -
200+ hours of step-by-step video tutorials by Java experts.
SALE $49.99 this month only -- learn more at:
http://p.sf.net/sfu/learnmore_122612 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
