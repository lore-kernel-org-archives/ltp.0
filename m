From: Jakub Racek <jracek@redhat.com>
Date: Wed, 15 Mar 2017 17:35:35 +0100
Subject: [LTP] [PATCH v4 1/6] Added syscall numbers for memfd_create
In-Reply-To: <1489595740-26159-1-git-send-email-jracek@redhat.com>
References: <1489595740-26159-1-git-send-email-jracek@redhat.com>
Message-ID: <1489595740-26159-2-git-send-email-jracek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Jakub Racek <jracek@redhat.com>
---
 testcases/kernel/include/aarch64.in   | 1 +
 testcases/kernel/include/arm.in       | 1 +
 testcases/kernel/include/hppa.in      | 1 +
 testcases/kernel/include/i386.in      | 1 +
 testcases/kernel/include/ia64.in      | 1 +
 testcases/kernel/include/powerpc.in   | 1 +
 testcases/kernel/include/powerpc64.in | 1 +
 testcases/kernel/include/s390.in      | 1 +
 testcases/kernel/include/s390x.in     | 1 +
 testcases/kernel/include/sh.in        | 1 +
 testcases/kernel/include/sparc.in     | 1 +
 testcases/kernel/include/sparc64.in   | 1 +
 testcases/kernel/include/x86_64.in    | 1 +
 13 files changed, 13 insertions(+)

diff --git a/testcases/kernel/include/aarch64.in b/testcases/kernel/include/aarch64.in
index cb3fe06..b81c068 100644
--- a/testcases/kernel/include/aarch64.in
+++ b/testcases/kernel/include/aarch64.in
@@ -255,3 +255,4 @@ setns 268
 sendmmsg 269
 kcmp 272
 getrandom 278
+memfd_create 279
diff --git a/testcases/kernel/include/arm.in b/testcases/kernel/include/arm.in
index cee9718..0a5dde1 100644
--- a/testcases/kernel/include/arm.in
+++ b/testcases/kernel/include/arm.in
@@ -338,3 +338,4 @@ sched_setattr (__NR_SYSCALL_BASE+380)
 sched_getattr (__NR_SYSCALL_BASE+381)
 renameat2 (__NR_SYSCALL_BASE+382)
 getrandom (__NR_SYSCALL_BASE+384)
+memfd_create (__NR_SYSCALL_BASE+385)
diff --git a/testcases/kernel/include/hppa.in b/testcases/kernel/include/hppa.in
index b784a2b..3946155 100644
--- a/testcases/kernel/include/hppa.in
+++ b/testcases/kernel/include/hppa.in
@@ -15,3 +15,4 @@ faccessat (__NR_openat + 12)
 splice 291
 tee 293
 vmsplice 294
+memfd_create 340
diff --git a/testcases/kernel/include/i386.in b/testcases/kernel/include/i386.in
index 1f1cade..42c5e3f 100644
--- a/testcases/kernel/include/i386.in
+++ b/testcases/kernel/include/i386.in
@@ -338,3 +338,4 @@ sched_setattr 351
 sched_getattr 352
 renameat2 354
 getrandom 355
+memfd_create 356
diff --git a/testcases/kernel/include/ia64.in b/testcases/kernel/include/ia64.in
index 846141f..dad25f4 100644
--- a/testcases/kernel/include/ia64.in
+++ b/testcases/kernel/include/ia64.in
@@ -294,3 +294,4 @@ fanotify_mark 1324
 prlimit64 1325
 renameat2 1338
 getrandom 1339
+memfd_create 1340
diff --git a/testcases/kernel/include/powerpc.in b/testcases/kernel/include/powerpc.in
index 5ca42a6..10a6e5d 100644
--- a/testcases/kernel/include/powerpc.in
+++ b/testcases/kernel/include/powerpc.in
@@ -345,3 +345,4 @@ sched_setattr 355
 sched_getattr 356
 renameat2 357
 getrandom 359
+memfd_create 360
diff --git a/testcases/kernel/include/powerpc64.in b/testcases/kernel/include/powerpc64.in
index 5ca42a6..10a6e5d 100644
--- a/testcases/kernel/include/powerpc64.in
+++ b/testcases/kernel/include/powerpc64.in
@@ -345,3 +345,4 @@ sched_setattr 355
 sched_getattr 356
 renameat2 357
 getrandom 359
+memfd_create 360
diff --git a/testcases/kernel/include/s390.in b/testcases/kernel/include/s390.in
index afe94f5..770db7f 100644
--- a/testcases/kernel/include/s390.in
+++ b/testcases/kernel/include/s390.in
@@ -329,3 +329,4 @@ sched_setattr 345
 sched_getattr 346
 renameat2 347
 getrandom 349
+memfd_create 350
diff --git a/testcases/kernel/include/s390x.in b/testcases/kernel/include/s390x.in
index afe94f5..770db7f 100644
--- a/testcases/kernel/include/s390x.in
+++ b/testcases/kernel/include/s390x.in
@@ -329,3 +329,4 @@ sched_setattr 345
 sched_getattr 346
 renameat2 347
 getrandom 349
+memfd_create 350
diff --git a/testcases/kernel/include/sh.in b/testcases/kernel/include/sh.in
index 3cb7e21..0345f8d 100644
--- a/testcases/kernel/include/sh.in
+++ b/testcases/kernel/include/sh.in
@@ -362,3 +362,4 @@ fanotify_init 367
 fanotify_mark 368
 prlimit64 369
 kcmp 378
+memfd_create 385
diff --git a/testcases/kernel/include/sparc.in b/testcases/kernel/include/sparc.in
index f266777..b84c844 100644
--- a/testcases/kernel/include/sparc.in
+++ b/testcases/kernel/include/sparc.in
@@ -334,3 +334,4 @@ prlimit64 331
 kcmp 341
 renameat2 345
 getrandom 347
+memfd_create 348
diff --git a/testcases/kernel/include/sparc64.in b/testcases/kernel/include/sparc64.in
index cb91828..7e0be30 100644
--- a/testcases/kernel/include/sparc64.in
+++ b/testcases/kernel/include/sparc64.in
@@ -310,3 +310,4 @@ prlimit64 331
 kcmp 341
 renameat2 345
 getrandom 347
+memfd_create 348
diff --git a/testcases/kernel/include/x86_64.in b/testcases/kernel/include/x86_64.in
index f54abf4..dec7742 100644
--- a/testcases/kernel/include/x86_64.in
+++ b/testcases/kernel/include/x86_64.in
@@ -305,3 +305,4 @@ sched_setattr 314
 sched_getattr 315
 renameat2 316
 getrandom 318
+memfd_create 319
-- 
1.8.3.1

