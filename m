From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 17 Oct 2019 11:06:30 +0200
Subject: [LTP] [PATCH] make: Add make check target + run.sh
In-Reply-To: <20190924182841.4528-1-pvorel@suse.cz>
References: <20190924182841.4528-1-pvorel@suse.cz>
Message-ID: <20191017090629.GA17707@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> +check: | $(MAKE_TARGETS)
> +	./run.sh
> diff --git a/lib/newlib_tests/run.sh b/lib/newlib_tests/run.sh
> new file mode 100755
> index 000000000..566454106
> --- /dev/null
> +++ b/lib/newlib_tests/run.sh
> @@ -0,0 +1,17 @@
> +#!/bin/sh

I guess, I should set PATH here to cwd and to testcases/lib/ (remove it from
lib/newlib_tests/shell/test_timeout_mul.sh). Probably some setup.sh loaded by
each test would be good, so all tests gets correct PATH)
> +
> +# blacklist directory content which is not a test
> +FILTER_OUT_FILES="$(basename $0) *.c config[0-9]* Makefile test_kconfig"
Instead of blacklisting tests, I should use approach from
lib/newlib_tests/shell/test_timeout_mul.sh: specify test and it's expected exit
code. Then it'd be possible to have also results which TBROK.
+ maybe disable color for tests and use colors for this comparison of expected
output.
> +
> +grep_pattern=
> +for i in $(echo $FILTER_OUT_FILES); do
> +	grep_pattern="-e $i $grep_pattern"
> +done
> +
> +for i in *; do
> +	if ! echo $i | grep -q $grep_pattern; then
> +		echo "===== $i ====="
> +		./$i
> +		echo
> +	fi
> +done

Kind regards,
Petr
