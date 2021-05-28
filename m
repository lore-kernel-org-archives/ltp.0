From: Li Wang <liwang@redhat.com>
Date: Fri, 28 May 2021 16:22:42 +0800
Subject: [LTP] [PATCH v2 5/6] API/cgroups: tst_require fail gracefully
 with unknown controller
In-Reply-To: <87mtsgjjiz.fsf@suse.de>
References: <20210521102528.21102-1-rpalethorpe@suse.com>
 <20210521102528.21102-6-rpalethorpe@suse.com>
 <CAEemH2cqGGJuF56LpVO9egB7eLLCLdcXKaVA_2dkFRFmN8=jKw@mail.gmail.com>
 <87mtsgjjiz.fsf@suse.de>
Message-ID: <CAEemH2d8dVjhNbD_1ayPhz+Y7+rGGyVn+M6T03YkF=Wy_DErew@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> >> +       if (!ctrl) {
> >> +               tst_brk(TBROK, "'%s' controller is unknown to LTP", ctrl_name);
> >> +               tst_brk(TBROK, "Calling %s in cleanup?", __func__);
> >> +               return;
> >
> > It'd never go here to perform a return because the first tst_brk
> > will break the test directly. And, I don't know why we need the
> > second tst_brk to show calling in cleanup, is that possible?
>
> It can return if it is called during cleanup. tst_cgroup_require should
> not be called from cleanup. However someone can do it by accident.

Well, I see. But TBH, here worries too much about the unexpected situation:).

> We probably need two versions of tst_brk. One which can return if called
> from cleanup and one which does not. I suspect most tst_brk callers
> assume it will not return. It is really only some safe library functions
> which can handle that.

Yes, sounds reasonable to me.

[Cc Cyril if he has more advice on this]

--
Regards,
Li Wang

