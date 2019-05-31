From: Li Wang <liwang@redhat.com>
Date: Fri, 31 May 2019 11:17:14 +0800
Subject: [LTP] [PATCH 2/3] lib/test.sh: TCONF needs to be counted
In-Reply-To: <5e8374fa7f4ea9d64cdfc39a2ca449761327c257.1559207183.git.caspar@casparzhang.com>
References: <f11c83459b71fbf399794fb8363f2b538b0b6346.1559207183.git.caspar@casparzhang.com>
 <5e8374fa7f4ea9d64cdfc39a2ca449761327c257.1559207183.git.caspar@casparzhang.com>
Message-ID: <CAEemH2eV6RZKdZV0MMuogAzyvoXCsuvrfp3v_1TNtO1cOoAPGA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, May 30, 2019 at 5:10 PM Caspar Zhang <caspar@linux.alibaba.com>
wrote:

> TCONF should also be one of exit statuses in a single test, else the
> output of TST_COUNT in shell tests could be wrong.
>
> Wrong:
> <<<test_output>>>
> memcg_use_hierarchy_test 1 TINFO: Starting test 1
> memcg_use_hierarchy_test 1 TINFO: set /dev/memcg/memory.use_hierarchy to 0
> failed
> memcg_use_hierarchy_test 1 TPASS: process 28658 is killed
> memcg_use_hierarchy_test 2 TINFO: Starting test 2
> memcg_use_hierarchy_test 2 TINFO: set /dev/memcg/memory.use_hierarchy to 0
> failed
> memcg_use_hierarchy_test 2 TCONF: memory.use_hierarchy already been 1,
> blame systemd, skip
> memcg_use_hierarchy_test 2 TINFO: Starting test 3
> memcg_use_hierarchy_test 2 TINFO: set /dev/memcg/memory.use_hierarchy to 0
> failed
> memcg_use_hierarchy_test 2 TPASS: echo 0 > subgroup/memory.use_hierarchy
> failed as expected
> <<<execution_status>>>
>
> Right:
> <<<test_output>>>
> memcg_use_hierarchy_test 1 TINFO: Starting test 1
> memcg_use_hierarchy_test 1 TINFO: set /dev/memcg/memory.use_hierarchy to 0
> failed
> memcg_use_hierarchy_test 1 TPASS: process 26825 is killed
> memcg_use_hierarchy_test 2 TINFO: Starting test 2
> memcg_use_hierarchy_test 2 TINFO: set /dev/memcg/memory.use_hierarchy to 0
> failed
> memcg_use_hierarchy_test 2 TCONF: memory.use_hierarchy already been 1,
> blame systemd, skip
> memcg_use_hierarchy_test 3 TINFO: Starting test 3
> memcg_use_hierarchy_test 3 TINFO: set /dev/memcg/memory.use_hierarchy to 0
> failed
> memcg_use_hierarchy_test 3 TPASS: echo 0 > subgroup/memory.use_hierarchy
> failed as expected
> <<<execution_status>>>
>

This is a good catch, but maybe it's not wise to simply regard the TCONF as
a single test, because there are many system-config detections in setup()
function, that will make LTP gives a mendacious report on the test numbers
if applying this patch.

e.g.

if tst_kvcmp -lt "3.10"; then
    tst_brk TCONF "test must be run with kernel 3.10 or newer"
fi
if dir path not exist; then
    tst_brk TCONF "system does not have xxxx/"
fi
and so on...



>
> Signed-off-by: Caspar Zhang <caspar@linux.alibaba.com>
> ---
>  testcases/lib/test.sh | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/testcases/lib/test.sh b/testcases/lib/test.sh
> index 670248ee5..ade8fcdff 100644
> --- a/testcases/lib/test.sh
> +++ b/testcases/lib/test.sh
> @@ -58,8 +58,7 @@ tst_resm()
>         echo " $@"
>
>         case "$ret" in
> -       TPASS|TFAIL)
> -       TST_COUNT=$((TST_COUNT+1));;
> +       TPASS|TFAIL|TCONF) TST_COUNT=$((TST_COUNT+1));;
>         esac
>  }
>
> --
> 2.21.0
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>


-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190531/10b12894/attachment.html>
