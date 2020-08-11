From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 11 Aug 2020 16:07:53 +0200
Subject: [LTP] [PATCH v1] Add test case for CVE-2018-11508
In-Reply-To: <20200620063713.5330-1-niravparmar@zilogic.com>
References: <20200620063713.5330-1-niravparmar@zilogic.com>
Message-ID: <20200811140753.GA1292@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with some changes, explained below, thanks.


diff --git a/testcases/kernel/syscalls/adjtimex/adjtimex03.c b/testcases/kernel/syscalls/adjtimex/adjtimex03.c
index d6c8d67e5..263391c90 100644
--- a/testcases/kernel/syscalls/adjtimex/adjtimex03.c
+++ b/testcases/kernel/syscalls/adjtimex/adjtimex03.c
@@ -33,13 +33,9 @@
 #include <sys/timex.h>
 #include "tst_test.h"
 
-#define SET_MODE (ADJ_OFFSET | ADJ_FREQUENCY | ADJ_MAXERROR | ADJ_ESTERROR | \
-		ADJ_STATUS | ADJ_TIMECONST | ADJ_TICK)
-
 #define ADJ_ADJTIME 0x8000
 #define LOOPS 10
 
-static struct timex *tim_save;
 static struct timex *buf;
 
 void verify_adjtimex(void)
@@ -54,7 +50,7 @@ void verify_adjtimex(void)
 		if ((TST_RET == -1) && (TST_ERR == EINVAL)) {
 			tst_res(TINFO,
 				"expecting adjtimex() to fail with EINVAL"
-				"with mode 0x%x", ADJ_ADJTIME);
+				" with mode 0x%x", ADJ_ADJTIME);
 		} else {
 			tst_brk(TBROK | TERRNO,
 					"adjtimex(): Unexpeceted error,"
@@ -75,38 +71,15 @@ void verify_adjtimex(void)
 		tst_res(TPASS, "Data leak not observed");
 }
 
-static void setup(void)
-{
-	tim_save->modes = 0;
-	/* Save current parameters */
-	if ((adjtimex(tim_save)) == -1) {
-		tst_brk(TBROK | TERRNO,
-				"adjtimex(): failed to save current params");
-	}
-}
-
-static void cleanup(void)
-{
-	tim_save->modes = SET_MODE;
-
-	/* Restore saved parameters */
-	if ((adjtimex(tim_save)) == -1)
-		tst_res(TWARN, "Failed to restore saved parameters");
-}

There is no point in saving and restoring anything if we pass invalid
mode.

 static struct tst_test test = {
-	.setup = setup,
-	.cleanup = cleanup,
-	.min_kver = "4.16.9",

Also we do not restrict regression test to any kernel version, this
would for example restrict the test from running on stable kernel trees
or distribution kernels where the fix should have been backported.

 	.test_all = verify_adjtimex,
 	.bufs = (struct tst_buffers []) {
 		{&buf, .size = sizeof(*buf)},
-		{&tim_save, .size = sizeof(*tim_save)},
 		{},
 	},
 	.tags = (const struct tst_tag[]) {
 		{"CVE", "2018-11508"},
-		{"linux-git", "3a4d44b61625"},
+		{"linux-git", "0a0b98734479"},

We put in the hash that fixed the problem, not the one that introduced
it. We do not track where bugs were introduced in LTP only where they
were fixed.

 		{},
 	}
 };

-- 
Cyril Hrubis
chrubis@suse.cz
