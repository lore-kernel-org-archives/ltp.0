From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Wed, 16 Nov 2016 18:39:07 +0300
Subject: [LTP] [PATCH 1/2] du01.sh: start matching at the beginning of a line
In-Reply-To: <20161110151248.GA13022@rei.suse.cz>
References: <20161110151248.GA13022@rei.suse.cz>
Message-ID: <1479310748-14359-1-git-send-email-stanislav.kholmanskikh@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Otherwise the test may pass if there is some garbage before
the correct string.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 testcases/commands/du/du01.sh |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/testcases/commands/du/du01.sh b/testcases/commands/du/du01.sh
index a0e3017..823c50a 100755
--- a/testcases/commands/du/du01.sh
+++ b/testcases/commands/du/du01.sh
@@ -86,17 +86,17 @@ block_size=512
 # The output could be different in some systems, if we use du to
 # estimate file space usage with the same filesystem and the same size.
 # So we use the approximate value to check.
-check1="10[2-3][0-9][0-9][[:space:]]\."
-check2="10[2-3][0-9][0-9][[:space:]]testfile"
-check3="[0-4][[:space:]]\.\/testdir\/testsymlink"
-check5="20[4-6][0-9][0-9][[:space:]]\."
-check7="10[4-5][0-9][0-9]\{4\}[[:space:]]\."
-check9="10[2-3][0-9][0-9][[:space:]]total"
-check11="10[2-3][0-9][0-9][[:space:]]testdir\/testsymlink"
-check14="1[0,1]M[[:space:]]\."
-check16="10[2-3][0-9][0-9][[:space:]]testdir\/"
-check20="11M[[:space:]]\."
-check23="[0-9]\{1,2\}[[:space:]]\."
+check1="^10[2-3][0-9][0-9][[:space:]]\."
+check2="^10[2-3][0-9][0-9][[:space:]]testfile"
+check3="^[0-4][[:space:]]\.\/testdir\/testsymlink"
+check5="^20[4-6][0-9][0-9][[:space:]]\."
+check7="^10[4-5][0-9][0-9]\{4\}[[:space:]]\."
+check9="^10[2-3][0-9][0-9][[:space:]]total"
+check11="^10[2-3][0-9][0-9][[:space:]]testdir\/testsymlink"
+check14="^1[0,1]M[[:space:]]\."
+check16="^10[2-3][0-9][0-9][[:space:]]testdir\/"
+check20="^11M[[:space:]]\."
+check23="^[0-9]\{1,2\}[[:space:]]\."
 
 du_test "du" ${check1}
 du_test "du testfile" ${check2}
-- 
1.7.1

