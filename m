From: Matthias Maennich <maennich@google.com>
Date: Wed, 13 Mar 2019 11:42:37 +0000
Subject: [LTP] [PATCH v1] rt_sigpending02: reuse code from sigpending02
In-Reply-To: <20190313094228.GA24870@rei.lan>
References: <20190308163832.212631-1-maennich@google.com>
 <64d5553d-ac2d-fd8a-03d1-7cd05d1deeeb@google.com>
 <20190313094228.GA24870@rei.lan>
Message-ID: <20190313114237.GA261142@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!

On Wed, Mar 13, 2019 at 10:42:28AM +0100, Cyril Hrubis wrote:
> Hi!
> > One downside with this multiplexed approach is that we then don't have 
> > an entry in the testcases/kernel/syscalls/ directory for all syscalls 
> > which can cause some confusion, but that could perhaps be addressed by 
> > adding symlinks for the missing ones.
I am not sure multiplexing is the right approach here (not saying it is not!).
In case of (rt_)sigpending, I would like to see them as separate binaries that
effectively do disjunct things. There might be the case that sigpending is not
available on that particular kernel and rt_sigpending is. I would like the
sigpending to fail with TCONF and the rt_sigpending to TPASS in that case. Is
that something that can be achieved with multiplexing?

I was already working on a v2 of this patch set to add a further test case and
will send this out shortly. I would like to reconsider multiplexing at a later
time and for now follow the pattern of other syscall related tests like
sigwait, sigtimedwait, rt_sigtimedwait.

> 
> Actually my long term plan is to include metadata in the testcases which
> would, among other things, describe which syscalls/libcalls the tests is
> excercising and I want this information to be propagated to the test
> runner as well, so instead of relying on one binary file per syscall we
> would have proper metadata describing the tests.
> 
> And the biggest problem here is that it looks that there is very little
> interest in investing time into this approach. I've send a (quick and
> dirty) RFC patch that tried to show a direction for such work, but
> nearly nobody replied to it, so I postponed the work a bit.
> 
> See:
> 
> http://patchwork.ozlabs.org/project/ltp/list/?series=78493
That looks actually promising. I will have a more detailed look these days!

-- 
Cheers,
Matthias
