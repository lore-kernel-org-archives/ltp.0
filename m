From: Jinhui huang <huangjh.jy@cn.fujitsu.com>
Date: Tue, 25 Sep 2018 16:18:54 +0800
Subject: [LTP] [PATCH 1/2] lapi/syscalls: Add syscall numbers for execveat
Message-ID: <1537863535-25744-1-git-send-email-huangjh.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Jinhui huang <huangjh.jy@cn.fujitsu.com>
---
 include/lapi/syscalls/aarch64.in   | 1 +
 include/lapi/syscalls/hppa.in      | 1 +
 include/lapi/syscalls/ia64.in      | 1 +
 include/lapi/syscalls/powerpc.in   | 1 +
 include/lapi/syscalls/powerpc64.in | 1 +
 include/lapi/syscalls/s390x.in     | 1 +
 include/lapi/syscalls/sh.in        | 1 +
 include/lapi/syscalls/sparc.in     | 1 +
 include/lapi/syscalls/sparc64.in   | 1 +
 9 files changed, 9 insertions(+)

diff --git a/include/lapi/syscalls/aarch64.in b/include/lapi/syscalls/aarch64.in
index 9ac7f99..b39a923 100644
--- a/include/lapi/syscalls/aarch64.in
+++ b/include/lapi/syscalls/aarch64.in
@@ -256,6 +256,7 @@ sendmmsg 269
 kcmp 272
 getrandom 278
 memfd_create 279
+execveat 281
 mlock2 284
 copy_file_range 285
 _sysctl 1078
diff --git a/include/lapi/syscalls/hppa.in b/include/lapi/syscalls/hppa.in
index 3db9780..f90fe1b 100644
--- a/include/lapi/syscalls/hppa.in
+++ b/include/lapi/syscalls/hppa.in
@@ -17,5 +17,6 @@ splice 291
 tee 293
 vmsplice 294
 memfd_create 340
+execveat 342
 mlock2 345
 copy_file_range 346
diff --git a/include/lapi/syscalls/ia64.in b/include/lapi/syscalls/ia64.in
index 2788193..b239643 100644
--- a/include/lapi/syscalls/ia64.in
+++ b/include/lapi/syscalls/ia64.in
@@ -296,5 +296,6 @@ prlimit64 1325
 renameat2 1338
 getrandom 1339
 memfd_create 1340
+execveat 1342
 mlock2 1346
 copy_file_range 1347
diff --git a/include/lapi/syscalls/powerpc.in b/include/lapi/syscalls/powerpc.in
index c0b4226..588e152 100644
--- a/include/lapi/syscalls/powerpc.in
+++ b/include/lapi/syscalls/powerpc.in
@@ -347,6 +347,7 @@ sched_getattr 356
 renameat2 357
 getrandom 359
 memfd_create 360
+execveat 362
 mlock2 378
 copy_file_range 379
 statx 383
diff --git a/include/lapi/syscalls/powerpc64.in b/include/lapi/syscalls/powerpc64.in
index c0b4226..588e152 100644
--- a/include/lapi/syscalls/powerpc64.in
+++ b/include/lapi/syscalls/powerpc64.in
@@ -347,6 +347,7 @@ sched_getattr 356
 renameat2 357
 getrandom 359
 memfd_create 360
+execveat 362
 mlock2 378
 copy_file_range 379
 statx 383
diff --git a/include/lapi/syscalls/s390x.in b/include/lapi/syscalls/s390x.in
index 83732ff..47a04de 100644
--- a/include/lapi/syscalls/s390x.in
+++ b/include/lapi/syscalls/s390x.in
@@ -331,5 +331,6 @@ sched_getattr 346
 renameat2 347
 getrandom 349
 memfd_create 350
+execveat 354
 mlock2 374
 copy_file_range 375
diff --git a/include/lapi/syscalls/sh.in b/include/lapi/syscalls/sh.in
index 407be7a..e3db4f0 100644
--- a/include/lapi/syscalls/sh.in
+++ b/include/lapi/syscalls/sh.in
@@ -364,5 +364,6 @@ fanotify_mark 368
 prlimit64 369
 kcmp 378
 memfd_create 385
+execveat 387
 mlock2 390
 copy_file_range 391
diff --git a/include/lapi/syscalls/sparc.in b/include/lapi/syscalls/sparc.in
index 2b06a79..4c094ef 100644
--- a/include/lapi/syscalls/sparc.in
+++ b/include/lapi/syscalls/sparc.in
@@ -336,5 +336,6 @@ kcmp 341
 renameat2 345
 getrandom 347
 memfd_create 348
+execveat 350
 mlock2 356
 copy_file_range 357
diff --git a/include/lapi/syscalls/sparc64.in b/include/lapi/syscalls/sparc64.in
index 8c8a866..b94f442 100644
--- a/include/lapi/syscalls/sparc64.in
+++ b/include/lapi/syscalls/sparc64.in
@@ -312,5 +312,6 @@ kcmp 341
 renameat2 345
 getrandom 347
 memfd_create 348
+execveat 350
 mlock2 356
 copy_file_range 357
-- 
1.8.3.1



