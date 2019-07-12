From: Hongzhi.Song <hongzhi.song@windriver.com>
Date: Fri, 12 Jul 2019 05:21:08 -0400
Subject: [LTP] [PATCH V3] getrlimit03: adjust a bit of code to compatiable
 with mips32
In-Reply-To: <1562923268-8132-1-git-send-email-hongzhi.song@windriver.com>
References: <1562923268-8132-1-git-send-email-hongzhi.song@windriver.com>
Message-ID: <1562923268-8132-2-git-send-email-hongzhi.song@windriver.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Error info:
getrlimit03.c:104: FAIL: __NR_prlimit64(0) had rlim_cur =
ffffffffffffffff but __NR_getrlimit(0) had rlim_cur = 7fffffff

According to kernel code: [arch/mips/include/uapi/asm/resource.h]
RLIM_INFINITY is set to 0x7fffffffUL instead of ULONG_MAX on mips32.

 /*
 * SuS says limits have to be unsigned.
 * Which makes a ton more sense anyway,
 * but we keep the old value on MIPS32,
 * for compatibility:
 */
 #ifndef __mips64
 # define RLIM_INFINITY      0x7fffffffUL
 #endif

Adding conditional statement about mips to fix this.

Signed-off-by: Hongzhi.Song <hongzhi.song@windriver.com>
---
 testcases/kernel/syscalls/getrlimit/getrlimit03.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/testcases/kernel/syscalls/getrlimit/getrlimit03.c b/testcases/kernel/syscalls/getrlimit/getrlimit03.c
index e4d56c4..a1cbec7 100644
--- a/testcases/kernel/syscalls/getrlimit/getrlimit03.c
+++ b/testcases/kernel/syscalls/getrlimit/getrlimit03.c
@@ -61,7 +61,16 @@ struct rlimit_ulong {
 	unsigned long rlim_cur;
 	unsigned long rlim_max;
 };
+
+#ifdef __mips
+#ifndef __mips64
+const unsigned long RLIM_INFINITY_UL = 0x7fffffffUL;
+#else
+const unsigned long RLIM_INFINITY_UL = ULONG_MAX;
+#endif
+#else
 const unsigned long RLIM_INFINITY_UL = ULONG_MAX;
+#endif
 
 static int getrlimit_ulong(int resource, struct rlimit_ulong *rlim)
 {
-- 
2.8.1

