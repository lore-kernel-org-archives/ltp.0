From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 22 Jul 2021 09:49:39 +0200
Subject: [LTP] [PATCH v1] lib/tst_test.sh: skip test if ip returns
 "Error: Unknown device type"
In-Reply-To: <20210722063422.18059-1-radoslav.kolev@suse.com>
References: <20210722063422.18059-1-radoslav.kolev@suse.com>
Message-ID: <YPkjE3KHHnhYklp/@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Radoslav,

> In network stress test groups there are tests expecting
> CONFIG_NET_IPVTI to be enabled in the kernel, and if it's not they
> fail. There is a check for VTI support in the ip utility, but not
> for the kernel. Skip these tests if vti device type is not known by
> the kernel.

LGTM.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> Signed-off-by: Radoslav Kolev <radoslav.kolev@suse.com>
> ---
>  testcases/lib/tst_test.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

> diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
> index c6aa2c487..0458c90c2 100644
> --- a/testcases/lib/tst_test.sh
> +++ b/testcases/lib/tst_test.sh
> @@ -241,12 +241,13 @@ TST_RTNL_CHK()
>  	local msg1="RTNETLINK answers: Function not implemented"
>  	local msg2="RTNETLINK answers: Operation not supported"
>  	local msg3="RTNETLINK answers: Protocol not supported"
> +	local msg4="Error: Unknown device type"
>  	local output="$($@ 2>&1 || echo 'LTP_ERR')"
>  	local msg

>  	echo "$output" | grep -q "LTP_ERR" || return 0

> -	for msg in "$msg1" "$msg2" "$msg3"; do
> +	for msg in "$msg1" "$msg2" "$msg3" "$msg4"; do
>  		echo "$output" | grep -q "$msg" && tst_brk TCONF "'$@': $msg"
>  	done
