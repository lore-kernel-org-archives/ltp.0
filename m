From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 13 Apr 2018 16:22:50 +0200
Subject: [LTP] [PATCH] syscalls/inotify06: bump timeout
Message-ID: <96166bd70a154ff7a440a8fabb8cb3395d6f5ce3.1523629313.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

After migrating this test to newlib, there's now
a default timeout and it's not enough for some
systems.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/inotify/inotify06.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/syscalls/inotify/inotify06.c b/testcases/kernel/syscalls/inotify/inotify06.c
index a3a60180a32e..4475f5ea43b1 100644
--- a/testcases/kernel/syscalls/inotify/inotify06.c
+++ b/testcases/kernel/syscalls/inotify/inotify06.c
@@ -106,6 +106,7 @@ static void verify_inotify(void)
 }
 
 static struct tst_test test = {
+	.timeout = 600,
 	.needs_tmpdir = 1,
 	.forks_child = 1,
 	.setup = setup,
-- 
1.8.3.1

