From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 3 Mar 2020 12:27:25 +0100
Subject: [LTP] [PATCH v2] Add test for CVE 2017-10661
In-Reply-To: <20200303110249.GB42129@gacrux.arch.suse.de>
References: <20200221120850.15874-1-mdoucha@suse.cz>
 <20200303104737.GA42129@gacrux.arch.suse.de>
 <20200303110249.GB42129@gacrux.arch.suse.de>
Message-ID: <20200303112725.GA24389@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > > +++ b/testcases/kernel/syscalls/timerfd/Makefile
> > > @@ -20,6 +20,7 @@ top_srcdir		?= ../../../..
> 
> > >  include $(top_srcdir)/include/mk/testcases.mk
> 
> > > -LDLIBS			+= -lpthread -lrt
> > > +timerfd_settime02:	CFLAGS	+= -pthread
> > > +timerfd_settime02:	LDLIBS	+= -pthread -lrt
> > Interesting, I thought -pthread wouldn't be needed to be in LDLIBS
> > (enough to have it in CFLAGS), but old distros (CentOS 6 in our travis: gcc
> > 4.4.7, glibc 2.12).
> 
> OK: it can be just this:
> timerfd_settime02:	CFLAGS	+= -pthread
> timerfd_settime02:	LDLIBS	+= -lrt
> 
> because failure in CentOS 6 is different:
> timerfd01.c:36: undefined reference to `clock_gettime'
> https://api.travis-ci.org/v3/job/657694167/log.txt
>
> Obviously we need autotools check for it (trivial, I can do it before merge).

-lrt is required in LDLIBS for older libc that had all the posix
realtime outside of the glibc.so, and it's harmless on newer glibc so
for the time being we just need -lrt in LDLIBS for quite a lot of
testcases...

-- 
Cyril Hrubis
chrubis@suse.cz
