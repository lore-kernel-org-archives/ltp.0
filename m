From: Feng Tang <feng.tang@intel.com>
Date: Fri, 30 Jul 2021 19:35:34 +0800
Subject: [LTP] [PATCH 3/3] mbind01: add more tests for MPOL_LOCAL
In-Reply-To: <CAEemH2cJHtVkaaH5OokAHfVLzPdxU=SqiCf_Gg_ntX_fnWorYw@mail.gmail.com>
References: <20210729132514.1699551-1-liwang@redhat.com>
 <20210729132514.1699551-3-liwang@redhat.com>
 <CAASaF6yQkiZVPWpsoo0ZrryBGFdLSGo3kkoejeWcy8dQMSL3yw@mail.gmail.com>
 <CAEemH2cJHtVkaaH5OokAHfVLzPdxU=SqiCf_Gg_ntX_fnWorYw@mail.gmail.com>
Message-ID: <20210730113534.GB87305@shbuild999.sh.intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,



On Fri, Jul 30, 2021 at 04:03:28PM +0800, Li Wang wrote:

[....]
> On Thu, Jul 29, 2021 at 10:20 PM Jan Stancek <jstancek@redhat.com> wrote:
> >> @@ -101,6 +101,20 @@ static struct test_case tcase[] = {
> >>                 .test = test_default,
> >>                 .exp_nodemask = &nodemask,
> >>         },
> >> +       {
> >> +               POLICY_DESC(MPOL_LOCAL),
> >> +               .ret = 0,
> >> +               .err = 0,
> >> +               .test = test_none,
> >> +               .exp_nodemask = &empty_nodemask,
> >> +               .check_policy = check_policy_pref_or_local,
> >>
> >
> > This is a bit more permissive, it allows for MPOL_LOCAL to return also
> > MPOL_PREFERRED.
> > Shouldn't that still be treated as error?
> >
> 
> To strictly this should be an error.
> 
> But I slightly think that it's acceptable to get 'MPOL_PREFERRED' on the old
> kernel (i.e. 4.18.0, v5.13) because 'MPOL_LOCAL' is not treated as a real
> policy.
> And the situation exists for quite a long time.
> 
>   7858d7bca7fb ("mm/mempolicy: don't handle MPOL_LOCAL like a fake
>   MPOL_PREFERRED policy")
> 
> Without this kernel commit, looks like the MPOL_LOCAL will convert to
> MPOL_PREFERRED in mpol_new.
> 
> SYSCAL_DEFINE6(mbind, ...)
>  kernel_mbind
>   do_mbind
>    mpol_new
>      ....
> 
> # cat mempolicy.c -n
> 
>    287          /*
>    288           * MPOL_PREFERRED cannot be used with MPOL_F_STATIC_NODES or
>    289           * MPOL_F_RELATIVE_NODES if the nodemask is empty (local
> allocation).
>    290           * All other modes require a valid pointer to a non-empty
> nodemask.
>    291           */
>    292          if (mode == MPOL_PREFERRED) {
>    293                  if (nodes_empty(*nodes)) {
>    294                          if (((flags & MPOL_F_STATIC_NODES) ||
>    295                               (flags & MPOL_F_RELATIVE_NODES)))
>    296                                  return ERR_PTR(-EINVAL);
>    297                  }
>    298          } else if (mode == MPOL_LOCAL) {
>    299                  if (!nodes_empty(*nodes) ||
>    300                      (flags & MPOL_F_STATIC_NODES) ||
>    301                      (flags & MPOL_F_RELATIVE_NODES))
>    302                          return ERR_PTR(-EINVAL);
>    303                  mode = MPOL_PREFERRED;    <--------- this line has
> been removed after the commit
>    304          } else if (nodes_empty(*nodes))
>    305                  return ERR_PTR(-EINVAL);
> 
> But maybe I was wrong here, CC FengTang in case he has suggestions on this.

Yes, you are right. With the commit MPOL_LOCAL will be taken as a real
policy, be MPOL_LOCAL itself, and not a fake MPOL_PREFERRED.   

Faking MPOL_LOCAL as a MPOL_PREFERRED makes the semantic very confusing, 
and the kenrel code is also very confusing and difficult to be maintained,
as there are many ambiguous logic to check this faking and transform the 
policy back and forth. So we chosed to clean it up.

Thanks,
Feng

> 
> >
> >> +       if ((tst_kvercmp(3, 8, 0)) < 0 && (tc->policy == MPOL_LOCAL)) {
> >> +               tst_res(TCONF, "%s is not supported",
> >> tst_mempolicy_mode_name(tc->policy));
> >> +               return;
> >> +       }
> >>
> >
> > I was thinking of runtime check (to support also downstream kernels that
> > backported it),
> > but I don't have strong opinion.
> >
> 
> Thanks, I assume there is little probability to backport it.
> 
> -- 
> Regards,
> Li Wang
