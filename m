From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 27 Mar 2019 17:31:20 +0100
Subject: [LTP] [RFC PATCH 1/1] shell: Remove tst_su
Message-ID: <20190327163120.11358-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

tst_su was added into legacy (but at the time the only) shell API in
commit cd9a41dff ("test.sh: Add tst_su"). It was never used nor added
into new shell API, thus removing.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/test-writing-guidelines.txt | 25 +------------------------
 testcases/lib/test.sh           |  9 ---------
 2 files changed, 1 insertion(+), 33 deletions(-)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index 3b8541e7a..f1912dc12 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -1470,7 +1470,7 @@ setup(). The function will generate a TCONF if the requested flags are not
 fully supported on the running kernel, and TBROK if either a zero mask was
 supplied or if the kernel is already tainted before executing the test.
 
-Then you can call tst_taint_check() during run(), which returns 0 or the 
+Then you can call tst_taint_check() during run(), which returns 0 or the
 tainted flags set in /proc/sys/kernel/tainted as specified earlier.
 
 Depending on your kernel version, not all tainted-flags will be supported.
@@ -2122,29 +2122,6 @@ is a workaround since there are a daemons dumb enough to probe all newly
 mounted filesystems, which prevents them from umounting shortly after they
 were mounted.
 
-Running commands as different user with 'su'
-++++++++++++++++++++++++++++++++++++++++++++
-
-While some distributions retain paths added to +$PATH+ when doing
-+su user -c "command"+ this does not work at least in Debian. If you want to
-run LTP binaries as a different user you must use 'tst_su' instead which sets
-up +$PATH+ and the runs the command.
-
-.Run test child binary as a test user
-[source,sh]
--------------------------------------------------------------------------------
-#!/bin/sh
-TCID=foo01
-. test.sh
-
-tst_su testusr foo01_child
-if [ $? -ne 0 ]; then
-	tst_resm TFAIL "foo failed"
-else
-	tst_resm TPASS "foo passed"
-fi
--------------------------------------------------------------------------------
-
 ROD and ROD_SILENT
 ++++++++++++++++++
 
diff --git a/testcases/lib/test.sh b/testcases/lib/test.sh
index 954f2a22a..670248ee5 100644
--- a/testcases/lib/test.sh
+++ b/testcases/lib/test.sh
@@ -368,15 +368,6 @@ tst_module_exists()
 	tst_brkm TCONF "Failed to find module '$mod_name'"
 }
 
-# Appends LTP path when doing su
-tst_su()
-{
-	local usr="$1"
-	shift
-
-	su "$usr" -c "PATH=\$PATH:$LTPROOT/testcases/bin/ $@"
-}
-
 TST_CHECKPOINT_WAIT()
 {
 	ROD tst_checkpoint wait 10000 "$1"
-- 
2.21.0

