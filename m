From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 9 Oct 2019 16:36:35 +0200
Subject: [LTP] [RFC PATCH v4 3/5] shell: Add timeout shell API tests
In-Reply-To: <20190930145916.20465-4-pvorel@suse.cz>
References: <20190930145916.20465-1-pvorel@suse.cz>
 <20190930145916.20465-4-pvorel@suse.cz>
Message-ID: <20191009143635.GF7561@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +DATA="
> +timeout01.sh||0
> +timeout02.sh||0
> +timeout02.sh|foo|32
> +timeout02.sh|2|0
> +timeout02.sh|1.1|0
> +timeout02.sh|-10|32
> +"
> +
> +echo "Testing timeout in shell API"
> +echo
> +
> +failed=0
> +IFS="
> +"

Do we have to change IFS here? It should be set to space, tab, and
newline by default, so the loop over $DATA should work correctly
anyways.

> +for i in $DATA; do
> +	file=$(echo $i | cut -d'|' -f1)
> +	timeout=$(echo $i | cut -d'|' -f2)
> +	exp_exit=$(echo $i | cut -d'|' -f3)
> +
> +	echo "=== $test (LTP_TIMEOUT_MUL='$timeout') ==="
> +	LTP_TIMEOUT_MUL=$timeout ./$file
> +	ret=$?
> +	if [ $ret -ne $exp_exit ]; then
> +		echo "FAILED (exit code: $ret, expected $exp_exit)"
> +		failed=$((failed+1))
> +	else
> +		echo "PASSED"
> +	fi
> +	echo
> +done
> +
> +echo "Failed tests: $failed"
> +exit $failed
> diff --git a/lib/newlib_tests/shell/timeout01.sh b/lib/newlib_tests/shell/timeout01.sh
> new file mode 100755
> index 000000000..ab7428a2d
> --- /dev/null
> +++ b/lib/newlib_tests/shell/timeout01.sh
> @@ -0,0 +1,13 @@
> +#!/bin/sh
> +
> +TST_TESTFUNC=do_test
> +
> +TST_TIMEOUT=-1
> +. tst_test.sh
> +
> +do_test()
> +{
> +	tst_res TPASS "timeout $TST_TIMEOUT set"
> +}
> +
> +tst_run
> diff --git a/lib/newlib_tests/shell/timeout02.sh b/lib/newlib_tests/shell/timeout02.sh
> new file mode 100755
> index 000000000..73af09125
> --- /dev/null
> +++ b/lib/newlib_tests/shell/timeout02.sh
> @@ -0,0 +1,13 @@
> +#!/bin/sh
> +
> +TST_TESTFUNC=do_test
> +
> +TST_TIMEOUT=2
> +. tst_test.sh
> +
> +do_test()
> +{
> +	tst_res TPASS "timeout $TST_TIMEOUT set (LTP_TIMEOUT_MUL='$LTP_TIMEOUT_MUL')"
> +}
> +
> +tst_run
> -- 
> 2.23.0
> 

-- 
Cyril Hrubis
chrubis@suse.cz
