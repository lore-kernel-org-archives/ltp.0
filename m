From: Radoslav Kolev <radoslav.kolev@suse.com>
Date: Mon, 21 Dec 2020 13:51:11 +0200
Subject: [LTP] [PATCH] lsmod01.sh: Fix failure when CONFIG_MODULE_UNLOAD is
 not set
Message-ID: <20201221115111.31982-1-radoslav.kolev@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

If CONFIG_MODULE_UNLOAD is not set lsmod shows '-2' (-ENOENT) for
the used by column, but /proc/modules has only '-' there.

Signed-off-by: Radoslav Kolev <radoslav.kolev@suse.com>
---
 testcases/commands/lsmod/lsmod01.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/testcases/commands/lsmod/lsmod01.sh b/testcases/commands/lsmod/lsmod01.sh
index c373b2893..2e044c718 100755
--- a/testcases/commands/lsmod/lsmod01.sh
+++ b/testcases/commands/lsmod/lsmod01.sh
@@ -44,7 +44,9 @@ cleanup()
 
 lsmod_matches_proc_modules()
 {
-	lsmod_output=$(lsmod | awk '!/Module/{print $1, $2, $3}' | sort)
+	lsmod_output=$(lsmod \
+			| awk '!/Module/{print $1, $2, ($3==-2) ? "-" : $3}' \
+			| sort)
 	if [ -z "$lsmod_output" ]; then
 		tst_brk TBROK "Failed to parse the output from lsmod"
 	fi
-- 
2.26.2

