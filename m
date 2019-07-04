From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 4 Jul 2019 10:51:54 -0400 (EDT)
Subject: [LTP] [PATCH] direct_io: diotest4: fix mips
 MAP_SHARED/MAP_FIXED mmap
In-Reply-To: <20190704140849.GB11528@rei.lan>
References: <47b8b48060353711ff8d3695a7d3702f1aced12a.1562224996.git.jstancek@redhat.com>
 <20190704130119.GA11421@rei.lan>
 <594163584.31676743.1562246342334.JavaMail.zimbra@redhat.com>
 <20190704140849.GB11528@rei.lan>
Message-ID: <559290240.31688905.1562251914018.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi!
> > > > diff --git a/include/lapi/mmap.h b/include/lapi/mmap.h
> > > > index 18547c0d47ed..98b6ade1e2ab 100644
> > > > --- a/include/lapi/mmap.h
> > > > +++ b/include/lapi/mmap.h
> > > > @@ -19,6 +19,8 @@
> > > >  #ifndef LAPI_MMAP_H__
> > > >  #define LAPI_MMAP_H__
> > > >  
> > > > +#include "config.h"
> > > > +
> > > >  #ifndef MAP_HUGETLB
> > > >  # define MAP_HUGETLB 0x40000
> > > >  #endif
> > > 
> > > Huh, this looks completely unrelevant to the patch itself, or do I miss
> > > something?
> > 
> > This fixes the original problem of bad alignment.
> > Hunk below improves on it by removing MAP_FIXED altogether.
> 
> Ah, that is needed for the HAVE_SYS_SHM_H.
> 
> > I could split it into 2 patches, if you prefer that.
> 
> Yes please, both are acked, so just push them.

Pushed as 2 patches.
