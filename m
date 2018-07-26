From: Yixin Zhang <yixin.zhang@intel.com>
Date: Thu, 26 Jul 2018 17:22:16 +0800
Subject: [LTP] [PATCH v3 ltp 1/4] fs/ext4: check if the big block device is
	mounted at do_setup()
Message-ID: <20180726092219.15667-1-yixin.zhang@intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The test requires the big block device is umounted before test, so check
at do_setup(), TBROK if it's mounted

Signed-off-by: Yixin Zhang <yixin.zhang@intel.com>
---
 testcases/kernel/fs/ext4-new-features/ext4_funcs.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testcases/kernel/fs/ext4-new-features/ext4_funcs.sh b/testcases/kernel/fs/ext4-new-features/ext4_funcs.sh
index a9eb54e8d..1514da5a2 100755
--- a/testcases/kernel/fs/ext4-new-features/ext4_funcs.sh
+++ b/testcases/kernel/fs/ext4-new-features/ext4_funcs.sh
@@ -45,6 +45,9 @@ ext4_setup()
 		tst_brkm TCONF "tests need a big block device(5G-10G)"
 	else
 		export EXT4_DEV=$LTP_BIG_DEV
+		if mount | cut -d' ' -f1 | grep -q ^$EXT4_DEV$ ; then
+			tst_brkm TBROK "$EXT4_DEV should be umounted before test"
+		fi
 	fi
 
 	tst_tmpdir
-- 
2.14.1

