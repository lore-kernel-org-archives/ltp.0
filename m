From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 30 Jul 2021 13:54:55 +0200
Subject: [LTP] [PATCH 3/3] mbind01: add more tests for MPOL_LOCAL
In-Reply-To: <CAEemH2e04E_dhqBzJVWXX_ux6rx-Pev+gp1Piv9VJ8FC-cSutQ@mail.gmail.com>
References: <20210729132514.1699551-1-liwang@redhat.com>
 <20210729132514.1699551-3-liwang@redhat.com>
 <CAASaF6yQkiZVPWpsoo0ZrryBGFdLSGo3kkoejeWcy8dQMSL3yw@mail.gmail.com>
 <CAEemH2cJHtVkaaH5OokAHfVLzPdxU=SqiCf_Gg_ntX_fnWorYw@mail.gmail.com>
 <CAASaF6x2pTo1kMXy+nPJT+B9nEZ4Z+ovNzjtfW5f2WEq1fxc0g@mail.gmail.com>
 <CAEemH2e04E_dhqBzJVWXX_ux6rx-Pev+gp1Piv9VJ8FC-cSutQ@mail.gmail.com>
Message-ID: <CAASaF6wOz0BX6z0w0LroG8XKgp-NSsGWyu=_rj2pKvZfFwBU0A@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

>
> Or, If we want something more precise, just cancel the
> check_policy_pref_or_local on kernel >= 5.14.
>
> Is this sound better?
>
> -       if ((tst_kvercmp(3, 8, 0)) < 0 && (tc->policy == MPOL_LOCAL)) {
> -               tst_res(TCONF, "%s is not supported",
> tst_mempolicy_mode_name(tc->policy));
> -               return;
>
> +       if (tc->policy == MPOL_LOCAL) {
> +               if ((tst_kvercmp(3, 8, 0)) < 0) {
> +                       tst_res(TCONF, "%s is not supported",
> tst_mempolicy_mode_name(tc->policy));
> +                       return;
> +               }
> +
> +               if ((tst_kvercmp(5, 14, 0)) >= 0)
> +                       tc->check_policy = NULL;
>
>
Yes, that works too.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210730/78002607/attachment.htm>
