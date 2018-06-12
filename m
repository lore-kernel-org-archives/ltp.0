From: Li Wang <liwang@redhat.com>
Date: Tue, 12 Jun 2018 22:28:39 +0800
Subject: [LTP] [COMMITTED][PATCH 1/1] tst_test.sh: Quote function
	parameter
In-Reply-To: <20180612141137.11690-1-pvorel@suse.cz>
References: <20180612141137.11690-1-pvorel@suse.cz>
Message-ID: <CAEemH2c=GuRMPM=KCbefiJcB0UKPNa_NAu1Z6WefczvYcFNG2A@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

On Tue, Jun 12, 2018 at 10:11 PM, Petr Vorel <pvorel@suse.cz> wrote:

> As following patches shows the need to use function with parameter [1],
> quotes are needed.
>
> [1] http://lists.linux.it/pipermail/ltp/2018-May/008147.html
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
>

​ACK.
​


> ---
> Sorry, I overlooked it in your patch.
>

​You shouldn't say sorry, that's my careless to made it. :)
​


> ---
>  testcases/lib/tst_test.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
> index 0c98d5a75..d27b4afd6 100644
> --- a/testcases/lib/tst_test.sh
> +++ b/testcases/lib/tst_test.sh
> @@ -156,7 +156,7 @@ EXPECT_FAIL()
>
>  TST_RETRY_FN_EXP_BACKOFF()
>  {
> -       local tst_fun=$1
> +       local tst_fun="$1"
>         local tst_exp=$2
>         local tst_sec=$(expr $3 \* 1000000)
>         local tst_delay=1
> --
> 2.16.3
>
>


-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180612/09ffc2fe/attachment.html>
