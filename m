Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WBP1P-0000jS-EC
	for ltp-list@lists.sourceforge.net; Thu, 06 Feb 2014 13:29:39 +0000
Date: Thu, 6 Feb 2014 14:29:05 +0100
From: chrubis@suse.cz
Message-ID: <20140206132905.GA4105@rei.suse.cz>
References: <1387201147-3808-1-git-send-email-stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1387201147-3808-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: Re: [LTP] [PATCH] msgctl11: process message queues by portions
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
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> As /proc/sys/kernel/msgmni value scales with an amount of host memory,
> on systems with several tens gigabytes of ram this testcase fails
> with "Not enough free pids" error.
> 
> Now if the amount of free pids is not enough to use all the queues at once
> we process the queues by portions (with the size based on amount of free pids).

The general idea is fine, comments below.

> Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
> ---
>  testcases/kernel/syscalls/ipc/msgctl/msgctl11.c |   98 +++++++++++++----------
>  1 files changed, 57 insertions(+), 41 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl11.c b/testcases/kernel/syscalls/ipc/msgctl/msgctl11.c
> index 57f4ae0..8bbb922 100644
> --- a/testcases/kernel/syscalls/ipc/msgctl/msgctl11.c
> +++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl11.c
> @@ -60,6 +60,7 @@ static int rkidarray[MAXNKIDS];
>  static int wkidarray[MAXNKIDS];
>  static int tid;
>  static int nprocs, nreps, nkids, MSGMNI;
> +static int maxnprocs;
>  static int procstat;
>  
>  void setup(void);
> @@ -67,6 +68,7 @@ void cleanup(void);
>  
>  static void term(int);
>  static int dotest(key_t, int);
> +static void dotest_iteration(int, int);
>  static void cleanup_msgqueue(int i, int tid);
>  
>  #ifdef UCLINUX
> @@ -84,8 +86,7 @@ static void do_child_3_uclinux();
>  
>  int main(int argc, char **argv)
>  {
> -	int i, j, ok, pid;
> -	int count, status;
> +	int i, j, ok;
>  
>  #ifdef UCLINUX
>  	char *msg;
> @@ -109,7 +110,6 @@ int main(int argc, char **argv)
>  	if (argc == 1) {
>  		/* Set default parameters */
>  		nreps = MAXNREPS;
> -		nprocs = MSGMNI;
>  		nkids = maxnkids;
>  	} else if (argc == 4) {
>  		if (atoi(argv[1]) > MAXNREPS) {
> @@ -120,13 +120,12 @@ int main(int argc, char **argv)
>  		} else {
>  			nreps = atoi(argv[1]);
>  		}
> -		if (atoi(argv[2]) > MSGMNI) {
> +		if (atoi(argv[2]) > maxnprocs) {
>  			tst_resm(TCONF,
>  				 "Requested number of processes too large, setting to Max. of %d",
> -				 MSGMNI);
> -			nprocs = MSGMNI;
> +				 maxnprocs);
>  		} else {
> -			nprocs = atoi(argv[2]);
> +			maxnprocs = atoi(argv[2]);
>  		}
>  		if (atoi(argv[3]) > maxnkids) {
>  			tst_resm(TCONF,
> @@ -147,15 +146,14 @@ int main(int argc, char **argv)
>  	srand48((unsigned)getpid() + (unsigned)(getppid() << 16));
>  	tid = -1;
>  
> -	/* Setup signal handleing routine */
> -	if (sigset(SIGTERM, term) == SIG_ERR) {
> -		tst_resm(TFAIL, "Sigset SIGTERM failed");
> -		tst_exit();
> -	}
> +	/* Setup signal handling routine */
> +	if (sigset(SIGTERM, term) == SIG_ERR)
> +		tst_brkm(TFAIL, cleanup, "Sigset SIGTERM failed");

Please keep cleanup changes separate from functional changes.

Also the original testcase is quite messy and deserves to be cleaned
up...

>  	/* Set up array of unique keys for use in allocating message
>  	 * queues
>  	 */
> -	for (i = 0; i < nprocs; i++) {
> +	for (i = 0; i < MSGMNI; i++) {
>  		ok = 1;
>  		do {
>  			/* Get random key */
> @@ -174,13 +172,45 @@ int main(int argc, char **argv)
>  			}
>  		} while (ok == 0);
>  	}
> -	/* Fork a number of processes (nprocs), each of which will
> +	/* Fork a number of processes, each of which will
>  	 * create a message queue with several (nkids) reader/writer
>  	 * pairs which will read and write a number (iterations)
>  	 * of random length messages with specific values (keys).
> +	 *
> +	 * We do not fork more than maxnprocs at a time and
> +	 * we fork until all the message queues get used.
>  	 */
>  
> +	if (MSGMNI < maxnprocs) {

That should be <= otherwise you would unnecessarily call
dotest_iteration() with zero as the number of processes in the else
branch. It looks like it will work, but I would rather see this changed.

> +		dotest_iteration(0, MSGMNI);
> +	} else {
> +		for (i = 0; i < (MSGMNI / maxnprocs); i++)
> +			dotest_iteration(i*(MSGMNI / maxnprocs),
> +					maxnprocs);
> +
> +		dotest_iteration(i*(MSGMNI / maxnprocs),
> +				MSGMNI % maxnprocs);
> +	}
> +
> +	tst_resm(TPASS, "msgctl11 ran successfully!");
> +
> +	cleanup();
> +	tst_exit();
> +}
> +
> +static void dotest_iteration(int idx, int no_of_processes)
> +{

Technically the idx should be named offset or off.

> +	key_t key;
> +	int i, count, status;
> +	pid_t pid;
> +
> +	nprocs = no_of_processes;

This is hacky, you should either pass the number as a function parameter
or in global variable but doing both is messy.

> +	memset(pidarray, 0, MAXNPROCS * sizeof(*pidarray));

In this case MAXNPROCS * sizeof(*pidarray) is just a complicated way to
write sizeof(pidarray).

>  	for (i = 0; i < nprocs; i++) {
> +		key = keyarray[idx + i];
> +
>  		fflush(stdout);
>  		if ((pid = FORK_OR_VFORK()) < 0) {

I've just pushed a change that flushes the test output on
FORK_OR_VFORK() automatically. So we can remove all the fflush(stdout)
from the testcase.

>  			tst_resm(TFAIL,
> @@ -190,13 +220,13 @@ int main(int argc, char **argv)
>  		/* Child does this */
>  		if (pid == 0) {
>  #ifdef UCLINUX
> -			if (self_exec(argv[0], "ndd", 1, keyarray[i], i) < 0) {
> +			if (self_exec(argv0, "ndd", 1, key, i) < 0) {
>  				tst_resm(TFAIL, "\tself_exec failed");
>  				tst_exit();
>  			}
>  #else
>  			procstat = 1;
> -			exit(dotest(keyarray[i], i));
> +			exit(dotest(key, i));
>  #endif
>  		}
>  		pidarray[i] = pid;
> @@ -227,13 +257,6 @@ int main(int argc, char **argv)
>  			 count, nprocs);
>  		tst_exit();
>  	}
> -
> -	tst_resm(TPASS, "msgctl11 ran successfully!");
> -
> -	cleanup();
> -
> -	return (0);
> -
>  }
>  
>  #ifdef UCLINUX
> @@ -453,33 +476,26 @@ void setup(void)
>  
>  	nr_msgqs = get_max_msgqueues();
>  	if (nr_msgqs < 0)
> -		cleanup();
> +		tst_brkm(TBROK, cleanup, "get_max_msgqueues() failed");
>  
>  	MSGMNI = nr_msgqs - get_used_msgqueues();
> -	if (MSGMNI <= 0) {
> -		tst_resm(TBROK,
> +	if (MSGMNI <= 0)
> +		tst_brkm(TBROK, cleanup,
>  			 "Max number of message queues already used, cannot create more.");
> -		cleanup();
> -	}
> +
> +	tst_resm(TINFO, "Found %d available message queues", MSGMNI);
>  
>  	free_pids = get_free_pids();
>  	if (free_pids < 0) {
> -		tst_resm(TBROK, "Can't obtain free_pid count");
> -		tst_exit();
> +		tst_brkm(TBROK, cleanup, "Can't obtain free_pid count");
> +	} else if (!free_pids) {
> +		tst_brkm(TBROK, cleanup, "No free pids");
>  	}
>  
> -	else if (!free_pids) {
> -		tst_resm(TBROK, "No free pids");
> -		tst_exit();
> -	}
> +	maxnprocs = (free_pids / 2) / (1 + 2*maxnkids);

Perpahs this computation is complicated enough to deserve a comment.

> -	if ((MSGMNI * MAXNKIDS * 2) > (free_pids / 2)) {
> -		maxnkids = ((free_pids / 4) / MSGMNI);
> -		if (!maxnkids) {
> -			tst_resm(TBROK, "Not enough free pids");
> -			tst_exit();
> -		}
> -	}
> +	if (!maxnprocs)
> +		tst_brkm(TBROK, cleanup, "Not enough free pids");
>  
>  	tst_resm(TINFO, "Using upto %d pids", free_pids / 2);
>  }

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Managing the Performance of Cloud-Based Applications
Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
Read the Whitepaper.
http://pubads.g.doubleclick.net/gampad/clk?id=121051231&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
