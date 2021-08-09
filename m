From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 9 Aug 2021 14:35:50 +0200
Subject: [LTP] [PATCH v2 14/16] syscalls/sched_setscheduler03: use
 libc/sys_sched_*()
In-Reply-To: <20210806164730.51040-15-aleksei.kodanev@bell-sw.com>
References: <20210806164730.51040-1-aleksei.kodanev@bell-sw.com>
 <20210806164730.51040-15-aleksei.kodanev@bell-sw.com>
Message-ID: <YREhJlJIy1tYXNKp@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  	tst_res(TINFO, "Setting init sched policy to SCHED_OTHER");
> -	if (sched_setscheduler(0, SCHED_OTHER, &param[0]) != 0)
> -		tst_res(TFAIL | TERRNO,
> -			 "ERROR sched_setscheduler: (0, SCHED_OTHER, param)");
> -
> -	if (sched_getscheduler(0) != SCHED_OTHER)
> +	TST_EXP_PASS_SILENT(tv->sched_setscheduler(0, SCHED_OTHER, &param[0]),
> +			    "sched_setscheduler(0, SCHED_OTHER, 0)");

Here as well, we shouldn't use TST_EXP_PASS* in the test setup().

Other than that:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz
