From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 18 Jun 2021 13:46:23 +0200
Subject: [LTP] [PATCH 1/3 v2] lib: tst_process_state: Use SPDX and
 format alignment
In-Reply-To: <20210617105556.130869-2-xieziyao@huawei.com>
References: <20210617105556.130869-1-xieziyao@huawei.com>
 <20210617105556.130869-2-xieziyao@huawei.com>
Message-ID: <YMyHj8em7HRG8XrS@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> ---
> v1->v2:
> 1. Move changes in license and whitespaces to a separate patch.
> 
>  include/tst_process_state.h | 23 +++++++++--------------
>  lib/tst_process_state.c     | 31 +++++++------------------------
>  2 files changed, 16 insertions(+), 38 deletions(-)
> 
> diff --git a/include/tst_process_state.h b/include/tst_process_state.h
> index c32aa58e6..32eaf46d9 100644
> --- a/include/tst_process_state.h
> +++ b/include/tst_process_state.h
> @@ -2,13 +2,10 @@
>   * Copyright (C) 2012-2014 Cyril Hrubis chrubis@suse.cz
>   */
> 
> - /*
> -
> -   These functions helps you wait till a process with given pid changes state.
> -   This is for example useful when you need to wait in parent until child
> -   blocks.
> -
> -  */
> +/*
> + * These functions helps you wait till a process with given pid changes state.
> + * This is for example useful when you need to wait in parent until child blocks.
> + */
> 
>  #ifndef TST_PROCESS_STATE__
>  #define TST_PROCESS_STATE__
> @@ -29,8 +26,7 @@
>  #ifdef TST_TEST_H__
> 
>  #define TST_PROCESS_STATE_WAIT(pid, state, msec_timeout) \
> -	tst_process_state_wait(__FILE__, __LINE__, NULL, \
> -	                       (pid), (state), (msec_timeout))
> +	tst_process_state_wait(__FILE__, __LINE__, NULL, (pid), (state), (msec_timeout))

This actually creates a line over 80 chars, so I guess that the proper
fix would be keeping the pid, state and timeout on a separate line but
using tabs instead of spaces for indentation.

>  #else
>  /*
>   * The same as above but does not use tst_brkm() interface.
> @@ -41,13 +37,12 @@
>   */
>  int tst_process_state_wait2(pid_t pid, const char state);
> 
> -# define TST_PROCESS_STATE_WAIT(cleanup_fn, pid, state) \
> -	 tst_process_state_wait(__FILE__, __LINE__, (cleanup_fn), \
> -	                        (pid), (state), 0)
> +#define TST_PROCESS_STATE_WAIT(cleanup_fn, pid, state) \
> +	tst_process_state_wait(__FILE__, __LINE__, (cleanup_fn), (pid), (state), 0)

And here as well.


Apart from these two minor issues the rest looks fine.

-- 
Cyril Hrubis
chrubis@suse.cz
