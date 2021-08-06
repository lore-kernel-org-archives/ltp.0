From: Li Wang <liwang@redhat.com>
Date: Fri, 6 Aug 2021 18:18:18 +0800
Subject: [LTP] [COMMITTED] setsockopt08: includes netinet/in.h
In-Reply-To: <YQ0C1givEZ8/H7hN@pevik>
References: <20210806025659.1962902-1-liwang@redhat.com>
 <YQzLUUKbLcoJjRVb@pevik> <YQzOxg35JjpDOj7X@pevik>
 <CAEemH2cNk-L1kRRHy=vvLVjcEm0HPQXaz8fJR00M1TyzoJAynw@mail.gmail.com>
 <YQ0C1givEZ8/H7hN@pevik>
Message-ID: <CAEemH2eCbTeTziGetR-mBRP9rB=0S2CvZNuDv-3DehksKUyu8A@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> > The conflict happened early in tst_test.h and I guess some header files
> > between line#14 to line#44 probably involves <linux/if.h>, but I'm not
> sure
> > which one is the culprit.
> Interesting, really something in in tst_test.h with combination of
> lapi/ip_tables.h. This combination is only in 2 tests, setsockopt0{3,8}.c,
> setsockopt03.c already had <netinet/in.h>.
>

I eventually caught that "tst_capability.h" is the key point.
To includes <netinet/in.h> before that can avoid the conflict.

But still not sure how it made things broken (i.e. where includes
 <linux/if.h>).


> > If we simply put the <netinet/in.h> at the top of tst_test.h, the
> > conflict disappears
> > as well.
> > See experiment commit:
> >
> https://github.com/wangli5665/ltp/commit/0155df479811d9a51f30e09accb330238607f73d
>
> I'd be for adding it there, with comment why it's there. We can prevent
> problems
> with failing another test in the future. (+ remove it from both tests).
>

I'm OK with this fix.

@Cyril, @Richard, what do you think? any other thoughts?

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210806/eb7401a6/attachment.htm>
