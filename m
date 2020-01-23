From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 23 Jan 2020 10:31:23 +0530
Subject: [LTP] [PATCH 1/2] Add Syscall numbers for io_pgetevents
Message-ID: <f9e9bc067d1153199440512d6ece01f7a001b660.1579755655.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
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
 include/lapi/syscalls/sparc.in     | 1 +
 include/lapi/syscalls/sparc64.in   | 1 +
 include/lapi/syscalls/x86_64.in    | 1 +
 12 files changed, 12 insertions(+)

diff --git a/include/lapi/syscalls/aarch64.in b/include/lapi/syscalls/aarch64.in
index 19f3aa4475bd..25e1b27e9867 100644
--- a/include/lapi/syscalls/aarch64.in
+++ b/include/lapi/syscalls/aarch64.in
@@ -269,6 +269,7 @@ pwritev2 287
 pkey_mprotect 288
 pkey_alloc 289
 pkey_free 290
+io_pgetevents 292
 pidfd_send_signal 424
 pidfd_open 434
 _sysctl 1078
diff --git a/include/lapi/syscalls/arm.in b/include/lapi/syscalls/arm.in
index 29538ba50d3b..49be125a755c 100644
--- a/include/lapi/syscalls/arm.in
+++ b/include/lapi/syscalls/arm.in
@@ -353,5 +353,6 @@ pkey_mprotect (__NR_SYSCALL_BASE+394)
 pkey_alloc (__NR_SYSCALL_BASE+395)
 pkey_free (__NR_SYSCALL_BASE+396)
 statx (__NR_SYSCALL_BASE+397)
+io_pgetevents (__NR_SYSCALL_BASE+399)
 pidfd_send_signal (__NR_SYSCALL_BASE+424)
 pidfd_open (__NR_SYSCALL_BASE+434)
diff --git a/include/lapi/syscalls/hppa.in b/include/lapi/syscalls/hppa.in
index b578d886516d..b11c8fbcf71f 100644
--- a/include/lapi/syscalls/hppa.in
+++ b/include/lapi/syscalls/hppa.in
@@ -25,5 +25,6 @@ mlock2 345
 copy_file_range 346
 preadv2 347
 pwritev2 348
+io_pgetevents 350
 pidfd_send_signal 424
 pidfd_open 434
diff --git a/include/lapi/syscalls/i386.in b/include/lapi/syscalls/i386.in
index 696563ebba48..40b84ca89f9b 100644
--- a/include/lapi/syscalls/i386.in
+++ b/include/lapi/syscalls/i386.in
@@ -352,5 +352,6 @@ pkey_mprotect 380
 pkey_alloc 381
 pkey_free 382
 statx 383
+io_pgetevents 385
 pidfd_send_signal 424
 pidfd_open 434
diff --git a/include/lapi/syscalls/ia64.in b/include/lapi/syscalls/ia64.in
index 11b236c7c507..675adda18703 100644
--- a/include/lapi/syscalls/ia64.in
+++ b/include/lapi/syscalls/ia64.in
@@ -305,6 +305,7 @@ mlock2 1346
 copy_file_range 1347
 preadv2 1348
 pwritev2 1349
+io_pgetevents 1351
 pkey_mprotect 1354
 pkey_alloc 1355
 pkey_free 1356
diff --git a/include/lapi/syscalls/powerpc.in b/include/lapi/syscalls/powerpc.in
index 293d86ba54c4..88c42924b306 100644
--- a/include/lapi/syscalls/powerpc.in
+++ b/include/lapi/syscalls/powerpc.in
@@ -355,6 +355,7 @@ copy_file_range 379
 preadv2 380
 pwritev2 381
 statx 383
+io_pgetevents 388
 pidfd_send_signal 424
 pidfd_open 434
 pkey_mprotect 386
diff --git a/include/lapi/syscalls/powerpc64.in b/include/lapi/syscalls/powerpc64.in
index 293d86ba54c4..88c42924b306 100644
--- a/include/lapi/syscalls/powerpc64.in
+++ b/include/lapi/syscalls/powerpc64.in
@@ -355,6 +355,7 @@ copy_file_range 379
 preadv2 380
 pwritev2 381
 statx 383
+io_pgetevents 388
 pidfd_send_signal 424
 pidfd_open 434
 pkey_mprotect 386
diff --git a/include/lapi/syscalls/s390.in b/include/lapi/syscalls/s390.in
index 4f4b2dbed5ef..dbeaea70f59c 100644
--- a/include/lapi/syscalls/s390.in
+++ b/include/lapi/syscalls/s390.in
@@ -339,6 +339,7 @@ mlock2 374
 copy_file_range 375
 preadv2 376
 pwritev2 377
+io_pgetevents 382
 pkey_mprotect 384
 pkey_alloc 385
 pkey_free 386
diff --git a/include/lapi/syscalls/s390x.in b/include/lapi/syscalls/s390x.in
index 673538a7217e..6bacacba1468 100644
--- a/include/lapi/syscalls/s390x.in
+++ b/include/lapi/syscalls/s390x.in
@@ -337,6 +337,7 @@ mlock2 374
 copy_file_range 375
 preadv2 376
 pwritev2 377
+io_pgetevents 382
 pkey_mprotect 384
 pkey_alloc 385
 pkey_free 386
diff --git a/include/lapi/syscalls/sparc.in b/include/lapi/syscalls/sparc.in
index 2b33c4983088..b5f269222f8b 100644
--- a/include/lapi/syscalls/sparc.in
+++ b/include/lapi/syscalls/sparc.in
@@ -344,6 +344,7 @@ mlock2 356
 copy_file_range 357
 preadv2 358
 pwritev2 359
+io_pgetevents 361
 pkey_mprotect 362
 pkey_alloc 363
 pkey_free 364
diff --git a/include/lapi/syscalls/sparc64.in b/include/lapi/syscalls/sparc64.in
index a6157adef7b3..ea191d4745e1 100644
--- a/include/lapi/syscalls/sparc64.in
+++ b/include/lapi/syscalls/sparc64.in
@@ -319,6 +319,7 @@ mlock2 356
 copy_file_range 357
 preadv2 358
 pwritev2 359
+io_pgetevents 361
 pkey_mprotect 362
 pkey_alloc 363
 pkey_free 364
diff --git a/include/lapi/syscalls/x86_64.in b/include/lapi/syscalls/x86_64.in
index 8bd6b66d3bef..d9370b9032d1 100644
--- a/include/lapi/syscalls/x86_64.in
+++ b/include/lapi/syscalls/x86_64.in
@@ -319,5 +319,6 @@ pkey_mprotect 329
 pkey_alloc 330
 pkey_free 331
 statx 332
+io_pgetevents 333
 pidfd_send_signal 424
 pidfd_open 434
-- 
2.21.0.rc0.269.g1a574e7a288b

