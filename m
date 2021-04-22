From: sujiaxun <sujiaxun@uniontech.com>
Date: Thu, 22 Apr 2021 15:26:09 +0800
Subject: [LTP] [PATCH] Fix the 64-bit macro definition of mips architecture
Message-ID: <20210422072609.9938-1-sujiaxun@uniontech.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

https://github.com/torvalds/linux/blob/master/arch/mips/include/uapi/asm/shmbuf.h
The mips 64-bit macro definition in the kernel is "__mips64",
 and the mips 64-bit macro definition in the ltp is "__arch64__".

Signed-off-by: sujiaxun <sujiaxun@uniontech.com>
---
 include/lapi/msgbuf.h | 2 +-
 include/lapi/sembuf.h | 2 +-
 include/lapi/shmbuf.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/lapi/msgbuf.h b/include/lapi/msgbuf.h
index f3277270d..f010695f1 100644
--- a/include/lapi/msgbuf.h
+++ b/include/lapi/msgbuf.h
@@ -17,7 +17,7 @@
 #if defined(__mips__)
 #define HAVE_MSQID64_DS

-#if defined(__arch64__)
+#if defined(__mips64)
 /*
  * The msqid64_ds structure for the MIPS architecture.
  * Note extra padding because this structure is passed back and forth
diff --git a/include/lapi/sembuf.h b/include/lapi/sembuf.h
index 4ef0483a0..58ad9dff5 100644
--- a/include/lapi/sembuf.h
+++ b/include/lapi/sembuf.h
@@ -24,7 +24,7 @@
  * Pad space is left for 2 miscellaneous 64-bit values on mips64,
  * but used for the upper 32 bit of the time values on mips32.
  */
-#if defined(__arch64__)
+#if defined(__mips64)
 struct semid64_ds {
 	struct ipc64_perm sem_perm;		/* permissions .. see ipc.h */
 	long		 sem_otime;		/* last semop time */
diff --git a/include/lapi/shmbuf.h b/include/lapi/shmbuf.h
index 28ee33620..fe405ffe8 100644
--- a/include/lapi/shmbuf.h
+++ b/include/lapi/shmbuf.h
@@ -27,7 +27,7 @@
  * data structure when moving to 64-bit time_t.
  */

-#if defined(__arch64__)
+#if defined(__mips64)
 struct shmid64_ds {
 	struct ipc64_perm	shm_perm;	/* operation perms */
 	size_t			shm_segsz;	/* size of segment (bytes) */
--
2.20.1



