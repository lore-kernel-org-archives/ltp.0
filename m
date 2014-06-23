Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1WyyFZ-0005we-6z
	for ltp-list@lists.sourceforge.net; Mon, 23 Jun 2014 07:01:09 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WyyFX-0003Mx-As
	for ltp-list@lists.sourceforge.net; Mon, 23 Jun 2014 07:01:09 +0000
Date: Mon, 23 Jun 2014 03:00:57 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1746817650.28471852.1403506857337.JavaMail.zimbra@redhat.com>
In-Reply-To: <1403491065.2219.6.camel@G08JYZSD130126>
References: <1403248796.26126.0.camel@G08JYZSD130126>
	<462849312.27746159.1403256946743.JavaMail.zimbra@redhat.com>
	<1403490467.2219.5.camel@G08JYZSD130126>
	<1403491065.2219.6.camel@G08JYZSD130126>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH v2 1/2] wait/wait02: cleanup
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
To: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>





----- Original Message -----
> From: "Zeng Linggang" <zenglg.jy@cn.fujitsu.com>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: "ltp-list" <ltp-list@lists.sourceforge.net>
> Sent: Monday, 23 June, 2014 4:37:45 AM
> Subject: [PATCH v2 1/2] wait/wait02: cleanup
> 
> * Delete some useless commtents and variable.
> 
> * Some cleanup.
> 
> Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>

Series pushed with these changes:

1. print TEST_RETURN in wait01.c if it has unexpected value:
        if (TEST_RETURN != -1) {
-               tst_resm(TFAIL | TTERRNO, "wait failed unexpectedly");
+               tst_resm(TFAIL | TTERRNO, "wait failed unexpectedly: %ld",
+                       TEST_RETURN);
                return;

2. compare exit status code with exit_child in wait02.c:
-       } else if (WIFEXITED(status) && WEXITSTATUS(status) == 1) {
+       } else if (WIFEXITED(status) && WEXITSTATUS(status) == exit_child) {

3. small typo fix in commit message.

Regards,
Jan

> ---
>  testcases/kernel/syscalls/wait/wait02.c | 171
>  +++++++-------------------------
>  1 file changed, 34 insertions(+), 137 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/wait/wait02.c
> b/testcases/kernel/syscalls/wait/wait02.c
> index a95213d..0cbcd48 100644
> --- a/testcases/kernel/syscalls/wait/wait02.c
> +++ b/testcases/kernel/syscalls/wait/wait02.c
> @@ -1,5 +1,7 @@
>  /*
>   * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
> + *    AUTHOR		: William Roske
> + *    CO-PILOT		: Dave Fenner
>   *
>   * This program is free software; you can redistribute it and/or modify it
>   * under the terms of version 2 of the GNU General Public License as
> @@ -30,84 +32,6 @@
>   * http://oss.sgi.com/projects/GenInfo/NoticeExplan/
>   *
>   */
> -/* $Id: wait02.c,v 1.7 2009/10/26 14:55:48 subrata_modak Exp $ */
> -/**********************************************************
> - *
> - *    OS Test - Silicon Graphics, Inc.
> - *
> - *    TEST IDENTIFIER	: wait02
> - *
> - *    EXECUTED BY	: anyone
> - *
> - *    TEST TITLE	: Basic test for wait(2)
> - *
> - *    PARENT DOCUMENT	: usctpl01
> - *
> - *    TEST CASE TOTAL	: 1
> - *
> - *    WALL CLOCK TIME	: 1
> - *
> - *    CPU TYPES		: ALL
> - *
> - *    AUTHOR		: William Roske
> - *
> - *    CO-PILOT		: Dave Fenner
> - *
> - *    DATE STARTED	: 03/30/92
> - *
> - *    INITIAL RELEASE	: UNICOS 7.0
> - *
> - *    TEST CASES
> - *
> - *	1.) wait(2) returns...(See Description)
> - *
> - *    INPUT SPECIFICATIONS
> - *	The standard options for system call tests are accepted.
> - *	(See the parse_opts(3) man page).
> - *
> - *    OUTPUT SPECIFICATIONS
> - *
> - *    DURATION
> - *	Terminates - with frequency and infinite modes.
> - *
> - *    SIGNALS
> - *	Uses SIGUSR1 to pause before test if option set.
> - *	(See the parse_opts(3) man page).
> - *
> - *    RESOURCES
> - *	None
> - *
> - *    ENVIRONMENTAL NEEDS
> - *      No run-time environmental needs.
> - *
> - *    SPECIAL PROCEDURAL REQUIREMENTS
> - *	None
> - *
> - *    INTERCASE DEPENDENCIES
> - *	None
> - *
> - *    DETAILED DESCRIPTION
> - *	This is a Phase I test for the wait(2) system call.  It is intended
> - *	to provide a limited exposure of the system call, for now.  It
> - *	should/will be extended when full functional tests are written for
> - *	wait(2).
> - *
> - *	Setup:
> - *	  Setup signal handling.
> - *	  Pause for SIGUSR1 if option specified.
> - *
> - *	Test:
> - *	 Loop if the proper options are given.
> - *	  Execute system call
> - *	  Check return code, if system call failed (return=-1)
> - *		Log the errno and Issue a FAIL message.
> - *	  Otherwise, Issue a PASS message.
> - *
> - *	Cleanup:
> - *	  Print errno log and/or timing stats if options given
> - *
> - *
> - *#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#**/
>  
>  #include <errno.h>
>  #include <string.h>
> @@ -118,94 +42,67 @@
>  #include "test.h"
>  #include "usctest.h"
>  
> -void setup();
> -void cleanup();
> +static void setup(void);
> +static void cleanup(void);
>  
>  char *TCID = "wait02";
>  int TST_TOTAL = 1;
>  
> -int exp_enos[] = { 0, 0 };
> -
> -int fork_pid, ret_code;
> -void trapper();
> +static void wait_verify(void);
>  
>  int main(int ac, char **av)
>  {
>  	int lc;
>  	const char *msg;
>  
> -    /***************************************************************
> -     * parse standard options
> -     ***************************************************************/
> -	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
> +	msg = parse_opts(ac, av, NULL, NULL);
> +	if (msg != NULL)
>  		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
>  
> -    /***************************************************************
> -     * perform global setup for test
> -     ***************************************************************/
>  	setup();
>  
> -	/* set the expected errnos... */
> -	TEST_EXP_ENOS(exp_enos);
> -
> -    /***************************************************************
> -     * check looping state if -c option given
> -     ***************************************************************/
>  	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -
>  		tst_count = 0;
> -
> -		/* create a child to wait for */
> -		if ((fork_pid = FORK_OR_VFORK()) == -1) {
> -			tst_brkm(TBROK, cleanup,
> -				 "fork() Failure. errno=%d : %s", errno,
> -				 strerror(errno));
> -		} else if (fork_pid == 0) {
> -			/* Child, sleep a second then exit */
> -			sleep(1);
> -			exit(1);
> -		}
> -
> -		/* Parent, wait for child to die */
> -		TEST(wait(&ret_code));
> -
> -		/* check return code */
> -		if (TEST_RETURN == -1) {
> -			TEST_ERROR_LOG(TEST_ERRNO);
> -			tst_resm(TFAIL, "wait(1) Failed, errno=%d : %s",
> -				 TEST_ERRNO, strerror(TEST_ERRNO));
> -		} else {
> -			tst_resm(TPASS, "wait(&ret_code) returned %ld",
> -				 TEST_RETURN);
> -		}
> +		wait_verify();
>  	}
>  
>  	cleanup();
>  	tst_exit();
>  }
>  
> -/***************************************************************
> - * setup() - performs all ONE TIME setup for this test.
> - ***************************************************************/
> -void setup(void)
> +static void setup(void)
>  {
> -
>  	tst_sig(FORK, DEF_HANDLER, cleanup);
>  
>  	TEST_PAUSE;
> +}
>  
> +static void wait_verify(void)
> +{
> +	int fork_pid, status, exit_child = 1;
> +
> +	fork_pid = FORK_OR_VFORK();
> +	if (fork_pid == -1) {
> +		tst_brkm(TBROK | TERRNO, cleanup, "fork() Failure");
> +	} else if (fork_pid == 0) {
> +		sleep(1);
> +		exit(exit_child);
> +	}
> +
> +	TEST(wait(&status));
> +
> +	if (TEST_RETURN == -1) {
> +		tst_resm(TFAIL | TTERRNO, "wait(1) Failed");
> +	} else if (WIFEXITED(status) && WEXITSTATUS(status) == 1) {
> +		tst_resm(TPASS, "wait(&status) returned %ld", TEST_RETURN);
> +	} else {
> +		tst_resm(TFAIL,
> +			 "wait(1) Failed, exit_child - 0x%x, status - 0x%x",
> +			 exit_child, status);
> +	}
>  }
>  
> -/***************************************************************
> - * cleanup() - performs all ONE TIME cleanup for this test at
> - *		completion or premature exit.
> - ***************************************************************/
> -void cleanup(void)
> +static void cleanup(void)
>  {
> -	/*
> -	 * print timing stats if that option was specified.
> -	 * print errno log if that option was specified.
> -	 */
>  	TEST_CLEANUP;
> -
>  }
> --
> 1.9.3
> 
> 
> 
> 

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
