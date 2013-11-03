Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <nexus226@gmail.com>) id 1Vcsqb-0001E2-L9
	for ltp-list@lists.sourceforge.net; Sun, 03 Nov 2013 08:15:49 +0000
Received: from mail-pb0-f43.google.com ([209.85.160.43])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Vcsqa-0005I2-Tq
	for ltp-list@lists.sourceforge.net; Sun, 03 Nov 2013 08:15:49 +0000
Received: by mail-pb0-f43.google.com with SMTP id md4so5944088pbc.2
	for <ltp-list@lists.sourceforge.net>;
	Sun, 03 Nov 2013 01:15:43 -0700 (PDT)
From: Honggyu Kim <nexus226@gmail.com>
Date: Sun,  3 Nov 2013 17:14:42 +0900
Message-Id: <1383466482-19441-1-git-send-email-nexus226@gmail.com>
Subject: [LTP] [PATCH v3] acct01: fix TBROK to TCONF if acct not implemented
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

acct system call is avaliable only when the kernel option is on.
When it fails, acct returns -1 and sets errno correspondingly.
ENOSYS is set when the system call is not implemented.
Currently, ENOSYS is not checked when the TEST_FILE5 argument is passed.
It just goes to TBROK regardless of the implementation in kernel.
This patch modifies to check errno ENOSYS, and marks as TCONF in that case.

Signed-off-by: Honggyu Kim <nexus226@gmail.com>
---
 testcases/kernel/syscalls/acct/acct01.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/acct/acct01.c b/testcases/kernel/syscalls/acct/acct01.c
index c38d4db..0fe973b 100644
--- a/testcases/kernel/syscalls/acct/acct01.c
+++ b/testcases/kernel/syscalls/acct/acct01.c
@@ -103,8 +103,15 @@ static void setup(void)
 	fd = SAFE_CREAT(cleanup, TEST_FILE5, 0777);
 	SAFE_CLOSE(cleanup, fd);
 
-	if (acct(TEST_FILE5) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "acct failed unexpectedly");
+	if (acct(TEST_FILE5) == -1) {
+		if (errno == ENOSYS) {
+			tst_brkm(TCONF, cleanup,
+				 "BSD process accounting is not configured in "
+				 "this kernel");
+		} else {
+			tst_brkm(TBROK | TERRNO, cleanup, "acct failed unexpectedly");
+		}
+	}
 
 	/* turn off acct, so we are in a known state */
 	if (acct(NULL) == -1) {
-- 
1.7.9.5


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
