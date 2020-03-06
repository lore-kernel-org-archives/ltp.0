From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 6 Mar 2020 14:20:11 +0100
Subject: [LTP] [PATCH v3] pty: Test data transmission with SLIP line
 discipline
In-Reply-To: <20200306120021.19997-1-rpalethorpe@suse.com>
References: <20200306120021.19997-1-rpalethorpe@suse.com>
Message-ID: <20200306132011.GA25572@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richard,

...
> +static int set_ldisc(int tty, struct ldisc_info *ldisc)
> +{
> +	TEST(ioctl(tty, TIOCSETD, &ldisc->n));
> +
> +	if (!TST_RET)
> +		return 0;
> +
> +	if (TST_ERR == EINVAL) {
> +		tst_res(TCONF | TTERRNO,
> +			"You don't appear to have the %s TTY line discipline",
> +			ldisc->name);
> +	} else {
> +		tst_res(TBROK | TTERRNO,
This must be TFAIL now.
This can be done by person who merges this patch.

BTW as the same function (with corrected TBROK) is
already in pty03.c (although struct ldisc_info is different).

Kind regards,
Petr
