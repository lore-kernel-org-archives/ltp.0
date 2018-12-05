From: Jason Xing <kerneljasonxing@linux.alibaba.com>
Date: Wed,  5 Dec 2018 21:43:46 +0800
Subject: [LTP] [PATCH v2 2/2] lapi/syscalls: Add syscall numbers for
	process_vm_readv/_writev
In-Reply-To: <1544017426-10669-1-git-send-email-kerneljasonxing@linux.alibaba.com>
References: <1514394255.82007574.1543913641122.JavaMail.zimbra@redhat.com>
 <1544017426-10669-1-git-send-email-kerneljasonxing@linux.alibaba.com>
Message-ID: <1544017426-10669-2-git-send-email-kerneljasonxing@linux.alibaba.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Jason Xing <kerneljasonxing@linux.alibaba.com>
Signed-off-by: Caspar Zhang <caspar@linux.alibaba.com>
---
 include/lapi/syscalls/aarch64.in   | 2 ++
 include/lapi/syscalls/arm.in       | 2 ++
 include/lapi/syscalls/hppa.in      | 2 ++
 include/lapi/syscalls/i386.in      | 2 ++
 include/lapi/syscalls/ia64.in      | 2 ++
 include/lapi/syscalls/powerpc.in   | 2 ++
 include/lapi/syscalls/powerpc64.in | 2 ++
 include/lapi/syscalls/s390.in      | 2 ++
 include/lapi/syscalls/s390x.in     | 2 ++
 include/lapi/syscalls/sh.in        | 2 ++
 include/lapi/syscalls/sparc.in     | 2 ++
 include/lapi/syscalls/sparc64.in   | 2 ++
 include/lapi/syscalls/x86_64.in    | 2 ++
 13 files changed, 26 insertions(+)

diff --git a/include/lapi/syscalls/aarch64.in b/include/lapi/syscalls/aarch64.in
index c7ed2fe..bf04895 100644
--- a/include/lapi/syscalls/aarch64.in
+++ b/include/lapi/syscalls/aarch64.in
@@ -253,6 +253,8 @@ clock_adjtime 266
 syncfs 267
 setns 268
 sendmmsg 269
+process_vm_readv 270
+process_vm_writev 271
 kcmp 272
 getrandom 278
 memfd_create 279
diff --git a/include/lapi/syscalls/arm.in b/include/lapi/syscalls/arm.in
index e63d15b..38de1d5 100644
--- a/include/lapi/syscalls/arm.in
+++ b/include/lapi/syscalls/arm.in
@@ -334,6 +334,8 @@ accept4 (__NR_SYSCALL_BASE+366)
 fanotify_init (__NR_SYSCALL_BASE+367)
 fanotify_mark (__NR_SYSCALL_BASE+368)
 prlimit64 (__NR_SYSCALL_BASE+369)
+process_vm_readv(__NR_SYSCALL_BASE+376)
+process_vm_writev(__NR_SYSCALL_BASE+377)
 kcmp (__NR_SYSCALL_BASE+378)
 sched_setattr (__NR_SYSCALL_BASE+380)
 sched_getattr (__NR_SYSCALL_BASE+381)
diff --git a/include/lapi/syscalls/hppa.in b/include/lapi/syscalls/hppa.in
index 56e89ba..182d393 100644
--- a/include/lapi/syscalls/hppa.in
+++ b/include/lapi/syscalls/hppa.in
@@ -16,6 +16,8 @@ faccessat (__NR_openat + 12)
 splice 291
 tee 293
 vmsplice 294
+process_vm_readv 330
+process_vm_writev 331
 memfd_create 340
 membarrier 343
 execveat 342
diff --git a/include/lapi/syscalls/i386.in b/include/lapi/syscalls/i386.in
index ad14b36..2fb0188 100644
--- a/include/lapi/syscalls/i386.in
+++ b/include/lapi/syscalls/i386.in
@@ -332,6 +332,8 @@ recvmmsg 337
 fanotify_init 338
 fanotify_mark 339
 prlimit64 340
+process_vm_readv 347
+process_vm_writev 348
 kcmp 349
 sched_setattr 351
 sched_getattr 352
diff --git a/include/lapi/syscalls/ia64.in b/include/lapi/syscalls/ia64.in
index 828765f..081c9ed 100644
--- a/include/lapi/syscalls/ia64.in
+++ b/include/lapi/syscalls/ia64.in
@@ -293,6 +293,8 @@ recvmmsg 1322
 fanotify_init 1323
 fanotify_mark 1324
 prlimit64 1325
+process_vm_readv 1332
+process_vm_writev 1333
 renameat2 1338
 getrandom 1339
 memfd_create 1340
diff --git a/include/lapi/syscalls/powerpc.in b/include/lapi/syscalls/powerpc.in
index 6176116..d16f9f9 100644
--- a/include/lapi/syscalls/powerpc.in
+++ b/include/lapi/syscalls/powerpc.in
@@ -339,6 +339,8 @@ recvmsg 342
 recvmmsg 343
 accept4 344
 syscalls 345
+process_vm_readv  351
+process_vm_writev 352
 kcmp 354
 sched_setattr 355
 sched_getattr 356
diff --git a/include/lapi/syscalls/powerpc64.in b/include/lapi/syscalls/powerpc64.in
index 6176116..d16f9f9 100644
--- a/include/lapi/syscalls/powerpc64.in
+++ b/include/lapi/syscalls/powerpc64.in
@@ -339,6 +339,8 @@ recvmsg 342
 recvmmsg 343
 accept4 344
 syscalls 345
+process_vm_readv  351
+process_vm_writev 352
 kcmp 354
 sched_setattr 355
 sched_getattr 356
diff --git a/include/lapi/syscalls/s390.in b/include/lapi/syscalls/s390.in
index fa70d73..4019438 100644
--- a/include/lapi/syscalls/s390.in
+++ b/include/lapi/syscalls/s390.in
@@ -323,6 +323,8 @@ setgid 214
 setfsuid 215
 setfsgid 216
 newfstatat 293
+process_vm_readv 340
+process_vm_writev 341
 kcmp 343
 sched_setattr 345
 sched_getattr 346
diff --git a/include/lapi/syscalls/s390x.in b/include/lapi/syscalls/s390x.in
index fa70d73..4019438 100644
--- a/include/lapi/syscalls/s390x.in
+++ b/include/lapi/syscalls/s390x.in
@@ -323,6 +323,8 @@ setgid 214
 setfsuid 215
 setfsgid 216
 newfstatat 293
+process_vm_readv 340
+process_vm_writev 341
 kcmp 343
 sched_setattr 345
 sched_getattr 346
diff --git a/include/lapi/syscalls/sh.in b/include/lapi/syscalls/sh.in
index f8ae691..8520bb1 100644
--- a/include/lapi/syscalls/sh.in
+++ b/include/lapi/syscalls/sh.in
@@ -360,6 +360,8 @@ accept4 366
 fanotify_init 367
 fanotify_mark 368
 prlimit64 369
+process_vm_readv 376
+process_vm_writev 377
 kcmp 378
 memfd_create 385
 execveat 387
diff --git a/include/lapi/syscalls/sparc.in b/include/lapi/syscalls/sparc.in
index 7d05da2..b7bb135 100644
--- a/include/lapi/syscalls/sparc.in
+++ b/include/lapi/syscalls/sparc.in
@@ -330,6 +330,8 @@ recvmmsg 328
 fanotify_init 329
 fanotify_mark 330
 prlimit64 331
+process_vm_readv 338
+process_vm_writev 339
 kcmp 341
 renameat2 345
 getrandom 347
diff --git a/include/lapi/syscalls/sparc64.in b/include/lapi/syscalls/sparc64.in
index fb305c3..a211df8 100644
--- a/include/lapi/syscalls/sparc64.in
+++ b/include/lapi/syscalls/sparc64.in
@@ -306,6 +306,8 @@ recvmmsg 328
 fanotify_init 329
 fanotify_mark 330
 prlimit64 331
+process_vm_readv 338
+process_vm_writev 339
 kcmp 341
 renameat2 345
 getrandom 347
diff --git a/include/lapi/syscalls/x86_64.in b/include/lapi/syscalls/x86_64.in
index 9504dc5..dae5769 100644
--- a/include/lapi/syscalls/x86_64.in
+++ b/include/lapi/syscalls/x86_64.in
@@ -299,6 +299,8 @@ recvmmsg 299
 fanotify_init 300
 fanotify_mark 301
 prlimit64 302
+process_vm_readv 310
+process_vm_writev 311
 kcmp 312
 sched_setattr 314
 sched_getattr 315
-- 
1.8.3.1

