From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue,  3 Jan 2017 12:39:45 +0100
Subject: [LTP] [COMMITTED] [PATCH] du01: Fix the BTRFS fix after test
	conversion
Message-ID: <1483443585-5551-1-git-send-email-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

I've moved the page_size variable inicialization into the setup()
function while converting the testcase to the new library in:

commit d40cbfb2372f68aef72ebdf167018d7374622ded
Author: Cyril Hrubis <chrubis@suse.cz>
Date:   Mon Sep 26 18:31:03 2016 +0200

    du01.sh: Convert to the new library

Which broke the test on BTRFS again, since the page_size has to be
defined before the check3 variable is assigned, otherwise the
${page_size} in the string is evaluated to empty string.

So this commit moves the inicialization back so the page_size variable
is assigned before the check3 variable.

Sorry for the breakage.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/commands/du/du01.sh | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/testcases/commands/du/du01.sh b/testcases/commands/du/du01.sh
index 0284c89..2fe23b3 100755
--- a/testcases/commands/du/du01.sh
+++ b/testcases/commands/du/du01.sh
@@ -39,12 +39,6 @@ setup()
 
 	ROD_SILENT ln -s ../testfile testdir/testsymlink
 
-	page_size=$(getconf PAGESIZE)
-	if [ "$page_size" -lt 1024 ]; then
-		tst_brk TBROK "Page size < 1024"
-	fi
-	page_size=$(( page_size / 1024 ))
-
 	# Display values are in units of the first available SIZE
 	# from --block-size, and the DU_BLOCK_SIZE, BLOCK_SIZE and
 	# BLOCKSIZE environment variables. Here we need to
@@ -80,6 +74,11 @@ du_test()
 }
 
 block_size=512
+page_size=$(getconf PAGESIZE)
+if [ "$page_size" -lt 1024 ]; then
+	tst_brk TBROK "Page size < 1024"
+fi
+page_size=$((page_size / 1024))
 
 # The output could be different in some systems, if we use du to
 # estimate file space usage with the same filesystem and the same size.
-- 
2.7.3

