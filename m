Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YFmqb-0007tf-B4
	for ltp-list@lists.sourceforge.net; Mon, 26 Jan 2015 16:49:09 +0000
Date: Mon, 26 Jan 2015 17:48:09 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150126164809.GB29158@rei>
References: <1419664386-14888-1-git-send-email-liwang@redhat.com>
	<511980342.1455678.1419931434983.JavaMail.zimbra@redhat.com>
	<1667897429.3183348.1420341038221.JavaMail.zimbra@redhat.com>
	<124148100.2234995.1420452985543.JavaMail.zimbra@redhat.com>
	<1759699028.3904548.1420537912980.JavaMail.zimbra@redhat.com>
	<27844855.3137974.1420540536445.JavaMail.zimbra@redhat.com>
	<169945440.3971026.1420553236395.JavaMail.zimbra@redhat.com>
	<1910508304.3829751.1420633954389.JavaMail.zimbra@redhat.com>
	<1240855022.4434958.1420642785249.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1240855022.4434958.1420642785249.JavaMail.zimbra@redhat.com>
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
To: Li Wang <liwang@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Signed-off-by: Li Wang <liwang@redhat.com>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  runtest/hugetlb                                    |   1 +
>  testcases/kernel/mem/.gitignore                    |   1 +
>  .../kernel/mem/hugetlb/hugeshmat/hugeshmat04.c     | 164 +++++++++++++++++++++
>  3 files changed, 166 insertions(+)
>  create mode 100644 testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
> 
> diff --git a/runtest/hugetlb b/runtest/hugetlb
> index 3eaf14c..805141d 100644
> --- a/runtest/hugetlb
> +++ b/runtest/hugetlb
> @@ -10,6 +10,7 @@ hugemmap05_3 hugemmap05 -s -m
>  hugeshmat01 hugeshmat01 -i 5
>  hugeshmat02 hugeshmat02 -i 5
>  hugeshmat03 hugeshmat03 -i 5
> +hugeshmat04 hugeshamt04 -i 5
>  
>  hugeshmctl01 hugeshmctl01 -i 5
>  hugeshmctl02 hugeshmctl02 -i 5
> diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
> index f96964c..c531563 100644
> --- a/testcases/kernel/mem/.gitignore
> +++ b/testcases/kernel/mem/.gitignore
> @@ -6,6 +6,7 @@
>  /hugetlb/hugeshmat/hugeshmat01
>  /hugetlb/hugeshmat/hugeshmat02
>  /hugetlb/hugeshmat/hugeshmat03
> +/hugetlb/hugeshmat/hugeshmat04
>  /hugetlb/hugeshmctl/hugeshmctl01
>  /hugetlb/hugeshmctl/hugeshmctl02
>  /hugetlb/hugeshmctl/hugeshmctl03
> diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
> new file mode 100644
> index 0000000..d6d2d4c
> --- /dev/null
> +++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
> @@ -0,0 +1,164 @@
> +/*
> + *   Copyright (c) Linux Test Project, 2014
> + *
> + *   This program is free software;  you can redistribute it and/or modify
> + *   it under the terms of the GNU General Public License as published by
> + *   the Free Software Foundation; either version 2 of the License, or
> + *   (at your option) any later version.
> + *
> + *   This program is distributed in the hope that it will be useful,
> + *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
> + *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> + *   the GNU General Public License for more details.
> + *
> + *   You should have received a copy of the GNU General Public License
> + *   along with this program;  if not, write to the Free Software
> + *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> + *   02110-1301 USA
> + */
> +
> +/*
> + * NAME
> + * 	hugeshmat04.c
> + *
> + * DESCRIPTION
> + *	hugeshmat04 - test for hugepage leak inspection.
> + *
> + *      Description of Problem:
> + *         When over 1GB shered memory was alocated in hugepage, the hugepage
> + *         is not released though process finished.
> + *
> + *         You need more than 2GB memory in test job
> + *
> + *	Test results:
> + *	   Successed: No regression found.
> + *	   Failed:    Regression detected.
> + *
> + * HISTORY
> + * 	05/2014 - Written by Fujistu Corp.
> + *	12/2014 - Port to LTP by Li Wang.
> + *
> + * RESTRICTIONS
> + * 	test must be run at root
> + */

The NAME, Test Results and RESTRICTONS are useless, please remove these.
What really matters here is the test DESCRIPTION. It should say that
it's a regression test for shared hugepage leak and a few more details
about the conditions that are needed to make it happen.

> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <fcntl.h>
> +#include <string.h>
> +#include <sys/mman.h>
> +#include <sys/types.h>
> +#include <sys/shm.h>
> +#include <sys/wait.h>
> +
> +#include "test.h"
> +#include "mem.h"
> +
> +#define SIZE	(1024 * 1024 * 1024)
> +#define BOUNDARY (1024 * 1024 * 1024)
> +
> +char *TCID = "hugeshmat04";
> +int TST_TOTAL = 3;
> +
> +static long huge_total;
> +static long huge_free;
> +static long huge_free2;
> +static long hugepages;
> +static long orig_hugepages;
> +
> +static void shared_hugepage(void);
> +
> +int main(int ac, char **av)
> +{
> +	int lc, i;
> +	const char *msg;
> +
> +	msg = parse_opts(ac, av, NULL, NULL);
> +	if (msg != NULL)
> +		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
> +
> +	setup();
> +
> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +		tst_count = 0;
> +
> +		for (i = 0; i < TST_TOTAL; i++) {
> +
> +			huge_free = read_meminfo("HugePages_Free:");
> +			shared_hugepage();
> +			huge_free2 = read_meminfo("HugePages_Free:");
> +
> +			if (huge_free2 != huge_free)
> +				tst_brkm(TFAIL, cleanup,
> +					"Test failed. Hugepage leak inspection.");
> +			else
> +				tst_resm(TPASS, "No regression found.");
> +		}
> +	}
> +
> +	cleanup();
> +	tst_exit();
> +}
> +
> +void shared_hugepage(void)
> +{
> +	pid_t pid;
> +	int status, shmid;
> +	size_t size = (size_t)SIZE;
> +	void *buf;
> +
> +	shmid = shmget(IPC_PRIVATE, size, SHM_HUGETLB | IPC_CREAT | 0777);
> +	if (shmid < 0)
> +		tst_brkm(TBROK | TERRNO, cleanup, "shmget");
> +
> +	buf = shmat(shmid, (void *)BOUNDARY, SHM_RND | 0777);
> +	if (buf == (void *)-1) {
> +		shmctl(shmid, IPC_RMID, NULL);
> +		tst_brkm(TBROK | TERRNO, cleanup, "shmat");
> +	}
> +
> +	memset(buf, 2, size);
> +	pid = fork();
> +
> +	if (pid == 0)
> +		exit(1);
> +	else if (pid < 0)
> +		tst_brkm(TBROK | TERRNO, cleanup, "fork");
> +
> +	wait(&status);
> +	shmdt(buf);
> +	shmctl(shmid, IPC_RMID, NULL);
> +}
> +
> +void setup(void)
> +{
> +	long mem_total, hpage_size;
> +
> +	tst_require_root(NULL);
> +
> +	mem_total = read_meminfo("MemTotal:") * 1024;
> +	if (mem_total < 2L*SIZE) {

Why don't we keep the computation here in kilobytes? It's less prone to
potential overflows...

> +		tst_resm(TINFO, "Total memory should greater than 2G.");
> +		tst_exit();

		Should be:
		tst_brmk(TCONF, "Test requires more than 2GB of RAM");

> +	}
> +
> +	orig_hugepages = get_sys_tune("nr_hugepages");
> +	hpage_size = read_meminfo("Hugepagesize:") * 1024;
> +
> +	hugepages = (orig_hugepages * hpage_size + SIZE) / hpage_size;
> +	set_sys_tune("nr_hugepages", hugepages, 1);
> +
> +	huge_total = read_meminfo("HugePages_Total:");
> +	if (huge_total != hugepages)
> +		tst_brkm(TCONF, cleanup,
> +			"Maybe huge pages not enough for test.");
> +
> +	TEST_PAUSE;
> +}
> +
> +void cleanup(void)
> +{
> +	TEST_CLEANUP;
> +	set_sys_tune("nr_hugepages", orig_hugepages, 0);
> +}

Otherwise it looks fine.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Dive into the World of Parallel Programming. The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
