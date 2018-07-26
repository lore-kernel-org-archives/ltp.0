From: Yixin Zhang <yixin.zhang@intel.com>
Date: Thu, 26 Jul 2018 17:22:18 +0800
Subject: [LTP] [PATCH v3 ltp 3/4] fs/ext4: bug fix - incorect argument ctime
	vs mtime
In-Reply-To: <20180726092219.15667-1-yixin.zhang@intel.com>
References: <20180726092219.15667-1-yixin.zhang@intel.com>
Message-ID: <20180726092219.15667-3-yixin.zhang@intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

nsec_ctime2 should call ext4_file_time with argument ctime, not mtime.

Signed-off-by: Yixin Zhang <yixin.zhang@intel.com>
---
 .../ext4-new-features/ext4-nsec-timestamps/ext4_nsec_timestamps_test.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/fs/ext4-new-features/ext4-nsec-timestamps/ext4_nsec_timestamps_test.sh b/testcases/kernel/fs/ext4-new-features/ext4-nsec-timestamps/ext4_nsec_timestamps_test.sh
index fdf64fde8..e44b9f62e 100755
--- a/testcases/kernel/fs/ext4-new-features/ext4-nsec-timestamps/ext4_nsec_timestamps_test.sh
+++ b/testcases/kernel/fs/ext4-new-features/ext4-nsec-timestamps/ext4_nsec_timestamps_test.sh
@@ -139,7 +139,7 @@ ext4_test_nsec_timestamps()
 
 	nsec_atime2=`ext4_file_time mnt_point/tmp_file atime nsec`
 	nsec_mtime2=`ext4_file_time mnt_point/tmp_file mtime nsec`
-	nsec_ctime2=`ext4_file_time mnt_point/tmp_file mtime nsec`
+	nsec_ctime2=`ext4_file_time mnt_point/tmp_file ctime nsec`
 
 	if [ $nsec_atime -ne $nsec_atime2 -o $nsec_ctime -ne $nsec_ctime2 -o \
 	     $nsec_mtime -ne $nsec_mtime2 ]; then
-- 
2.14.1

