From: Cui Bixuan <cuibixuan@huawei.com>
Date: Thu, 10 Sep 2015 09:04:07 +0800
Subject: [LTP] [PATCH]  [PATCH] rmdir/rmdir05: Delete unnecessary if
In-Reply-To: <1441846935-44787-1-git-send-email-cuibixuan@huawei.com>
References: <1441846935-44787-1-git-send-email-cuibixuan@huawei.com>
Message-ID: <55F0D707.4040407@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Delete unnecessary if in testcase

Signed-off-by: Cui Bixuan <cuibixuan@huawei.com>
---
 testcases/kernel/syscalls/rmdir/rmdir05.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/rmdir/rmdir05.c b/testcases/kernel/syscalls/rmdir/rmdir05.c
index 10037c7..2f0f102 100644
--- a/testcases/kernel/syscalls/rmdir/rmdir05.c
+++ b/testcases/kernel/syscalls/rmdir/rmdir05.c
@@ -81,9 +81,6 @@ int main(int argc, char **argv)
 		TEST(rmdir("."));

 		if (TEST_RETURN == -1) {
-		}
-
-		if (TEST_RETURN == -1) {
 			if (TEST_ERRNO & (EBUSY | ENOTEMPTY)) {
 				/* For functionality tests, verify that the
 				 * directory wasn't removed.
-- 
1.6.0.2


.



