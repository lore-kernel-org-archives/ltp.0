From: vkabatov@redhat.com <vkabatov@redhat.com>
Date: Wed,  9 Aug 2017 16:39:34 +0200
Subject: [LTP] [PATCH v3] [vma] Add regression tests for vsyscall and vdso
Message-ID: <20170809143934.2875-1-vkabatov@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Veronika Kabatova <vkabatov@redhat.com>

Test checks if vsyscall and vdso VMAs are reported correctly. vsyscall
range and permissions were fixed with kernel commit 103efcd9aac1 ("fix
perms/range of vsyscall vma in /proc/*/maps"). While some newer systems
run with CONFIG_LEGACY_VSYSCALL_NONE, this test may serve to find
regressions on systems still running with vsyscalls.

Second part of the test checks regression of vdso permissions bug
(fixed with b6558c4a2378 ("fix [vdso] page permissions") and
e5b97dde514f ("add VM_ALWAYSDUMP")). As a consequence of this bug, vdso
pages were not included in core dumps which caused incomplete
backtraces:

    Program terminated with signal 11, Segmentation fault.
    #0  0x005f0402 in ?? ()

    Thread 1 (process 14859):
    #0  0x005f0402 in ?? ()
    #1  0x00336366 in ?? () from /lib/i686/nosegneg/libc.so.6
    #2  0x0804845f in handle_alrm (signo=14) at small.c:9
    #3  0x005f0420 in ?? ()
    #4  0x0000000e in ?? ()
    #5  0x00000033 in ?? ()
    #6  0x00000000 in ?? ()

Signed-off-by: Veronika Kabatova <vkabatov@redhat.com>
---
 runtest/mm                            |  1 +
 testcases/kernel/mem/.gitignore       |  1 +
 testcases/kernel/mem/vma/Makefile     |  2 +
 testcases/kernel/mem/vma/vma05.sh     | 84 +++++++++++++++++++++++++++++++++++
 testcases/kernel/mem/vma/vma05_vdso.c |  7 +++
 5 files changed, 95 insertions(+)
 create mode 100755 testcases/kernel/mem/vma/vma05.sh
 create mode 100644 testcases/kernel/mem/vma/vma05_vdso.c

diff --git a/runtest/mm b/runtest/mm
index d108d1897..55fc2cab0 100644
--- a/runtest/mm
+++ b/runtest/mm
@@ -89,6 +89,7 @@ vma01 vma01
 vma02 vma02
 vma03 vma03
 vma04 vma04
+vma05 vma05.sh
 
 overcommit_memory01 overcommit_memory
 overcommit_memory02 overcommit_memory -R 0
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index 51701190a..ce21ca70f 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -72,5 +72,6 @@
 /vma/vma02
 /vma/vma03
 /vma/vma04
+/vma/vma05_vdso
 /vmtests/data_space
 /vmtests/stack_space
diff --git a/testcases/kernel/mem/vma/Makefile b/testcases/kernel/mem/vma/Makefile
index b323dbfd5..966148cbd 100644
--- a/testcases/kernel/mem/vma/Makefile
+++ b/testcases/kernel/mem/vma/Makefile
@@ -19,6 +19,8 @@
 
 top_srcdir              ?= ../../../..
 
+vma05_vdso: CFLAGS+=-ggdb3
+
 include $(top_srcdir)/include/mk/testcases.mk
 include $(top_srcdir)/testcases/kernel/mem/include/libmem.mk
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/mem/vma/vma05.sh b/testcases/kernel/mem/vma/vma05.sh
new file mode 100755
index 000000000..5742fbc22
--- /dev/null
+++ b/testcases/kernel/mem/vma/vma05.sh
@@ -0,0 +1,84 @@
+#!/bin/sh
+
+# Copyright (C) 2017 Red Hat, Inc.
+#
+# This program is free software;  you can redistribute it and#or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful, but
+# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
+# or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
+# for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, see <http://www.gnu.org/licenses/>.
+
+# Test description: [regression] Check if the vsyscall and vdso VMA regions are
+#                   reported correctly.
+#
+#       While [vsyscall] is mostly deprecated with newer systems, there is
+#       still plenty of kernels compiled with CONFIG_LEGACY_VSYSCALL_NATIVE and
+#       CONFIG_LEGACY_VSYSCALL_EMULATE (see linux/arch/x86/Kconfig for option
+#       descriptions). First part of the test will check eligible kernels for
+#       regression for a bug fixed by commit 103efcd9aac1 (fix perms/range of
+#       vsyscall vma in /proc/*/maps).
+#
+#       Second part of test checks [vdso] VMA permissions (fixed with commits
+#       b6558c4a2378 (fix [vdso] page permissions) and e5b97dde514f (Add
+#       VM_ALWAYSDUMP)). As a consequence of this bug, VMAs were not included
+#       in core dumps which resulted in eg. incomplete backtraces and invalid
+#       core dump files created by gdb.
+
+# Usage
+# ./vma05.sh
+
+TST_SETUP=setup
+TST_CLEANUP=cleanup
+TST_TESTFUNC=vma_report_check
+TST_NEEDS_ROOT=1
+TST_NEEDS_CMDS="gdb"
+
+. tst_test.sh
+
+CORE_LIMIT=$(ulimit -c)
+CORE_PATTERN=$(cat /proc/sys/kernel/core_pattern)
+
+setup()
+{
+	ulimit -c unlimited
+	echo "core" > /proc/sys/kernel/core_pattern
+}
+
+cleanup()
+{
+	ulimit -c "$CORE_LIMIT"
+	echo "$CORE_PATTERN" > /proc/sys/kernel/core_pattern
+}
+
+vma_report_check()
+{
+	if [ $(uname -m) == "x86_64" ] ; then
+		if LINE=$(grep "vsyscall" /proc/self/maps) ; then
+			RIGHT="ffffffffff600000-ffffffffff601000[[:space:]]r-xp"
+			if grep -q "$RIGHT" <<< "$LINE" ; then
+				tst_res TPASS "[vsyscall] reported correctly"
+			else
+				tst_res TFAIL "[vsyscall] reporting wrong"
+			fi
+		fi
+	fi
+
+	rm -rf core*
+	{ vma05_vdso; } >& /dev/null
+	TRACE=$(gdb -silent -ex="thread apply all backtrace" -ex="quit"\
+		vma05_vdso ./core* 2> /dev/null)
+	if grep -qF "??" <<< "$TRACE" ; then
+		tst_res TFAIL "[vdso] bug not patched"
+	else
+		tst_res TPASS "[vdso] backtrace complete"
+	fi
+}
+
+tst_run
diff --git a/testcases/kernel/mem/vma/vma05_vdso.c b/testcases/kernel/mem/vma/vma05_vdso.c
new file mode 100644
index 000000000..507de50d5
--- /dev/null
+++ b/testcases/kernel/mem/vma/vma05_vdso.c
@@ -0,0 +1,7 @@
+#include <signal.h>
+
+int main(void)
+{
+	raise(SIGSEGV);
+	return 0;
+}
-- 
2.13.3

