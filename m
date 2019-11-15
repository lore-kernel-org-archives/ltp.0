From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 15 Nov 2019 16:51:23 +0100
Subject: [LTP] [PATCH v3 1/5] syscalls/quotactl01.c: Add Q_GETNEXQUOTA
 test
In-Reply-To: <1572612959-20577-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <20191031152646.GA7078@dell5510>
 <1572612959-20577-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1572612959-20577-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20191115155123.GA658@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> Q_GETNEXTQUOTA was introduced since linux 4.6, this operation is the
> same as Q_GETQUOTA, but it returns quota information for the next ID
> greater than or equal to id that has a quota set.

> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
LGTM, minor note below.

> diff --git a/include/lapi/quotactl.h b/include/lapi/quotactl.h
...
>  #ifndef LAPI_QUOTACTL_H__
>  # define LAPI_QUOTACTL_H__

> +#ifdef HAVE_STRUCT_IF_NEXTDQBLK
> +# include <linux/quota.h>
You test <linux/quota.h> in LTP_CHECK_SYSCALL_QUOTACTL (indirectly via AC_CHECK_TYPES, but that should be ok)
> +#endif
> +#include <sys/quota.h>
> +

...
> @@ -155,8 +177,15 @@ static void verify_quota(unsigned int n)
>  	res_dq.dqb_bsoftlimit = 0;
>  	res_qf.dqi_igrace = 0;
>  	fmt_buf = 0;
> +#if defined(HAVE_STRUCT_IF_NEXTDQBLK)
> +	res_ndq.dqb_id = -1;
> +#endif

>  	TEST(quotactl(tc->cmd, tst_device->dev, *tc->id, tc->addr));
> +	if (TST_ERR == EINVAL) {
> +		tst_res(TCONF, "Current system doesn't support this cmd");
nit: cmd? Maybe something like "quotactl() syscall does not support this command"
or "quotactl() syscall does not support to %s", tc->des
to follow other messages. I'd actually prefer to have some macro, which prints
QCMD flags, but that's a detail which we can ignore.

> +		return;
> +	}
>  	if (TST_RET == -1) {
>  		tst_res(TFAIL | TTERRNO, "quotactl failed to %s", tc->des);
>  		return;

Kind regards,
Petr
