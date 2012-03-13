Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1S7MZU-0007KW-2V
	for ltp-list@lists.sourceforge.net; Tue, 13 Mar 2012 07:55:04 +0000
Received: from mail-pz0-f47.google.com ([209.85.210.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1S7MZO-0003Jg-Fy
	for ltp-list@lists.sourceforge.net; Tue, 13 Mar 2012 07:55:04 +0000
Received: by dado14 with SMTP id o14so455468dad.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 13 Mar 2012 00:54:52 -0700 (PDT)
From: Caspar Zhang <caspar@casparzhang.com>
Date: Tue, 13 Mar 2012 15:53:38 +0800
Message-Id: <1331625218-5731-1-git-send-email-caspar@casparzhang.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.8.4"
Subject: [LTP] [PATCH] hugetlb/hugeshmat01: don't use hard-coded unaligned
	addr
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: LTP List <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------1.7.8.4
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


An usable unaligned addr various on different platforms, it's better to
generate the addr dynamically instead of using a hard-coded one. This
patch generate this unaligned addr based on first run.

Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
---
 .../kernel/mem/hugetlb/hugeshmat/hugeshmat01.c     |   29 ++++++++++---------
 1 files changed, 15 insertions(+), 14 deletions(-)


--------------1.7.8.4
Content-Type: text/x-patch;
	name="0001-hugetlb-hugeshmat01-don-t-use-hard-coded-unaligned-a.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0001-hugetlb-hugeshmat01-don-t-use-hard-coded-unaligned-a.patch"

diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
index e46ae12..54d8aeb 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
@@ -66,16 +66,6 @@ int TST_TOTAL = 3;
 #define CASE0		10		/* values to write into the shared */
 #define CASE1		20		/* memory location.		   */
 
-#if __WORDSIZE == 64
-#if defined(__mips__)
-#define UNALIGNED      0x1000000eee
-#else
-#define UNALIGNED      0x10000000eee
-#endif
-#else
-#define UNALIGNED      0x60000eee
-#endif
-
 static size_t shm_size;
 static int    shm_id_1 = -1;
 static void   *addr;
@@ -92,13 +82,16 @@ struct test_case_t {
 	int  flags;
 } TC[] = {
 	/* a straight forward read/write attach */
-	{ &shm_id_1,	0,			0 },
+	{ &shm_id_1,	0,		0 },
 
-	/* an attach using non aligned memory */
-	{ &shm_id_1,	(void *)UNALIGNED,	SHM_RND },
+	/*
+	 * an attach using non aligned memory
+	 * -1 will be replaced with an unaligned addr
+	 */
+	{ &shm_id_1,	(void *)-1,	SHM_RND },
 
 	/* a read only attach */
-	{ &shm_id_1,	0,			SHM_RDONLY }
+	{ &shm_id_1,	0,		SHM_RDONLY }
 };
 
 static void check_functionality(int i);
@@ -130,6 +123,14 @@ int main(int ac, char **av)
 					tst_resm(TPASS, "shmat call succeeded");
 			}
 
+			/*
+			 * addr in TC[0] will be used to generate an unaligned
+			 * address for TC[1]
+			 */
+			if (i == 0 && addr != (void *)-1)
+				TC[i+1].addr = (void *)((unsigned long)addr/
+					    SHMLBA*SHMLBA) + SHMLBA -1;
+
 			if (shmdt(addr) == -1)
 				tst_brkm(TBROK|TERRNO, cleanup, "shmdt");
 		}

--------------1.7.8.4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
--------------1.7.8.4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.8.4--



