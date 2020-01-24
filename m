From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 24 Jan 2020 15:23:28 +0530
Subject: [LTP] [PATCH V2 1/2] Add Syscall numbers for io_pgetevents
Message-ID: <d3a4f3d5740a64a51752bba89f2b8e2c5326b78c.1579859350.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V1->V2:
- No changes

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
index 979a0183d4f5..c4e162662c3e 100644
--- a/include/lapi/syscalls/arm.in
+++ b/include/lapi/syscalls/arm.in
@@ -354,5 +354,6 @@ pkey_mprotect (__NR_SYSCALL_BASE+394)
 pkey_alloc (__NR_SYSCALL_BASE+395)
 pkey_free (__NR_SYSCALL_BASE+396)
 statx (__NR_SYSCALL_BASE+397)
+io_pgetevents (__NR_SYSCALL_BASE+399)
 pidfd_send_signal (__NR_SYSCALL_BASE+424)
 pidfd_open (__NR_SYSCALL_BASE+434)
diff --git a/include/lapi/syscalls/hppa.in b/include/lapi/syscalls/hppa.in
index b0807ca6b69f..71486f30d8ca 100644
--- a/include/lapi/syscalls/hppa.in
+++ b/include/lapi/syscalls/hppa.in
@@ -26,5 +26,6 @@ mlock2 345
 copy_file_range 346
 preadv2 347
 pwritev2 348
+io_pgetevents 350
 pidfd_send_signal 424
 pidfd_open 434
diff --git a/include/lapi/syscalls/i386.in b/include/lapi/syscalls/i386.in
index f19e24bd63c9..ec47ca123a1f 100644
--- a/include/lapi/syscalls/i386.in
+++ b/include/lapi/syscalls/i386.in
@@ -353,5 +353,6 @@ pkey_mprotect 380
 pkey_alloc 381
 pkey_free 382
 statx 383
+io_pgetevents 385
 pidfd_send_signal 424
 pidfd_open 434
diff --git a/include/lapi/syscalls/ia64.in b/include/lapi/syscalls/ia64.in
index 92cc881d933b..e9ae3f0093bf 100644
--- a/include/lapi/syscalls/ia64.in
+++ b/include/lapi/syscalls/ia64.in
@@ -306,6 +306,7 @@ mlock2 1346
 copy_file_range 1347
 preadv2 1348
 pwritev2 1349
+io_pgetevents 1351
 pkey_mprotect 1354
 pkey_alloc 1355
 pkey_free 1356
diff --git a/include/lapi/syscalls/powerpc.in b/include/lapi/syscalls/powerpc.in
index f83f7d233e61..3d27d2f2d0f6 100644
--- a/include/lapi/syscalls/powerpc.in
+++ b/include/lapi/syscalls/powerpc.in
@@ -356,6 +356,7 @@ copy_file_range 379
 preadv2 380
 pwritev2 381
 statx 383
+io_pgetevents 388
 pidfd_send_signal 424
 pidfd_open 434
 pkey_mprotect 386
diff --git a/include/lapi/syscalls/powerpc64.in b/include/lapi/syscalls/powerpc64.in
index f83f7d233e61..3d27d2f2d0f6 100644
--- a/include/lapi/syscalls/powerpc64.in
+++ b/include/lapi/syscalls/powerpc64.in
@@ -356,6 +356,7 @@ copy_file_range 379
 preadv2 380
 pwritev2 381
 statx 383
+io_pgetevents 388
 pidfd_send_signal 424
 pidfd_open 434
 pkey_mprotect 386
diff --git a/include/lapi/syscalls/s390.in b/include/lapi/syscalls/s390.in
index f99aceb71a81..460a17884735 100644
--- a/include/lapi/syscalls/s390.in
+++ b/include/lapi/syscalls/s390.in
@@ -340,6 +340,7 @@ mlock2 374
 copy_file_range 375
 preadv2 376
 pwritev2 377
+io_pgetevents 382
 pkey_mprotect 384
 pkey_alloc 385
 pkey_free 386
diff --git a/include/lapi/syscalls/s390x.in b/include/lapi/syscalls/s390x.in
index 9666095b6bea..00236356df73 100644
--- a/include/lapi/syscalls/s390x.in
+++ b/include/lapi/syscalls/s390x.in
@@ -338,6 +338,7 @@ mlock2 374
 copy_file_range 375
 preadv2 376
 pwritev2 377
+io_pgetevents 382
 pkey_mprotect 384
 pkey_alloc 385
 pkey_free 386
diff --git a/include/lapi/syscalls/sparc.in b/include/lapi/syscalls/sparc.in
index 6c610ba67308..b56b1ae5c748 100644
--- a/include/lapi/syscalls/sparc.in
+++ b/include/lapi/syscalls/sparc.in
@@ -345,6 +345,7 @@ mlock2 356
 copy_file_range 357
 preadv2 358
 pwritev2 359
+io_pgetevents 361
 pkey_mprotect 362
 pkey_alloc 363
 pkey_free 364
diff --git a/include/lapi/syscalls/sparc64.in b/include/lapi/syscalls/sparc64.in
index d20e87926913..8f04d730a5d5 100644
--- a/include/lapi/syscalls/sparc64.in
+++ b/include/lapi/syscalls/sparc64.in
@@ -320,6 +320,7 @@ mlock2 356
 copy_file_range 357
 preadv2 358
 pwritev2 359
+io_pgetevents 361
 pkey_mprotect 362
 pkey_alloc 363
 pkey_free 364
diff --git a/include/lapi/syscalls/x86_64.in b/include/lapi/syscalls/x86_64.in
index cba0080dd27a..8656a84d9b93 100644
--- a/include/lapi/syscalls/x86_64.in
+++ b/include/lapi/syscalls/x86_64.in
@@ -320,5 +320,6 @@ pkey_mprotect 329
 pkey_alloc 330
 pkey_free 331
 statx 332
+io_pgetevents 333
 pidfd_send_signal 424
 pidfd_open 434
-- 
2.21.0.rc0.269.g1a574e7a288b

