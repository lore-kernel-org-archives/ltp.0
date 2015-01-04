Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <liwan@redhat.com>) id 1Y7baa-0001l8-C0
	for ltp-list@lists.sourceforge.net; Sun, 04 Jan 2015 03:10:48 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Y7baX-0005Li-Ln
	for ltp-list@lists.sourceforge.net; Sun, 04 Jan 2015 03:10:48 +0000
Date: Sat, 3 Jan 2015 22:10:38 -0500 (EST)
From: Li Wang <liwang@redhat.com>
Message-ID: <1667897429.3183348.1420341038221.JavaMail.zimbra@redhat.com>
In-Reply-To: <511980342.1455678.1419931434983.JavaMail.zimbra@redhat.com>
References: <1419664386-14888-1-git-send-email-liwang@redhat.com>
	<511980342.1455678.1419931434983.JavaMail.zimbra@redhat.com>
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

The regression has a long history, Patch in upstream 2.6.20-rc1
GIT: 39dde65c9940c97fcd178a3d2b1c57ed8b7b68aa. 
https://lkml.org/lkml/2012/4/16/129

Not long before, Fujistu guys request us(RedHat) to cover this regression test in RHEL7-next , then I found two Redhat BZs on clearly tracing this issue:
https://bugzilla.redhat.com/show_bug.cgi?id=428612
https://bugzilla.redhat.com/show_bug.cgi?id=222753#c16
So, I port the testcase to LTP.

-- 
Regards, 
Li Wang 
Email: liwang@redhat.com 



----- Original Message -----
> 
> 
> 
> 
> ----- Original Message -----
> > From: "Li Wang" <liwang@redhat.com>
> > To: ltp-list@lists.sourceforge.net
> > Sent: Saturday, 27 December, 2014 8:13:06 AM
> > Subject: [LTP] [PATCH] mem/hugeshmat: new case for hugepage leak inspection
> > 
> > Description of Problem:
> >     When over 1GB shared memory was alocated in hugepage, the hugepage
> >     is not released though process finished.
> 
> This looks like a regression test for kernel bug. Do you know what
> kernel version are affected and which commit is fixing it?
> 
> Regards,
> Jan
> 
> > 
> > Signed-off-by: Li Wang <liwang@redhat.com>
> > ---
> >  runtest/hugetlb                                    |   1 +
> >  testcases/kernel/mem/.gitignore                    |   1 +
> >  .../kernel/mem/hugetlb/hugeshmat/hugeshmat04.c     | 185
> >  +++++++++++++++++++++
> >  3 files changed, 187 insertions(+)
> >  create mode 100644 testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
> > 
> > diff --git a/runtest/hugetlb b/runtest/hugetlb
> > index 3eaf14c..805141d 100644
> > --- a/runtest/hugetlb
> > +++ b/runtest/hugetlb
> > @@ -10,6 +10,7 @@ hugemmap05_3 hugemmap05 -s -m
> >  hugeshmat01 hugeshmat01 -i 5
> >  hugeshmat02 hugeshmat02 -i 5
> >  hugeshmat03 hugeshmat03 -i 5
> > +hugeshmat04 hugeshamt04 -i 5
> >  
> >  hugeshmctl01 hugeshmctl01 -i 5
> >  hugeshmctl02 hugeshmctl02 -i 5
> > diff --git a/testcases/kernel/mem/.gitignore
> > b/testcases/kernel/mem/.gitignore
> > index f96964c..c531563 100644
> > --- a/testcases/kernel/mem/.gitignore
> > +++ b/testcases/kernel/mem/.gitignore
> > @@ -6,6 +6,7 @@
> >  /hugetlb/hugeshmat/hugeshmat01
> >  /hugetlb/hugeshmat/hugeshmat02
> >  /hugetlb/hugeshmat/hugeshmat03
> > +/hugetlb/hugeshmat/hugeshmat04
> >  /hugetlb/hugeshmctl/hugeshmctl01
> >  /hugetlb/hugeshmctl/hugeshmctl02
> >  /hugetlb/hugeshmctl/hugeshmctl03
> > diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
> > b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
> > new file mode 100644
> > index 0000000..515947b
> > --- /dev/null
> > +++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
> > @@ -0,0 +1,185 @@
> > +/*
> > + *   Copyright (c) Linux Test Project, 2014
> > + *
> > + *   This program is free software;  you can redistribute it and/or modify
> > + *   it under the terms of the GNU General Public License as published by
> > + *   the Free Software Foundation; either version 2 of the License, or
> > + *   (at your option) any later version.
> > + *
> > + *   This program is distributed in the hope that it will be useful,
> > + *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
> > + *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> > + *   the GNU General Public License for more details.
> > + *
> > + *   You should have received a copy of the GNU General Public License
> > + *   along with this program;  if not, write to the Free Software
> > + *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> > 02110-1301 USA
> > + */
> > +
> > +/*
> > + * NAME
> > + * 	hugeshmat04.c
> > + *
> > + * DESCRIPTION
> > + *	hugeshmat04 - test for hugepage leak inspection.
> > + *
> > + *      Description of Problem:
> > + *          When over 1GB shered memory was alocated in hugepage, the
> > hugepage
> > + *          is not released though process finished.
> > + *
> > + *          You need more than 2GB memory in test job
> > + *
> > + *	Return value:
> > + *	  0: 	 Test successed.  No regression found.
> > + *	  1: 	 Test failed.  Maybe memory shortage.  Please retry testing.
> > + *	  2: 	 Test failed.  Regression detected.
> > + *	  other: Test failed.  Other problem detected.
> > + *
> > + * HISTORY
> > + * 	05/2014 - Written by Fujistu Corp.
> > + *     	12/2014 - Port to LTP by Li Wang.
> > + *
> > + * RESTRICTIONS
> > + * 	test must be run at root
> > + */
> > +
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <unistd.h>
> > +#include <fcntl.h>
> > +#include <string.h>
> > +#include <sys/mman.h>
> > +#include <sys/types.h>
> > +#include <sys/shm.h>
> > +#include <sys/wait.h>
> > +
> > +#include "test.h"
> > +#include "mem.h"
> > +
> > +#define SIZE	(1024 * 1024 * 1024)
> > +#define BOUNDARY (1024 * 1024 * 1024)
> > +
> > +char *TCID = "hugeshmat04";
> > +int TST_TOTAL = 3;
> > +
> > +static int huge_total;
> > +static int huge_free;
> > +static int huge_free2;
> > +static long hugepages;
> > +static long orig_hugepages;
> > +
> > +static int shared_hugepage(void);
> > +
> > +
> > +int main(int ac, char **av)
> > +{
> > +	int lc, i, ret;
> > +	const char *msg;
> > +
> > +	msg = parse_opts(ac,av, NULL, NULL);
> > +	if (msg != NULL)
> > +		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
> > +
> > +	setup();
> > +
> > +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> > +		tst_count = 0;
> > +
> > +		for (i = 0; i < TST_TOTAL; i++) {
> > +			huge_total = read_meminfo("HugePages_Total:");
> > +			huge_free = read_meminfo("HugePages_Free:");
> > +
> > +			if (huge_total == hugepages && huge_free == hugepages) {
> > +				ret = shared_hugepage();
> > +
> > +				huge_free2 = read_meminfo("HugePages_Free:");
> > +				if (huge_free2 != huge_free)
> > +					ret = 2;
> > +			} else {
> > +				ret = 1;
> > +			}
> > +
> > +			switch (ret) {
> > +			case 0:
> > +				tst_resm(TPASS,
> > +					"No regression found.");
> > +				break;
> > +			case 1:
> > +				tst_brkm(TFAIL, cleanup,
> > +					"Test failed. Maybe memory shortage.");
> > +				break;
> > +			case 2:
> > +				tst_brkm(TFAIL, cleanup,
> > +					"Test failed. Hugepage leak inspection.");
> > +				break;
> > +			default:
> > +				tst_brkm(TFAIL, cleanup,
> > +					"Test failed. Other problem detected.");
> > +				break;
> > +			}
> > +
> > +		}
> > +	}
> > +	cleanup();
> > +	tst_exit();
> > +}
> > +
> > +int shared_hugepage(void)
> > +{
> > +	pid_t pid;
> > +	int status, shmid;
> > +	size_t size = (size_t)SIZE;
> > +	void *buf;
> > +
> > +	shmid = shmget(IPC_PRIVATE, size, SHM_HUGETLB | IPC_CREAT | 0777);
> > +	if (shmid < 0)
> > +		tst_brkm(TBROK | TERRNO, cleanup, "shmget");
> > +
> > +	buf = shmat(shmid, (void *)BOUNDARY, SHM_RND | 0777);
> > +	if ( buf == (void *)-1 ) {
> > +		shmctl(shmid, IPC_RMID, NULL);
> > +		tst_brkm(TBROK | TERRNO, cleanup, "shmat");
> > +	}
> > +
> > +	memset(buf, 2, size);
> > +	sleep(3);
> > +	pid = fork();
> > +
> > +	if (pid == 0)
> > +	        exit(1);
> > +	else if (pid < 0)
> > +	 	tst_brkm(TBROK | TERRNO, cleanup, "fork");
> > +
> > +	wait(&status);
> > +	shmdt(buf);
> > +	shmctl(shmid, IPC_RMID, NULL);
> > +
> > +	return 0;
> > +}
> > +
> > +void setup(void)
> > +{
> > +	long mem_total, hpage_size;
> > +
> > +	tst_require_root(NULL);
> > +
> > +	mem_total = read_meminfo("MemTotal:");
> > +	if (mem_total < 2097152) {
> > +		tst_resm(TINFO, "Total memory should greater than 2G.");
> > +		tst_exit();
> > +	}
> > +
> > +	orig_hugepages = get_sys_tune("nr_hugepages");
> > +	hpage_size = read_meminfo("Hugepagesize:");
> > +
> > +	hugepages = (orig_hugepages * hpage_size + 1048576) / hpage_size;
> > +	set_sys_tune("nr_hugepages", hugepages, 1);
> > +
> > +	TEST_PAUSE;
> > +}
> > +
> > +void cleanup(void)
> > +{
> > +	TEST_CLEANUP;
> > +	set_sys_tune("nr_hugepages", orig_hugepages, 0);
> > +}
> > --
> > 1.8.3.1
> > 
> > 
> > ------------------------------------------------------------------------------
> > Dive into the World of Parallel Programming! The Go Parallel Website,
> > sponsored by Intel and developed in partnership with Slashdot Media, is
> > your
> > hub for all things parallel software development, from weekly thought
> > leadership blogs to news, videos, case studies, tutorials and more. Take a
> > look and join the conversation now. http://goparallel.sourceforge.net
> > _______________________________________________
> > Ltp-list mailing list
> > Ltp-list@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/ltp-list
> > 
> 

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
