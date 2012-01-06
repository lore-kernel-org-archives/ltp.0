Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Wei.Yang@windriver.com>) id 1Rj3TW-0007lo-QA
	for ltp-list@lists.sourceforge.net; Fri, 06 Jan 2012 06:40:26 +0000
Received: from mail.windriver.com ([147.11.1.11])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Rj3TV-0004HQ-Bk
	for ltp-list@lists.sourceforge.net; Fri, 06 Jan 2012 06:40:26 +0000
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q066eJRh011999
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>;
	Thu, 5 Jan 2012 22:40:19 -0800 (PST)
From: <Wei.Yang@windriver.com>
Date: Fri, 6 Jan 2012 14:40:19 +0800
Message-ID: <1325832019-21537-1-git-send-email-Wei.Yang@windriver.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH1/1][V2] shmat() returns -1 and errno is EINVAL on mips
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


Hi, Please folks help me review the patch below.

thanks

The patch fixes upon the issue described by the subject above.
The funciton shmget(shkey++, INT_SIZE,...) and shmat() only 
ensure that a page linear address range is avaiable. 
shmat() will return base_addr aligned on a page boundary, 
For x86 and ppc, since SHMLBA is equal to PAGE_SIZE, so the 
base_addr returned by shmat() is the same as the base_addr 
is aligned to next SHMLBA. But for mips architecture, 
SHMLBA is not equal to PAGE_SIZE(SHMLBA > PAGE_SIZE)
so when base_addr is aligned to next SHMLBA address. base_addr will 
expire a page range and the base_addr can already be used by the process,
then shmat(shkey, base_addr....) will return -1.
Therefore we should probe a bigger available virtual address space for 
ensuring that base_addr aligned to next SHMLBA always is available. that is
the base_addr aligned to next SHMLBA is not used by the process.


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
Ridiculously easy VDI. With Citrix VDI-in-a-Box, you don't need a complex
infrastructure or vast IT resources to deliver seamless, secure access to
virtual desktops. With this all-in-one solution, easily deploy virtual 
desktops for less than the cost of PCs and save 60% on VDI infrastructure 
costs. Try it free! http://p.sf.net/sfu/Citrix-VDIinabox
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
