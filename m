From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 3 Mar 2017 10:57:59 +0100
Subject: [LTP] [PATCH v3 3/3] syscalls/getxattr04.c: add new regression
	test
In-Reply-To: <1488507513-30941-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20170302162310.GB8152@rei.lan>
 <1488507513-30941-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20170303095759.GD17012@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +/*
> + * Copyright (c) 2017 Fujitsu Ltd.
> + * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of version 2 of the GNU General Public License as
> + * published by the Free Software Foundation.

Can we please use GPLv2+ (the one with any later clausule)?

> + * This program is distributed in the hope that it would be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> + *
> + * You should have received a copy of the GNU General Public License
> + * alone with this program.
> + *
> + */
> +

...

> +static void loop_getxattr(void)
> +{
> +	int res;
> +
> +	while (!end) {
> +		res = getxattr(TEST_FILE, TRUSTED_SMALL, NULL, 0);
> +		if (res == -1) {
> +			if (errno == ENODATA) {
> +				tst_res(TFAIL, "getxattr() failed to get an "
> +					"existing attribute");
> +			} else {
> +				tst_res(TFAIL | TERRNO,
> +					"getxattr() failed without ENOATTR");
> +			}
> +
> +			exit(0);
> +		}
> +	}
> +
> +	tst_res(TPASS, "getxattr() succeeded to get an existing attribute");
> +	exit(0);
> +}
> +
> +static void verify_getxattr(void)
> +{
> +	pid_t pid;
> +	int n;

We should reset the end variable here, in case that the program is
looping (-i option).


Otherwise it look good.

-- 
Cyril Hrubis
chrubis@suse.cz
