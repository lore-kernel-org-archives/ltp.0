From: Li Wang <liwang@redhat.com>
Date: Fri, 28 Feb 2020 15:00:24 +0800
Subject: [LTP] [PATCH 2/4] lib: Check also flags for tst_res()
In-Reply-To: <20200227163922.317-2-pvorel@suse.cz>
References: <20200227163922.317-1-pvorel@suse.cz>
 <20200227163922.317-2-pvorel@suse.cz>
Message-ID: <CAEemH2fTYf91KP6_Kf343taLmoGeTuOvNJWVr1qf5C-02+CZpQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

Thanks for your work on this!

On Fri, Feb 28, 2020 at 12:39 AM Petr Vorel <pvorel@suse.cz> wrote:

> Allowed types: TCONF | TFAIL | TINFO | TPASS | TWARN
> i.e. TBROK is forbidden.
>
> Suggested-by: Li Wang <liwang@redhat.com>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Hi,
>
> TPASS == 0, that's why TTYPE_RESULT(ttype) ?: TCONF
>
> Kind regards,
> Petr
>
>  include/tst_common.h | 3 +++
>  include/tst_test.h   | 6 +++++-
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/include/tst_common.h b/include/tst_common.h
> index d37e38487..54a8428fd 100644
> --- a/include/tst_common.h
> +++ b/include/tst_common.h
> @@ -77,4 +77,7 @@
>  #define TST_BRK_SUPPORTS_ONLY_TCONF_TBROK(condition) \
>         do { ((void)sizeof(char[1 - 2 * !!(condition)])); } while (0)
>
> +#define TST_RES_SUPPORTS_TCONF_TFAIL_TINFO_TPASS_TWARN(condition) \
> +       TST_BRK_SUPPORTS_ONLY_TCONF_TBROK(condition)
>

To be honest, this looks verbose and confusing a little. I'm thinking can
we just add a prefix TST_ to the kernel macro and use it directly?

e.g

#define TST_BUILD_BUG_ON(condition) \
        do { ((void)sizeof(char[1 - 2 * !!(condition)])); } while (0)



> +
>  #endif /* TST_COMMON_H__ */
> diff --git a/include/tst_test.h b/include/tst_test.h
> index 1026a422a..8508c2e38 100644
> --- a/include/tst_test.h
> +++ b/include/tst_test.h
> @@ -47,7 +47,11 @@ void tst_res_(const char *file, const int lineno, int
> ttype,
>                __attribute__ ((format (printf, 4, 5)));
>
>  #define tst_res(ttype, arg_fmt, ...) \
> -       tst_res_(__FILE__, __LINE__, (ttype), (arg_fmt), ##__VA_ARGS__)
> +       ({
>       \
> +
>  TST_RES_SUPPORTS_TCONF_TFAIL_TINFO_TPASS_TWARN(!((TTYPE_RESULT(ttype) ?:
> TCONF) & \
> +                       (TCONF | TFAIL | TINFO | TPASS | TWARN)));
>                       \
> +               tst_res_(__FILE__, __LINE__, (ttype), (arg_fmt),
> ##__VA_ARGS__);\
> +       })
>
>  void tst_resm_hexd_(const char *file, const int lineno, int ttype,
>         const void *buf, size_t size, const char *arg_fmt, ...)
> --
> 2.25.1
>
>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200228/849620a9/attachment-0001.htm>
