Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <liwan@redhat.com>) id 1Y8Qnx-00036m-Ki
	for ltp-list@lists.sourceforge.net; Tue, 06 Jan 2015 09:52:01 +0000
Received: from mx5-phx2.redhat.com ([209.132.183.37])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Y8Qnv-0005QM-Hf
	for ltp-list@lists.sourceforge.net; Tue, 06 Jan 2015 09:52:01 +0000
Date: Tue, 6 Jan 2015 04:51:52 -0500 (EST)
From: Li Wang <liwang@redhat.com>
Message-ID: <1759699028.3904548.1420537912980.JavaMail.zimbra@redhat.com>
In-Reply-To: <124148100.2234995.1420452985543.JavaMail.zimbra@redhat.com>
References: <1419664386-14888-1-git-send-email-liwang@redhat.com>
	<511980342.1455678.1419931434983.JavaMail.zimbra@redhat.com>
	<1667897429.3183348.1420341038221.JavaMail.zimbra@redhat.com>
	<124148100.2234995.1420452985543.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] mem/hugeshmat: new case for hugepage leak
 inspection
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net


> ----- Original Message -----
> > From: "Li Wang" <liwang@redhat.com>
> > To: "Jan Stancek" <jstancek@redhat.com>
> > Cc: ltp-list@lists.sourceforge.net
> > Sent: Sunday, 4 January, 2015 4:10:38 AM
> > Subject: Re: [LTP] [PATCH] mem/hugeshmat: new case for hugepage leak
> > inspection
> > 
> > The regression has a long history, Patch in upstream 2.6.20-rc1
> > GIT: 39dde65c9940c97fcd178a3d2b1c57ed8b7b68aa.
> > https://lkml.org/lkml/2012/4/16/129
> 
> And fix is presumably this commit:
> 
> ommit c5c99429fa57dcf6e05203ebe3676db1ec646793
> Author: Larry Woodman <lwoodman@redhat.com>
> Date:   Thu Jan 24 05:49:25 2008 -0800
>     fix hugepages leak due to pagetable page sharing
> 
> It'd be nice to include this information somewhere in testcase or commit
> message.
> More comments below:
...
> > > > +int shared_hugepage(void)
> > > > +{
> > > > +	pid_t pid;
> > > > +	int status, shmid;
> > > > +	size_t size = (size_t)SIZE;
> > > > +	void *buf;
> > > > +
> > > > +	shmid = shmget(IPC_PRIVATE, size, SHM_HUGETLB | IPC_CREAT | 0777);
> > > > +	if (shmid < 0)
> > > > +		tst_brkm(TBROK | TERRNO, cleanup, "shmget");
> > > > +
> > > > +	buf = shmat(shmid, (void *)BOUNDARY, SHM_RND | 0777);
> 
> Does it make a difference where you attach shared segment? I'm slightly
> worried,
> that absolute address you picked may already be in use on some
> distros/arches.

Hi Jan,

Thank you for reviewing my stupid patch. :)

Actually I also don't know why using absolute address here, I doubt this 
manner are similar with the BZ occurred environment. The sleep(3) below as well.

Since the original case is too old to found out who is the author. I hope someone 
now could provide any useful discussion here, if not, I still feel we can use these 
code to cover the regression. What do you think?


A new patch:

Subject: [PATCH] mem/hugeshmat: new case for hugepage leak inspection

Description of Problem:
	When over 1GB shared memory was alocated in hugepage, the hugepage
	is not released though process finished.

The fix is this commit:
	commit c5c99429fa57dcf6e05203ebe3676db1ec646793
	Author: Larry Woodman <lwoodman@redhat.com>
	Date:   Thu Jan 24 05:49:25 2008 -0800
    	fix hugepages leak due to pagetable page sharing

Signed-off-by: Li Wang <liwang@redhat.com>
Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 runtest/hugetlb                                    |   1 +
 testcases/kernel/mem/.gitignore                    |   1 +
 .../kernel/mem/hugetlb/hugeshmat/hugeshmat04.c     | 166 +++++++++++++++++++++
 3 files changed, 168 insertions(+)
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
index 0000000..43e9f3f
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
@@ -0,0 +1,166 @@
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
+ *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+ *   02110-1301 USA
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
+ *         When over 1GB shered memory was alocated in hugepage, the hugepage
+ *         is not released though process finished.
+ *
+ *         You need more than 2GB memory in test job
+ *
+ *	Test results:
+ *	   Successed: No regression found.
+ *	   Failed:    Regression detected.
+ *
+ * HISTORY
+ * 	05/2014 - Written by Fujistu Corp.
+ *	12/2014 - Port to LTP by Li Wang.
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
+static long huge_total;
+static long huge_free;
+static long huge_free2;
+static long hugepages;
+static long orig_hugepages;
+
+static void shared_hugepage(void);
+
+int main(int ac, char **av)
+{
+	int lc, i;
+	const char *msg;
+
+	msg = parse_opts(ac, av, NULL, NULL);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		tst_count = 0;
+
+		for (i = 0; i < TST_TOTAL; i++) {
+
+			shared_hugepage();
+			huge_free2 = read_meminfo("HugePages_Free:");
+
+			if (huge_free2 != huge_free)
+				tst_brkm(TFAIL, cleanup,
+					"Test failed. Hugepage leak inspection.");
+			else
+				tst_resm(TPASS, "No regression found.");
+		}
+	}
+
+	cleanup();
+	tst_exit();
+}
+
+void shared_hugepage(void)
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
+	if (buf == (void *)-1) {
+		shmctl(shmid, IPC_RMID, NULL);
+		tst_brkm(TBROK | TERRNO, cleanup, "shmat");
+	}
+
+	memset(buf, 2, size);
+	sleep(3);
+	pid = fork();
+
+	if (pid == 0)
+		exit(1);
+	else if (pid < 0)
+		tst_brkm(TBROK | TERRNO, cleanup, "fork");
+
+	wait(&status);
+	shmdt(buf);
+	shmctl(shmid, IPC_RMID, NULL);
+}
+
+void setup(void)
+{
+	long mem_total, hpage_size;
+
+	tst_require_root(NULL);
+
+	mem_total = read_meminfo("MemTotal:") * 1024;
+	if (mem_total < 2L*SIZE) {
+		tst_resm(TINFO, "Total memory should greater than 2G.");
+		tst_exit();
+	}
+
+	orig_hugepages = get_sys_tune("nr_hugepages");
+	hpage_size = read_meminfo("Hugepagesize:") * 1024;
+
+	hugepages = (orig_hugepages * hpage_size + SIZE) / hpage_size;
+	set_sys_tune("nr_hugepages", hugepages, 1);
+
+	huge_total = read_meminfo("HugePages_Total:");
+	huge_free = read_meminfo("HugePages_Free:");
+
+	if (huge_total != hugepages || huge_free != hugepages)
+		tst_brkm(TCONF, cleanup,
+			"Maybe huge pages not enough for test.");
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
