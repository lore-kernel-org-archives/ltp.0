From: Alexander Gordeev <agordeev@linux.ibm.com>
Date: Fri,  8 May 2020 15:09:03 +0200
Subject: [LTP] [PATCH 2/2] lib/cloner.c: Use __clone instead of clone for
 s390
In-Reply-To: <cover.1588942426.git.agordeev@linux.ibm.com>
References: <cover.1588942426.git.agordeev@linux.ibm.com>
Message-ID: <8f28b9797be3408c0c1086d0a2bc9c052b55bfe2.1588942426.git.agordeev@linux.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The kernel sys_clone and s390 glibc entry __clone assume
the flags parameter type as unsigned long. However, the
glibc clone wrapper used by ltp_clone helper defines flags
as signed int. That leads to gcc extending CLONE_IO flag of
0x80000000 value to 0xffffffff80000000.

A quick solution for s390 is to skip clone weak alias and
use __clone entry point directly.

Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 lib/cloner.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/cloner.c b/lib/cloner.c
index 11401f2..1192e4b 100644
--- a/lib/cloner.c
+++ b/lib/cloner.c
@@ -49,6 +49,11 @@ extern int __clone2(int (*fn) (void *arg), void *child_stack_base,
                     size_t child_stack_size, int flags, void *arg,
                     pid_t *parent_tid, void *tls, pid_t *child_tid);
 #endif
+#if defined(__s390__)
+# define clone __clone
+extern int __clone(int (*fn)(void *arg), void *child_stack, unsigned long flags,
+		   void *arg, pid_t *parent_tid, void *tls, pid_t *child_tid);
+#endif
 
 #ifndef CLONE_SUPPORTS_7_ARGS
 # define clone(fn, stack, flags, arg, ptid, tls, ctid) \
-- 
1.8.3.1

