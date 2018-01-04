From: Petr Vorel <pvorel@suse.cz>
Date: Thu,  4 Jan 2018 21:42:49 +0100
Subject: [LTP] [RFC PATCH 1/2] tst_atomic.h: Allow to compile on archs
	without atomic support
In-Reply-To: <20180104204250.7032-1-pvorel@suse.cz>
References: <20180104204250.7032-1-pvorel@suse.cz>
Message-ID: <20180104204250.7032-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Some archs without atomic support in compiler and without our own
implementation can now benefit with at least having tests which don't
need atomic support.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/tst_atomic.h | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/include/tst_atomic.h b/include/tst_atomic.h
index 5736d28bb..a4ccb8592 100644
--- a/include/tst_atomic.h
+++ b/include/tst_atomic.h
@@ -61,7 +61,11 @@
 #ifndef TST_ATOMIC_H__
 #define TST_ATOMIC_H__
 
+#include <stdlib.h>
+#include <stdio.h>
+
 #include "config.h"
+#include "tst_res_flags.h"
 
 #if HAVE_ATOMIC_MEMORY_MODEL == 1
 static inline int tst_atomic_add_return(int i, int *v)
@@ -309,8 +313,31 @@ static inline int tst_atomic_add_return(int i, int *v)
 }
 
 #else /* HAVE_SYNC_ADD_AND_FETCH == 1 */
-# error Your compiler does not provide __atomic_add_fetch, __sync_add_and_fetch \
-        and an LTP implementation is missing for your architecture.
+# define LTP_NO_ATOMIC "WARNING: Your compiler does not provide __atomic_add_fetch, " \
+	"__sync_add_and_fetch and an LTP implementation is missing for your architecture. " \
+	"Tests using atomic operations (e.g. using threads on new API or fuzzy synchronization) will not work.\n"
+
+# warning Your compiler does not provide __atomic_add_fetch \
+	__sync_add_and_fetch and an LTP implementation is missing for your architecture. \
+	Tests using atomic operations (e.g. using threads on new API or fuzzy synchronization) will not work.
+
+static inline int tst_atomic_add_return(int i LTP_ATTRIBUTE_UNUSED, int *v LTP_ATTRIBUTE_UNUSED)
+{
+	printf(LTP_NO_ATOMIC);
+	exit(TCONF);
+}
+
+static inline int tst_atomic_load(int *v LTP_ATTRIBUTE_UNUSED)
+{
+	printf(LTP_NO_ATOMIC);
+	exit(TCONF);
+}
+
+static inline void tst_atomic_store(int i LTP_ATTRIBUTE_UNUSED, int *v LTP_ATTRIBUTE_UNUSED)
+{
+	printf(LTP_NO_ATOMIC);
+	exit(TCONF);
+}
 #endif
 
 #ifdef LTP_USE_GENERIC_LOAD_STORE_ASM
-- 
2.15.1

