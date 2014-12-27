Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <liwang@redhat.com>) id 1Y5TuQ-0002Pe-37
	for ltp-list@lists.sourceforge.net; Mon, 29 Dec 2014 06:34:30 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Y5TuO-0001vw-N7
	for ltp-list@lists.sourceforge.net; Mon, 29 Dec 2014 06:34:30 +0000
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id sBR7DAZg013284
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Sat, 27 Dec 2014 02:13:10 -0500
Received: from dhcp-13-206.nay.redhat.com (dhcp-12-104.nay.redhat.com
	[10.66.12.104])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id sBR7D8u3028315
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <ltp-list@lists.sourceforge.net>; Sat, 27 Dec 2014 02:13:09 -0500
From: Li Wang <liwang@redhat.com>
Date: Sat, 27 Dec 2014 15:13:06 +0800
Message-Id: <1419664386-14888-1-git-send-email-liwang@redhat.com>
Subject: [LTP] [PATCH] mem/hugeshmat: new case for hugepage leak inspection
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

Description of Problem:
    When over 1GB shared memory was alocated in hugepage, the hugepage
    is not released though process finished.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 runtest/hugetlb                                    |   1 +
 testcases/kernel/mem/.gitignore                    |   1 +
 .../kernel/mem/hugetlb/hugeshmat/hugeshmat04.c     | 185 +++++++++++++++++++++
 3 files changed, 187 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 3eaf14c..805141d 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -10,6 +10,7 @@ hugemmap05_3 hugemmap05 -s -m
 hugeshmat01 hugeshmat01 -i 5
 hugeshmat02 hugeshmat02 -i 5
 hugeshmat03 hugeshmat03 -i 5
+hugeshmat04 hugeshamt04 -i 5
 
 hugeshmctl01 hugeshmctl01 -i 5
 hugeshmctl02 hugeshmctl02 -i 5
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index f96964c..c531563 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -6,6 +6,7 @@
 /hugetlb/hugeshmat/hugeshmat01
 /hugetlb/hugeshmat/hugeshmat02
 /hugetlb/hugeshmat/hugeshmat03
+/hugetlb/hugeshmat/hugeshmat04
 /hugetlb/hugeshmctl/hugeshmctl01
 /hugetlb/hugeshmctl/hugeshmctl02
 /hugetlb/hugeshmctl/hugeshmctl03
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
new file mode 100644
index 0000000..515947b
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
@@ -0,0 +1,185 @@
+/*
+ *   Copyright (c) Linux Test Project, 2014
+ *
+ *   This program is free software;  you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ *   the GNU General Public License for more details.
+ *  
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program;  if not, write to the Free Software
+ *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ */
+
+/*
+ * NAME
+ * 	hugeshmat04.c
+ * 
+ * DESCRIPTION
+ *	hugeshmat04 - test for hugepage leak inspection.
+ *     
+ *      Description of Problem:
+ *          When over 1GB shered memory was alocated in hugepage, the hugepage
+ *          is not released though process finished.
+ *
+ *          You need more than 2GB memory in test job
+ *
+ *	Return value:
+ *	  0: 	 Test successed.  No regression found.
+ *	  1: 	 Test failed.  Maybe memory shortage.  Please retry testing.
+ *	  2: 	 Test failed.  Regression detected.
+ *	  other: Test failed.  Other problem detected.
+ *
+ * HISTORY
+ * 	05/2014 - Written by Fujistu Corp. 
+ *     	12/2014 - Port to LTP by Li Wang.
+ *    
+ * RESTRICTIONS
+ * 	test must be run at root
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <string.h>
+#include <sys/mman.h>
+#include <sys/types.h>
+#include <sys/shm.h>
+#include <sys/wait.h>
+
+#include "test.h"
+#include "mem.h"
+
+#define SIZE	(1024 * 1024 * 1024)
+#define BOUNDARY (1024 * 1024 * 1024)
+
+char *TCID = "hugeshmat04";
+int TST_TOTAL = 3;
+
+static int huge_total;
+static int huge_free;
+static int huge_free2;
+static long hugepages;
+static long orig_hugepages;
+
+static int shared_hugepage(void);
+
+
+int main(int ac, char **av)
+{
+	int lc, i, ret;
+	const char *msg;
+
+	msg = parse_opts(ac,av, NULL, NULL);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		tst_count = 0;
+
+		for (i = 0; i < TST_TOTAL; i++) {
+			huge_total = read_meminfo("HugePages_Total:");
+			huge_free = read_meminfo("HugePages_Free:");
+
+			if (huge_total == hugepages && huge_free == hugepages) {
+				ret = shared_hugepage();
+
+				huge_free2 = read_meminfo("HugePages_Free:");
+				if (huge_free2 != huge_free)
+					ret = 2;
+			} else {
+				ret = 1;
+			}
+			
+			switch (ret) {
+			case 0:
+				tst_resm(TPASS, 
+					"No regression found.");
+				break;
+			case 1:
+				tst_brkm(TFAIL, cleanup, 
+					"Test failed. Maybe memory shortage.");
+				break;
+			case 2:
+				tst_brkm(TFAIL, cleanup, 
+					"Test failed. Hugepage leak inspection.");
+				break;
+			default:
+				tst_brkm(TFAIL, cleanup, 
+					"Test failed. Other problem detected.");
+				break;
+			}
+
+		}
+	}
+	cleanup();
+	tst_exit();
+}
+
+int shared_hugepage(void)
+{
+	pid_t pid;
+	int status, shmid;
+	size_t size = (size_t)SIZE;
+	void *buf;
+
+	shmid = shmget(IPC_PRIVATE, size, SHM_HUGETLB | IPC_CREAT | 0777);
+	if (shmid < 0)
+		tst_brkm(TBROK | TERRNO, cleanup, "shmget");
+
+	buf = shmat(shmid, (void *)BOUNDARY, SHM_RND | 0777);
+	if ( buf == (void *)-1 ) {
+		shmctl(shmid, IPC_RMID, NULL);
+		tst_brkm(TBROK | TERRNO, cleanup, "shmat");
+	}
+
+	memset(buf, 2, size);
+	sleep(3);
+	pid = fork();
+	
+	if (pid == 0)
+	        exit(1);
+	else if (pid < 0)
+	 	tst_brkm(TBROK | TERRNO, cleanup, "fork");
+	
+	wait(&status);
+	shmdt(buf);
+	shmctl(shmid, IPC_RMID, NULL);
+
+	return 0;
+}
+
+void setup(void)
+{
+	long mem_total, hpage_size;
+	
+	tst_require_root(NULL);
+
+	mem_total = read_meminfo("MemTotal:");
+	if (mem_total < 2097152) {
+		tst_resm(TINFO, "Total memory should greater than 2G.");
+		tst_exit();
+	}
+
+	orig_hugepages = get_sys_tune("nr_hugepages");
+	hpage_size = read_meminfo("Hugepagesize:");
+	
+	hugepages = (orig_hugepages * hpage_size + 1048576) / hpage_size;
+	set_sys_tune("nr_hugepages", hugepages, 1);
+	
+	TEST_PAUSE;
+}
+
+void cleanup(void)
+{
+	TEST_CLEANUP;
+	set_sys_tune("nr_hugepages", orig_hugepages, 0);
+}
-- 
1.8.3.1


------------------------------------------------------------------------------
Dive into the World of Parallel Programming! The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
