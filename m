From: Steven Price <steven.price@arm.com>
Date: Fri, 19 Jul 2019 13:48:17 +0100
Subject: [LTP] [PATCH] ustat02: Fix EFAULT in 32bit compatibility mode
Message-ID: <20190719124817.5140-1-steven.price@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The size of dev_t is larger than 32 bits which causes the dev argument
to be passed incorrectly. On Arm this means that the EFAULT test case
actually returns EINVAL because the device number isn't recognised.

Signed-off-by: Steven Price <steven.price@arm.com>
---
This is the same fix as 989bcfc7544d ("ustat: Fix EFAULT in 32bit
compatability mode") applied to ustat02. Originally it was justified[1]
that this doesn't affect ustat02 as the test works on x86, however it
does affect Arm.

I believe this only affects Arm and not x86 because only Arm requires a
64 bit argument to be aligned in registers. This means the test is
currently passing the dev number in r2/r3 and leaving junk in r1 which
is then being treated as the device number.

However even on x86 the pointer value is actually the upper bits of
root_dev rather than the expected (void*)-1.

[1] http://lists.linux.it/pipermail/ltp/2019-February/010752.html
---
 testcases/kernel/syscalls/ustat/ustat02.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/ustat/ustat02.c b/testcases/kernel/syscalls/ustat/ustat02.c
index 9bbe4f3f5..1a0e9e059 100644
--- a/testcases/kernel/syscalls/ustat/ustat02.c
+++ b/testcases/kernel/syscalls/ustat/ustat02.c
@@ -36,7 +36,7 @@ int TST_TOTAL = ARRAY_SIZE(tc);
 
 void run(unsigned int test)
 {
-	TEST(tst_syscall(__NR_ustat, *tc[test].dev, tc[test].buf));
+	TEST(tst_syscall(__NR_ustat, (unsigned int)*tc[test].dev, tc[test].buf));
 
 	if ((TST_RET == -1) && (TST_ERR == tc[test].exp_errno))
 		tst_res(TPASS | TTERRNO, "ustat(2) expected failure");
-- 
2.20.1

