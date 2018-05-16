From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 16 May 2018 11:38:19 +0200
Subject: [LTP] [RFC PATCH 4/9] testcases: tar: Add TST_NEEDS_CMDS on
 gzip and bzip
In-Reply-To: <20180423094639.14612-5-mylene.josserand@bootlin.com>
References: <20180423094639.14612-1-mylene.josserand@bootlin.com>
 <20180423094639.14612-5-mylene.josserand@bootlin.com>
Message-ID: <20180516093819.5ecnfhljdlmolsky@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi Mylène,

> Add TST_NEEDS_CMDS to return a TCONF in case "gzip"
> and "bzip2" binaries are not available on the system.

> Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
> ---
>  testcases/commands/tar/tar_tests.sh | 2 ++
>  1 file changed, 2 insertions(+)

> diff --git a/testcases/commands/tar/tar_tests.sh b/testcases/commands/tar/tar_tests.sh
> index 7ac18a4e5..946e9c7b1 100755
> --- a/testcases/commands/tar/tar_tests.sh
> +++ b/testcases/commands/tar/tar_tests.sh
> @@ -27,6 +27,8 @@
>  TST_CNT=6
>  TST_TESTFUNC=do_test
>  TST_NEEDS_TMPDIR=1
> +TST_NEEDS_CMDS="gzip bzip2"
> +
>  . tst_test.sh

>  TAR_FILES="file1 file2 file3"

Pushed, thanks!


Kind regards,
Petr
