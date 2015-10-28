From: Cui Bixuan <cuibixuan@huawei.com>
Date: Wed, 28 Oct 2015 03:11:44 +0000
Subject: [LTP] [PATCH 8/11] ipc/msgctl: Testcases failed when no root user
	run it
In-Reply-To: <1446001907-43525-1-git-send-email-cuibixuan@huawei.com>
References: <1446001907-43525-1-git-send-email-cuibixuan@huawei.com>
Message-ID: <1446001907-43525-8-git-send-email-cuibixuan@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add tst_require_root() to testcase for msgctl().

Signed-off-by: Cui Bixuan <cuibixuan@huawei.com>
---
 testcases/kernel/syscalls/ipc/msgctl/msgctl06.c |    2 ++
 testcases/kernel/syscalls/ipc/msgctl/msgctl07.c |    2 ++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl06.c b/testcases/kernel/syscalls/ipc/msgctl/msgctl06.c
index a0b1d35..6c7108f 100644
--- a/testcases/kernel/syscalls/ipc/msgctl/msgctl06.c
+++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl06.c
@@ -123,6 +123,8 @@ int main(int argc, char *argv[])
  *   ****************************************************************/
 void setup(void)
 {
+	tst_require_root();
+
 	/* You will want to enable some signal handling so you can capture
 	 * unexpected signals like SIGSEGV.
 	 */
diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl07.c b/testcases/kernel/syscalls/ipc/msgctl/msgctl07.c
index ac1215c..0eebfb6 100644
--- a/testcases/kernel/syscalls/ipc/msgctl/msgctl07.c
+++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl07.c
@@ -299,6 +299,8 @@ void setup(void)
 {
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
+	tst_require_root();
+
 	TEST_PAUSE;
 
 	tst_tmpdir();
-- 
1.6.0.2

