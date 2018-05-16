From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 16 May 2018 11:34:27 +0200
Subject: [LTP] [RFC PATCH 3/9] testcases: file: Add TST_NEEDS_CMDS on
 readelf
In-Reply-To: <20180423094639.14612-4-mylene.josserand@bootlin.com>
References: <20180423094639.14612-1-mylene.josserand@bootlin.com>
 <20180423094639.14612-4-mylene.josserand@bootlin.com>
Message-ID: <20180516093427.wy577hbcuennimxg@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi Mylène,

> This test is using "readelf" binary that can be
> unavailable on the system.
> Instead of failing, it should return a TCONF.

> This is what this commit is doing by adding "readelf"
> in TST_NEEDS_CMDS macro.

> Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
> ---
>  testcases/commands/file/file01.sh | 2 ++
>  1 file changed, 2 insertions(+)

> diff --git a/testcases/commands/file/file01.sh b/testcases/commands/file/file01.sh
> index e04b32e86..b72760e9f 100755
> --- a/testcases/commands/file/file01.sh
> +++ b/testcases/commands/file/file01.sh
> @@ -28,6 +28,8 @@ TST_CNT=20
>  TST_SETUP=setup
>  TST_TESTFUNC=do_test
>  TST_NEEDS_TMPDIR=1
> +TST_NEEDS_CMDS="readelf"
> +
>  . tst_test.sh

>  setup()

Pushed, thanks!


Kind regards,
Petr
