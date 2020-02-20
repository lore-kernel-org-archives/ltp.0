From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 20 Feb 2020 13:48:21 +0100
Subject: [LTP] [PATCH v2] syscalls/quotactl07: add regresstion test for
 Q_XQTUOTARM
In-Reply-To: <1575526664-25738-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1575526664-25738-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20200220124821.GB11142@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> This is a regresstion test to check Q_XQUOTARM  whether has
> quota flags check.
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> 
> ---------------------
> 1.Simplify test code
> 2.add comment for invalid_type,
> ---------------------
  ^
  Btw this belongs under the three dashes below, otherwise it ends up in
  the commit message when applied.

...

> +static void setup(void)
> +{
> +	TEST(quotactl(QCMD(Q_XQUOTAOFF, USRQUOTA), tst_device->dev, 0, (void *)&qflag_acct));
> +	if (TST_RET == -1)
> +		tst_brk(TBROK | TTERRNO, "quotactl with Q_XQUOTAOFF failed");
> +
> +	TEST(quotactl(QCMD(Q_XQUOTARM, USRQUOTA), tst_device->dev, 0, (void *)&valid_type));
> +	if (TST_ERR == EINVAL) {
> +		tst_res(TCONF, "current system doesn't support Q_XQUOTARM, skip it");
> +		return;

I've changed this to tst_brk() because doing return from setup has no
efect here, and pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
