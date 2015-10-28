From: Cui Bixuan <cuibixuan@huawei.com>
Date: Wed, 28 Oct 2015 03:11:41 +0000
Subject: [LTP] [PATCH 5/11] syscalls/fcntl: Testcases failed when no root
	user run it
In-Reply-To: <1446001907-43525-1-git-send-email-cuibixuan@huawei.com>
References: <1446001907-43525-1-git-send-email-cuibixuan@huawei.com>
Message-ID: <1446001907-43525-5-git-send-email-cuibixuan@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add tst_require_root() to testcase for setreuid().

Signed-off-by: Cui Bixuan <cuibixuan@huawei.com>
---
 testcases/kernel/syscalls/fcntl/fcntl18.c |    2 ++
 testcases/kernel/syscalls/fcntl/fcntl33.c |    2 ++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/testcases/kernel/syscalls/fcntl/fcntl18.c b/testcases/kernel/syscalls/fcntl/fcntl18.c
index 6b9a7aa..5eefbd1 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl18.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl18.c
@@ -171,6 +171,8 @@ void setup(void)
 
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
+	tst_require_root();
+
 	umask(0);
 
 	TEST_PAUSE;
diff --git a/testcases/kernel/syscalls/fcntl/fcntl33.c b/testcases/kernel/syscalls/fcntl/fcntl33.c
index bffb9cb..161c814 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl33.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl33.c
@@ -112,6 +112,8 @@ static void setup(void)
 {
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
+	tst_require_root();
+
 	tst_timer_check(CLOCK_MONOTONIC);
 
 	/* Backup and set the lease-break-time. */
-- 
1.6.0.2

