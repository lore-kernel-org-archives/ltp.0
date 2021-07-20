From: Martin Doucha <mdoucha@suse.cz>
Date: Tue, 20 Jul 2021 12:39:40 +0200
Subject: [LTP] [PATCH 2/3] Replace existing lockdown checks with
 skip_in_lockdown
In-Reply-To: <20210720103941.9767-1-mdoucha@suse.cz>
References: <20210720103941.9767-1-mdoucha@suse.cz>
Message-ID: <20210720103941.9767-2-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 .../kernel/syscalls/delete_module/delete_module01.c    |  6 ++----
 .../kernel/syscalls/delete_module/delete_module03.c    |  6 ++----
 testcases/kernel/syscalls/ioperm/ioperm01.c            |  6 ++----
 testcases/kernel/syscalls/ioperm/ioperm02.c            |  6 ++----
 testcases/kernel/syscalls/iopl/iopl01.c                | 10 ++--------
 testcases/kernel/syscalls/iopl/iopl02.c                |  6 ++----
 6 files changed, 12 insertions(+), 28 deletions(-)

diff --git a/testcases/kernel/syscalls/delete_module/delete_module01.c b/testcases/kernel/syscalls/delete_module/delete_module01.c
index cec20c19c..c4f6978c1 100644
--- a/testcases/kernel/syscalls/delete_module/delete_module01.c
+++ b/testcases/kernel/syscalls/delete_module/delete_module01.c
@@ -25,10 +25,6 @@ static int module_loaded;
 
 static void do_delete_module(void)
 {
-	/* lockdown requires signed modules */
-	if (tst_lockdown_enabled())
-		tst_brk(TCONF, "Kernel is locked down, skip this test");
-
 	if (module_loaded == 0) {
 		tst_module_load(MODULE_NAME_KO, NULL);
 		module_loaded = 1;
@@ -53,6 +49,8 @@ static void cleanup(void)
 
 static struct tst_test test = {
 	.needs_root = 1,
+	/* lockdown requires signed modules */
+	.skip_in_lockdown = 1,
 	.cleanup = cleanup,
 	.test_all = do_delete_module,
 };
diff --git a/testcases/kernel/syscalls/delete_module/delete_module03.c b/testcases/kernel/syscalls/delete_module/delete_module03.c
index 56cef459f..863d36188 100644
--- a/testcases/kernel/syscalls/delete_module/delete_module03.c
+++ b/testcases/kernel/syscalls/delete_module/delete_module03.c
@@ -50,10 +50,6 @@ static void do_delete_module(void)
 
 static void setup(void)
 {
-	/* lockdown requires signed modules */
-	if (tst_lockdown_enabled())
-		tst_brk(TCONF, "Kernel is locked down, skip this test");
-
 	/* Load first kernel module */
 	tst_module_load(DUMMY_MOD_KO, NULL);
 	dummy_mod_loaded = 1;
@@ -76,6 +72,8 @@ static void cleanup(void)
 
 static struct tst_test test = {
 	.needs_root = 1,
+	/* lockdown requires signed modules */
+	.skip_in_lockdown = 1,
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = do_delete_module,
diff --git a/testcases/kernel/syscalls/ioperm/ioperm01.c b/testcases/kernel/syscalls/ioperm/ioperm01.c
index 6c50a0b75..8f2cc684d 100644
--- a/testcases/kernel/syscalls/ioperm/ioperm01.c
+++ b/testcases/kernel/syscalls/ioperm/ioperm01.c
@@ -42,10 +42,6 @@ static void verify_ioperm(void)
 
 static void setup(void)
 {
-	/* ioperm() is restricted under kernel lockdown. */
-	if (tst_lockdown_enabled())
-		tst_brk(TCONF, "Kernel is locked down, skip this test");
-
 	/*
 	 * The value of IO_BITMAP_BITS (include/asm-i386/processor.h) changed
 	 * from kernel 2.6.8 to permit 16-bits ioperm
@@ -70,6 +66,8 @@ static void cleanup(void)
 static struct tst_test test = {
 	.test_all = verify_ioperm,
 	.needs_root = 1,
+	/* ioperm() is restricted under kernel lockdown. */
+	.skip_in_lockdown = 1,
 	.setup = setup,
 	.cleanup = cleanup,
 };
diff --git a/testcases/kernel/syscalls/ioperm/ioperm02.c b/testcases/kernel/syscalls/ioperm/ioperm02.c
index 80dcb992e..33c501904 100644
--- a/testcases/kernel/syscalls/ioperm/ioperm02.c
+++ b/testcases/kernel/syscalls/ioperm/ioperm02.c
@@ -45,10 +45,6 @@ static struct tcase_t {
 
 static void setup(void)
 {
-	/* ioperm() is restricted under kernel lockdown. */
-	if (tst_lockdown_enabled())
-		tst_brk(TCONF, "Kernel is locked down, skip this test");
-
 	/*
 	 * The value of IO_BITMAP_BITS (include/asm-i386/processor.h) changed
 	 * from kernel 2.6.8 to permit 16-bits (65536) ioperm
@@ -92,6 +88,8 @@ static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(tcases),
 	.test = verify_ioperm,
 	.needs_root = 1,
+	/* ioperm() is restricted under kernel lockdown. */
+	.skip_in_lockdown = 1,
 	.setup = setup,
 	.cleanup = cleanup,
 };
diff --git a/testcases/kernel/syscalls/iopl/iopl01.c b/testcases/kernel/syscalls/iopl/iopl01.c
index dcf2cc406..70e2a7ff1 100644
--- a/testcases/kernel/syscalls/iopl/iopl01.c
+++ b/testcases/kernel/syscalls/iopl/iopl01.c
@@ -42,13 +42,6 @@ static void verify_iopl(void)
 	}
 }
 
-static void setup(void)
-{
-	/* iopl() is restricted under kernel lockdown. */
-	if (tst_lockdown_enabled())
-		tst_brk(TCONF, "Kernel is locked down, skip this test");
-}
-
 static void cleanup(void)
 {
 	/*
@@ -61,7 +54,8 @@ static void cleanup(void)
 static struct tst_test test = {
 	.test_all = verify_iopl,
 	.needs_root = 1,
-	.setup = setup,
+	/* iopl() is restricted under kernel lockdown. */
+	.skip_in_lockdown = 1,
 	.cleanup = cleanup,
 };
 
diff --git a/testcases/kernel/syscalls/iopl/iopl02.c b/testcases/kernel/syscalls/iopl/iopl02.c
index a6135ddf3..7301442f9 100644
--- a/testcases/kernel/syscalls/iopl/iopl02.c
+++ b/testcases/kernel/syscalls/iopl/iopl02.c
@@ -53,10 +53,6 @@ static void setup(void)
 {
 	struct passwd *pw;
 
-	/* iopl() is restricted under kernel lockdown. */
-	if (tst_lockdown_enabled())
-		tst_brk(TCONF, "Kernel is locked down, skip this test");
-
 	pw = SAFE_GETPWNAM("nobody");
 	SAFE_SETEUID(pw->pw_uid);
 }
@@ -70,6 +66,8 @@ static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(tcases),
 	.test = verify_iopl,
 	.needs_root = 1,
+	/* iopl() is restricted under kernel lockdown. */
+	.skip_in_lockdown = 1,
 	.setup = setup,
 	.cleanup = cleanup,
 };
-- 
2.32.0

