Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <avagin@gmail.com>) id 1NDIWY-0006a0-Mi
	for ltp-list@lists.sourceforge.net; Wed, 25 Nov 2009 14:07:14 +0000
Received: from mailhub.sw.ru ([195.214.232.25] helo=relay.sw.ru)
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NDIWR-0004F9-Sm
	for ltp-list@lists.sourceforge.net; Wed, 25 Nov 2009 14:07:14 +0000
From: Andrew Vagin <avagin@gmail.com>
Date: Wed, 25 Nov 2009 16:36:35 +0300
Message-Id: <1259156195-13056-1-git-send-email-avagin@gmail.com>
Subject: [LTP] [PATCH] tst_res: save errno at the begin,
	otherwise it may be rewritten
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
To: subrata@linux.vnet.ibm.com
Cc: ltp-list@lists.sf.net, vapier@gentoo.org

it may do fprinf for example.
---
 lib/tst_res.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/tst_res.c b/lib/tst_res.c
index ded3cd6..75fe263 100644
--- a/lib/tst_res.c
+++ b/lib/tst_res.c
@@ -457,6 +457,7 @@ void tst_flush(void)
  */
 static void tst_print(char *tcid, int tnum, int trange, int ttype, char *tmesg)
 {
+	int err = errno; /* avoid unintended side effects */
 	const char *type;
 	int ttype_result = TTYPE_RESULT(ttype);
 
@@ -499,11 +500,9 @@ static void tst_print(char *tcid, int tnum, int trange, int ttype, char *tmesg)
 			fprintf(T_out, "%-8s %4d       %s  :  %s",
 				tcid, tnum, type, tmesg);
 	}
-	if (ttype & TERRNO) {
-		int err = errno; /* avoid unintended side effects */
+	if (ttype & TERRNO)
 		fprintf(T_out, ": errno=%s(%i): %s", strerrnodef(err),
 			err, strerror(err));
-	}
 	if (ttype & TTERRNO)
 		fprintf(T_out, ": TEST_ERRNO=%s(%i): %s", strerrnodef(TEST_ERRNO),
 			(int)TEST_ERRNO, strerror(TEST_ERRNO));
-- 
1.6.2.5


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
