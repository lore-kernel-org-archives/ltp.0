From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 24 Sep 2020 13:33:47 +0200
Subject: [LTP] [PATCH] tst_cgroup: Don't try to use V2 if V1 controllers
 are mounted
In-Reply-To: <20200924111124.5666-1-rpalethorpe@suse.com>
References: <20200924111124.5666-1-rpalethorpe@suse.com>
Message-ID: <20200924113347.GA12565@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richie,

> It is not possible to use a controller in V2 cgroups if it has been
> mounted as a V1 controller. So if V1 is mounted we use it regardless
> of if V2 is available.

> We have to include a space in tst_is_mounted so that we do not match
> cgroup2.

Acked-by: Petr Vorel <pvorel@suse.cz>

Thanks for your fix.

> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> ---
>  lib/tst_cgroup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
> index ba413d874..73ddd4b82 100644
> --- a/lib/tst_cgroup.c
> +++ b/lib/tst_cgroup.c
> @@ -44,7 +44,7 @@ enum tst_cgroup_ver tst_cgroup_version(void)
>          enum tst_cgroup_ver cg_ver;

>          if (tst_cgroup_check("cgroup2")) {
> -                if (!tst_is_mounted("cgroup2") && tst_is_mounted("cgroup"))
> +                if (tst_is_mounted("cgroup "))
On first look the space looks like typo. But people can use git blame.

>                          cg_ver = TST_CGROUP_V1;
>                  else
>                          cg_ver = TST_CGROUP_V2;

Kind regards,
Petr
