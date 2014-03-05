Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WLCbP-0000kL-Er
	for ltp-list@lists.sourceforge.net; Wed, 05 Mar 2014 14:15:19 +0000
Date: Wed, 5 Mar 2014 15:15:02 +0100
From: chrubis@suse.cz
Message-ID: <20140305141502.GA24575@rei>
References: <1390882509-16312-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1390882509-16312-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] pipeio/pipeio.c: cleanup
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
> Delete some useless comments and fix some.
> 
> Use SAFE_* macros.
> 
> Make a re-arrangement on original code: let parent process
> work in do_parent(), child process work in do_child(), and
> arguments parse and initialization work in setup().
> 
> Some cleanup.
> 
> Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
> ---
>  testcases/kernel/ipc/pipeio/pipeio.c | 945 ++++++++++++++++-------------------
>  1 file changed, 429 insertions(+), 516 deletions(-)
> 
> diff --git a/testcases/kernel/ipc/pipeio/pipeio.c b/testcases/kernel/ipc/pipeio/pipeio.c
> index 7dfbe44..3e1b4a6 100644
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
> @@ -90,130 +80,149 @@ void myexit(int x)
>  #define MAX_ERRS 16
>  #define MAX_EMPTY 256
>  
> -void sig_handler(), help(), usage(), prt_buf(), prt_examples();
> -void sig_child();
> -
> -int count = 0;
> -int Nchildcomplete = 0;
> -
> -/*
> - * Ensure PATH_MAX is define
> - */
>  #ifndef PATH_MAX
> -#ifdef MAXPATHLEN
> -#define PATH_MAX MAXPATHLEN
> -#else
>  #define PATH_MAX 1024
> -#endif /* ! MAXPATHLEN */
> -#endif /* PATH_MAX */
> +#endif
>  
> -int main(ac, av)
> -int ac;
> -char *av[];
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
> +
> +static int check_rw_buf(void);
> +
> +static int Nchildcomplete;
> +
> +static int error;
> +static int count;
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
> +static char pname[PATH_MAX];	/* contains the name of the unamed pipe */
> +static char *blk_type = NON_BLOCKING_IO; /* blocking i/o or not */
> +static char *pipe_type;		/* type of pipe under test */
> +static int fds[2];		/* un-named pipe fds */
> +static int read_fd;
> +static int write_fd;
> +static int empty_read;
> +static int format = HEX;
> +static int format_size = -1;
> +static int iotype;		/* sync io */
> +static int sem_id;
> +static struct sembuf sem_op;
> +
> +static union semun {
> +	int val;
> +	struct semid_ds *buf;
> +	unsigned short int *array;
> +} u;
> +
> +static unsigned int uwait_iter = 1000;
> +static unsigned int uwait_total = 5000000;
> +
> +int main(int ac, char *av[])
>  {
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
> -	time_t start_time, current_time, diff_time;	/* start time, current time, diff of times */
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
> +	int i;
> +	pid_t child;
> +
> +	setup(ac, av);
> +
> +	for (i = num_writers; i > 0; --i) {
> +		child = FORK_OR_VFORK();

Do not use FORK_OR_VFORK() in testcases that are not ported to uClinux.

> +		if (child < 0)
> +			tst_brkm(TBROK | TERRNO, cleanup, "fork() failed");
> +
> +		if (child == 0) {
> +			do_child();
> +			exit(0);
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
> +		tst_resm(TFAIL, "FAIL %d data errors on pipe, "
> +			 "read size = %d, %s %s",
> +			 error, size, pipe_type, blk_type);
> +	} else if (!quiet) {
> +		tst_resm(TPASS,
> +			 "PASS %d pipe reads complete, read size = %d, %s %s",
> +			 count + 1, size, pipe_type, blk_type);
> +	}
> +
> +	/*
> +	 * wait for all children to finish, timeout after uwait_total
> +	 * semtimedop might not be available everywhere
> +	 */
> +	for (i = 0; i < uwait_total; i += uwait_iter) {
> +		if (semctl(sem_id, 1, GETVAL) == 0)
> +			break;
> +		usleep(uwait_iter);
> +	}
> +
> +	if (i >= uwait_total) {
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
> @@ -221,20 +230,16 @@ char *av[];
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
> @@ -263,32 +268,34 @@ char *av[];
>  				fprintf(stderr,
>  					"%s: --f option invalid arg '%s'.\n",
>  					TCID, optarg);
> -				fprintf(stderr,
> -					"\tIt must be x(hex), o(octal), d(decimal), a(ascii) or n(none) with opt sz\n");
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
> -						"\tIt must be x(hex), o(octal), d(decimal), a(ascii) or n(none) with opt sz\n");
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
> @@ -299,42 +306,29 @@ char *av[];
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
> @@ -345,14 +339,11 @@ char *av[];
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
> @@ -361,20 +352,17 @@ char *av[];
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
> @@ -384,29 +372,60 @@ char *av[];
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
>  	}
>  
> +	return ret;
> +}

I see some changes in the option parsing code.

* The C option is removed
  (this one makes sense because it's not supported)

* The B background option is removed

* The d dir option no longer copies the dir name, why?


This should be exaplained in the commit message, or even better for a
patch of this size split it into part that only moves codeblocks around
and patch that changes behavior.


Also have you tried to run the test with options we have in runtest
files before and after the changes? Was the test output and runtime
the same?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Subversion Kills Productivity. Get off Subversion & Make the Move to Perforce.
With Perforce, you get hassle-free workflows. Merge that actually works. 
Faster operations. Version large binaries.  Built-in WAN optimization and the
freedom to use Git, Perforce or both. Make the move to Perforce.
http://pubads.g.doubleclick.net/gampad/clk?id=122218951&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
