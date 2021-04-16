From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 16 Apr 2021 18:53:55 +0200
Subject: [LTP] [PATCH v4 2/2] commands: Add shell pipe test
In-Reply-To: <20210416165355.5160-1-pvorel@suse.cz>
References: <20210416165355.5160-1-pvorel@suse.cz>
Message-ID: <20210416165355.5160-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This adds basic shell pipe testing, which was removed from splice02
in 85cebe238 ("splice02: Generate input in C").

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v3->v4:
* Add missing Makefile

 runtest/commands                         |  1 +
 runtest/smoketest                        |  1 +
 testcases/commands/shell/Makefile        | 10 ++++++++++
 testcases/commands/shell/shell_pipe01.sh | 17 +++++++++++++++++
 4 files changed, 29 insertions(+)
 create mode 100644 testcases/commands/shell/Makefile
 create mode 100755 testcases/commands/shell/shell_pipe01.sh

diff --git a/runtest/commands b/runtest/commands
index 058266b54..8cfad0449 100644
--- a/runtest/commands
+++ b/runtest/commands
@@ -41,3 +41,4 @@ gdb01_sh gdb01.sh
 unshare01_sh unshare01.sh
 sysctl01_sh sysctl01.sh
 sysctl02_sh sysctl02.sh
+shell_test01 echo "SUCCESS" | shell_pipe01.sh
diff --git a/runtest/smoketest b/runtest/smoketest
index 2224d8f74..7f395936e 100644
--- a/runtest/smoketest
+++ b/runtest/smoketest
@@ -13,3 +13,4 @@ utime01A symlink01 -T utime01
 rename01A symlink01 -T rename01
 splice02 splice02 -s 20
 route4-change-dst route-change-dst.sh
+shell_test01 echo "SUCCESS" | shell_pipe01.sh
diff --git a/testcases/commands/shell/Makefile b/testcases/commands/shell/Makefile
new file mode 100644
index 000000000..c696ec35a
--- /dev/null
+++ b/testcases/commands/shell/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) Linux Test Project, 2021
+
+top_srcdir		?= ../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+
+INSTALL_TARGETS		:= *.sh
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/commands/shell/shell_pipe01.sh b/testcases/commands/shell/shell_pipe01.sh
new file mode 100755
index 000000000..3c8ef49fb
--- /dev/null
+++ b/testcases/commands/shell/shell_pipe01.sh
@@ -0,0 +1,17 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2021 Petr Vorel <pvorel@suse.cz>
+
+TST_TESTFUNC=do_test
+
+. tst_test.sh
+
+do_test()
+{
+	tst_res TINFO "expecting SUCCESS string passed from stdin"
+
+	read line
+	EXPECT_PASS [ "$line" = "SUCCESS" ]
+}
+
+tst_run
-- 
2.31.1

