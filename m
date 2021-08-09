From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 9 Aug 2021 14:19:01 +0200
Subject: [LTP] [PATCH v2 12/16] syscalls/sched_setscheduler01: convert
 to new API
In-Reply-To: <20210806164730.51040-13-aleksei.kodanev@bell-sw.com>
References: <20210806164730.51040-1-aleksei.kodanev@bell-sw.com>
 <20210806164730.51040-13-aleksei.kodanev@bell-sw.com>
Message-ID: <YREdNTHNjAiU6C1a@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> + * [Algorithm]
>   *
> - * USAGE:  <for command-line>
> - *  sched_setscheduler01 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
> - *     where,  -c n : Run n copies concurrently.
> - *             -e   : Turn on errno logging.
> - *             -i n : Execute test n times.
> - *             -I x : Execute test for x seconds.
> - *             -P x : Pause for x seconds between iterations.
> - *             -t   : Turn on syscall timing.
> - *
> - * HISTORY
> - *	07/2001 Ported by Wayne Boyer
> - *
> - * RESTRICTIONS
> - *	None
> + * 1. Call sched_setscheduler with an invalid pid, and expect
> + * ESRCH to be returned.
> + * 2. Call sched_setscheduler with an invalid scheduling policy,
> + * and expect EINVAL to be returned.
> + * 3. Call sched_setscheduler with an invalid "param" address,
> + * which lies outside the address space of the process, and expect
> + * EFAULT to be returned.
> + * 4.Call sched_setscheduler with an invalid priority value
> + * in "param" and expect EINVAL to be returned
>   */

Can we have this reformatted so that it renders as a nice list in
asciidoc as well?

Other than this:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz
