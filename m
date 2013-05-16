Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <li.dan@cn.fujitsu.com>) id 1Ucobv-00057Z-1l
	for ltp-list@lists.sourceforge.net; Thu, 16 May 2013 03:12:07 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Ucobt-0004Xk-9i
	for ltp-list@lists.sourceforge.net; Thu, 16 May 2013 03:12:07 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id r4G3BvJi008514
	for <ltp-list@lists.sourceforge.net>; Thu, 16 May 2013 11:11:58 +0800
Message-ID: <51944DF0.3080506@cn.fujitsu.com>
Date: Thu, 16 May 2013 11:09:36 +0800
From: DAN LI <li.dan@cn.fujitsu.com>
MIME-Version: 1.0
References: <51944C16.5080607@cn.fujitsu.com>
In-Reply-To: <51944C16.5080607@cn.fujitsu.com>
Subject: [LTP] [PATCH 2/2] shmat/shmat01.c: Test for specifying NULL to
	shmaddr
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
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: LTP list <ltp-list@lists.sourceforge.net>


Test for statement:
"If shmaddr is NULL, the system chooses a suitable (unused) address
at which to attach the segment."

Signed-off-by: DAN LI <li.dan@cn.fujitsu.com>
---
 testcases/kernel/syscalls/ipc/shmat/shmat01.c | 41 ++++++++++++++++++---------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/shmat/shmat01.c b/testcases/kernel/syscalls/ipc/shmat/shmat01.c
index 3461782..13c9b1b 100644
--- a/testcases/kernel/syscalls/ipc/shmat/shmat01.c
+++ b/testcases/kernel/syscalls/ipc/shmat/shmat01.c
@@ -46,7 +46,7 @@
 #define CASE1		20

 char *TCID = "shmat01";
-int TST_TOTAL = 3;
+int TST_TOTAL = 4;

 int shm_id_1 = -1;

@@ -70,6 +70,7 @@ int main(int argc, char *argv[])
 {
 	int lc, i;
 	char *msg;
+	void *attchaddr;

 	msg = parse_opts(argc, argv, NULL, NULL);
 	if (msg != NULL)
@@ -85,10 +86,10 @@ int main(int argc, char *argv[])

 			base_addr = probe_free_addr();

-			addr = shmat(*(TC[i].shmid), base_addr + TC[i].offset,
-				     TC[i].flags);
-			TEST_ERRNO = errno;
+			attchaddr = (i ? base_addr + TC[i].offset : NULL);
+			addr = shmat(*(TC[i].shmid), attchaddr, TC[i].flags);

+			TEST_ERRNO = errno;
 			if (addr == (void *)-1) {
 				tst_brkm(TFAIL | TTERRNO, cleanup,
 					 "shmat call failed");
@@ -148,11 +149,20 @@ static void check_functionality(int i)
 		 * If this fails the program will get a SIGSEGV, dump
 		 * core and exit.
 		 */
-
 		*shared = CASE0;
 		break;
 	case 1:
 		/*
+		 * Check the functionality of the first call by simply
+		 * "writing" a value to the shared memory space.
+		 * If this fails the program will get a SIGSEGV, dump
+		 * core and exit.
+		 */
+
+		*shared = CASE0;
+		break;
+	case 2:
+		/*
 		 * Check the functionality of the second call by writing
 		 * a value to the shared memory space and then checking
 		 * that the original address given was rounded down as
@@ -167,7 +177,7 @@ static void check_functionality(int i)
 			fail = 1;
 		}
 		break;
-	case 2:
+	case 3:
 		/*
 		 * This time the shared memory is read only.  Read the value
 		 * and check that it is equal to the value set in case #2,
@@ -195,20 +205,25 @@ void setup(void)
 	if (TC == NULL)
 		tst_brkm(TFAIL | TERRNO, cleanup, "failed to allocate memory");

-	/* a straight forward read/write attach */
+	/* set NULL as attaching address*/
 	TC[0].shmid = &shm_id_1;
 	TC[0].offset = 0;
 	TC[0].flags = 0;

-	/* an attach using unaligned memory */
+	/* a straight forward read/write attach */
 	TC[1].shmid = &shm_id_1;
-	TC[1].offset = SHMLBA - 1;
-	TC[1].flags = SHM_RND;
+	TC[1].offset = 0;
+	TC[1].flags = 0;

-	/* a read only attach */
+	/* an attach using unaligned memory */
 	TC[2].shmid = &shm_id_1;
-	TC[2].offset = 0;
-	TC[2].flags = SHM_RDONLY;
+	TC[2].offset = SHMLBA - 1;
+	TC[2].flags = SHM_RND;
+
+	/* a read only attach */
+	TC[3].shmid = &shm_id_1;
+	TC[3].offset = 0;
+	TC[3].flags = SHM_RDONLY;

 	tst_tmpdir();

-- 
1.8.1




------------------------------------------------------------------------------
AlienVault Unified Security Management (USM) platform delivers complete
security visibility with the essential security capabilities. Easily and
efficiently configure, manage, and operate all of your security controls
from a single console and one unified framework. Download a free trial.
http://p.sf.net/sfu/alienvault_d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
