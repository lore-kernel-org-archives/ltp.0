Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1M9K2U-0000hY-OX
	for ltp-list@lists.sourceforge.net; Wed, 27 May 2009 14:23:30 +0000
Received: from e9.ny.us.ibm.com ([32.97.182.139])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1M9K2R-00040a-JV
	for ltp-list@lists.sourceforge.net; Wed, 27 May 2009 14:23:30 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e9.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n4REBOHK004157
	for <ltp-list@lists.sourceforge.net>; Wed, 27 May 2009 10:11:24 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n4RENQks098912
	for <ltp-list@lists.sourceforge.net>; Wed, 27 May 2009 10:23:26 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n4RELKbX002472
	for <ltp-list@lists.sourceforge.net>; Wed, 27 May 2009 10:21:20 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4A1CB801.3080408@cn.fujitsu.com>
References: <4A166FB6.6010208@cn.fujitsu.com>
	<1243268093.6752.24.camel@subratamodak.linux.ibm.com>
	<4A1BB9F6.6050107@cn.fujitsu.com>
	<1243340572.6293.23.camel@subratamodak.linux.ibm.com>
	<4A1CB801.3080408@cn.fujitsu.com>
Date: Wed, 27 May 2009 19:53:20 +0530
Message-Id: <1243434200.10447.16.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [QUESTION] about test execve04 which testing for EMFILE
Reply-To: subrata@linux.vnet.ibm.com
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
To: Wei Yongjun <yjwei@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

On Wed, 2009-05-27 at 11:48 +0800, Wei Yongjun wrote: 
> Subrata Modak wrote:
> > On Tue, 2009-05-26 at 17:44 +0800, Wei Yongjun wrote: 
> >   
> >> Subrata Modak wrote:
> >>     
> >>> On Fri, 2009-05-22 at 17:26 +0800, Wei Yongjun wrote: 
> >>>   
> >>>       
> >>>> recently kernel commit e7b9b550f53e81ea38e71d322d6f95730df058a2
> >>>> has removed the file get code. The execve syscall will never
> >>>> return EMFILE.
> >>>>
> >>>> Call to execve() will be suceess even if the the process has the
> >>>> maximum number of files open, because execve() never open any file.
> >>>>
> >>>> Can anyone tell me what does this test case test for? It be wrote
> >>>> base on which document? Just the man page?
> >>>>     
> >>>>         
> >>> * DESCRIPTION
> >>> *      Testcase to check execve(2) sets errno to EMFILE correctly
> >>> *
> >>> * ALGORITHM
> >>> *      Get the configured file descriptor table size. open(2) files to
> >>> fill
> >>> *      up the file descriptor table. Once file descriptor table is full,
> >>> *      an attempt to execve(2) any other executable fails with EMFILE.
> >>>
> >>> is what the source description says. Can you please execute the test
> >>> against that kernel commit and share the results with/without commits ?
> >>>   
> >>>       
> >> Test without that commit:
> >> # ./execve04 -F ./test3
> >> execve04 1 PASS : Expected failure - 24 : Too many open files
> >>
> >> Test with that commit:
> >> # ./execve04 -F ./test3
> >> <program name unknown>: error while loading shared libraries: libc.so.6:
> >> cannot open shared object file: Error 24
> >> execve04 1 FAIL :
> >> execve(/home/weiyj/ltp/testcases/kernel/syscalls/execve/./test3) failed:
> >> expected EMFILE(24), got 127 (Key has expired)
> >>
> >> Test with that commit but I compiled test3 with --static:
> >> # gcc test3.c -o test3 --static
> >> # ./execve04 -F ./test3
> >> Hello World
> >> execve04 1 FAIL :
> >> execve(/home/weiyj/ltp/testcases/kernel/syscalls/execve/./test3) failed:
> >> expected EMFILE(24), got 0 (Success)
> >>
> >> The latest kernel do execve(2) without get file descriptor, it only
> >> need one file struct. It seem that this test is obsoleted.
> >>     
> >
> > Lets remove then. Send a patch to do so.
> >   
> 
> Here is the patch.
> 
> -------------------------------------------------------
> 
> [PATCH] execve: remove obsoleted test case execve04
> 
> Since latest kernel do execve(2) without get file descriptor, it
> only use one file struct. This cause the case execve04 which test
> for set EMFILE errno obsoleted.
> 
> This patch removed test case execve04, and changed the index of
> the test cases after execve04.
> 
> Signed-off-by: Wei Yongjun <yjwei@cn.fujitsu.com>

Thanks.

Regards--
Subrata

> ---
>  doc/testcases/kernel.txt                    |    6 +-
>  runtest/ltplite                             |    5 +-
>  runtest/stress.part3                        |    5 +-
>  runtest/syscalls                            |    3 +-
>  testcases/kernel/syscalls/execve/execve04.c |  331 ++++++++++++++---------
>  testcases/kernel/syscalls/execve/execve05.c |  380 ++++++++++----------------
>  testcases/kernel/syscalls/execve/execve06.c |  236 -----------------
>  7 files changed, 357 insertions(+), 609 deletions(-)
>  delete mode 100644 testcases/kernel/syscalls/execve/execve06.c
> 
> diff --git a/doc/testcases/kernel.txt b/doc/testcases/kernel.txt
> index aa277e4..90afc9b 100644
> --- a/doc/testcases/kernel.txt
> +++ b/doc/testcases/kernel.txt
> @@ -803,14 +803,10 @@ syscalls
>    
>    execve04  
>    
> - 	Testcase to check execve(2) sets errno to EMFILE correctly
> - 
> -  execve05  
> -  
>   	Testcase to check execve sets the following errnos correctly:
>   	1.	ETXTBSY
> 
> -  execve06  
> +  execve05  
>    
>    	This testcase tests the basic functionality of the execve(2) system
>   	call.
> diff --git a/runtest/ltplite b/runtest/ltplite
> index 571763f..4717f1f 100644
> --- a/runtest/ltplite
> +++ b/runtest/ltplite
> @@ -167,9 +167,8 @@ execv01 execv01
>  execve01 execve01
>  execve02 execve02 -F $LTPROOT/testcases/bin/test3
>  execve03 execve03
> -execve04 cp -f $LTPROOT/testcases/bin/test3 $TMP; execve04 -F test3
> -execve05 execve05 -F $LTPROOT/testcases/bin/test3
> -execve06 execve06 20 $LTPROOT/testcases/bin/execve06 $LTPROOT/testcases/bin/execve06 4
> +execve04 execve04 -F $LTPROOT/testcases/bin/test3
> +execve05 execve05 20 $LTPROOT/testcases/bin/execve05 $LTPROOT/testcases/bin/execve05 4
>  execvp01 execvp01
> 
>  exit01 exit01
> diff --git a/runtest/stress.part3 b/runtest/stress.part3
> index b071625..88f5c04 100644
> --- a/runtest/stress.part3
> +++ b/runtest/stress.part3
> @@ -108,9 +108,8 @@ execv01 execv01
>  execve01 execve01
>  execve02 execve02 -F $LTPROOT/testcases/bin/test3
>  execve03 execve03
> -execve04 cp -f $LTPROOT/testcases/bin/test3 $TMP; execve04 -F test3
> -execve05 execve05 -F $LTPROOT/testcases/bin/test3
> -execve06 execve06 20 $LTPROOT/testcases/bin/execve06 $LTPROOT/testcases/bin/execve06 4
> +execve04 execve04 -F $LTPROOT/testcases/bin/test3
> +execve05 execve05 20 $LTPROOT/testcases/bin/execve05 $LTPROOT/testcases/bin/execve05 4
>  execvp01 execvp01
> 
>  exit01 exit01
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 9b7b2ca..69e5e0b 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -129,8 +129,7 @@ execve01 execve01
>  execve02 execve02 -F $LTPROOT/testcases/bin/test3
>  execve03 execve03
>  execve04 execve04 -F $LTPROOT/testcases/bin/test3
> -execve05 execve05 -F $LTPROOT/testcases/bin/test3
> -execve06 execve06 20 $LTPROOT/testcases/bin/execve06 $LTPROOT/testcases/bin/execve06 4
> +execve05 execve05 20 $LTPROOT/testcases/bin/execve05 $LTPROOT/testcases/bin/execve05 4
>  execvp01 execvp01
> 
>  exit01 exit01
> diff --git a/testcases/kernel/syscalls/execve/execve04.c b/testcases/kernel/syscalls/execve/execve04.c
> index 78c4bcb..b85fc32 100644
> --- a/testcases/kernel/syscalls/execve/execve04.c
> +++ b/testcases/kernel/syscalls/execve/execve04.c
> @@ -1,59 +1,64 @@
>  /*
>   *
> - *  Copyright (c) International Business Machines  Corp., 2001
> + *   Copyright (c) International Business Machines  Corp., 2001
>   *
> - *  This program is free software;  you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> + *   This program is free software;  you can redistribute it and/or modify
> + *   it under the terms of the GNU General Public License as published by
> + *   the Free Software Foundation; either version 2 of the License, or
> + *   (at your option) any later version.
>   *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY;  without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> - *  the GNU General Public License for more details.
> + *   This program is distributed in the hope that it will be useful,
> + *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
> + *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> + *   the GNU General Public License for more details.
>   *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program;  if not, write to the Free Software
> - *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
> + *   You should have received a copy of the GNU General Public License
> + *   along with this program;  if not, write to the Free Software
> + *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
>   */
> 
>  /*
>   * NAME
> - *	execve04
> + *	execve04.c
>   *
>   * DESCRIPTION
> - *	Testcase to check execve(2) sets errno to EMFILE correctly
> + *	Testcase to check execve sets the following errnos correctly:
> + *	1.	ETXTBSY
>   *
>   * ALGORITHM
> - *	Get the configured file descriptor table size. open(2) files to fill
> - *	up the file descriptor table. Once file descriptor table is full,
> - *	an attempt to execve(2) any other executable fails with EMFILE.
> + *	1.	Attempt to execve(2) a file which is being opened by another
> + *		process for writing fails with ETXTBSY.
>   *
>   * USAGE:  <for command-line>
>   *  execve04 -F <test file> [-c n] [-e] [-i n] [-I x] [-P x] [-t]
> - *     where,	-c n : Run n copies concurrently.
> - *		-e   : Turn on errno logging.
> - *		-i n : Execute test n times.
> - *		-I x : Execute test for x seconds.
> - *		-P x : Pause for x seconds between iterations.
> - *		-t   : Turn on syscall timing.
> + *     where,  -c n : Run n copies concurrently.
> + *             -e   : Turn on errno logging.
> + *             -i n : Execute test n times.
> + *             -I x : Execute test for x seconds.
> + *             -P x : Pause for x seconds between iterations.
> + *             -t   : Turn on syscall timing.
>   *
>   * HISTORY
>   *	07/2001 Ported by Wayne Boyer
> + *	04/2008 Roy Lee <roylee@andestech.com>
> + *              - Fix a synchronization issue.
> + *                On a loaded system, the 'execving' child can get access
> + *                to the file before the 'opening' child does, hence results
> + *                in an unexpected opening fail.
>   *
>   * RESTRICTIONS
> - *	Must run test with the -F <test file> option.
> + *	must be run with -F <test file> option
>   */
> 
>  #include <stdio.h>
>  #include <errno.h>
> -#include <unistd.h>
> +#include <fcntl.h>
>  #include <sys/types.h>
> -#include <sys/stat.h>
>  #include <sys/wait.h>
> -#include <fcntl.h>
> -#include <test.h>
> -#include <usctest.h>
> +#include <libgen.h>
> +#include "test.h"
> +#include "usctest.h"
> +#include "libtestsuite.h"
> 
>  char *TCID = "execve04";
>  int TST_TOTAL = 1;
> @@ -62,20 +67,27 @@ extern int Tst_count;
>  void setup(void);
>  void cleanup(void);
>  void help(void);
> +void do_child_1(void);
> +void do_child_2(void);
> 
> -int mypid;
> -char fname[40] = "";
> -char test_name[PATH_MAX] = "";
> -int ifile, nfile, first;
> -
> -int exp_enos[] = { EMFILE, 0 };
> +int exp_enos[] = { ETXTBSY, 0 };
> +int start_sync_pipes[2];
> +int end_sync_pipes[2];
> 
>  int Fflag = 0;
> -char *fname1;
> +char *test_name;
> +
> +#ifdef UCLINUX
> +#define PIPE_NAME_START		"execve04_start"
> +#define PIPE_NAME_END		"execve04_end"
> +#else
> +#define PIPE_NAME_START		NULL
> +#define PIPE_NAME_END		NULL
> +#endif
> 
>  /* for test specific parse_opts options - in this case "-F" */
>  option_t options[] = {
> -	{"F:", &Fflag, &fname1},
> +	{"F:", &Fflag, &test_name},
>  	{NULL, NULL, NULL}
>  };
> 
> @@ -83,20 +95,23 @@ int main(int ac, char **av)
>  {
>  	int lc;			/* loop counter */
>  	char *msg;		/* message returned from parse_opts */
> -	int childpid;
> -	int err;
> +	pid_t pid, pid1;
> +	int e_code, status, retval = 3;
> +	char *argv[1], *env[1];
> 
>  	/* parse standard options */
>  	if ((msg = parse_opts(ac, av, options, &help)) != (char *)NULL) {
>  		tst_brkm(TBROK, tst_exit, "OPTION PARSING ERROR - %s", msg);
>  	}
> +#ifdef UCLINUX
> +	maybe_run_child(&do_child_1, "nS", 1, &test_name);
> +#endif
> 
>  	if (!Fflag) {
> -		tst_resm(TWARN,
> -			 "You must specify a test executable with"
> +		tst_resm(TWARN, "You must specify an executable file with "
>  			 "the -F option.");
>  		tst_resm(TWARN, "Run '%s -h' for option information.", TCID);
> -		tst_exit();
> +		cleanup();
>  	}
> 
>  	setup();
> @@ -109,119 +124,152 @@ int main(int ac, char **av)
>  		/* reset Tst_count in case we are looping */
>  		Tst_count = 0;
> 
> -		childpid = fork();
> -		if (childpid == -1) {
> -			tst_resm(TBROK, "fork() failed: %s", strerror(errno));
> -		} else if (childpid == 0) {
> -			TEST(execve(test_name, NULL, NULL));
> -			exit(TEST_ERRNO);
> -		} else {	/* parent */
> -			waitpid(childpid, &err, 0);
> -			err = WEXITSTATUS(err);
> -
> -			if (err != EMFILE) {
> -				tst_resm(TFAIL,
> -					 "execve(%s) failed: expected EMFILE(%d), got %d (%s)",
> -					 test_name, EMFILE, err, strerror(err));
> -				continue;
> +		if (sync_pipe_create(start_sync_pipes, PIPE_NAME_START) == -1)
> +			tst_brkm(TBROK, cleanup, "sync_pipe_create failed");
> +		if (sync_pipe_create(end_sync_pipes, PIPE_NAME_END) == -1)
> +			tst_brkm(TBROK, cleanup, "sync_pipe_create failed");
> +
> +		/*
> +		 * to test whether execve(2) sets ETXTBSY when a second
> +		 * child process attempts to execve the executable opened
> +		 * by the first child process
> +		 */
> +		if ((pid = FORK_OR_VFORK()) == -1) {
> +			tst_brkm(TBROK, cleanup, "fork #1 failed");
> +		}
> +
> +		if (pid == 0) {	/* first child */
> +#ifdef UCLINUX
> +			if (self_exec(av[0], "nS", 1, test_name) < 0) {
> +				tst_brkm(TBROK, cleanup, "self_exec failed");
>  			}
> +#else
> +			do_child_1();
> +#endif
> +		}
> 
> -			TEST_ERROR_LOG(err);
> +		if (sync_pipe_wait(start_sync_pipes) == -1)
> +			tst_brkm(TBROK, cleanup, "sync_pipe_wait failed");
> 
> -			tst_resm(TPASS, "Expected failure - %d : %s", err,
> -				 strerror(err));
> -		}
> +		if (sync_pipe_close(start_sync_pipes, PIPE_NAME_START) == -1)
> +			tst_brkm(TBROK, cleanup, "sync_pipe_close failed");
> +
> +		if ((pid1 = FORK_OR_VFORK()) == -1)
> +			tst_brkm(TBROK, cleanup, "fork #2 failed");
> +
> +		if (pid1 == 0) {	/* second child */
> +			argv[0] = 0;
> +			env[0] = 0;
> +
> +			/* do not interfere with end synchronization of first
> +			 * child */
> +			sync_pipe_close(end_sync_pipes, PIPE_NAME_END);
> 
> +			TEST(execve(test_name, argv, env));
> +
> +			TEST_ERROR_LOG(TEST_ERRNO);
> +
> +			if (TEST_ERRNO != ETXTBSY) {
> +				retval = 1;
> +				tst_resm(TFAIL, "expected ETXTBSY, received "
> +					 "%d : %s", TEST_ERRNO,
> +					 strerror(TEST_ERRNO));
> +			} else {
> +				tst_resm(TPASS, "call generated expected "
> +					 "ETXTBSY error");
> +			}
> +			exit(retval);
> +		} else {	/* parent */
> +			/* wait for the child to finish */
> +			waitpid(pid1, &status, 0);
> +			/* make sure the child returned a good exit status */
> +			e_code = status >> 8;
> +			/* If execve() succeeds, child cannot report the error */
> +			if (status == 0)
> +				tst_resm(TFAIL, "execve succeeded, "
> +					 "expected failure");
> +			if ((e_code != 3) || (retval != 3)) {
> +				tst_resm(TFAIL, "Failures reported above");
> +			}
> +
> +			/*  terminate first child */
> +			sync_pipe_notify(end_sync_pipes);
> +			waitpid(pid, NULL, 0);
> +			cleanup();
> +		}
>  	}
> -	cleanup();
> 
> -	/* NOTREACHED */
> -	return 0;
> +	 /*NOTREACHED*/ return 0;
>  }
> 
>  /*
> - * help
> - *	Prints out the help message for the -F option defined
> - *	by this test.
> + * help() - Prints out the help message for the -D option defined
> + *          by this test.
>   */
>  void help()
>  {
> -	puts("  -F <test file> : for example, 'execve04 -F test1'\n");
> +	printf("  -F <test name> : for example, 'execve04 -F test3'\n");
>  }
> 
>  /*
> - * setup
> - *	performs all ONE TIME setup for this test.
> + * setup() - performs all ONE TIME setup for this test.
>   */
>  void setup()
>  {
> -	int fd;
> -	char *pname = NULL;
> +	char *cmd, *dirc, *basec, *bname, *dname, *path, *pwd = NULL;
> +	int res;
> 
>  	/* capture signals */
>  	tst_sig(FORK, DEF_HANDLER, cleanup);
> 
> -	/* Pause if that option was specified */
> -	TEST_PAUSE;
> -
> -	/*
> -	 * Get the current working directory and append to it the name
> -	 * of the executable file specified with the -F option.
> -	 * This way when we issue the execve() call later, we get the
> -	 * correct path.  But only do this if user did not provide the
> -	 * full path to the executable file.
> +	/* Get file name of the passed test file and the absolute path to it.
> +	 * We will need these informations to copy the test file in the temp
> +	 * directory.
>  	 */
> -	if (*fname1 != '/') {
> -		if ((pname = getcwd(pname, 0)) == NULL) {
> +	dirc = strdup(test_name);
> +	basec = strdup(test_name);
> +	dname = dirname(dirc);
> +	bname = basename(basec);
> +
> +	if (dname[0] == '/')
> +		path = dname;
> +	else {
> +		if ((pwd = getcwd(NULL, 0)) == NULL) {
>  			tst_brkm(TBROK, tst_exit,
>  				 "Could not get current directory");
>  		}
> -		snprintf(test_name, sizeof(test_name) - 1, "%s/%s", pname,
> -			 fname1);
> -	} else {
> -		strncpy(test_name, fname1, sizeof(test_name) - 1);
> +		path = malloc(strlen(pwd) + strlen(dname) + 2);
> +		if (path == NULL) {
> +			tst_brkm(TBROK, tst_exit, "Cannot alloc path string");
> +		}
> +		sprintf(path, "%s/%s", pwd, dname);
>  	}
> 
> -	/* make temp dir and cd to it */
> +	/* make a temp dir and cd to it */
>  	tst_tmpdir();
> 
> -	nfile = getdtablesize();
> -	mypid = getpid();
> -
> -	sprintf(fname, "execve04.%d", mypid);
> -	unlink(fname);
> -
> -	if ((first = fd = creat(fname, 0666)) == -1) {
> -		tst_brkm(TBROK, cleanup, "Cannot open first file: %s",
> -			 strerror(errno));
> +	/* Copy the given test file to the private temp directory.
> +	 */
> +	cmd = malloc(strlen(path) + strlen(bname) + 15);
> +	if (cmd == NULL) {
> +		tst_brkm(TBROK, tst_exit, "Cannot alloc command string");
>  	}
> 
> -	close(fd);
> -	unlink(fname);
> -
> -	for (ifile = first; ifile <= nfile; ifile++) {
> -		sprintf(fname, "execve04.%d.%d", ifile, mypid);
> -		if ((fd = creat(fname, 0666)) == -1) {
> -			if (errno == EMFILE) {
> -				if (ifile != nfile)
> -					tst_resm(TINFO,
> -						 "couldn't creat file #%d, but this should be ok",
> -						 ifile + 1);
> -				break;
> -			}
> -			tst_resm(TBROK,
> -				 "couldn't creat file #%d, expected to "
> -				 "create %d files: %s", ifile + 1, nfile,
> -				 strerror(errno));
> -			cleanup();
> -		}
> +	sprintf(cmd, "cp -p %s/%s .", path, bname);
> +	res = system(cmd);
> +	free(cmd);
> +	if (res == -1) {
> +		tst_brkm(TBROK, tst_exit, "Cannot copy file %s", test_name);
>  	}
> +
> +	test_name = bname;
> +	/* Pause if that option was specified */
> +	TEST_PAUSE;
>  }
> 
>  /*
> - * cleanup
> - *	performs all ONE TIME cleanup for this test at completion or
> - *	premature exit
> + * cleanup() - performs all ONE TIME cleanup for this test at
> + *	       completion or premature exit.
>   */
>  void cleanup()
>  {
> @@ -229,17 +277,48 @@ void cleanup()
>  	 * print timing stats if that option was specified.
>  	 * print errno log if that option was specified.
>  	 */
> -	close(first);
> -
>  	TEST_CLEANUP;
> 
> -	/* Remove the tmp dir and all files it */
> -	for (ifile = first; ifile < nfile; ifile++) {
> -		sprintf(fname, "execve04.%d.%d", ifile, mypid);
> -		unlink(fname);
> -	}
> +	/* Remove the temporary directory */
>  	tst_rmdir();
> 
>  	/* exit with return code appropriate for results */
>  	tst_exit();
>  }
> +
> +/*
> + * do_child_1()
> + */
> +void do_child_1()
> +{
> +	int fildes;
> +
> +#ifdef UCLINUX
> +	if (sync_pipe_create(start_sync_pipes, PIPE_NAME_START) == -1)
> +		tst_brkm(TBROK, cleanup, "sync_pipe_create failed");
> +	if (sync_pipe_create(end_sync_pipes, PIPE_NAME_END) == -1)
> +		tst_brkm(TBROK, cleanup, "sync_pipe_create failed");
> +#endif
> +
> +	if ((fildes = open(test_name, O_WRONLY)) == -1) {
> +		tst_brkm(TBROK, NULL, "open(2) failed");
> +		exit(1);
> +	}
> +
> +	if (sync_pipe_notify(start_sync_pipes) == -1) {
> +		tst_brkm(TBROK, NULL, "sync_pipe_notify failed");
> +		exit(1);
> +	}
> +
> +	if (sync_pipe_close(start_sync_pipes, PIPE_NAME_START) == -1) {
> +		tst_brkm(TBROK, NULL, "sync_pipe_close failed");
> +		exit(1);
> +	}
> +
> +	/* let other child execve same file */
> +	if (sync_pipe_wait(end_sync_pipes) == -1) {
> +		tst_brkm(TBROK, NULL, "sync_pipe_wait failed");
> +		exit(1);
> +	}
> +	exit(0);
> +}
> diff --git a/testcases/kernel/syscalls/execve/execve05.c b/testcases/kernel/syscalls/execve/execve05.c
> index e232a03..ec2c99e 100644
> --- a/testcases/kernel/syscalls/execve/execve05.c
> +++ b/testcases/kernel/syscalls/execve/execve05.c
> @@ -19,104 +19,75 @@
> 
>  /*
>   * NAME
> - *	execve05.c
> + * 	execve05.c
>   *
>   * DESCRIPTION
> - *	Testcase to check execve sets the following errnos correctly:
> - *	1.	ETXTBSY
> + * 	This testcase tests the basic functionality of the execve(2) system
> + *	call.
>   *
>   * ALGORITHM
> - *	1.	Attempt to execve(2) a file which is being opened by another
> - *		process for writing fails with ETXTBSY.
> + *	This program also gets the names "test1", and "test2". This tests
> + *	the functionality of the execve(2) system call by spawning a few
> + *	children, each of which would execute "test1/test2" executables, and
> + *	finally the parent ensures that they terminated correctly.
>   *
> - * USAGE:  <for command-line>
> - *  execve05 -F <test file> [-c n] [-e] [-i n] [-I x] [-P x] [-t]
> - *     where,  -c n : Run n copies concurrently.
> - *             -e   : Turn on errno logging.
> - *             -i n : Execute test n times.
> - *             -I x : Execute test for x seconds.
> - *             -P x : Pause for x seconds between iterations.
> - *             -t   : Turn on syscall timing.
> - *
> - * HISTORY
> - *	07/2001 Ported by Wayne Boyer
> - *	04/2008 Roy Lee <roylee@andestech.com>
> - *              - Fix a synchronization issue.
> - *                On a loaded system, the 'execving' child can get access
> - *                to the file before the 'opening' child does, hence results
> - *                in an unexpected opening fail.
> + * USAGE
> + *	execve05 20 test1 test2 4
>   *
>   * RESTRICTIONS
> - *	must be run with -F <test file> option
> + * 	This program does not follow the LTP format - *PLEASE FIX*
>   */
> 
>  #include <stdio.h>
>  #include <errno.h>
> -#include <fcntl.h>
>  #include <sys/types.h>
> +#include <sys/stat.h>
>  #include <sys/wait.h>
> -#include <libgen.h>
>  #include "test.h"
>  #include "usctest.h"
> -#include "libtestsuite.h"
> 
> -char *TCID = "execve05";
> -int TST_TOTAL = 1;
> -extern int Tst_count;
> +#undef DEBUG			/* change this to #define if needed */
> 
>  void setup(void);
>  void cleanup(void);
> -void help(void);
> -void do_child_1(void);
> -void do_child_2(void);
> -
> -int exp_enos[] = { ETXTBSY, 0 };
> -int start_sync_pipes[2];
> -int end_sync_pipes[2];
> 
> -int Fflag = 0;
> -char *test_name;
> +char *TCID = "execve05";
> +int TST_TOTAL = 1;
> +extern int Tst_count;
> 
> -#ifdef UCLINUX
> -#define PIPE_NAME_START		"execve05_start"
> -#define PIPE_NAME_END		"execve05_end"
> -#else
> -#define PIPE_NAME_START		NULL
> -#define PIPE_NAME_END		NULL
> -#endif
> +int iterations;
> +char *fname1;
> +char *fname2;
> +char *prog;
> +char *av[6];
> +char *ev[1];
> 
> -/* for test specific parse_opts options - in this case "-F" */
> -option_t options[] = {
> -	{"F:", &Fflag, &test_name},
> -	{NULL, NULL, NULL}
> -};
> +void usage(void)
> +{
> +	tst_resm(TBROK, "usage: %s <iters> <fname1> <fname2> <count>", TCID);
> +	tst_resm(TINFO, "example: %s 20 test1 test2 4", TCID);
> +	tst_exit();
> +}
> 
>  int main(int ac, char **av)
>  {
> -	int lc;			/* loop counter */
> -	char *msg;		/* message returned from parse_opts */
> -	pid_t pid, pid1;
> -	int e_code, status, retval = 3;
> -	char *argv[1], *env[1];
> +	char iter[20];
> +	int pid, child, status, count;
> +	int nchild, i, fail = 0;
> +
> +	int lc;
> +	char *msg;
> 
>  	/* parse standard options */
> -	if ((msg = parse_opts(ac, av, options, &help)) != (char *)NULL) {
> +	if ((msg = parse_opts(ac, av, (option_t *) NULL, NULL)) != (char *)NULL) {
>  		tst_brkm(TBROK, tst_exit, "OPTION PARSING ERROR - %s", msg);
> -	}
> -#ifdef UCLINUX
> -	maybe_run_child(&do_child_1, "nS", 1, &test_name);
> -#endif
> -
> -	if (!Fflag) {
> -		tst_resm(TWARN, "You must specify an executable file with "
> -			 "the -F option.");
> -		tst_resm(TWARN, "Run '%s -h' for option information.", TCID);
> -		cleanup();
> -	}
> -
> +	 /*NOTREACHED*/}
>  	setup();
> 
> -	TEST_EXP_ENOS(exp_enos);
> +	if (ac != 5) {
> +		tst_resm(TINFO, "Wrong number of arguments");
> +		usage();
> +	 /*NOTREACHED*/}
> 
>  	/* check looping state if -i option given */
>  	for (lc = 0; TEST_LOOPING(lc); lc++) {
> @@ -124,201 +95,142 @@ int main(int ac, char **av)
>  		/* reset Tst_count in case we are looping */
>  		Tst_count = 0;
> 
> -		if (sync_pipe_create(start_sync_pipes, PIPE_NAME_START) == -1)
> -			tst_brkm(TBROK, cleanup, "sync_pipe_create failed");
> -		if (sync_pipe_create(end_sync_pipes, PIPE_NAME_END) == -1)
> -			tst_brkm(TBROK, cleanup, "sync_pipe_create failed");
> +		prog = av[0];
> +		iterations = atoi(av[1]);
> +		fname1 = av[2];
> +		fname2 = av[3];
> +		count = atoi(av[4]);
> +#ifdef DEBUG
> +		tst_resm(TINFO, "Entered %s %d %s %s %d -- pid = %d", prog,
> +			 iterations, fname1, fname2, count, getpid());
> +#endif
> 
> -		/*
> -		 * to test whether execve(2) sets ETXTBSY when a second
> -		 * child process attempts to execve the executable opened
> -		 * by the first child process
> -		 */
> -		if ((pid = FORK_OR_VFORK()) == -1) {
> -			tst_brkm(TBROK, cleanup, "fork #1 failed");
> +		if (iterations == 0) {
> +			tst_resm(TPASS, "Test DONE, pid %d, -- %s %d %s %s",
> +				 getpid(), prog, iterations, fname1, fname2);
> +			tst_exit();
>  		}
> 
> -		if (pid == 0) {	/* first child */
> -#ifdef UCLINUX
> -			if (self_exec(av[0], "nS", 1, test_name) < 0) {
> -				tst_brkm(TBROK, cleanup, "self_exec failed");
> -			}
> -#else
> -			do_child_1();
> +		if (!count) {
> +			sprintf(iter, "%d", iterations - 1);
> +			av[0] = fname1;
> +			av[1] = iter;
> +			av[2] = fname1;
> +			av[3] = fname2;
> +			av[4] = "0";
> +			av[5] = 0;
> +			ev[0] = 0;
> +#ifdef DEBUG
> +			tst_resm(TINFO, "Doing execve(%s, av, ev)", fname1);
> +			tst_resm(TINFO, "av[0,1,2,3,4] = %s, %s, %s, %s, %s",
> +				 av[0], av[1], av[2], av[3], av[4]);
>  #endif
> +			(void)execve(fname1, av, ev);
> +			tst_resm(TFAIL, "Execve fail, %s, errno=%d", fname1,
> +				 errno);
>  		}
> 
> -		if (sync_pipe_wait(start_sync_pipes) == -1)
> -			tst_brkm(TBROK, cleanup, "sync_pipe_wait failed");
> -
> -		if (sync_pipe_close(start_sync_pipes, PIPE_NAME_START) == -1)
> -			tst_brkm(TBROK, cleanup, "sync_pipe_close failed");
> -
> -		if ((pid1 = FORK_OR_VFORK()) == -1)
> -			tst_brkm(TBROK, cleanup, "fork #2 failed");
> -
> -		if (pid1 == 0) {	/* second child */
> -			argv[0] = 0;
> -			env[0] = 0;
> -
> -			/* do not interfere with end synchronization of first
> -			 * child */
> -			sync_pipe_close(end_sync_pipes, PIPE_NAME_END);
> -
> -			TEST(execve(test_name, argv, env));
> -
> -			TEST_ERROR_LOG(TEST_ERRNO);
> -
> -			if (TEST_ERRNO != ETXTBSY) {
> -				retval = 1;
> -				tst_resm(TFAIL, "expected ETXTBSY, received "
> -					 "%d : %s", TEST_ERRNO,
> -					 strerror(TEST_ERRNO));
> -			} else {
> -				tst_resm(TPASS, "call generated expected "
> -					 "ETXTBSY error");
> +		nchild = count * 2;
> +
> +		sprintf(iter, "%d", iterations);
> +		for (i = 0; i < count; i++) {
> +			pid = FORK_OR_VFORK();
> +			if (pid < 0) {
> +				perror("Fork failed");
> +				exit(1);
> +			} else if (pid == 0) {
> +				av[0] = fname1;
> +				av[1] = iter;
> +				av[2] = fname1;
> +				av[3] = fname2;
> +				av[4] = "0";
> +				av[5] = 0;
> +				ev[0] = 0;
> +				(void)execve(fname1, av, ev);
> +				tst_resm(TFAIL, "Execve fail, %s, errno = %d",
> +					 fname1, errno);
> +				exit(2);
> +			}
> +#ifdef DEBUG
> +			tst_resm(TINFO, "Main - started pid %d", pid);
> +#endif
> +			pid = FORK_OR_VFORK();
> +			if (pid < 0) {
> +				perror("Fork failed");
> +				exit(1);
> +			} else if (pid == 0) {
> +				av[0] = fname2;
> +				av[1] = iter;
> +				av[2] = fname2;
> +				av[3] = fname1;
> +				av[4] = "0";
> +				av[5] = 0;
> +				ev[0] = 0;
> +				execve(fname2, av, ev);
> +				tst_resm(TFAIL, "Execve fail, %s, errno = %d",
> +					 fname2, errno);
> +				exit(2);
>  			}
> -			exit(retval);
> -		} else {	/* parent */
> -			/* wait for the child to finish */
> -			waitpid(pid1, &status, 0);
> -			/* make sure the child returned a good exit status */
> -			e_code = status >> 8;
> -			/* If execve() succeeds, child cannot report the error */
> -			if (status == 0)
> -				tst_resm(TFAIL, "execve succeeded, "
> -					 "expected failure");
> -			if ((e_code != 3) || (retval != 3)) {
> -				tst_resm(TFAIL, "Failures reported above");
> +#ifdef DEBUG
> +			tst_resm(TINFO, "Main - started pid %d", pid);
> +#endif
> +		}
> +
> +		/*
> +		 * Wait for children to finish
> +		 */
> +		count = 0;
> +		while ((child = wait(&status)) > 0) {
> +#ifdef DEBUG
> +			tst_resm(TINFO, "Test [%d] exited status = 0x%x",
> +				 child, status);
> +#endif
> +			++count;
> +			if (status) {
> +				fail = 1;
>  			}
> +		}
> 
> -			/*  terminate first child */
> -			sync_pipe_notify(end_sync_pipes);
> -			waitpid(pid, NULL, 0);
> -			cleanup();
> +		/*
> +		 * Should have colledcted all children
> +		 */
> +		if (count != nchild) {
> +			tst_resm(TFAIL, "Wrong #children waited on, count = %d",
> +				 count);
> +			fail = 1;
> +		}
> +		if (fail) {
> +			tst_resm(TINFO, "Test FAILED");
> +		} else {
> +			tst_resm(TINFO, "Test PASSED");
>  		}
>  	}
> +	cleanup();
> 
>  	 /*NOTREACHED*/ return 0;
>  }
> 
>  /*
> - * help() - Prints out the help message for the -D option defined
> - *          by this test.
> - */
> -void help()
> -{
> -	printf("  -F <test name> : for example, 'execve05 -F test3'\n");
> -}
> -
> -/*
> - * setup() - performs all ONE TIME setup for this test.
> + * setup - performs all ONE TIME steup for this test
>   */
> -void setup()
> +void setup(void)
>  {
> -	char *cmd, *dirc, *basec, *bname, *dname, *path, *pwd = NULL;
> -	int res;
> -
>  	/* capture signals */
>  	tst_sig(FORK, DEF_HANDLER, cleanup);
> 
> -	/* Get file name of the passed test file and the absolute path to it.
> -	 * We will need these informations to copy the test file in the temp
> -	 * directory.
> -	 */
> -	dirc = strdup(test_name);
> -	basec = strdup(test_name);
> -	dname = dirname(dirc);
> -	bname = basename(basec);
> -
> -	if (dname[0] == '/')
> -		path = dname;
> -	else {
> -		if ((pwd = getcwd(NULL, 0)) == NULL) {
> -			tst_brkm(TBROK, tst_exit,
> -				 "Could not get current directory");
> -		}
> -		path = malloc(strlen(pwd) + strlen(dname) + 2);
> -		if (path == NULL) {
> -			tst_brkm(TBROK, tst_exit, "Cannot alloc path string");
> -		}
> -		sprintf(path, "%s/%s", pwd, dname);
> -	}
> -
> -	/* make a temp dir and cd to it */
> -	tst_tmpdir();
> -
> -	/* Copy the given test file to the private temp directory.
> -	 */
> -	cmd = malloc(strlen(path) + strlen(bname) + 15);
> -	if (cmd == NULL) {
> -		tst_brkm(TBROK, tst_exit, "Cannot alloc command string");
> -	}
> -
> -	sprintf(cmd, "cp -p %s/%s .", path, bname);
> -	res = system(cmd);
> -	free(cmd);
> -	if (res == -1) {
> -		tst_brkm(TBROK, tst_exit, "Cannot copy file %s", test_name);
> -	}
> -
> -	test_name = bname;
>  	/* Pause if that option was specified */
>  	TEST_PAUSE;
> +
> +	umask(0);
>  }
> 
>  /*
> - * cleanup() - performs all ONE TIME cleanup for this test at
> - *	       completion or premature exit.
> + * cleanup() - performs all the ONE TIME cleanup for this test at completion or
> + * 	       premature exit
>   */
> -void cleanup()
> +void cleanup(void)
>  {
> -	/*
> -	 * print timing stats if that option was specified.
> -	 * print errno log if that option was specified.
> -	 */
>  	TEST_CLEANUP;
> 
> -	/* Remove the temporary directory */
> -	tst_rmdir();
> -
> -	/* exit with return code appropriate for results */
>  	tst_exit();
>  }
> -
> -/*
> - * do_child_1()
> - */
> -void do_child_1()
> -{
> -	int fildes;
> -
> -#ifdef UCLINUX
> -	if (sync_pipe_create(start_sync_pipes, PIPE_NAME_START) == -1)
> -		tst_brkm(TBROK, cleanup, "sync_pipe_create failed");
> -	if (sync_pipe_create(end_sync_pipes, PIPE_NAME_END) == -1)
> -		tst_brkm(TBROK, cleanup, "sync_pipe_create failed");
> -#endif
> -
> -	if ((fildes = open(test_name, O_WRONLY)) == -1) {
> -		tst_brkm(TBROK, NULL, "open(2) failed");
> -		exit(1);
> -	}
> -
> -	if (sync_pipe_notify(start_sync_pipes) == -1) {
> -		tst_brkm(TBROK, NULL, "sync_pipe_notify failed");
> -		exit(1);
> -	}
> -
> -	if (sync_pipe_close(start_sync_pipes, PIPE_NAME_START) == -1) {
> -		tst_brkm(TBROK, NULL, "sync_pipe_close failed");
> -		exit(1);
> -	}
> -
> -	/* let other child execve same file */
> -	if (sync_pipe_wait(end_sync_pipes) == -1) {
> -		tst_brkm(TBROK, NULL, "sync_pipe_wait failed");
> -		exit(1);
> -	}
> -	exit(0);
> -}
> diff --git a/testcases/kernel/syscalls/execve/execve06.c b/testcases/kernel/syscalls/execve/execve06.c
> deleted file mode 100644
> index 3146d45..0000000
> --- a/testcases/kernel/syscalls/execve/execve06.c
> +++ /dev/null
> @@ -1,236 +0,0 @@
> -/*
> - *
> - *   Copyright (c) International Business Machines  Corp., 2001
> - *
> - *   This program is free software;  you can redistribute it and/or modify
> - *   it under the terms of the GNU General Public License as published by
> - *   the Free Software Foundation; either version 2 of the License, or
> - *   (at your option) any later version.
> - *
> - *   This program is distributed in the hope that it will be useful,
> - *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
> - *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> - *   the GNU General Public License for more details.
> - *
> - *   You should have received a copy of the GNU General Public License
> - *   along with this program;  if not, write to the Free Software
> - *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
> - */
> -
> -/*
> - * NAME
> - * 	execve06.c
> - *
> - * DESCRIPTION
> - * 	This testcase tests the basic functionality of the execve(2) system
> - *	call.
> - *
> - * ALGORITHM
> - *	This program also gets the names "test1", and "test2". This tests
> - *	the functionality of the execve(2) system call by spawning a few
> - *	children, each of which would execute "test1/test2" executables, and
> - *	finally the parent ensures that they terminated correctly.
> - *
> - * USAGE
> - *	execve06 20 test1 test2 4
> - *
> - * RESTRICTIONS
> - * 	This program does not follow the LTP format - *PLEASE FIX*
> - */
> -
> -#include <stdio.h>
> -#include <errno.h>
> -#include <sys/types.h>
> -#include <sys/stat.h>
> -#include <sys/wait.h>
> -#include "test.h"
> -#include "usctest.h"
> -
> -#undef DEBUG			/* change this to #define if needed */
> -
> -void setup(void);
> -void cleanup(void);
> -
> -char *TCID = "execve06";
> -int TST_TOTAL = 1;
> -extern int Tst_count;
> -
> -int iterations;
> -char *fname1;
> -char *fname2;
> -char *prog;
> -char *av[6];
> -char *ev[1];
> -
> -void usage(void)
> -{
> -	tst_resm(TBROK, "usage: %s <iters> <fname1> <fname2> <count>", TCID);
> -	tst_resm(TINFO, "example: %s 20 test1 test2 4", TCID);
> -	tst_exit();
> -}
> -
> -int main(int ac, char **av)
> -{
> -	char iter[20];
> -	int pid, child, status, count;
> -	int nchild, i, fail = 0;
> -
> -	int lc;
> -	char *msg;
> -
> -	/* parse standard options */
> -	if ((msg = parse_opts(ac, av, (option_t *) NULL, NULL)) != (char *)NULL) {
> -		tst_brkm(TBROK, tst_exit, "OPTION PARSING ERROR - %s", msg);
> -	 /*NOTREACHED*/}
> -	setup();
> -
> -	if (ac != 5) {
> -		tst_resm(TINFO, "Wrong number of arguments");
> -		usage();
> -	 /*NOTREACHED*/}
> -
> -	/* check looping state if -i option given */
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -
> -		/* reset Tst_count in case we are looping */
> -		Tst_count = 0;
> -
> -		prog = av[0];
> -		iterations = atoi(av[1]);
> -		fname1 = av[2];
> -		fname2 = av[3];
> -		count = atoi(av[4]);
> -#ifdef DEBUG
> -		tst_resm(TINFO, "Entered %s %d %s %s %d -- pid = %d", prog,
> -			 iterations, fname1, fname2, count, getpid());
> -#endif
> -
> -		if (iterations == 0) {
> -			tst_resm(TPASS, "Test DONE, pid %d, -- %s %d %s %s",
> -				 getpid(), prog, iterations, fname1, fname2);
> -			tst_exit();
> -		}
> -
> -		if (!count) {
> -			sprintf(iter, "%d", iterations - 1);
> -			av[0] = fname1;
> -			av[1] = iter;
> -			av[2] = fname1;
> -			av[3] = fname2;
> -			av[4] = "0";
> -			av[5] = 0;
> -			ev[0] = 0;
> -#ifdef DEBUG
> -			tst_resm(TINFO, "Doing execve(%s, av, ev)", fname1);
> -			tst_resm(TINFO, "av[0,1,2,3,4] = %s, %s, %s, %s, %s",
> -				 av[0], av[1], av[2], av[3], av[4]);
> -#endif
> -			(void)execve(fname1, av, ev);
> -			tst_resm(TFAIL, "Execve fail, %s, errno=%d", fname1,
> -				 errno);
> -		}
> -
> -		nchild = count * 2;
> -
> -		sprintf(iter, "%d", iterations);
> -		for (i = 0; i < count; i++) {
> -			pid = FORK_OR_VFORK();
> -			if (pid < 0) {
> -				perror("Fork failed");
> -				exit(1);
> -			} else if (pid == 0) {
> -				av[0] = fname1;
> -				av[1] = iter;
> -				av[2] = fname1;
> -				av[3] = fname2;
> -				av[4] = "0";
> -				av[5] = 0;
> -				ev[0] = 0;
> -				(void)execve(fname1, av, ev);
> -				tst_resm(TFAIL, "Execve fail, %s, errno = %d",
> -					 fname1, errno);
> -				exit(2);
> -			}
> -#ifdef DEBUG
> -			tst_resm(TINFO, "Main - started pid %d", pid);
> -#endif
> -			pid = FORK_OR_VFORK();
> -			if (pid < 0) {
> -				perror("Fork failed");
> -				exit(1);
> -			} else if (pid == 0) {
> -				av[0] = fname2;
> -				av[1] = iter;
> -				av[2] = fname2;
> -				av[3] = fname1;
> -				av[4] = "0";
> -				av[5] = 0;
> -				ev[0] = 0;
> -				execve(fname2, av, ev);
> -				tst_resm(TFAIL, "Execve fail, %s, errno = %d",
> -					 fname2, errno);
> -				exit(2);
> -			}
> -#ifdef DEBUG
> -			tst_resm(TINFO, "Main - started pid %d", pid);
> -#endif
> -		}
> -
> -		/*
> -		 * Wait for children to finish
> -		 */
> -		count = 0;
> -		while ((child = wait(&status)) > 0) {
> -#ifdef DEBUG
> -			tst_resm(TINFO, "Test [%d] exited status = 0x%x",
> -				 child, status);
> -#endif
> -			++count;
> -			if (status) {
> -				fail = 1;
> -			}
> -		}
> -
> -		/*
> -		 * Should have colledcted all children
> -		 */
> -		if (count != nchild) {
> -			tst_resm(TFAIL, "Wrong #children waited on, count = %d",
> -				 count);
> -			fail = 1;
> -		}
> -		if (fail) {
> -			tst_resm(TINFO, "Test FAILED");
> -		} else {
> -			tst_resm(TINFO, "Test PASSED");
> -		}
> -	}
> -	cleanup();
> -
> -	 /*NOTREACHED*/ return 0;
> -}
> -
> -/*
> - * setup - performs all ONE TIME steup for this test
> - */
> -void setup(void)
> -{
> -	/* capture signals */
> -	tst_sig(FORK, DEF_HANDLER, cleanup);
> -
> -	/* Pause if that option was specified */
> -	TEST_PAUSE;
> -
> -	umask(0);
> -}
> -
> -/*
> - * cleanup() - performs all the ONE TIME cleanup for this test at completion or
> - * 	       premature exit
> - */
> -void cleanup(void)
> -{
> -	TEST_CLEANUP;
> -
> -	tst_exit();
> -}


------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT 
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp as they present alongside digital heavyweights like Barbarian 
Group, R/GA, & Big Spaceship. http://p.sf.net/sfu/creativitycat-com 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
