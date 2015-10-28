From: Cui Bixuan <cuibixuan@huawei.com>
Date: Wed, 28 Oct 2015 03:11:45 +0000
Subject: [LTP] [PATCH 9/11] ipc/semctl: Testcases failed when no root user
	run it
In-Reply-To: <1446001907-43525-1-git-send-email-cuibixuan@huawei.com>
References: <1446001907-43525-1-git-send-email-cuibixuan@huawei.com>
Message-ID: <1446001907-43525-9-git-send-email-cuibixuan@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add tst_require_root() to testcase for semop() and semget().

Signed-off-by: Cui Bixuan <cuibixuan@huawei.com>
---
 testcases/kernel/syscalls/ipc/semctl/semctl06.c |    2 ++
 testcases/kernel/syscalls/ipc/semctl/semctl07.c |    2 ++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl06.c b/testcases/kernel/syscalls/ipc/semctl/semctl06.c
index c298345..0b7d853 100644
--- a/testcases/kernel/syscalls/ipc/semctl/semctl06.c
+++ b/testcases/kernel/syscalls/ipc/semctl/semctl06.c
@@ -387,6 +387,8 @@ void setup(void)
 {
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
+	tst_require_root();
+
 	TEST_PAUSE;
 
 	tst_tmpdir();
diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl07.c b/testcases/kernel/syscalls/ipc/semctl/semctl07.c
index 3cc1eff..2eb9b5e 100644
--- a/testcases/kernel/syscalls/ipc/semctl/semctl07.c
+++ b/testcases/kernel/syscalls/ipc/semctl/semctl07.c
@@ -155,6 +155,8 @@ void setup(void)
 {
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
+	tst_require_root();
+
 	TEST_PAUSE;
 
 	tst_tmpdir();
-- 
1.6.0.2

