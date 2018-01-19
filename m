From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 19 Jan 2018 18:54:03 +0100
Subject: [LTP] [PATCH v3] Add regression test for CVE-2017-17052
In-Reply-To: <20180119160347.GB7954@rei>
References: <20180112115952.9287-1-mmoese@suse.de> <20180119160347.GB7954@rei>
Message-ID: <20180119175402.GA13508@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > +static void setup(void)
> > +{
> > +	shm = SAFE_MMAP(NULL, sizeof(struct my_shm_data), PROT_READ|PROT_WRITE,
>                                ^
> 			       The system aligns the length to be a
> 			       multiple of pagesize, so we may as well
> 			       pass result of getpagesize() here.
> > +		    MAP_SHARED | MAP_ANONYMOUS, -1, 0);
> > +
> > +	shm->exit = 0;
> > +}
> > +
> > +static void cleanup(void)
> > +{
> > +	SAFE_MUNMAP(shm, sizeof(struct my_shm_data));
>                           ^
> 			  Here we must pass length that is multiple of
> 			  pagesize, at least manual pages says so.

Sorry, I've misread the manual page, that applies only for huge page
mappings, so passing sizeof(*shm) to mmap() and munmap() should work
just fine, it would still allocate whole page though.

-- 
Cyril Hrubis
chrubis@suse.cz
