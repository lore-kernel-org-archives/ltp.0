From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 21 Mar 2017 14:03:13 +0100
Subject: [LTP] [PATCH] madvise09: Add MADV_FREE test
In-Reply-To: <67200919.5693108.1489584679637.JavaMail.zimbra@redhat.com>
References: <20170313110636.10803-1-chrubis@suse.cz>
 <67200919.5693108.1489584679637.JavaMail.zimbra@redhat.com>
Message-ID: <20170321130313.GA32105@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Ok to commit with these changes against v2?

diff --git a/testcases/kernel/syscalls/madvise/madvise09.c b/testcases/kernel/syscalls/madvise/madvise09.c
index 0339086..45a14a0 100644
--- a/testcases/kernel/syscalls/madvise/madvise09.c
+++ b/testcases/kernel/syscalls/madvise/madvise09.c
@@ -52,6 +52,7 @@
 #include <signal.h>
 #include <errno.h>
 #include <stdio.h>
+#include <ctype.h>
 
 #include "tst_test.h"
 #include "lapi/mmap.h"
@@ -64,14 +65,16 @@ static char limit_in_bytes_path[PATH_MAX];
 static char memsw_limit_in_bytes_path[PATH_MAX];
 
 static size_t page_size;
+static int sleep_between_faults;
 
 #define PAGES 32
+#define TOUCHED_PAGE1 0
+#define TOUCHED_PAGE2 10
 
 static void memory_pressure_child(void)
 {
 	size_t i, page_size = getpagesize();
 	char *ptr;
-	int sleep = 1;
 
 	for (;;) {
 		ptr = mmap(NULL, 500 * page_size, PROT_READ | PROT_WRITE,
@@ -79,10 +82,8 @@ static void memory_pressure_child(void)
 
 		for (i = 0; i < 500; i++) {
 			ptr[i * page_size] = i % 100;
-			usleep(sleep);
+			usleep(sleep_between_faults);
 		}
-
-		sleep++;
 	}
 
 	abort();
@@ -111,6 +112,46 @@ static int count_freed(char *ptr)
 	return ret;
 }
 
+static int check_page_baaa(char *ptr)
+{
+	unsigned int i;
+
+	if (ptr[0] != 'b') {
+		tst_res(TINFO, "%p unexpected %c (%i) at 0 expected 'b'",
+			ptr, isprint(ptr[0]) ? ptr[0] : ' ', ptr[0]);
+		return 1;
+	}
+
+	for (i = 1; i < page_size; i++) {
+		if (ptr[i] != 'a') {
+			tst_res(TINFO,
+				"%p unexpected %c (%i) at %i expected 'a'",
+				ptr, isprint(ptr[i]) ? ptr[i] : ' ',
+				ptr[i], i);
+			return 1;
+		}
+	}
+
+	return 0;
+}
+
+static int check_page(char *ptr, char val)
+{
+	unsigned int i;
+
+	for (i = 0; i < page_size; i++) {
+		if (ptr[i] != val) {
+			tst_res(TINFO,
+				"%p unexpected %c (%i)@%i expected %c (%i)",
+				ptr, isprint(ptr[i]) ? ptr[i] : ' ', ptr[i], i,
+				isprint(val) ? val : ' ', val);
+			return 1;
+		}
+	}
+
+	return 0;
+}
+
 static void child(void)
 {
 	size_t i;
@@ -139,8 +180,8 @@ static void child(void)
 	else
 		tst_res(TPASS, "MADV_FREE pages were not freed immediatelly");
 
-	ptr[0] = 'b';
-	ptr[10 * page_size] = 'b';
+	ptr[TOUCHED_PAGE1 * page_size] = 'b';
+	ptr[TOUCHED_PAGE2 * page_size] = 'b';
 
 	usage = 8 * 1024 * 1024;
 	tst_res(TINFO, "Setting memory limits to %u %u", usage, 2 * usage);
@@ -151,6 +192,8 @@ static void child(void)
 	SAFE_FILE_PRINTF(memsw_limit_in_bytes_path, "%u", 2 * usage);
 
 	do {
+		sleep_between_faults++;
+
 		pid = SAFE_FORK();
 		if (!pid)
 			memory_pressure_child();
@@ -160,21 +203,33 @@ static void child(void)
 		SAFE_WAIT(&status);
 	} while (retries++ < 10 && count_freed(ptr) == 0);
 
-	if (ptr[0] == 0 || ptr[10 * page_size] == 0)
-		tst_res(TFAIL, "Page modified after MADV_FREE was freed");
-	else
-		tst_res(TPASS, "Page modified after MADV_FREE was not freed");
-
 	char map[PAGES+1];
 	unsigned int freed = 0;
+	unsigned int corrupted = 0;
 
 	for (i = 0; i < PAGES; i++) {
+		char exp_val;
+
 		if (ptr[i * page_size]) {
+			exp_val = 'a';
 			map[i] = 'p';
 		} else {
+			exp_val = 0;
 			map[i] = '_';
 			freed++;
 		}
+
+		if (i != TOUCHED_PAGE1 && i != TOUCHED_PAGE2) {
+			if (check_page(ptr + i * page_size, exp_val)) {
+				map[i] = '?';
+				corrupted++;
+			}
+		} else {
+			if (check_page_baaa(ptr + i * page_size)) {
+				map[i] = '?';
+				corrupted++;
+			}
+		}
 	}
 	map[PAGES] = '\0';
 
@@ -185,6 +240,11 @@ static void child(void)
 	else
 		tst_res(TFAIL, "No MADV_FREE page was freed on low memory");
 
+	if (corrupted)
+		tst_res(TFAIL, "Found corrupted page");
+	else
+		tst_res(TPASS, "All pages have expected content");
+
 	SAFE_FILE_PRINTF(memsw_limit_in_bytes_path, "%u", old_memsw_limit);
 	SAFE_FILE_PRINTF(limit_in_bytes_path, "%u", old_limit);
 

-- 
Cyril Hrubis
chrubis@suse.cz
