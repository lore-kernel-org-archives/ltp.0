From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 18 Aug 2021 11:12:22 +0200
Subject: [LTP] [PATCH 1/3] tst_test.sh: Simplify tst_cmd_available()
In-Reply-To: <20210818091224.27578-1-pvorel@suse.cz>
References: <20210818091224.27578-1-pvorel@suse.cz>
Message-ID: <20210818091224.27578-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

"command -v" [1] and "type" [2] are POSIX. They're supported in all
common shells (bash, zsh, dash, busybox sh, mksh). Thus we don't have to
fallback on "which", which has been discontinued after 2.21 release in
2015 due this (git repository is empty [3]).

Use "type" instead of "command -v" which is IMHO more known.

Also drop explicit return as the exit code is reliable an all
implementations.

[1] https://pubs.opengroup.org/onlinepubs/9699919799/utilities/command.html
[2] https://pubs.opengroup.org/onlinepubs/9699919799/utilities/type.html
[3] https://git.savannah.gnu.org/cgit/which.git

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_test.sh | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index c6aa2c487..fa35a64f1 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -346,18 +346,7 @@ tst_virt_hyperv()
 
 tst_cmd_available()
 {
-	if type command > /dev/null 2>&1; then
-		command -v $1 > /dev/null 2>&1 || return 1
-	else
-		which $1 > /dev/null 2>&1
-		if [ $? -eq 0 ]; then
-			return 0
-		elif [ $? -eq 127 ]; then
-			tst_brk TCONF "missing which command"
-		else
-			return 1
-		fi
-	fi
+	type $1 >/dev/null 2>&1
 }
 
 tst_require_cmds()
-- 
2.32.0

