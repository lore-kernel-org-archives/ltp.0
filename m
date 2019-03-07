From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 7 Mar 2019 12:55:59 +0100
Subject: [LTP] [PATCH] sysctl01: fix fails on live-patched kernels
In-Reply-To: <20190307094531.21832-1-jbaier@suse.cz>
References: <20190307094531.21832-1-jbaier@suse.cz>
Message-ID: <20190307115559.GB1040@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Version from uname and /proc/sys/kernel/version does not match on
> live-patched kernels (bsc#1100130, poo#38483).

As far as I can tell the bug and progress issue are not accessible to
public, there is no point in including them in the commit message.

It would be better to describe here what causes the difference and how
the difference looks like.

> Adjust the string from uname in such cases.
> 
> Signed-off-by: Jan Baier <jbaier@suse.cz>
> ---
>  testcases/kernel/syscalls/sysctl/sysctl01.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git testcases/kernel/syscalls/sysctl/sysctl01.c testcases/kernel/syscalls/sysctl/sysctl01.c
> index 70905d806..fda29f060 100644
> --- testcases/kernel/syscalls/sysctl/sysctl01.c
> +++ testcases/kernel/syscalls/sysctl/sysctl01.c
> @@ -1,6 +1,7 @@
>  /*
>   * Copyright (c) International Business Machines  Corp., 2001
>   * Copyright (c) 2018 Xiao Yang <yangx.jy@cn.fujitsu.com>
> + * Copyright (c) 2019 SUSE.  All Rights Reserved.
>   *
>   * This program is free software;  you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License as published by
> @@ -77,6 +78,19 @@ static void setup(void)
>  	/* get kernel name and information */
>  	if (uname(&buf) == -1)
>  		tst_brk(TBROK | TERRNO, "uname() failed");
> +
> +	/* revert uname change in case of kGraft/livepatch */
> +	char *klp_tag;
> +	char *right_brace;
> +
> +	klp_tag = strstr(buf.version, "/kGraft-");
> +	if (!klp_tag)
> +		klp_tag = strstr(buf.version, "/lp-");
> +	if (klp_tag) {
> +		right_brace = strchr(klp_tag, ')');
> +		if (right_brace)
> +			strcpy(klp_tag, right_brace);

This is not generally safe, the parameters passed to strcpy() must not
overlap. I guess that the safe option would be copying the content into
a new buffer.

> +	}
>  }
>  
>  static struct tst_test test = {
> -- 
> 2.21.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
