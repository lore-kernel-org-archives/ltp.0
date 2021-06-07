From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 7 Jun 2021 11:12:55 +0200
Subject: [LTP] [RFC PATCH v2 1/2] Add 'make check' and clang-check to
 build system
In-Reply-To: <e6efb099-1c51-9f68-4996-7ce917107929@jv-coder.de>
References: <20210604111434.21422-1-rpalethorpe@suse.com>
 <20210604111434.21422-2-rpalethorpe@suse.com>
 <e6efb099-1c51-9f68-4996-7ce917107929@jv-coder.de>
Message-ID: <YL3jFyCj8aPSEpXw@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > +include $(top_srcdir)/include/mk/env_pre.mk
> > +include $(top_srcdir)/include/mk/functions.mk
> > +
> > +HOST_MAKE_TARGETS	:= main
> > +HOST_LDFLAGS 		+= -lclang
> If anyone else trying this has problems linking the tool, at least for 
> me, this must be
> HOST_LDLIBS ?????? ?????? += -lclang
> 
> Otherwise the link order is wrong (main.c after -lclang) and all symbols 
> from libclang are undefined.

Thx for report, indeed that has to be fixed.

-- 
Cyril Hrubis
chrubis@suse.cz
