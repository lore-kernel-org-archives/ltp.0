From: Yixin Zhang <yixin.zhang@intel.com>
Date: Fri, 20 Apr 2018 11:18:50 +0800
Subject: [LTP] [PATCH ltp 1/6] fs/acls/acl_test01: Fix shellcheck issue
	SC2069
Message-ID: <20180420031855.22657-1-yixin.zhang@intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

error: The order of the 2>&1 and the redirect matters. The 2>&1 has to
be last. [SC2069]

Signed-off-by: Yixin Zhang <yixin.zhang@intel.com>
---
 testcases/kernel/fs/acls/acl_test01 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/fs/acls/acl_test01 b/testcases/kernel/fs/acls/acl_test01
index 63683e707..c91eb5686 100755
--- a/testcases/kernel/fs/acls/acl_test01
+++ b/testcases/kernel/fs/acls/acl_test01
@@ -78,7 +78,7 @@ do_setup()
 		tst_brkm TCONF "[ losetup.1 ] Failed to find an available loopback device -- is the required support compiled in your kernel?"
 	fi
 
-	if ! losetup $LOOP_DEV $TMP/tacl/blkext3 2>&1 > /dev/null; then
+	if ! losetup $LOOP_DEV $TMP/tacl/blkext3 > /dev/null 2>&1; then
 		echo ""
 		tst_brkm TCONF "[ losetup.2 ] Failed to setup the device."
 	fi
-- 
2.14.1

