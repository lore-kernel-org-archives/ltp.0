From: Li Wang <liwang@redhat.com>
Date: Mon, 9 Aug 2021 12:03:15 +0800
Subject: [LTP] [COMMITTED] setsockopt08: includes netinet/in.h
In-Reply-To: <874kc2n8tx.fsf@suse.de>
References: <20210806025659.1962902-1-liwang@redhat.com>
 <YQzLUUKbLcoJjRVb@pevik> <YQzOxg35JjpDOj7X@pevik>
 <CAEemH2cNk-L1kRRHy=vvLVjcEm0HPQXaz8fJR00M1TyzoJAynw@mail.gmail.com>
 <YQ0C1givEZ8/H7hN@pevik>
 <CAEemH2eCbTeTziGetR-mBRP9rB=0S2CvZNuDv-3DehksKUyu8A@mail.gmail.com>
 <874kc2n8tx.fsf@suse.de>
Message-ID: <CAEemH2dXGdWoA1CLoxYnVkkN1pNL3mZzU4XU=zwX_1dvpK9RcA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richard,


> >> I'd be for adding it there, with comment why it's there. We can prevent
> >> problems
> >> with failing another test in the future. (+ remove it from both tests).
> >>
> >
> > I'm OK with this fix.
> >
> > @Cyril, @Richard, what do you think? any other thoughts?
>
> We need to clean up our headers, which is a bigger problem. Most tests
> do not need all the stuff in tst_test.h. It is just a load of unecessary
> work.
>

Yes, I agree. It benefits for long-term maintenance of LTP.
So maybe a good start is to be more strict in review new
patches especially on the includes header check.


>
> Cleaning up the headers is a big challenge. It would be easier if we
> know what will break older distros. So I suggest adding something like:
>
> #ifdef _X_H
> # error "You should include X before Y ..."
> #endif
>
>
Hmm, it's right, but I'm afraid we have to define that in many places
because include headers are sometimes dispersive or singly.

I.e.

We need to define the above hint duplicated for everywhere if includes
the <netinet/in.h>, to avoid include <linux/in.h> before it. This will
look a bit messy I feel.

$ git grep netinet/in.h
lapi/netinet_in.h:#include <netinet/in.h>
old/old_safe_net.h:#include <netinet/in.h>
safe_net_fn.h:#include <netinet/in.h>
tst_net.h:#include <netinet/in.h>
tst_safe_net.h:#include <netinet/in.h>


> to one or more headers.
>
> Otherwise I'm fine with the above solution as a "temporary" fix.
>


-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210809/12a4a456/attachment.htm>
