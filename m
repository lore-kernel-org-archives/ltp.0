From: Cui Bixuan <cuibixuan@huawei.com>
Date: Wed, 28 Oct 2015 03:11:42 +0000
Subject: [LTP] [PATCH 6/11] mmap/mmap12: Testcase failed when no root user
	run it
In-Reply-To: <1446001907-43525-1-git-send-email-cuibixuan@huawei.com>
References: <1446001907-43525-1-git-send-email-cuibixuan@huawei.com>
Message-ID: <1446001907-43525-6-git-send-email-cuibixuan@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add tst_require_root() to testcase for open /proc/self/pagemap file.

Signed-off-by: Cui Bixuan <cuibixuan@huawei.com>
---
 testcases/kernel/syscalls/mmap/mmap12.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/testcases/kernel/syscalls/mmap/mmap12.c b/testcases/kernel/syscalls/mmap/mmap12.c
index ba8c646..7484601 100644
--- a/testcases/kernel/syscalls/mmap/mmap12.c
+++ b/testcases/kernel/syscalls/mmap/mmap12.c
@@ -143,6 +143,8 @@ static void setup(void)
 {
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
+	tst_require_root();
+
 	if ((tst_kvercmp(2, 6, 25)) < 0)
 		tst_brkm(TCONF, NULL,
 			"This test can only run on kernels that are 2.6.25 and "
-- 
1.6.0.2

