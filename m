From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 15 Mar 2017 17:26:02 +0100
Subject: [LTP] [COMMITTED] [PATCH 2/2] syscalls/ioctl{04, 05,
	06}: Require root
In-Reply-To: <20170315162602.25921-1-chrubis@suse.cz>
References: <20170315162602.25921-1-chrubis@suse.cz>
Message-ID: <20170315162602.25921-2-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

I've missed that when writing these testcases, sorry.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/ioctl/ioctl04.c | 1 +
 testcases/kernel/syscalls/ioctl/ioctl05.c | 1 +
 testcases/kernel/syscalls/ioctl/ioctl06.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl04.c b/testcases/kernel/syscalls/ioctl/ioctl04.c
index 6a44813..8f78247 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl04.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl04.c
@@ -96,6 +96,7 @@ static struct tst_test test = {
 	.tid = "ioctl04",
 	.needs_tmpdir = 1,
 	.format_device = 1,
+	.needs_root = 1,
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = verify_ioctl,
diff --git a/testcases/kernel/syscalls/ioctl/ioctl05.c b/testcases/kernel/syscalls/ioctl/ioctl05.c
index c250609..d1b44f1 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl05.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl05.c
@@ -80,6 +80,7 @@ static void cleanup(void)
 static struct tst_test test = {
 	.tid = "ioctl05",
 	.needs_device = 1,
+	.needs_root = 1,
 	.cleanup = cleanup,
 	.test_all = verify_ioctl,
 };
diff --git a/testcases/kernel/syscalls/ioctl/ioctl06.c b/testcases/kernel/syscalls/ioctl/ioctl06.c
index d05aa45..082d097 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl06.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl06.c
@@ -64,6 +64,7 @@ static void cleanup(void)
 
 static struct tst_test test = {
 	.tid = "ioctl06",
+	.needs_root = 1,
 	.needs_device = 1,
 	.setup = setup,
 	.cleanup = cleanup,
-- 
2.10.2

