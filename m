From: Jinhui huang <huangjh.jy@cn.fujitsu.com>
Date: Fri, 1 Mar 2019 15:16:26 +0800
Subject: [LTP] [PATCH v2 1/3] lapi/syscalls: Add syscall numbers for
	pwritev2()
Message-ID: <1551424588-27446-1-git-send-email-huangjh.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Jinhui huang <huangjh.jy@cn.fujitsu.com>
---
 include/lapi/syscalls/aarch64.in   | 1 +
 include/lapi/syscalls/arm.in       | 1 +
 include/lapi/syscalls/hppa.in      | 1 +
 include/lapi/syscalls/i386.in      | 1 +
 include/lapi/syscalls/ia64.in      | 1 +
 include/lapi/syscalls/powerpc.in   | 1 +
 include/lapi/syscalls/powerpc64.in | 1 +
 include/lapi/syscalls/s390.in      | 1 +
 include/lapi/syscalls/s390x.in     | 1 +
 include/lapi/syscalls/sh.in        | 1 +
 include/lapi/syscalls/sparc.in     | 1 +
 include/lapi/syscalls/sparc64.in   | 1 +
 include/lapi/syscalls/x86_64.in    | 1 +
 13 files changed, 13 insertions(+)

diff --git a/include/lapi/syscalls/aarch64.in b/include/lapi/syscalls/aarch64.in
index bf04895..7ce1485 100644
--- a/include/lapi/syscalls/aarch64.in
+++ b/include/lapi/syscalls/aarch64.in
@@ -263,4 +263,5 @@ execveat 281
 mlock2 284
 copy_file_range 285
 preadv2 286
+pwritev2 287
 _sysctl 1078
diff --git a/include/lapi/syscalls/arm.in b/include/lapi/syscalls/arm.in
index e720b08..22c76d4 100644
--- a/include/lapi/syscalls/arm.in
+++ b/include/lapi/syscalls/arm.in
@@ -347,4 +347,5 @@ membarrier (__NR_SYSCALL_BASE+389)
 mlock2 (__NR_SYSCALL_BASE+390)
 copy_file_range (__NR_SYSCALL_BASE+391)
 preadv2 (__NR_SYSCALL_BASE+392)
+pwritev2 (__NR_SYSCALL_BASE+393)
 statx (__NR_SYSCALL_BASE+397)
diff --git a/include/lapi/syscalls/hppa.in b/include/lapi/syscalls/hppa.in
index 182d393..a0dd230 100644
--- a/include/lapi/syscalls/hppa.in
+++ b/include/lapi/syscalls/hppa.in
@@ -24,3 +24,4 @@ execveat 342
 mlock2 345
 copy_file_range 346
 preadv2 347
+pwritev2 348
diff --git a/include/lapi/syscalls/i386.in b/include/lapi/syscalls/i386.in
index 2fb0188..7e485ae 100644
--- a/include/lapi/syscalls/i386.in
+++ b/include/lapi/syscalls/i386.in
@@ -345,4 +345,5 @@ membarrier 375
 mlock2 376
 copy_file_range 377
 preadv2 378
+pwritev2 379
 statx 383
diff --git a/include/lapi/syscalls/ia64.in b/include/lapi/syscalls/ia64.in
index 081c9ed..7c9a0ea 100644
--- a/include/lapi/syscalls/ia64.in
+++ b/include/lapi/syscalls/ia64.in
@@ -303,3 +303,4 @@ execveat 1342
 mlock2 1346
 copy_file_range 1347
 preadv2 1348
+pwritev2 1349
diff --git a/include/lapi/syscalls/powerpc.in b/include/lapi/syscalls/powerpc.in
index d16f9f9..fc1f899 100644
--- a/include/lapi/syscalls/powerpc.in
+++ b/include/lapi/syscalls/powerpc.in
@@ -352,4 +352,5 @@ execveat 362
 mlock2 378
 copy_file_range 379
 preadv2 380
+pwritev2 381
 statx 383
diff --git a/include/lapi/syscalls/powerpc64.in b/include/lapi/syscalls/powerpc64.in
index d16f9f9..fc1f899 100644
--- a/include/lapi/syscalls/powerpc64.in
+++ b/include/lapi/syscalls/powerpc64.in
@@ -352,4 +352,5 @@ execveat 362
 mlock2 378
 copy_file_range 379
 preadv2 380
+pwritev2 381
 statx 383
diff --git a/include/lapi/syscalls/s390.in b/include/lapi/syscalls/s390.in
index 4019438..6d0c895 100644
--- a/include/lapi/syscalls/s390.in
+++ b/include/lapi/syscalls/s390.in
@@ -336,3 +336,4 @@ execveat 354
 mlock2 374
 copy_file_range 375
 preadv2 376
+pwritev2 377
diff --git a/include/lapi/syscalls/s390x.in b/include/lapi/syscalls/s390x.in
index e156b09..8105b55 100644
--- a/include/lapi/syscalls/s390x.in
+++ b/include/lapi/syscalls/s390x.in
@@ -335,3 +335,4 @@ execveat 354
 mlock2 374
 copy_file_range 375
 preadv2 376
+pwritev2 377
diff --git a/include/lapi/syscalls/sh.in b/include/lapi/syscalls/sh.in
index 8520bb1..a942fb5 100644
--- a/include/lapi/syscalls/sh.in
+++ b/include/lapi/syscalls/sh.in
@@ -368,3 +368,4 @@ execveat 387
 mlock2 390
 copy_file_range 391
 preadv2 392
+pwritev2 393
diff --git a/include/lapi/syscalls/sparc.in b/include/lapi/syscalls/sparc.in
index b7bb135..20a21a9 100644
--- a/include/lapi/syscalls/sparc.in
+++ b/include/lapi/syscalls/sparc.in
@@ -341,3 +341,4 @@ execveat 350
 mlock2 356
 copy_file_range 357
 preadv2 358
+pwritev2 359
diff --git a/include/lapi/syscalls/sparc64.in b/include/lapi/syscalls/sparc64.in
index a211df8..36ab394 100644
--- a/include/lapi/syscalls/sparc64.in
+++ b/include/lapi/syscalls/sparc64.in
@@ -317,3 +317,4 @@ execveat 350
 mlock2 356
 copy_file_range 357
 preadv2 358
+pwritev2 359
diff --git a/include/lapi/syscalls/x86_64.in b/include/lapi/syscalls/x86_64.in
index dae5769..580b298 100644
--- a/include/lapi/syscalls/x86_64.in
+++ b/include/lapi/syscalls/x86_64.in
@@ -312,4 +312,5 @@ membarrier 324
 mlock2 325
 copy_file_range 326
 preadv2 327
+pwritev2 359
 statx 332
-- 
1.8.3.1



