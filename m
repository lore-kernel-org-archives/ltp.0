From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 14 Jun 2017 15:25:32 +0200
Subject: [LTP] [PATCH] [COMMITTED] syscalls: Smash newly introduced .tids
Message-ID: <20170614132532.23544-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The .tid is auto-initilalized for some time now, this commit removes
newly added initializations that got in while applying older patches.

Maybe it's time to hide the .tid from the user interface after all.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/open/open01.c     | 1 -
 testcases/kernel/syscalls/open/open02.c     | 1 -
 testcases/kernel/syscalls/read/read02.c     | 1 -
 testcases/kernel/syscalls/splice/splice04.c | 1 -
 testcases/kernel/syscalls/splice/splice05.c | 1 -
 testcases/kernel/syscalls/write/write03.c   | 1 -
 6 files changed, 6 deletions(-)

diff --git a/testcases/kernel/syscalls/open/open01.c b/testcases/kernel/syscalls/open/open01.c
index 0d6c371b6..43305b2ef 100644
--- a/testcases/kernel/syscalls/open/open01.c
+++ b/testcases/kernel/syscalls/open/open01.c
@@ -88,7 +88,6 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
-	.tid = "open01",
 	.tcnt = ARRAY_SIZE(tcases),
 	.needs_tmpdir = 1,
 	.setup = setup,
diff --git a/testcases/kernel/syscalls/open/open02.c b/testcases/kernel/syscalls/open/open02.c
index 518f0f041..f09bfe03d 100644
--- a/testcases/kernel/syscalls/open/open02.c
+++ b/testcases/kernel/syscalls/open/open02.c
@@ -85,7 +85,6 @@ void cleanup(void)
 }
 
 static struct tst_test test = {
-	.tid = "open02",
 	.tcnt = ARRAY_SIZE(tcases),
 	.needs_root = 1,
 	.needs_tmpdir = 1,
diff --git a/testcases/kernel/syscalls/read/read02.c b/testcases/kernel/syscalls/read/read02.c
index 0e4776e62..dae2385aa 100644
--- a/testcases/kernel/syscalls/read/read02.c
+++ b/testcases/kernel/syscalls/read/read02.c
@@ -139,7 +139,6 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
-	.tid = "read02",
 	.tcnt = ARRAY_SIZE(tcases),
 	.test = verify_read,
 	.setup = setup,
diff --git a/testcases/kernel/syscalls/splice/splice04.c b/testcases/kernel/syscalls/splice/splice04.c
index da0d3e172..91f54253a 100644
--- a/testcases/kernel/syscalls/splice/splice04.c
+++ b/testcases/kernel/syscalls/splice/splice04.c
@@ -97,7 +97,6 @@ exit:
 }
 
 static struct tst_test test = {
-	.tid = "splice04",
 	.test_all = pipe_pipe,
 	.setup = setup,
 	.cleanup = cleanup,
diff --git a/testcases/kernel/syscalls/splice/splice05.c b/testcases/kernel/syscalls/splice/splice05.c
index 7f312e74d..b8a21b9d1 100644
--- a/testcases/kernel/syscalls/splice/splice05.c
+++ b/testcases/kernel/syscalls/splice/splice05.c
@@ -113,7 +113,6 @@ exit:
 }
 
 static struct tst_test test = {
-	.tid = "splice05",
 	.test_all = pipe_socket,
 	.setup = setup,
 	.cleanup = cleanup,
diff --git a/testcases/kernel/syscalls/write/write03.c b/testcases/kernel/syscalls/write/write03.c
index 9ea57cb86..7e3ec98df 100644
--- a/testcases/kernel/syscalls/write/write03.c
+++ b/testcases/kernel/syscalls/write/write03.c
@@ -81,7 +81,6 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
-	.tid = "write03",
 	.test_all = verify_write,
 	.setup = setup,
 	.cleanup = cleanup,
-- 
2.13.0

