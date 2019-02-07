From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Thu,  7 Feb 2019 11:18:35 +0100
Subject: [LTP] [PATCH] ustat: Fix EFAULT in 32bit compatability mode
In-Reply-To: <20190202001727.13269-1-smuckle@google.com>
References: <20190202001727.13269-1-smuckle@google.com>
Message-ID: <20190207101835.641-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This test fails with -m32 on Intel because the user land dev_num is too
large.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---

From looking at glibc, this test may also be broken on mips, but I am not sure
if that matters. AFAICT on all other platforms glibc always casts to uint
after performing a sanity check..

 testcases/kernel/syscalls/ustat/ustat01.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/ustat/ustat01.c b/testcases/kernel/syscalls/ustat/ustat01.c
index 3f1186c49..2e7dcc9d7 100644
--- a/testcases/kernel/syscalls/ustat/ustat01.c
+++ b/testcases/kernel/syscalls/ustat/ustat01.c
@@ -20,7 +20,7 @@ void run(void)
 {
 	struct ustat ubuf;
 
-	TEST(tst_syscall(__NR_ustat, dev_num, &ubuf));
+	TEST(tst_syscall(__NR_ustat, (unsigned int)dev_num, &ubuf));
 
 	if (TST_RET == -1)
 		tst_res(TFAIL | TTERRNO, "ustat(2) failed");
-- 
2.20.1

