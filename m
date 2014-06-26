Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1X074h-00082s-KR
	for ltp-list@lists.sourceforge.net; Thu, 26 Jun 2014 10:38:39 +0000
Date: Thu, 26 Jun 2014 12:38:17 +0200
From: chrubis@suse.cz
Message-ID: <20140626103816.GA10335@rei.Home>
References: <1402060015.2086.2.camel@G08JYZSD130126>
	<20140617095229.GB29213@rei.Home>
	<1403698904.2434.22.camel@G08JYZSD130126>
	<1751892689.30818356.1403778578891.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1751892689.30818356.1403778578891.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH v2] add new errno testes for timerfd_*
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> > * Add EINVAL errno testes for timerfd_create(2)
> > 	- The clockid argument is neither CLOCK_MONOTONIC nor CLOCK_REALTIME,
> > 	  EINVAL would return.
> > 	- flags is invalid, EINVAL would return.
> > 
> > * Add EBADF, EFAULT and EINVAL errno testes for timerfd_gettime(2)
> > 	- fd is not a valid file descriptor, EBADF would return.
> > 	- curr_value is not valid a pointer, EFAULT would return.
> > 	- fd is not a valid timerfd file descriptor, EINVAL would return.
> > 
> > * Add EBADF, EFAULT and EINVAL errno testes for timerfd_settime(2)
> > 	- fd is not a valid file descriptor, EBADF would return.
> > 	- old_value is not valid a pointer, EFAULT would return.
> > 	- fd is not a valid timerfd file descriptor, EINVAL would return.
> > 	- flags is invalid, EINVAL would return.
> > 
> > Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
> > ---
> >  configure.ac                                       |   1 +
> >  include/lapi/timerfd.h                             |  52 ++++++++
> >  m4/ltp-timerfd.m4                                  |  25 ++++
> >  runtest/syscalls                                   |   3 +
> >  testcases/kernel/syscalls/.gitignore               |   3 +
> >  .../kernel/syscalls/timerfd/timerfd_create01.c     | 106 ++++++++++++++++
> >  .../kernel/syscalls/timerfd/timerfd_gettime01.c    | 131
> >  ++++++++++++++++++++
> >  .../kernel/syscalls/timerfd/timerfd_settime01.c    | 136
> >  +++++++++++++++++++++
> >  8 files changed, 457 insertions(+)
> >  create mode 100644 include/lapi/timerfd.h
> >  create mode 100644 m4/ltp-timerfd.m4
> >  create mode 100644 testcases/kernel/syscalls/timerfd/timerfd_create01.c
> >  create mode 100644 testcases/kernel/syscalls/timerfd/timerfd_gettime01.c
> >  create mode 100644 testcases/kernel/syscalls/timerfd/timerfd_settime01.c
> > 
> 
> Hi,
> 
> > +#if defined(HAVE_TIMERFD_CREATE)
> > +#include <sys/timerfd.h>
> > +#endif
> > +
> 
> just a small nit, you probably want this included if any of HAVE_TIMERFD_* is defined.
> Overall it looks good to me. I tested it on RHEL6.5 and 7.

Or add AC_CHECK_HEADERS() for sys/timerfd.h to the m4/ltp-timerfd.m4 and
use that instead.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Open source business process management suite built on Java and Eclipse
Turn processes into business applications with Bonita BPM Community Edition
Quickly connect people, data, and systems into organized workflows
Winner of BOSSIE, CODIE, OW2 and Gartner awards
http://p.sf.net/sfu/Bonitasoft
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
