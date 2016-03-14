From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Mon, 14 Mar 2016 19:24:14 +0300
Subject: [LTP] [PATCH 1/2] tst_mkfs: drop -f from mkfs
Message-ID: <1457972655-8326-1-git-send-email-stanislav.kholmanskikh@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

We no longer need to pass the force flag to mkfs due to
commit f79021c5d168 ("tst_acquire_device: clear first sectors of LTP_DEV").

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---

This patch is a follow up to:

http://lists.linux.it/pipermail/ltp/2016-February/001044.html


lib/tst_mkfs.c        |   21 ---------------------
 testcases/lib/test.sh |   21 ++-------------------
 2 files changed, 2 insertions(+), 40 deletions(-)

diff --git a/lib/tst_mkfs.c b/lib/tst_mkfs.c
index 5f959a4..5cd8565 100644
--- a/lib/tst_mkfs.c
+++ b/lib/tst_mkfs.c
@@ -31,27 +31,6 @@ void tst_mkfs(void (cleanup_fn)(void), const char *dev,
 	if (!fs_type)
 		tst_brkm(TBROK, cleanup_fn, "No fs_type specified");
 
-	/*
-	 * mkfs.xfs and mkfs.btrfs aborts if it finds a filesystem
-	 * superblock on the device, which is the case here as we
-	 * reuse one device for all tests.
-	 */
-	if (!strcmp(fs_type, "xfs")) {
-		tst_resm(TINFO, "Appending '-f' flag to mkfs.%s", fs_type);
-		argv[pos++] = "-f";
-	}
-
-	if (!strcmp(fs_type, "btrfs")) {
-		/*
-		 * The -f option was added to btrfs-progs v3.12
-		 */
-		if (!tst_system("mkfs.btrfs 2>&1 | grep -q '\\-f[ |]'")) {
-			tst_resm(TINFO, "Appending '-f' flag to mkfs.%s",
-				fs_type);
-			argv[pos++] = "-f";
-		}
-	}
-
 	if (fs_opts) {
 		for (i = 0; fs_opts[i]; i++) {
 			argv[pos++] = fs_opts[i];
diff --git a/testcases/lib/test.sh b/testcases/lib/test.sh
index 9b652c0..1d603b6 100644
--- a/testcases/lib/test.sh
+++ b/testcases/lib/test.sh
@@ -300,26 +300,9 @@ tst_mkfs()
 {
 	local fs_type=$1
 	local device=$2
-	local fs_opts=""
-
-	if [ $fs_type = "xfs" -o $fs_type = "jfs" ]; then
-		tst_resm TINFO "Appending '-f' flag to mkfs.$fs_type"
-		fs_opts="-f"
-	fi
-
-	if [ $fs_type = "btrfs" ]; then
-		# check if mkfs.btrfs supports -f option
-		# detect "-f --force" or "-f|--force" because btrfs-progs
-		# changes usage text in commit 3f312d500b73
-		mkfs.btrfs 2>&1 | grep -q '\-f[ |]' >/dev/null
-		if [ $? -eq 0 ]; then
-			tst_resm TINFO "Appending '-f' flag to mkfs.$fs_type"
-			fs_opts="-f"
-		fi
-	fi
-
 	shift 2
-	fs_opts="$fs_opts $@"
+	local fs_opts="$@"
+
 	tst_resm TINFO "Formatting $device with $fs_type extra opts='$fs_opts'"
 
 	ROD_SILENT mkfs.$fs_type $fs_opts $device
-- 
1.7.1

