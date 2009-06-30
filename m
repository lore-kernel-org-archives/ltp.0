Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MLY7E-0002qS-E7
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2009 07:50:56 +0000
Received: from [32.97.110.159] (helo=e38.co.us.ibm.com)
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MLY7D-0004fx-BO
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2009 07:50:56 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e38.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5U7ktQL032001
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 01:46:55 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5U7o4lK094732
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 01:50:04 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5U7o3hZ023429
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 01:50:04 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <364299f40906291412o1c24953n587406adcc465139@mail.gmail.com>
References: <f5a7b3810906290953k7326b82ds617ee7bfdac92e48@mail.gmail.com>
	<364299f40906291412o1c24953n587406adcc465139@mail.gmail.com>
Date: Tue, 30 Jun 2009 13:11:31 +0530
Message-Id: <1246347691.4819.36.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [FIX-PATCH]Build-issue-cacheflush01.c on MIPS
Reply-To: subrata@linux.vnet.ibm.com
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
To: naresh kamboju <naresh.kernel@gmail.com>, Henry Yei <hyei@mvista.com>
Cc: ltp-list@lists.sourceforge.net, Mike Frysinger <vapier@gentoo.org>, Jiri Palecek <jpalecek@web.de>, maxin john <maxinbjohn@gmail.com>, brinda_mn@yahoo.co.in, Manas Kumar Nayak <maknayak@in.ibm.com>

On Mon, 2009-06-29 at 14:12 -0700, Garrett Cooper wrote: 
> On Mon, Jun 29, 2009 at 9:53 AM, naresh kamboju<naresh.kernel@gmail.com> wrote:
> > Hi,
> >
> > I have noticed build error for cacheflush01.c on MIPS.
> > There is edit issue from Windows to Linux text file.
> > Now build issue is resolved.
> > Please find attached patch and below.
> >
> > Best Regards
> > Naresh Kamboju

Henry already submitted a patch to fix this:
http://marc.info/?l=ltp-list&m=124615187102775&w=2

I am yet to check-in that. It is the same as your patch ;-)

Regards--
Subrata

> >
> > Build-Error:
> >
> > cacheflush01.c  -L../../../../lib -lltp -o cacheflush01
> > cacheflush01.c: In function 'cacheflush':
> > cacheflush01.c:52: error: 'B' undeclared (first use in this function)
> > cacheflush01.c:52: error: (Each undeclared identifier is reported only once
> > cacheflush01.c:52: error: for each function it appears in.)
> > cacheflush01.c:52: error: expected ';' before 'B'
> > cacheflush01.c:53: warning: control reaches end of non-void function
> > make: *** [cacheflush01] Error 1
> >
> >
> > Signed-off-by: Naresh Kamboju < naresh.kernel@gmail.com >
> >
> > diff -Naurb a/testcases/kernel/syscalls/cacheflush/cacheflush01.c
> > b/testcases/kernel/syscalls/cacheflush/cacheflush01.c
> > --- a/testcases/kernel/syscalls/cacheflush/cacheflush01.c       2009-04-15
> > 12:02:35.000000000 +0530
> > +++ b/testcases/kernel/syscalls/cacheflush/cacheflush01.c       2009-06-29
> > 21:38:42.000000000 +0530
> > @@ -49,7 +49,7 @@
> >  #include <asm/cachectl.h>
> >  int cacheflush(char *addr, int nbytes, int cache)
> >  {
> > -B  B  B  B return syscall(__NR_cacheflush, addr, nbytes, cache);
> > +           return syscall(__NR_cacheflush, addr, nbytes, cache);
> >  }
> >  #endif /* __mips__ */
> 
> Nice catch... Heh.
> -Garrett
> 
> ------------------------------------------------------------------------------
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
