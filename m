From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 16 Oct 2017 17:42:05 +0200
Subject: [LTP] [PATCH v4 14/14] numa: Remove HAVE_NUMA_MOVE_PAGES definition
In-Reply-To: <20171016154205.4814-1-pvorel@suse.cz>
References: <20171016154205.4814-1-pvorel@suse.cz>
Message-ID: <20171016154205.4814-15-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

numa_move_pages() was added in NUMA API v2 => replace with
HAVE_NUMA_V2 definition.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 m4/ltp-numa.m4                                      | 4 ----
 testcases/kernel/syscalls/move_pages/move_pages01.c | 4 ++--
 testcases/kernel/syscalls/move_pages/move_pages02.c | 4 ++--
 testcases/kernel/syscalls/move_pages/move_pages03.c | 4 ++--
 testcases/kernel/syscalls/move_pages/move_pages04.c | 4 ++--
 testcases/kernel/syscalls/move_pages/move_pages05.c | 4 ++--
 testcases/kernel/syscalls/move_pages/move_pages06.c | 4 ++--
 testcases/kernel/syscalls/move_pages/move_pages07.c | 4 ++--
 testcases/kernel/syscalls/move_pages/move_pages08.c | 4 ++--
 testcases/kernel/syscalls/move_pages/move_pages09.c | 4 ++--
 testcases/kernel/syscalls/move_pages/move_pages10.c | 4 ++--
 testcases/kernel/syscalls/move_pages/move_pages11.c | 4 ++--
 testcases/kernel/syscalls/move_pages/move_pages12.c | 4 ++--
 13 files changed, 24 insertions(+), 28 deletions(-)

diff --git a/m4/ltp-numa.m4 b/m4/ltp-numa.m4
index 56a2b81f7..f199643a1 100644
--- a/m4/ltp-numa.m4
+++ b/m4/ltp-numa.m4
@@ -38,9 +38,5 @@ exit(1);
 	if test "x$have_libnuma" = "xyes" -a "x$have_numa_headers" != "xno" -a "x$have_numa_headers_v2" = "xyes"; then
 		AC_SUBST(NUMA_LIBS, "-lnuma")
 		AC_DEFINE(HAVE_NUMA_V2, 1, [Define to 1 if you have libnuma and it's headers version >= 2 installed.])
-
-		AC_CHECK_LIB(numa, numa_move_pages, [
-			AC_DEFINE(HAVE_NUMA_MOVE_PAGES, 1, [Define to 1 if you have `numa_move_pages' function.])
-		])
 	fi
 ])
diff --git a/testcases/kernel/syscalls/move_pages/move_pages01.c b/testcases/kernel/syscalls/move_pages/move_pages01.c
index 6f9bd896d..e86c5fc80 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages01.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages01.c
@@ -72,7 +72,7 @@ int main(int argc, char **argv)
 
 	setup();
 
-#if HAVE_NUMA_MOVE_PAGES
+#ifdef HAVE_NUMA_V2
 	int lc;
 
 	/* check for looping state if -i option is given */
@@ -101,7 +101,7 @@ int main(int argc, char **argv)
 
 	}
 #else
-	tst_resm(TCONF, "move_pages support not found.");
+	tst_resm(TCONF, "test requires libnuma >= 2 and it's development packages");
 #endif
 
 	cleanup();
diff --git a/testcases/kernel/syscalls/move_pages/move_pages02.c b/testcases/kernel/syscalls/move_pages/move_pages02.c
index 23594ab1b..ee84b92a7 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages02.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages02.c
@@ -73,7 +73,7 @@ int main(int argc, char **argv)
 
 	setup();
 
-#if HAVE_NUMA_MOVE_PAGES
+#ifdef HAVE_NUMA_V2
 	unsigned int i;
 	int lc;
 	unsigned int from_node;
@@ -117,7 +117,7 @@ int main(int argc, char **argv)
 		free_pages(pages, TEST_PAGES);
 	}
 #else
-	tst_resm(TCONF, "move_pages support not found.");
+	tst_resm(TCONF, "test requires libnuma >= 2 and it's development packages");
 #endif
 
 	cleanup();
diff --git a/testcases/kernel/syscalls/move_pages/move_pages03.c b/testcases/kernel/syscalls/move_pages/move_pages03.c
index ec036e610..f3f4fd9c1 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages03.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages03.c
@@ -111,7 +111,7 @@ int main(int argc, char **argv)
 
 	setup();
 
-#if HAVE_NUMA_MOVE_PAGES
+#ifdef HAVE_NUMA_V2
 	unsigned int i;
 	int lc;
 	unsigned int from_node;
@@ -183,7 +183,7 @@ err_free_pages:
 		free_shared_pages(pages, TEST_PAGES);
 	}
 #else
-	tst_resm(TCONF, "move_pages support not found.");
+	tst_resm(TCONF, "test requires libnuma >= 2 and it's development packages");
 #endif
 
 	cleanup();
diff --git a/testcases/kernel/syscalls/move_pages/move_pages04.c b/testcases/kernel/syscalls/move_pages/move_pages04.c
index 0182538c0..3678df0e0 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages04.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages04.c
@@ -84,7 +84,7 @@ int main(int argc, char **argv)
 
 	setup();
 
-#if HAVE_NUMA_MOVE_PAGES
+#ifdef HAVE_NUMA_V2
 	unsigned int i;
 	int lc;
 	unsigned int from_node;
@@ -150,7 +150,7 @@ err_free_pages:
 		free_pages(pages, TEST_PAGES);
 	}
 #else
-	tst_resm(TCONF, "move_pages support not found.");
+	tst_resm(TCONF, "test requires libnuma >= 2 and it's development packages");
 #endif
 
 	cleanup();
diff --git a/testcases/kernel/syscalls/move_pages/move_pages05.c b/testcases/kernel/syscalls/move_pages/move_pages05.c
index 10264ef20..da9642e7e 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages05.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages05.c
@@ -112,7 +112,7 @@ int main(int argc, char **argv)
 
 	setup();
 
-#if HAVE_NUMA_MOVE_PAGES
+#ifdef HAVE_NUMA_V2
 	unsigned int i;
 	int lc;
 	unsigned int from_node;
@@ -198,7 +198,7 @@ err_free_shared:
 		free_shared_pages(pages + SHARED_PAGE, N_SHARED_PAGES);
 	}
 #else
-	tst_resm(TCONF, "move_pages support not found.");
+	tst_resm(TCONF, "test requires libnuma >= 2 and it's development packages");
 #endif
 
 	cleanup();
diff --git a/testcases/kernel/syscalls/move_pages/move_pages06.c b/testcases/kernel/syscalls/move_pages/move_pages06.c
index 847fc6279..0edb58218 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages06.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages06.c
@@ -73,7 +73,7 @@ int main(int argc, char **argv)
 
 	setup();
 
-#if HAVE_NUMA_MOVE_PAGES
+#ifdef HAVE_NUMA_V2
 	unsigned int i;
 	int lc;
 	unsigned int from_node;
@@ -113,7 +113,7 @@ int main(int argc, char **argv)
 		free_pages(pages, TEST_PAGES);
 	}
 #else
-	tst_resm(TCONF, "move_pages support not found.");
+	tst_resm(TCONF, "test requires libnuma >= 2 and it's development packages");
 #endif
 
 	cleanup();
diff --git a/testcases/kernel/syscalls/move_pages/move_pages07.c b/testcases/kernel/syscalls/move_pages/move_pages07.c
index b8653bd8c..0ed54b77a 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages07.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages07.c
@@ -73,7 +73,7 @@ int main(int argc, char **argv)
 
 	setup();
 
-#if HAVE_NUMA_MOVE_PAGES
+#ifdef HAVE_NUMA_V2
 	unsigned int i;
 	int lc;
 	unsigned int from_node;
@@ -115,7 +115,7 @@ int main(int argc, char **argv)
 		free_pages(pages, TEST_PAGES);
 	}
 #else
-	tst_resm(TCONF, "move_pages support not found.");
+	tst_resm(TCONF, "test requires libnuma >= 2 and it's development packages");
 #endif
 
 	cleanup();
diff --git a/testcases/kernel/syscalls/move_pages/move_pages08.c b/testcases/kernel/syscalls/move_pages/move_pages08.c
index 66544eb2a..bf237f35e 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages08.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages08.c
@@ -74,7 +74,7 @@ int main(int argc, char **argv)
 
 	setup();
 
-#if HAVE_NUMA_MOVE_PAGES
+#ifdef HAVE_NUMA_V2
 	unsigned int i;
 	int lc;
 	unsigned int from_node;
@@ -113,7 +113,7 @@ int main(int argc, char **argv)
 		free_pages(pages, TEST_PAGES);
 	}
 #else
-	tst_resm(TCONF, "move_pages support not found.");
+	tst_resm(TCONF, "test requires libnuma >= 2 and it's development packages");
 #endif
 
 	cleanup();
diff --git a/testcases/kernel/syscalls/move_pages/move_pages09.c b/testcases/kernel/syscalls/move_pages/move_pages09.c
index d217fc2a1..2d9dc4680 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages09.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages09.c
@@ -73,7 +73,7 @@ int main(int argc, char **argv)
 
 	setup();
 
-#if HAVE_NUMA_MOVE_PAGES
+#ifdef HAVE_NUMA_V2
 	unsigned int i;
 	int lc;
 	unsigned int from_node;
@@ -125,7 +125,7 @@ int main(int argc, char **argv)
 		free_pages(pages, TEST_PAGES);
 	}
 #else
-	tst_resm(TCONF, "move_pages support not found.");
+	tst_resm(TCONF, "test requires libnuma >= 2 and it's development packages");
 #endif
 
 	cleanup();
diff --git a/testcases/kernel/syscalls/move_pages/move_pages10.c b/testcases/kernel/syscalls/move_pages/move_pages10.c
index 1777ff465..7044135fa 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages10.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages10.c
@@ -73,7 +73,7 @@ int main(int argc, char **argv)
 
 	setup();
 
-#if HAVE_NUMA_MOVE_PAGES
+#ifdef HAVE_NUMA_V2
 	unsigned int i;
 	int lc;
 	unsigned int from_node;
@@ -112,7 +112,7 @@ int main(int argc, char **argv)
 		free_pages(pages, TEST_PAGES);
 	}
 #else
-	tst_resm(TCONF, "move_pages support not found.");
+	tst_resm(TCONF, "test requires libnuma >= 2 and it's development packages");
 #endif
 
 	cleanup();
diff --git a/testcases/kernel/syscalls/move_pages/move_pages11.c b/testcases/kernel/syscalls/move_pages/move_pages11.c
index 773e9c569..a9d84c5d5 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages11.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages11.c
@@ -112,7 +112,7 @@ int main(int argc, char **argv)
 
 	setup();
 
-#if HAVE_NUMA_MOVE_PAGES
+#ifdef HAVE_NUMA_V2
 	unsigned int i;
 	int lc;
 	unsigned int from_node;
@@ -186,7 +186,7 @@ err_free_pages:
 		free_shared_pages(pages, TEST_PAGES);
 	}
 #else
-	tst_resm(TCONF, "move_pages support not found.");
+	tst_resm(TCONF, "test requires libnuma >= 2 and it's development packages");
 #endif
 
 	cleanup();
diff --git a/testcases/kernel/syscalls/move_pages/move_pages12.c b/testcases/kernel/syscalls/move_pages/move_pages12.c
index 4c7d5c2c0..1ac7bc1c4 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages12.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages12.c
@@ -43,7 +43,7 @@
 #include "move_pages_support.h"
 #include "lapi/mmap.h"
 
-#if HAVE_NUMA_MOVE_PAGES
+#ifdef HAVE_NUMA_V2
 
 #define LOOPS	1000
 #define PATH_MEMINFO	"/proc/meminfo"
@@ -267,5 +267,5 @@ static struct tst_test test = {
 };
 
 #else
-	TST_TEST_TCONF("move_pages support not found");
+	TST_TEST_TCONF("test requires libnuma >= 2 and it's development packages");
 #endif
-- 
2.14.2

