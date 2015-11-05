From: Eryu Guan <eguan@redhat.com>
Date: Thu,  5 Nov 2015 22:34:59 +0800
Subject: [LTP] [PATCH 1/3] lib/test.sh: improvement on the check if
	mkfs.btrfs supports -f option
Message-ID: <1446734101-6175-1-git-send-email-eguan@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

There are two issues here:

a) '\\-f' won't match string "-f", but "\\-f" or '\-f' does
b) searching for string "-f" is not accurate, because it matches both
   "-f" and "--features"

And the help text has been changed in btrfs-progs commit 3f312d500b73.
So use '\-f[ |]' to match both old and new btrfs-progs.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 testcases/lib/test.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/testcases/lib/test.sh b/testcases/lib/test.sh
index 1753664..6de39b9 100644
--- a/testcases/lib/test.sh
+++ b/testcases/lib/test.sh
@@ -277,7 +277,10 @@ tst_mkfs()
 	fi
 
 	if [ $fs_type = "btrfs" ]; then
-		mkfs.btrfs 2>&1 | grep -q '\\-f' >/dev/null
+		# check if mkfs.btrfs supports -f option
+		# detect "-f --force" or "-f|--force" because btrfs-progs
+		# changes usage text in commit 3f312d500b73
+		mkfs.btrfs 2>&1 | grep -q '\-f[ |]' >/dev/null
 		if [ $? -eq 0 ]; then
 			tst_resm TINFO "Appending '-f' flag to mkfs.$fs_type"
 			fs_opts="-f"
-- 
2.5.0

