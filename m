Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1PLwCG-0007DN-73
	for ltp-list@lists.sourceforge.net; Fri, 26 Nov 2010 11:10:32 +0000
Date: Fri, 26 Nov 2010 12:23:00 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20101126112300.GC11386@saboteur.suse.cz>
References: <1778429352.495721290732324614.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<657824967.497541290736866368.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <657824967.497541290736866368.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
Subject: Re: [LTP] [PATCH] mbind_range() vma merge
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
To: CAI Qian <caiqian@redhat.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

> > > +#include <numaif.h>
> > > +#include <numa.h>
> > > +#include <sys/mman.h>
> > > +#include <stdio.h>
> > > +#include <unistd.h>
> > > +#include <stdlib.h>
> > > +#include <string.h>
> > > +#include "test.h"
> > > +#include "usctest.h"
> > > 
> > > gcooper> This will cause breakage on systems without proper numa
> > lib
> > > support *cues some RHEL users from Ryobi on the list :)...*
> > Right, I'll add a autoconf check for this.
> I recalled in the pass that Masatake YAMATO created a doc about how to add autoconf to a test but I could not find it now. Is there any recent document about how to do it right now??

I would start by looking at existing autoconf tests which is
configure.ac and functions in m4/*. Doing 'make autotools' should update
configure script and running it by './configure' should update
include/config.h and few other make scripts.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Increase Visibility of Your 3D Game App & Earn a Chance To Win $500!
Tap into the largest installed PC base & get more eyes on your game by
optimizing for Intel(R) Graphics Technology. Get started today with the
Intel(R) Software Partner Program. Five $500 cash prizes are up for grabs.
http://p.sf.net/sfu/intelisp-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
