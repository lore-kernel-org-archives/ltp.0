From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 17 Oct 2019 11:00:44 +0200
Subject: [LTP] [PATCH v3 4/4] Add newlib shell test for
 tst_multiply_timeout()
In-Reply-To: <20191016161519.11256-4-cfamullaconrad@suse.de>
References: <1571225126.8494.1.camel@suse.de>
 <20191016161519.11256-1-cfamullaconrad@suse.de>
 <20191016161519.11256-4-cfamullaconrad@suse.de>
Message-ID: <20191017090043.GB14386@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Clemens,

> Simple test for different kinds of calls from tst_multiply_timeout()
> ---
>  lib/newlib_tests/shell/test_timeout_mul.sh | 54 ++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100755 lib/newlib_tests/shell/test_timeout_mul.sh

> diff --git a/lib/newlib_tests/shell/test_timeout_mul.sh b/lib/newlib_tests/shell/test_timeout_mul.sh
> new file mode 100755
> index 000000000..8397df25c
> --- /dev/null
> +++ b/lib/newlib_tests/shell/test_timeout_mul.sh
> @@ -0,0 +1,54 @@
> +#!/bin/bash
This is library test, which will run on developer box, where bash is for sure.
But I'd still prefer to have /bin/sh with posix shell syntax.
Mainly because if you have /bin/bash in sources people will write tests with
bashisms (even if you document that bash is only allowed for these library
tests).

But we should have a discussion on that and document it ([1]).

> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2019 Clemens Famulla-Conrad <cfamullaconrad@suse.de>
> +
> +TST_TESTFUNC=do_test
> +. tst_test.sh
This expect PATH to be set correctly. Which is probably better approach, than
mine (I put PATH for tst_test.sh into
lib/newlib_tests/shell/test_timeout_mul.sh; best would be to have 'make check',
which would set it; my patch [2] does not set it).
> +
> +
> +call_it()
> +{
> +	local SAVE_MUL=${LTP_TIMEOUT_MUL}
> +	$1
> +	if [ "${!2}" -ne "$3" ]; then
> +		tst_brk TBROK "LTP_TIMEOUT_MUL=$SAVE_MUL $1 (${!2} != $3)"
> +	else
> +		tst_res TPASS "LTP_TIMEOUT_MUL=$SAVE_MUL $1 (${!2} == $3)"
> +	fi
> +}
> +
> +do_test()
> +{
> +	LTP_TIMEOUT_MUL=2
> +	local sec=1
> +
> +        call_it 'tst_multiply_timeout sec' 'sec' 2
> +        call_it 'tst_multiply_timeout foo 1000' 'foo' 2000
> +
> +	sec=1
You mix tabs and spaces.

> +        call_it 'tst_multiply_timeout sec 500' 'sec' 1000
> +
> +	sec=1
> +	LTP_TIMEOUT_MUL="1.5"
> +        call_it 'tst_multiply_timeout sec' 'sec' 2
> +
> +	sec=1
> +	LTP_TIMEOUT_MUL=0.5
> +        call_it 'tst_multiply_timeout sec' 'sec' 1
> +
> +	sec=1
> +	LTP_TIMEOUT_MUL=1.5
> +        call_it 'tst_multiply_timeout sec 5' 'sec' 10
> +
> +	sec=1
> +	LTP_TIMEOUT_MUL=0.5
> +        call_it 'tst_multiply_timeout sec 5' 'sec' 5
> +
> +	sec=1
> +	LTP_TIMEOUT_MUL=2
> +        call_it 'tst_multiply_timeout sec' 'sec' 2
> +        call_it 'tst_multiply_timeout sec' 'sec' 4
> +        call_it 'tst_multiply_timeout sec' 'sec' 8
> +}
> +
> +tst_run;
Unnecessary ;

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/patch/1166786/
[2] https://patchwork.ozlabs.org/patch/1166785/
