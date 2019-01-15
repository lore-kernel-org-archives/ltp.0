From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 15 Jan 2019 16:07:59 +0100
Subject: [LTP] [PATCH 6/6] ima/ima_violations: Temporarily remove the
 printk rate limit
In-Reply-To: <1547518476-34008-7-git-send-email-zhang.jia@linux.alibaba.com>
References: <1547518476-34008-1-git-send-email-zhang.jia@linux.alibaba.com>
 <1547518476-34008-7-git-send-email-zhang.jia@linux.alibaba.com>
Message-ID: <20190115150759.GA2954@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jia, Mimi,

...
> +reset_printk_ratelimit()
> +{
> +	[ "$PRINTK_RATE_LIMIT" != "0" ] && \
> +		sysctl -wq kernel.printk_ratelimit=$PRINTK_RATE_LIMIT
> +}
...
> @@ -151,6 +163,8 @@ test3()

>  	validate $num_violations $count $search

> +	reset_printk_ratelimit
This should be called in cleanup function.
Actually as it's called only once I'd put it into cleanup function.
No need to resent the patchset, if it's the only change, I change it before
merge.

@Mimi: do you agree with this change?
I've seen some issues on some distros when not using auditd daemon,
but now cannot reproduce them any more.

Kind regards,
Petr
