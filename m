From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 6 Apr 2016 09:14:57 -0400 (EDT)
Subject: [LTP] [PATCH] testcases/kernel/include/lib.mk: re-order library
 link order
In-Reply-To: <20160406130445.GA10599@rei.suse.cz>
References: <0d998706a0a9c4c353f3aa31f2c1544007611714.1459758277.git.jstancek@redhat.com>
 <20160406130445.GA10599@rei.suse.cz>
Message-ID: <1553115594.19532648.1459948497819.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Wednesday, 6 April, 2016 3:04:45 PM
> Subject: Re: [LTP] [PATCH] testcases/kernel/include/lib.mk: re-order library link order
> 
> Hi!
> > diff --git a/testcases/kernel/include/lib.mk
> > b/testcases/kernel/include/lib.mk
> > index f79a1c0197e3..5c97ae2c9edf 100644
> > --- a/testcases/kernel/include/lib.mk
> > +++ b/testcases/kernel/include/lib.mk
> > @@ -23,7 +23,7 @@ KERNEL_DIR		:= $(abs_top_builddir)/testcases/kernel
> >  LIBKERNTEST_DIR		:= $(KERNEL_DIR)/lib
> >  LIBKERNTEST		:= $(LIBKERNTEST_DIR)/libkerntest.a
> >  CPPFLAGS		+= $(NUMA_CPPFLAGS) -I$(KERNEL_SRCDIR)/include
> > -LDLIBS			+= $(NUMA_LIBS) -lkerntest -lltp
> > +LDLIBS			+= -lkerntest -lltp $(NUMA_LIBS)
> 
> Looking at the libkerntest.a it uses numa library as well as ltp library
> so it should passed be before them, acked.

Pushed.

Regards,
Jan

> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
