Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1URijl-00012A-VF
	for ltp-list@lists.sourceforge.net; Mon, 15 Apr 2013 12:42:22 +0000
Date: Mon, 15 Apr 2013 14:43:05 +0200
From: chrubis@suse.cz
Message-ID: <20130415124305.GC1091@rei>
References: <cover.1366016616.git.zliu@redhat.com>
	<9ef6222c6ec4ae13864cb6983a907fe41704cb16.1366016616.git.zliu@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9ef6222c6ec4ae13864cb6983a907fe41704cb16.1366016616.git.zliu@redhat.com>
Subject: Re: [LTP] [PATCH v4 1/3] mm/thp: new case thp04.c
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

Hi!
> +static void khugepaged_scan_done(void)
> +{
> +	int changing = 1, count = 0;
> +	long old_pages_collapsed, old_max_ptes_none, old_pages_to_scan;
> +	long pages_collapsed = 0, max_ptes_none = 0, pages_to_scan = 0;
> +
> +	while (changing) {
> +		/*
> +		 * as 'khugepaged' run 100% during testing, so 10s
> +		 * is an enough for us to recognize if 'khugepaged'
> +		 * finish scanning proceses' anonymouse hugepages
                                                ^
                                             anonymous

> +		 * or not.
> +		 */
> +		sleep(10);
> +		count++;
> +
> +		SAFE_FILE_SCANF(cleanup, PATH_KHPD "pages_collapsed",
> +			       "%ld", &pages_collapsed);
> +		SAFE_FILE_SCANF(cleanup, PATH_KHPD "max_ptes_none",
> +			       "%ld", &max_ptes_none);
> +		SAFE_FILE_SCANF(cleanup, PATH_KHPD "pages_to_scan",
> +			       "%ld", &pages_to_scan);
> +
> +		if (pages_collapsed != old_pages_collapsed ||
> +		    max_ptes_none != old_max_ptes_none ||
> +		    pages_to_scan != old_pages_to_scan) {
> +			old_pages_collapsed = pages_collapsed;
> +			old_max_ptes_none = max_ptes_none;
> +			old_pages_to_scan = pages_to_scan;
> +		} else {
> +			changing = 0;
> +		}
> +	}
> +
> +	tst_resm(TINFO, "khugepaged daemon takes %ds to scan all thp pages",
> +		 count * 10);
> +}

Ah, so it acutally does polling, this is fine.

How long scanning takes. If it is about 10 seconds, we should poll
faster so that the testcase has chance to finish reasonably fast.
(if it takes 10 seconds and we miss the first windows it will sleep
 doing noting for another ten seconds)

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
> +	unsigned long hugepagesize, memfree;
> +	int i, *pid, ret, status;
> +	char path[BUFSIZ];
> +
> +	memfree = read_meminfo("MemFree:");
> +	tst_resm(TINFO, "The current MemFree is %luMB", memfree / KB);
> +	if (memfree < MB)
> +		tst_resm(TWARN, "The system has low memory, which maybe "
> +				"cause the case failed");

Hmm, TWARN is most likely wrong here, as it gets propagated into the
test return value. If it is known to fail on low memory, I would just
exit with TCONF and "Not enough memory for testing" message. Comments
anybody?

> +	hugepagesize = read_meminfo("Hugepagesize:");
> +
> +	pid = malloc(nr_child * sizeof(int));
> +	if (pid == NULL)
> +		tst_brkm(TBROK | TERRNO, cleanup, "malloc");

This is really small nit, but I would have named this array as 'pids'.

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
                                       ^
				    their tasks

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
> index 0000000..0f6c553
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
> +static int pre_thp_scan_sleep_millisecs;
> +static int pre_thp_alloc_sleep_millisecs;
> +static char pre_thp_enabled[BUFSIZ];
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

The PATH_KPHD and "scan_sleep_millisecs" are both static strings and are
merged before they are passed to the snprintf() at compile time, which
results in printf format string __without__ any characters to
substitute. This is really weird.

> +	/* set 0 to khugepaged/scan_sleep_millisecs to run khugepaged 100% */
> +	SAFE_FILE_PRINTF(cleanup, path, "%d", 0);

I'm confused here, this is the only function in the setup that takes a
pointer to the cleanup defined bellow.

> +	snprintf(path, BUFSIZ, PATH_KHPD "alloc_sleep_millisecs");
> +	SAFE_FILE_SCANF(NULL, path, "%d", &pre_thp_alloc_sleep_millisecs);
> +	/*
> +	 * set 0 to khugepaged/alloc_sleep_millisecs to make sure khugepaged
> +	 * don't stop if there's a hugepage allcation failure.
> +	 */
> +	SAFE_FILE_PRINTF(NULL, path, "%d", 0);
> +
> +	snprintf(path, BUFSIZ, PATH_THP "enabled");

Here as well.

> +	write_file(path, "always");

Where this came from? Does the function check for failures? Why not to
use SAFE_FILE_PRINTF() as the rest of the file?

> +	tst_sig(FORK, DEF_HANDLER, NULL);
> +	TEST_PAUSE;
> +}
> +
> +void cleanup(void)
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

Same here.

> +	TEST_CLEANUP;
> +}
> -- 
> 1.7.11.7
> 
> 
> ------------------------------------------------------------------------------
> Precog is a next-generation analytics platform capable of advanced
> analytics on semi-structured data. The platform includes APIs for building
> apps and a phenomenal toolset for data science. Developers can use
> our toolset for easy data analysis & visualization. Get a free account!
> http://www2.precog.com/precogplatform/slashdotnewsletter
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Precog is a next-generation analytics platform capable of advanced
analytics on semi-structured data. The platform includes APIs for building
apps and a phenomenal toolset for data science. Developers can use
our toolset for easy data analysis & visualization. Get a free account!
http://www2.precog.com/precogplatform/slashdotnewsletter
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
