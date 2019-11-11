From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 11 Nov 2019 11:30:26 -0500 (EST)
Subject: [LTP] [PATCH] futex_cmp_requeue01: fix test expectations
In-Reply-To: <20191111150928.GA16894@rei.lan>
References: <18ef4352ad8e03719e5bd470825d912569813aa4.1573476808.git.jstancek@redhat.com>
 <20191111150928.GA16894@rei.lan>
Message-ID: <1059626680.11523678.1573489826970.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Shouldn't these be volatile? Or does the tst_atomic_load() guarantee
> that compiler knows that it could be changed from a different process?

That should be implied. Our fallback functions issue compiler barriers too.

> 
> >  static struct tcase {
> >  	int num_waiters;
> > @@ -37,14 +38,28 @@ static struct tcase {
> >  
> >  static void do_child(void)
> >  {
> > -	struct timespec usec = tst_ms_to_timespec(2000);
> > +	int max_sleep_ms = 5000, slept_for_ms = 0;
> 
> We do have a tst_multiply_timeout() in the test library now, shouldn't
> we use it for the max_sleep_ms here as well?
> 
> Also if we do that it would make sense to keep the timeout in global and
> initialize it in the parent, that would save us some runtime.

OK, I can add that.

> >  	num_requeues = futex_wake(&futexes[1], tc->num_waiters, 0);
> >  	num_waits = futex_wake(&futexes[0], tc->num_waiters, 0);
> >  
> >  	for (i = 0; i < tc->num_waiters; i++) {
> > +		tst_atomic_store(1, test_done);
> 
> What's the point of storing the value in the loop, shouldn't it suffice
> to do it once before the loop?

Yes. I previously used kill() here for each child. When I changed that
I forgot to move it out of loop.

> 
> >  		SAFE_WAITPID(pid[i], &status, 0);
> >  		if (WIFEXITED(status) && !WEXITSTATUS(status))
> >  			num_total++;
> >  	}
> >  
> > +	tst_res(TINFO, "children woken, futex0: %d, futex1: %d, "
> > +		"spurious wakeups: %d",
> > +		num_waits, num_requeues, tst_atomic_load(spurious));
> 
> I guess that we do not need atomic access once all the children are
> waited for.

Strictly no, but it seems more consistent. I don't think we care about
performance impact of it.

> >  
> >  static void cleanup(void)
> >  {
> >  	if (futexes)
> >  		SAFE_MUNMAP((void *)futexes, sizeof(futex_t) * 2);
> > +	if (spurious)
> > +		SAFE_MUNMAP((void *)spurious, sizeof(int) * 2);
> 
> Can't we just use a single page? It should be large enough for both
> futexes and counters...
> 
> I guess that we can as well define a structure with all the parameters
> so that we do only a single mmap() later on.

I'll put it into single struct and single mmap.

Thanks,
Jan

