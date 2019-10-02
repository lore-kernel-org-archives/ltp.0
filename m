From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 2 Oct 2019 12:46:17 +0200
Subject: [LTP] [RFC PATCH v4 3/5] shell: Add timeout shell API tests
In-Reply-To: <20190930145916.20465-4-pvorel@suse.cz>
References: <20190930145916.20465-1-pvorel@suse.cz>
 <20190930145916.20465-4-pvorel@suse.cz>
Message-ID: <20191002104617.GA8313@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  lib/newlib_tests/shell/test_timeout.sh | 38 ++++++++++++++++++++++++++
>  lib/newlib_tests/shell/timeout01.sh    | 13 +++++++++
>  lib/newlib_tests/shell/timeout02.sh    | 13 +++++++++
>  3 files changed, 64 insertions(+)
>  create mode 100755 lib/newlib_tests/shell/test_timeout.sh
>  create mode 100755 lib/newlib_tests/shell/timeout01.sh
>  create mode 100755 lib/newlib_tests/shell/timeout02.sh

> diff --git a/lib/newlib_tests/shell/test_timeout.sh b/lib/newlib_tests/shell/test_timeout.sh
> new file mode 100755
> index 000000000..7e296f9e9
> --- /dev/null
> +++ b/lib/newlib_tests/shell/test_timeout.sh
> @@ -0,0 +1,38 @@
> +#!/bin/sh
> +
> +PATH="$(dirname $0)/../../../testcases/lib/:$PATH"
I put PATH here, as it's the only runner and not prolong this fix.
If we want more sophisticated functionality from these test of the library
itself runners, we could create some common.sh library here, which would set
PATH and do other things (counting failures and report them etc).

> +
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
