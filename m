Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1XKpfZ-0007Sb-WB
	for ltp-list@lists.sourceforge.net; Fri, 22 Aug 2014 14:18:22 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XKpfY-00015l-Fv
	for ltp-list@lists.sourceforge.net; Fri, 22 Aug 2014 14:18:21 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s7MEIDBR003052
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 22 Aug 2014 10:18:13 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id s7MEICM6024237
	for <ltp-list@lists.sourceforge.net>; Fri, 22 Aug 2014 10:18:12 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 22 Aug 2014 16:18:11 +0200
Message-Id: <424e9b2f0320f58ad3b13852cb2093ef01ca90dd.1408717012.git.jstancek@redhat.com>
Subject: [LTP] [PATCH] sbrk02: check for ret code in setup()
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

In the case sbrk() doesn't return ENOMEM, setup()
keeps looping forever.

Modify setup to check sbrk() return value and also to watch
if increment doesn't overflow.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/sbrk/sbrk02.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/sbrk/sbrk02.c b/testcases/kernel/syscalls/sbrk/sbrk02.c
index caa8537..5e9d4b8 100644
--- a/testcases/kernel/syscalls/sbrk/sbrk02.c
+++ b/testcases/kernel/syscalls/sbrk/sbrk02.c
@@ -34,7 +34,7 @@ static void sbrk_verify(void);
 static void cleanup(void);
 static int exp_enos[] = { ENOMEM, 0 };
 
-static long increment;
+static long increment = INC;
 
 int main(int argc, char *argv[])
 {
@@ -60,12 +60,19 @@ int main(int argc, char *argv[])
 
 static void setup(void)
 {
+	void *ret = NULL;
+
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 
-	for (increment = INC; errno == 0; increment+=INC)
-		sbrk(increment);
+	/* call sbrk until it fails or increment overflows */
+	while (ret != (void *)-1 && increment > 0) {
+		ret = sbrk(increment);
+		increment += INC;
+	}
+	tst_resm(TINFO | TERRNO, "setup() bailing inc: %ld, ret: %p, sbrk: %p",
+		increment, ret, sbrk(0));
 
 	errno = 0;
 
-- 
1.7.1


------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
