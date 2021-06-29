From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 29 Jun 2021 08:58:36 +0200
Subject: [LTP] [PATCH 1/1] delete_module0{1,
 3}: Skip when kernel is locked down
Message-ID: <20210629065836.20932-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Lockdown requires signed modules, otherwise tests fails with EPERM.
TCONF until we solve signing modules in LTP build.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/syscalls/delete_module/delete_module01.c | 4 ++++
 testcases/kernel/syscalls/delete_module/delete_module03.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/testcases/kernel/syscalls/delete_module/delete_module01.c b/testcases/kernel/syscalls/delete_module/delete_module01.c
index 8fb559f0c..cec20c19c 100644
--- a/testcases/kernel/syscalls/delete_module/delete_module01.c
+++ b/testcases/kernel/syscalls/delete_module/delete_module01.c
@@ -25,6 +25,10 @@ static int module_loaded;
 
 static void do_delete_module(void)
 {
+	/* lockdown requires signed modules */
+	if (tst_lockdown_enabled())
+		tst_brk(TCONF, "Kernel is locked down, skip this test");
+
 	if (module_loaded == 0) {
 		tst_module_load(MODULE_NAME_KO, NULL);
 		module_loaded = 1;
diff --git a/testcases/kernel/syscalls/delete_module/delete_module03.c b/testcases/kernel/syscalls/delete_module/delete_module03.c
index 7178e8ef1..56cef459f 100644
--- a/testcases/kernel/syscalls/delete_module/delete_module03.c
+++ b/testcases/kernel/syscalls/delete_module/delete_module03.c
@@ -50,6 +50,10 @@ static void do_delete_module(void)
 
 static void setup(void)
 {
+	/* lockdown requires signed modules */
+	if (tst_lockdown_enabled())
+		tst_brk(TCONF, "Kernel is locked down, skip this test");
+
 	/* Load first kernel module */
 	tst_module_load(DUMMY_MOD_KO, NULL);
 	dummy_mod_loaded = 1;
-- 
2.32.0

