From: Li Wang <liwang@redhat.com>
Date: Mon, 30 Aug 2021 17:55:00 +0800
Subject: [LTP] [PATCH v2] tst_test_macros.h: Add TST_EXP_VAL macro
In-Reply-To: <20210830070951.27803-1-zhanglianjie@uniontech.com>
References: <20210830070951.27803-1-zhanglianjie@uniontech.com>
Message-ID: <CAEemH2cJt3Ku90f2CUkypr-55H3dwEUpnO7-QcsyJbRRfVH2nw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Aug 30, 2021 at 3:10 PM zhanglianjie <zhanglianjie@uniontech.com>
wrote:

> Add TST_EXP_VAL to determine whether the return value
> is equal to the given value.
>
> Signed-off-by: zhanglianjie <zhanglianjie@uniontech.com>
>
 Reviewed-by: Li Wang <liwang@redhat.com>


>
> diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
> index 50598aa15..0ccc01f49 100644
> --- a/include/tst_test_macros.h
> +++ b/include/tst_test_macros.h
> @@ -132,6 +132,34 @@ extern void *TST_RET_PTR;
>                         TST_MSG_(TPASS, " passed", #SCALL,
> ##__VA_ARGS__);     \
>         } while (0)
>     \
>
> +
> +#define TST_EXP_VAL_SILENT_(SCALL, SSCALL, VAL, ...)
>      \
> +       do {
>      \
> +               TEST(SCALL);
>      \
> +
>     \
> +               TST_PASS = 0;
>     \
> +
>     \
> +               if (TST_RET != VAL) {
>     \
> +                       TST_MSGP_(TFAIL | TTERRNO, " retval not %ld",
>     \
> +                                 (long )VAL, SSCALL, ##__VA_ARGS__);
>     \
> +                       break;
>      \
> +               }
>     \
> +
>     \
> +               TST_PASS = 1;
>     \
> +
>     \
> +       } while (0)
> +
> +#define TST_EXP_VAL_SILENT(SCALL, VAL, ...) TST_EXP_VAL_SILENT_(SCALL,
> #SCALL, VAL, ##__VA_ARGS__)
> +
> +#define TST_EXP_VAL(SCALL, VAL, ...)
>      \
> +       do {
>      \
> +               TST_EXP_VAL_SILENT(SCALL, VAL, ##__VA_ARGS__);
>      \
> +
>     \
> +               if (TST_PASS)
>     \
> +                       TST_MSG_(TPASS, " passed", #SCALL,
> ##__VA_ARGS__);     \
> +
>     \
> +       } while(0)
> +
>  #define TST_EXP_FAIL_(PASS_COND, SCALL, SSCALL, ERRNO, ...)
>       \
>         do {
>      \
>                 TEST(SCALL);
>      \
> --
> 2.20.1
>
>
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>
>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210830/f0150db9/attachment.htm>
