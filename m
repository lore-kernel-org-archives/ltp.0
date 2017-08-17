From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 17 Aug 2017 12:24:47 +0200
Subject: [LTP] [PATCH v3] [vma] Add regression tests for vsyscall and
	vdso
In-Reply-To: <20170809143934.2875-1-vkabatov@redhat.com>
References: <20170809143934.2875-1-vkabatov@redhat.com>
Message-ID: <20170817102447.GA28406@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've fixed a few cases of bashism (please try to run the test with dash
before submitting next time) and added TST_NEEDS_TMPDIR=1 since the test
creates the core file which should be put into temporary directory.

And pushed, thanks.

The diff for what I did:

diff --git a/testcases/kernel/mem/vma/vma05.sh b/testcases/kernel/mem/vma/vma05.sh
index 04affa021..1008b9c8b 100755
--- a/testcases/kernel/mem/vma/vma05.sh
+++ b/testcases/kernel/mem/vma/vma05.sh
@@ -38,6 +38,7 @@ TST_SETUP=setup
 TST_CLEANUP=cleanup
 TST_TESTFUNC=vma_report_check
 TST_NEEDS_ROOT=1
+TST_NEEDS_TMPDIR=1
 TST_NEEDS_CMDS="gdb"

and:

diff --git a/testcases/kernel/mem/vma/vma05.sh b/testcases/kernel/mem/vma/vma05.sh
index 5742fbc22..662290d60 100755
--- a/testcases/kernel/mem/vma/vma05.sh
+++ b/testcases/kernel/mem/vma/vma05.sh
@@ -59,10 +59,10 @@ cleanup()
 
 vma_report_check()
 {
-       if [ $(uname -m) == "x86_64" ] ; then
-               if LINE=$(grep "vsyscall" /proc/self/maps) ; then
+       if [ $(uname -m) = "x86_64" ]; then
+               if LINE=$(grep "vsyscall" /proc/self/maps); then
                        RIGHT="ffffffffff600000-ffffffffff601000[[:space:]]r-xp"
-                       if grep -q "$RIGHT" <<< "$LINE" ; then
+                       if echo "$LINE" | grep -q "$RIGHT"; then
                                tst_res TPASS "[vsyscall] reported correctly"
                        else
                                tst_res TFAIL "[vsyscall] reporting wrong"
@@ -71,10 +71,10 @@ vma_report_check()
        fi
 
        rm -rf core*
-       { vma05_vdso; } >& /dev/null
+       { vma05_vdso; } > /dev/null 2>&1
        TRACE=$(gdb -silent -ex="thread apply all backtrace" -ex="quit"\
                vma05_vdso ./core* 2> /dev/null)
-       if grep -qF "??" <<< "$TRACE" ; then
+       if echo "$TRACE" | grep -qF "??"; then
                tst_res TFAIL "[vdso] bug not patched"
        else
                tst_res TPASS "[vdso] backtrace complete"


-- 
Cyril Hrubis
chrubis@suse.cz
