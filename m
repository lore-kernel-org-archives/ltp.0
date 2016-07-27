From: Li Wang <liwang@redhat.com>
Date: Wed, 27 Jul 2016 13:44:07 +0800
Subject: [LTP] [PATCH 2/2] mkfs01: extend the loop device size to 256M
In-Reply-To: <1469598247-23993-1-git-send-email-liwang@redhat.com>
References: <1469598247-23993-1-git-send-email-liwang@redhat.com>
Message-ID: <1469598247-23993-2-git-send-email-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Increase TST_DEVICE size to make btrfs-progs happy.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/commands/mkfs/mkfs01.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/commands/mkfs/mkfs01.sh b/testcases/commands/mkfs/mkfs01.sh
index eda9829..9a26899 100755
--- a/testcases/commands/mkfs/mkfs01.sh
+++ b/testcases/commands/mkfs/mkfs01.sh
@@ -32,7 +32,8 @@ setup()
 
 	tst_tmpdir
 
-	tst_acquire_device
+	# set test_dev.img size
+	tst_acquire_device 256
 
 	TST_CLEANUP="cleanup"
 
-- 
1.8.3.1

