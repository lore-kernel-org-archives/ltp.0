From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 25 May 2018 18:01:55 +0200
Subject: [LTP] [RFC PATCH v4 1/4] lib/tst_test.sh: Fix test name
 function detection for TST_CNT
In-Reply-To: <20180524152129.1067-1-pvorel@suse.cz>
References: <20180524152129.1067-1-pvorel@suse.cz>
Message-ID: <20180525160155.neyzzrt6iqsjvsdz@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> Reported-by: Cyril Hrubis <chrubis@suse.cz>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/lib/tst_test.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
> index 464c4c41e..779383392 100644
> --- a/testcases/lib/tst_test.sh
> +++ b/testcases/lib/tst_test.sh
> @@ -349,7 +349,7 @@ tst_run()
>  	#TODO check that test reports some results for each test function call
>  	while [ $TST_ITERATIONS -gt 0 ]; do
>  		if [ -n "$TST_CNT" ]; then
> -			if type test1 > /dev/null 2>&1; then
> +			if type ${TST_TESTFUNC}1 > /dev/null 2>&1; then
>  				for tst_i in $(seq $TST_CNT); do
>  					local res=$(tst_resstr)
>  					$TST_TESTFUNC$tst_i

Pushed.


Kind regards,
Petr
