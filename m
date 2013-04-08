Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1UP7E3-00079Q-KG
	for ltp-list@lists.sourceforge.net; Mon, 08 Apr 2013 08:14:51 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UP7E0-0003kB-NS
	for ltp-list@lists.sourceforge.net; Mon, 08 Apr 2013 08:14:51 +0000
Message-ID: <51627C9C.9060200@cn.fujitsu.com>
Date: Mon, 08 Apr 2013 16:15:24 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <cover.1365402799.git.zliu@redhat.com>
	<6b9bfe6944adbbb2963d6e18cad373a309956f90.1365402799.git.zliu@redhat.com>
In-Reply-To: <6b9bfe6944adbbb2963d6e18cad373a309956f90.1365402799.git.zliu@redhat.com>
Subject: Re: [LTP] [PATCH 1/3] mm/thp: new case thp04.c
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
> The case is desinged to test THP functionality.
> 
> when one process allocate hugepage aligned anonymouse pages,
> kernel thread 'khugepaged' controlled by sysfs knobs
> /sys/kernel/mm/transparent_hugepage/* will scan them, and make
> them as transparent hugepage if they are suited, you can find out
> how many transparent hugepages are there in one process from
> /proc/<pid>/smaps, among the file contents, 'AnonHugePages' entry
> stand for transparent hugepage.
> 
> Signed-off-by: Zhouping Liu <zliu@redhat.com>
> ---
>  runtest/mm                         |   3 +
>  testcases/kernel/mem/include/mem.h |  11 +++
>  testcases/kernel/mem/lib/mem.c     | 180 +++++++++++++++++++++++++++++++++++++
>  testcases/kernel/mem/thp/thp04.c   | 136 ++++++++++++++++++++++++++++
>  4 files changed, 330 insertions(+)
>  create mode 100644 testcases/kernel/mem/thp/thp04.c
> 
> diff --git a/runtest/mm b/runtest/mm
> index 56b83f8..3fbb20f 100644
> --- a/runtest/mm
> +++ b/runtest/mm
> @@ -84,6 +84,9 @@ swapping01 swapping01 -i 5
>  thp01 thp01 -I 120
>  thp02 thp02
>  thp03 thp03
> +thp04_1 thp04
> +thp04_2 thp04 -n 10 -N 20
> +thp04_3 thp04 -n 1 -N 300
>  
>  vma01 vma01
>  vma02 vma02
> diff --git a/testcases/kernel/mem/include/mem.h b/testcases/kernel/mem/include/mem.h
> index fdf558e..ccae47d 100644
> --- a/testcases/kernel/mem/include/mem.h
> +++ b/testcases/kernel/mem/include/mem.h
> @@ -32,6 +32,17 @@ void testoom(int mempolicy, int lite);
>  
>  #define PATH_KSM		"/sys/kernel/mm/ksm/"
>  
> +/* THP */
> +
> +#define PATH_THP		"/sys/kernel/mm/transparent_hugepage/"
> +#define PATH_KHPD		PATH_THP "khugepaged/"
> +
> +int opt_nr_child, opt_nr_thps;
> +char *opt_nr_child_str, *opt_nr_thps_str;
> +void test_transparent_hugepage(int nr_child, int nr_thps, int hg_aligned);
> +void check_thp_options(int *nr_child, int *nr_thps);
> +void thp_usage(void);
> +
>  /* HUGETLB */
>  
>  #define PATH_SHMMAX		"/proc/sys/kernel/shmmax"
> diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
> index c9525e5..491afe8 100644
> --- a/testcases/kernel/mem/lib/mem.c
> +++ b/testcases/kernel/mem/lib/mem.c
> @@ -501,6 +501,186 @@ void ksm_usage(void)
>  	printf("  -u      Memory allocation unit in MB\n");
>  }
>  
> +/* THP */
> +
> +static int alloc_transparent_hugepages(int nr_thps, int hg_aligned)
> +{
> +	unsigned long hugepagesize, size;
> +	void *addr;
> +	int ret;
> +
> +	hugepagesize = read_meminfo("Hugepagesize:") * KB;
> +	size = nr_thps * hugepagesize;
> +
> +	if (hg_aligned) {
> +		ret = posix_memalign(&addr, hugepagesize, size);
> +		if (ret != 0) {
> +			printf("posix_memalign failed\n");
> +			return -1;
> +		}
> +	} else {
> +		addr = mmap(NULL, size, PROT_READ|PROT_WRITE,
> +			    MAP_PRIVATE|MAP_ANON, -1, 0);
> +		if (addr == MAP_FAILED) {
> +			perror("mmap");
> +			return -1;
> +		}
> +	}
> +
> +	memset(addr, 10, size);
> +
> +	tst_resm(TINFO, "child[%d] stop here", getpid());
> +	/*
> +	 * stop here, until the father finish to calculate
> +	 * all the transparent hugepages.
> +	 */
> +	if (raise(SIGSTOP) == -1) {
> +		perror("kill");
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
> +static void khugepaged_scan_done(void)
> +{
> +	int changing = 1, count = 0;
> +	long old_pages_collapsed, old_defrag;
> +	long old_max_ptes_none, old_pages_to_scan;
> +	long pages_collapsed = 0, pages_to_scan = 0;
> +	long defrag = 0, max_ptes_none = 0;
> +
> +	while (changing) {
> +		sleep(10);

You should comment this sleep line. Why should it be 10?


> +		count++;
> +
> +		SAFE_FILE_SCANF(cleanup, PATH_KHPD "pages_collapsed",
> +			       "%ld", &pages_collapsed);
> +		SAFE_FILE_SCANF(cleanup, PATH_KHPD "defrag", "%ld", &defrag);
> +		SAFE_FILE_SCANF(cleanup, PATH_KHPD "max_ptes_none",
> +			       "%ld", &max_ptes_none);
> +		SAFE_FILE_SCANF(cleanup, PATH_KHPD "pages_to_scan",
> +			       "%ld", &pages_to_scan);
> +
> +		if (pages_collapsed != old_pages_collapsed ||
> +		    pages_to_scan != old_pages_to_scan ||
> +		    max_ptes_none != old_max_ptes_none ||
> +		    defrag != old_defrag) {
> +			old_pages_collapsed = pages_collapsed;
> +			old_pages_to_scan = pages_to_scan;
> +			old_max_ptes_none = max_ptes_none;
> +			old_defrag = defrag;
> +		} else {
> +			changing = 0;
> +		}
> +	}
> +
> +	tst_resm(TINFO, "khugepaged daemon takes %ds to scan all thp pages",
> +		 count * 10);
> +}
> +
> +static void verify_thp_size(int *child, int nr_child, int nr_thps)
> +{
> +	FILE *fp;
> +	char path[BUFSIZ], buf[BUFSIZ], line[BUFSIZ];
> +	int i, ret;
> +	long expect_thps; /* the amount of per child's transparent hugepages */
> +	long val, actual_thps;
> +	long hugepagesize;
> +
> +	hugepagesize = read_meminfo("Hugepagesize:");
> +	expect_thps = nr_thps * hugepagesize;
> +
> +	for (i = 0; i < nr_child; i++) {
> +		actual_thps = 0;
> +
> +		snprintf(path, BUFSIZ, "/proc/%d/smaps", child[i]);
> +		fp = fopen(path, "r");
> +		while (fgets(line, BUFSIZ, fp) != NULL) {
> +			ret = sscanf(line, "%64s %ld", buf, &val);
> +			if (ret == 2 && val != 0) {
> +				if (strcmp(buf, "AnonHugePages:") == 0)
> +					actual_thps += val;
> +			}
> +		}
> +
> +		if (actual_thps != expect_thps)
> +			tst_resm(TFAIL, "child[%d] got %ldKB thps - expect %ld"
> +				"KB thps", getpid(), actual_thps, expect_thps);
> +		fclose(fp);
> +	}
> +}
> +
> +void test_transparent_hugepage(int nr_child, int nr_thps, int hg_aligned)
> +{
> +	unsigned long hugepagesize;
> +	int i, *pid, ret, status;
> +	char path[BUFSIZ];
> +
> +	hugepagesize = read_meminfo("Hugepagesize:");
> +
> +	pid = (int *)malloc(nr_child * sizeof(int));

type is unnecessary?

> +	if (pid == NULL)
> +		tst_brkm(TBROK | TERRNO, cleanup, "malloc");
> +
> +	for (i = 0; i < nr_child; i++) {
> +		switch (pid[i] = fork()) {
> +		case -1:
> +			tst_brkm(TBROK | TERRNO, cleanup, "fork");
> +
> +		case 0:
> +			ret = alloc_transparent_hugepages(nr_thps, hg_aligned);
> +			exit(ret);
> +		}
> +	}
> +
> +	tst_resm(TINFO, "Stop all children...");
> +	for (i = 0; i < nr_child; i++) {
> +		if (waitpid(pid[i], &status, WUNTRACED) == -1)
> +			tst_brkm(TBROK|TERRNO, cleanup, "waitpid");
> +		if (!WIFSTOPPED(status))
> +			tst_brkm(TBROK, cleanup,
> +				 "child[%d] was not stoppted", pid[i]);
> +	}
> +
> +	tst_resm(TINFO, "Start to scan all transparent hugepages...");
> +	khugepaged_scan_done();
> +
> +	tst_resm(TINFO, "Start to verify transparent hugepage size...");
> +	verify_thp_size(pid, nr_child, nr_thps);
> +
> +	tst_resm(TINFO, "Wake up all children...");
> +	for (i = 0; i < nr_child; i++) {
> +		if (kill(pid[i], SIGCONT) == -1)
> +			tst_brkm(TBROK | TERRNO, cleanup,
> +				 "signal continue child[%d]", pid[i]);
> +	}
> +
> +	/* wait all children finish himself task */
> +	for (i = 0; i < nr_child; i++) {
> +		if (waitpid(pid[i], &status, 0) == -1)
> +			tst_brkm(TBROK|TERRNO, cleanup, "waitpid %d", pid[i]);
> +
> +		if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
> +			tst_resm(TFAIL, "the child[%d] unexpectedly failed:"
> +				 " %d", pid[i], status);
> +	}
> +}
> +
> +void check_thp_options(int *nr_child, int *nr_thps)
> +{
> +	if (opt_nr_child)
> +		*nr_child = SAFE_STRTOL(NULL, opt_nr_child_str, 0, LONG_MAX);
> +	if (opt_nr_thps)
> +		*nr_thps = SAFE_STRTOL(NULL, opt_nr_thps_str, 0, LONG_MAX);
> +}
> +
> +void thp_usage(void)
> +{
> +	printf("  -n      Number of processes\n");
> +	printf("  -N      Number of transparent hugepages\n");
> +}
> +
>  /* cpuset/memcg */
>  
>  static void gather_node_cpus(char *cpus, long nd)
> diff --git a/testcases/kernel/mem/thp/thp04.c b/testcases/kernel/mem/thp/thp04.c
> new file mode 100644
> index 0000000..2855eb5
> --- /dev/null
> +++ b/testcases/kernel/mem/thp/thp04.c
> @@ -0,0 +1,136 @@
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
> + * hugepage - THP
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
> +#include "test.h"
> +#include "usctest.h"
> +#include "mem.h"
> +
> +char *TCID = "thp04";
> +int TST_TOTAL = 1;
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

These can be made to static?

> +
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
> +
> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +		tst_count = 0;
> +
> +		test_transparent_hugepage(nr_child, nr_thps, 1);
> +	}
> +
> +	cleanup();
> +	tst_exit();
> +}
> +
> +void setup(void)

static ?

> +{
> +	char path[BUFSIZ];
> +
> +	tst_require_root(NULL);
> +
> +	if (access(PATH_THP, F_OK) == -1)
> +		tst_brkm(TCONF, NULL, "THP is not enabled");
> +
> +	snprintf(path, BUFSIZ, PATH_KHPD "scan_sleep_millisecs");
> +	SAFE_FILE_SCANF(NULL, path, "%d", &pre_thp_scan_sleep_millisecs);
> +	/* set 0 to khugepaged/scan_sleep_millisecs to run khugepaged 100% */
> +	SAFE_FILE_PRINTF(cleanup, path, "%d", 0);
> +
> +	snprintf(path, BUFSIZ, PATH_KHPD "alloc_sleep_millisecs");
> +	SAFE_FILE_SCANF(NULL, path, "%d", &pre_thp_alloc_sleep_millisecs);
> +	/*
> +	 * set 0 to khugepaged/alloc_sleep_millisecs to make sure khugepaged
> +	 * don't stop if there's a hugepage allcation failure.
> +	 */
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

static?

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
