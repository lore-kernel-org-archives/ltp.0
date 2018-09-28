From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 28 Sep 2018 16:52:16 +0800
Subject: [LTP] [PATCH 2/2] delete_module*: Cleanup && Move to kernel/syscalls
In-Reply-To: <1538124736-1183-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1538124736-1183-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <1538124736-1183-2-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1) Convert to new API && Cleanup
2) Move delete_module* tests to kernel/syscalls

Fix: #380

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 runtest/modules                                    |   5 -
 runtest/syscalls                                   |   4 +
 scenario_groups/default                            |   1 -
 testcases/kernel/Makefile                          |   1 -
 testcases/kernel/module/Makefile                   |  30 ----
 testcases/kernel/module/delete_module/.gitignore   |   5 -
 testcases/kernel/module/delete_module/Makefile     |  40 ------
 .../kernel/module/delete_module/delete_module01.c  |  89 ------------
 .../kernel/module/delete_module/delete_module02.c  | 155 ---------------------
 .../kernel/module/delete_module/delete_module03.c  | 118 ----------------
 .../kernel/module/delete_module/dummy_del_mod.c    |  64 ---------
 .../module/delete_module/dummy_del_mod_dep.c       |  56 --------
 testcases/kernel/syscalls/delete_module/.gitignore |   5 +
 testcases/kernel/syscalls/delete_module/Makefile   |  25 ++++
 .../syscalls/delete_module/delete_module01.c       |  54 +++++++
 .../syscalls/delete_module/delete_module02.c       |  96 +++++++++++++
 .../syscalls/delete_module/delete_module03.c       |  78 +++++++++++
 .../kernel/syscalls/delete_module/dummy_del_mod.c  |  41 ++++++
 .../syscalls/delete_module/dummy_del_mod_dep.c     |  37 +++++
 19 files changed, 340 insertions(+), 564 deletions(-)
 delete mode 100644 runtest/modules
 delete mode 100644 testcases/kernel/module/Makefile
 delete mode 100644 testcases/kernel/module/delete_module/.gitignore
 delete mode 100644 testcases/kernel/module/delete_module/Makefile
 delete mode 100644 testcases/kernel/module/delete_module/delete_module01.c
 delete mode 100644 testcases/kernel/module/delete_module/delete_module02.c
 delete mode 100644 testcases/kernel/module/delete_module/delete_module03.c
 delete mode 100644 testcases/kernel/module/delete_module/dummy_del_mod.c
 delete mode 100644 testcases/kernel/module/delete_module/dummy_del_mod_dep.c
 create mode 100644 testcases/kernel/syscalls/delete_module/.gitignore
 create mode 100644 testcases/kernel/syscalls/delete_module/Makefile
 create mode 100644 testcases/kernel/syscalls/delete_module/delete_module01.c
 create mode 100644 testcases/kernel/syscalls/delete_module/delete_module02.c
 create mode 100644 testcases/kernel/syscalls/delete_module/delete_module03.c
 create mode 100644 testcases/kernel/syscalls/delete_module/dummy_del_mod.c
 create mode 100644 testcases/kernel/syscalls/delete_module/dummy_del_mod_dep.c

diff --git a/runtest/modules b/runtest/modules
deleted file mode 100644
index 0f1ba52..0000000
--- a/runtest/modules
+++ /dev/null
@@ -1,5 +0,0 @@
-#DESCRIPTION:2.6.x kernel module tests
-delete_module01 delete_module01
-delete_module02 delete_module02
-delete_module03 delete_module03
-
diff --git a/runtest/syscalls b/runtest/syscalls
index 0d0be77..2416f80 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -105,6 +105,10 @@ creat06 creat06
 creat07 creat07
 creat08 creat08
 
+delete_module01 delete_module01
+delete_module02 delete_module02
+delete_module03 delete_module03
+
 dup01 dup01
 dup02 dup02
 dup03 dup03
diff --git a/scenario_groups/default b/scenario_groups/default
index 5658a61..9d7d3c3 100644
--- a/scenario_groups/default
+++ b/scenario_groups/default
@@ -25,7 +25,6 @@ hugetlb
 commands
 hyperthreading
 kernel_misc
-modules
 fs_ext4
 pipes
 can
diff --git a/testcases/kernel/Makefile b/testcases/kernel/Makefile
index 5acc9b8..39d79c7 100644
--- a/testcases/kernel/Makefile
+++ b/testcases/kernel/Makefile
@@ -54,7 +54,6 @@ SUBDIRS			+= connectors \
 			   security \
 			   timers \
 			   tracing \
-			   module \
 
 ifeq ($(WITH_POWER_MANAGEMENT_TESTSUITE),yes)
 SUBDIRS			+= power_management
diff --git a/testcases/kernel/module/Makefile b/testcases/kernel/module/Makefile
deleted file mode 100644
index cc2a0e0..0000000
--- a/testcases/kernel/module/Makefile
+++ /dev/null
@@ -1,30 +0,0 @@
-#
-#    kernel/module test suite Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Ngie Cooper, July 2009
-#
-
-top_srcdir	?= ../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-# Only delete_module works at this time...
-SUBDIRS		:= delete_module
-
-include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/kernel/module/delete_module/.gitignore b/testcases/kernel/module/delete_module/.gitignore
deleted file mode 100644
index 8ffd425..0000000
--- a/testcases/kernel/module/delete_module/.gitignore
+++ /dev/null
@@ -1,5 +0,0 @@
-/delete_module01
-/delete_module02
-/delete_module03
-/dummy_del_mod.ko
-/dummy_del_mod_dep.ko
diff --git a/testcases/kernel/module/delete_module/Makefile b/testcases/kernel/module/delete_module/Makefile
deleted file mode 100644
index 95693b1..0000000
--- a/testcases/kernel/module/delete_module/Makefile
+++ /dev/null
@@ -1,40 +0,0 @@
-#
-# Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
-#
-# This program is free software; you can redistribute it and/or modify it
-# under the terms of version 2 of the GNU General Public License as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it would be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-###########################################################################
-# name of file		 : Makefile		 		 	  #
-# description		 : make file for the delete_module(2) testcases	  #
-###########################################################################
-
-ifneq ($(KERNELRELEASE),)
-
-obj-m := dummy_del_mod.o dummy_del_mod_dep.o
-
-else
-
-top_srcdir		?= ../../../..
-
-include $(top_srcdir)/include/mk/testcases.mk
-
-REQ_VERSION_MAJOR	:= 2
-REQ_VERSION_PATCH	:= 6
-
-MAKE_TARGETS		:= delete_module01 delete_module02 delete_module03 \
-			   dummy_del_mod.ko dummy_del_mod_dep.ko
-
-include $(top_srcdir)/include/mk/module.mk
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
-
-endif
diff --git a/testcases/kernel/module/delete_module/delete_module01.c b/testcases/kernel/module/delete_module/delete_module01.c
deleted file mode 100644
index a159de8..0000000
--- a/testcases/kernel/module/delete_module/delete_module01.c
+++ /dev/null
@@ -1,89 +0,0 @@
-/*
- * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
- */
-
-/*
- *    AUTHOR: Madhu T L <madhu.tarikere@wipro.com>
- *
- *    DESCRIPTION:
- *    	Basic tests for delete_module(2)
- *    	1) insmod dummy_del_mod.ko
- *    	2) call delete_module(2) to remove dummy_del_mod.ko
- */
-
-#include <errno.h>
-#include "test.h"
-#include "old_module.h"
-#include "safe_macros.h"
-#include "lapi/syscalls.h"
-
-#define MODULE_NAME	"dummy_del_mod"
-#define MODULE_NAME_KO	"dummy_del_mod.ko"
-
-static void setup(void);
-static void cleanup(void);
-
-
-char *TCID = "delete_module01";
-int TST_TOTAL = 1;
-static int module_loaded;
-
-int main(int argc, char **argv)
-{
-	int lc;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		/* insert dummy_del_mod.ko */
-		if (module_loaded == 0) {
-			tst_module_load(NULL, MODULE_NAME_KO, NULL);
-			module_loaded = 1;
-		}
-
-		TEST(ltp_syscall(__NR_delete_module, MODULE_NAME, 0));
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL | TTERRNO, "delete_module() failed to "
-				 "remove module entry for %s ", MODULE_NAME);
-		} else {
-			tst_resm(TPASS, "delete_module() successful");
-			module_loaded = 0;
-		}
-
-	}
-
-	cleanup();
-	tst_exit();
-}
-
-static void setup(void)
-{
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	tst_require_root();
-
-	TEST_PAUSE;
-}
-
-static void cleanup(void)
-{
-	if (module_loaded == 1)
-		tst_module_unload(NULL, MODULE_NAME_KO);
-}
diff --git a/testcases/kernel/module/delete_module/delete_module02.c b/testcases/kernel/module/delete_module/delete_module02.c
deleted file mode 100644
index f92639e..0000000
--- a/testcases/kernel/module/delete_module/delete_module02.c
+++ /dev/null
@@ -1,155 +0,0 @@
-/*
- * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
- */
-
-/*
- *    AUTHOR: Madhu T L <madhu.tarikere@wipro.com>
- *
- *    DESCRIPTION
- *      Verify that,
- *      1. delete_module(2) returns -1 and sets errno to ENOENT for nonexistent
- *	   module entry.
- *      2. delete_module(2) returns -1 and sets errno to EFAULT, if
- *         module name parameter is outside program's accessible address space.
- *      3. delete_module(2) returns -1 and sets errno to EPERM, if effective
- *         user id of the caller is not superuser.
- */
-
-#include <errno.h>
-#include <pwd.h>
-#include <sys/types.h>
-#include <unistd.h>
-#include <limits.h>
-
-#include <sys/mman.h>
-#include "test.h"
-#include "safe_macros.h"
-#include "lapi/syscalls.h"
-
-#define NULLMODNAME	""
-#define BASEMODNAME	"dummy"
-#define LONGMODNAMECHAR	'm'	/* Arbitrarily selected */
-
-/*
- * From kernel internal headers: include/linux/module.h
- * include/linux/moduleparam.h
- */
-#define MODULE_NAME_LEN	( 64 - sizeof(unsigned long) )
-
-char *TCID = "delete_module02";
-
-static char nobody_uid[] = "nobody";
-struct passwd *ltpuser;
-static char longmodname[MODULE_NAME_LEN];
-static char modname[20];
-
-static void setup(void);
-static void cleanup(void);
-static void setup1(void);
-static void cleanup1(void);
-
-static struct test_case_t {
-	char *modname;
-	int experrno;
-	char *desc;
-	void (*setup) (void);
-	void (*cleanup) (void);
-} tdat[] = {
-	{ modname, ENOENT, "nonexistent module", NULL, NULL},
-	{ NULLMODNAME, ENOENT, "null terminated module name", NULL, NULL},
-	{ (char *)-1, EFAULT, "module name outside program's "
-	  "accessible address space", NULL, NULL},
-	{ longmodname, ENOENT, "long module name", NULL, NULL},
-	{ modname, EPERM, "non-superuser", setup1, cleanup1},
-};
-
-int TST_TOTAL = ARRAY_SIZE(tdat);
-
-int main(int argc, char **argv)
-{
-	int lc;
-	int i;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		for (i = 0; i < TST_TOTAL; ++i) {
-			if (tdat[i].setup)
-				tdat[i].setup();
-
-			tst_resm(TINFO, "test %s", tdat[i].desc);
-			TEST(ltp_syscall(__NR_delete_module,
-			     tdat[i].modname, 0));
-
-			if (TEST_RETURN != -1) {
-				tst_resm(TFAIL, "delete_module() "
-					 "succeeded unexpectedly");
-			} else if (TEST_ERRNO == tdat[i].experrno) {
-				tst_resm(TPASS | TTERRNO,
-					 "delete_module() failed as expected");
-			} else {
-				tst_resm(TFAIL | TTERRNO, "delete_module() "
-					 "failed unexpectedly; expected: "
-					 "%d - %s", tdat[i].experrno,
-					 strerror(tdat[i].experrno));
-			}
-			if (tdat[i].cleanup)
-				tdat[i].cleanup();
-		}
-	}
-
-	cleanup();
-	tst_exit();
-}
-
-static void setup1(void)
-{
-	SAFE_SETEUID(cleanup, ltpuser->pw_uid);
-}
-
-static void cleanup1(void)
-{
-	SAFE_SETEUID(cleanup, 0);
-}
-
-static void setup(void)
-{
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	tst_require_root();
-
-	ltpuser = SAFE_GETPWNAM(cleanup, nobody_uid);
-
-	TEST_PAUSE;
-
-	/* Initialize longmodname to LONGMODNAMECHAR character */
-	memset(longmodname, LONGMODNAMECHAR, MODULE_NAME_LEN - 1);
-
-	/* Get unique module name for each child process */
-	if (sprintf(modname, "%s_%d", BASEMODNAME, getpid()) <= 0)
-		tst_brkm(TBROK, NULL, "Failed to initialize module name");
-
-	tdat[2].modname = SAFE_MMAP(cleanup, 0, 1, PROT_NONE,
-				    MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
-}
-
-void cleanup(void)
-{
-}
diff --git a/testcases/kernel/module/delete_module/delete_module03.c b/testcases/kernel/module/delete_module/delete_module03.c
deleted file mode 100644
index cbf9ff6..0000000
--- a/testcases/kernel/module/delete_module/delete_module03.c
+++ /dev/null
@@ -1,118 +0,0 @@
-/*
- * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
- */
-
-/*
- *    AUTHOR: Madhu T L <madhu.tarikere@wipro.com>
- *
- *    DESCRIPTION
- *      Verify that, delete_module(2) returns -1 and sets errno to EWOULDBLOCK,
- *      if tried to remove a module while other modules depend on this module.
- *
- */
-
-#include <errno.h>
-#include "test.h"
-#include "old_module.h"
-#include "safe_macros.h"
-#include "lapi/syscalls.h"
-
-#define DUMMY_MOD		"dummy_del_mod"
-#define DUMMY_MOD_KO		"dummy_del_mod.ko"
-#define DUMMY_MOD_DEP		"dummy_del_mod_dep"
-#define DUMMY_MOD_DEP_KO	"dummy_del_mod_dep.ko"
-
-static int dummy_mod_loaded;
-static int dummy_mod_dep_loaded;
-
-char *TCID = "delete_module03";
-
-int TST_TOTAL = 1;
-
-static void setup();
-static void cleanup(void);
-
-int main(int argc, char **argv)
-{
-	int lc;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		TEST(ltp_syscall(__NR_delete_module, DUMMY_MOD, 0));
-
-		if (TEST_RETURN < 0) {
-			switch (errno) {
-			case EWOULDBLOCK:
-				tst_resm(TPASS | TTERRNO,
-					 "delete_module() failed as expected");
-			break;
-			default:
-				tst_resm(TFAIL | TTERRNO, "delete_module() "
-					 "failed unexpectedly; expected: "
-					 "%d - %s", EWOULDBLOCK,
-					 strerror(EWOULDBLOCK));
-			break;
-			}
-		} else {
-			tst_resm(TFAIL, "delete_module()"
-				 "succeeded unexpectedly");
-			dummy_mod_loaded = 0;
-			/*
-			 * insmod DUMMY_MOD_KO again in case running
-			 * with -i option
-			 */
-			tst_module_load(cleanup, DUMMY_MOD_KO, NULL);
-			dummy_mod_loaded = 1;
-		}
-	}
-
-	cleanup();
-	tst_exit();
-
-}
-
-static void setup(void)
-{
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	tst_require_root();
-
-	/* Load first kernel module */
-	tst_module_load(cleanup, DUMMY_MOD_KO, NULL);
-	dummy_mod_loaded = 1;
-
-	/* Load dependant kernel module */
-	tst_module_load(cleanup, DUMMY_MOD_DEP_KO, NULL);
-	dummy_mod_dep_loaded = 1;
-
-	TEST_PAUSE;
-}
-
-static void cleanup(void)
-{
-	/* Unload dependent kernel module */
-	if (dummy_mod_dep_loaded == 1)
-		tst_module_unload(NULL, DUMMY_MOD_DEP_KO);
-
-	/* Unload first kernel module */
-	if (dummy_mod_loaded == 1)
-		tst_module_unload(NULL, DUMMY_MOD_KO);
-}
diff --git a/testcases/kernel/module/delete_module/dummy_del_mod.c b/testcases/kernel/module/delete_module/dummy_del_mod.c
deleted file mode 100644
index 10932d0..0000000
--- a/testcases/kernel/module/delete_module/dummy_del_mod.c
+++ /dev/null
@@ -1,64 +0,0 @@
-/*
- * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
- */
-/*************************************************************************
- * Description: This is a kernel loadable module programme used by
- *		delete_module03 testcase which inserts this module as part
- *		setup.
- *************************************************************************/
-
-#ifndef MODULE
-#define MODULE
-#endif
-
-/* #define __KERNEL__    Commented this line out b/c it causes errors with
- *			 module.h when it calls /usr/include/linux/version.h
- *			 -11/22/02 Robbie Williamson <robbiew@us.ibm.com>
- */
-
-#include <asm/atomic.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/proc_fs.h>
-#include <linux/kernel.h>
-
-static int dummy_func_test(void);
-
-/* Dummy function called by dependent module */
-
-static int dummy_func_test()
-{
-	return 0;
-}
-
-static int __init dummy_init(void)
-{
-	struct proc_dir_entry *proc_dummy;
-
-	proc_dummy = proc_mkdir("dummy", 0);
-	return 0;
-}
-
-static void __exit dummy_exit(void)
-{
-
-	remove_proc_entry("dummy", 0);
-}
-
-module_init(dummy_init);
-module_exit(dummy_exit);
-EXPORT_SYMBOL(dummy_func_test);
-MODULE_LICENSE("GPL");
diff --git a/testcases/kernel/module/delete_module/dummy_del_mod_dep.c b/testcases/kernel/module/delete_module/dummy_del_mod_dep.c
deleted file mode 100644
index c9f60e3..0000000
--- a/testcases/kernel/module/delete_module/dummy_del_mod_dep.c
+++ /dev/null
@@ -1,56 +0,0 @@
-/*
- * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
- */
-/*************************************************************************
- * Description: This is a kernel loadable module programme used by
- *		delete_module03 testcase which inserts this module as part
- *		of setup. This module has dependency on dummy_del_mod module
- *		(calls function of dummy_del_mod during initialization).
- *************************************************************************/
-
-#ifndef MODULE
-#define MODULE
-#endif
-/* #define __KERNEL__    Commented this line out b/c it causes errors with
- *                       module.h when it calls /usr/include/linux/version.h
- *                       -11/22/02 Robbie Williamson <robbiew@us.ibm.com>
- */
-
-#include <asm/atomic.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/proc_fs.h>
-#include <linux/kernel.h>
-
-extern int dummy_func_test(void);
-
-static int __init dummy_init(void)
-{
-	struct proc_dir_entry *proc_dummy;
-
-	proc_dummy = proc_mkdir("dummy_dep", 0);
-	dummy_func_test();
-	return 0;
-}
-
-static void __exit dummy_exit(void)
-{
-	remove_proc_entry("dummy_dep", 0);
-}
-
-module_init(dummy_init);
-module_exit(dummy_exit);
-MODULE_LICENSE("GPL");
diff --git a/testcases/kernel/syscalls/delete_module/.gitignore b/testcases/kernel/syscalls/delete_module/.gitignore
new file mode 100644
index 0000000..8ffd425
--- /dev/null
+++ b/testcases/kernel/syscalls/delete_module/.gitignore
@@ -0,0 +1,5 @@
+/delete_module01
+/delete_module02
+/delete_module03
+/dummy_del_mod.ko
+/dummy_del_mod_dep.ko
diff --git a/testcases/kernel/syscalls/delete_module/Makefile b/testcases/kernel/syscalls/delete_module/Makefile
new file mode 100644
index 0000000..b98dcd3
--- /dev/null
+++ b/testcases/kernel/syscalls/delete_module/Makefile
@@ -0,0 +1,25 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
+# Copyright (c) 2018 Xiao Yang <yangx.jy@cn.fujitsu.com>
+#
+
+ifneq ($(KERNELRELEASE),)
+
+obj-m := dummy_del_mod.o dummy_del_mod_dep.o
+
+else
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+REQ_VERSION_MAJOR	:= 2
+REQ_VERSION_PATCH	:= 6
+
+MAKE_TARGETS		:= delete_module01 delete_module02 delete_module03 \
+			   dummy_del_mod.ko dummy_del_mod_dep.ko
+
+include $(top_srcdir)/include/mk/module.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
+
+endif
diff --git a/testcases/kernel/syscalls/delete_module/delete_module01.c b/testcases/kernel/syscalls/delete_module/delete_module01.c
new file mode 100644
index 0000000..e5cb53c
--- /dev/null
+++ b/testcases/kernel/syscalls/delete_module/delete_module01.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
+ * Copyright (c) 2018 Xiao Yang <yangx.jy@cn.fujitsu.com>
+ */
+
+/*
+ * AUTHOR: Madhu T L <madhu.tarikere@wipro.com>
+ *
+ * DESCRIPTION:
+ * Basic tests for delete_module(2)
+ * 1) insmod dummy_del_mod.ko
+ * 2) call delete_module(2) to remove dummy_del_mod.ko
+ */
+
+#include <errno.h>
+#include "old_module.h"
+#include "lapi/syscalls.h"
+#include "tst_test.h"
+
+#define MODULE_NAME	"dummy_del_mod"
+#define MODULE_NAME_KO	"dummy_del_mod.ko"
+
+static int module_loaded;
+
+static void do_delete_module(void)
+{
+	if (module_loaded == 0) {
+		tst_module_load(NULL, MODULE_NAME_KO, NULL);
+		module_loaded = 1;
+	}
+
+	TEST(tst_syscall(__NR_delete_module, MODULE_NAME, 0));
+	if (TST_RET == -1) {
+		tst_res(TFAIL | TTERRNO, "delete_module() failed to "
+			"remove module entry for %s ", MODULE_NAME);
+		return;
+	}
+
+	tst_res(TPASS, "delete_module() successful");
+	module_loaded = 0;
+}
+
+static void cleanup(void)
+{
+	if (module_loaded == 1)
+		tst_module_unload(NULL, MODULE_NAME_KO);
+}
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.cleanup = cleanup,
+	.test_all = do_delete_module,
+};
diff --git a/testcases/kernel/syscalls/delete_module/delete_module02.c b/testcases/kernel/syscalls/delete_module/delete_module02.c
new file mode 100644
index 0000000..f52239f
--- /dev/null
+++ b/testcases/kernel/syscalls/delete_module/delete_module02.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
+ * Copyright (c) 2018 Xiao Yang <yangx.jy@cn.fujitsu.com>
+ */
+
+/*
+ * AUTHOR: Madhu T L <madhu.tarikere@wipro.com>
+ *
+ * DESCRIPTION
+ * Verify that,
+ * 1. delete_module(2) returns -1 and sets errno to ENOENT for nonexistent
+ *    module entry.
+ * 2. delete_module(2) returns -1 and sets errno to EFAULT, if
+ *    module name parameter is outside program's accessible address space.
+ * 3. delete_module(2) returns -1 and sets errno to EPERM, if effective
+ *    user id of the caller is not superuser.
+ */
+
+#include <errno.h>
+#include <pwd.h>
+#include <stdio.h>
+#include <string.h>
+
+#include "tst_test.h"
+#include "lapi/syscalls.h"
+
+#define BASEMODNAME	"dummy"
+#define LONGMODNAMECHAR	'm'
+
+/*
+ * From kernel internal headers: include/linux/module.h
+ * include/linux/moduleparam.h
+ */
+#define MODULE_NAME_LEN	(64 - sizeof(unsigned long))
+
+static struct passwd *ltpuser;
+static char longmodname[MODULE_NAME_LEN];
+static char modname[20];
+
+static struct test_case_t {
+	char *modname;
+	int experrno;
+	char *desc;
+	/* 1: nobody_user 0: root_user */
+	int nobody_user;
+} tdat[] = {
+	{ modname, ENOENT, "nonexistent module", 0},
+	{ "", ENOENT, "null terminated module name", 0},
+	{ NULL, EFAULT, "module name outside program's accessible address space", 0},
+	{ longmodname, ENOENT, "long module name", 0},
+	{ modname, EPERM, "non-superuser", 1},
+};
+
+static void do_delete_module(unsigned int n)
+{
+	struct test_case_t *tc = &tdat[n];
+
+	if (!tc->modname)
+		tc->modname = tst_get_bad_addr(NULL);
+
+	if (tc->nobody_user)
+		SAFE_SETEUID(ltpuser->pw_uid);
+
+	tst_res(TINFO, "test %s", tc->desc);
+	TEST(tst_syscall(__NR_delete_module, tc->modname, 0));
+	if (TST_RET != -1) {
+		tst_res(TFAIL, "delete_module() succeeded unexpectedly");
+	} else if (TST_ERR == tc->experrno) {
+		tst_res(TPASS | TTERRNO, "delete_module() failed as expected");
+	} else {
+		tst_res(TFAIL | TTERRNO, "delete_module() failed unexpectedly;"
+			" expected: %s", tst_strerrno(tc->experrno));
+	}
+
+	if (tc->nobody_user)
+		SAFE_SETEUID(0);
+}
+
+static void setup(void)
+{
+	ltpuser = SAFE_GETPWNAM("nobody");
+
+	/* Initialize longmodname to LONGMODNAMECHAR character */
+	memset(longmodname, LONGMODNAMECHAR, MODULE_NAME_LEN - 1);
+
+	/* Get unique module name for each child process */
+	sprintf(modname, "%s_%d", BASEMODNAME, getpid());
+}
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tdat),
+	.needs_root = 1,
+	.setup = setup,
+	.test = do_delete_module,
+};
diff --git a/testcases/kernel/syscalls/delete_module/delete_module03.c b/testcases/kernel/syscalls/delete_module/delete_module03.c
new file mode 100644
index 0000000..8bd51be
--- /dev/null
+++ b/testcases/kernel/syscalls/delete_module/delete_module03.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
+ * Copyright (c) 2018 Xiao Yang <yangx.jy@cn.fujitsu.com>
+ */
+
+/*
+ * AUTHOR: Madhu T L <madhu.tarikere@wipro.com>
+ *
+ * DESCRIPTION
+ * Verify that, delete_module(2) returns -1 and sets errno to EWOULDBLOCK,
+ * if tried to remove a module while other modules depend on this module.
+ */
+
+#include <errno.h>
+#include "tst_test.h"
+#include "old_module.h"
+#include "lapi/syscalls.h"
+
+#define DUMMY_MOD		"dummy_del_mod"
+#define DUMMY_MOD_KO		"dummy_del_mod.ko"
+#define DUMMY_MOD_DEP_KO	"dummy_del_mod_dep.ko"
+
+static int dummy_mod_loaded;
+static int dummy_mod_dep_loaded;
+
+static void do_delete_module(void)
+{
+	TEST(tst_syscall(__NR_delete_module, DUMMY_MOD, 0));
+	if (TST_RET < 0) {
+		if (TST_ERR == EWOULDBLOCK) {
+			tst_res(TPASS | TTERRNO,
+				"delete_module() failed as expected");
+		} else {
+			tst_res(TFAIL | TTERRNO, "delete_module() failed "
+			"unexpectedly; expected: %s",
+			tst_strerrno(EWOULDBLOCK));
+		}
+	} else {
+		tst_res(TFAIL, "delete_module() succeeded unexpectedly");
+		dummy_mod_loaded = 0;
+		/*
+		 * insmod DUMMY_MOD_KO again in case running
+		 * with -i option
+		 */
+		tst_module_load(NULL, DUMMY_MOD_KO, NULL);
+		dummy_mod_loaded = 1;
+	}
+}
+
+static void setup(void)
+{
+	/* Load first kernel module */
+	tst_module_load(NULL, DUMMY_MOD_KO, NULL);
+	dummy_mod_loaded = 1;
+
+	/* Load dependant kernel module */
+	tst_module_load(NULL, DUMMY_MOD_DEP_KO, NULL);
+	dummy_mod_dep_loaded = 1;
+}
+
+static void cleanup(void)
+{
+	/* Unload dependent kernel module */
+	if (dummy_mod_dep_loaded == 1)
+		tst_module_unload(NULL, DUMMY_MOD_DEP_KO);
+
+	/* Unload first kernel module */
+	if (dummy_mod_loaded == 1)
+		tst_module_unload(NULL, DUMMY_MOD_KO);
+}
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = do_delete_module,
+};
diff --git a/testcases/kernel/syscalls/delete_module/dummy_del_mod.c b/testcases/kernel/syscalls/delete_module/dummy_del_mod.c
new file mode 100644
index 0000000..04a0b32
--- /dev/null
+++ b/testcases/kernel/syscalls/delete_module/dummy_del_mod.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
+ * Copyright (c) 2018 Xiao Yang <yangx.jy@cn.fujitsu.com>
+ */
+/*
+ * Description:
+ * This is a kernel loadable module programme used by delete_module*
+ * testcases which insert this module as part setup.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/proc_fs.h>
+#include <linux/kernel.h>
+
+static int dummy_func_test(void);
+
+/* Dummy function called by dependent module */
+int dummy_func_test(void)
+{
+	return 0;
+}
+EXPORT_SYMBOL(dummy_func_test);
+
+static int __init dummy_init(void)
+{
+	struct proc_dir_entry *proc_dummy;
+
+	proc_dummy = proc_mkdir("dummy", 0);
+	return 0;
+}
+
+static void __exit dummy_exit(void)
+{
+	remove_proc_entry("dummy", 0);
+}
+
+module_init(dummy_init);
+module_exit(dummy_exit);
+MODULE_LICENSE("GPL");
diff --git a/testcases/kernel/syscalls/delete_module/dummy_del_mod_dep.c b/testcases/kernel/syscalls/delete_module/dummy_del_mod_dep.c
new file mode 100644
index 0000000..85b3279
--- /dev/null
+++ b/testcases/kernel/syscalls/delete_module/dummy_del_mod_dep.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
+ * Copyright (c) 2018 Xiao Yang <yangx.jy@cn.fujitsu.com>
+ */
+/*
+ * Description:
+ * This is a kernel loadable module programme used by delete_module03
+ * testcase which inserts this module as part of setup. This module
+ * has dependency on dummy_del_mod module (calls function of dummy_del_mod
+ * during initialization).
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/proc_fs.h>
+#include <linux/kernel.h>
+
+extern int dummy_func_test(void);
+
+static int __init dummy_init(void)
+{
+	struct proc_dir_entry *proc_dummy;
+
+	proc_dummy = proc_mkdir("dummy_dep", 0);
+	dummy_func_test();
+	return 0;
+}
+
+static void __exit dummy_exit(void)
+{
+	remove_proc_entry("dummy_dep", 0);
+}
+
+module_init(dummy_init);
+module_exit(dummy_exit);
+MODULE_LICENSE("GPL");
-- 
1.8.3.1



