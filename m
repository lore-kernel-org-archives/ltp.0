From: Jiri Jaburek <jjaburek@redhat.com>
Date: Fri, 10 Jun 2016 14:43:29 +0200
Subject: [LTP] [PATCH] syscalls/fcntl34: use struct flock64 on 32bit
Message-ID: <1465562609-11947-1-git-send-email-jjaburek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On x86, compiled as 32bit:

fcntl34.c:113: INFO: write to a file inside threads with OFD locks
fcntl34.c:47: INFO: spawning '3' threads
fcntl34.c:56: INFO: waiting for '3' threads
fcntl34.c:88: BROK: fcntl() failed: EINVAL

This is because glibc translates fcntl() to sys_fcntl64,

[pid 19656] fcntl64(4, F_OFD_SETLKW, {l_type=F_WRLCK, l_whence=SEEK_SET,
l_start=4294967296, l_len=-695062700769673216}) = -1 EINVAL
(Invalid argument)

as advised by the kernel,

	/* 32-bit arches must use fcntl64() */
	case F_OFD_SETLK:
	case F_OFD_SETLKW:

but the struct passed uses 32bit values,

struct flock lck = {
	.l_whence = SEEK_SET,
	.l_start = 0,
	.l_len = 1,
};

which are read as 64bit by the kernel,

int fcntl_setlk64(unsigned int fd, struct file *filp, unsigned int cmd,
struct flock64 __user *l)

causing the garbage in upper 32bit of at least l_start and l_len to be
treated as offsets, resulting in EINVAL.

This patch makes the test use struct flock64 when _FILE_OFFSET_BITS
is unset.

Signed-off-by: Jiri Jaburek <jjaburek@redhat.com>
---
 testcases/kernel/syscalls/fcntl/fcntl34.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/fcntl/fcntl34.c b/testcases/kernel/syscalls/fcntl/fcntl34.c
index c72951e..9c9310e 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl34.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl34.c
@@ -58,6 +58,13 @@ static void wait_threads(pthread_t *id)
 		SAFE_PTHREAD_JOIN(id[i], NULL);
 }
 
+/* F_OFD_SETLKW needs proper 64bit offsets on 32bit systems */
+#if _FILE_OFFSET_BITS == 64
+typedef struct flock flock_t;
+#else
+typedef struct flock64 flock_t;
+#endif
+
 void *thread_fn_01(void *arg)
 {
 	int i;
@@ -66,7 +73,7 @@ void *thread_fn_01(void *arg)
 
 	memset(buf, (intptr_t)arg, write_size);
 
-	struct flock lck = {
+	flock_t lck = {
 		.l_whence = SEEK_SET,
 		.l_start  = 0,
 		.l_len    = 1,
-- 
2.4.3

