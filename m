From: Yixin Zhang <yixin.zhang@intel.com>
Date: Tue, 17 Sep 2019 14:40:27 +0800
Subject: [LTP] [PATCH ltp] lib/newlib_tests: add tst_capability0{1,
 2} into .gitignore
Message-ID: <20190917064027.27208-1-yixin.zhang@intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

tst_capability0{1,2} is missed in .gitignore

Fixes: 0cbcfbef8 ("capability: library tests")

Signed-off-by: Yixin Zhang <yixin.zhang@intel.com>
---
 lib/newlib_tests/.gitignore | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/newlib_tests/.gitignore b/lib/newlib_tests/.gitignore
index 6788ddf90..d4aa4935f 100644
--- a/lib/newlib_tests/.gitignore
+++ b/lib/newlib_tests/.gitignore
@@ -14,6 +14,8 @@ test13
 test14
 test15
 test16
+tst_capability01
+tst_capability02
 tst_device
 tst_safe_fileops
 tst_res_hexd
-- 
2.17.1

