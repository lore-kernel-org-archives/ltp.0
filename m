From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 3 May 2017 08:49:46 -0400 (EDT)
Subject: [LTP] [PATCH v2] mmapstress04: rewrite to fix heap overwrite
In-Reply-To: <20170503123541.GA794@rei.suse.de>
References: <3cd0bc26ccba6d0bc890952e12ee312f95eaeebc.1493801364.git.jstancek@redhat.com>
 <20170503123541.GA794@rei.suse.de>
Message-ID: <1681486633.6527722.1493815786828.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi!
> > +static void setup(void)
> > +{
> > +	page_size = getpagesize();
> > +
> > +	/*
> > +	 * Pick large enough area, PROT_NONE doesn't matter,
> > +	 * because we remap it later.
> > +	 */
> > +	mmap_area = SAFE_MMAP(NULL, page_size * NUM_PAGES, PROT_NONE,
> > +		MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
> > +}
> > +
> > +static void write_fully(int fd, void *buf, int len)
> > +{
> > +	do {
> > +		len -= SAFE_WRITE(0, fd, buf, len);
> > +		buf += len;
> 
> This appears to be wrong. If SAFE_WRITE() writes 1 byte we end up with
> offset len - 1 and lenght len - 1 which will cause reads outside of the
> buffer.

You're right, it's wrong :-(.

> 
> We have to do:
> 
> 		ret = SAFE_WRITE(...);
> 		buf += ret;
> 		len -= ret;
> 
> > +	} while (len > 0);
> > +}
> 
> Otherwise it's fine. Acked with the write function fixed.

Fixed and pushed.

Regards,
Jan
