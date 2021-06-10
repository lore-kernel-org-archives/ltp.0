From: Vinay Kumar <vinay.m.engg@gmail.com>
Date: Thu, 10 Jun 2021 10:39:52 +0530
Subject: [LTP] [PATCH v4] adjtimex02.c: Skipped EFAULT tests for libc
 variant"
In-Reply-To: <20210602040423.9350-1-vinay.m.engg@gmail.com>
References: <20210602040423.9350-1-vinay.m.engg@gmail.com>
Message-ID: <20210610050952.2862-1-vinay.m.engg@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: vinay kumar <vinay.m.engg@gmail.com>

Tested EFAULT cases only for "__NR_adjtimex" syscall.

Tests for bad addresses in LTP cases trigger segment
fault in libc on a 32bit system.

Signed-off-by: Vinay Kumar <vinay.m.engg@gmail.com>
---
 .../kernel/syscalls/adjtimex/adjtimex02.c     | 226 ++++++++++++------
 1 file changed, 152 insertions(+), 74 deletions(-)

diff --git a/testcases/kernel/syscalls/adjtimex/adjtimex02.c b/testcases/kernel/syscalls/adjtimex/adjtimex02.c
index 19ee97158..5eaea6352 100644
--- a/testcases/kernel/syscalls/adjtimex/adjtimex02.c
+++ b/testcases/kernel/syscalls/adjtimex/adjtimex02.c
@@ -10,115 +10,193 @@
 #include <unistd.h>
 #include <pwd.h>
 #include "tst_test.h"
+#include "lapi/syscalls.h"
 
-#define SET_MODE ( ADJ_OFFSET | ADJ_FREQUENCY | ADJ_MAXERROR | ADJ_ESTERROR | \
-	ADJ_STATUS | ADJ_TIMECONST | ADJ_TICK )
+#define SET_MODE (ADJ_OFFSET | ADJ_FREQUENCY | ADJ_MAXERROR | ADJ_ESTERROR | \
+				ADJ_STATUS | ADJ_TIMECONST | ADJ_TICK)
 
-static int hz;			/* HZ from sysconf */
-
-static struct timex *tim_save;
-static struct timex *buf;
+static int hz;		/* HZ from sysconf */
 
+static struct timex *tim_save, *buf;
 static struct passwd *ltpuser;
 
-static void verify_adjtimex(unsigned int nr)
+struct test_case {
+	unsigned int modes;
+	long lowlimit;
+	long highlimit;
+	long delta;
+	int exp_err;
+};
+
+static int libc_adjtimex(void *timex)
 {
-	struct timex *bufp;
-	int expected_errno = 0;
+	return adjtimex(timex);
+}
 
-	/*
-	 * since Linux 2.6.26, if buf.offset value is outside
-	 * the acceptable range, it is simply normalized instead
-	 * of letting the syscall fail. so just skip this test
-	 * case.
-	 */
-	if (nr > 3 && (tst_kvercmp(2, 6, 25) > 0)) {
-		tst_res(TCONF, "this kernel normalizes buf."
-				"offset value if it is outside"
-				" the acceptable range.");
-		return;
-	}
+static int sys_adjtimex(void *timex)
+{
+	return tst_syscall(__NR_adjtimex, timex);
+}
+
+static struct test_case tc[] = {
+	{
+	.modes = SET_MODE,
+	.exp_err = EFAULT,
+	},
+	{
+	.modes = ADJ_TICK,
+	.lowlimit = 900000,
+	.delta = 1,
+	.exp_err = EINVAL,
+	},
+	{
+	.modes = ADJ_TICK,
+	.highlimit = 1100000,
+	.delta = 1,
+	.exp_err = EINVAL,
+	},
+	{
+	.modes = ADJ_OFFSET,
+	.highlimit = 512000L,
+	.delta = 1,
+	.exp_err = EINVAL,
+	},
+	{
+	.modes = ADJ_OFFSET,
+	.lowlimit = -512000L,
+	.delta = -1,
+	.exp_err = EINVAL,
+	},
+};
+
+static struct test_variants
+{
+	int (*adjtimex)(void *timex);
+	char *desc;
+} variants[] = {
+	{ .adjtimex = libc_adjtimex, .desc = "libc adjtimex()"},
+
+#if (__NR_adjtimex != __LTP__NR_INVALID_SYSCALL)
+	{ .adjtimex = sys_adjtimex,  .desc = "__NR_adjtimex syscall"},
+#endif
+};
+
+static void verify_adjtimex(unsigned int i)
+{
+	struct timex *bufp;
+	struct test_variants *tv = &variants[tst_variant];
 
 	*buf = *tim_save;
 	buf->modes = SET_MODE;
 	bufp = buf;
-	switch (nr) {
-	case 0:
-		bufp = (struct timex *)-1;
-		expected_errno = EFAULT;
-		break;
-	case 1:
-		buf->tick = 900000 / hz - 1;
-		expected_errno = EINVAL;
-		break;
-	case 2:
-		buf->tick = 1100000 / hz + 1;
-		expected_errno = EINVAL;
-		break;
-	case 3:
-		/* Switch to nobody user for correct error code collection */
-		ltpuser = SAFE_GETPWNAM("nobody");
-		SAFE_SETEUID(ltpuser->pw_uid);
-		expected_errno = EPERM;
-		break;
-	case 4:
-		buf->offset = 512000L + 1;
-		expected_errno = EINVAL;
-		break;
-	case 5:
-		buf->offset = (-1) * (512000L) - 1;
-		expected_errno = EINVAL;
-		break;
-	default:
-		tst_brk(TFAIL, "Invalid test case %u ", nr);
+
+	if (tc[i].exp_err == EINVAL) {
+		if (tc[i].modes == ADJ_TICK) {
+			if (tc[i].lowlimit)
+				buf->tick = tc[i].lowlimit - tc[i].delta;
+
+			if (tc[i].highlimit)
+				buf->tick = tc[i].highlimit + tc[i].delta;
+		}
+		if (tc[i].modes == ADJ_OFFSET) {
+			if (tc[i].lowlimit) {
+				tst_res(TCONF, "this kernel normalizes buf. offset value if it is outside the acceptable range.");
+				return;
+			}
+			if (tc[i].highlimit) {
+				tst_res(TCONF, "this kernel normalizes buf. offset value if it is outside the acceptable range.");
+				return;
+			}
+		}
 	}
 
-	TEST(adjtimex(bufp));
-	if ((TST_RET == -1) && (TST_ERR == expected_errno)) {
-		tst_res(TPASS | TTERRNO,
-				"adjtimex() error %u ", expected_errno);
-	} else {
-		tst_res(TFAIL | TTERRNO,
-				"Test Failed, adjtimex() returned %ld",
-				TST_RET);
+	if (tc[i].exp_err == EFAULT) {
+		if (tv->adjtimex != libc_adjtimex) {
+			bufp = (struct timex *) -1;
+		} else {
+			tst_res(TCONF, "EFAULT is skipped for libc variant");
+			return;
+		}
+	}
+
+	TEST(tv->adjtimex(bufp));
+
+	if (tc[i].exp_err != TST_ERR) {
+		tst_res(TFAIL | TTERRNO, "adjtimex(): expected %s mode %x",
+					tst_strerrno(tc[i].exp_err), tc[i].modes);
+		return;
 	}
 
-	/* clean up after ourselves */
-	if (nr == 3)
-		SAFE_SETEUID(0);
+	tst_res(TPASS, "adjtimex() error %s", tst_strerrno(tc[i].exp_err));
+
 }
 
 static void setup(void)
 {
+	struct test_variants *tv = &variants[tst_variant];
+	size_t i;
+	int expected_errno = 0;
+
+	tst_res(TINFO, "Testing variant: %s", tv->desc);
+
 	tim_save->modes = 0;
 
+	buf->modes = SET_MODE;
+
+	/* Switch to nobody user for correct error code collection */
+	ltpuser = SAFE_GETPWNAM("nobody");
+	SAFE_SETEUID(ltpuser->pw_uid);
+	expected_errno = EPERM;
+
+	TEST(tv->adjtimex(buf));
+
+	if ((TST_RET == -1) && (TST_ERR == expected_errno)) {
+		tst_res(TPASS, "adjtimex() error %s ",
+				tst_strerrno(expected_errno));
+	} else {
+		tst_res(TFAIL | TTERRNO,
+				"adjtimex(): returned %ld", TST_RET);
+	}
+
+	SAFE_SETEUID(0);
+
 	/* set the HZ from sysconf */
 	hz = SAFE_SYSCONF(_SC_CLK_TCK);
 
-	/* Save current parameters */
-	if ((adjtimex(tim_save)) == -1)
+	for (i = 0; i < ARRAY_SIZE(tc); i++) {
+		if (tc[i].modes == ADJ_TICK) {
+			tc[i].highlimit /= hz;
+			tc[i].lowlimit /= hz;
+		}
+	}
+
+	if ((adjtimex(tim_save)) == -1) {
 		tst_brk(TBROK | TERRNO,
-			"adjtimex(): failed to save current params");
+		"adjtimex(): failed to save current params");
+	}
 }
 
 static void cleanup(void)
 {
+
 	tim_save->modes = SET_MODE;
 
-	/* Restore saved parameters */
-	if ((adjtimex(tim_save)) == -1)
-		tst_res(TWARN, "Failed to restore saved parameters");
+	if ((adjtimex(tim_save)) == -1) {
+		tst_brk(TBROK | TERRNO,
+		"adjtimex(): failed to save current params");
+	}
 }
 
 static struct tst_test test = {
-	.needs_root = 1,
-	.tcnt = 6,
+	.test = verify_adjtimex,
 	.setup = setup,
 	.cleanup = cleanup,
-	.test = verify_adjtimex,
+	.tcnt = ARRAY_SIZE(tc),
+	.test_variants = ARRAY_SIZE(variants),
+	.needs_root = 1,
 	.bufs = (struct tst_buffers []) {
-		{&buf, .size = sizeof(*buf)},
-		{&tim_save, .size = sizeof(*tim_save)},
-		{},
-	}
+		 {&buf, .size = sizeof(*buf)},
+		 {&tim_save, .size = sizeof(*tim_save)},
+		 {},
+		}
 };
-- 
2.17.1

