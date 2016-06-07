From: Jan Stancek <jstancek@redhat.com>
Date: Tue,  7 Jun 2016 14:09:05 +0200
Subject: [LTP] [PATCH] linux_syscall_numbers: add sched_[get|set]attr for
	ppc and s390
Message-ID: <79dd48009e53a6a887967034b7c20f0c8665325d.1465301288.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

sched_getattr and sched_setattr may fail on powerpc and s390
on kernels > 3.14 with older userspace because LTP defines
syscall numbers only for x86 and arm.

This patch adds also numbers for ppc and s390.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/include/powerpc.in   | 2 ++
 testcases/kernel/include/powerpc64.in | 2 ++
 testcases/kernel/include/s390.in      | 2 ++
 testcases/kernel/include/s390x.in     | 2 ++
 4 files changed, 8 insertions(+)

diff --git a/testcases/kernel/include/powerpc.in b/testcases/kernel/include/powerpc.in
index 3126b11ca30e..5ca42a69ea96 100644
--- a/testcases/kernel/include/powerpc.in
+++ b/testcases/kernel/include/powerpc.in
@@ -341,5 +341,7 @@ recvmmsg 343
 accept4 344
 syscalls 345
 kcmp 354
+sched_setattr 355
+sched_getattr 356
 renameat2 357
 getrandom 359
diff --git a/testcases/kernel/include/powerpc64.in b/testcases/kernel/include/powerpc64.in
index 3126b11ca30e..5ca42a69ea96 100644
--- a/testcases/kernel/include/powerpc64.in
+++ b/testcases/kernel/include/powerpc64.in
@@ -341,5 +341,7 @@ recvmmsg 343
 accept4 344
 syscalls 345
 kcmp 354
+sched_setattr 355
+sched_getattr 356
 renameat2 357
 getrandom 359
diff --git a/testcases/kernel/include/s390.in b/testcases/kernel/include/s390.in
index 15cb06ef859f..afe94f5e21e0 100644
--- a/testcases/kernel/include/s390.in
+++ b/testcases/kernel/include/s390.in
@@ -325,5 +325,7 @@ setfsuid 215
 setfsgid 216
 newfstatat 293
 kcmp 343
+sched_setattr 345
+sched_getattr 346
 renameat2 347
 getrandom 349
diff --git a/testcases/kernel/include/s390x.in b/testcases/kernel/include/s390x.in
index 15cb06ef859f..afe94f5e21e0 100644
--- a/testcases/kernel/include/s390x.in
+++ b/testcases/kernel/include/s390x.in
@@ -325,5 +325,7 @@ setfsuid 215
 setfsgid 216
 newfstatat 293
 kcmp 343
+sched_setattr 345
+sched_getattr 346
 renameat2 347
 getrandom 349
-- 
1.8.3.1

