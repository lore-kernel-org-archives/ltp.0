From: Petr Vorel <petr.vorel@gmail.com>
Date: Sat, 20 Jun 2020 11:24:27 +0200
Subject: [LTP] [PATCH v1] Add test case for CVE-2018-11508
In-Reply-To: <20200620063713.5330-1-niravparmar@zilogic.com>
References: <20200620063713.5330-1-niravparmar@zilogic.com>
Message-ID: <20200620092427.GB281578@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Nirav,

thanks for your patch!

...
> + * This proves that there are 4 bytes of info leaked. The bug was fixed in
> + * Kernel Version 4.16.9. Therefore, the below test case will only be
> + * applicable for the kernel version 4.16.9 and above.
This is IMHO wrong. The fix 3a4d44b61625 fixes 3a4d44b61625 ("ntp: Move adjtimex
related compat syscalls to native counterparts"), which was released in
v4.13-rc1.

...
> +static struct tst_test test = {
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.min_kver = "4.16.9",
Thus there should be .min_kver = "4.13",

And most of the tests doesn't have .min_kver anyway, it might be removed
entirely.

> +	.test_all = verify_adjtimex,
> +	.bufs = (struct tst_buffers []) {
> +		{&buf, .size = sizeof(*buf)},
> +		{&tim_save, .size = sizeof(*tim_save)},
> +		{},
> +	},
> +	.tags = (const struct tst_tag[]) {
> +		{"CVE", "2018-11508"},
> +		{"linux-git", "3a4d44b61625"},
> +		{},
> +	}
> +};

Kind regards,
Petr
