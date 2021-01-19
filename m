From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 19 Jan 2021 12:01:35 +0100
Subject: [LTP] [PATCH] fs/lftest: Convert to new library
In-Reply-To: <20201215092534.757347-1-lkml@jv-coder.de>
References: <20201215092534.757347-1-lkml@jv-coder.de>
Message-ID: <YAa8D8iQwaQr2tAm@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Joerg,

> Additonal changes:
>  - Use temp directory instead of working dir
>  - 100 buffers is teh default  now and can be changed using -n
>  - Removed some useless output (nseek, nwrite was always bufnum)

Reviewed-by: Petr Vorel <pvorel@suse.cz>

LGTM, going to merge it after Jan 2021 release.

Below are 2 tiny details I'll fix during merge.

...
> +++ b/runtest/fs
> @@ -58,7 +58,7 @@ ftest06 ftest06
>  ftest07 ftest07
>  ftest08 ftest08

> -lftest01	lftest 100
> +lftest01	lftest

Not sure if anybody uses runtest/fs_readonly, but we still haven't removed it.
Thus it must be also updated:

-test_robind54 test_robind.sh -c "lftest 80"
+test_robind54 test_robind.sh -c "lftest"

...
> +++ b/testcases/kernel/fs/lftest/lftest.c
...
> +	if (str_bufnum) {
> +		if (tst_parse_int(str_bufnum ,&bufnum, 0, INT_MAX)) {
nit: formatting:
		if (tst_parse_int(str_bufnum, &bufnum, 0, INT_MAX)) {

> +			tst_brk(TBROK, "Invalid buffer count '%s'", str_bufnum);
> +		}

Kind regards,
Petr
