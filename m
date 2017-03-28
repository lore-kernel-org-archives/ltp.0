From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 28 Mar 2017 12:23:17 +0200
Subject: [LTP] [PATCH] lseek: functional SEEK_HOLE and SEEK_DATA test
In-Reply-To: <20170328101742.GW21915@dhcp12-143.nay.redhat.com>
References: <1490254129-24570-1-git-send-email-zlang@redhat.com>
 <20170327142631.GC21272@rei.lan>
 <20170328101742.GW21915@dhcp12-143.nay.redhat.com>
Message-ID: <20170328102317.GD1045@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > > +	/* reset to the original state */
> > > +	SAFE_LSEEK(fd, 0, SEEK_SET);
> > > +	SAFE_FTRUNCATE(fd, 0);
> > 
> > Can't we get this information from stat() or from sysfs?
> >
> 
> No, we can't make sure always get a real block size from stat().
> For XFS, it can. But when I get on some un-local filesystem, e.g: glusterfs.
> stat return 1M for st_blksize, but the truth is not.
> 
> The st_blksize field gives the "preferred" blocksize for efficient
> filesystem I/O. Not real filesystem block size to allocate space.
> 
> I want to have a better method than what I used above too :)
> 
> > We are testing the SEEK_HOLE here, it would make sense to obtain it from
> > a different source...
> 
> Do you mean move this function to common function?

I meant from a different kernel interface, but if that is not possible,
we don't have a choice.

Have you tried asking kernel fs devs if this information is exported
somewhere?

> > > +	sprintf(buf, "data%02dsuffix", num);
> > > +	count = strlen(buf);
> > > +
> > > +	/* make sure all data can be written */
> > > +	while (count > 0) {
> > > +		rc = write(fd, p, count);
> > > +		if (rc < 0) {
> > > +			tst_brk(TBROK | TERRNO, "write failed");
> > > +			break;
> > > +		}
> > > +		p += rc;
> > > +		count -= rc;
> > > +	}
> > 
> > Are you sure that the write for that short string could actually write
> > only part of the data? Cannot we rather use the SAFE_WRITE() and expect
> > it to be written in one write() call?
> 
> OK, I prefer to use a common function.
> 
> I think 99.99% rate one write() can write all data into file, but I can't
> make sure about that, because the (man 2 write) said:
> 
> "On success, the number of bytes written is returned (zero indicates
> nothing was written). It is not an error if  this  number  is smaller
> than the number of bytes requested; this may happen for example
> because the disk device was filled."
> 
> As our test results, SAFE_WRITE sometimes failed likes:
> 
> growfiles(gf17): 5347 growfiles.c/2249: 14671 tlibio.c/744 write(6, buf, 5000) returned=4096
> 
> I haven't looked into it, so I can't be sure if it's SAFE_WRITE's bug.

I would expect that write smaller than certain size will never do
a partial write to a file and 12 bytes looks small enough to me.

-- 
Cyril Hrubis
chrubis@suse.cz
