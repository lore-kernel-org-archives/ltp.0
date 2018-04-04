From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 4 Apr 2018 15:08:06 +0200
Subject: [LTP] [RFC PATCH v3 2/5] tst_test.sh: Introduce
	TST_NO_DEFAULT_RUN
In-Reply-To: <20180403154717.22491-3-pvorel@suse.cz>
References: <20180403154717.22491-1-pvorel@suse.cz>
 <20180403154717.22491-3-pvorel@suse.cz>
Message-ID: <20180404130806.GG32109@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> TST_NO_DEFAULT_RUN is somehow similar to TST_NO_DEFAULT_MAIN. It's meant
> to be used for libraries and tools using tst_test.sh. It helps to use
> part of test framework functionality without wanting to run test.
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/lib/tst_test.sh | 100 +++++++++++++++++++++++-----------------------
>  1 file changed, 51 insertions(+), 49 deletions(-)
> 
> diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
> index 78bd328a2..7cdaa1f7f 100644
> --- a/testcases/lib/tst_test.sh
> +++ b/testcases/lib/tst_test.sh
> @@ -1,6 +1,6 @@
>  #!/bin/sh
>  #
> -# Copyright (c) Linux Test Project, 2014-2017
> +# Copyright (c) Linux Test Project, 2014-2018
>  #
>  # This program is free software; you can redistribute it and/or modify
>  # it under the terms of the GNU General Public License as published by
> @@ -371,67 +371,69 @@ tst_run()
>  	tst_do_exit
>  }
>  
> -if TST_TEST_PATH=$(which $0) 2>/dev/null; then
> -	if ! grep -q tst_run "$TST_TEST_PATH"; then
> -		tst_brk TBROK "Test $0 must call tst_run!"
> +if [ -z "$TST_NO_DEFAULT_RUN" ]; then
> +	if TST_TEST_PATH=$(which $0) 2>/dev/null; then
> +		if ! grep -q tst_run "$TST_TEST_PATH"; then
> +			tst_brk TBROK "Test $0 must call tst_run!"
> +		fi
>  	fi
> -fi
> -
> -if [ -z "$TST_ID" ]; then
> -	filename=$(basename $0)
> -	TST_ID=${filename%%.*}
> -fi
> -export TST_ID="$TST_ID"
> -
> -if [ -z "$TST_TESTFUNC" ]; then
> -	tst_brk TBROK "TST_TESTFUNC is not defined"
> -fi
>  
> -if [ -n "$TST_CNT" ]; then
> -	if ! tst_is_int "$TST_CNT"; then
> -		tst_brk TBROK "TST_CNT must be integer"
> +	if [ -z "$TST_ID" ]; then
> +		filename=$(basename $0)
> +		TST_ID=${filename%%.*}
>  	fi
> +	export TST_ID="$TST_ID"
>  
> -	if [ "$TST_CNT" -le 0 ]; then
> -		tst_brk TBROK "TST_CNT must be > 0"
> +	if [ -z "$TST_TESTFUNC" ]; then
> +		tst_brk TBROK "TST_TESTFUNC is not defined"
>  	fi
> -fi
>  
> -if [ -n "$TST_POS_ARGS" ]; then
> -	if ! tst_is_int "$TST_POS_ARGS"; then
> -		tst_brk TBROK "TST_POS_ARGS must be integer"
> +	if [ -n "$TST_CNT" ]; then
> +		if ! tst_is_int "$TST_CNT"; then
> +			tst_brk TBROK "TST_CNT must be integer"
> +		fi
> +
> +		if [ "$TST_CNT" -le 0 ]; then
> +			tst_brk TBROK "TST_CNT must be > 0"
> +		fi
>  	fi
>  
> -	if [ "$TST_POS_ARGS" -le 0 ]; then
> -		tst_brk TBROK "TST_POS_ARGS must be > 0"
> +	if [ -n "$TST_POS_ARGS" ]; then
> +		if ! tst_is_int "$TST_POS_ARGS"; then
> +			tst_brk TBROK "TST_POS_ARGS must be integer"
> +		fi
> +
> +		if [ "$TST_POS_ARGS" -le 0 ]; then
> +			tst_brk TBROK "TST_POS_ARGS must be > 0"
> +		fi
>  	fi
> -fi
>  
> -if [ -z "$LTPROOT" ]; then
> -	export LTPROOT="$PWD"
> -	export TST_DATAROOT="$LTPROOT/datafiles"
> -else
> -	export TST_DATAROOT="$LTPROOT/testcases/data/$TST_ID"
> -fi
> +	if [ -z "$LTPROOT" ]; then
> +		export LTPROOT="$PWD"
> +		export TST_DATAROOT="$LTPROOT/datafiles"
> +	else
> +		export TST_DATAROOT="$LTPROOT/testcases/data/$TST_ID"
> +	fi

I guess that we may want to initialize the TST_ID, LTPROOT and
TST_DATAROOT regardless, otherwise this looks pretty much
straighforward and okay.

-- 
Cyril Hrubis
chrubis@suse.cz
