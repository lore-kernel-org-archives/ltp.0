From: Radoslav Kolev <radoslav.kolev@suse.com>
Date: Mon, 21 Dec 2020 13:34:49 +0200
Subject: [LTP] [PATCH] df01.sh: Fix failure when block size < 1024
Message-ID: <20201221113449.30656-1-radoslav.kolev@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

If block size is < 1024 shell integer division will always round down.
Add 512 (1024/2) to the left side, to cause round up for values >= .5.

Signed-off-by: Radoslav Kolev <radoslav.kolev@suse.com>
---
 testcases/commands/df/df01.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/commands/df/df01.sh b/testcases/commands/df/df01.sh
index 02aeec7b4..0e73a16af 100755
--- a/testcases/commands/df/df01.sh
+++ b/testcases/commands/df/df01.sh
@@ -101,8 +101,8 @@ df_check()
 		local free=$(stat -f mntpoint --printf=%f)
 		local used=$((total-free))
 		local bsize=$(stat -f mntpoint --printf=%s)
-		total=$(($total * $bsize / 1024))
-		used=$(($used * $bsize / 1024))
+		total=$((($total * $bsize + 512)/ 1024))
+		used=$((($used * $bsize + 512) / 1024))
 	fi
 
 	grep ${TST_DEVICE} output | grep -q "${total}.*${used}"
-- 
2.26.2

