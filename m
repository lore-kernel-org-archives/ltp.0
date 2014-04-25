Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1WdggC-0004nQ-Lo
	for ltp-list@lists.sourceforge.net; Fri, 25 Apr 2014 14:00:40 +0000
Received: from mx6-phx2.redhat.com ([209.132.183.39])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Wdgg9-0002mj-QL
	for ltp-list@lists.sourceforge.net; Fri, 25 Apr 2014 14:00:40 +0000
Date: Fri, 25 Apr 2014 10:00:23 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1400546492.10228732.1398434422995.JavaMail.zimbra@redhat.com>
In-Reply-To: <1398423247-17525-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
References: <1398423247-17525-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH v3] pipeio/pipeio.c: cleanup and add it to run
 default
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





----- Original Message -----
> From: "Xiaoguang Wang" <wangxg.fnst@cn.fujitsu.com>
> To: ltp-list@lists.sourceforge.net
> Sent: Friday, 25 April, 2014 12:54:07 PM
> Subject: [LTP] [PATCH v3] pipeio/pipeio.c: cleanup and add it to run default
> 
> Delete some useless comments and fix some.
> 
> Use SAFE_* macros.
> 
> Make a re-arrangement on original code: let parent process
> work in do_parent(), child process work in do_child(), and
> arguments parse and initialization work in setup().
> 
> Delete several useless or pointless options:
>   Option C: this option is not supported and has no effect to this test.
> 
>   Option B: if this option is specified, the parent process will always
> return 0, which won't reflect the correct test results. I think it does
> not make much sense and remove it.
> 
>   Option d: this option is used to specify a directory, where named pipe
> is created, other than the current directory. Since tst_tmpdir() will
> create a temporary directory, so I think "-d" option can be removed.
> 
> printf() is not async-signal-safe, so use write(2) in signal handler
> directly.
> 
> Some cleanup.
> 
> Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>

Thanks for tidying up those global variables. I went over code split between
main(), do_parent() and do_child() again and haven't noticed any issues.
I also ran this testcase with various parameters on RHEL6.5 and RHEL7,
all PASSed, ACK.

Regards,
Jan

> ---
>  scenario_groups/default              |   1 +
>  testcases/kernel/ipc/pipeio/pipeio.c | 963
>  ++++++++++++++++-------------------
>  2 files changed, 441 insertions(+), 523 deletions(-)
> 
> diff --git a/scenario_groups/default b/scenario_groups/default
> index 196e636..bf7ab79 100644
> --- a/scenario_groups/default
> +++ b/scenario_groups/default
> @@ -27,3 +27,4 @@ hyperthreading
>  kernel_misc
>  modules
>  fs_ext4
> +pipes
> diff --git a/testcases/kernel/ipc/pipeio/pipeio.c
> b/testcases/kernel/ipc/pipeio/pipeio.c
> index 7dfbe44..479d5c8 100644
> --- a/testcases/kernel/ipc/pipeio/pipeio.c
> +++ b/testcases/kernel/ipc/pipeio/pipeio.c
> @@ -52,28 +52,18 @@
>  #include "tlibio.h"
>  
>  #include "test.h"
> +#include "usctest.h"
> +#include "safe_macros.h"
>  
> -char *TCID = "pipeio";		/* Test program identifier.    */
> -int TST_TOTAL = 1;		/* Total number of test cases. */
> +char *TCID = "pipeio";
> +int TST_TOTAL = 1;
>  
>  #define SAFE_FREE(p) { if (p) { free(p); (p)=NULL; } }
>  
> -/* To avoid extensive modifications to the code, use this bodge */
> -#define exit(x) myexit(x)
> -void myexit(int x)
> -{
> -	if (x)
> -		tst_resm(TFAIL, "Test failed");
> -	else
> -		tst_resm(TPASS, "Test passed");
> -	tst_exit();
> -}
> -
>  #if defined(__linux__)
>  #define NBPW sizeof(int)
>  #endif
>  
> -#define PPATH "tpipe"
>  #define OCTAL	'o'
>  #define HEX	'x'
>  #define DECIMAL	'd'
> @@ -90,130 +80,145 @@ void myexit(int x)
>  #define MAX_ERRS 16
>  #define MAX_EMPTY 256
>  
> -void sig_handler(), help(), usage(), prt_buf(), prt_examples();
> -void sig_child();
> +static int parse_options(int argc, char *argv[]);
> +static void setup(int argc, char *argv[]);
> +static void cleanup(void);
> +
> +static void do_child(void);
> +static void do_parent(void);
> +
> +static void help(void), usage(void), prt_examples(void);
> +static void prt_buf(char **addr, char *buf, int length, int format);
> +static void sig_child(int sig);
> +static int check_rw_buf(void);
> +
> +static volatile sig_atomic_t nchildcompleted;
> +
> +/* variables may be modified in setup() */
> +static int num_writers = 1;	/* number of writers */
> +static int num_writes = 1;	/* number of writes per child */
> +static int loop;		/* loop indefinitely */
> +static int exit_error = 1;	/* exit on error #, zero means no exit */
> +static int size = 327;		/* default size */
> +static int unpipe;		/* un-named pipe if non-zero */
> +static int verbose;		/* verbose mode if set */
> +static int quiet;		/* quiet mode if set */
> +static int num_rpt;		/* ping number, how often to print message */
> +static int chld_wait;	/* max time to wait between writes, 1 == no wait */
> +static int parent_wait;	/* max time to wait between reads, 1 == no wait */
> +static int ndelay = O_NDELAY;	/* additional flag to open */
> +static char *writebuf;
> +static char *readbuf;
> +static char pname[PATH_MAX];	/* contains the name of the named pipe */
> +static char *blk_type = NON_BLOCKING_IO; /* blocking i/o or not */
> +static char *pipe_type;		/* type of pipe under test */
> +static int format = HEX;
> +static int format_size = -1;
> +static int iotype;		/* sync io */
> +
> +/* variables will be modified in running */
> +static int error;
> +static int count;
> +static int read_fd;
> +static int write_fd;
> +static int empty_read;
> +static int sem_id;
> +
> +static union semun {
> +	int val;
> +	struct semid_ds *buf;
> +	unsigned short int *array;
> +} u;
> +
> +int main(int ac, char *av[])
> +{
> +	int i;
> +	unsigned int j;
> +	unsigned int uwait_iter = 1000, uwait_total = 5000000;
> +	pid_t child;
>  
> -int count = 0;
> -int Nchildcomplete = 0;
> +	setup(ac, av);
>  
> -/*
> - * Ensure PATH_MAX is define
> - */
> -#ifndef PATH_MAX
> -#ifdef MAXPATHLEN
> -#define PATH_MAX MAXPATHLEN
> -#else
> -#define PATH_MAX 1024
> -#endif /* ! MAXPATHLEN */
> -#endif /* PATH_MAX */
> -
> -int main(ac, av)
> -int ac;
> -char *av[];
> -{
> -	int i, j, c, error = 0;
> -	int n;
> -	int nb;			/* number of bytes read */
> -	int num_wrters = 1;	/* number of writers */
> -	int num_writes = 1;	/* number of writes per child */
> -	int loop = 0;		/* loop indefinitely */
> -	int exit_error = 1;	/* exit on error #, zero means no exit */
> -	int size = 327;		/* default size */
> -	int unpipe = 0;		/* un-named pipe if non-zero */
> -	int verbose = 0;	/* verbose mode if set */
> -	int quiet = 0;		/* quiet mode if set */
> -	int num_rpt = 0;	/* ping number, how often to print message */
> -	int chld_wait = 0;	/* max time to wait between writes, 1 == no wait */
> -	int parent_wait = 0;	/* max time to wait between reads, 1 == no wait */
> -	int ndelay = O_NDELAY;	/* additional flag to open */
> -	long clock;
> -	char *writebuf = NULL;
> -	char *readbuf = NULL;
> -	double d;
> -	char *cp;
> -	extern char *optarg;
> -	char pname[PATH_MAX];	/* contains the name of the unamed pipe */
> -	char dir[PATH_MAX];	/* directory to create pipe in          */
> -	char *blk_type;		/* blocking i/o or not */
> -	char *pipe_type;	/* type of pipe under test */
> -	int fds[2];		/* un-named pipe fds */
> -	int read_fd = 0;
> -	int write_fd = 0;
> -	int empty_read = 0;
> -	time_t start_time, current_time, diff_time;	/* start time, current time,
> diff of times */
> -	int *count_word;	/* holds address where to write writers count */
> -	int *pid_word;		/* holds address where to write writers pid */
> -	int format;
> -	int format_size = -1;
> -	int background = 0;	/* if set, put process in background */
> -	struct stat stbuf;
> -	int iotype = 0;		/* sync io */
> -	char *toutput;		/* for getenv() */
> -	int sem_id;
> -	struct sembuf sem_op;
> -	union semun {		/* for semctl() */
> -		int val;
> -		struct semid_ds *buf;
> -		unsigned short int *array;
> -	} u;
> -	unsigned int uwait_iter = 1000;
> -	unsigned int uwait_total = 5000000;
> -
> -	u.val = 0;
> -	format = HEX;
> -	blk_type = NON_BLOCKING_IO;
> -	dir[0] = '\0';
> -	sprintf(pname, "%s.%d", PPATH, getpid());
> -
> -	if ((toutput = getenv("TOUTPUT")) != NULL) {
> -		if (strcmp(toutput, "NOPASS") == 0) {
> -			quiet = 1;
> +	for (i = num_writers; i > 0; --i) {
> +
> +		child = tst_fork();
> +		switch (child) {
> +		case -1:
> +			tst_brkm(TBROK | TERRNO, cleanup, "fork() failed");
> +		case 0:
> +			do_child();
> +			exit(0);
> +		default:
> +			break;
>  		}
>  	}
>  
> -	while ((c =
> -		getopt(ac, av,
> -		       "T:BbCc:D:d:he:Ef:i:I:ln:p:qs:uvW:w:P:")) != EOF) {
> +	do_parent();
> +
> +	if (empty_read)
> +		tst_resm(TWARN, "%d empty reads", empty_read);
> +
> +	if (error) {
> +		tst_resm(TFAIL, "%d data errors on pipe, read size = %d, %s %s",
> +			 error, size, pipe_type, blk_type);
> +	} else if (!quiet) {
> +		tst_resm(TPASS, "%d pipe reads complete, read size = %d, %s %s",
> +			 count + 1, size, pipe_type, blk_type);
> +	}
> +
> +	/*
> +	 * wait for all children to finish, timeout after uwait_total
> +	 * semtimedop might not be available everywhere
> +	 */
> +	for (j = 0; j < uwait_total; j += uwait_iter) {
> +		if (semctl(sem_id, 1, GETVAL) == 0)
> +			break;
> +		usleep(uwait_iter);
> +	}
> +
> +	if (j >= uwait_total) {
> +		tst_resm(TWARN,
> +			 "Timed out waiting for child processes to exit");
> +	}
> +
> +	cleanup();
> +	tst_exit();
> +}
> +
> +static int parse_options(int argc, char *argv[])
> +{
> +	char *cp;
> +	int c;
> +	int ret = 0;
> +	static double d;
> +
> +	while ((c = getopt(argc, argv, "T:bc:D:he:Ef:i:I:ln:p:qs:uvW:w:"))
> +	       != -1) {
>  		switch (c) {
>  		case 'T':
>  			TCID = optarg;
>  			break;
>  		case 'h':
>  			help();
> -			exit(0);
> -			break;
> -		case 'd':	/* dir name */
> -			strcpy(dir, optarg);
> +			ret = 1;
>  			break;
>  		case 'D':	/* pipe name */
>  			strcpy(pname, optarg);
>  			break;
> -		case 'B':	/* background */
> -			background = 1;
> -			break;
>  		case 'b':	/* blocked */
>  			ndelay = 0;
>  			blk_type = BLOCKING_IO;
>  			break;
> -		case 'C':
> -			fprintf(stderr,
> -				"%s: --C option not supported on this architecture\n",
> -				TCID);
> -			exit(1);
> -			break;
>  		case 'c':	/* number childern */
> -			if (sscanf(optarg, "%d", &num_wrters) != 1) {
> +			if (sscanf(optarg, "%d", &num_writers) != 1) {
>  				fprintf(stderr,
>  					"%s: --c option invalid arg '%s'.\n",
>  					TCID, optarg);
> -				usage();
> -				exit(1);
> -			} else if (num_wrters <= 0) {
> -				fprintf(stderr,
> -					"%s: --c option must be greater than zero.\n",
> -					TCID);
> -				usage();
> -				exit(1);
> +				ret = 1;
> +			} else if (num_writers <= 0) {
> +				fprintf(stderr, "%s: --c option must be "
> +					"greater than zero.\n", TCID);
> +				ret = 1;
>  			}
>  			break;
>  		case 'e':	/* exit on error # */
> @@ -221,20 +226,16 @@ char *av[];
>  				fprintf(stderr,
>  					"%s: --e option invalid arg '%s'.\n",
>  					TCID, optarg);
> -				usage();
> -				exit(1);
> +				ret = 1;
>  			} else if (exit_error < 0) {
> -				fprintf(stderr,
> -					"%s: --e option must be greater than zero.\n",
> -					TCID);
> -				usage();
> -				exit(1);
> +				fprintf(stderr, "%s: --e option must be "
> +					"greater than zero.\n", TCID);
> +				ret = 1;
>  			}
>  			break;
> -
>  		case 'E':
>  			prt_examples();
> -			exit(0);
> +			ret = 1;
>  			break;
>  		case 'f':	/* format of buffer on error */
>  			switch (optarg[0]) {
> @@ -263,32 +264,34 @@ char *av[];
>  				fprintf(stderr,
>  					"%s: --f option invalid arg '%s'.\n",
>  					TCID, optarg);
> -				fprintf(stderr,
> -					"\tIt must be x(hex), o(octal), d(decimal), a(ascii) or n(none) with
> opt sz\n");
> -				exit(1);
> +				fprintf(stderr, "\tIt must be x(hex), o(octal),"
> +					"d(decimal), a(ascii) or n(none) with "
> +					"opt sz\n");
> +				ret = 1;
>  				break;
>  			}
>  			cp = optarg;
>  			cp++;
>  			if (*cp) {
>  				if (sscanf(cp, "%i", &format_size) != 1) {
> -					fprintf(stderr,
> -						"%s: --f option invalid arg '%s'.\n",
> -						TCID, optarg);
> -					fprintf(stderr,
> -						"\tIt must be x(hex), o(octal), d(decimal), a(ascii) or n(none) with
> opt sz\n");
> -					exit(1);
> +					fprintf(stderr, "%s: --f option invalid"
> +						"arg '%s'.\n", TCID, optarg);
> +					fprintf(stderr, "\tIt must be x(hex),"
> +						"o(octal), d(decimal), a(ascii)"
> +						" or n(none) with opt sz\n");
> +					ret = 1;
>  					break;
>  				}
>  			}
>  			break;
>  
>  		case 'I':
> -			if ((iotype = lio_parse_io_arg1(optarg)) == -1) {
> -				fprintf(stderr,
> -					"%s: --I arg is invalid, must be s, p, f, a, l, L or r.\n",
> +			iotype = lio_parse_io_arg1(optarg);
> +			if (iotype == -1) {
> +				fprintf(stderr, "%s: --I arg is invalid, "
> +					"must be s, p, f, a, l, L or r.\n",
>  					TCID);
> -				exit(1);
> +				ret = 1;
>  			}
>  			break;
>  
> @@ -299,42 +302,29 @@ char *av[];
>  		case 'i':
>  		case 'n':	/* number writes per child */
>  			if (sscanf(optarg, "%d", &num_writes) != 1) {
> -				fprintf(stderr,
> -					"%s: --i/n option invalid arg '%s'.\n",
> -					TCID, optarg);
> -				usage();
> -				exit(1);
> +				fprintf(stderr, "%s: --i/n option invalid "
> +					"arg '%s'.\n", TCID, optarg);
> +				ret = 1;
>  			} else if (num_writes < 0) {
> -				fprintf(stderr,
> -					"%s: --i/n option must be greater than equal to zero.\n",
> +				fprintf(stderr, "%s: --i/n option must be "
> +					"greater than equal to zero.\n",
>  					TCID);
> -				usage();
> -				exit(1);
> +				ret = 1;
>  			}
>  
>  			if (num_writes == 0)	/* loop forever */
>  				++loop;
> -
> -			break;
> -		case 'P':	/* panic flag */
> -			fprintf(stderr,
> -				"%s: --P not supported on this architecture\n",
> -				TCID);
> -			exit(1);
>  			break;
>  		case 'p':	/* ping */
>  			if (sscanf(optarg, "%d", &num_rpt) != 1) {
>  				fprintf(stderr,
>  					"%s: --p option invalid arg '%s'.\n",
>  					TCID, optarg);
> -				usage();
> -				exit(1);
> +				ret = 1;
>  			} else if (num_rpt < 0) {
> -				fprintf(stderr,
> -					"%s: --p option must be greater than equal to zero.\n",
> -					TCID);
> -				usage();
> -				exit(1);
> +				fprintf(stderr, "%s: --p option must be greater"
> +					" than equal to zero.\n", TCID);
> +				ret = 1;
>  			}
>  			break;
>  		case 'q':	/* Quiet - NOPASS */
> @@ -345,14 +335,11 @@ char *av[];
>  				fprintf(stderr,
>  					"%s: --s option invalid arg '%s'.\n",
>  					TCID, optarg);
> -				usage();
> -				exit(1);
> +				ret = 1;
>  			} else if (size <= 0) {
> -				fprintf(stderr,
> -					"%s: --s option must be greater than zero.\n",
> -					TCID);
> -				usage();
> -				exit(1);
> +				fprintf(stderr, "%s: --s option must be greater"
> +					" than zero.\n", TCID);
> +				ret = 1;
>  			}
>  			break;
>  		case 'u':
> @@ -361,20 +348,17 @@ char *av[];
>  		case 'v':	/* verbose */
>  			verbose = 1;
>  			break;
> -		case 'W':	/* max wait time between writes */
> +		case 'W':	/* max wait time between reads */
>  			d = strtod(optarg, &cp);
>  			if (*cp != '\0') {
>  				fprintf(stderr,
>  					"%s: --w option invalid arg '%s'.\n",
>  					TCID, optarg);
> -				usage();
> -				exit(1);
> +				ret = 1;
>  			} else if (d < 0) {
> -				fprintf(stderr,
> -					"%s: --w option must be greater than zero.\n",
> -					TCID);
> -				usage();
> -				exit(1);
> +				fprintf(stderr, "%s: --w option must be greater"
> +					" than zero.\n", TCID);
> +				ret = 1;
>  			}
>  			parent_wait = (int)(d * 1000000.0);
>  			break;
> @@ -384,29 +368,59 @@ char *av[];
>  				fprintf(stderr,
>  					"%s: --w option invalid arg '%s'.\n",
>  					TCID, optarg);
> -				usage();
> -				exit(1);
> +				ret = 1;
>  			} else if (d < 0) {
> -				fprintf(stderr,
> -					"%s: --w option must be greater than zero.\n",
> -					TCID);
> -				usage();
> -				exit(1);
> +				fprintf(stderr, "%s: --w option must be greater"
> +					" than zero.\n", TCID);
> +				ret = 1;
>  			}
>  			chld_wait = (int)(d * 1000000.0);
>  			break;
>  		case '?':
> -			usage();
> -			exit(1);
> +			ret = 1;
>  			break;
>  		}
> +
> +		if (ret == 1) {
> +			usage();
> +			return ret;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static void setup(int argc, char *argv[])
> +{
> +	int ret;
> +	char *toutput;
> +	int fds[2];
> +
> +	tst_sig(FORK, DEF_HANDLER, cleanup);
> +
> +	TEST_PAUSE;
> +
> +	tst_tmpdir();
> +
> +	if (signal(SIGCHLD, sig_child) == SIG_ERR) {
> +		tst_brkm(TBROK | TERRNO, cleanup,
> +			 "set signal handler for SIGCHLD failed");
>  	}
>  
> +	toutput = getenv("TOUTPUT");
> +	if (toutput != NULL && strcmp(toutput, "NOPASS") == 0)
> +		quiet = 1;
> +
> +	sprintf(pname, "%s", "tpipe");
> +
> +	ret = parse_options(argc, argv);
> +	if (ret == 1)
> +		tst_brkm(TBROK, cleanup, "options parse error");
> +
>  	if (format_size == -1)
>  		format_size = size;
>  
>  	/*
> -	 *
>  	 * If there is more than one writer, all writes and reads
>  	 * must be the same size.  Only writes of a size <= PIPE_BUF
>  	 * are atomic.  T
> @@ -422,376 +436,306 @@ char *av[];
>  	 *      bytes will be written.)  This is the same as:
>  	 *      pipeio -s 4096 -n 13 -c 5
>  	 */
> -	if (size > PIPE_BUF && num_wrters > 1) {
> +	if (size > PIPE_BUF && num_writers > 1) {
>  		if (!loop) {
> -			/* we must set num_writes s.t. num_writes*num_wrters doesn't overflow
> later */
> -			num_writes =
> -			    MIN(((long long)num_writes * size + PIPE_BUF -
> -				 1) / PIPE_BUF, INT_MAX / num_wrters);
> -			tst_resm(TINFO,
> -				 "adjusting i/o size to %d, and # of writes to %d",
> -				 PIPE_BUF, num_writes);
> +			/*
> +			 * we must set num_writes*num_writers
> +			 * doesn't overflow later
> +			 */
> +			num_writes = MIN(((long long)num_writes * size +
> +					 PIPE_BUF - 1) / PIPE_BUF,
> +					 INT_MAX / num_writers);
> +			tst_resm(TINFO, "adjusting i/o size to %d, and # of "
> +				 "writes to %d", PIPE_BUF, num_writes);
>  		} else {
>  			tst_resm(TINFO, "adjusting i/o size to %d", PIPE_BUF);
>  		}
>  		size = PIPE_BUF;
> -
>  	}
>  
> -	if ((writebuf = (char *)malloc(size)) == NULL ||
> -	    (readbuf = (char *)malloc(size)) == NULL) {
> -		tst_resm(TFAIL | TERRNO, "malloc() failed");
> -		SAFE_FREE(writebuf);
> -		SAFE_FREE(readbuf);
> -		exit(1);
> -	}
> +	writebuf = SAFE_MALLOC(cleanup, size);
> +	readbuf = SAFE_MALLOC(cleanup, size);
>  
>  	memset(writebuf, 'Z', size);
> +	writebuf[size - 1] = 'A';
>  
> -	writebuf[size - 1] = 'A';	/* to detect partial read/write problem */
> -
> -	if ((sem_id = semget(IPC_PRIVATE, 2, IPC_CREAT | S_IRWXU)) == -1) {
> -		tst_brkm(TBROK | TERRNO, NULL, "Couldn't allocate semaphore");
> +	sem_id = semget(IPC_PRIVATE, 2, IPC_CREAT | S_IRWXU);
> +	if (sem_id == -1) {
> +		tst_brkm(TBROK | TERRNO, cleanup,
> +			 "Couldn't allocate semaphore");
>  	}
>  
> -	if (semctl(sem_id, 0, SETVAL, u) == -1)
> -		tst_brkm(TBROK | TERRNO, NULL,
> +	if (semctl(sem_id, 0, SETVAL, u) == -1) {
> +		tst_brkm(TBROK | TERRNO, cleanup,
>  			 "Couldn't initialize semaphore 0 value");
> +	}
>  
> -	/* semaphore to hold off children from exiting until open() completes */
> -	if (semctl(sem_id, 1, SETVAL, u) == -1)
> -		tst_brkm(TBROK | TERRNO, NULL,
> +	if (semctl(sem_id, 1, SETVAL, u) == -1) {
> +		tst_brkm(TBROK | TERRNO, cleanup,
>  			 "Couldn't initialize semaphore 1 value");
> -
> -	if (background) {
> -		if ((n = fork()) == -1) {
> -			tst_resm(TFAIL | TERRNO, "fork() failed");
> -			exit(1);
> -		} else if (n != 0)	/* parent */
> -			exit(0);
>  	}
>  
>  	if (unpipe) {
> -		if (pipe(fds) == -1) {
> -			tst_resm(TFAIL | TERRNO,
> -				 "pipe() failed to create un-named pipe");
> -			exit(1);
> -		}
> +		SAFE_PIPE(cleanup, fds);
>  		read_fd = fds[0];
>  		write_fd = fds[1];
>  		pipe_type = PIPE_UNNAMED;
>  		blk_type = UNNAMED_IO;
>  	} else {
> -		if (strlen(dir) && chdir(dir) == -1) {
> -			tst_resm(TFAIL | TERRNO, "chdir(%s) failed", dir);
> -			exit(1);
> -		}
> -
> -		if (stat(pname, &stbuf) == -1) {
> -
> -			if (mkfifo(pname, 0777) == -1) {
> -				tst_resm(TFAIL | TERRNO,
> -					 "mkfifo(%s,0777) failed", pname);
> -				exit(1);
> -			}
> +		if (mkfifo(pname, 0777) == -1) {
> +			tst_brkm(TBROK | TERRNO, cleanup,
> +				"mkfifo(%s, 0777) failed", pname);
>  		}
>  		pipe_type = PIPE_NAMED;
>  	}
> +}
>  
> -	start_time = time(0);
> +static void cleanup(void)
> +{
> +	TEST_CLEANUP;
>  
> -#if DEBUG
> -	printf("num_wrters = %d\n", num_wrters);
> -#endif
> +	SAFE_FREE(writebuf);
> +	SAFE_FREE(readbuf);
> +
> +	semctl(sem_id, 0, IPC_RMID);
> +
> +	if (!unpipe)
> +		SAFE_UNLINK(NULL, pname);
> +
> +	tst_rmdir();
> +}
> +
> +static void do_child(void)
> +{
> +	int *count_word;        /* holds address where to write writers count */
> +	int *pid_word;          /* holds address where to write writers pid */
> +	int nb, j;
> +	long clock;
> +	char *cp;
> +	long int n;
> +	struct sembuf sem_op;
> +	pid_t self_pid =  getpid();
>  
> -#ifdef linux
> -	signal(SIGCHLD, sig_child);
> -	signal(SIGHUP, sig_handler);
> -	signal(SIGINT, sig_handler);
> -	signal(SIGQUIT, sig_handler);
> -#ifdef SIGRECOVERY
> -	signal(SIGRECOVERY, sig_handler);
> -#endif /* SIGRECOVERY */
> -#else
> -	sigset(SIGCHLD, sig_child);
> -	sigset(SIGHUP, sig_handler);
> -	sigset(SIGINT, sig_handler);
> -	sigset(SIGQUIT, sig_handler);
> -#ifdef SIGRECOVERY
> -	sigset(SIGRECOVERY, sig_handler);
> -#endif /* SIGRECOVERY */
> -#endif /* linux */
> -
> -	for (i = num_wrters; i > 0; --i) {
> -		if ((c = fork()) < 0) {
> -			tst_resm(TFAIL | TERRNO, "fork() failed");
> +	if (!unpipe) {
> +		write_fd = open(pname, O_WRONLY);
> +		if (write_fd == -1) {
> +			fprintf(stderr, "child pipe open(%s, %#o) failed",
> +				pname, O_WRONLY | ndelay);
>  			exit(1);
>  		}
> -		if (c == 0)
> -			break;	/* stop child from forking */
> -	}
> -	if (c == 0) {	/***** if child *****/
> -#if DEBUG
> -		printf("child after fork pid = %d\n", getpid());
> -#endif
> -		if (!unpipe) {
> -			if ((write_fd = open(pname, O_WRONLY)) == -1) {
> -				tst_resm(TFAIL | TERRNO,
> -					 "child pipe open(%s, %#o) failed",
> -					 pname, O_WRONLY | ndelay);
> -				exit(1);
> -			}
> -			if (ndelay
> -			    && fcntl(write_fd, F_SETFL, O_NONBLOCK) == -1) {
> -				tst_brkm(TBROK | TERRNO, NULL,
> -					 "Failed setting the pipe to nonblocking mode");
> -			}
> -		} else {
> -			close(read_fd);
> +		if (ndelay && fcntl(write_fd, F_SETFL, O_NONBLOCK) == -1) {
> +			fprintf(stderr, "Failed setting the pipe to "
> +				"nonblocking mode");
> +			exit(1);
>  		}
> +	} else {
> +		close(read_fd);
> +	}
>  
> -		sem_op = (struct sembuf) {
> -		.sem_num = 0,.sem_op = 1,.sem_flg = 0};
> +	sem_op = (struct sembuf) {
> +		 .sem_num = 0, .sem_op = 1, .sem_flg = 0};
>  
> -		if (semop(sem_id, &sem_op, 1) == -1)
> -			tst_brkm(TBROK | TERRNO, NULL,
> -				 "Couldn't raise the semaphore 0");
> +	if (semop(sem_id, &sem_op, 1) == -1) {
> +		fprintf(stderr, "child: %d couldn't raise the semaphore 0",
> +			self_pid);
> +		exit(1);
> +	}
>  
> -		pid_word = (int *)&writebuf[0];
> -		count_word = (int *)&writebuf[NBPW];
> +	pid_word = (int *)&writebuf[0];
> +	count_word = (int *)&writebuf[NBPW];
>  
> -		for (j = 0; j < num_writes || loop; ++j) {
> +	for (j = 0; j < num_writes || loop; ++j) {
> +		/*
> +		 * writes are only in one unit when the size of the write
> +		 * is <= PIPE_BUF.
> +		 * Therefore, if size is greater than PIPE_BUF, we will break
> +		 * the writes into PIPE_BUF chunks.
> +		 * All writes and read need to be same size.
> +		 */
>  
> -			/* writes are only in one unit when the size of the write
> -			 * is <= PIPE_BUF.
> -			 * Therefore, if size is greater than PIPE_BUF, we will break
> -			 * the writes into PIPE_BUF chunks.
> -			 * All writes and read need to be same size.
> -			 */
> +		/*
> +		 * write pid and count in first two
> +		 * words of buffer
> +		 */
> +		*count_word = j;
> +		*pid_word = self_pid;
>  
> +		nb = lio_write_buffer(write_fd, iotype, writebuf, size,
> +				      SIGUSR1, &cp, 0);
> +		if (nb < 0) {
>  			/*
> -			 * write pid and count in first two
> -			 * words of buffer
> +			 * If lio_write_buffer returns a negative number,
> +			 * the return will be -errno.
>  			 */
> -
> -			*count_word = j;
> -			*pid_word = getpid();
> -
> -			if ((nb =
> -			     lio_write_buffer(write_fd, iotype, writebuf, size,
> -					      SIGUSR1, &cp, 0)) < 0) {
> -				/*
> -				 * If lio_write_buffer returns a negative number,
> -				 * the return will be -errno.
> -				 */
> -				tst_resm(TFAIL,
> -					 "pass %d: lio_write_buffer(%s) failed; it returned %d: %s",
> -					 j, cp, nb, strerror(-nb));
> +			fprintf(stderr, "pass %d: lio_write_buffer(%s) failed;"
> +				" it returned %d: %s",
> +				j, cp, nb, strerror(-nb));
>  				exit(1);
> -			} else if (nb != size) {
> -				tst_resm(TFAIL,
> -					 "pass %d: lio_write_buffer(%s) failed, write count %d, but expected to
> write %d",
> -					 j, cp, nb, size);
> -			}
> -			if (verbose)
> -				tst_resm(TINFO,
> -					 "pass %d: pid %d: wrote %d bytes, expected %d bytes",
> -					 j, getpid(), nb, size);
> -
> -			if (chld_wait) {
> -				clock = time(0);
> -				srand48(clock);
> -				n = lrand48() % chld_wait;
> -				usleep(n);
> -			}
> -			fflush(stderr);
> +		} else if (nb != size) {
> +			fprintf(stderr, "pass %d: lio_write_buffer(%s) failed,"
> +				" write count %d, but expected to write %d",
> +				j, cp, nb, size);
> +		}
> +		if (verbose) {
> +			fprintf(stderr, "pass %d: pid %d: wrote %d bytes,"
> +				"expected %d bytes",
> +				j, self_pid, nb, size);
>  		}
>  
> -		/* child waits until parent completes open() */
> -		sem_op = (struct sembuf) {
> -		.sem_num = 1,.sem_op = -1,.sem_flg = 0};
> -		if (semop(sem_id, &sem_op, 1) == -1)
> -			tst_brkm(TBROK | TERRNO, NULL,
> -				 "Couldn't lower the semaphore 1");
> +		if (chld_wait) {
> +			clock = time(0);
> +			srand48(clock);
> +			n = lrand48() % chld_wait;
> +			usleep(n);
> +		}
> +		fflush(stderr);
>  	}
> -	if (c > 0) {	/***** if parent *****/
>  
> -		if (!unpipe) {
> -			if ((read_fd = open(pname, O_RDONLY)) == -1) {
> -				tst_resm(TFAIL | TERRNO,
> -					 "parent pipe open(%s, %#o) failed",
> -					 pname, O_RDONLY);
> -				exit(1);
> -			}
> -			if (ndelay && fcntl(read_fd, F_SETFL, O_NONBLOCK) == -1) {
> -				tst_brkm(TBROK | TERRNO, NULL,
> -					 "Failed setting the pipe to nonblocking mode");
> -			}
> -		} else {
> -			close(write_fd);
> +	/* child waits until parent completes open() */
> +	sem_op = (struct sembuf) {
> +		  .sem_num = 1, .sem_op = -1, .sem_flg = 0};
> +	if (semop(sem_id, &sem_op, 1) == -1)
> +		fprintf(stderr, "Couldn't lower the semaphore 1");
> +
> +	exit(0);
> +}
> +
> +static int check_rw_buf(void)
> +{
> +	int i;
> +
> +	for (i = 2 * NBPW; i < size; ++i) {
> +		if (writebuf[i] != readbuf[i]) {
> +			++error;
> +			tst_resm(TFAIL,
> +				 "FAIL data error on byte %d; rd# %d, sz= %d, "
> +				 "%s %s empty_reads= %d, err= %d",
> +				 i, count, size, pipe_type, blk_type,
> +				 empty_read, error);
> +			prt_buf(&readbuf, readbuf, format_size, format);
> +			fflush(stdout);
> +			return 1;
>  		}
> +	}
>  
> -		/* raise semaphore so children can exit */
> -		sem_op = (struct sembuf) {
> -		.sem_num = 1,.sem_op = num_wrters,.sem_flg = 0};
> -		if (semop(sem_id, &sem_op, 1) == -1)
> -			tst_brkm(TBROK | TERRNO, NULL,
> -				 "Couldn't raise the semaphore 1");
> +	return 0;
> +}
>  
> -		sem_op = (struct sembuf) {
> -		.sem_num = 0,.sem_op = -num_wrters,.sem_flg = 0};
> +static void do_parent(void)
> +{
> +	int i, nb;
> +	long clock;
> +	time_t start_time, current_time, diff_time;
> +	char *cp;
> +	long int n;
> +	struct sembuf sem_op;
>  
> -		while (Nchildcomplete < num_wrters
> -		       && semop(sem_id, &sem_op, 1) == -1) {
> -			if (errno == EINTR) {
> -				continue;
> -			}
> -			tst_brkm(TBROK | TERRNO, NULL,
> -				 "Couldn't wait on semaphore 0");
> +	start_time = time(0);
> +	if (!unpipe) {
> +		read_fd = SAFE_OPEN(cleanup, pname, O_RDONLY);
> +		if (ndelay && fcntl(read_fd, F_SETFL, O_NONBLOCK) == -1) {
> +			tst_brkm(TBROK | TERRNO, cleanup,
> +				 "Failed setting the pipe to nonblocking mode");
>  		}
> +	} else {
> +		SAFE_CLOSE(cleanup, write_fd);
> +	}
>  
> -		for (i = num_wrters * num_writes; i > 0 || loop; --i) {
> -			if (error >= MAX_ERRS || empty_read >= MAX_EMPTY)
> -				break;
> -			if (parent_wait) {
> -				clock = time(0);
> -				srand48(clock);
> -				n = lrand48() % parent_wait;
> -				usleep(n);
> -			}
> -			++count;
> -			if ((nb =
> -			     lio_read_buffer(read_fd, iotype, readbuf, size,
> -					     SIGUSR1, &cp, 0)) < 0) {
> -				/*
> -				 * If lio_read_buffer returns a negative number,
> -				 * the return will be -errno.
> -				 */
> -				tst_resm(TFAIL,
> -					 "pass %d: lio_read_buffer(%s) failed; it returned %d: %s",
> -					 i, cp, nb, strerror(-nb));
> +	/* raise semaphore so children can exit */
> +	sem_op = (struct sembuf) {
> +		  .sem_num = 1, .sem_op = num_writers, .sem_flg = 0};
> +	if (semop(sem_id, &sem_op, 1) == -1) {
> +		tst_brkm(TBROK | TERRNO, cleanup,
> +			 "Couldn't raise the semaphore 1");
> +	}
> +
> +	sem_op = (struct sembuf) {
> +		  .sem_num = 0, .sem_op = -num_writers, .sem_flg = 0};
> +
> +	while (nchildcompleted < num_writers
> +	       && semop(sem_id, &sem_op, 1) == -1) {
> +		if (errno == EINTR)
> +			continue;
> +		tst_brkm(TBROK | TERRNO, cleanup,
> +			 "Couldn't wait on semaphore 0");
> +	}
> +
> +	/* parent start to read pipe */
> +	for (i = num_writers * num_writes; i > 0 || loop; --i) {
> +		if (error >= MAX_ERRS || empty_read >= MAX_EMPTY)
> +			break;
> +		if (parent_wait) {
> +			clock = time(0);
> +			srand48(clock);
> +			n = lrand48() % parent_wait;
> +			usleep(n);
> +		}
> +		++count;
> +		nb = lio_read_buffer(read_fd, iotype, readbuf, size,
> +				     SIGUSR1, &cp, 0);
> +		if (nb < 0) {
> +			/*
> +			 * If lio_read_buffer returns a negative number,
> +			 * the return will be -errno.
> +			 */
> +			tst_resm(TFAIL, "pass %d: lio_read_buffer(%s) failed; "
> +				 "returned %d: %s", i, cp, nb, strerror(-nb));
> +			++i;
> +			count--;
> +			error++;
> +			continue;
> +		} else {
> +			if (nb == 0) {
> +				if (nchildcompleted >= num_writers && !loop) {
> +					tst_resm(TWARN, "The children have "
> +						 "died prematurely");
> +					break;	/* All children have died */
> +				}
> +				empty_read++;
>  				++i;
>  				count--;
> -				error++;
>  				continue;
> -
> -			} else {
> -				if (nb == 0) {
> -					if (Nchildcomplete >= num_wrters) {
> -						if (!loop)
> -							tst_resm(TWARN,
> -								 "The children have died prematurely");
> -						break;	/* All children have died */
> -					}
> -					empty_read++;
> -/*
> -					fprintf(stdout,
> -						"%s: Nothing on the pipe (%d),read count %d (read not counted)\n",
> -						TCID,empty_read,count);
> -					fflush(stdout);
> - */
> -					++i;
> -					count--;
> -					continue;
> -				} else if (nb < size && size <= PIPE_BUF) {
> -					tst_resm(TFAIL,
> -						 "pass %d: partial read from the pipe: read %d bytes, expected %d,
> read count %d",
> -						 i, nb, size, count);
> -					++error;
> -				} else if (nb == size) {
> -					for (j = 2 * NBPW; j < size; ++j) {
> -						if (writebuf[j] != readbuf[j]) {
> -							++error;
> -							tst_resm(TFAIL,
> -								 "1 FAIL data error on byte %d; rd# %d, sz= %d, %s %s empty_reads=
> %d, err= %d",
> -								 j, count, size,
> -								 pipe_type,
> -								 blk_type,
> -								 empty_read,
> -								 error);
> -							prt_buf(&readbuf,
> -								readbuf,
> -								format_size,
> -								format);
> -							fflush(stdout);
> -							if (exit_error
> -							    && exit_error ==
> -							    error)
> -								goto output;
> -
> -							else
> -								break;
> -						}
> -					}
> -				}
> -				if (verbose || (num_rpt && !(count % num_rpt))) {
> -					current_time = time(0);
> -					diff_time = current_time - start_time;	/* elapsed time */
> -					tst_resm(TFAIL,
> -						 "(%d) rd# %d, sz= %d, %s %s empty_reads= %d, err= %d\n",
> -						 (int)diff_time, count, size,
> -						 pipe_type, blk_type,
> -						 empty_read, error);
> -					fflush(stdout);
> -				}
> +			} else if (nb < size && size <= PIPE_BUF) {
> +				tst_resm(TFAIL, "pass %d: partial read from the"
> +					" pipe: read %d bytes, expected %d, "
> +					"read count %d", i, nb, size, count);
> +				++error;
> +			} else if (nb == size) {
> +				check_rw_buf();
> +				if (exit_error && exit_error == error)
> +					return;
>  			}
> -		}
> -		if (empty_read)
> -			tst_resm(TWARN, "%d empty reads", empty_read);
> -output:
> -		if (error)
> -			tst_resm(TFAIL,
> -				 "1 FAIL %d data errors on pipe, read size = %d, %s %s",
> -				 error, size, pipe_type, blk_type);
> -		else if (!quiet)
> -			tst_resm(TPASS,
> -				 "1 PASS %d pipe reads complete, read size = %d, %s %s",
> -				 count + 1, size, pipe_type, blk_type);
> -
> -		/* wait for all children to finish, timeout after uwait_total
> -		   semtimedop might not be available everywhere */
> -		for (i = 0; i < uwait_total; i += uwait_iter) {
> -			if (semctl(sem_id, 1, GETVAL) == 0) {
> -				break;
> -			}
> -			usleep(uwait_iter);
> -		}
>  
> -		if (i > uwait_total) {
> -			tst_resm(TWARN,
> -				 "Timed out waiting for child processes to exit");
> +			if (verbose || (num_rpt && !(count % num_rpt))) {
> +				current_time = time(0);
> +				diff_time = current_time - start_time;
> +				tst_resm(TFAIL,
> +					 "(%d) rd# %d, sz= %d, %s %s "
> +					 "empty_reads= %d, err= %d\n",
> +					 (int)diff_time, count, size,
> +					 pipe_type, blk_type,
> +					 empty_read, error);
> +				fflush(stdout);
> +			}
>  		}
> -
> -		semctl(sem_id, 0, IPC_RMID);
> -
> -		if (!unpipe)
> -			unlink(pname);
>  	}
> -
> -	SAFE_FREE(writebuf);
> -	SAFE_FREE(readbuf);
> -	return (error);
>  }
>  
> -void usage()
> +static void usage(void)
>  {
> -	fprintf(stderr,
> -		"Usage: %s [-BbCEv][-c #writers][-D pname][-d dir][-h][-e exit_num][-f
> fmt][-l][-i #writes][-n #writes][-p num_rpt]\n\t[-s size][-W max_wait][-w
> max_wait][-u]\n",
> -		TCID);
> +	fprintf(stderr, "Usage: %s [-bEv][-c #writers][-D pname][-h]"
> +		"[-e exit_num][-f fmt][-l][-i #writes][-n #writes][-p num_rpt]"
> +		"\n\t[-s size][-W max_wait][-w max_wait][-u]\n", TCID);
>  	fflush(stderr);
> -
>  }
>  
> -void help()
> +static void help(void)
>  {
>  	usage();
>  
> -	printf("  -B           - execute actions in background\n\
> -  -b           - blocking reads and writes. default non-block\n\
> +	printf(" -b    - blocking reads and writes. default non-block\n\
>    -c #writers  - number of writers (childern)\n\
>    -D pname     - name of fifo (def tpipe<pid>)\n\
> -  -d dir       - cd to dir before creating named pipe\n\
> -               - (silently ignored if used with -u)\n\
>    -h           - print this help message\n\
>    -e exit_num  - exit on error exit_num, 0 is ignore errors, 1 is
>    default.\n\
>    -E           - print cmd line examples and exit\n\
> @@ -815,12 +759,10 @@ void help()
>    -v           - verbose mode, all writes/reads resutlts printed\n");
>  
>  	fflush(stdout);
> -
>  }
>  
> -void prt_buf(long addr, char *buf, int length, int format)
> +static void prt_buf(char **addr, char *buf, int length, int format)
>  {
> -
>  	int i;
>  	int num_words = length / NBPW;	/* given length in bytes, get length in
>  	words */
>  	int width;		/* number of columns */
> @@ -856,13 +798,13 @@ void prt_buf(long addr, char *buf, int length, int
> format)
>  				 * get the last 2 words printed
>  				 */
>  				memcpy(c, a - (width * NBPW), width * NBPW);
> -				for (p = c; (p - c) < width * NBPW; ++p) {
> +				for (p = c; (p - c) < (int)(width*NBPW); ++p) {
>  					if (*p < '!' || *p > '~')
>  						*p = '.';
>  				}
>  				printf("\t%16.16s", c);
>  			}
> -			printf("\n%7lo: ", addr);
> +			printf("\n%p: ", addr);
>  			/***printf("\n%7o (%d): ",addr,i);***/
>  		}
>  
> @@ -875,7 +817,7 @@ void prt_buf(long addr, char *buf, int length, int
> format)
>  			break;
>  		case ASCII:
>  			memcpy(b, a, NBPW);
> -			for (p = b; (p - b) < NBPW; ++p) {
> +			for (p = b; (p - b) < (int)NBPW; ++p) {
>  				if (*p < '!' || *p > '~')
>  					*p = '.';
>  			}
> @@ -895,7 +837,7 @@ void prt_buf(long addr, char *buf, int length, int
> format)
>  		if (extra_words)
>  			width = extra_words;	/* odd number of words */
>  		memcpy(c, a - (width * NBPW), width * NBPW);
> -		for (p = c; (p - c) < width * NBPW; ++p) {
> +		for (p = c; (p - c) < (int)(width * NBPW); ++p) {
>  			if (*p < '!' || *p > '~')
>  				*p = '.';
>  		}
> @@ -908,46 +850,21 @@ void prt_buf(long addr, char *buf, int length, int
> format)
>  	fflush(stdout);
>  }
>  
> -void prt_examples()
> +static void prt_examples(void)
>  {
>  	printf("%s -c 5 -i 0 -s 4090 -b\n", TCID);
>  	printf("%s -c 5 -i 0 -s 4090 -b -u \n", TCID);
>  	printf("%s -c 5 -i 0 -s 4090 -b -W 3 -w 3 \n", TCID);
> -
>  }
>  
> -void sig_child(int sig)
> +static void sig_child(int sig)
>  {
>  	int status;
>  
> -	Nchildcomplete++;
> +	nchildcompleted++;
>  #if DEBUG
> -	printf("parent: received SIGCHLD\n");
> +	#define STR	"parent: received SIGCHLD\n"
> +	write(STDOUT_FILENO, str, strlen(STR));
>  #endif
>  	waitpid(-1, &status, WNOHANG);
> -#if linux
> -	signal(SIGCHLD, sig_child);
> -#else
> -	sigset(SIGCHLD, sig_child);
> -#endif
> -}
> -
> -void sig_handler(int sig)
> -{
> -#ifdef SIGRECOVERY
> -	if (sig == SIGRECOVERY) {
> -		printf("%s: received SIGRECOVERY, count = %d\n", TCID, count);
> -		fflush(stdout);
> -#ifdef linux
> -		signal(sig, sig_handler);
> -#else
> -		sigset(sig, sig_handler);
> -#endif
> -		return;
> -	}
> -#endif
> -	printf("%s: received unexpected signal: %d\n", TCID, sig);
> -	fflush(stdout);
> -	exit(3);
> -
>  }
> --
> 1.8.2.1
> 
> 
> ------------------------------------------------------------------------------
> Start Your Social Network Today - Download eXo Platform
> Build your Enterprise Intranet with eXo Platform Software
> Java Based Open Source Intranet - Social, Extensible, Cloud Ready
> Get Started Now And Turn Your Intranet Into A Collaboration Platform
> http://p.sf.net/sfu/ExoPlatform
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

------------------------------------------------------------------------------
Start Your Social Network Today - Download eXo Platform
Build your Enterprise Intranet with eXo Platform Software
Java Based Open Source Intranet - Social, Extensible, Cloud Ready
Get Started Now And Turn Your Intranet Into A Collaboration Platform
http://p.sf.net/sfu/ExoPlatform
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

