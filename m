From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 26 Feb 2019 19:26:08 +0100
Subject: [LTP] [PATCH 1/2] lib/tst_net.sh: don't treat TWARN/TCONF as
 failure in tst_netload()
In-Reply-To: <1551198213-10024-1-git-send-email-alexey.kodanev@oracle.com>
References: <1551198213-10024-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <20190226182607.GB27937@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> Report TWARN and don't stop the test in that case.

Acked-by: Petr Vorel <pvorel@suse.cz>

With one minor comment below.
...
> --- a/testcases/lib/tst_net.sh
> +++ b/testcases/lib/tst_net.sh
> @@ -573,7 +573,7 @@ tst_netload()
>  	[ "$setup_srchost" = 1 ] && s_opts="${s_opts}-S $hostopt "

>  	local expect_ret=0
> -	[ "$expect_res" != "pass" ] && expect_ret=1
> +	[ "$expect_res" != "pass" ] && expect_ret=3

>  	tst_rhost_run -c "pkill -9 netstress\$"
>  	s_opts="${cs_opts}${s_opts}-R $s_replies -B $TST_TMPDIR"
> @@ -590,26 +590,37 @@ tst_netload()
>  	c_opts="${cs_opts}${c_opts}-a $c_num -r $c_requests -d $rfile -g $port"

>  	tst_res_ TINFO "run client 'netstress -l $c_opts'"
> -	netstress -l $c_opts > tst_netload.log 2>&1 || ret=1
> +	netstress -l $c_opts > tst_netload.log 2>&1 || ret=$?
>  	tst_rhost_run -c "pkill -9 netstress\$"

> -	if [ "$expect_ret" -ne "$ret" ]; then
> +	if [ "$expect_ret" -ne 0 ]; then
> +		if [ $((ret & expect_ret)) -ne 0 ]; then
> +			tst_res_ TPASS "netstress failed as expected"
> +		else
> +			tst_res_ TFAIL "unexpected pass, ret is $ret"
I like the previous one, which mentioned what was expected. maybe something
like:
			tst_res_ TFAIL "unexpected pass, expected '$expect_ret', but ret: $ret"

Or even mention $expect_res, which is word (not number)?


Kind regards,
Petr
