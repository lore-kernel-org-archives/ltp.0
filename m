From: Jan Stancek <jstancek@redhat.com>
Date: Mon,  4 Apr 2016 10:26:27 +0200
Subject: [LTP] [PATCH] testcases/kernel/include/lib.mk: re-order library
	link order
Message-ID: <0d998706a0a9c4c353f3aa31f2c1544007611714.1459758277.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

M.Srikanth Kumar reported a -static build failure:
  gcc -static -pthread
  -L/home/linaro/ltp-master/testcases/kernel/lib
  -L../../../../lib  migrate_pages01.o migrate_pages_common.o
  -lltp
  -lnuma -lkerntest -lltp -o migrate_pages01
  migrate_pages01.o: In function `test_invalid_perm':

  /home/linaro/ltp-master/testcases/kernel/lib/libkerntest.a(numa_helper.o):
  In function `get_max_node':
  /home/linaro/ltp-master/testcases/kernel/lib/numa_helper.c:53:
  undefined reference to `numa_max_possible_node'

  /home/linaro/ltp-master/testcases/kernel/lib/libkerntest.a(numa_helper.o):
  In function `get_allowed_nodes_arr':
  /home/linaro/ltp-master/testcases/kernel/lib/numa_helper.c:177:
  undefined reference to `numa_available'
  ...

Re-order libraries, moving libnuma to the end, to fix linking of
unresolved libnuma symbols.

Reported-and-tested-by: "M.Srikanth Kumar" <srikanth007m@gmail.com>
Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/include/lib.mk | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/include/lib.mk b/testcases/kernel/include/lib.mk
index f79a1c0197e3..5c97ae2c9edf 100644
--- a/testcases/kernel/include/lib.mk
+++ b/testcases/kernel/include/lib.mk
@@ -23,7 +23,7 @@ KERNEL_DIR		:= $(abs_top_builddir)/testcases/kernel
 LIBKERNTEST_DIR		:= $(KERNEL_DIR)/lib
 LIBKERNTEST		:= $(LIBKERNTEST_DIR)/libkerntest.a
 CPPFLAGS		+= $(NUMA_CPPFLAGS) -I$(KERNEL_SRCDIR)/include
-LDLIBS			+= $(NUMA_LIBS) -lkerntest -lltp
+LDLIBS			+= -lkerntest -lltp $(NUMA_LIBS)
 LDFLAGS			+= -L$(LIBKERNTEST_DIR)
 
 $(LIBKERNTEST_DIR):
-- 
1.8.3.1

