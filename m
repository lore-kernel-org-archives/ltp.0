From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 31 Oct 2017 11:23:08 +0100
Subject: [LTP] [PATCH 1/3] lib: setup rhost TST_TMPDIR if net test sets
 TST_NEEDS_TMPDIR
In-Reply-To: <1507812041-2068-1-git-send-email-alexey.kodanev@oracle.com>
References: <1507812041-2068-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <20171031102222.hkchibhw7qnb2oyc@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> tst_tmpdir() in test_net.sh should be removed when network tests
> converted to newer lib.

> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> ---
>  testcases/lib/test.sh     |    2 ++
>  testcases/lib/test_net.sh |   12 ++++++++++++
>  testcases/lib/tst_test.sh |    2 ++
>  3 files changed, 16 insertions(+), 0 deletions(-)

LGTM.

<snip>
> +if [ "$TST_NEEDS_TMPDIR" = 1 ]; then
I prefer "1", but that's only a detail:

> +	tst_tmpdir
> +	tst_rhost_run -c "mkdir -p $TST_TMPDIR"
> +	tst_rhost_run -c "chmod 777 $TST_TMPDIR"
> +	export TST_TMPDIR_RHOST=1
> +fi
> diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
> index 9453759..249b054 100644
> --- a/testcases/lib/tst_test.sh
> +++ b/testcases/lib/tst_test.sh
> @@ -28,6 +28,7 @@ export TST_WARN=0
>  export TST_CONF=0
>  export TST_COUNT=1
>  export TST_ITERATIONS=1
> +export TST_TMPDIR_RHOST=0

>  . tst_ansi_color.sh

> @@ -49,6 +50,7 @@ tst_do_exit()
>  	if [ "$TST_NEEDS_TMPDIR" = 1 -a -n "$TST_TMPDIR" ]; then
The same here.

<snip>


Kind regards,
Petr
