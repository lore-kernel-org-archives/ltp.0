From: Li Wang <liwang@redhat.com>
Date: Mon, 13 Mar 2017 19:35:26 +0800
Subject: [LTP] [PATCH] ltp: test id usually same as test filename without
	suffix
Message-ID: <20170313113526.31763-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Perform this script under ltp root dir.

 $ cat fix_tid.sh
 #!/bin/bash

 for file in `find -name *.c`; do
 	value=$(echo $(basename ${file%%.c}));
 	sed -i "/\.tid/s/\".*\"/\"$value\"/g" $file
 done

Signed-off-by: Li Wang <liwang@redhat.com>
---
 lib/newlib_tests/test03.c                         | 2 +-
 testcases/kernel/syscalls/add_key/add_key02.c     | 2 +-
 testcases/kernel/syscalls/ioctl/ioctl06.c         | 2 +-
 testcases/kernel/syscalls/mq_unlink/mq_unlink01.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/newlib_tests/test03.c b/lib/newlib_tests/test03.c
index c1983ad..d5772a8 100644
--- a/lib/newlib_tests/test03.c
+++ b/lib/newlib_tests/test03.c
@@ -28,6 +28,6 @@ static void do_test(void)
 }
 
 static struct tst_test test = {
-	.tid = "test02",
+	.tid = "test03",
 	.test_all = do_test,
 };
diff --git a/testcases/kernel/syscalls/add_key/add_key02.c b/testcases/kernel/syscalls/add_key/add_key02.c
index e954575..fc99191 100644
--- a/testcases/kernel/syscalls/add_key/add_key02.c
+++ b/testcases/kernel/syscalls/add_key/add_key02.c
@@ -69,7 +69,7 @@ static void verify_add_key(unsigned int i)
 }
 
 static struct tst_test test = {
-	.tid = "add_key01",
+	.tid = "add_key02",
 	.tcnt = ARRAY_SIZE(tcases),
 	.test = verify_add_key,
 };
diff --git a/testcases/kernel/syscalls/ioctl/ioctl06.c b/testcases/kernel/syscalls/ioctl/ioctl06.c
index 9046a3f..d05aa45 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl06.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl06.c
@@ -63,7 +63,7 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
-	.tid = "ioctl07",
+	.tid = "ioctl06",
 	.needs_device = 1,
 	.setup = setup,
 	.cleanup = cleanup,
diff --git a/testcases/kernel/syscalls/mq_unlink/mq_unlink01.c b/testcases/kernel/syscalls/mq_unlink/mq_unlink01.c
index 03ce3f8..40f6db2 100644
--- a/testcases/kernel/syscalls/mq_unlink/mq_unlink01.c
+++ b/testcases/kernel/syscalls/mq_unlink/mq_unlink01.c
@@ -124,7 +124,7 @@ EXIT:
 }
 
 static struct tst_test test = {
-	.tid = "mq_ulink01",
+	.tid = "mq_unlink01",
 	.tcnt = ARRAY_SIZE(tcase),
 	.test = do_test,
 	.needs_root = 1,
-- 
2.9.3

