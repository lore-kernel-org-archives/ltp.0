From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 11 Nov 2020 17:31:14 +0100
Subject: [LTP] [PATCH v3 2/4] syscalls/msgstress*: cleanup and convert
 into new api
In-Reply-To: <1603285074-28392-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <20200722154558.GB2714@yuki.lan>
 <1603285074-28392-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1603285074-28392-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20201111163114.GB23576@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> @@ -31,105 +18,61 @@
>  #include <stdlib.h>
>  #include <stdio.h>
>  #include <unistd.h>
> -#include <values.h>
>  #include <sys/types.h>
>  #include <sys/wait.h>
>  #include <sys/stat.h>
>  #include <sys/ipc.h>
>  #include <sys/msg.h>
> -#include "test.h"
> -#include "ipcmsg.h"
> -#include "libmsgctl.h"
> +#include "tst_test.h"
> +#include "libnewipc.h"
> +#include "tst_safe_sysv_ipc.h"
> +#include "msgstress_common.h"
>  
> -char *TCID = "msgstress01";
> -int TST_TOTAL = 1;
> -
> -#ifndef CONFIG_COLDFIRE
> -#define MAXNPROCS	1000000	/* This value is set to an arbitrary high limit. */
> -#else
> -#define MAXNPROCS	 100000	/* Coldfire can't deal with 1000000 */
> -#endif
> +#define MAXNPROCS       1000000
>  #define MAXNREPS	100000
>  
>  static key_t keyarray[MAXNPROCS];
> -static int pidarray[MAXNPROCS];
>  static int tid;
>  static int MSGMNI, nprocs, nreps;
> -static int procstat;
> -static int mykid;
> -
> -void setup(void);
> -void cleanup(void);
> -
> -static int dotest(key_t key, int child_process);
> -static void sig_handler();
> -
>  static char *opt_nprocs;
>  static char *opt_nreps;
> +static void cleanup(void);
>  
> -static option_t options[] = {
> -	{"n:", NULL, &opt_nprocs},
> -	{"l:", NULL, &opt_nreps},
> -	{NULL, NULL, NULL},
> +static struct tst_option options[] = {
> +	{"n:", &opt_nprocs, "-n N     Number of processes"},
> +	{"l:", &opt_nreps, "-l N     Number of iterations"},
> +	{NULL, NULL, NULL}
>  };
>  
> -static void usage(void)
> -{
> -	printf("  -n      Number of processes\n");
> -	printf("  -l      Number of iterations\n");
> -}
> -
> -int main(int argc, char **argv)
> +static void dotest(key_t key, int child_process)
>  {
> -	int i, j, ok, pid;
> -	int count, status;
> -	struct sigaction act;
> -
> -	tst_parse_opts(argc, argv, options, usage);
> -
> -	setup();
> +	int pid;
>  
> -	nreps = MAXNREPS;
> -	nprocs = MSGMNI;
> +	tid = SAFE_MSGGET(key, IPC_CREAT | S_IRUSR | S_IWUSR);
>  
> -	if (opt_nreps) {
> -		nreps = atoi(opt_nreps);
> -		if (nreps > MAXNREPS) {
> -			tst_resm(TINFO,
> -				 "Requested number of iterations too large, "
> -				 "setting to Max. of %d", MAXNREPS);
> -			nreps = MAXNREPS;
> -		}
> +	pid = SAFE_FORK();
> +	if (pid == 0) {
> +		do_reader(key, tid, 1, child_process, nreps);
> +		exit(0);
>  	}
>  
> -	if (opt_nprocs) {
> -		nprocs = atoi(opt_nprocs);
> -		if (nprocs > MSGMNI) {
> -			tst_resm(TINFO,
> -				 "Requested number of processes too large, "
> -				 "setting to Max. of %d", MSGMNI);
> -			nprocs = MSGMNI;
> -		}
> -	}
> +	do_writer(key, tid, 1, child_process, nreps);
> +	SAFE_WAIT(NULL);
> +	SAFE_MSGCTL(tid, IPC_RMID, NULL);
> +}
> +
> +static void verify_msgstress(void)
> +{
> +	int i, j, ok, pid;
> +	int count;
>  
>  	srand(getpid());
>  	tid = -1;
>  
> -	/* Setup signal handling routine */
> -	memset(&act, 0, sizeof(act));
> -	act.sa_handler = sig_handler;
> -	sigemptyset(&act.sa_mask);
> -	sigaddset(&act.sa_mask, SIGTERM);
> -	if (sigaction(SIGTERM, &act, NULL) < 0) {
> -		tst_brkm(TFAIL, NULL, "Sigset SIGTERM failed");
> -	}
> -	/* Set up array of unique keys for use in allocating message
> -	 * queues
> -	 */
> +	/* Set up array of unique keys for use in allocating message queues */
>  	for (i = 0; i < nprocs; i++) {

>  		ok = 1;
>  		do {
> -			/* Get random key */
>  			keyarray[i] = (key_t) rand();
>  			/* Make sure key is unique and not private */
>  			if (keyarray[i] == IPC_PRIVATE) {
> @@ -146,156 +89,83 @@ int main(int argc, char **argv)
>  		} while (ok == 0);
>  	}

The functions that setups the keys should go to the library as well.

> -	/* Fork a number of processes, each of which will
> +	/*
> +	 * Fork a number of processes, each of which will
>  	 * create a message queue with one reader/writer
>  	 * pair which will read and write a number (iterations)
>  	 * of random length messages with specific values.
>  	 */
> -
>  	for (i = 0; i < nprocs; i++) {
> -		fflush(stdout);
> -		if ((pid = FORK_OR_VFORK()) < 0) {
> -			tst_brkm(TFAIL,
> -				 NULL,
> -				 "\tFork failed (may be OK if under stress)");
> -		}
> -		/* Child does this */
> +		pid = SAFE_FORK();
>  		if (pid == 0) {
> -			procstat = 1;
> -			exit(dotest(keyarray[i], i));
> +			dotest(keyarray[i], i);
> +			exit(0);
>  		}
> -		pidarray[i] = pid;
>  	}
>  
>  	count = 0;
> +
>  	while (1) {
> -		if ((wait(&status)) > 0) {
> -			if (status >> 8 != 0) {
> -				tst_brkm(TFAIL, NULL,
> -					 "Child exit status = %d",
> -					 status >> 8);
> -			}
> +		if (wait(NULL) > 0) {
>  			count++;
>  		} else {
> -			if (errno != EINTR) {
> +			if (errno != EINTR)
>  				break;
> -			}
> -#ifdef DEBUG
> -			tst_resm(TINFO, "Signal detected during wait");
> -#endif
>  		}
>  	}
> -	/* Make sure proper number of children exited */
> -	if (count != nprocs) {
> -		tst_brkm(TFAIL,
> -			 NULL,
> -			 "Wrong number of children exited, Saw %d, Expected %d",
> -			 count, nprocs);
> -	}
>  
> -	tst_resm(TPASS, "Test ran successfully!");
> +	if (count != nprocs)
> +		tst_brk(TFAIL, "Wrong number of children exited, Saw %d, Expected %d",
> +			count, nprocs);
>  
> +	tst_res(TPASS, "Test ran successfully!");
>  	cleanup();

The cleanup will be called by the library, you must not call it here
yourself.

> -	tst_exit();
> -}
> -
> -static int dotest(key_t key, int child_process)
> -{
> -	int id, pid;
> -	int ret, status;
> -
> -	sighold(SIGTERM);
> -	TEST(msgget(key, IPC_CREAT | S_IRUSR | S_IWUSR));
> -	if (TEST_RETURN < 0) {
> -		printf("msgget() error in child %d: %s\n",
> -			child_process, strerror(TEST_ERRNO));
> -
> -		return FAIL;
> -	}
> -	tid = id = TEST_RETURN;
> -	sigrelse(SIGTERM);
> -
> -	fflush(stdout);
> -	if ((pid = FORK_OR_VFORK()) < 0) {
> -		printf("\tFork failed (may be OK if under stress)\n");
> -		TEST(msgctl(tid, IPC_RMID, 0));
> -		if (TEST_RETURN < 0) {
> -			printf("mscgtl() error in cleanup: %s\n",
> -				strerror(TEST_ERRNO));
> -		}
> -		return FAIL;
> -	}
> -	/* Child does this */
> -	if (pid == 0)
> -		exit(doreader(key, id, 1, child_process, nreps));
> -	/* Parent does this */
> -	mykid = pid;
> -	procstat = 2;
> -	ret = dowriter(key, id, 1, child_process, nreps);
> -	wait(&status);
> -
> -	if (ret != PASS)
> -		exit(FAIL);
> -
> -	if ((!WIFEXITED(status) || (WEXITSTATUS(status) != PASS)))
> -		exit(FAIL);
> -
> -	TEST(msgctl(id, IPC_RMID, 0));
> -	if (TEST_RETURN < 0) {
> -		printf("msgctl() errno %d: %s\n",
> -			TEST_ERRNO, strerror(TEST_ERRNO));
> -
> -		return FAIL;
> -	}
> -	return PASS;
>  }
>  
> -static void sig_handler(void)
> -{
> -}
> -
> -void setup(void)
> +static void setup(void)
>  {
>  	int nr_msgqs;
>  
> -	tst_tmpdir();
> +	SAFE_FILE_SCANF("/proc/sys/kernel/msgmni", "%d", &nr_msgqs);
>  
> -	tst_sig(FORK, DEF_HANDLER, cleanup);
> +	nr_msgqs -= GET_USED_QUEUES();
> +	if (nr_msgqs <= 0)
> +		tst_brk(TCONF, "Max number of message queues already used, "
> +			"cannot create more.");

LKML coding style prefers not to break strings even if they are over 80
chars.

> -	TEST_PAUSE;
> +	MSGMNI = min(nr_msgqs, NR_MSGQUEUES);

> -	nr_msgqs = get_max_msgqueues();
> -	if (nr_msgqs < 0)
> -		cleanup();
> +	if (opt_nreps) {
> +		nreps = SAFE_STRTOL(opt_nreps, 1, INT_MAX);
> +		nreps = min(nreps, MAXNREPS);
> +	} else {
> +		nreps = MAXNREPS;
> +	}
> -	nr_msgqs -= get_used_msgqueues();
> -	if (nr_msgqs <= 0) {
> -		tst_resm(TBROK,
> -			 "Max number of message queues already used, cannot create more.");
> -		cleanup();
> +	if (opt_nprocs) {
> +		nprocs = SAFE_STRTOL(opt_nprocs, 1, INT_MAX);
> +		nprocs = min(nprocs, MAXNPROCS);
> +		nprocs = min(nprocs, MSGMNI);
> +	} else {
> +		nprocs = MSGMNI;
>  	}

This looks completely wrong in this test we basically fork nproc
processes and each of them runs one message queue. There is no point in
setting anything else than nprocs and the nprocs is limited by the
number of possible message queues.

So all this setup should be something as:


static int nprocs = MAXNPROCS;
static int nreps = MAXNREPS;

...

	unsigned int avail_msg_queues = get_avail_msgqueues();

	if (opt_nprocs)
		nprocs = SAFE_STRTOL(opt_nprocs, 1, MAXNPROCS);

	if (nprocs > avail_msg_queues) {
		tst_res(TINFO, "Setting max processes to %u", avail_msg_queues);
		nprocs = avail_msg_queues;
	}

	if (opt_nreps)
		nreps = SAFE_STRTOL(opt_nreps, 1, MAXNREPS);

Where the get_avail_msgqueues() is a library function that returns the
max_queues - used_queues.


> -	/*
> -	 * Since msgmni scales to the memory size, it may reach huge values
> -	 * that are not necessary for this test.
> -	 * That's why we define NR_MSGQUEUES as a high boundary for it.
> -	 */
> -	MSGMNI = min(nr_msgqs, NR_MSGQUEUES);
> +	SAFE_SIGNAL(SIGTERM, SIG_IGN);
> +	tst_res(TINFO, "Number of message queues is %d, process is %d, "
> +		"iterations is %d", MSGMNI, nprocs, nreps);

The LKML coding style prefers not to break strings even if they are
longer than 80 chars.

>  }
>  
>  void cleanup(void)
>  {
> -	int status;
> -
> -#ifdef DEBUG
> -	tst_resm(TINFO, "Removing the message queue");
> -#endif
> -	(void)msgctl(tid, IPC_RMID, NULL);
> -	if ((status = msgctl(tid, IPC_STAT, NULL)) != -1) {
> -		(void)msgctl(tid, IPC_RMID, NULL);
> -		tst_resm(TFAIL, "msgctl(tid, IPC_RMID) failed");
> -
> -	}
> -
> -	tst_rmdir();
> +	if (tid >= 0)
> +		SAFE_MSGCTL(tid, IPC_RMID, NULL);
>  }
> +
> +static struct tst_test test = {
> +	.needs_tmpdir = 1,
> +	.options = options,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.forks_child = 1,
> +	.test_all = verify_msgstress,
> +};

And I've run out of time for today, but I think that similar comments
would apply for the rest of the testcases as well.

It would also be easier if there was one patch per testcase, that would
make it easier to review as well.

-- 
Cyril Hrubis
chrubis@suse.cz
