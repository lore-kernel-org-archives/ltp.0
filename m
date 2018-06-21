From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 21 Jun 2018 16:32:16 +0200
Subject: [LTP] [PATCH v3 3/3] cve/cve-2018-1000001: Add Realpath Buffer
 Underflow test
In-Reply-To: <20180621142049.GB14165@rei>
References: <20180621141648.11430-1-pvorel@suse.cz>
 <20180621141648.11430-3-pvorel@suse.cz>
 <20180621142049.GB14165@rei>
Message-ID: <20180621143216.fhcb5hg2blrnf2ff@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> > diff --git a/testcases/cve/Makefile b/testcases/cve/Makefile
> > index 3a05dd4fe..e5fc8d44f 100644
> > --- a/testcases/cve/Makefile
> > +++ b/testcases/cve/Makefile
> > @@ -41,4 +41,4 @@ cve-2017-17053:	CFLAGS += -pthread

> >  cve-2015-3290:	CFLAGS += -pthread

> > -include $(top_srcdir)/include/mk/generic_leaf_target.mk
> > +include $(top_srcdir)/include/mk/generic_trunk_target.mk

> This change is useless now.

Sorry for leaving this. Removed it and pushed, with your ack.

> Other than that the patchset looks fine.


Kind regards,
Petr
