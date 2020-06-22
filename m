From: Li Wang <liwang@redhat.com>
Date: Mon, 22 Jun 2020 17:08:08 +0800
Subject: [LTP] [PATCH 1/2] cgroup: Fix build with -Werror=return-type
In-Reply-To: <20200622074314.22098-1-petr.vorel@suse.com>
References: <20200622074314.22098-1-petr.vorel@suse.com>
Message-ID: <CAEemH2cz9s71E+VidezUAfYGarOzgpPTf0VucY+OYCYmjBjTGQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Jun 22, 2020 at 3:43 PM Petr Vorel <petr.vorel@suse.com> wrote:

> From: Petr Vorel <pvorel@suse.cz>
>
> Adding bogus return to keep compiler happy.
>
> Fixes: 3b716981b ("lib: add new cgroup test API")
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Hi,
>
> IMHO using pragma would be better, but I don't know how to write it
> portable way.
>
> Kind regards,
> Petr
>
>  lib/tst_cgroup.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
> index f55d8818d..0118dd7b2 100644
> --- a/lib/tst_cgroup.c
> +++ b/lib/tst_cgroup.c
> @@ -49,6 +49,7 @@ enum tst_cgroup_ver tst_cgroup_version(void)
>                 return TST_CGROUP_V1;
>
>         tst_brk(TCONF, "Cgroup is not configured");
> +       return TST_CGROUP_V1; /* fix -Werror=return-type */
>

This return looks strange since it will never go to here.

How about this?

enum tst_cgroup_ver tst_cgroup_version(void)
{
        enum tst_cgroup_ver cg_ver;

        if (tst_cgroup_check("cgroup2")) {
                if (!tst_is_mounted("cgroup2") && tst_is_mounted("cgroup"))
                        cg_ver = TST_CGROUP_V1;
                else
                        cg_ver = TST_CGROUP_V2;

                goto out;
        }

        if (tst_cgroup_check("cgroup"))
                cg_ver = TST_CGROUP_V1;

        if (!tg_ver)
                tst_brk(TCONF, "Cgroup is not configured");

out:
        return cg_ver;
}


-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200622/445db0f7/attachment.htm>
