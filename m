From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 31 Oct 2016 14:25:36 +0100
Subject: [LTP] [PATCH] syscalls/quotactl02.c: Reconstruct and Convert to
	new API
In-Reply-To: <1477913601-21745-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20161031101104.GD30590@rei.lan>
 <1477913601-21745-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20161031132536.GA32461@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> -} TC[] = {
> -	{Q_XQUOTAOFF, &qflag, check_qoff, NULL},
> -	{Q_XQUOTAON, &qflag, check_qon, NULL},
> -	{Q_XGETQUOTA, &dquota, check_getq, NULL},
> -	{Q_XSETQLIM, &dquota, check_setqlim, setup_setqlim},
> -	{Q_XGETQSTAT, &qstat, check_getqstat, NULL},
> +	void (*func_check)();
> +	char *des;
> +} tcases[] = {
> +	{QCMD(Q_XQUOTAOFF, USRQUOTA), &test_id, &qflag, NULL,
> +	"turn off xfs quota"},
> +	{QCMD(Q_XGETQSTAT, USRQUOTA), &test_id, &res_qstat, check_qoff,
> +	"get xfs quota off status"},
> +	{QCMD(Q_XQUOTAON, USRQUOTA), &test_id, &qflag, NULL,
> +	"turn on xfs quota"},
> +	{QCMD(Q_XGETQSTAT, USRQUOTA), &test_id, &res_qstat, check_qon,
> +	"get xfs quota on status"},
> +	{QCMD(Q_XSETQLIM, USRQUOTA), &test_id, &set_dquota, NULL,
> +	"set xfs disk quota limits"},
> +	{QCMD(Q_XGETQUOTA, USRQUOTA), &test_id, &res_dquota, check_getqlim,
> +	"get xfs disk quota limits"}
>  };

Looking at this part there is a problem that these testcases depends on
each other. I.e. that the test to check that quota is turned off needs
to be executed after we run the test to turn the quota off.

Now this will break horribly if we ever add default test options to
select the number of the test to execute. So what about addin the
quotactl() call to the check_{qoff,qon,getqlim} call and rather than
being a separate test add them as a check for the OFF/ON/SET calls?

-- 
Cyril Hrubis
chrubis@suse.cz
