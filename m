From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 12 Sep 2017 17:45:24 +0200
Subject: [LTP] [PATCH] madvise07: Increase probability of testing
	a	supported page type
In-Reply-To: <1387821959.5916937.1504079485373.JavaMail.zimbra@redhat.com>
References: <20170828134827.5871-1-rpalethorpe@suse.com>
 <1387821959.5916937.1504079485373.JavaMail.zimbra@redhat.com>
Message-ID: <20170912154523.GB31460@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > We were attempting to poison page types which do not support it (e.g. the
> > zero
> > page) due to our usage of mmap. Now we map some anonymous memory and write to
> > it. Hopefully ensuring the underlying page is of a supported type.
> > + * If the underlying page type of the memory we have mapped does not support
> > + * poisoning then the test will fail. We try to map and write to the memory
> > in
> > + * such a way that by the time madvise is called the virtual memory address
> > + * points to a supported page. However there may be some rare circumstances
> > + * where the test produces the wrong result because we have somehow obtained
> > + * an unsupported page.
> 
> Hi,
> 
> Can you elaborate please? If we always do mmap+touch anonymous memory,
> how would we sometime end up with different page type?

Wouldn't this mean that the API is broken by desing?

One thing is that the call does not work on an unmapped page and fails
to return an error. But if we cannot even guarantee that it will work
if we make an effort to fault the page in advance its horribly broken by
design.

> I don't have objections to patch, but I'm thinking if we should go
> further if there's possibility the test still won't be reliable.
> We could relax the condition, for example by FAILing only if
> child dies unexpectedly (signal != SIGBUS).

What would that mean, producing TCONF on any error from the madvise()
call? Looking at manual pages the only error we may get running
MADVISE_HWPOISON as a root on a mapped page is the EINVAL we handle
anyway.

-- 
Cyril Hrubis
chrubis@suse.cz
