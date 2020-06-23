From: Yixin Zhang <yixin.zhang@intel.com>
Date: Tue, 23 Jun 2020 14:44:24 +0800
Subject: [LTP] [PATCH ltp] lib/newlib_tests: add test21 into .gitignore
Message-ID: <20200623064424.15273-1-yixin.zhang@intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add newly added test21 into .gitignore.

Fixes: 3b716981bd54 ("lib: add new cgroup test API")
Signed-off-by: Yixin Zhang <yixin.zhang@intel.com>
---
 lib/newlib_tests/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/newlib_tests/.gitignore b/lib/newlib_tests/.gitignore
index fee8795b6bc0..44bc6526fea6 100644
--- a/lib/newlib_tests/.gitignore
+++ b/lib/newlib_tests/.gitignore
@@ -24,6 +24,7 @@ test17
 test18
 test19
 test20
+test21
 tst_expiration_timer
 test_assert
 test_timer
-- 
2.17.1

