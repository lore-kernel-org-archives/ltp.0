From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 29 Jan 2020 11:27:55 +0530
Subject: [LTP] [PATCH 1/2] Add syscall numbers for new file-system related
 syscalls
Message-ID: <6ea999de18b214e694d336582d2c19e507eabade.1580277453.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This add syscall numbers for open_tree, move_mount, fsopen, fsconfig,
fsmount and fspick syscalls.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 include/lapi/syscalls/aarch64.in   | 6 ++++++
 include/lapi/syscalls/arm.in       | 6 ++++++
 include/lapi/syscalls/hppa.in      | 6 ++++++
 include/lapi/syscalls/i386.in      | 6 ++++++
 include/lapi/syscalls/ia64.in      | 6 ++++++
 include/lapi/syscalls/powerpc.in   | 6 ++++++
 include/lapi/syscalls/powerpc64.in | 6 ++++++
 include/lapi/syscalls/s390.in      | 6 ++++++
 include/lapi/syscalls/s390x.in     | 6 ++++++
 include/lapi/syscalls/sh.in        | 6 ++++++
 include/lapi/syscalls/sparc.in     | 6 ++++++
 include/lapi/syscalls/sparc64.in   | 6 ++++++
 include/lapi/syscalls/x86_64.in    | 6 ++++++
 13 files changed, 78 insertions(+)

diff --git a/include/lapi/syscalls/aarch64.in b/include/lapi/syscalls/aarch64.in
index 25e1b27e9867..7892b2203b73 100644
--- a/include/lapi/syscalls/aarch64.in
+++ b/include/lapi/syscalls/aarch64.in
@@ -271,5 +271,11 @@ pkey_alloc 289
 pkey_free 290
 io_pgetevents 292
 pidfd_send_signal 424
+open_tree 428
+move_mount 429
+fsopen 430
+fsconfig 431
+fsmount 432
+fspick 433
 pidfd_open 434
 _sysctl 1078
diff --git a/include/lapi/syscalls/arm.in b/include/lapi/syscalls/arm.in
index c4e162662c3e..1ffad674f913 100644
--- a/include/lapi/syscalls/arm.in
+++ b/include/lapi/syscalls/arm.in
@@ -356,4 +356,10 @@ pkey_free (__NR_SYSCALL_BASE+396)
 statx (__NR_SYSCALL_BASE+397)
 io_pgetevents (__NR_SYSCALL_BASE+399)
 pidfd_send_signal (__NR_SYSCALL_BASE+424)
+open_tree (__NR_SYSCALL_BASE+428)
+move_mount (__NR_SYSCALL_BASE+429)
+fsopen (__NR_SYSCALL_BASE+430)
+fsconfig (__NR_SYSCALL_BASE+431)
+fsmount (__NR_SYSCALL_BASE+432)
+fspick (__NR_SYSCALL_BASE+433)
 pidfd_open (__NR_SYSCALL_BASE+434)
diff --git a/include/lapi/syscalls/hppa.in b/include/lapi/syscalls/hppa.in
index 71486f30d8ca..0f3b4533e0c8 100644
--- a/include/lapi/syscalls/hppa.in
+++ b/include/lapi/syscalls/hppa.in
@@ -28,4 +28,10 @@ preadv2 347
 pwritev2 348
 io_pgetevents 350
 pidfd_send_signal 424
+open_tree 428
+move_mount 429
+fsopen 430
+fsconfig 431
+fsmount 432
+fspick 433
 pidfd_open 434
diff --git a/include/lapi/syscalls/i386.in b/include/lapi/syscalls/i386.in
index ec47ca123a1f..28b6fc0072d3 100644
--- a/include/lapi/syscalls/i386.in
+++ b/include/lapi/syscalls/i386.in
@@ -355,4 +355,10 @@ pkey_free 382
 statx 383
 io_pgetevents 385
 pidfd_send_signal 424
+open_tree 428
+move_mount 429
+fsopen 430
+fsconfig 431
+fsmount 432
+fspick 433
 pidfd_open 434
diff --git a/include/lapi/syscalls/ia64.in b/include/lapi/syscalls/ia64.in
index e9ae3f0093bf..2dea5c6beabc 100644
--- a/include/lapi/syscalls/ia64.in
+++ b/include/lapi/syscalls/ia64.in
@@ -311,4 +311,10 @@ pkey_mprotect 1354
 pkey_alloc 1355
 pkey_free 1356
 pidfd_send_signal 1448
+open_tree 1452
+move_mount 1453
+fsopen 1454
+fsconfig 1455
+fsmount 1456
+fspick 1457
 pidfd_open 1458
diff --git a/include/lapi/syscalls/powerpc.in b/include/lapi/syscalls/powerpc.in
index 3d27d2f2d0f6..8a3a99e847b9 100644
--- a/include/lapi/syscalls/powerpc.in
+++ b/include/lapi/syscalls/powerpc.in
@@ -362,3 +362,9 @@ pidfd_open 434
 pkey_mprotect 386
 pkey_alloc 384
 pkey_free 385
+open_tree 428
+move_mount 429
+fsopen 430
+fsconfig 431
+fsmount 432
+fspick 433
diff --git a/include/lapi/syscalls/powerpc64.in b/include/lapi/syscalls/powerpc64.in
index 3d27d2f2d0f6..e4089e572696 100644
--- a/include/lapi/syscalls/powerpc64.in
+++ b/include/lapi/syscalls/powerpc64.in
@@ -358,6 +358,12 @@ pwritev2 381
 statx 383
 io_pgetevents 388
 pidfd_send_signal 424
+open_tree 428
+move_mount 429
+fsopen 430
+fsconfig 431
+fsmount 432
+fspick 433
 pidfd_open 434
 pkey_mprotect 386
 pkey_alloc 384
diff --git a/include/lapi/syscalls/s390.in b/include/lapi/syscalls/s390.in
index 460a17884735..397bc7be26f1 100644
--- a/include/lapi/syscalls/s390.in
+++ b/include/lapi/syscalls/s390.in
@@ -345,4 +345,10 @@ pkey_mprotect 384
 pkey_alloc 385
 pkey_free 386
 pidfd_send_signal 424
+open_tree 428
+move_mount 429
+fsopen 430
+fsconfig 431
+fsmount 432
+fspick 433
 pidfd_open 434
diff --git a/include/lapi/syscalls/s390x.in b/include/lapi/syscalls/s390x.in
index 00236356df73..dac0bd1b49b1 100644
--- a/include/lapi/syscalls/s390x.in
+++ b/include/lapi/syscalls/s390x.in
@@ -343,4 +343,10 @@ pkey_mprotect 384
 pkey_alloc 385
 pkey_free 386
 pidfd_send_signal 424
+open_tree 428
+move_mount 429
+fsopen 430
+fsconfig 431
+fsmount 432
+fspick 433
 pidfd_open 434
diff --git a/include/lapi/syscalls/sh.in b/include/lapi/syscalls/sh.in
index 73549b46e6dd..4e0693cdd056 100644
--- a/include/lapi/syscalls/sh.in
+++ b/include/lapi/syscalls/sh.in
@@ -371,4 +371,10 @@ copy_file_range 391
 preadv2 392
 pwritev2 393
 pidfd_send_signal 424
+open_tree 428
+move_mount 429
+fsopen 430
+fsconfig 431
+fsmount 432
+fspick 433
 pidfd_open 434
diff --git a/include/lapi/syscalls/sparc.in b/include/lapi/syscalls/sparc.in
index b56b1ae5c748..6b0e4136fcdb 100644
--- a/include/lapi/syscalls/sparc.in
+++ b/include/lapi/syscalls/sparc.in
@@ -350,4 +350,10 @@ pkey_mprotect 362
 pkey_alloc 363
 pkey_free 364
 pidfd_send_signal 424
+open_tree 428
+move_mount 429
+fsopen 430
+fsconfig 431
+fsmount 432
+fspick 433
 pidfd_open 434
diff --git a/include/lapi/syscalls/sparc64.in b/include/lapi/syscalls/sparc64.in
index 8f04d730a5d5..3a3bf86241a2 100644
--- a/include/lapi/syscalls/sparc64.in
+++ b/include/lapi/syscalls/sparc64.in
@@ -325,4 +325,10 @@ pkey_mprotect 362
 pkey_alloc 363
 pkey_free 364
 pidfd_send_signal 424
+open_tree 428
+move_mount 429
+fsopen 430
+fsconfig 431
+fsmount 432
+fspick 433
 pidfd_open 434
diff --git a/include/lapi/syscalls/x86_64.in b/include/lapi/syscalls/x86_64.in
index 8656a84d9b93..414c26b7b459 100644
--- a/include/lapi/syscalls/x86_64.in
+++ b/include/lapi/syscalls/x86_64.in
@@ -322,4 +322,10 @@ pkey_free 331
 statx 332
 io_pgetevents 333
 pidfd_send_signal 424
+open_tree 428
+move_mount 429
+fsopen 430
+fsconfig 431
+fsmount 432
+fspick 433
 pidfd_open 434
-- 
2.21.0.rc0.269.g1a574e7a288b

