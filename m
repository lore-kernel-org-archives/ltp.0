From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 13 Nov 2019 08:59:42 +0100
Subject: [LTP] [PATCH 2/2] lib: Allow timeout coefficient < 1
In-Reply-To: <20191107153458.16917-3-rpalethorpe@suse.com>
References: <20191107153458.16917-1-rpalethorpe@suse.com>
 <20191107153458.16917-3-rpalethorpe@suse.com>
Message-ID: <20191113075942.GA14606@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> For the Syzkaller reproducers we want to allow the test runner to set the
> timeout to be a fraction of the default amount.

> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> ---
>  lib/tst_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 6239acf89..2e00fd86b 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -1107,7 +1107,7 @@ void tst_set_timeout(int timeout)
>  	if (mul) {
>  		float m = atof(mul);

> -		if (m < 1)
> +		if (m <= 0)
>  			tst_brk(TBROK, "Invalid timeout multiplier '%s'", mul);

>  		results->timeout = results->timeout * m + 0.5;

Update for current master:

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 8d7dee2cc..2513ce7ba 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1190,8 +1190,8 @@ unsigned int tst_multiply_timeout(unsigned int timeout)
 			timeout_mul = 1;
 		}
 	}
-	if (timeout_mul < 1)
-		tst_brk(TBROK, "LTP_TIMEOUT_MUL must to be int >= 1! (%.2f)",
+	if (timeout_mul <= 0)
+		tst_brk(TBROK, "LTP_TIMEOUT_MUL must to be int >= 0! (%.2f)",
 				timeout_mul);
 
 	if (timeout < 1)


Kind regards,
Petr
