From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Mon, 14 Mar 2016 19:24:15 +0300
Subject: [LTP] [PATCH 2/2] tst_mkfs: check the arguments for passed device
	and fs_type
In-Reply-To: <1457972655-8326-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1457972655-8326-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <1457972655-8326-2-git-send-email-stanislav.kholmanskikh@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 lib/tst_mkfs.c        |    3 +++
 testcases/lib/test.sh |    8 ++++++++
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/lib/tst_mkfs.c b/lib/tst_mkfs.c
index 5cd8565..7a0992c 100644
--- a/lib/tst_mkfs.c
+++ b/lib/tst_mkfs.c
@@ -28,6 +28,9 @@ void tst_mkfs(void (cleanup_fn)(void), const char *dev,
 	const char *argv[OPTS_MAX] = {"mkfs", "-t", fs_type};
 	char fs_opts_str[1024] = "";
 
+	if (!dev)
+		tst_brkm(TBROK, cleanup_fn, "No device specified");
+
 	if (!fs_type)
 		tst_brkm(TBROK, cleanup_fn, "No fs_type specified");
 
diff --git a/testcases/lib/test.sh b/testcases/lib/test.sh
index 1d603b6..458bbca 100644
--- a/testcases/lib/test.sh
+++ b/testcases/lib/test.sh
@@ -303,6 +303,14 @@ tst_mkfs()
 	shift 2
 	local fs_opts="$@"
 
+	if [ -z "$fs_type" ]; then
+		tst_brkm TBROK "No fs_type specified"
+	fi
+
+	if [ -z "$device" ]; then
+		tst_brkm TBROK "No device specified"
+	fi
+
 	tst_resm TINFO "Formatting $device with $fs_type extra opts='$fs_opts'"
 
 	ROD_SILENT mkfs.$fs_type $fs_opts $device
-- 
1.7.1

