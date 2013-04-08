Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1UP7Ff-0005uZ-AR
	for ltp-list@lists.sourceforge.net; Mon, 08 Apr 2013 08:16:31 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UP7Fd-0001vt-10
	for ltp-list@lists.sourceforge.net; Mon, 08 Apr 2013 08:16:31 +0000
Message-ID: <51627D01.5050804@cn.fujitsu.com>
Date: Mon, 08 Apr 2013 16:17:05 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <cover.1365402799.git.zliu@redhat.com>
	<562d626131ac38c90ca623bcb27e42e16056e888.1365402799.git.zliu@redhat.com>
In-Reply-To: <562d626131ac38c90ca623bcb27e42e16056e888.1365402799.git.zliu@redhat.com>
Subject: Re: [LTP] [PATCH 3/3] mm/thp: add new case thp05
Reply-To: gaowanlong@cn.fujitsu.com
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
To: Zhouping Liu <zliu@redhat.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

On 04/08/2013 02:38 PM, Zhouping Liu wrote:
> added new case thp05, which is used to test transparent hugepage
> under mempolicy.
> 
> Signed-off-by: Zhouping Liu <zliu@redhat.com>
> ---
>  runtest/mm                         |   3 +
>  testcases/kernel/mem/include/mem.h |   3 +-
>  testcases/kernel/mem/lib/mem.c     |   6 +-
>  testcases/kernel/mem/thp/thp04.c   |   2 +-
>  testcases/kernel/mem/thp/thp05.c   | 152 +++++++++++++++++++++++++++++++++++++
>  5 files changed, 163 insertions(+), 3 deletions(-)
>  create mode 100644 testcases/kernel/mem/thp/thp05.c
> 
> diff --git a/runtest/mm b/runtest/mm
> index 3fbb20f..7c7abf1 100644
> --- a/runtest/mm
> +++ b/runtest/mm
> @@ -87,6 +87,9 @@ thp03 thp03
>  thp04_1 thp04
>  thp04_2 thp04 -n 10 -N 20
>  thp04_3 thp04 -n 1 -N 300
> +thp05_1 thp05
> +thp05_2 thp05 -n 10 -N 20
> +thp05_3 thp05 -n 1 -N 300
>  
>  vma01 vma01
>  vma02 vma02
> diff --git a/testcases/kernel/mem/include/mem.h b/testcases/kernel/mem/include/mem.h
> index ccae47d..6b020af 100644
> --- a/testcases/kernel/mem/include/mem.h
> +++ b/testcases/kernel/mem/include/mem.h
> @@ -39,7 +39,8 @@ void testoom(int mempolicy, int lite);
>  
>  int opt_nr_child, opt_nr_thps;
>  char *opt_nr_child_str, *opt_nr_thps_str;
> -void test_transparent_hugepage(int nr_child, int nr_thps, int hg_aligned);
> +void test_transparent_hugepage(int nr_child, int nr_thps,
> +			       int hg_aligned, int mempolicy);
>  void check_thp_options(int *nr_child, int *nr_thps);
>  void thp_usage(void);
>  
> diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
> index 39fa99a..f5a2453 100644
> --- a/testcases/kernel/mem/lib/mem.c
> +++ b/testcases/kernel/mem/lib/mem.c
> @@ -616,12 +616,16 @@ static void verify_thp_size(int *child, int nr_child, int nr_thps)
>  	}
>  }
>  
> -void test_transparent_hugepage(int nr_child, int nr_thps, int hg_aligned)
> +void test_transparent_hugepage(int nr_child, int nr_thps,
> +			       int hg_aligned, int mempolicy)
>  {
>  	unsigned long hugepagesize;
>  	int i, *pid, ret, status;
>  	char path[BUFSIZ];
>  
> +	if (mempolicy)
> +		set_global_mempolicy(mempolicy);
> +
>  	hugepagesize = read_meminfo("Hugepagesize:");
>  
>  	pid = (int *)malloc(nr_child * sizeof(int));
> diff --git a/testcases/kernel/mem/thp/thp04.c b/testcases/kernel/mem/thp/thp04.c
> index 2855eb5..a628be3 100644
> --- a/testcases/kernel/mem/thp/thp04.c
> +++ b/testcases/kernel/mem/thp/thp04.c
> @@ -83,7 +83,7 @@ int main(int argc, char *argv[])
>  	for (lc = 0; TEST_LOOPING(lc); lc++) {
>  		tst_count = 0;
>  
> -		test_transparent_hugepage(nr_child, nr_thps, 1);
> +		test_transparent_hugepage(nr_child, nr_thps, 1, 0);
>  	}
>  
>  	cleanup();
> diff --git a/testcases/kernel/mem/thp/thp05.c b/testcases/kernel/mem/thp/thp05.c
> new file mode 100644
> index 0000000..7d339cb
> --- /dev/null
> +++ b/testcases/kernel/mem/thp/thp05.c
> @@ -0,0 +1,152 @@
> +/*
> + * Copyright (C) 2013 Linux Test Project
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of version 2 of the GNU General Public
> + * License as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it would be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> + *
> + * Further, this software is distributed without any warranty that it
> + * is free of the rightful claim of any third person regarding
> + * infringement or the like.  Any license provided herein, whether
> + * implied or otherwise, applies only to this software file.  Patent
> + * licenses, if any, provided herein do not apply to combinations of
> + * this program with other software, or any other product whatsoever.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write the Free Software
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> + * 02110-1301, USA.
> + */
> +
> +/*
> + * The case is designed to test the functionality of transparent
> + * hugepage - THP under mempolicy (NUMA)
> + *
> + * when one process allocate hugepage aligned anonymouse pages,
> + * kernel thread 'khugepaged' controlled by sysfs knobs
> + * /sys/kernel/mm/transparent_hugepage/ will scan them, and make
> + * them as transparent hugepage if they are suited, you can find out
> + * how many transparent hugepages are there in one process from
> + * /proc/<pid>/smaps, among the file contents, 'AnonHugePages' entry
> + * stand for transparent hugepage.
> + */
> +
> +#include <sys/types.h>
> +#include <sys/mman.h>
> +#include <sys/stat.h>
> +#include <sys/wait.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <signal.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include "numa_helper.h"
> +#include "test.h"
> +#include "usctest.h"
> +#include "mem.h"
> +
> +char *TCID = "thp05";
> +int TST_TOTAL = 1;
> +
> +#if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
> +		&& HAVE_MPOL_CONSTANTS
> +
> +option_t thp_options[] = {
> +	{"n:", &opt_nr_child, &opt_nr_child_str},
> +	{"N:", &opt_nr_thps, &opt_nr_thps_str},
> +	{NULL, NULL, NULL}
> +};
> +
> +int pre_thp_scan_sleep_millisecs;
> +int pre_thp_alloc_sleep_millisecs;
> +char pre_thp_enabled[BUFSIZ];
> +

static?

> +int main(int argc, char *argv[])
> +{
> +	int lc;
> +	char *msg;
> +	int nr_child = 2, nr_thps = 64;
> +
> +	msg = parse_opts(argc, argv, thp_options, thp_usage);
> +	if (msg != NULL)
> +		tst_brkm(TBROK, tst_exit, "OPTION PARSING ERROR - %s", msg);
> +	check_thp_options(&nr_child, &nr_thps);
> +
> +	setup();
> +
> +	tst_resm(TINFO, "Start to test transparent hugepage...");
> +	tst_resm(TINFO, "There are %d children allocating %d "
> +			"transparent hugepages", nr_child, nr_thps);
> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +		tst_count = 0;
> +
> +		tst_resm(TINFO, "THP on MPOL_BIND mempolicy...");
> +		test_transparent_hugepage(nr_child, nr_thps, 1, MPOL_BIND);
> +
> +		tst_resm(TINFO, "THP on MPOL_INTERLEAVE mempolicy...");
> +		test_transparent_hugepage(nr_child, nr_thps, 1,
> +					  MPOL_INTERLEAVE);
> +
> +		tst_resm(TINFO, "THP on MPOL_PREFERRED mempolicy...");
> +		test_transparent_hugepage(nr_child, nr_thps, 1, MPOL_PREFERRED);
> +	}
> +
> +	cleanup();
> +	tst_exit();
> +}
> +
> +void setup(void)

ditto?

> +{
> +	char path[BUFSIZ];
> +
> +	tst_require_root(NULL);
> +
> +	if (access(PATH_THP, F_OK) == -1)
> +		tst_brkm(TCONF, NULL, "THP is not enabled");
> +
> +	if (!is_numa(NULL))
> +		tst_brkm(TCONF, NULL, "The case need a NUMA system.");
> +
> +	snprintf(path, BUFSIZ, PATH_KHPD "scan_sleep_millisecs");
> +	SAFE_FILE_SCANF(NULL, path, "%d", &pre_thp_scan_sleep_millisecs);
> +	SAFE_FILE_PRINTF(cleanup, path, "%d", 0);
> +
> +	snprintf(path, BUFSIZ, PATH_KHPD "alloc_sleep_millisecs");
> +	SAFE_FILE_SCANF(NULL, path, "%d", &pre_thp_alloc_sleep_millisecs);
> +	SAFE_FILE_PRINTF(NULL, path, "%d", 0);
> +
> +	snprintf(path, BUFSIZ, PATH_THP "enabled");
> +	write_file(path, "always");
> +
> +	tst_sig(FORK, DEF_HANDLER, NULL);
> +	TEST_PAUSE;
> +}
> +
> +void cleanup(void)

ditto?

Thanks,
Wanlong Gao

> +{
> +	char path[BUFSIZ];
> +
> +	snprintf(path, BUFSIZ, PATH_KHPD "scan_sleep_millisecs");
> +	SAFE_FILE_PRINTF(NULL, path, "%d", pre_thp_scan_sleep_millisecs);
> +
> +	snprintf(path, BUFSIZ, PATH_KHPD "alloc_sleep_millisecs");
> +	SAFE_FILE_PRINTF(NULL, path, "%d", pre_thp_alloc_sleep_millisecs);
> +
> +	snprintf(path, BUFSIZ, PATH_THP "enabled");
> +	write_file(path, pre_thp_enabled);
> +
> +	TEST_CLEANUP;
> +}
> +
> +#else /* no NUMA */
> +int main(void)
> +{
> +	tst_brkm(TCONF, NULL, "no NUMA development packages installed.");
> +}
> +#endif
> 


------------------------------------------------------------------------------
Minimize network downtime and maximize team effectiveness.
Reduce network management and security costs.Learn how to hire 
the most talented Cisco Certified professionals. Visit the 
Employer Resources Portal
http://www.cisco.com/web/learning/employer_resources/index.html
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
