From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 13 Sep 2017 14:44:56 +0200
Subject: [LTP] [PATCH] madvise07: Increase probability of testing a
 supported page type
In-Reply-To: <862571300.14738390.1505297297582.JavaMail.zimbra@redhat.com>
References: <20170828134827.5871-1-rpalethorpe@suse.com>
 <1387821959.5916937.1504079485373.JavaMail.zimbra@redhat.com>
 <20170912154523.GB31460@rei.lan>
 <862571300.14738390.1505297297582.JavaMail.zimbra@redhat.com>
Message-ID: <20170913124456.GA28447@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Wouldn't this mean that the API is broken by desing?
> > 
> > One thing is that the call does not work on an unmapped page and fails
> > to return an error. But if we cannot even guarantee that it will work
> > if we make an effort to fault the page in advance its horribly broken by
> > design.
> 
> I think Richard was talking about scenario where something happens
> to page you just faulted in, e.g. it's swapped out for some reason.
> That should be quite unlikely.

We can always mlock() the page if that ever happens...

> > > I don't have objections to patch, but I'm thinking if we should go
> > > further if there's possibility the test still won't be reliable.
> > > We could relax the condition, for example by FAILing only if
> > > child dies unexpectedly (signal != SIGBUS).
> > 
> > What would that mean, producing TCONF on any error from the madvise()
> > call? Looking at manual pages the only error we may get running
> > MADVISE_HWPOISON as a root on a mapped page is the EINVAL we handle
> > anyway.
> 
> I'd stay with just "mmap+touch anonymous memory" for now and see if
> that ever fails.

I've applied the patch from Richard.

-- 
Cyril Hrubis
chrubis@suse.cz
