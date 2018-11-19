From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 19 Nov 2018 18:38:57 +0100
Subject: [LTP] [PATCH v4 1/2] net: Add tst_net_run helper
In-Reply-To: <3a454cb5-64d2-357e-2375-d25df6b1478d@oracle.com>
References: <20181113163008.9093-1-pvorel@suse.cz>
 <09aff1dd-a89f-479b-49da-c0c776b08b91@oracle.com>
 <20181116142411.GA24956@dell5510>
 <37a6f27b-096e-8701-b8ee-4132d10ef889@oracle.com>
 <20181119154004.GB26645@dell5510>
 <3a454cb5-64d2-357e-2375-d25df6b1478d@oracle.com>
Message-ID: <20181119173857.GA11061@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> > tst_rhost_run with -s option in cleanup is only in 2 files:
> > testcases/network/mpls/mpls_lib.sh
> > testcases/network/tcp_cmds/sendfile/sendfile01
> > Maybe that's a mistake (unlike C functions where error in SAFE_* continue with
> > warning, in shell it exits during cleanup).


> For tst_test.sh we could add something like this to tst_brk()

> iff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
> index 16081fa..e84cf7f 100644
> --- a/testcases/lib/tst_test.sh
> +++ b/testcases/lib/tst_test.sh
> @@ -41,6 +41,7 @@ trap "tst_brk TBROK 'test interrupted'" INT
>  _tst_do_exit()
>  {
>         local ret=0
> +       TST_DO_EXIT=1

>         if [ -n "$TST_SETUP_STARTED" -a -n "$TST_CLEANUP" -a \
>              -z "$TST_NO_CLEANUP" ]; then
> @@ -123,6 +124,11 @@ tst_brk()
>         local res=$1
>         shift

> +       if [ "$TST_DO_EXIT" = 1 ]; then
> +               tst_res TWARN "$@"
> +               return
> +       fi
> +
>         tst_res "$res" "$@"
>         _tst_do_exit
>  }

Good idea! Could you please send a patch?


Kind regards,
Petr
