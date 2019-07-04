From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 4 Jul 2019 09:19:02 -0400 (EDT)
Subject: [LTP] [PATCH] direct_io: diotest4: fix mips
 MAP_SHARED/MAP_FIXED mmap
In-Reply-To: <20190704130119.GA11421@rei.lan>
References: <47b8b48060353711ff8d3695a7d3702f1aced12a.1562224996.git.jstancek@redhat.com>
 <20190704130119.GA11421@rei.lan>
Message-ID: <594163584.31676743.1562246342334.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi!
> > diff --git a/include/lapi/mmap.h b/include/lapi/mmap.h
> > index 18547c0d47ed..98b6ade1e2ab 100644
> > --- a/include/lapi/mmap.h
> > +++ b/include/lapi/mmap.h
> > @@ -19,6 +19,8 @@
> >  #ifndef LAPI_MMAP_H__
> >  #define LAPI_MMAP_H__
> >  
> > +#include "config.h"
> > +
> >  #ifndef MAP_HUGETLB
> >  # define MAP_HUGETLB 0x40000
> >  #endif
> 
> Huh, this looks completely unrelevant to the patch itself, or do I miss
> something?

This fixes the original problem of bad alignment.
Hunk below improves on it by removing MAP_FIXED altogether.

I could split it into 2 patches, if you prefer that.

> 
> > diff --git a/testcases/kernel/io/direct_io/diotest4.c
> > b/testcases/kernel/io/direct_io/diotest4.c
> > index e4616e400abd..bf200cd41a27 100644
> > --- a/testcases/kernel/io/direct_io/diotest4.c
> > +++ b/testcases/kernel/io/direct_io/diotest4.c
> > @@ -352,18 +352,14 @@ int main(int argc, char *argv[])
> >  	total++;
> >  
> >  	/* Test-10: read, write to a mmaped file */
> > -	shm_base = (char *)(((long)sbrk(0) + (shmsz - 1)) & ~(shmsz - 1));
> > -	if (shm_base == NULL) {
> > -		tst_brkm(TBROK, cleanup, "sbrk failed: %s", strerror(errno));
> > -	}
> >  	offset = 4096;
> >  	count = bufsize;
> >  	if ((fd = open(filename, O_DIRECT | O_RDWR)) < 0) {
> >  		tst_brkm(TBROK, cleanup, "can't open %s: %s",
> >  			 filename, strerror(errno));
> >  	}
> > -	shm_base = mmap(shm_base, 0x100000, PROT_READ | PROT_WRITE,
> > -			MAP_SHARED | MAP_FIXED, fd, 0);
> > +	shm_base = mmap(0, 0x100000, PROT_READ | PROT_WRITE,
> > +			MAP_SHARED, fd, 0);
> >  	if (shm_base == (caddr_t) - 1) {
> >  		tst_brkm(TBROK, cleanup, "can't mmap file: %s",
> >  			 strerror(errno));
> 
> Agree here, the part that computes the mmap addres based on the sbrk()
> output looks completely bogus to me.
> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
