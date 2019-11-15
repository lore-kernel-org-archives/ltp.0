From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 15 Nov 2019 18:41:10 +0100
Subject: [LTP] [PATCH v3 2/5] syscalls/quotactl02.c: Add Q_XGETQSTATV
 test
In-Reply-To: <1572612959-20577-3-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <20191031152646.GA7078@dell5510>
 <1572612959-20577-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1572612959-20577-3-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20191115174110.GB22234@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xu,

> Q_XGETQSTATV returns XFS filesystem-specific quota information in the fs_quota_statv
> pointed to by addr. The qs_version field of the structure should be filled with
> the version of the structure supported by the caller (for now, only FS_QSTAT_VERSION1
> is supported).
nit: one would think you add 1 test case. But you added 8 test cases, all of
them are XFS related, but only 4 related to Q_XGETQSTATV.

> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Nice work, thanks!

Nit: I'd just extract quotactl02.h later in the commit, where
the code needs to be reused (i.e. in 0cc1dc512 ("syscalls/quotactl05: add
project quota test for xfs filesystem")) or at least mention why you do it now.

...
> +++ b/testcases/kernel/syscalls/quotactl/quotactl02.c
...
> +#if defined(HAVE_STRUCT_FS_QUOTA_STATV)
> +	{QCMD(Q_XQUOTAOFF, GRPQUOTA), &qflagg, check_qoffv,
> +	QCMD(Q_XGETQSTATV, GRPQUOTA), 1,
> +	"turn off xfs quota and get xfs quota off statv for group"},

> -	tst_res(TPASS, "quoactl() succeeded to set and use %s to get xfs disk quota limits",
> -			desp);
> -}
> +	{QCMD(Q_XQUOTAON, GRPQUOTA), &qflagg, check_qonv,
> +	QCMD(Q_XGETQSTATV, GRPQUOTA), 1,
> +	"turn on xfs quota and get xfs quota on statv for group"},
> +#endif
> +};
Hm, we don't report some TCONF: Q_XGETQSTATV not supported.
But that's probably not important.

...

Kind regards,
Petr
