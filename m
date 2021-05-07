From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 7 May 2021 17:39:45 +0200
Subject: [LTP] [PATCH v2 2/2] shell: Prevent orphan timeout sleep
 processes
In-Reply-To: <CAEemH2fgcFm4tsJdtj+J=sqvOy24w54QR+7M=Bhk2E7NDE68Gg@mail.gmail.com>
References: <20210507103258.232174-1-lkml@jv-coder.de>
 <20210507103258.232174-3-lkml@jv-coder.de>
 <CAEemH2fucJPyeTL-HZJD92ves7GLMaMHcaPzi8kS_qWL+x=Hcg@mail.gmail.com>
 <YJVNKebKn6jTvyG/@pevik>
 <CAEemH2fgcFm4tsJdtj+J=sqvOy24w54QR+7M=Bhk2E7NDE68Gg@mail.gmail.com>
Message-ID: <YJVfQanq/HPXnfi1@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

> > > But there is another issue I found that the timeout03 can NOT
> > > be killed after timed out in calling cleanup(), the reason is
> > > tst_brk stop the _tst_kill_test running in the background so that
> > > it does not output as what we expected:
> > Good catch, I'll try to have a look as well.

> The simplest way I can think of is to let _tst_kill_test ignores
> the TERM and INT signals. If you agree to this, we can fix it in
> a separate patch:).

> --- a/testcases/lib/tst_test.sh
> +++ b/testcases/lib/tst_test.sh
> @@ -439,6 +439,8 @@ _tst_kill_test()
>  {
>         local i=10

> +       trap " " TERM INT
Acked-by: Petr Vorel <pvorel@suse.cz>

Thanks!

BTW I'm surprised " " works, I'd expect : would have to be used.

Kind regards,
Petr
