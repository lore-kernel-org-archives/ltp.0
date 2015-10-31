From: Eryu Guan <eguan@redhat.com>
Date: Sat, 31 Oct 2015 14:43:19 +0800
Subject: [LTP] [PATCH 1/2] test_robind.sh: set default FSTYPES to
	LTP_BIG_DEV_FS_TYPE
Message-ID: <1446273800-2494-1-git-send-email-eguan@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

In test_robind.sh LTP_BIG_DEV is used, so use LTP_BIG_DEV_FS_TYPE as
default fs type accordingly. If LTP_BIG_DEV_FS_TYPE is not set, fall
back to ext3.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 testcases/kernel/fs/fs_readonly/test_robind.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/fs/fs_readonly/test_robind.sh b/testcases/kernel/fs/fs_readonly/test_robind.sh
index 0513275..5674ca4 100755
--- a/testcases/kernel/fs/fs_readonly/test_robind.sh
+++ b/testcases/kernel/fs/fs_readonly/test_robind.sh
@@ -123,9 +123,10 @@ setup()
 		mkdir -p $dir
 	done
 
-	# populating the default FS as ext3, if FS is not given
+	# populating the default FS as $LTP_BIG_DEV_FS_TYPE
+	# (or ext3 if it's not set), if FS is not given
 	if [ -z "$*" ]; then
-		FSTYPES="ext3"
+		FSTYPES=${LTP_BIG_DEV_FS_TYPE:-ext3}
 	else
 		FSTYPES="$*"
 	fi
-- 
2.4.3

