Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Wz5a3-0004PE-6V
	for ltp-list@lists.sourceforge.net; Mon, 23 Jun 2014 14:50:47 +0000
Date: Mon, 23 Jun 2014 16:50:28 +0200
From: chrubis@suse.cz
Message-ID: <20140623145028.GD6050@rei.Home>
References: <1403513949-24653-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
	<1403513949-24653-2-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1403513949-24653-2-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 2/2] pan/ltp-pan.c: add statistics about not fully
 tested testcases
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
To: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Currently numbers of testcases in LTP will return TCONF when they are not
> appropriate to run. But when users execute './runltp' to run the default
> test suite towards an linux distribution or upstream kernel, if testcases
> return TCONF, ultimately they will print TPASS to users, then users will
> not know the real LTP test coverage.
> 
> Here we change this behaviour and show users testcases which return TCONF,
> meaning that these testcases are not fully tested.
> 
> Here is a sample:
> 1. Before this patch, The output will be:
> Test Start Time: Mon Jun 23 16:06:07 2014
> -----------------------------------------
> Testcase                       Result     Exit Value
> --------                       ------     ----------
> access01                       PASS       0
> access02                       PASS       0
> access03                       PASS       0
> getxattr01                     PASS       0
> getxattr02                     PASS       0
> access04                       PASS       0
> access05                       PASS       0
> access06                       PASS       0
> 
> -----------------------------------------------
> Total Tests: 8
> Total Failures: 0
> Kernel Version: 3.16.0-rc1+
> Machine Architecture: x86_64
> Hostname: localhost.localdomain
> 
> 2. After this patch, the output will be:
> Test Start Time: Mon Jun 23 16:17:50 2014
> -----------------------------------------
> Testcase                       Result          Exit Value
> --------                       ------          ----------
> access01                       PASS                 0
> access02                       PASS                 0
> access03                       PASS                 0
> getxattr01                     Not Fully Tested     32
> getxattr02                     Not Fully Tested     32

I would preffer TCONF instead of the "Not Fully Tested" string, because
the "Not Fully Tested" sounds more like the test was finished (testcases
not written), while TCONF means that the system lacks kernel or libc
support or system resources or similar to execute the test.

What should be improved here is the documentation which should explain
what TCONF means. I guess that we need some introduction document on how
to run LTP and how to interpret the results but that is outside of the
scope for this patch.

> access04                       PASS                 0
> access05                       PASS                 0
> access06                       PASS                 0
> 
> -----------------------------------------------
> Total Tests: 8
> Total Test Not Fully Tested: 2
> Total Failures: 0
> Kernel Version: 3.16.0-rc1+
> Machine Architecture: x86_64
> Hostname: localhost.localdomain
> 
> Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
> ---
>  lib/tst_res.c |  2 +-
>  pan/ltp-pan.c | 46 +++++++++++++++++++++++++++++++++++-----------
>  2 files changed, 36 insertions(+), 12 deletions(-)
> 
> diff --git a/lib/tst_res.c b/lib/tst_res.c
> index c179e31..31186e0 100644
> --- a/lib/tst_res.c
> +++ b/lib/tst_res.c
> @@ -563,7 +563,7 @@ void tst_exit(void)
>  	tst_flush();
>  
>  	/* Mask out TRETR, TINFO, and TCONF results from the exit status. */
> -	exit(T_exitval & ~(TRETR | TINFO | TCONF));
> +	exit(T_exitval & ~(TRETR | TINFO));
>  }

That is OK, but we need to change the shell library as well.

See tst_exit() in ltp/testcases/lib/test.sh

>  pid_t tst_fork(void)
> diff --git a/pan/ltp-pan.c b/pan/ltp-pan.c
> index c36a9ee..679822a 100644
> --- a/pan/ltp-pan.c
> +++ b/pan/ltp-pan.c
> @@ -68,6 +68,17 @@
>  #include "splitstr.h"
>  #include "zoolib.h"
>  
> +/* Use low 6 bits to encode test result type */
> +#define TTYPE_MASK 0x3f
> +#define TPASS	0	/* Test passed flag */
> +#define TFAIL	1	/* Test failed flag */
> +#define TBROK	2	/* Test broken flag */
> +#define TWARN	4	/* Test warning flag */
> +#define TRETR	8	/* Test retire flag */
> +#define TINFO	16	/* Test information flag */
> +#define TCONF	32	/* Test not appropriate for configuration flag */
> +#define TTYPE_RESULT(ttype)	((ttype) & TTYPE_MASK)

This is copy & paste from the test.h isn't it?

We should put these into shared header and include it to both ltp-pan as
well as test.h (assuming that you ommited including test.h because it
contains quite a lot of fucntions that are not usable from ltp-pan).

>  /* One entry in the command line collection.  */
>  struct coll_entry {
>  	char *name;		/* tag name */
> @@ -104,7 +115,7 @@ static void pids_running(struct tag_pgrp *running, int keep_active);
>  static int check_pids(struct tag_pgrp *running, int *num_active,
>  		      int keep_active, FILE * logfile, FILE * failcmdfile,
>  		      struct orphan_pgrp *orphans, int fmt_print,
> -		      int *failcnt, int quiet_mode);
> +		      int *failcnt, int *not_fully_run_cases, int quiet_mode);

Again, I would stick to conf for names, i.e. confcnt and the same in the
rest of the code.

>  static void propagate_signal(struct tag_pgrp *running, int keep_active,
>  			     struct orphan_pgrp *orphans);
>  static void dump_coll(struct collection *coll);
> @@ -160,6 +171,8 @@ int main(int argc, char **argv)
>  	int keep_active = 1;
>  	int num_active = 0;
>  	int failcnt = 0;	/* count of total testcases that failed. */
> +	/* count of total testcases that are not fully run*/
> +	int not_fully_run_cases = 0;
>  	int err, i;
>  	int starts = -1;
>  	int timed = 0;
> @@ -332,9 +345,9 @@ int main(int argc, char **argv)
>  			fprintf(logfile, "Test Start Time: %s\n", s);
>  			fprintf(logfile,
>  				"-----------------------------------------\n");
> -			fprintf(logfile, "%-30.20s %-10.10s %-10.10s\n",
> +			fprintf(logfile, "%-30.20s %-15.15s %-10.10s\n",
>  				"Testcase", "Result", "Exit Value");
> -			fprintf(logfile, "%-30.20s %-10.10s %-10.10s\n",
> +			fprintf(logfile, "%-30.20s %-15.15s %-10.10s\n",
>  				"--------", "------", "------------");
>  		}
>  		fflush(logfile);
> @@ -568,7 +581,7 @@ int main(int argc, char **argv)
>  
>  		err = check_pids(running, &num_active, keep_active, logfile,
>  				 failcmdfile, orphans, fmt_print, &failcnt,
> -				 quiet_mode);
> +				 &not_fully_run_cases, quiet_mode);
>  		if (Debug & Drunning) {
>  			pids_running(running, keep_active);
>  			orphans_running(orphans);
> @@ -628,6 +641,8 @@ int main(int argc, char **argv)
>  		fprintf(logfile,
>  			"\n-----------------------------------------------\n");
>  		fprintf(logfile, "Total Tests: %d\n", coll->cnt);
> +		fprintf(logfile, "Total Test Not Fully Tested: %d\n",
> +			not_fully_run_cases);

Hmm, the best message I can think of here is "Total Skipped Tests: "

>  		fprintf(logfile, "Total Failures: %d\n", failcnt);
>  		fprintf(logfile, "Kernel Version: %s\n", unamebuf.release);
>  		fprintf(logfile, "Machine Architecture: %s\n",
> @@ -679,7 +694,8 @@ propagate_signal(struct tag_pgrp *running, int keep_active,
>  static int
>  check_pids(struct tag_pgrp *running, int *num_active, int keep_active,
>  	   FILE * logfile, FILE * failcmdfile, struct orphan_pgrp *orphans,
> -	   int fmt_print, int *failcnt, int quiet_mode)
> +	   int fmt_print, int *failcnt, int *not_fully_run_cases,
> +	   int quiet_mode)
>  {
>  	int w;
>  	pid_t cpid;
> @@ -688,6 +704,7 @@ check_pids(struct tag_pgrp *running, int *num_active, int keep_active,
>  	int i;
>  	time_t t;
>  	char *status;
> +	char *result_str;
>  	int signaled = 0;
>  	struct tms tms1, tms2;
>  	clock_t tck;
> @@ -735,7 +752,7 @@ check_pids(struct tag_pgrp *running, int *num_active, int keep_active,
>  					"child %d exited with status %d\n",
>  					cpid, w);
>  			--*num_active;
> -			if (w != 0)
> +			if (w != 0 && w != TCONF)
>  				ret++;
>  		} else if (WIFSTOPPED(stat_loc)) {	/* should never happen */
>  			w = WSTOPSIG(stat_loc);
> @@ -782,13 +799,20 @@ check_pids(struct tag_pgrp *running, int *num_active, int keep_active,
>  							(int)(tms2.tms_cstime -
>  							      tms1.tms_cstime));
>  					else {
> -						if (w != 0)
> -							++ * failcnt;
> +						if (strcmp(status, "exited") == 0 && TTYPE_RESULT(w) == TCONF) {
> +							++*not_fully_run_cases;
> +							result_str = "Not Fully Tested";
> +						} else if (w != 0) {
> +							++*failcnt;
> +							result_str = "FAIL";
> +						} else {
> +							result_str = "PASS";
> +						}

The TTYPE_RESULT() IMHO is not needed here because if you look at
tst_res() it's applied to filter out TERRNO and TTERRNO before the
return value is stored (which is the value later masked for TINFO and
TRETR and returned by tst_exit()). Or am I mistaken?

Otherwise the logic seems fine to me. I.e. if only TCONF bit is set,
return TCONF otherwise it's a failure.


Othewise it looks good to me (I will have to look closer on ltp-pan.c
source to make sure that these changes are 100% Ok, which I will do for
the next iteration).

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
HPCC Systems Open Source Big Data Platform from LexisNexis Risk Solutions
Find What Matters Most in Your Big Data with HPCC Systems
Open Source. Fast. Scalable. Simple. Ideal for Dirty Data.
Leverages Graph Analysis for Fast Processing & Easy Data Exploration
http://p.sf.net/sfu/hpccsystems
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
