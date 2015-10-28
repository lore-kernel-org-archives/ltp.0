From: Cui Bixuan <cuibixuan@huawei.com>
Date: Wed, 28 Oct 2015 03:11:40 +0000
Subject: [LTP] [PATCH 4/11] execve/execve03: Testcase failed when no root
	user run it
In-Reply-To: <1446001907-43525-1-git-send-email-cuibixuan@huawei.com>
References: <1446001907-43525-1-git-send-email-cuibixuan@huawei.com>
Message-ID: <1446001907-43525-4-git-send-email-cuibixuan@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add tst_require_root() to testcase for setgid().

Signed-off-by: Cui Bixuan <cuibixuan@huawei.com>
---
 testcases/kernel/syscalls/execve/execve03.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/testcases/kernel/syscalls/execve/execve03.c b/testcases/kernel/syscalls/execve/execve03.c
index a3e589e..15b575d 100644
--- a/testcases/kernel/syscalls/execve/execve03.c
+++ b/testcases/kernel/syscalls/execve/execve03.c
@@ -166,6 +166,8 @@ void setup(void)
 	char *cwdname = NULL;
 	int fd;
 
+	tst_require_root();
+
 	umask(0);
 
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-- 
1.6.0.2

