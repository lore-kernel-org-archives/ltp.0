From: Li Wang <liwang@redhat.com>
Date: Sat, 8 May 2021 11:57:00 +0800
Subject: [LTP] [PATCH v2 2/2] shell: Prevent orphan timeout sleep
 processes
In-Reply-To: <YJVfQanq/HPXnfi1@pevik>
References: <20210507103258.232174-1-lkml@jv-coder.de>
 <20210507103258.232174-3-lkml@jv-coder.de>
 <CAEemH2fucJPyeTL-HZJD92ves7GLMaMHcaPzi8kS_qWL+x=Hcg@mail.gmail.com>
 <YJVNKebKn6jTvyG/@pevik>
 <CAEemH2fgcFm4tsJdtj+J=sqvOy24w54QR+7M=Bhk2E7NDE68Gg@mail.gmail.com>
 <YJVfQanq/HPXnfi1@pevik>
Message-ID: <CAEemH2cjDZVq0iJ28R-x8VPzJT71EZnUY-wuKjDLOz_+Uhsa5A@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> > --- a/testcases/lib/tst_test.sh
> > +++ b/testcases/lib/tst_test.sh
> > @@ -439,6 +439,8 @@ _tst_kill_test()
> >  {
> >         local i=10
>
> > +       trap " " TERM INT

Seems no need to ignore the SIGTERM, because it only sends in
the early (before timeout) phase, the _tst_kill_test has no chance
to catch a SIGTERM.

> Acked-by: Petr Vorel <pvorel@suse.cz>

Thanks for the review! I will send a patch for it.

>
> Thanks!
>
> BTW I'm surprised " " works, I'd expect : would have to be used.

" " or '' define none string makes it ignore signals.

-- 
Regards,
Li Wang

