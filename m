From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 29 Jan 2020 11:27:56 +0530
Subject: [LTP] [PATCH 2/2] Add Syscall numbers for io_uring_* syscalls
In-Reply-To: <6ea999de18b214e694d336582d2c19e507eabade.1580277453.git.viresh.kumar@linaro.org>
References: <6ea999de18b214e694d336582d2c19e507eabade.1580277453.git.viresh.kumar@linaro.org>
Message-ID: <818498fc5fa11618aba150929c35b86325188316.1580277453.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This add syscall numbers for io_uring_setup, io_uring_enter and
io_uring_register syscalls.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 include/lapi/syscalls/aarch64.in   | 3 +++
 include/lapi/syscalls/arm.in       | 3 +++
 include/lapi/syscalls/hppa.in      | 3 +++
 include/lapi/syscalls/i386.in      | 3 +++
 include/lapi/syscalls/ia64.in      | 3 +++
 include/lapi/syscalls/powerpc.in   | 3 +++
 include/lapi/syscalls/powerpc64.in | 3 +++
 include/lapi/syscalls/s390.in      | 3 +++
 include/lapi/syscalls/s390x.in     | 3 +++
 include/lapi/syscalls/sh.in        | 3 +++
 include/lapi/syscalls/sparc.in     | 3 +++
 include/lapi/syscalls/sparc64.in   | 3 +++
 include/lapi/syscalls/x86_64.in    | 3 +++
 13 files changed, 39 insertions(+)

diff --git a/include/lapi/syscalls/aarch64.in b/include/lapi/syscalls/aarch64.in
index 7892b2203b73..4a3b4981df99 100644
--- a/include/lapi/syscalls/aarch64.in
+++ b/include/lapi/syscalls/aarch64.in
@@ -271,6 +271,9 @@ pkey_alloc 289
 pkey_free 290
 io_pgetevents 292
 pidfd_send_signal 424
+io_uring_setup 425
+io_uring_enter 426
+io_uring_register 427
 open_tree 428
 move_mount 429
 fsopen 430
diff --git a/include/lapi/syscalls/arm.in b/include/lapi/syscalls/arm.in
index 1ffad674f913..8720a982a159 100644
--- a/include/lapi/syscalls/arm.in
+++ b/include/lapi/syscalls/arm.in
@@ -356,6 +356,9 @@ pkey_free (__NR_SYSCALL_BASE+396)
 statx (__NR_SYSCALL_BASE+397)
 io_pgetevents (__NR_SYSCALL_BASE+399)
 pidfd_send_signal (__NR_SYSCALL_BASE+424)
+io_uring_setup (__NR_SYSCALL_BASE+425)
+io_uring_enter (__NR_SYSCALL_BASE+426)
+io_uring_register (__NR_SYSCALL_BASE+427)
 open_tree (__NR_SYSCALL_BASE+428)
 move_mount (__NR_SYSCALL_BASE+429)
 fsopen (__NR_SYSCALL_BASE+430)
diff --git a/include/lapi/syscalls/hppa.in b/include/lapi/syscalls/hppa.in
index 0f3b4533e0c8..e00d2dc6d37d 100644
--- a/include/lapi/syscalls/hppa.in
+++ b/include/lapi/syscalls/hppa.in
@@ -28,6 +28,9 @@ preadv2 347
 pwritev2 348
 io_pgetevents 350
 pidfd_send_signal 424
+io_uring_setup 425
+io_uring_enter 426
+io_uring_register 427
 open_tree 428
 move_mount 429
 fsopen 430
diff --git a/include/lapi/syscalls/i386.in b/include/lapi/syscalls/i386.in
index 28b6fc0072d3..35162a251e86 100644
--- a/include/lapi/syscalls/i386.in
+++ b/include/lapi/syscalls/i386.in
@@ -355,6 +355,9 @@ pkey_free 382
 statx 383
 io_pgetevents 385
 pidfd_send_signal 424
+io_uring_setup 425
+io_uring_enter 426
+io_uring_register 427
 open_tree 428
 move_mount 429
 fsopen 430
diff --git a/include/lapi/syscalls/ia64.in b/include/lapi/syscalls/ia64.in
index 2dea5c6beabc..9e491b54bded 100644
--- a/include/lapi/syscalls/ia64.in
+++ b/include/lapi/syscalls/ia64.in
@@ -311,6 +311,9 @@ pkey_mprotect 1354
 pkey_alloc 1355
 pkey_free 1356
 pidfd_send_signal 1448
+io_uring_setup 1449
+io_uring_enter 1450
+io_uring_register 1451
 open_tree 1452
 move_mount 1453
 fsopen 1454
diff --git a/include/lapi/syscalls/powerpc.in b/include/lapi/syscalls/powerpc.in
index 8a3a99e847b9..af31bf929319 100644
--- a/include/lapi/syscalls/powerpc.in
+++ b/include/lapi/syscalls/powerpc.in
@@ -362,6 +362,9 @@ pidfd_open 434
 pkey_mprotect 386
 pkey_alloc 384
 pkey_free 385
+io_uring_setup 425
+io_uring_enter 426
+io_uring_register 427
 open_tree 428
 move_mount 429
 fsopen 430
diff --git a/include/lapi/syscalls/powerpc64.in b/include/lapi/syscalls/powerpc64.in
index e4089e572696..2c1f105c1a9e 100644
--- a/include/lapi/syscalls/powerpc64.in
+++ b/include/lapi/syscalls/powerpc64.in
@@ -358,6 +358,9 @@ pwritev2 381
 statx 383
 io_pgetevents 388
 pidfd_send_signal 424
+io_uring_setup 425
+io_uring_enter 426
+io_uring_register 427
 open_tree 428
 move_mount 429
 fsopen 430
diff --git a/include/lapi/syscalls/s390.in b/include/lapi/syscalls/s390.in
index 397bc7be26f1..c23db6514fa6 100644
--- a/include/lapi/syscalls/s390.in
+++ b/include/lapi/syscalls/s390.in
@@ -345,6 +345,9 @@ pkey_mprotect 384
 pkey_alloc 385
 pkey_free 386
 pidfd_send_signal 424
+io_uring_setup 425
+io_uring_enter 426
+io_uring_register 427
 open_tree 428
 move_mount 429
 fsopen 430
diff --git a/include/lapi/syscalls/s390x.in b/include/lapi/syscalls/s390x.in
index dac0bd1b49b1..1acd488a20bc 100644
--- a/include/lapi/syscalls/s390x.in
+++ b/include/lapi/syscalls/s390x.in
@@ -343,6 +343,9 @@ pkey_mprotect 384
 pkey_alloc 385
 pkey_free 386
 pidfd_send_signal 424
+io_uring_setup 425
+io_uring_enter 426
+io_uring_register 427
 open_tree 428
 move_mount 429
 fsopen 430
diff --git a/include/lapi/syscalls/sh.in b/include/lapi/syscalls/sh.in
index 4e0693cdd056..0b06313ae3fc 100644
--- a/include/lapi/syscalls/sh.in
+++ b/include/lapi/syscalls/sh.in
@@ -371,6 +371,9 @@ copy_file_range 391
 preadv2 392
 pwritev2 393
 pidfd_send_signal 424
+io_uring_setup 425
+io_uring_enter 426
+io_uring_register 427
 open_tree 428
 move_mount 429
 fsopen 430
diff --git a/include/lapi/syscalls/sparc.in b/include/lapi/syscalls/sparc.in
index 6b0e4136fcdb..9a8b8d03860e 100644
--- a/include/lapi/syscalls/sparc.in
+++ b/include/lapi/syscalls/sparc.in
@@ -350,6 +350,9 @@ pkey_mprotect 362
 pkey_alloc 363
 pkey_free 364
 pidfd_send_signal 424
+io_uring_setup 425
+io_uring_enter 426
+io_uring_register 427
 open_tree 428
 move_mount 429
 fsopen 430
diff --git a/include/lapi/syscalls/sparc64.in b/include/lapi/syscalls/sparc64.in
index 3a3bf86241a2..efdaa76a1de1 100644
--- a/include/lapi/syscalls/sparc64.in
+++ b/include/lapi/syscalls/sparc64.in
@@ -325,6 +325,9 @@ pkey_mprotect 362
 pkey_alloc 363
 pkey_free 364
 pidfd_send_signal 424
+io_uring_setup 425
+io_uring_enter 426
+io_uring_register 427
 open_tree 428
 move_mount 429
 fsopen 430
diff --git a/include/lapi/syscalls/x86_64.in b/include/lapi/syscalls/x86_64.in
index 414c26b7b459..dd12b7ff838d 100644
--- a/include/lapi/syscalls/x86_64.in
+++ b/include/lapi/syscalls/x86_64.in
@@ -322,6 +322,9 @@ pkey_free 331
 statx 332
 io_pgetevents 333
 pidfd_send_signal 424
+io_uring_setup 425
+io_uring_enter 426
+io_uring_register 427
 open_tree 428
 move_mount 429
 fsopen 430
-- 
2.21.0.rc0.269.g1a574e7a288b

