Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1Ujm4W-0003ZB-Gq
	for ltp-list@lists.sourceforge.net; Tue, 04 Jun 2013 07:54:24 +0000
Received: from mail-pd0-f182.google.com ([209.85.192.182])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Ujm4V-0007IB-Bp
	for ltp-list@lists.sourceforge.net; Tue, 04 Jun 2013 07:54:24 +0000
Received: by mail-pd0-f182.google.com with SMTP id g10so6850262pdj.13
	for <ltp-list@lists.sourceforge.net>;
	Tue, 04 Jun 2013 00:54:17 -0700 (PDT)
Message-ID: <51AD95E8.9000002@casparzhang.com>
Date: Tue, 04 Jun 2013 15:23:20 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <51AD55F0.8030402@cn.fujitsu.com>
In-Reply-To: <51AD55F0.8030402@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v2] shmget/shmget01.c: cleanup
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
To: DAN LI <li.dan@cn.fujitsu.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

On 06/04/2013 10:50 AM, DAN LI wrote:
> 1. Remove useless comments
>
> 2. Revise code to follow ltp-code-style
>
> Signed-off-by: DAN LI <li.dan@cn.fujitsu.com>

overall looks good to me, yet I think there are some more comments could 
be removed. like:


/* if we get here, everything looks good */

and

108                 /*
109                  * clean up things in case we are looping
110                  */

Thoughts?

Caspar

> ---
>   testcases/kernel/syscalls/ipc/shmget/shmget01.c |   86 ++++++-----------------
>   1 files changed, 21 insertions(+), 65 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/ipc/shmget/shmget01.c b/testcases/kernel/syscalls/ipc/shmget/shmget01.c
> index 38dbee7..aa2c78b 100644
> --- a/testcases/kernel/syscalls/ipc/shmget/shmget01.c
> +++ b/testcases/kernel/syscalls/ipc/shmget/shmget01.c
> @@ -1,20 +1,19 @@
>   /*
> + * Copyright (c) International Business Machines  Corp., 2001
>    *
> - *   Copyright (c) International Business Machines  Corp., 2001
> + * This program is free software;  you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
>    *
> - *   This program is free software;  you can redistribute it and/or modify
> - *   it under the terms of the GNU General Public License as published by
> - *   the Free Software Foundation; either version 2 of the License, or
> - *   (at your option) any later version.
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY;  without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> + * the GNU General Public License for more details.
>    *
> - *   This program is distributed in the hope that it will be useful,
> - *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
> - *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> - *   the GNU General Public License for more details.
> - *
> - *   You should have received a copy of the GNU General Public License
> - *   along with this program;  if not, write to the Free Software
> - *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> + * You should have received a copy of the GNU General Public License
> + * along with this program;  if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
>    */
>
>   /*
> @@ -33,27 +32,12 @@
>    *	  if doing functionality testing
>    *		stat the shared memory resource
>    *		check the size, creator pid and mode
> - *	  	if correct,
> + *		if correct,
>    *			issue a PASS message
>    *		otherwise
>    *			issue a FAIL message
>    *	  else issue a PASS message
>    *	call cleanup
> - *
> - * USAGE:  <for command-line>
> - *  shmget01 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
> - *     where,  -c n : Run n copies concurrently.
> - *             -f   : Turn off functionality Testing.
> - *	       -i n : Execute test n times.
> - *	       -I x : Execute test for x seconds.
> - *	       -P x : Pause for x seconds between iterations.
> - *	       -t   : Turn on syscall timing.
> - *
> - * HISTORY
> - *	03/2001 - Written by Wayne Boyer
> - *
> - * RESTRICTIONS
> - *	none
>    */
>
>   #include "ipcshm.h"
> @@ -61,31 +45,24 @@
>   char *TCID = "shmget01";
>   int TST_TOTAL = 1;
>
> -int shm_id_1 = -1;
> +static int shm_id_1 = -1;
>
> -int main(int ac, char **av)
> +int main(int argc, char *argv[])
>   {
>   	int lc;
>   	char *msg;
>   	struct shmid_ds buf;
>
> -	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL) {
> +	msg = parse_opts(argc, argv, NULL, NULL);
> +	if (msg != NULL)
>   		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
> -	}
>
> -	setup();		/* global setup */
> -
> -	/* The following loop checks looping state if -i option given */
> +	setup();
>
>   	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		/* reset tst_count in case we are looping */
>   		tst_count = 0;
>
> -		/*
> -		 * Use TEST macro to make the call
> -		 */
> -
> -		TEST(shmget(shmkey, SHM_SIZE, (IPC_CREAT | IPC_EXCL | SHM_RW)));
> +		TEST(shmget(shmkey, SHM_SIZE, IPC_CREAT | IPC_EXCL | SHM_RW));
>
>   		if (TEST_RETURN == -1) {
>   			tst_resm(TFAIL, "%s call failed - errno = %d : %s",
> @@ -131,11 +108,10 @@ int main(int ac, char **av)
>   		/*
>   		 * clean up things in case we are looping
>   		 */
> -		if (shmctl(shm_id_1, IPC_RMID, NULL) == -1) {
> +		if (shmctl(shm_id_1, IPC_RMID, NULL) == -1)
>   			tst_resm(TBROK, "couldn't remove shared memory");
> -		} else {
> +		else
>   			shm_id_1 = -1;
> -		}
>   	}
>
>   	cleanup();
> @@ -143,42 +119,22 @@ int main(int ac, char **av)
>   	tst_exit();
>   }
>
> -/*
> - * setup() - performs all the ONE TIME setup for this test.
> - */
>   void setup(void)
>   {
> -
>   	tst_sig(NOFORK, DEF_HANDLER, cleanup);
>
>   	TEST_PAUSE;
>
> -	/*
> -	 * Create a temporary directory and cd into it.
> -	 * This helps to ensure that a unique msgkey is created.
> -	 * See ../lib/libipc.c for more information.
> -	 */
>   	tst_tmpdir();
>
> -	/* get an IPC resource key */
>   	shmkey = getipckey();
>   }
>
> -/*
> - * cleanup() - performs all the ONE TIME cleanup for this test at completion
> - * 	       or premature exit.
> - */
>   void cleanup(void)
>   {
> -	/* if it exists, remove the shared memory resource */
>   	rm_shm(shm_id_1);
>
>   	tst_rmdir();
>
> -	/*
> -	 * print timing stats if that option was specified.
> -	 * print errno log if that option was specified.
> -	 */
>   	TEST_CLEANUP;
> -
>   }
>


------------------------------------------------------------------------------
How ServiceNow helps IT people transform IT departments:
1. A cloud service to automate IT design, transition and operations
2. Dashboards that offer high-level views of enterprise services
3. A single system of record for all IT processes
http://p.sf.net/sfu/servicenow-d2d-j
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
