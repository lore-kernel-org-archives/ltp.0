From: Li Wang <liwang@redhat.com>
Date: Wed, 26 Feb 2020 17:00:15 +0800
Subject: [LTP] [PATCH 1/1] request_key04: Use TFAIL instead of TBROK
In-Reply-To: <20200226084249.29561-1-pvorel@suse.cz>
References: <20200226084249.29561-1-pvorel@suse.cz>
Message-ID: <CAEemH2cMBtVV-1_RZb_UHN9rQF3sD2w-H2gS11BD2WHPTPzvgQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Feb 26, 2020 at 4:43 PM Petr Vorel <pvorel@suse.cz> wrote:

> To fix unreported results error:
> tst_test.c:1036: BROK: Test haven't reported results!
>
> which also prevents to display kernel commit fix and CVE.
>
> Fixes: 8ac26843e ("syscalls/request_key04: new test for request_key()
> permission check bug")
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Hi,
>
> obvious fix which I'd normally merge without sending to ML.
> But there are 19 tests which use tst_res(TBROK, and at least some of
> them are affected by this (i.e. don't unconditionally report any result
> before tst_res(TBROK), so we might want to fix it different way.
>
+1 for this fix.

By the way, do you think it makes sense to add build check parameters for
tst_res() too? Just like what we do for tst_brk() in commit 0738e3753c51.

Any thoughts?



>
> Kind regards,
> Petr
>
>  testcases/kernel/syscalls/request_key/request_key04.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/testcases/kernel/syscalls/request_key/request_key04.c
> b/testcases/kernel/syscalls/request_key/request_key04.c
> index da036bf3a..c125f4261 100644
> --- a/testcases/kernel/syscalls/request_key/request_key04.c
> +++ b/testcases/kernel/syscalls/request_key/request_key04.c
> @@ -65,7 +65,7 @@ static void do_test(void)
>         if (TST_ERR == EACCES) {
>                 tst_res(TPASS, "request_key() failed with EACCES as
> expected");
>         } else {
> -               tst_res(TBROK | TTERRNO,
> +               tst_res(TFAIL | TTERRNO,
>                         "request_key() failed with unexpected error code");
>         }
>  }
> --
> 2.25.1
>
>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200226/2c786714/attachment.htm>
