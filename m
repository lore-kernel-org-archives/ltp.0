From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 16 May 2018 12:00:55 +0200
Subject: [LTP] [RFC PATCH 6/9] testcases: wc: Add "unrecognized option"
 as TCONF
In-Reply-To: <20180423094639.14612-7-mylene.josserand@bootlin.com>
References: <20180423094639.14612-1-mylene.josserand@bootlin.com>
 <20180423094639.14612-7-mylene.josserand@bootlin.com>
Message-ID: <20180516100055.5mrh74e3o74gy3lo@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi Mylène,
> In case we are using Busybox, for example, some options
> may not available and leads to a test failure.
> This commit adds "unrecognized option" parsing to return the
> test as a TCONF and not FAIL anymore.

> Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
> ---
>  testcases/commands/wc/wc01.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/testcases/commands/wc/wc01.sh b/testcases/commands/wc/wc01.sh
> index e72819c51..74d69e254 100755
> --- a/testcases/commands/wc/wc01.sh
> +++ b/testcases/commands/wc/wc01.sh
> @@ -40,7 +40,7 @@ wc_test()

>  	eval $wc_cmd > temp 2>&1
>  	if [ $? -ne 0 ]; then
> -		grep -q -E "unknown option|invalid option" temp
> +		grep -q -E "unknown option|invalid option|unrecognized option" temp
What exactly needs "unrecognized option".
I haven't found it in busybox sources neither in busybox git log.

>  		if [ $? -eq 0 ]; then
>  			tst_res TCONF "$wc_cmd not supported."
>  		else


Kind regards,
Petr
