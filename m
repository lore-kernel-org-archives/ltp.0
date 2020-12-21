From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 21 Dec 2020 17:33:11 +0300
Subject: [LTP] [PATCH v2] ipsec_lib: make tst_net_run "tst_check_driver"
 quiet
In-Reply-To: <20201218144156.29866-1-kory.maincent@bootlin.com>
References: <20201218144156.29866-1-kory.maincent@bootlin.com>
Message-ID: <e9601747-8f08-d127-6eac-46467c631c43@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 18.12.2020 17:41, Kory Maincent wrote:
> Make tst_net_run quiet when using tst_check_drivers to avoid wrong TWARN message
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
> 
> Change since v1:
>   Considered Alexey's review
>   https://urldefense.com/v3/__http://lists.linux.it/pipermail/ltp/2020-December/020285.html__;!!GqivPVa7Brio!OdHd62f8dF5zyARaPopO0WEuxNw4iqh52VKRlkJFHeFaaBmwFHz9K_6sE7jP0oox9W-4$ 
> 
>  testcases/network/stress/ipsec/ipsec_lib.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied the patch, thanks!

> diff --git a/testcases/network/stress/ipsec/ipsec_lib.sh b/testcases/network/stress/ipsec/ipsec_lib.sh
> index 198c9315d..e395e1ff3 100644
> --- a/testcases/network/stress/ipsec/ipsec_lib.sh
> +++ b/testcases/network/stress/ipsec/ipsec_lib.sh
> @@ -83,7 +83,7 @@ ipsec_lib_setup()
>  	ALGR=
>  
>  	if [ -n "$IPSEC_MODE" ]; then
> -		tst_net_run "tst_check_drivers xfrm_user" || \
> +		tst_net_run -q "tst_check_drivers xfrm_user" || \

Noticed a minor issue in the test output, when tst_check_drivers
prints missing drivers to stderr, I think we should handle it
inside tst_net_run with -q somehow...
