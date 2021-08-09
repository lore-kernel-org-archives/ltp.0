From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 9 Aug 2021 14:21:39 +0200
Subject: [LTP] [PATCH v2 13/16] syscalls/sched_setscheduler02: convert
 to new API
In-Reply-To: <20210806164730.51040-14-aleksei.kodanev@bell-sw.com>
References: <20210806164730.51040-1-aleksei.kodanev@bell-sw.com>
 <20210806164730.51040-14-aleksei.kodanev@bell-sw.com>
Message-ID: <YREd08mkfysYkjzZ@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  #define SCHED_INVALID	99
>  #define INVALID_PID	999999

I guess that we should remove these two unused macros as well.

> +	if (!pid) {
> +		struct sched_param p = { .sched_priority = 1 };
> +
> +		SAFE_SETEUID(nobody_uid);
> +		TST_EXP_FAIL(tv->sched_setscheduler(0, SCHED_FIFO, &p), EPERM,
> +			     "sched_setscheduler(0, SCHED_FIFO, %d)",
> +			     p.sched_priority);
> +		SAFE_SETEUID(0);

And we do not have to reset the UID before we call exit(0)

> +		exit(0);
> +	}
> +	tst_reap_children();
>  }

Other than that:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz
