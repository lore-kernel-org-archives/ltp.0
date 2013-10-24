Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VZLxO-00028s-Dv
	for ltp-list@lists.sourceforge.net; Thu, 24 Oct 2013 14:32:14 +0000
Date: Thu, 24 Oct 2013 16:31:58 +0200
From: chrubis@suse.cz
Message-ID: <20131024143158.GA11150@rei>
References: <525F76B7.4050705@oracle.com>
	<1382087565-2370-1-git-send-email-stanislav.kholmanskikh@oracle.com>
	<20131021125723.GA2385@rei> <5268FDE5.5010408@oracle.com>
	<20131024121601.GC29706@rei> <52692C2F.3040903@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <52692C2F.3040903@oracle.com>
Subject: Re: [LTP] [PATCH] msgctl{08, 09, 10, 11}: cleanup
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> >> And I think that I found an another issue we should overcome - lib.mk
> >> defines MAKE_TARGETS:
> >>
> >> MAKE_TARGETS    := $(LIB)
> >>
> >> generic_leaf_target.mk also does it.
> >>
> >> So It should not be trivial to include both files (lib.mk and
> >> generic_leaf_target.mk) into one Makefile.
> >> I suppose that in that case we have to implicitly define MAKE_TARGETS in
> >> our Makefile.
> > Now this one is more complicated, but solvable.
> >
> > First of all we need to change the part in lib.mk to
> >
> > MAKE_TARGETS += $(LIB)
> >
> > Then define MAKE_TARGETS explicitly in the Makefile (we need that anyway
> > for lib: tests dependency) and add LDFLAGS and LDLIBS. The full Makefile
> > looks like:
> >
> > top_srcdir              ?= ../../../../..
> > include $(top_srcdir)/include/mk/testcases.mk
> >
> > LIBSRCS := libmsgctl.c
> > INTERNAL_LIB := libmsgctl.a
> > MAKE_TARGETS := $(patsubst %.c,%,$(wildcard msgctl??.c))
> >
> > $(MAKE_TARGETS): $(INTERNAL_LIB)
> >
> > LDFLAGS += -L$(abs_builddir)
> > LDLIBS += -lmsgctl
> >
> > include $(abs_srcdir)/../Makefile.inc
> > include $(top_srcdir)/include/mk/lib.mk
> > include $(top_srcdir)/include/mk/generic_leaf_target.mk
> >
> > See also attached patch with all the changes and check if that works for
> > you. If so I will commit change to the lib.mk as separate patch and ask
> > you to include changes in Makefile.inc in your patchset.
> 
> 
> Yes, It works.
> 
> But the compilation is performed as follows:
> 
> gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall 
> -I/home/stas/ltp/testcases/kernel/include 
> -I/home/stas/ltp/testcases/kernel/syscalls/ipc/msgctl/../lib 
> -I../../../../../include -I../../../../../include 
> -I../../../../../include -I../../../../../include 
> -L/home/stas/ltp/testcases/kernel/syscalls/ipc/msgctl 
> -L/home/stas/ltp/testcases/kernel/syscalls/ipc/msgctl/../lib 
> -L../../../../../lib -L../../../../../lib  msgctl01.c libmsgctl.a -lltp 
> -lmsgctl -lipc -o msgctl01
> 
> So gcc 'links' msgctl01.c and libmsgctl.a at once (and additionally is 
> passed -lmsgctl option).

Ah, this one. Let's fix this, the handling of static libraries is too
fragile and this may posibly break on some distribution (from my memory
Ubuntu was the most problematic one).

> How do you think, maybe introduce my favourite .INTERMEDIATE target into 
> Makefile? :)
> 
> Like this:
> 
> MAKE_TARGET_OBJS := $(addsuffix .o,$(MAKE_TARGETS))
> .INTERMEDIATE: $(MAKE_TARGET_OBJS)
> 
> $(MAKE_TARGET_OBJS): $(INTERNAL_LIB)
> 
> #$(MAKE_TARGETS): $(INTERNAL_LIB)
> 
> With this option the compilation is as follows:
> 
> gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall 
> -I/home/stas/ltp/testcases/kernel/include 
> -I/home/stas/ltp/testcases/kernel/syscalls/ipc/msgctl/../lib 
> -I../../../../../include -I../../../../../include 
> -I../../../../../include -I../../../../../include  -c -o msgctl01.o 
> msgctl01.c
> gcc   -L/home/stas/ltp/testcases/kernel/syscalls/ipc/msgctl 
> -L/home/stas/ltp/testcases/kernel/syscalls/ipc/msgctl/../lib 
> -L../../../../../lib -L../../../../../lib  msgctl01.o   -lltp -lmsgctl 
> -lipc -o msgctl01
> 
> I can't find any reasonable arguments for this approach. Just feels that 
> it's more 'correct'.

That looks a bit like a workaround, but let's go with this one for now.

I will take a closer look later and change it if I find a better way.
(I have a better build system documentation on my TODO)

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135991&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
