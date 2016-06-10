From: Jiri Jaburek <jjaburek@redhat.com>
Date: Fri, 10 Jun 2016 16:50:02 +0200
Subject: [LTP] [PATCH v2] syscalls/fcntl34: disable on 32bit without
	_FILE_OFFSET_BITS==64
In-Reply-To: <575AC8F3.8090301@redhat.com>
References: <575AC8F3.8090301@redhat.com>
Message-ID: <1465570202-15504-1-git-send-email-jjaburek@redhat.com>
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

but the struct passed uses 32bit values, which are read as 64bit by
the kernel,

SYSCALL_DEFINE3(fcntl64, unsigned int, fd, unsigned int, cmd,
                unsigned long, arg)
{
	...
	case F_OFD_SETLKW:
		err = fcntl_setlk64(fd, f.file, cmd,
				(struct flock64 __user *) arg);

causing the garbage in upper 32bit of at least l_start and l_len to be
treated as offsets, resulting in EINVAL.

This patch therefore disables the test when using the 32bit struct
members. The functionality is tested by fcntl34_64, which defines
_FILE_OFFSET_BITS=64.

Signed-off-by: Jiri Jaburek <jjaburek@redhat.com>
---
 testcases/kernel/syscalls/fcntl/fcntl34.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/testcases/kernel/syscalls/fcntl/fcntl34.c b/testcases/kernel/syscalls/fcntl/fcntl34.c
index c72951e..e2c8bf7 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl34.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl34.c
@@ -102,6 +102,10 @@ static void test01(void)
 
 	tst_res(TINFO, "write to a file inside threads with OFD locks");
 
+#if __WORDSIZE == 32 && _FILE_OFFSET_BITS != 64
+	tst_brk(TCONF, "test not supported on 32bit");
+#endif
+
 	int fd = SAFE_OPEN(fname, O_CREAT | O_TRUNC | O_RDWR, 0600);
 
 	memset(res, 0, sizeof(res));
-- 
2.4.3

