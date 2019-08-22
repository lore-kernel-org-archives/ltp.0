From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Thu, 22 Aug 2019 11:35:35 +0200
Subject: [LTP] [RFC PATCH 1/1] capability: Introduce capability API
In-Reply-To: <5D5E5551.9050308@cn.fujitsu.com>
References: <20190808153825.18363-1-rpalethorpe@suse.com>
 <20190808153825.18363-2-rpalethorpe@suse.com>
 <5D5E5551.9050308@cn.fujitsu.com>
Message-ID: <87tva9v8yg.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,
> Hi Richard
>
> If we use _LINUX_CAPABILITY_VERSION_1, kernel will report the following warning: `cap_test' uses 32-bit capabilities (legacy support in use)
>
> _LINUX_CAPABILITY_VERSION_2 has been deprecated since kernel 2.6.25, so we can only use _LINUX_CAPABILITY_VERSION_3.
>
> But _LINUX_CAPABILITY_VERSION_3 uses 64-bit capabilities as man-page said, effective defined as uint32_t in tst_cap_usr_data is not enough.
> I guess we need to define cur[2] ,new[2] and compare. Also, it can slove the EPERM failure as Li wang's cap_test.c found.
>  ps: I changed  kernel code to track this problem.
> diff --git a/security/commoncap.c b/security/commoncap.c
> index f4ee0ae106b2..291eb4e71031 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -247,24 +247,31 @@ int cap_capset(struct cred *new,
>         if (cap_inh_is_capped()&&
>             !cap_issubset(*inheritable,
>                           cap_combine(old->cap_inheritable,
> -                                     old->cap_permitted)))
> +                                     old->cap_permitted))) {
>                 /* incapable of using this inheritable set */
> +               printk("xuyang 0\n");
>                 return -EPERM;
> +       }
>
>         if (!cap_issubset(*inheritable,
>                           cap_combine(old->cap_inheritable,
> -                                     old->cap_bset)))
> +                                     old->cap_bset))) {
>                 /* no new pI capabilities outside bounding set */
> +               printk("xuyang 1\n");
>                 return -EPERM;
> +       }
>
>         /* verify restrictions on target's new Permitted set */
> -       if (!cap_issubset(*permitted, old->cap_permitted))
> +       if (!cap_issubset(*permitted, old->cap_permitted)) {
> +               printk("xuyang  2\n");
>                 return -EPERM;
> +       }
>
>         /* verify the _new_Effective_ is a subset of the _new_Permitted_ */
> -       if (!cap_issubset(*effective, *permitted))
> +       if (!cap_issubset(*effective, *permitted)) {
> +               printk("xuyang 3\n");
>                 return -EPERM;
> -
> +       }
>         new->cap_effective   = *effective;
>         new->cap_inheritable = *inheritable;
>
> #./cap_test  (dmesg will report "xuyang 3",return EPERM if use version 3)
>
> Thanks
> Yang Xu

Yes, sorry I should have said earlier. I am converting it to use 64bit
capabilities. Also I have created some tests for this and will try to
use the upper bits.

-- 
Thank you,
Richard.
