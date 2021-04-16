From: Li Wang <liwang@redhat.com>
Date: Fri, 16 Apr 2021 15:01:18 +0800
Subject: [LTP] [PATCH v3 2/7] API: Add macro for the container_of trick
In-Reply-To: <20210412145506.26894-3-rpalethorpe@suse.com>
References: <20210412145506.26894-1-rpalethorpe@suse.com>
 <20210412145506.26894-3-rpalethorpe@suse.com>
Message-ID: <CAEemH2ejA9kY2P4HsYEds3g9AjzFQ4mDRuWiF2176istdOMtaA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Richard Palethorpe <rpalethorpe@suse.com> wrote:

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
>
Reviewed-by: Li Wang <liwang@redhat.com>


> ---
>  include/tst_common.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/include/tst_common.h b/include/tst_common.h
> index fd7a900d4..317925d1d 100644
> --- a/include/tst_common.h
> +++ b/include/tst_common.h
> @@ -83,4 +83,9 @@
>  #define TST_RES_SUPPORTS_TCONF_TFAIL_TINFO_TPASS_TWARN(condition) \
>         TST_BUILD_BUG_ON(condition)
>
> +#define tst_container_of(ptr, type, member) ({              \
> +       const typeof( ((type *)0)->member ) *__mptr = (ptr); \
> +       (type *)( (char *)__mptr - offsetof(type,member) );  \
> +})
>

I'd suggest defining it as uppercase 'TST_CONTAINER_OF(...)' to respect
other macro's naming policy in tst_common.h.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210416/d63e627f/attachment-0001.htm>
