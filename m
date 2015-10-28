From: Cui Bixuan <cuibixuan@huawei.com>
Date: Wed, 28 Oct 2015 03:11:47 +0000
Subject: [LTP] [PATCH 11/11] unshare/unshare01: Testcase failed when no root
	user run it
In-Reply-To: <1446001907-43525-1-git-send-email-cuibixuan@huawei.com>
References: <1446001907-43525-1-git-send-email-cuibixuan@huawei.com>
Message-ID: <1446001907-43525-11-git-send-email-cuibixuan@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add tst_require_root() to testcase for unshare().

Signed-off-by: Cui Bixuan <cuibixuan@huawei.com>
---
 testcases/kernel/syscalls/unshare/unshare01.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/testcases/kernel/syscalls/unshare/unshare01.c b/testcases/kernel/syscalls/unshare/unshare01.c
index 17a5a5f..84d1892 100644
--- a/testcases/kernel/syscalls/unshare/unshare01.c
+++ b/testcases/kernel/syscalls/unshare/unshare01.c
@@ -144,6 +144,8 @@ void cleanup(void)
 /******************************************************************************/
 void setup(void)
 {
+	tst_require_root();
+
 	/* Capture signals if any */
 	/* Create temporary directories */
 	TEST_PAUSE;
-- 
1.6.0.2

