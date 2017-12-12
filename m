From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 12 Dec 2017 04:26:05 -0500 (EST)
Subject: [LTP] [PATCH v2 2/2] pthread_create-14-1: avoid threads sharing
 stack
In-Reply-To: <20171211143850.GA12716@rei>
References: <a79545c7338fa1e9df27b43dd37d5538360f20c5.1512568550.git.jstancek@redhat.com>
 <3e635415d2f7fd5e79ade01df9214e083a28bc6b.1512568550.git.jstancek@redhat.com>
 <20171211143850.GA12716@rei>
Message-ID: <1721839199.53982933.1513070765015.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi!
> > +static unsigned long current_time_usec(void)
> > +{
> > +	struct timeval now;
> > +
> > +	SAFE_FUNC(gettimeofday(&now, NULL));
> > +	return now.tv_sec * 1000000 + now.tv_usec;
> > +}
> 
> Looking into this closely wouldn't this overflow on 32bit where
> sizeof(long) == 4 ?
> 
> So this functions has to return long long which should be 64 bit even on
> 32bit archs.
> 
> Sorry for not catching that in the first review.
> 
> 
> Acked with fix fix for the overflow.

Pushed with long long. I did same change to pthread_detach-4-3,
where I made the same mistake years ago.

I'm thinking if we could re-use include/tst_timer.h in open_posix tests.

Regards,
Jan
