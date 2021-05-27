From: Li Wang <liwang@redhat.com>
Date: Thu, 27 May 2021 21:18:37 +0800
Subject: [LTP] [PATCH v2 5/6] API/cgroups: tst_require fail gracefully
 with unknown controller
In-Reply-To: <20210521102528.21102-6-rpalethorpe@suse.com>
References: <20210521102528.21102-1-rpalethorpe@suse.com>
 <20210521102528.21102-6-rpalethorpe@suse.com>
Message-ID: <CAEemH2cqGGJuF56LpVO9egB7eLLCLdcXKaVA_2dkFRFmN8=jKw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richard,

On Fri, May 21, 2021 at 6:26 PM Richard Palethorpe via ltp
<ltp@lists.linux.it> wrote:
>
> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> ---
>  lib/tst_cgroup.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
> index 74746f13e..6d94ea41c 100644
> --- a/lib/tst_cgroup.c
> +++ b/lib/tst_cgroup.c
> @@ -599,6 +599,12 @@ void tst_cgroup_require(const char *const ctrl_name,
>         struct cgroup_ctrl *const ctrl = cgroup_find_ctrl(ctrl_name);
>         struct cgroup_root *root;
>
> +       if (!ctrl) {
> +               tst_brk(TBROK, "'%s' controller is unknown to LTP", ctrl_name);
> +               tst_brk(TBROK, "Calling %s in cleanup?", __func__);
> +               return;

It'd never go here to perform a return because the first tst_brk
will break the test directly. And, I don't know why we need the
second tst_brk to show calling in cleanup, is that possible?


> +       }
> +
>         if (!options)
>                 options = &default_opts;
>
> --
> 2.31.1
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>


--
Regards,
Li Wang

