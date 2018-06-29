From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 29 Jun 2018 16:58:08 +0200
Subject: [LTP] [PATCH 1/1] tst_test.sh: Fix check for $TST_DEVICE
In-Reply-To: <20180628122944.3373-1-pvorel@suse.cz>
References: <20180628122944.3373-1-pvorel@suse.cz>
Message-ID: <20180629145807.ve4qmrh3pudpnx6n@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> When tst_device acquire call fails, it outputs into stdout,
> therefore the content is actually help message.
> => Check for file presence rather than variable not being empty.

> Fixes: c5ac5d712 tst_test.sh: Make use of tst_device helper

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Hi,

> other option would be to check $?.

> BTW found while testing on TMPDIR being tmpfs with small size (300M).
> Test lib/newlib_tests/tst_device.c obviously fails.

> Kind regards,
> Petr
> ---
>  testcases/lib/tst_test.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
> index d27b4afd6..799045b03 100644
> --- a/testcases/lib/tst_test.sh
> +++ b/testcases/lib/tst_test.sh
> @@ -364,7 +364,7 @@ tst_run()

>  		TST_DEVICE=$(tst_device acquire)

> -		if [ -z "$TST_DEVICE" ]; then
> +		if [ ! -b "$TST_DEVICE" ]; then
>  			tst_brk TBROK "Failed to acquire device"
>  		fi
Pushed with Jan's ack and as 
-               if [ -z "$TST_DEVICE" ]; then
+               if [ ! -b "$TST_DEVICE" -o $? -ne 0 ]; then


Kind regards,
Petr
