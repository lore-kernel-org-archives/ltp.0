Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VZJpp-0003qm-Ry
	for ltp-list@lists.sourceforge.net; Thu, 24 Oct 2013 12:16:17 +0000
Date: Thu, 24 Oct 2013 14:16:01 +0200
From: chrubis@suse.cz
Message-ID: <20131024121601.GC29706@rei>
References: <525F76B7.4050705@oracle.com>
	<1382087565-2370-1-git-send-email-stanislav.kholmanskikh@oracle.com>
	<20131021125723.GA2385@rei> <5268FDE5.5010408@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
In-Reply-To: <5268FDE5.5010408@oracle.com>
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
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!
> >> diff --git a/testcases/kernel/syscalls/ipc/msgctl/Makefile b/testcases/kernel/syscalls/ipc/msgctl/Makefile
> >> index f467389..ae61b51 100644
> >> --- a/testcases/kernel/syscalls/ipc/msgctl/Makefile
> >> +++ b/testcases/kernel/syscalls/ipc/msgctl/Makefile
> >> @@ -18,6 +18,15 @@
> >>   
> >>   top_srcdir              ?= ../../../../..
> >>   
> >> +FILTER_OUT_MAKE_TARGETS	:= libmsgctl
> >> +
> >>   include $(top_srcdir)/include/mk/testcases.mk
> >>   include $(abs_srcdir)/../Makefile.inc
> >>   include $(top_srcdir)/include/mk/generic_leaf_target.mk
> >> +
> >> +SRCS			?= $(wildcard $(abs_srcdir)/*.c)
> >> +OBJS			:= $(notdir $(patsubst %.c,%.o,$(SRCS)))
> >> +.INTERMEDIATE: $(OBJS)
> >> +
> >> +$(MAKE_TARGETS): %: %.o libmsgctl.o
> >> +libmsgctl.o: libmsgctl.h
> >> diff --git a/testcases/kernel/syscalls/ipc/msgctl/libmsgctl.c b/testcases/kernel/syscalls/ipc/msgctl/libmsgctl.c
> >> new file mode 100644
> >> index 0000000..fa77b56
> > This is too hacky what about building .a library instead as it's done in
> > testcases/kernel/mem/lib ?
> >
> > I've looked into the lib.mk and it looks like you don't even have to put
> > the lib in the separate directory if you set LIBSRC in the corresponding
> > Makefile.
> 
> Cyril, could you show an example of doing this (placing test case 
> sources and static libraries sources in the same directory), please?
> 
> I tried to do what you said but couldn't manage it :(
> 
> I used this Makefile:
> 
> top_srcdir              ?= ../../../../..
> 
> LIBSRCS := $(abs_srcdir)/libmsgctl.c
> INTERNAL_LIB := libmsgctl.a
> 
> include $(top_srcdir)/include/mk/testcases.mk
> include $(abs_srcdir)/../Makefile.inc
> include $(top_srcdir)/include/mk/generic_leaf_target.mk
> include $(top_srcdir)/include/mk/lib.mk
> 
> And got error:
> ../../../../../include/mk/lib.mk:66: warning: overriding commands for 
> target `../lib/libipc.a'
> /home/stas/ltp/testcases/kernel/syscalls/ipc/msgctl/../Makefile.inc:34: 
> warning: ignoring old commands for target `../lib/libipc.a'
> make: Circular ../lib/libipc.a <- ../lib/libipc.a dependency dropped.
> if [ -z "../lib" ] ; then \
>          echo "Cowardly refusing to create empty archive"; \
>          exit 1; \
>      fi
> ar -rc "../lib/libipc.a" ../lib
> ar: ../lib/libipc.a: Error reading ../lib: Is a directory
> make: *** [../lib/libipc.a] Error 1

Ah, there is the include $(abs_srcdir)/../Makefile.inc that sets LIB
to ../lib/libipc.a which breaks the lib.mk as there now there are two
rules for making the library. One that runs make in ../lib/ from the
Makefile.inc and second in lib.mk. Renaming the LIB to LIBIPC in
Makefile.inc fixes this one.

> And I think that I found an another issue we should overcome - lib.mk 
> defines MAKE_TARGETS:
> 
> MAKE_TARGETS    := $(LIB)
> 
> generic_leaf_target.mk also does it.
> 
> So It should not be trivial to include both files (lib.mk and 
> generic_leaf_target.mk) into one Makefile.
> I suppose that in that case we have to implicitly define MAKE_TARGETS in 
> our Makefile.

Now this one is more complicated, but solvable.

First of all we need to change the part in lib.mk to

MAKE_TARGETS += $(LIB)

Then define MAKE_TARGETS explicitly in the Makefile (we need that anyway
for lib: tests dependency) and add LDFLAGS and LDLIBS. The full Makefile
looks like:

top_srcdir              ?= ../../../../..
include $(top_srcdir)/include/mk/testcases.mk

LIBSRCS := libmsgctl.c
INTERNAL_LIB := libmsgctl.a
MAKE_TARGETS := $(patsubst %.c,%,$(wildcard msgctl??.c))

$(MAKE_TARGETS): $(INTERNAL_LIB)

LDFLAGS += -L$(abs_builddir)
LDLIBS += -lmsgctl

include $(abs_srcdir)/../Makefile.inc
include $(top_srcdir)/include/mk/lib.mk
include $(top_srcdir)/include/mk/generic_leaf_target.mk

See also attached patch with all the changes and check if that works for
you. If so I will commit change to the lib.mk as separate patch and ask
you to include changes in Makefile.inc in your patchset.

-- 
Cyril Hrubis
chrubis@suse.cz

--tThc/1wpZn/ma/RB
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="build.patch"

diff --git a/include/mk/lib.mk b/include/mk/lib.mk
index 96c08eb..456db24 100644
--- a/include/mk/lib.mk
+++ b/include/mk/lib.mk
@@ -46,7 +46,7 @@ ifneq ($(MAKECMDGOALS),install)
 LIB ?= $(INTERNAL_LIB)
 endif
 
-MAKE_TARGETS	:= $(LIB)
+MAKE_TARGETS	+= $(LIB)
 
 LIBSRCS		?= $(wildcard $(abs_srcdir)/*.c)
 
diff --git a/testcases/kernel/syscalls/ipc/Makefile.inc b/testcases/kernel/syscalls/ipc/Makefile.inc
index a468e93..c7890a9 100644
--- a/testcases/kernel/syscalls/ipc/Makefile.inc
+++ b/testcases/kernel/syscalls/ipc/Makefile.inc
@@ -25,15 +25,15 @@
 LDLIBS			+= -lipc
 LIBDIR			:= ../lib
 
-LIB			:= $(LIBDIR)/libipc.a
+LIBIPC			:= $(LIBDIR)/libipc.a
 
 $(LIBDIR):
 	mkdir -p "$@"
 
-$(LIB): $(LIBDIR)
+$(LIBIPC): $(LIBDIR)
 	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" all
 
-MAKE_DEPS		:= $(LIB)
+MAKE_DEPS		:= $(LIBIPC)
 
 CPPFLAGS		+= -I$(abs_srcdir)/$(LIBDIR)
 
diff --git a/testcases/kernel/syscalls/ipc/msgctl/Makefile b/testcases/kernel/syscalls/ipc/msgctl/Makefile
index f467389..7f1688b 100644
--- a/testcases/kernel/syscalls/ipc/msgctl/Makefile
+++ b/testcases/kernel/syscalls/ipc/msgctl/Makefile
@@ -17,7 +17,17 @@
 #
 
 top_srcdir              ?= ../../../../..
-
 include $(top_srcdir)/include/mk/testcases.mk
+
+LIBSRCS := libmsgctl.c
+INTERNAL_LIB := libmsgctl.a
+MAKE_TARGETS := $(patsubst %.c,%,$(wildcard msgctl??.c))
+
+$(MAKE_TARGETS): $(INTERNAL_LIB)
+
+LDFLAGS += -L$(abs_builddir)
+LDLIBS += -lmsgctl
+
 include $(abs_srcdir)/../Makefile.inc
+include $(top_srcdir)/include/mk/lib.mk
 include $(top_srcdir)/include/mk/generic_leaf_target.mk

--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135991&iu=/4140/ostg.clktrk
--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--tThc/1wpZn/ma/RB--

