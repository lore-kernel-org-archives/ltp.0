From: Mason <slash.tmp@free.fr>
Date: Fri, 25 Mar 2016 15:53:44 +0100
Subject: [LTP] [PATCH] delete_module: export license information
Message-ID: <56F550F8.3000609@free.fr>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Export license information to avoid kernel taint.

	dummy_del_mod: module license 'unspecified' taints kernel.
	Disabling lock debugging due to kernel taint
---
 testcases/kernel/module/delete_module/dummy_del_mod.c     | 1 +
 testcases/kernel/module/delete_module/dummy_del_mod_dep.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/testcases/kernel/module/delete_module/dummy_del_mod.c b/testcases/kernel/module/delete_module/dummy_del_mod.c
index dfda0e333f46..10932d0aa959 100644
--- a/testcases/kernel/module/delete_module/dummy_del_mod.c
+++ b/testcases/kernel/module/delete_module/dummy_del_mod.c
@@ -61,3 +61,4 @@ static void __exit dummy_exit(void)
 module_init(dummy_init);
 module_exit(dummy_exit);
 EXPORT_SYMBOL(dummy_func_test);
+MODULE_LICENSE("GPL");
diff --git a/testcases/kernel/module/delete_module/dummy_del_mod_dep.c b/testcases/kernel/module/delete_module/dummy_del_mod_dep.c
index a15b2ea5d7c0..c9f60e3cde9e 100644
--- a/testcases/kernel/module/delete_module/dummy_del_mod_dep.c
+++ b/testcases/kernel/module/delete_module/dummy_del_mod_dep.c
@@ -53,3 +53,4 @@ static void __exit dummy_exit(void)
 
 module_init(dummy_init);
 module_exit(dummy_exit);
+MODULE_LICENSE("GPL");
-- 
2.7.0

