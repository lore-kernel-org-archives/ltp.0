From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 16 May 2018 12:44:37 +0200
Subject: [LTP] [PATCH v2] tst_test.sh: achieve TST_RETRY_FUNC function
 in shell
In-Reply-To: <20180503033414.5601-1-liwang@redhat.com>
References: <20180503033414.5601-1-liwang@redhat.com>
Message-ID: <20180516104437.kgun7upb4sbrwsfj@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

> The commit c2ce4df67d(include: add an exponential backoff macro for
> function retry) involves a new MACRO for function retry in C code,
> here achieve it in shell lib and gives a introduction in LTP documents.

> Signed-off-by: Li Wang <liwang@redhat.com>
> Tested-by: Petr Vorel <pvorel@suse.cz>
> ---
...
> +++ b/testcases/lib/tst_test.sh
> @@ -154,6 +154,40 @@ EXPECT_FAIL()
>  	fi
>  }

> +TST_RETRY_FN_EXP_BACKOFF()
> +{
> +	local tst_fun=$1
> +	local tst_exp=$2

Maybe add check for int, something like this?
	if ! tst_is_int "$tst_sec"; then
		tst_brk TBROK "TST_RETRY_FN_EXP_BACKOFF: tst_sec must be integer ('$tst_sec')"
	fi
> +	local tst_sec=$(expr $3 \* 1000000)
> +	local tst_delay=1
> +
> +	if [ $# -ne 3 ]; then
> +		tst_brk TBROK "TST_RETRY_FN_EXP_BACKOFF expects three parameters"
I'd personally use number than word, but feel free to ignore that.
		tst_brk TBROK "TST_RETRY_FN_EXP_BACKOFF expects 3 parameters"
I'm not sure if checking
...

> +TST_RETRY_FUNC()
> +{
TST_RETRY_FUNC needs check for number of params as well:

	if [ $# -ne 2 ]; then
		tst_brk TBROK "TST_RETRY_FUNC expects 2 parameters"
	fi
> +	TST_RETRY_FN_EXP_BACKOFF "$1" "$2" 1

Otherwise you run TST_RETRY_FUNC without params and didn't get check.
some-test 1 TBROK: "" failed


Kind regards,
Petr
