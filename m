Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1MuPQS-0008SX-L9
	for ltp-list@lists.sourceforge.net; Sun, 04 Oct 2009 11:38:52 +0000
Received: from fmmailgate03.web.de ([217.72.192.234])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MuPQJ-00079Y-SN
	for ltp-list@lists.sourceforge.net; Sun, 04 Oct 2009 11:38:52 +0000
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate03.web.de (Postfix) with ESMTP id 89A6E11E4D92A
	for <ltp-list@lists.sourceforge.net>;
	Sun,  4 Oct 2009 13:38:37 +0200 (CEST)
Received: from [83.208.36.163] (helo=debian)
	by smtp07.web.de with asmtp (WEB.DE 4.110 #314) id 1MuPQD-00036W-00
	for ltp-list@lists.sourceforge.net; Sun, 04 Oct 2009 13:38:37 +0200
Date: Sun, 07 Jun 2009 02:32:09 +0200
From: "Jiri Palecek" <jpalecek@web.de>
MIME-Version: 1.0
Resent-To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>
Resent-Message-ID: <op.u09xb5cscfnueu@debian>
Subject: [LTP] [PATCH] Fix temporary file creation in mmapstress tests
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
Message-ID: <20090607003209.LvcAkzv2Ab1MYUVRAvIgOSKasVct1jtoX695fju8xtA@z>

Hello,

these are two little fixes of the mmapstress test.

 - the mkstemp() function returns -1 on error; the tests treat 0 as
   error instead

 - mkstemp() returns a file descriptor; no need to open the file once
   more later

Regards
    Jiri Palecek

Signed-off-by: Jiri Palecek <jpalecek@web.de>
---
 testcases/kernel/mem/mmapstress/mmapstress02.c |    6 +-----
 testcases/kernel/mem/mmapstress/mmapstress05.c |    6 +-----
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/mem/mmapstress/mmapstress02.c b/testcases/kernel/mem/mmapstress/mmapstress02.c
index a0f0693..f801a2e 100644
--- a/testcases/kernel/mem/mmapstress/mmapstress02.c
+++ b/testcases/kernel/mem/mmapstress/mmapstress02.c
@@ -101,7 +101,7 @@ main(int argc, char *argv[]) {
 		return 1;
 	}
 	(void)time(&t);
-	if (!(fd = mkstemp(tmpname))) {
+	if ((fd = mkstemp(tmpname)) == -1) {
 		ERROR("mkstemp failed");
 		anyfail();
 	}
@@ -114,10 +114,6 @@ main(int argc, char *argv[]) {
         CATCH_SIG(SIGINT);
         CATCH_SIG(SIGQUIT);
         CATCH_SIG(SIGTERM);
-	if ((fd = open(tmpname, O_CREAT|O_RDWR, 0777)) == -1) {
-		ERROR("couldn't open temporary file");
-		anyfail();
-	}
 	if (sbrk(2*pagesize - ((ulong)sbrk(0) & (pagesize-1))) == (char *)-1) {
 		CLEANERROR("couldn't round up brk");
 		anyfail();
diff --git a/testcases/kernel/mem/mmapstress/mmapstress05.c b/testcases/kernel/mem/mmapstress/mmapstress05.c
index 9155834..4d25b8d 100644
--- a/testcases/kernel/mem/mmapstress/mmapstress05.c
+++ b/testcases/kernel/mem/mmapstress/mmapstress05.c
@@ -133,7 +133,7 @@ main(int argc, char *argv[])
 	-- sreeni
 	*/
 
-	if (!(fd = mkstemp(tmpname))) {
+	if ((fd = mkstemp(tmpname))==-1) {
 		ERROR("mkstemp failed");
 		anyfail();
 	}
@@ -146,10 +146,6 @@ main(int argc, char *argv[])
 	CATCH_SIG(SIGINT);
         CATCH_SIG(SIGQUIT);
         CATCH_SIG(SIGTERM);
-	if ((fd = open(tmpname, O_RDWR|O_CREAT, 0777)) == -1) {
-		ERROR("open failed");
-		anyfail();
-	}
 	for (i = 0; i < pagesize; i++)
 		buf[i] = 'a';
 	if (write(fd, buf, pagesize) != pagesize) {
-- 
1.6.4.3




------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
