From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Tue, 21 Aug 2018 17:38:56 +0800
Subject: [LTP] [PATCH 1/4] lapi/syscalls: Add syscall numbers for mlock2
Message-ID: <1534844339-8655-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
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
index 2c8c589..9ac7f99 100644
--- a/include/lapi/syscalls/aarch64.in
+++ b/include/lapi/syscalls/aarch64.in
@@ -256,5 +256,6 @@ sendmmsg 269
 kcmp 272
 getrandom 278
 memfd_create 279
+mlock2 284
 copy_file_range 285
 _sysctl 1078
diff --git a/include/lapi/syscalls/arm.in b/include/lapi/syscalls/arm.in
index c44adcd..774e1c7 100644
--- a/include/lapi/syscalls/arm.in
+++ b/include/lapi/syscalls/arm.in
@@ -341,4 +341,5 @@ renameat2 (__NR_SYSCALL_BASE+382)
 getrandom (__NR_SYSCALL_BASE+384)
 memfd_create (__NR_SYSCALL_BASE+385)
 execveat (__NR_SYSCALL_BASE+387)
+mlock2 (__NR_SYSCALL_BASE+390)
 copy_file_range (__NR_SYSCALL_BASE+391)
diff --git a/include/lapi/syscalls/hppa.in b/include/lapi/syscalls/hppa.in
index 92aee9f..3db9780 100644
--- a/include/lapi/syscalls/hppa.in
+++ b/include/lapi/syscalls/hppa.in
@@ -17,4 +17,5 @@ splice 291
 tee 293
 vmsplice 294
 memfd_create 340
+mlock2 345
 copy_file_range 346
diff --git a/include/lapi/syscalls/i386.in b/include/lapi/syscalls/i386.in
index 19f0148..6a72b43 100644
--- a/include/lapi/syscalls/i386.in
+++ b/include/lapi/syscalls/i386.in
@@ -341,4 +341,5 @@ renameat2 354
 getrandom 355
 memfd_create 356
 execveat 358
+mlock2 376
 copy_file_range 377
diff --git a/include/lapi/syscalls/ia64.in b/include/lapi/syscalls/ia64.in
index a3abc99..2788193 100644
--- a/include/lapi/syscalls/ia64.in
+++ b/include/lapi/syscalls/ia64.in
@@ -296,4 +296,5 @@ prlimit64 1325
 renameat2 1338
 getrandom 1339
 memfd_create 1340
+mlock2 1346
 copy_file_range 1347
diff --git a/include/lapi/syscalls/powerpc.in b/include/lapi/syscalls/powerpc.in
index 11ddca3..54c1941 100644
--- a/include/lapi/syscalls/powerpc.in
+++ b/include/lapi/syscalls/powerpc.in
@@ -347,4 +347,5 @@ sched_getattr 356
 renameat2 357
 getrandom 359
 memfd_create 360
+mlock2 378
 copy_file_range 379
diff --git a/include/lapi/syscalls/powerpc64.in b/include/lapi/syscalls/powerpc64.in
index 11ddca3..54c1941 100644
--- a/include/lapi/syscalls/powerpc64.in
+++ b/include/lapi/syscalls/powerpc64.in
@@ -347,4 +347,5 @@ sched_getattr 356
 renameat2 357
 getrandom 359
 memfd_create 360
+mlock2 378
 copy_file_range 379
diff --git a/include/lapi/syscalls/s390.in b/include/lapi/syscalls/s390.in
index d95b282..47a04de 100644
--- a/include/lapi/syscalls/s390.in
+++ b/include/lapi/syscalls/s390.in
@@ -332,4 +332,5 @@ renameat2 347
 getrandom 349
 memfd_create 350
 execveat 354
+mlock2 374
 copy_file_range 375
diff --git a/include/lapi/syscalls/s390x.in b/include/lapi/syscalls/s390x.in
index 98c861f..83732ff 100644
--- a/include/lapi/syscalls/s390x.in
+++ b/include/lapi/syscalls/s390x.in
@@ -331,4 +331,5 @@ sched_getattr 346
 renameat2 347
 getrandom 349
 memfd_create 350
+mlock2 374
 copy_file_range 375
diff --git a/include/lapi/syscalls/sh.in b/include/lapi/syscalls/sh.in
index c605b14..407be7a 100644
--- a/include/lapi/syscalls/sh.in
+++ b/include/lapi/syscalls/sh.in
@@ -364,4 +364,5 @@ fanotify_mark 368
 prlimit64 369
 kcmp 378
 memfd_create 385
+mlock2 390
 copy_file_range 391
diff --git a/include/lapi/syscalls/sparc.in b/include/lapi/syscalls/sparc.in
index 296d694..2b06a79 100644
--- a/include/lapi/syscalls/sparc.in
+++ b/include/lapi/syscalls/sparc.in
@@ -336,4 +336,5 @@ kcmp 341
 renameat2 345
 getrandom 347
 memfd_create 348
+mlock2 356
 copy_file_range 357
diff --git a/include/lapi/syscalls/sparc64.in b/include/lapi/syscalls/sparc64.in
index 169347a..8c8a866 100644
--- a/include/lapi/syscalls/sparc64.in
+++ b/include/lapi/syscalls/sparc64.in
@@ -312,4 +312,5 @@ kcmp 341
 renameat2 345
 getrandom 347
 memfd_create 348
+mlock2 356
 copy_file_range 357
diff --git a/include/lapi/syscalls/x86_64.in b/include/lapi/syscalls/x86_64.in
index 7907c31..dec9d3b 100644
--- a/include/lapi/syscalls/x86_64.in
+++ b/include/lapi/syscalls/x86_64.in
@@ -308,4 +308,5 @@ renameat2 316
 getrandom 318
 memfd_create 319
 execveat 322
+mlock2 325
 copy_file_range 326
-- 
1.8.3.1



