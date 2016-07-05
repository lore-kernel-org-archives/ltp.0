From: Han Pingtian <hanpt@linux.vnet.ibm.com>
Date: Tue, 5 Jul 2016 09:22:36 +0800
Subject: [LTP] [PATCH] kernel/numa: sleep 2s in test01 for waiting
 numastat updating
In-Reply-To: <20160531164504.GE14283@rei.lan>
References: <CAAUgArBQ_D+wY+48YO6VYPWYM70hxr98YshcRRkXDYSoz2VZQg@mail.gmail.com>
 <20160530115554.GB6079@rei>
 <CAAUgArD-x-1w9GOg1gaExOiAGoFYwiRChMjB3GkNT+ZJh8Z+Tg@mail.gmail.com>
 <20160531164504.GE14283@rei.lan>
Message-ID: <20160705012236.GA3581@localhost.localdomain>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, May 31, 2016 at 06:45:05PM +0200, Cyril Hrubis wrote:
> Hi!
> > > What we should do instead is to get the new stastistic in loop with a
> > > short (~0.1s) sleep util we get the expected value or until timeout has
> > > been reached (~10s). And this should be done ideally as a function
> > > called from each of the numa tests.
> > >
> > 
> > I think we should not wait for 10s, it is a bit longer, the test will
> > pass no matter we
> > add "numactl --cpunodebind=$node --membind=$node support_numa
> > $ALLOC_1MB" or not.
> 
> Hmm, we are looking at accumulated statistics. So some of the tests will
> just pass as other processes allocate memory as well.
> 
> > I suppose maybe we could refine the support_numa  to make it allocate
> > a bigger memory and run for a while rather than return immediately.
> 
> I wonder if there is a file in /proc/ that could be used to determine on
> which numa node is the page allocated on. There is /proc/$pid/pagemap
> that could be used to map address to someting that could used to seek in
> /proc/kpageflags that can be used to get quite a lot of information
> about the page state but not on which numa node it is allocated on...
> 
On two systems with two different beta distros, test01 always fail even
after adding 'sleep 2s'. Looks like there is no guarantee when naumstat
will be updated at all.

One distro uses a 4.4.13 kernel, the other uses a 4.4.0 kernel.

