From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 16 May 2018 11:27:31 +0200
Subject: [LTP] [RFC PATCH 2/9] testcases: ar: Add TST_NEEDS_CMDS on "ar"
In-Reply-To: <20180423094639.14612-3-mylene.josserand@bootlin.com>
References: <20180423094639.14612-1-mylene.josserand@bootlin.com>
 <20180423094639.14612-3-mylene.josserand@bootlin.com>
Message-ID: <20180516092731.x6obyr4lej6ruhc5@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi Mylène,

> In case "ar" binary is not available, the test will fail.
> It should return a TCONF as we just do not have the binary.

> This commit adds TST_NEEDS_CMDS macro on "ar". Thanks to that,
> it will return "TCONF" and not "FAIL" when "ar" is not available.

> Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
> ---
>  testcases/commands/ar/ar01 | 3 +++
>  1 file changed, 3 insertions(+)

> diff --git a/testcases/commands/ar/ar01 b/testcases/commands/ar/ar01
> index ddab2e0f0..edaa24657 100644
> --- a/testcases/commands/ar/ar01
> +++ b/testcases/commands/ar/ar01
> @@ -22,9 +22,12 @@

>  # This is a basic ar command test.

> +AR=${AR:=ar}
>  TST_CNT=17
>  TST_TESTFUNC=test
>  TST_NEEDS_TMPDIR=1
> +TST_NEEDS_CMDS="$AR"
> +
>  . tst_test.sh

>  test1()

Merged with minor change:
-AR=${AR:=ar}
+AR="${AR:=ar}"

Thanks for your contributions.

Kind regards,
Petr
