From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue,  3 Oct 2017 16:19:38 +0200
Subject: [LTP] [COMMITTED] [PATCH 05/40] Make use of SAFE_MUNMAP()
In-Reply-To: <20171003142013.25230-1-chrubis@suse.cz>
References: <20171003142013.25230-1-chrubis@suse.cz>
Message-ID: <20171003142013.25230-5-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/mem/mtest06/mmap1.c                      | 4 ++--
 testcases/kernel/mem/vma/vma01.c                          | 4 ++--
 testcases/kernel/syscalls/cma/process_vm01.c              | 3 +--
 testcases/kernel/syscalls/migrate_pages/migrate_pages01.c | 3 +--
 testcases/kernel/syscalls/mlock/mlock04.c                 | 4 ++--
 testcases/kernel/syscalls/mprotect/mprotect03.c           | 4 +---
 testcases/kernel/syscalls/mremap/mremap05.c               | 4 ++--
 testcases/kernel/syscalls/munmap/munmap02.c               | 5 +----
 testcases/kernel/syscalls/readahead/readahead02.c         | 3 +--
 testcases/kernel/syscalls/sendfile/sendfile04.c           | 6 +++---
 10 files changed, 16 insertions(+), 24 deletions(-)

diff --git a/testcases/kernel/mem/mtest06/mmap1.c b/testcases/kernel/mem/mtest06/mmap1.c
index f3eae9994..8894b0dbf 100644
--- a/testcases/kernel/mem/mtest06/mmap1.c
+++ b/testcases/kernel/mem/mtest06/mmap1.c
@@ -53,6 +53,7 @@
 #include <signal.h>
 #include <string.h>
 #include "test.h"
+#include "safe_macros.h"
 
 #define DISTANT_MMAP_SIZE (64*1024*1024)
 #define OPT_MISSING(prog, opt) do { \
@@ -347,8 +348,7 @@ int main(int argc, char **argv)
 		MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
 	if (distant_area == (void *)-1)
 		tst_brkm(TBROK | TERRNO, NULL, "distant_area: mmap()");
-	if (munmap(distant_area, (size_t) DISTANT_MMAP_SIZE) == -1)
-		tst_brkm(TBROK | TERRNO, NULL, "distant_area: munmap()");
+	SAFE_MUNMAP(NULL, distant_area, (size_t)DISTANT_MMAP_SIZE);
 	distant_area += DISTANT_MMAP_SIZE / 2;
 
 	if (verbose_print)
diff --git a/testcases/kernel/mem/vma/vma01.c b/testcases/kernel/mem/vma/vma01.c
index f800ffaf8..bafbfff46 100644
--- a/testcases/kernel/mem/vma/vma01.c
+++ b/testcases/kernel/mem/vma/vma01.c
@@ -51,6 +51,7 @@
 #include <string.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 #define MAPS_FILE "/proc/self/maps"
 
@@ -155,8 +156,7 @@ static void create_bighole(void)
 		tst_brkm(TBROK | TERRNO, cleanup, "mmap");
 	memset(t, 'a', ps);
 	p = t + 3 * ps;
-	if (munmap(t, 9 * ps) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "munmap");
+	SAFE_MUNMAP(cleanup, t, 9 * ps);
 }
 
 static void *get_end_addr(void *addr_s)
diff --git a/testcases/kernel/syscalls/cma/process_vm01.c b/testcases/kernel/syscalls/cma/process_vm01.c
index 110db6e76..8ae16c41d 100644
--- a/testcases/kernel/syscalls/cma/process_vm01.c
+++ b/testcases/kernel/syscalls/cma/process_vm01.c
@@ -396,8 +396,7 @@ static void cma_test_invalid_protection(void)
 	cma_check_ret(-1, TEST_RETURN);
 	cma_check_errno(EFAULT);
 
-	if (munmap(p, getpagesize()) < 0)
-		tst_brkm(TBROK | TERRNO, cleanup, "munmap");
+	SAFE_MUNMAP(cleanup, p, getpagesize());
 
 	cma_free_params(sane_params);
 }
diff --git a/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c b/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c
index 88a37219c..591ff3365 100644
--- a/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c
+++ b/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c
@@ -117,8 +117,7 @@ static void test_invalid_mem(void)
 	check_ret(-1);
 	check_errno(EFAULT);
 
-	if (munmap(p, getpagesize()) < 0)
-		tst_brkm(TBROK | TERRNO, cleanup, "munmap");
+	SAFE_MUNMAP(cleanup, p, getpagesize());
 	tst_resm(TINFO, "test_invalid_mem unmmaped");
 	TEST(ltp_syscall(__NR_migrate_pages, 0, sane_max_node, p, p));
 	check_ret(-1);
diff --git a/testcases/kernel/syscalls/mlock/mlock04.c b/testcases/kernel/syscalls/mlock/mlock04.c
index a97bf491c..d1f3c9d0d 100644
--- a/testcases/kernel/syscalls/mlock/mlock04.c
+++ b/testcases/kernel/syscalls/mlock/mlock04.c
@@ -31,6 +31,7 @@
  * 02110-1301, USA.
  */
 #include "test.h"
+#include "safe_macros.h"
 #include "config.h"
 
 char *TCID = "mlock04";
@@ -72,8 +73,7 @@ int main(void)
 		if (munlock(buf, file_len) == -1)
 			tst_brkm(TBROK | TERRNO, cleanup, "munlock");
 
-		if (munmap(buf, file_len) == -1)
-			tst_brkm(TBROK | TERRNO, cleanup, "munmap");
+		SAFE_MUNMAP(cleanup, buf, file_len);
 	}
 
 	tst_resm(TPASS, "test succeeded.");
diff --git a/testcases/kernel/syscalls/mprotect/mprotect03.c b/testcases/kernel/syscalls/mprotect/mprotect03.c
index 099afb6bc..944b45e87 100644
--- a/testcases/kernel/syscalls/mprotect/mprotect03.c
+++ b/testcases/kernel/syscalls/mprotect/mprotect03.c
@@ -120,9 +120,7 @@ int main(int ac, char **av)
 		}
 
 		/* clean up things in case we are looping */
-		if (munmap(addr, strlen(buf)) == -1) {
-			tst_brkm(TBROK, cleanup, "munamp failed");
-		}
+		SAFE_MUNMAP(cleanup, addr, strlen(buf));
 		SAFE_CLOSE(cleanup, fd);
 		if (unlink(file1) == -1) {
 			tst_brkm(TBROK, cleanup, "unlink failed");
diff --git a/testcases/kernel/syscalls/mremap/mremap05.c b/testcases/kernel/syscalls/mremap/mremap05.c
index 079f281e5..d7e4e63e7 100644
--- a/testcases/kernel/syscalls/mremap/mremap05.c
+++ b/testcases/kernel/syscalls/mremap/mremap05.c
@@ -41,6 +41,7 @@
 #include <errno.h>
 #include <unistd.h>
 #include "test.h"
+#include "safe_macros.h"
 
 char *TCID = "mremap05";
 
@@ -119,8 +120,7 @@ static int TST_TOTAL = sizeof(tdat) / sizeof(tdat[0]);
 
 static void free_test_area(void *p, int size)
 {
-	if (munmap(p, size) < 0)
-		tst_brkm(TBROK | TERRNO, cleanup, "free_test_area munmap");
+	SAFE_MUNMAP(cleanup, p, size);
 }
 
 static void *get_test_area(int size, int free_area)
diff --git a/testcases/kernel/syscalls/munmap/munmap02.c b/testcases/kernel/syscalls/munmap/munmap02.c
index 3997b445c..a85c079c3 100644
--- a/testcases/kernel/syscalls/munmap/munmap02.c
+++ b/testcases/kernel/syscalls/munmap/munmap02.c
@@ -264,10 +264,7 @@ void cleanup(void)
 	map_len = map_len - page_sz;
 
 	/* unmap the portion of the region of the file left unmapped */
-	if (munmap(addr, map_len) < 0) {
-		tst_brkm(TBROK, NULL,
-			 "munmap() fails to unmap portion of mapped region");
-	}
+	SAFE_MUNMAP(NULL, addr, map_len);
 
 	/* Close the temporary file */
 	SAFE_CLOSE(NULL, fildes);
diff --git a/testcases/kernel/syscalls/readahead/readahead02.c b/testcases/kernel/syscalls/readahead/readahead02.c
index a5b01c756..d21bb9c45 100644
--- a/testcases/kernel/syscalls/readahead/readahead02.c
+++ b/testcases/kernel/syscalls/readahead/readahead02.c
@@ -273,8 +273,7 @@ static void read_testfile(int do_readahead, const char *fname, size_t fsize,
 	if (!do_readahead)
 		*cached = get_cached_size();
 
-	if (munmap(p, fsize) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "munmap failed");
+	SAFE_MUNMAP(cleanup, p, fsize);
 
 	*read_bytes = get_bytes_read() - read_bytes_start;
 	if (gettimeofday(&now, NULL) == -1)
diff --git a/testcases/kernel/syscalls/sendfile/sendfile04.c b/testcases/kernel/syscalls/sendfile/sendfile04.c
index 822c4688c..779e7dc70 100644
--- a/testcases/kernel/syscalls/sendfile/sendfile04.c
+++ b/testcases/kernel/syscalls/sendfile/sendfile04.c
@@ -57,6 +57,7 @@
 #include <netinet/in.h>
 #include <arpa/inet.h>
 #include "test.h"
+#include "safe_macros.h"
 
 #ifndef OFF_T
 #define OFF_T off_t
@@ -119,9 +120,8 @@ void do_sendfile(int prot, int pass_unmapped_buffer)
 	}
 
 	if (pass_unmapped_buffer) {
-		if (munmap(protected_buffer, sizeof(*protected_buffer)) < 0) {
-			tst_brkm(TBROK, cleanup, "munmap failed: %d", errno);
-		}
+		SAFE_MUNMAP(cleanup, protected_buffer,
+			    sizeof(*protected_buffer));
 	}
 
 	TEST(sendfile(out_fd, in_fd, protected_buffer, sb.st_size));
-- 
2.13.5

