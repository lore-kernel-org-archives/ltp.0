From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 21 Feb 2020 11:19:14 +0100
Subject: [LTP] [PATCH] Add test for CVE 2017-10661
In-Reply-To: <8736b4gya0.fsf@our.domain.is.not.set>
References: <20200220144559.22440-1-mdoucha@suse.cz>
 <8736b4gya0.fsf@our.domain.is.not.set>
Message-ID: <20200221101913.GA24332@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > +static int fd = -1;
> > +static struct itimerspec its;
> > +static struct tst_fzsync_pair fzsync_pair;
> > +
> > +static void setup(void)
> > +{
> > +	int tmp;
> 
> All variables are temporary.
> 
> > +
> > +	tst_taint_init(TST_TAINT_W | TST_TAINT_D);
> > +	fd = timerfd_create(CLOCK_REALTIME, 0);
> > +
> > +	if (fd < 0) {
> > +		tmp = (errno == ENOTSUP ? TCONF : TBROK) | TERRNO,
> 
> Huh? This compiles?

I do not like this piece of code either, but apart from that it's
correct and works fine as far as I can tell.

-- 
Cyril Hrubis
chrubis@suse.cz
