From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 13 May 2019 10:55:20 +0200
Subject: [LTP] [PATCH v2 2/2] syscalls/getcpu:Add libc sched_getcpu()
 detection &&fix compiler errors
In-Reply-To: <20190513082708.GA9928@dell5510>
References: <20190412114632.GD28648@haruka.lan>
 <1555481102-4158-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1555481102-4158-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20190513082708.GA9928@dell5510>
Message-ID: <20190513085520.GA12685@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > sched_getcpu() isn't defined on some old distros, so we can add dection
> > and fix compiler error.
> 
> > Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> Acked-by: Petr Vorel <pvorel@suse.cz>
> 
> @Metan: I'd be for pushing this before new release.

Acked, please go ahead.

> ...
> >  static inline int get_cpu(unsigned *cpu_id,
> >  			  unsigned *node_id LTP_ATTRIBUTE_UNUSED,
> >  			  void *cache_struct LTP_ATTRIBUTE_UNUSED)
> >  {
> > -#if defined(__i386__)
> > -	return syscall(__NR_getcpu, cpu_id, node_id, cache_struct);
> > +#ifndef HAVE_SCHED_GETCPU
> > +	return tst_syscall(__NR_getcpu, cpu_id, node_id, cache_struct);
> >  #else
> >  	*cpu_id = sched_getcpu();
> >  #endif
> 
> BTW: when rewriting into new C API (whenever it happens) it'd be nice to test
> both syscall and libc sched_getcpu() (if available) via recently added test_variants [1].
> 
> Kind regards,
> Petr
> 
> [1] https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#2229-testing-similar-syscalls-in-one-test


Sure, but let's aim for that after the release has been finished.

-- 
Cyril Hrubis
chrubis@suse.cz
