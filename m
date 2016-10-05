From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 5 Oct 2016 12:21:03 -0400 (EDT)
Subject: [LTP] [PATCH 1/2] syscalls: new test writev07
In-Reply-To: <20161005152331.GC23476@rei.lan>
References: <c6be7469f0f59fa5c0d65e9466d0d9686a1251b3.1475670993.git.jstancek@redhat.com>
 <20161005152331.GC23476@rei.lan>
Message-ID: <1642663993.652860.1475684463479.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Wednesday, 5 October, 2016 5:23:31 PM
> Subject: Re: [LTP] [PATCH 1/2] syscalls: new test writev07
> 
> Hi!
> > +#define TESTFILE "testfile"
> > +#define CHUNK 64
> > +#define BUFSIZE (CHUNK * 8)
> > +
> > +static void *bad_addr;
> > +
> > +static void dump_buf(unsigned char *buf, int len)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < len; i++) {
> > +		printf("0x%02x ", *(buf + i));
> > +		if (i % 16 == 15)
> > +			printf("\n");
> > +	}
> > +	printf("\n");
> > +}
> 
> Hmm, we have tst_resm_hexd() in the old library exactly for this purpose
> but it's not exported to the new library at this point. We should fix
> that and make use of it here.
> 
> > +static void test_partially_valid_iovec(int initial_file_offset)
> > +{
> > +	int i, fd;
> > +	unsigned char buffer[BUFSIZE], fpattern[BUFSIZE], tmp[BUFSIZE];
> > +	long off_after;
> > +	struct iovec wr_iovec[] = {
> > +		{ buffer + CHUNK, CHUNK * 2 },
> > +		{ bad_addr, CHUNK },
> > +		{ buffer + CHUNK * 3, CHUNK },
> > +		{ buffer + CHUNK * 2, CHUNK * 2 },
> > +	};
> 
> Hmm, I fail to see the logic after the buffer and CHUNK here. Why don't
> we start from the start of the buffer for the first iovec record?

We can, I picked random offset and lengths.

> 
> Why is the BUFSIZE defined as CHUNK * 8 while the only CHUNK * 4 could
> be reached here?

BUFSIZE should also be large enough to accomodate all writes combined,
so in worst case (if bad_addr somehow worked) you need CHUNK * 6.
I picked 8 to have some reserve. I can rework it just to CHUNK * 4 size.

Regards,
Jan


