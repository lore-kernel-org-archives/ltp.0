Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1S7Joj-0000QG-FH
	for ltp-list@lists.sourceforge.net; Tue, 13 Mar 2012 04:58:37 +0000
Received: from mail-pz0-f47.google.com ([209.85.210.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1S7Joi-0008Uv-FM
	for ltp-list@lists.sourceforge.net; Tue, 13 Mar 2012 04:58:37 +0000
Received: by mail-pz0-f47.google.com with SMTP id o14so271940dad.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 12 Mar 2012 21:58:36 -0700 (PDT)
From: Caspar Zhang <caspar@casparzhang.com>
Date: Tue, 13 Mar 2012 12:56:45 +0800
Message-Id: <1331614605-30347-12-git-send-email-caspar@casparzhang.com>
In-Reply-To: <1331614605-30347-1-git-send-email-caspar@casparzhang.com>
References: <1331614605-30347-1-git-send-email-caspar@casparzhang.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.8.4"
Subject: [LTP] [PATCH 11/11] libltp: remove system_specific_hugepages_info
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: LTP List <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------1.7.8.4
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


system_specific_hugepages_info is not well-implemented and has been
deprecated, all functions in it can be replaced with libmem. So removing
it.

Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
---
 include/system_specific_hugepages_info.h           |   30 ------
 lib/system_specific_hugepages_info.c               |   93 --------------------
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c |   19 ++--
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c |    5 +-
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap03.c |    1 -
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c |   24 ++---
 6 files changed, 21 insertions(+), 151 deletions(-)
 delete mode 100644 include/system_specific_hugepages_info.h
 delete mode 100644 lib/system_specific_hugepages_info.c


--------------1.7.8.4
Content-Type: text/x-patch;
	name="0011-libltp-remove-system_specific_hugepages_info.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0011-libltp-remove-system_specific_hugepages_info.patch"

diff --git a/include/system_specific_hugepages_info.h b/include/system_specific_hugepages_info.h
deleted file mode 100644
index f5e3c46..0000000
--- a/include/system_specific_hugepages_info.h
+++ /dev/null
@@ -1,30 +0,0 @@
-/*
- *
- *   Copyright (c) International Business Machines  Corp., 2009
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- */
-
-#ifndef _SYS_SPECIFIC_HUGEPAGES_INFO_H_
-#define _SYS_SPECIFIC_HUGEPAGES_INFO_H_
-
-/*Returns Total No. of available Hugepages in the system from /proc/meminfo*/
-int get_no_of_hugepages(void);
-/*Returns No. of Hugepages_Free  from /proc/meminfo*/
-int get_no_of_free_hugepages(void);
-/*Returns Hugepages Size from /proc/meminfo*/
-int hugepages_size(void);
-
-#endif
diff --git a/lib/system_specific_hugepages_info.c b/lib/system_specific_hugepages_info.c
deleted file mode 100644
index 2344add..0000000
--- a/lib/system_specific_hugepages_info.c
+++ /dev/null
@@ -1,93 +0,0 @@
-/*
- *
- *   Copyright (c) International Business Machines  Corp., 2009
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- */
-
-/*
- *   DESCRIPTION
- *               get_no_of_hugepages() --> Return No. of hugepages for this systems
- *                                         from /proc/meminfo
- *               hugepages_size()      --> Return Hugepages Size for this system
- *                                         from /proc/meminfo
- */
-
-#include <fcntl.h>
-#include <sys/types.h>
-#include <test.h>
-
-int get_no_of_hugepages() {
- #ifdef __linux__
-       FILE *f;
-       char buf[BUFSIZ];
-
-       f = popen("grep 'HugePages_Total' /proc/meminfo | cut -d ':' -f2 | tr -d ' \n'", "r");
-       if (!f)
-              tst_brkm(TBROK, NULL,
-                     "Could not get info about Total_Hugepages from /proc/meminfo");
-       if (!fgets(buf, 10, f)) {
-               fclose(f);
-               tst_brkm(TBROK, NULL,
-                     "Could not read Total_Hugepages from /proc/meminfo");
-       }
-       pclose(f);
-       return(atoi(buf));
- #else
-        return -1;
- #endif
-}
-
-int get_no_of_free_hugepages() {
- #ifdef __linux__
-       FILE *f;
-       char buf[BUFSIZ];
-
-       f = popen("grep 'HugePages_Free' /proc/meminfo | cut -d ':' -f2 | tr -d ' \n'", "r");
-       if (!f)
-               tst_brkm(TBROK, NULL,
-                     "Could not get info about HugePages_Free from /proc/meminfo");
-       if (!fgets(buf, 10, f)) {
-               fclose(f);
-               tst_brkm(TBROK, NULL,
-                     "Could not read HugePages_Free from /proc/meminfo");
-       }
-       pclose(f);
-       return(atoi(buf));
- #else
-        return -1;
- #endif
-}
-
-int hugepages_size() {
- #ifdef __linux__
-       FILE *f;
-       char buf[BUFSIZ];
-
-       f = popen("grep 'Hugepagesize' /proc/meminfo | cut -d ':' -f2 | tr -d 'kB \n'", "r");
-       if (!f)
-               tst_brkm(TBROK, NULL,
-                     "Could not get info about HugePages_Size from /proc/meminfo");
-       if (!fgets(buf, 10, f)) {
-               fclose(f);
-               tst_brkm(TBROK, NULL,
-                     "Could not read HugePages_Size from /proc/meminfo");
-       }
-       pclose(f);
-       return(atoi(buf));
- #else
-        return -1;
- #endif
-}
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
index 90f28c8..1140d8b 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
@@ -62,7 +62,6 @@
 #include "test.h"
 #include "usctest.h"
 #include "safe_macros.h"
-#include "system_specific_hugepages_info.h"
 #include "mem.h"
 
 static char TEMPFILE[MAXPATHLEN];
@@ -73,9 +72,9 @@ static long *addr;
 static int fildes;
 static char *Hopt;
 static char *nr_opt;
-static int beforetest;
-static int aftertest;
-static int hugepagesmapped;
+static long beforetest;
+static long aftertest;
+static long hugepagesmapped;
 static long hugepages = 128;
 static long orig_hugepages;
 
@@ -86,7 +85,7 @@ int main(int ac, char **av)
 	int lc;
 	char *msg;
 	int Hflag = 0;
-	int page_sz = 0;
+	long page_sz = 0;
 	int sflag = 0;
 
 	option_t options[] = {
@@ -119,12 +118,12 @@ int main(int ac, char **av)
 		Tst_count = 0;
 
 		/* Note the number of free huge pages BEFORE testing */
-		beforetest = get_no_of_free_hugepages();
+		beforetest = read_meminfo("HugePages_Free:");
 
 		/* Note the size of huge page size BEFORE testing */
-		page_sz = hugepages_size();
+		page_sz = read_meminfo("Hugepagesize:") * 1024;
 
-		addr = mmap(NULL, page_sz*1024, PROT_READ | PROT_WRITE,
+		addr = mmap(NULL, page_sz, PROT_READ | PROT_WRITE,
 			    MAP_SHARED, fildes, 0);
 		if (addr == MAP_FAILED) {
 			tst_resm(TFAIL|TERRNO, "mmap() Failed on %s", TEMPFILE);
@@ -141,7 +140,7 @@ int main(int ac, char **av)
 		 * Make sure the number of free huge pages
 		 * AFTER testing decreased
 		 */
-		aftertest = get_no_of_free_hugepages();
+		aftertest = read_meminfo("HugePages_Free:");
 		hugepagesmapped = beforetest - aftertest;
 		if (hugepagesmapped < 1)
 			tst_resm(TWARN, "Number of HUGEPAGES_FREE stayed the"
@@ -150,7 +149,7 @@ int main(int ac, char **av)
 
 		/* Clean up things in case we are looping */
 		/* Unmap the mapped memory */
-		if (munmap(addr, page_sz*1024) != 0)
+		if (munmap(addr, page_sz) != 0)
 			tst_brkm(TFAIL|TERRNO, NULL, "munmap failed");
 
 		close(fildes);
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
index 5a96146..7b2fb68 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
@@ -55,7 +55,6 @@
 #include "test.h"
 #include "usctest.h"
 #include "safe_macros.h"
-#include "system_specific_hugepages_info.h"
 #include "mem.h"
 
 #define LOW_ADDR       (void *)(0x80000000)
@@ -83,7 +82,7 @@ int main(int ac, char **av)
 	int lc;
 	char *msg;
 	int Hflag = 0;
-	int page_sz, map_sz;
+	long page_sz, map_sz;
 	int sflag = 0;
 
 	option_t options[] = {
@@ -105,7 +104,7 @@ int main(int ac, char **av)
 		hugepages = SAFE_STRTOL(NULL, nr_opt, 0, LONG_MAX);
 
 	page_sz = getpagesize();
-	map_sz = 2 * 1024 * hugepages_size();
+	map_sz = read_meminfo("Hugepagesize:") * 1024 * 2;
 
 	setup();
 
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap03.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap03.c
index 50fe707..4b75601 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap03.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap03.c
@@ -46,7 +46,6 @@
 #include "test.h"
 #include "usctest.h"
 #include "safe_macros.h"
-#include "system_specific_hugepages_info.h"
 #include "mem.h"
 
 #define HIGH_ADDR      (void *)(0x1000000000000)
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
index f313c60..554eaae 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
@@ -63,7 +63,6 @@
 #include "test.h"
 #include "usctest.h"
 #include "safe_macros.h"
-#include "system_specific_hugepages_info.h"
 #include "mem.h"
 
 static char TEMPFILE[MAXPATHLEN];
@@ -73,10 +72,10 @@ int TST_TOTAL = 1;
 static long *addr;
 static long long mapsize;
 static int fildes;
-static int freepages;
-static int beforetest;
-static int aftertest;
-static int hugepagesmapped;
+static long freepages;
+static long beforetest;
+static long aftertest;
+static long hugepagesmapped;
 static long hugepages = 128;
 static long orig_hugepages;
 static char *Hopt;
@@ -112,10 +111,6 @@ int main(int ac, char **av)
 
 	setup();
 
-	/* Check number of hugepages */
-	if (get_no_of_hugepages() <= 0 || hugepages_size() <= 0)
-		tst_brkm(TCONF, cleanup, "Not enough available Hugepages");
-
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		/* Creat a temporary file used for huge mapping */
 		fildes = open(TEMPFILE, O_RDWR | O_CREAT, 0666);
@@ -126,11 +121,11 @@ int main(int ac, char **av)
 		Tst_count = 0;
 
 		/* Note the number of free huge pages BEFORE testing */
-		freepages = get_no_of_free_hugepages();
+		freepages = read_meminfo("HugePages_Free:");
 		beforetest = freepages;
 
 		/* Note the size of huge page size BEFORE testing */
-		huge_pagesize = hugepages_size();
+		huge_pagesize = read_meminfo("Hugepagesize:");
 		tst_resm(TINFO, "Size of huge pages is %d KB", huge_pagesize);
 
 #if __WORDSIZE == 32
@@ -150,8 +145,9 @@ int main(int ac, char **av)
 			close(fildes);
 			continue;
 		} else {
-			tst_resm(TPASS, "Succeeded mapping file using %d pages",
-				 freepages);
+			tst_resm(TPASS,
+				"Succeeded mapping file using %ld pages",
+				freepages);
 			/* force to allocate page and change HugePages_Free */
 			*(int *)addr = 0;
 		}
@@ -160,7 +156,7 @@ int main(int ac, char **av)
 		 * Make sure the number of free huge pages
 		 * AFTER testing decreased
 		 */
-		aftertest = get_no_of_free_hugepages();
+		aftertest = read_meminfo("HugePages_Free:");
 		hugepagesmapped = beforetest - aftertest;
 		if (hugepagesmapped < 1)
 			tst_resm(TWARN, "Number of HUGEPAGES_FREE stayed the"

--------------1.7.8.4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
--------------1.7.8.4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.8.4--



