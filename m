From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 16 Jan 2019 12:12:02 +0100
Subject: [LTP] [PATCH v3] syscalls: Add set_mempolicy numa tests.
In-Reply-To: <728475501.93120973.1546515595304.JavaMail.zimbra@redhat.com>
References: <20181218155752.7028-1-chrubis@suse.cz>
 <728475501.93120973.1546515595304.JavaMail.zimbra@redhat.com>
Message-ID: <20190116111201.GC23245@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > +
> > +
> > +void tst_numa_alloc_parse(struct tst_nodemap *nodes, const char *path,
> > +                          unsigned int pages)
> 
> I'd change this to a function that only counts allocated pages,
> and increases counters.

Fair enough.

> > +{
> > +	size_t page_size = getpagesize();
> > +	char *ptr;
> > +	int fd = -1;
> > +	int flags = MAP_PRIVATE|MAP_ANONYMOUS;
> > +	int node;
> > +	unsigned int i;
> > +
> > +	if (path) {
> > +		fd = SAFE_OPEN(path, O_CREAT | O_EXCL | O_RDWR, 0666);
> > +		SAFE_FTRUNCATE(fd, pages * page_size);
> > +		flags = MAP_SHARED;
> > +	}
> > +
> > +	ptr = SAFE_MMAP(NULL, pages  * page_size,
> > +	                PROT_READ|PROT_WRITE, flags, fd, 0);
> > +
> > +	if (path) {
> > +		SAFE_CLOSE(fd);
> > +		SAFE_UNLINK(path);
> > +	}
> > +
> > +	memset(ptr, 'a', pages * page_size);
> 
> I think all the alloc stuff shouldn't be in library. It's quite
> possible tests will need different ways to allocate memory. 
> 
> Maybe the test will want to mmap, but not touch any pages,
> or pass different flags to mmap. Allocate with other functions
> than mmap, etc.

It should be put into some kind of common place though since it's used
from several tests even at this point.

What about splitting the tst_numa_alloc_parse() to tst_numa_alloc() and
tst_numa_parse() and keeping the functionality in the library?

-- 
Cyril Hrubis
chrubis@suse.cz
