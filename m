From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 13 Jun 2019 09:23:59 +0200
Subject: [LTP] [PATCH v3 1/3] lib: add ltp_alloc_stack()
Message-ID: <adca7c08dbf20805da9b99a7fa03d498de70235d.1560410182.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Meant to allocate stack with sufficient alignment for all arches.
Use it in lib/cloner.c instead of malloc().

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 include/tst_clone.h |  1 +
 lib/cloner.c        | 23 ++++++++++++++++++++---
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/include/tst_clone.h b/include/tst_clone.h
index 72145fabe7cd..786cee5d1209 100644
--- a/include/tst_clone.h
+++ b/include/tst_clone.h
@@ -33,6 +33,7 @@ int ltp_clone_malloc(unsigned long clone_flags, int (*fn)(void *arg),
 		void *arg, size_t stacksize);
 int ltp_clone_quick(unsigned long clone_flags, int (*fn)(void *arg),
 		void *arg);
+void *ltp_alloc_stack(size_t size);
 
 #define clone(...) (use_the_ltp_clone_functions__do_not_use_clone)
 
diff --git a/lib/cloner.c b/lib/cloner.c
index 63f223d2a150..cf37184aa22a 100644
--- a/lib/cloner.c
+++ b/lib/cloner.c
@@ -28,8 +28,7 @@
 #include <stdlib.h>
 #include <sched.h>
 #include <stdarg.h>
-#include "test.h"
-#include "config.h"
+#include "tst_clone.h"
 
 #undef clone			/* we want to use clone() */
 
@@ -118,6 +117,24 @@ int ltp_clone7(unsigned long flags, int (*fn)(void *arg), void *arg,
 }
 
 /*
+ * ltp_alloc_stack: allocate stack of size 'size', that is sufficiently
+ * aligned for all arches. User is responsible for freeing allocated
+ * memory.
+ * Returns pointer to new stack. On error, returns NULL with errno set.
+ */
+void *ltp_alloc_stack(size_t size)
+{
+	void *ret = NULL;
+	int err;
+
+	err = posix_memalign(&ret, 64, size);
+	if (err)
+		errno = err;
+
+	return ret;
+}
+
+/*
  * ltp_clone_malloc: also does the memory allocation for clone with a
  * caller-specified size.
  */
@@ -129,7 +146,7 @@ ltp_clone_malloc(unsigned long clone_flags, int (*fn) (void *arg), void *arg,
 	int ret;
 	int saved_errno;
 
-	stack = malloc(stack_size);
+	stack = ltp_alloc_stack(stack_size);
 	if (stack == NULL)
 		return -1;
 
-- 
1.8.3.1

