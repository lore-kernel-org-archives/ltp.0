From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 31 May 2016 18:45:05 +0200
Subject: [LTP] [PATCH] kernel/numa: sleep 2s in test01 for waiting
 numastat updating
In-Reply-To: <CAAUgArD-x-1w9GOg1gaExOiAGoFYwiRChMjB3GkNT+ZJh8Z+Tg@mail.gmail.com>
References: <CAAUgArBQ_D+wY+48YO6VYPWYM70hxr98YshcRRkXDYSoz2VZQg@mail.gmail.com>
 <20160530115554.GB6079@rei>
 <CAAUgArD-x-1w9GOg1gaExOiAGoFYwiRChMjB3GkNT+ZJh8Z+Tg@mail.gmail.com>
Message-ID: <20160531164504.GE14283@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > What we should do instead is to get the new stastistic in loop with a
> > short (~0.1s) sleep util we get the expected value or until timeout has
> > been reached (~10s). And this should be done ideally as a function
> > called from each of the numa tests.
> >
> 
> I think we should not wait for 10s, it is a bit longer, the test will
> pass no matter we
> add "numactl --cpunodebind=$node --membind=$node support_numa
> $ALLOC_1MB" or not.

Hmm, we are looking at accumulated statistics. So some of the tests will
just pass as other processes allocate memory as well.

> I suppose maybe we could refine the support_numa  to make it allocate
> a bigger memory and run for a while rather than return immediately.

I wonder if there is a file in /proc/ that could be used to determine on
which numa node is the page allocated on. There is /proc/$pid/pagemap
that could be used to map address to someting that could used to seek in
/proc/kpageflags that can be used to get quite a lot of information
about the page state but not on which numa node it is allocated on...

-- 
Cyril Hrubis
chrubis@suse.cz
