From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 16 Jan 2019 13:36:21 +0100
Subject: [LTP] [PATCH v3] syscalls: Add set_mempolicy numa tests.
In-Reply-To: <1825051207.96340275.1547639365640.JavaMail.zimbra@redhat.com>
References: <20181218155752.7028-1-chrubis@suse.cz>
 <728475501.93120973.1546515595304.JavaMail.zimbra@redhat.com>
 <20190116111201.GC23245@rei.lan>
 <1825051207.96340275.1547639365640.JavaMail.zimbra@redhat.com>
Message-ID: <20190116123621.GA24833@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > > I think all the alloc stuff shouldn't be in library. It's quite
> > > possible tests will need different ways to allocate memory.
> > > 
> > > Maybe the test will want to mmap, but not touch any pages,
> > > or pass different flags to mmap. Allocate with other functions
> > > than mmap, etc.
> > 
> > It should be put into some kind of common place though since it's used
> > from several tests even at this point.
> 
> set_mempolicy sub-dir?

That wouldn't not work once I will add mbind tests.

> > What about splitting the tst_numa_alloc_parse() to tst_numa_alloc() and
> > tst_numa_parse() and keeping the functionality in the library?
> 
> That looks more flexible.
> 
> Though I'm not 100% sold on single alloc func in library. My concern is
> it will be difficult for it to cover all possible scenarios and API
> will keep changing as we find more.

The worst that can happen is that we will end up with a few alloc
functions each for different purpose, but I do not think that this is
necessarily bad.

-- 
Cyril Hrubis
chrubis@suse.cz
