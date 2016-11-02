From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 2 Nov 2016 18:27:35 +0800
Subject: [LTP] [PATCH] syscalls/*: fix TERRNO
Message-ID: <1478082455-14686-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1) we should use TTERRNO instead of TERRNO after calling TEST() function
2) remove unnecessary TERRNO

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/llistxattr/llistxattr01.c   | 2 +-
 testcases/kernel/syscalls/llistxattr/llistxattr03.c   | 2 +-
 testcases/kernel/syscalls/quotactl/quotactl01.c       | 4 ++--
 testcases/kernel/syscalls/quotactl/quotactl02.c       | 2 +-
 testcases/kernel/syscalls/request_key/request_key01.c | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/llistxattr/llistxattr01.c b/testcases/kernel/syscalls/llistxattr/llistxattr01.c
index 03d7f85..2e95faf 100644
--- a/testcases/kernel/syscalls/llistxattr/llistxattr01.c
+++ b/testcases/kernel/syscalls/llistxattr/llistxattr01.c
@@ -82,7 +82,7 @@ static void verify_llistxattr(void)
 
 	TEST(llistxattr("symlink", buf, size));
 	if (TEST_RETURN == -1) {
-		tst_res(TFAIL | TERRNO, "llistxattr() failed");
+		tst_res(TFAIL | TTERRNO, "llistxattr() failed");
 		return;
 	}
 
diff --git a/testcases/kernel/syscalls/llistxattr/llistxattr03.c b/testcases/kernel/syscalls/llistxattr/llistxattr03.c
index 9b65de9..e6e4c68 100644
--- a/testcases/kernel/syscalls/llistxattr/llistxattr03.c
+++ b/testcases/kernel/syscalls/llistxattr/llistxattr03.c
@@ -59,7 +59,7 @@ static void verify_llistxattr(unsigned int n)
 
 	TEST(llistxattr(name, NULL, 0));
 	if (TEST_RETURN == -1) {
-		tst_res(TFAIL | TERRNO, "llistxattr() failed");
+		tst_res(TFAIL | TTERRNO, "llistxattr() failed");
 		return;
 	}
 
diff --git a/testcases/kernel/syscalls/quotactl/quotactl01.c b/testcases/kernel/syscalls/quotactl/quotactl01.c
index 89b5dc2..586272a 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl01.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl01.c
@@ -189,12 +189,12 @@ static void verify_quota(unsigned int n)
 
 	TEST(quotactl(tc->cmd, tst_device->dev, *tc->id, tc->addr));
 	if (TEST_RETURN == -1) {
-		tst_res(TFAIL | TERRNO, "quotactl failed to %s", tc->des);
+		tst_res(TFAIL | TTERRNO, "quotactl failed to %s", tc->des);
 		return;
 	}
 
 	if (*tc->set_data != *tc->res_data) {
-		tst_res(TFAIL | TERRNO, "quotactl got unexpected info %lu, "
+		tst_res(TFAIL, "quotactl got unexpected info %lu, "
 			"expected %lu", *tc->res_data, *tc->set_data);
 		return;
 	}
diff --git a/testcases/kernel/syscalls/quotactl/quotactl02.c b/testcases/kernel/syscalls/quotactl/quotactl02.c
index 4f07fbd..97e7844 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl02.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl02.c
@@ -160,7 +160,7 @@ static void verify_quota(unsigned int n)
 
 	TEST(quotactl(tc->cmd, tst_device->dev, test_id, tc->addr));
 	if (TEST_RETURN == -1) {
-		tst_res(TFAIL | TERRNO, "quotactl() failed to %s", tc->des);
+		tst_res(TFAIL | TTERRNO, "quotactl() failed to %s", tc->des);
 		return;
 	}
 
diff --git a/testcases/kernel/syscalls/request_key/request_key01.c b/testcases/kernel/syscalls/request_key/request_key01.c
index 3b7bc36..583ecdc 100644
--- a/testcases/kernel/syscalls/request_key/request_key01.c
+++ b/testcases/kernel/syscalls/request_key/request_key01.c
@@ -43,7 +43,7 @@ static void verify_request_key(void)
 
 	TEST(request_key("keyring", "ltp", NULL, KEY_REQKEY_DEFL_DEFAULT));
 	if (TEST_RETURN == -1) {
-		tst_res(TFAIL | TERRNO, "request_key() failed");
+		tst_res(TFAIL | TTERRNO, "request_key() failed");
 		return;
 	}
 
-- 
1.8.3.1



