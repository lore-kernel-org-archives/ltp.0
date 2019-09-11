From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 11 Sep 2019 11:12:43 +0200
Subject: [LTP] [PATCH] Use LTP_TIMEOUT_MUL in TST_RETRY_FN()
In-Reply-To: <20190911085536.25546-1-cfamullaconrad@suse.de>
References: <20190911085536.25546-1-cfamullaconrad@suse.de>
Message-ID: <20190911091242.GA24623@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Clemens,

> We discovered timeout problems for well known candidates.
> Most of the time we already use LTP_TIMEOUT_MUL in other cases to
> globally increase timeout value. So doing it for this function as well.

> Signed-off-by: Clemens Famulla-Conrad <cfamullaconrad@suse.de>
> ---
>  testcases/lib/tst_test.sh | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

> diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
> index e0b24c6b9..80b8871cb 100644
> --- a/testcases/lib/tst_test.sh
> +++ b/testcases/lib/tst_test.sh
> @@ -162,9 +162,11 @@ EXPECT_FAIL()

>  TST_RETRY_FN_EXP_BACKOFF()
>  {
> +	LTP_TIMEOUT_MUL=${LTP_TIMEOUT_MUL:-1}
> +
>  	local tst_fun="$1"
>  	local tst_exp=$2
> -	local tst_sec=$(expr $3 \* 1000000)
> +	local tst_sec=$(expr $3 \* 1000000 \* $LTP_TIMEOUT_MUL)
>  	local tst_delay=1

I'm for it, but that will diverge from C API. Shouldn't we add it also
to tst_common.h?

Kind regards,
Petr
