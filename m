From: Jan Stancek <jstancek@redhat.com>
Date: Thu,  1 Jun 2017 16:02:45 +0200
Subject: [LTP] [PATCH] clone/kcmp: avoid CLONE_VM crashes during ld resolve
Message-ID: <783ae1180822ab04e92acac9688ef6b43fbcf488.1496325577.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Testcases which spawn children via clone(CLONE_VM) are prone
to races in dynamic linker during symbol resolution. CLONE_VM
is causing both parent and child process to share same TLS,
which rarely leads to a crashes, for example:

  Program terminated with signal 4, Illegal instruction.
  [Switching to thread 1 (LWP 30351)]
  (gdb) bt
  #0  _dl_x86_64_restore_sse () at ../sysdeps/x86_64/dl-trampoline.S:389
  #1  0x00007fefa1360625 in _dl_fixup (l=<optimized out>, reloc_arg=<optimized out>) at ../elf/dl-runtime.c:121
  #2  0x00007fefa13670c0 in _dl_runtime_resolve () at ../sysdeps/x86_64/dl-trampoline.S:87
  #3  0x0000000000402e4f in test_FILES () at clone02.c:332
  #4  child_fn () at clone02.c:272
  #5  0x00007fefa10887ad in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:113
  [Switching to thread 2 (LWP 30350)]
  (gdb) bt
  #0  0x00007fefa104f1f2 in __libc_wait (stat_loc=stat_loc@entry=0x7ffe0edb537c) at ../sysdeps/unix/sysv/linux/wait.c:30
  #1  0x000000000040294a in main (ac=<optimized out>, av=<optimized out>) at clone02.c:154

See also:
  http://www.mail-archive.com/utrace-devel@redhat.com/msg01944.html

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/clone/Makefile | 2 ++
 testcases/kernel/syscalls/kcmp/Makefile  | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/testcases/kernel/syscalls/clone/Makefile b/testcases/kernel/syscalls/clone/Makefile
index bd617d806675..2ded37c0028f 100644
--- a/testcases/kernel/syscalls/clone/Makefile
+++ b/testcases/kernel/syscalls/clone/Makefile
@@ -20,4 +20,6 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
+CFLAGS += -Wl,-z,now
+
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/kcmp/Makefile b/testcases/kernel/syscalls/kcmp/Makefile
index 083a071b4eff..cb8a3dea3dc9 100644
--- a/testcases/kernel/syscalls/kcmp/Makefile
+++ b/testcases/kernel/syscalls/kcmp/Makefile
@@ -21,4 +21,6 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
+CFLAGS += -Wl,-z,now
+
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
-- 
1.8.3.1

