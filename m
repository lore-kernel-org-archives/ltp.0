From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Mon, 10 Dec 2018 14:19:52 +0100
Subject: [LTP] [PATCH] getrlimit03: Allow for missing getrlimit syscall at
	runtime
Message-ID: <20181210131952.27010-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

It appears that __NR_getrlimit can be missing or disabled in the kernel. For
example this appears to be the case on the PPC64le platform. So this changes
the test to return TCONF under these circumstances as this system call is
redundant and libc can implement it in terms of other calls.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---

It also occurred to me that __NR_getrlimit may not be defined in user land for
some very new architectures like RISC-V. I'm not sure exactly what would
happen in that case or if it is likely.

 testcases/kernel/syscalls/getrlimit/getrlimit03.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/testcases/kernel/syscalls/getrlimit/getrlimit03.c b/testcases/kernel/syscalls/getrlimit/getrlimit03.c
index 376ef7241..f470c0b3b 100644
--- a/testcases/kernel/syscalls/getrlimit/getrlimit03.c
+++ b/testcases/kernel/syscalls/getrlimit/getrlimit03.c
@@ -79,6 +79,8 @@ static int getrlimit_long(int resource, struct rlimit_long *rlim)
 {
 	return syscall(__NR_getrlimit, resource, rlim);
 }
+
+static int seen_getrlimit_nosys = 0;
 #endif
 
 static int compare_retval(int resource, int ret_u64, int errno_u64,
@@ -159,10 +161,20 @@ static void run(unsigned int resource)
 		return;
 
 #if SIGNED_GETRLIMIT
+	if (seen_getrlimit_nosys)
+		goto EXIT;
+
 	errno = 0;
 	ret_l = getrlimit_long(resource, &rlim_l);
 	errno_l = errno;
 
+	if (errno_l == ENOSYS) {
+		tst_res(TCONF,
+			"__NR_getrlimit(%d) is not present", __NR_getrlimit);
+		seen_getrlimit_nosys = 1;
+		return;
+	}
+
 	if (compare_retval(resource, ret_u64, errno_u64, ret_l, errno_l,
 			   "__NR_getrlimit") ||
 	    compare_u64_long(resource, rlim_u64.rlim_cur, rlim_l.rlim_cur,
@@ -172,6 +184,7 @@ static void run(unsigned int resource)
 		return;
 #endif
 
+EXIT:
 	tst_res(TPASS, "getrlimit(%u) was consistent during all syscalls",
 		resource);
 }
-- 
2.19.1

