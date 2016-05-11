From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 11 May 2016 15:21:36 +0200
Subject: [LTP] [PATCH 2/2] pause01: rewrite testcase
In-Reply-To: <95ff9c04f7d84a25fc19697a20e96b870f3c65ca.1462968075.git.jstancek@redhat.com>
References: <b1cd0d1691b4d5416fdc34dd6b35dee1b7909a7c.1462968075.git.jstancek@redhat.com>
 <95ff9c04f7d84a25fc19697a20e96b870f3c65ca.1462968075.git.jstancek@redhat.com>
Message-ID: <20160511132136.GE24701@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> This is a rewrite to avoid running into hang reported by Yury,
> which is based on newlib.
> 
> Test is changed to do following:
> 1. parent will fork a child and wait
> 2. just before child calls pause() it signals parent
> 3. parent calls tst_process_state_wait() to wait until
>    child process falls asleep (on pause() call)
> 4. parent sends signal to child
> 5. child checks that pause() exited with EINTR
> 
> Reported-by: Yury Norov <ynorov@caviumnetworks.com>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  testcases/kernel/syscalls/pause/pause01.c | 132 +++++++++++++-----------------
>  1 file changed, 56 insertions(+), 76 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/pause/pause01.c b/testcases/kernel/syscalls/pause/pause01.c
> index c967d8ec4f6a..091860830696 100644
> --- a/testcases/kernel/syscalls/pause/pause01.c
> +++ b/testcases/kernel/syscalls/pause/pause01.c
> @@ -1,95 +1,75 @@
>  /*
> - * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
> - *    AUTHOR		: William Roske
> - *    CO-PILOT		: Dave Fenner
> + * Copyright (c) 2016 Linux Test Project
>   *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
>   *
> - * This program is distributed in the hope that it would be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> + * This program is distributed in the hope that it would be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
>   *
> - * Further, this software is distributed without any warranty that it is
> - * free of the rightful claim of any third person regarding infringement
> - * or the like.  Any license provided herein, whether implied or
> - * otherwise, applies only to this software file.  Patent licenses, if
> - * any, provided herein do not apply to combinations of this program with
> - * other software, or any other product whatsoever.
> - *
> - * You should have received a copy of the GNU General Public License along
> - * with this program; if not, write the Free Software Foundation, Inc.,
> - * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> - *
> - * Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
> - * Mountain View, CA  94043, or:
> - *
> - * http://www.sgi.com
> - *
> - * For further information regarding this notice, see:
> - *
> - * http://oss.sgi.com/projects/GenInfo/NoticeExplan/
> - */
> -/*
> - * Setup alarm() signal, wait in pause() expect to be woken up.
> + * Check that pause() returns on signal with errno == EINTR.
>   */
>  #include <errno.h>
>  #include <signal.h>
> -#include "test.h"
> +#include <stdlib.h>
> +#include "tst_test.h"
>  
> -char *TCID = "pause01";
> -int TST_TOTAL = 1;
> -
> -static void setup(void);
> -
> -int main(int ac, char **av)
> +static void sig_handler(int sig LTP_ATTRIBUTE_UNUSED)
>  {
> -	int lc;
> -	struct itimerval it = {
> -		.it_interval = {.tv_sec = 0, .tv_usec = 0},
> -		.it_value = {.tv_sec = 0, .tv_usec = 1000},
> -	};
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> +}
>  
> -	setup();
> +static void do_child(void)
> +{
> +	if (signal(SIGINT, sig_handler) == SIG_ERR)
> +		tst_brk(TBROK | TERRNO, "signal");

We should probably add SAFE_SIGNAL() to the newlib.

> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		tst_count = 0;
> +	TST_CHECKPOINT_WAKE(0);
>  
> -		if (setitimer(ITIMER_REAL, &it, NULL))
> -			tst_brkm(TBROK | TERRNO, NULL, "setitimer() failed");
> +	TEST(pause());
> +	if (TEST_RETURN != -1)
> +		tst_res(TFAIL, "pause() succeeded unexpectedly");
> +	else if (TEST_ERRNO == EINTR)
> +		tst_res(TPASS, "pause() interrupted with EINTR");
> +	else
> +		tst_res(TFAIL | TTERRNO, "pause() unexpected errno");
>  
> -		TEST(pause());
> +	TST_CHECKPOINT_WAKE(0);
> +	exit(0);
> +}
>  
> -		if (TEST_RETURN != -1) {
> -			tst_resm(TFAIL,
> -				 "pause() returned WITHOUT an error return code : %d",
> -				 TEST_ERRNO);
> -		} else {
> -			if (TEST_ERRNO == EINTR)
> -				tst_resm(TPASS, "pause() returned %ld",
> -					 TEST_RETURN);
> -			else
> -				tst_resm(TFAIL,
> -					 "pause() returned %ld. Expected %d (EINTR)",
> -					 TEST_RETURN, EINTR);
> -		}
> +static void do_test(void)
> +{
> +	int pid, status;
> +
> +	pid = SAFE_FORK();
> +	switch (pid) {
> +	case 0:
> +		do_child();
> +		break;
> +	case -1:
> +		tst_brk(TBROK | TERRNO, "fork() failed");
> +		break;
>  	}

Unlike tst_fork() SAFE_FORK() cannot fail, it call tst_brk() in case of
failure in the test library.

> -	tst_exit();
> -}
> +	TST_CHECKPOINT_WAIT(0);
> +	TST_PROCESS_STATE_WAIT(pid, 'S');
> +	kill(pid, SIGINT);
>  
> -static void go(int sig)
> -{
> -	(void)sig;
> +	/*
> +	 * TST_CHECKPOINT_WAIT has built-in timeout, if pause() doesn't return,
> +	 * this checkpoint call will reliably end the test.
> +	 */
> +	TST_CHECKPOINT_WAIT(0);
> +	SAFE_WAIT(&status);

Hmm, maybe it would be better if we add timeout logic to the new test
library instead of adding it to selected few testcases.

>  }
>  
> -void setup(void)
> -{
> -	tst_sig(NOFORK, DEF_HANDLER, NULL);
> -	(void)signal(SIGALRM, go);
> -
> -	TEST_PAUSE;
> -}
> +static struct tst_test test = {
> +	.tid = "pause01",
> +	.forks_child = 1,
> +	.needs_checkpoints = 1,
> +	.test_all = do_test,
> +};

Otherwise it looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
