From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 9 Aug 2021 13:31:00 +0200
Subject: [LTP] [PATCH v2 07/16] syscalls/sched_setparam04: convert to
 new API
In-Reply-To: <20210806164730.51040-8-aleksei.kodanev@bell-sw.com>
References: <20210806164730.51040-1-aleksei.kodanev@bell-sw.com>
 <20210806164730.51040-8-aleksei.kodanev@bell-sw.com>
Message-ID: <YRER9Pjz3Aoc5Wgk@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +/*\
> + * [Description]
>   *
> - *    SIGNALS
> - *      Uses SIGUSR1 to pause before test if option set.
> - *      (See the parse_opts(3) man page).
> + * Testing error conditions for sched_setparam(2)
>   *
>   * DESCRIPTION

We should remove this DESCRIPTION as it's redundant.

>   * 	Verify that,
> @@ -41,129 +21,54 @@
>   *   4) sched_setparam(2) returns -1 sets errno to EINVAL if the
>   *	value for p.sched_priority is other than 0 for scheduling
>   *	policy, SCHED_OTHER

And reformat this part so that it renders as a list in ascii-doc please.

For the rest:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz
