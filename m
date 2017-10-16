From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 16 Oct 2017 17:42:04 +0200
Subject: [LTP] [PATCH v4 13/14] numa: Remove HAVE_NUMA_ALLOC_ONNODE
	definition
In-Reply-To: <20171016154205.4814-1-pvorel@suse.cz>
References: <20171016154205.4814-1-pvorel@suse.cz>
Message-ID: <20171016154205.4814-14-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

numa_alloc_onnode() was added in libnuma v0.6 and we require
NUMA API v2 => replace with HAVE_NUMA_V2 definition.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/config.h.default                                  | 3 ---
 m4/ltp-numa.m4                                            | 3 ---
 testcases/kernel/syscalls/move_pages/move_pages_support.c | 4 ++--
 3 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/include/config.h.default b/include/config.h.default
index ef6a3d55f..8b245fce0 100644
--- a/include/config.h.default
+++ b/include/config.h.default
@@ -125,9 +125,6 @@
 /* 2.6 version of swapon/swapoff */
 #define HAVE_NEW_SWAPONOFF 1
 
-/* Define to 1 if you have the `numa_alloc_onnode' function. */
-#undef HAVE_NUMA_ALLOC_ONNODE
-
 /* Define to 1 if you have the <numa.h> header file. */
 #undef HAVE_NUMA_H
 
diff --git a/m4/ltp-numa.m4 b/m4/ltp-numa.m4
index 547fa58a5..56a2b81f7 100644
--- a/m4/ltp-numa.m4
+++ b/m4/ltp-numa.m4
@@ -39,9 +39,6 @@ exit(1);
 		AC_SUBST(NUMA_LIBS, "-lnuma")
 		AC_DEFINE(HAVE_NUMA_V2, 1, [Define to 1 if you have libnuma and it's headers version >= 2 installed.])
 
-		AC_CHECK_LIB(numa, numa_alloc_onnode, [
-			AC_DEFINE(HAVE_NUMA_ALLOC_ONNODE, 1, [Define to 1 if you have `numa_alloc_onnode' function.])
-		])
 		AC_CHECK_LIB(numa, numa_move_pages, [
 			AC_DEFINE(HAVE_NUMA_MOVE_PAGES, 1, [Define to 1 if you have `numa_move_pages' function.])
 		])
diff --git a/testcases/kernel/syscalls/move_pages/move_pages_support.c b/testcases/kernel/syscalls/move_pages/move_pages_support.c
index 340a715fc..31f74968f 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages_support.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages_support.c
@@ -63,7 +63,7 @@ void free_pages(void **pages, unsigned int num)
 int alloc_pages_on_nodes(void **pages, unsigned int num, int *nodes)
 {
 	int i;
-#if HAVE_NUMA_ALLOC_ONNODE
+#ifdef HAVE_NUMA_V2
 	size_t onepage = get_page_size();
 #endif
 
@@ -74,7 +74,7 @@ int alloc_pages_on_nodes(void **pages, unsigned int num, int *nodes)
 	for (i = 0; i < num; i++) {
 		char *page;
 
-#if HAVE_NUMA_ALLOC_ONNODE
+#ifdef HAVE_NUMA_V2
 		pages[i] = numa_alloc_onnode(onepage, nodes[i]);
 #endif
 		if (pages[i] == NULL) {
-- 
2.14.2

