From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 30 Jul 2019 13:21:20 +0200
Subject: [LTP] [PATCH 1/2] syscalls/nanosleep03: remove duplicated
 nanosleep03
In-Reply-To: <1564363652-3975-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1564363652-3975-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20190730112120.GA10214@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/testcases/kernel/syscalls/nanosleep/nanosleep01.c b/testcases/kernel/syscalls/nanosleep/nanosleep01.c
> index 96e1cf1b4..418f86565 100644
> --- a/testcases/kernel/syscalls/nanosleep/nanosleep01.c
> +++ b/testcases/kernel/syscalls/nanosleep/nanosleep01.c
> @@ -1,21 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0-or-lat
                                             ^
					   later
>  /*
>   * Copyright (c) International Business Machines  Corp., 2001
>   *  07/2001 Ported by Wayne Boyer
>   * Copyright (C) 2015-2017 Cyril Hrubis <chrubis@suse.cz>
> - *
> - * This program is free software;  you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY;  without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> - * the GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program;  if not, write to the Free Software Foundation,
> - * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
>   */
>  
>  /*
> @@ -25,7 +12,6 @@
>   */
>  
>  #include <errno.h>
> -
>  #include "tst_timer_test.h"
>  
>  int sample_fn(int clk_id, long long usec)
> diff --git a/testcases/kernel/syscalls/nanosleep/nanosleep02.c b/testcases/kernel/syscalls/nanosleep/nanosleep02.c
> index 8bd2c44c4..20a93d3b6 100644
> --- a/testcases/kernel/syscalls/nanosleep/nanosleep02.c
> +++ b/testcases/kernel/syscalls/nanosleep/nanosleep02.c
> @@ -10,6 +10,9 @@
>   *  Verify that nanosleep() will be successful to suspend the execution
>   *  of a process, returns after the receipt of a signal and writes the
>   *  remaining sleep time into the structure.
> + *
> + *  This test also verifies that if the call is interrupted by a signal
> + *  handler, nanosleep() returns -1, sets errno to EINTR.
>   */
>  
>  #include <errno.h>
> @@ -39,11 +42,13 @@ static void do_child(void)
>  	TEST(nanosleep(&timereq, &timerem));
>  	tst_timer_stop();
>  
> -	if (!TST_RET)
> +	if (TST_RET != -1)
>  		tst_brk(TBROK, "nanosleep was not interrupted");

We should probably print the TST_RET after this change.

>  	if (TST_ERR != EINTR)
>  		tst_brk(TBROK | TTERRNO, "nanosleep() failed");

And I guess that we should change these two messages to tst_res(TFAIL,
followed by return;

> +	tst_res(TPASS, "nanosleep() returned -1, set errno to EINTER");
> +
>  	if (tst_timespec_lt(timereq, tst_timer_elapsed()))
>  		tst_brk(TFAIL, "nanosleep() slept more than timereq");
>  

Other than these minor issues the patch is OK.

-- 
Cyril Hrubis
chrubis@suse.cz
