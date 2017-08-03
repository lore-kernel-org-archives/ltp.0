From: vkabatov@redhat.com <vkabatov@redhat.com>
Date: Thu,  3 Aug 2017 11:47:26 +0200
Subject: [LTP]  [PATCH] [vma] Add regression tests for vsyscall and vdso
Message-ID: <20170803094726.12301-1-vkabatov@redhat.com>
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
 runtest/mm                        |   1 +
 testcases/kernel/mem/vma/vma05.sh | 100 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 101 insertions(+)
 create mode 100755 testcases/kernel/mem/vma/vma05.sh

diff --git a/runtest/mm b/runtest/mm
index d108d1897..52b7a1ebc 100644
--- a/runtest/mm
+++ b/runtest/mm
@@ -89,6 +89,7 @@ vma01 vma01
 vma02 vma02
 vma03 vma03
 vma04 vma04
+vma05 vma05
 
 overcommit_memory01 overcommit_memory
 overcommit_memory02 overcommit_memory -R 0
diff --git a/testcases/kernel/mem/vma/vma05.sh b/testcases/kernel/mem/vma/vma05.sh
new file mode 100755
index 000000000..89f21b29e
--- /dev/null
+++ b/testcases/kernel/mem/vma/vma05.sh
@@ -0,0 +1,100 @@
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
+TST_NEEDS_TMPDIR=1
+TST_NEEDS_CMDS="gcc gdb"
+
+. tst_test.sh
+
+CORE_LIMIT=$(ulimit -c)
+
+setup()
+{
+	ulimit -c unlimited
+	cat << EOF > test_vdso.c
+#include <signal.h>
+#include <unistd.h>
+
+static void handle_alrm(int signo)
+{
+	kill(getpid(), SIGSEGV);
+}
+
+int main(void)
+{
+	signal(SIGALRM, handle_alrm);
+	alarm(1);
+	pause();
+	return 0;
+}
+EOF
+
+	gcc -o test_vdso test_vdso.c -ggdb3
+}
+
+cleanup()
+{
+	ulimit -c "$CORE_LIMIT"
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
+	{ ./test_vdso; } >& /dev/null
+	TRACE=$(gdb -silent -ex="thread apply all backtrace" -ex="quit"\
+		./test_vdso ./core* 2> /dev/null)
+	if grep -q "<signal handler called>" <<< "$TRACE" ; then
+		tst_res TPASS "[vdso] backtrace complete"
+	else
+		tst_res TFAIL "[vdso] bug not patched"
+	fi
+}
+
+tst_run
-- 
2.13.3

