From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 20 Jan 2021 14:33:14 +0100
Subject: [LTP] Holidays and LTP release
In-Reply-To: <YAgFQnIazPBpkWwL@yuki.lan>
References: <X9tMlNxJbwCWIRnO@yuki.lan> <X/Wq28noppvB5MGw@yuki.lan>
 <20210113095724.214c904a@kmaincent-XPS-13-7390>
 <CA+G9fYv1UFr+7ePC7tLjCY4JPsoQdBdf-6Jpr40zmsoYRWVrdQ@mail.gmail.com>
 <db866679-a5e8-35d6-f57a-18a202c7937b@suse.cz>
 <CA+G9fYvRqOH7D04NHwPQNXKyMzak5bDo=GN3k13tcwV3bwN5Yw@mail.gmail.com>
 <YAgFQnIazPBpkWwL@yuki.lan>
Message-ID: <YAgxGvg/FXcUq8R6@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > do you mean something like this ?
> > But this change did not solve the problem (ioctl_sg01) i have reported.
> > 
> > diff --git a/lib/tst_memutils.c b/lib/tst_memutils.c
> > index f134d90c9..00bf45e9c 100644
> > --- a/lib/tst_memutils.c
> > +++ b/lib/tst_memutils.c
> > @@ -20,7 +20,7 @@ void tst_pollute_memory(size_t maxsize, int fillchar)
> >         struct sysinfo info;
> > 
> >         SAFE_SYSINFO(&info);
> > -       safety = 4096 * SAFE_SYSCONF(_SC_PAGESIZE) / info.mem_unit;
> > +       safety = 8192 * SAFE_SYSCONF(_SC_PAGESIZE) / info.mem_unit;
> 
> Actually Martin sugessted a different patch that chooses the margin to
> be the greater of 4096 pages or 64MB, which would effectivelly set the
> safety to "16384 * SAFE_SYSCONF(_SC_PAGESIZE) / info.mem_unit" on most
> systems.
> 
> Also I've been playing with a VM and I've been able to reproduce
> occasional failures with swap turned off and memory_overcommit set to 1
> that Martin's patch fixed for me.

And it looks like the patch for tst_memutils.c is the last one that
should be taken care of before the release.

It would be nice if you could check if that fixes your failures as well.

However it made the situation better, at least for me, so I will push it
tomorrow morning and proceed with the release.

-- 
Cyril Hrubis
chrubis@suse.cz
