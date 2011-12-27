Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Wei.Yang@windriver.com>) id 1RfQxL-0001MA-0B
	for ltp-list@lists.sourceforge.net; Tue, 27 Dec 2011 06:56:15 +0000
Received: from mail.windriver.com ([147.11.1.11])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RfQxJ-0007OK-PC
	for ltp-list@lists.sourceforge.net; Tue, 27 Dec 2011 06:56:14 +0000
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id pBR6u7E1025921
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>;
	Mon, 26 Dec 2011 22:56:07 -0800 (PST)
From: <Wei.Yang@windriver.com>
Date: Tue, 27 Dec 2011 14:53:29 +0800
Message-ID: <1324968809-15021-1-git-send-email-Wei.Yang@windriver.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] shmat01 failed on mips
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
To: ltp-list@lists.sourceforge.net
Cc: wei.yang@windriver.com

From: Wei Yang <Wei.Yang@windriver.com>

For mips architecture, SHMLBA is not equal to PAGE_SIZE
 base_addr is not available address for process after
 base_addr is aligned to next SHMLBA address. so we should
 probe a bigger available virtual address space for ensuring that
 a wide range from base_addr aligned to next SHMLBA to base_addr + INT_SIZE
 always is available


Signed-off-by: Wei Yang <Wei.Yang@windriver.com>
---
 testcases/kernel/syscalls/ipc/shmat/shmat01.c |   27 +++++++++++++++++++++++-
 1 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/shmat/shmat01.c b/testcases/kernel/syscalls/ipc/shmat/shmat01.c
index 7c68459..344ad3f 100644
--- a/testcases/kernel/syscalls/ipc/shmat/shmat01.c
+++ b/testcases/kernel/syscalls/ipc/shmat/shmat01.c
@@ -65,6 +65,9 @@ void check_functionality(int);
 #define CASE1		20	/* memory location.                */
 
 int shm_id_1 = -1;
+#if defined(__mips__) || defined(__mips64)
+int shm_id_2 = -1;
+#endif
 
 void *base_addr;		/* By probing this address first, we can make
 				 * non-aligned addresses from it for different
@@ -262,14 +265,34 @@ void setup(void)
 		tst_brkm(TBROK, cleanup, "Failed to create shared memory "
 			 "resource 1 in setup()");
 	}
-
 	/* Probe an available linear address for attachment */
+#if defined(__mips__) || defined(__mips64)
+	/*
+	 * For mips architecture, SHMLBA is not equal to PAGE_SIZE
+	 * base_addr is not available address for process after 
+	 * base_addr is aligned to next SHMLBA address
+	 */
+	if ((shm_id_2 = shmget(shmkey++, SHMLBA, SHM_RW | IPC_CREAT | IPC_EXCL)) == -1) {
+		tst_brkm(TBROK, cleanup, "Failed to create shared memory ");
+	}
+	if ((base_addr = shmat(shm_id_2, NULL, 0)) == (void *) -1) {
+		rm_shm(shm_id_2);
+		tst_brkm(TBROK, cleanup, "Couldn't attach shared memory");
+	}
+	if (shmdt((const void *)base_addr) == -1) {
+		rm_shm(shm_id_2);
+		tst_brkm(TBROK, cleanup, "Couldn't detach shared memory");
+	}
+	rm_shm(shm_id_2);
+#else
 	if ((base_addr = shmat(shm_id_1, NULL, 0)) == (void *)-1) {
 		tst_brkm(TBROK, cleanup, "Couldn't attach shared memory");
 	}
 	if (shmdt((const void *)base_addr) == -1) {
 		tst_brkm(TBROK, cleanup, "Couldn't detach shared memory");
 	}
+#endif
+	
 
 	/* some architectures (e.g. parisc) are strange, so better always align to
 	 * next SHMLBA address. */
@@ -299,4 +322,4 @@ void cleanup(void)
 	 */
 	TEST_CLEANUP;
 
-}
\ No newline at end of file
+}
-- 
1.7.0.2


------------------------------------------------------------------------------
Write once. Port to many.
Get the SDK and tools to simplify cross-platform app development. Create 
new or port existing apps to sell to consumers worldwide. Explore the 
Intel AppUpSM program developer opportunity. appdeveloper.intel.com/join
http://p.sf.net/sfu/intel-appdev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
