From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 6 Oct 2016 09:16:08 +0200
Subject: [LTP] [PATCH 1/2] syscalls: new test writev07
In-Reply-To: <1642663993.652860.1475684463479.JavaMail.zimbra@redhat.com>
References: <c6be7469f0f59fa5c0d65e9466d0d9686a1251b3.1475670993.git.jstancek@redhat.com>
 <20161005152331.GC23476@rei.lan>
 <1642663993.652860.1475684463479.JavaMail.zimbra@redhat.com>
Message-ID: <20161006071607.GA4975@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Hmm, we have tst_resm_hexd() in the old library exactly for this purpose
> > but it's not exported to the new library at this point. We should fix
> > that and make use of it here.
> > 
> > > +static void test_partially_valid_iovec(int initial_file_offset)
> > > +{
> > > +	int i, fd;
> > > +	unsigned char buffer[BUFSIZE], fpattern[BUFSIZE], tmp[BUFSIZE];
> > > +	long off_after;
> > > +	struct iovec wr_iovec[] = {
> > > +		{ buffer + CHUNK, CHUNK * 2 },
> > > +		{ bad_addr, CHUNK },
> > > +		{ buffer + CHUNK * 3, CHUNK },
> > > +		{ buffer + CHUNK * 2, CHUNK * 2 },
> > > +	};
> > 
> > Hmm, I fail to see the logic after the buffer and CHUNK here. Why don't
> > we start from the start of the buffer for the first iovec record?
> 
> We can, I picked random offset and lengths.
> 
> > 
> > Why is the BUFSIZE defined as CHUNK * 8 while the only CHUNK * 4 could
> > be reached here?
> 
> BUFSIZE should also be large enough to accomodate all writes combined,
> so in worst case (if bad_addr somehow worked) you need CHUNK * 6.
> I picked 8 to have some reserve. I can rework it just to CHUNK * 4 size.

Nah, just let it be. I was just wondering if there is a deeper meaning
behind these.

-- 
Cyril Hrubis
chrubis@suse.cz
