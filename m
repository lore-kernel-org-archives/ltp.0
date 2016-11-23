From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 23 Nov 2016 15:13:51 +0100
Subject: [LTP] [PATCH 3/4] ipc/msgget02.c: reconstruct && convert to new
 API
In-Reply-To: <1479885511-7414-3-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1479885511-7414-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1479885511-7414-3-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20161123141350.GK3346@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/testcases/kernel/syscalls/ipc/msgget/msgget02.c b/testcases/kernel/syscalls/ipc/msgget/msgget02.c
> index be9bc61..85104e8 100644
> --- a/testcases/kernel/syscalls/ipc/msgget/msgget02.c
> +++ b/testcases/kernel/syscalls/ipc/msgget/msgget02.c
> @@ -1,176 +1,119 @@
>  /*
> + * Copyright (c) International Business Machines  Corp., 2001
>   *
> - *   Copyright (c) International Business Machines  Corp., 2001
> + * This program is free software;  you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
>   *
> - *   This program is free software;  you can redistribute it and/or modify
> - *   it under the terms of the GNU General Public License as published by
> - *   the Free Software Foundation; either version 2 of the License, or
> - *   (at your option) any later version.
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY;  without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> + * the GNU General Public License for more details.
>   *
> - *   This program is distributed in the hope that it will be useful,
> - *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
> - *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> - *   the GNU General Public License for more details.
> - *
> - *   You should have received a copy of the GNU General Public License
> - *   along with this program;  if not, write to the Free Software
> - *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> + * You should have received a copy of the GNU General Public License
> + * along with this program.
>   */
>  
>  /*
> - * NAME
> - *	msgget02.c
> + * NAME: msgget02.c
>   *
>   * DESCRIPTION
> - *	msgget02 - test for EEXIST and ENOENT errors
> - *
> - * ALGORITHM
> - *	create a message queue
> - *	loop if that option was specified
> - *	try to recreate the same queue - test #1
> - *	try to access a queue that doesn't exist - tests #2 & #3
> - *	check the errno value
> - *	  issue a PASS message if we get EEXIST or ENOENT depening on test
> - *	otherwise, the tests fails
> - *	  issue a FAIL message
> - *	  break any remaining tests
> - *	  call cleanup
> - *
> - * USAGE:  <for command-line>
> - *  msgget02 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
> - *     where,  -c n : Run n copies concurrently.
> - *             -e   : Turn on errno logging.
> - *	       -i n : Execute test n times.
> - *	       -I x : Execute test for x seconds.
> - *	       -P x : Pause for x seconds between iterations.
> - *	       -t   : Turn on syscall timing.
> - *
> - * HISTORY
> - *	03/2001 - Written by Wayne Boyer
> + * 1) msgget(2) fails if a message queue exists for key and msgflg
> + *    specified both IPC_CREAT and IPC_EXCL.
> + * 2) msgget(2) fails if no message queue exists for key and msgflg
> + *    did not specify IPC_CREAT.
> + * 3) msgget(2) fails if a message queue exists for key, but the
> + *    calling process does not have permission to access the queue,
> + *    and does not have the CAP_IPC_OWNER capability.
>   *
> - *      28/03/2008 Renaud Lottiaux (Renaud.Lottiaux@kerlabs.com)
> - *      - Fix concurrency issue. The second key used for this test was
> - *        sometime conflicting with the key from another task.
> - *        Generate a valid second key through getipckey to avoid conflicts.
> - *
> - * RESTRICTIONS
> - *	none
>   */
>  
> -#include "test.h"
> +#include <sys/types.h>
> +#include <sys/ipc.h>
> +#include <sys/msg.h>
> +#include <pwd.h>
>  
> -#include "ipcmsg.h"
> +#include "tst_ipcmsg.h"
> +#include "tst_test.h"
>  
> -char *TCID = "msgget02";
> -int TST_TOTAL = 3;
> +static key_t msgkey1;
> +static int msg_q_1 = -1;
>  
> -struct test_case_t {
> -	int error;
> -	int msgkey;
> +static struct tcase {
> +	int *key;
>  	int flags;
> -} TC[] = {
> -	{
> -	EEXIST, 0, IPC_CREAT | IPC_EXCL}, {
> -	ENOENT, 1, IPC_PRIVATE}, {
> -	ENOENT, 1, IPC_EXCL}
> +	int exp_err;
> +} tcases[] = {
> +	{&msgkey, IPC_CREAT | IPC_EXCL, EEXIST},
> +	{&msgkey1, IPC_PRIVATE, ENOENT},
> +	{&msgkey1, IPC_EXCL, ENOENT},
> +	{&msgkey, MSG_RD, EACCES},
> +	{&msgkey, MSG_WR, EACCES},
> +	{&msgkey, MSG_RD | MSG_WR, EACCES}
>  };
>  
> -key_t msgkey1;
> -int msg_q_1 = -1;		/* The message queue id created in setup */
> -
> -int main(int ac, char **av)
> +static void verify_msgget(struct tcase *tc)
>  {
> -	int lc;
> -	int i;
> -	key_t key;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();		/* global setup */
> +	TEST(msgget(*tc->key, tc->flags));
>  
> -	/* The following loop checks looping state if -i option given */
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		/* reset tst_count in case we are looping */
> -		tst_count = 0;
> -
> -		/* loop through the test cases */
> -
> -		for (i = 0; i < TST_TOTAL; i++) {
> -
> -			if (TC[i].msgkey == 0)
> -				key = msgkey;
> -			else
> -				key = msgkey1;
> -
> -			TEST(msgget(key, TC[i].flags));
> +	if (TEST_RETURN != -1) {
> +		tst_res(TFAIL, "msgget() succeeded unexpectedly");
> +		return;
> +	}
>  
> -			if (TEST_RETURN != -1) {
> -				tst_resm(TFAIL, "msgget() call succeeded "
> -					 "on expected fail");
> -				continue;
> -			}
> +	if (TEST_ERRNO == tc->exp_err)
> +		tst_res(TPASS | TTERRNO, "msgget() failed as expected");
> +	else
> +		tst_res(TFAIL | TTERRNO, "msgget() failed unexpectedly,"
> +			" expected %s", tst_strerrno(tc->exp_err));
> +}
>  
> -			switch (TEST_ERRNO) {
> -			case ENOENT:
> -			 /*FALLTHROUGH*/ case EEXIST:
> -				if (TEST_ERRNO == TC[i].error) {
> -					tst_resm(TPASS, "expected failure - "
> -						 "errno = %d : %s", TEST_ERRNO,
> -						 strerror(TEST_ERRNO));
> -					break;
> -				}
> -			/*FALLTHROUGH*/ default:
> -				tst_resm(TFAIL, "call failed with an "
> -					 "unexpected error - %d : %s",
> -					 TEST_ERRNO, strerror(TEST_ERRNO));
> -				break;
> -			}
> +static void verify_access(unsigned int n)
               ^
	       The function name is confusing, we do not test access()
	       call here. I would have just called this do_test() or
	       something.

> +{
> +	pid_t pid;
> +	uid_t uid;
> +	struct passwd *pw;
> +	struct tcase *tc = &tcases[n];
> +
> +	if (tc->exp_err != EACCES) {

Switching on the expected errno is kind of confusing. I would rather see
as_nobody bitflag in the tcases structure that is set to 1 for this
particular case.

> +		verify_msgget(tc);
> +	} else {
> +		pw = SAFE_GETPWNAM("nobody");
> +		uid = pw->pw_uid;

This should be done in the test setup()

> +		pid = SAFE_FORK();
> +		if (pid) {
> +			SAFE_WAITPID(pid, NULL, 0);

If you do not want to check the child return value here you should
rather call tst_reap_children() that will do that for you.

> +		} else {
> +			SAFE_SETUID(uid);
> +			verify_msgget(tc);

Missing exit(0) here?

>  		}
>  	}
> -
> -	cleanup();
> -
> -	tst_exit();
>  }
>  
> -/*
> - * setup() - performs all the ONE TIME setup for this test.
> - */
> -void setup(void)
> +static void setup(void)
>  {
> -
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> -
> -	/*
> -	 * Create a temporary directory and cd into it.
> -	 * This helps to ensure that a unique msgkey is created.
> -	 * See ../lib/libipc.c for more information.
> -	 */
> -	tst_tmpdir();
> -
>  	msgkey = getipckey();
>  	msgkey1 = getipckey();
>  
> -	/* now we have a key, so let's create a message queue */
> -	if ((msg_q_1 = msgget(msgkey, IPC_CREAT | IPC_EXCL)) == -1) {
> -		system("ipcs > /tmp/toto");
> -		system("ps -aux >> /tmp/toto");
> -		tst_brkm(TBROK, cleanup, "Can't create message queue");
> -	}
> +	msg_q_1 = msgget(msgkey, IPC_CREAT | IPC_EXCL);
> +	if (msg_q_1 == -1)
> +		tst_brk(TBROK, "Can't create message queue");
>  }

-- 
Cyril Hrubis
chrubis@suse.cz
