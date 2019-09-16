From: Li Wang <liwang@redhat.com>
Date: Mon, 16 Sep 2019 18:15:15 +0800
Subject: [LTP] [PATCH v2 2/3] shell: Introduce TST_TIMEOUT variable
In-Reply-To: <20190913125823.17314-3-pvorel@suse.cz>
References: <20190913125823.17314-1-pvorel@suse.cz>
 <20190913125823.17314-3-pvorel@suse.cz>
Message-ID: <CAEemH2f4oeSvN-p7xSzjo2ZFvndxjX2sQ+M9f6fYV_bN2ewn=A@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

Thanks for your working.

On Fri, Sep 13, 2019 at 8:58 PM Petr Vorel <pvorel@suse.cz> wrote:

>
> <snip>

>
> --- a/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
> +++ b/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
> @@ -17,7 +17,7 @@ TST_NEEDS_CMDS="mount umount cat kill mkdir rmdir grep
> awk cut"
>
>  # Each test case runs for 900 secs when everything fine
>  # therefore the default 5 mins timeout is not enough.
> -LTP_TIMEOUT_MUL=7
> +TST_TIMEOUT=2100
>
>  . cgroup_lib.sh
>
> diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
> index ca63745fd..b206fc0bb 100644
> --- a/testcases/lib/tst_test.sh
> +++ b/testcases/lib/tst_test.sh
> @@ -379,9 +379,41 @@ _tst_rescmp()
>
>  _tst_setup_timer()
>  {
> +       TST_TIMEOUT=${TST_TIMEOUT:-300}
>         LTP_TIMEOUT_MUL=${LTP_TIMEOUT_MUL:-1}
>
> -       local sec=$((300 * LTP_TIMEOUT_MUL))
> +       if [ "$TST_TIMEOUT" = -1 ]; then
> +               tst_res TINFO "Timeout per run is disabled"
> +               return
> +       fi
> +
> +       local err is_float
> +       if tst_is_num "$LTP_TIMEOUT_MUL"; then
> +               if tst_is_int "$LTP_TIMEOUT_MUL"; then
> +                       [ "$LTP_TIMEOUT_MUL" -ge 1 ] || err=1
> +               else
> +                       tst_test_cmds awk
> +                       echo | awk '{if ('"$LTP_TIMEOUT_MUL"' < 1) {exit
> 1}}' || err=1
> +                       is_float=1
> +               fi
> +       else
> +               err=1
> +       fi
>

I'm OK to allow $LTP_TIMEOUT_MUL being float. But here I don't see what's
enough reason to add the is_float variable. Because we could use the float
expression for both types comparing, isn't it?


> +       if [ "$err" ]; then
> +               tst_brk TCONF "LTP_TIMEOUT_MUL must be number >= 1!
> ($LTP_TIMEOUT_MUL)"
> +       fi
> +
> +       if ! tst_is_int "$TST_TIMEOUT" || [ "$TST_TIMEOUT" -lt 1 ]; then
> +               tst_brk TBROK "TST_TIMEOUT must be int >= 1!
> ($TST_TIMEOUT)"
> +       fi
> +
> +       local sec
> +       if [ "$is_float" ]; then
> +               sec=`echo |awk '{printf("%d\n", '$TST_TIMEOUT' *
> '$LTP_TIMEOUT_MUL')}'`
> +       else
> +               sec=$((TST_TIMEOUT * LTP_TIMEOUT_MUL))
> +       fi
>

Here as well, why we need to distinguish the float and int, is the float
expression does not work for integer?

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190916/0ff2e4e0/attachment.htm>
