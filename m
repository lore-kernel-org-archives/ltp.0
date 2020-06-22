From: Petr Vorel <pvorel@suse.com>
Date: Mon, 22 Jun 2020 11:22:13 +0200
Subject: [LTP] [PATCH 1/2] cgroup: Fix build with -Werror=return-type
In-Reply-To: <CAEemH2cz9s71E+VidezUAfYGarOzgpPTf0VucY+OYCYmjBjTGQ@mail.gmail.com>
References: <20200622074314.22098-1-petr.vorel@suse.com>
 <CAEemH2cz9s71E+VidezUAfYGarOzgpPTf0VucY+OYCYmjBjTGQ@mail.gmail.com>
Message-ID: <20200622092213.GA27392@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

> >         tst_brk(TCONF, "Cgroup is not configured");
> > +       return TST_CGROUP_V1; /* fix -Werror=return-type */


> This return looks strange since it will never go to here.

> How about this?

I'm sorry, I overlooked your mail and push whole patchset.

LGTM, feel free to merge.
Tested-by: Petr Vorel <pvorel@suse.cz>

> enum tst_cgroup_ver tst_cgroup_version(void)
> {
>         enum tst_cgroup_ver cg_ver;

>         if (tst_cgroup_check("cgroup2")) {
>                 if (!tst_is_mounted("cgroup2") && tst_is_mounted("cgroup"))
>                         cg_ver = TST_CGROUP_V1;
>                 else
>                         cg_ver = TST_CGROUP_V2;

>                 goto out;
>         }

>         if (tst_cgroup_check("cgroup"))
>                 cg_ver = TST_CGROUP_V1;

>         if (!tg_ver)
Typo:
         if (!cg_ver)
>                 tst_brk(TCONF, "Cgroup is not configured");

> out:
>         return cg_ver;
> }

Kind regards,
Petr
