From: Cui Bixuan <cuibixuan@huawei.com>
Date: Wed, 28 Oct 2015 03:11:39 +0000
Subject: [LTP] [PATCH 3/11] chroot/chroot04: Testcase failed when no root
	user run it
In-Reply-To: <1446001907-43525-1-git-send-email-cuibixuan@huawei.com>
References: <1446001907-43525-1-git-send-email-cuibixuan@huawei.com>
Message-ID: <1446001907-43525-3-git-send-email-cuibixuan@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add tst_require_root() to testcase for seteuid().

Signed-off-by: Cui Bixuan <cuibixuan@huawei.com>
---
 testcases/kernel/syscalls/chroot/chroot04.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/testcases/kernel/syscalls/chroot/chroot04.c b/testcases/kernel/syscalls/chroot/chroot04.c
index 6d1d46b..254db0c 100644
--- a/testcases/kernel/syscalls/chroot/chroot04.c
+++ b/testcases/kernel/syscalls/chroot/chroot04.c
@@ -99,6 +99,8 @@ void setup(void)
 {
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
+	tst_require_root();
+
 	TEST_PAUSE;
 
 	/* make a temporary directory and cd to it */
-- 
1.6.0.2

