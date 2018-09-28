From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 28 Sep 2018 17:10:49 +0800
Subject: [LTP] [PATCH 1/3] lapi/syscalls: Add syscall numbers for preadv2
Message-ID: <1538125851-26738-1-git-send-email-yangx.jy@cn.fujitsu.com>
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
index 9ac7f99..0b6ba3b 100644
--- a/include/lapi/syscalls/aarch64.in
+++ b/include/lapi/syscalls/aarch64.in
@@ -258,4 +258,5 @@ getrandom 278
 memfd_create 279
 mlock2 284
 copy_file_range 285
+preadv2 286
 _sysctl 1078
diff --git a/include/lapi/syscalls/arm.in b/include/lapi/syscalls/arm.in
index 0a7f98a..279130f 100644
--- a/include/lapi/syscalls/arm.in
+++ b/include/lapi/syscalls/arm.in
@@ -343,4 +343,5 @@ memfd_create (__NR_SYSCALL_BASE+385)
 execveat (__NR_SYSCALL_BASE+387)
 mlock2 (__NR_SYSCALL_BASE+390)
 copy_file_range (__NR_SYSCALL_BASE+391)
+preadv2 (__NR_SYSCALL_BASE+392)
 statx (__NR_SYSCALL_BASE+397)
diff --git a/include/lapi/syscalls/hppa.in b/include/lapi/syscalls/hppa.in
index 3db9780..0fa6f4e 100644
--- a/include/lapi/syscalls/hppa.in
+++ b/include/lapi/syscalls/hppa.in
@@ -19,3 +19,4 @@ vmsplice 294
 memfd_create 340
 mlock2 345
 copy_file_range 346
+preadv2 347
diff --git a/include/lapi/syscalls/i386.in b/include/lapi/syscalls/i386.in
index a000564..ee8c4e9 100644
--- a/include/lapi/syscalls/i386.in
+++ b/include/lapi/syscalls/i386.in
@@ -343,4 +343,5 @@ memfd_create 356
 execveat 358
 mlock2 376
 copy_file_range 377
+preadv2 378
 statx 383
diff --git a/include/lapi/syscalls/ia64.in b/include/lapi/syscalls/ia64.in
index 2788193..b9f00bc 100644
--- a/include/lapi/syscalls/ia64.in
+++ b/include/lapi/syscalls/ia64.in
@@ -298,3 +298,4 @@ getrandom 1339
 memfd_create 1340
 mlock2 1346
 copy_file_range 1347
+preadv2 1348
diff --git a/include/lapi/syscalls/powerpc.in b/include/lapi/syscalls/powerpc.in
index c0b4226..1e429f4 100644
--- a/include/lapi/syscalls/powerpc.in
+++ b/include/lapi/syscalls/powerpc.in
@@ -349,4 +349,5 @@ getrandom 359
 memfd_create 360
 mlock2 378
 copy_file_range 379
+preadv2 380
 statx 383
diff --git a/include/lapi/syscalls/powerpc64.in b/include/lapi/syscalls/powerpc64.in
index c0b4226..1e429f4 100644
--- a/include/lapi/syscalls/powerpc64.in
+++ b/include/lapi/syscalls/powerpc64.in
@@ -349,4 +349,5 @@ getrandom 359
 memfd_create 360
 mlock2 378
 copy_file_range 379
+preadv2 380
 statx 383
diff --git a/include/lapi/syscalls/s390.in b/include/lapi/syscalls/s390.in
index 47a04de..8780815 100644
--- a/include/lapi/syscalls/s390.in
+++ b/include/lapi/syscalls/s390.in
@@ -334,3 +334,4 @@ memfd_create 350
 execveat 354
 mlock2 374
 copy_file_range 375
+preadv2 376
diff --git a/include/lapi/syscalls/s390x.in b/include/lapi/syscalls/s390x.in
index 83732ff..b029e72 100644
--- a/include/lapi/syscalls/s390x.in
+++ b/include/lapi/syscalls/s390x.in
@@ -333,3 +333,4 @@ getrandom 349
 memfd_create 350
 mlock2 374
 copy_file_range 375
+preadv2 376
diff --git a/include/lapi/syscalls/sh.in b/include/lapi/syscalls/sh.in
index 407be7a..ebf8dad 100644
--- a/include/lapi/syscalls/sh.in
+++ b/include/lapi/syscalls/sh.in
@@ -366,3 +366,4 @@ kcmp 378
 memfd_create 385
 mlock2 390
 copy_file_range 391
+preadv2 392
diff --git a/include/lapi/syscalls/sparc.in b/include/lapi/syscalls/sparc.in
index 2b06a79..8d8a54e 100644
--- a/include/lapi/syscalls/sparc.in
+++ b/include/lapi/syscalls/sparc.in
@@ -338,3 +338,4 @@ getrandom 347
 memfd_create 348
 mlock2 356
 copy_file_range 357
+preadv2 358
diff --git a/include/lapi/syscalls/sparc64.in b/include/lapi/syscalls/sparc64.in
index 8c8a866..140e9ce 100644
--- a/include/lapi/syscalls/sparc64.in
+++ b/include/lapi/syscalls/sparc64.in
@@ -314,3 +314,4 @@ getrandom 347
 memfd_create 348
 mlock2 356
 copy_file_range 357
+preadv2 358
diff --git a/include/lapi/syscalls/x86_64.in b/include/lapi/syscalls/x86_64.in
index 4ce8477..1966da2 100644
--- a/include/lapi/syscalls/x86_64.in
+++ b/include/lapi/syscalls/x86_64.in
@@ -310,4 +310,5 @@ memfd_create 319
 execveat 322
 mlock2 325
 copy_file_range 326
+preadv2 327
 statx 332
-- 
1.8.3.1



