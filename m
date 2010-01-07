Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1NSqhu-0006Ue-TD
	for ltp-list@lists.sourceforge.net; Thu, 07 Jan 2010 11:39:14 +0000
Received: from e9.ny.us.ibm.com ([32.97.182.139])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NSqhs-0003aV-Mn
	for ltp-list@lists.sourceforge.net; Thu, 07 Jan 2010 11:39:14 +0000
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e9.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o07BTX4q028876
	for <ltp-list@lists.sourceforge.net>; Thu, 7 Jan 2010 06:29:33 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o07BbAEE1605632
	for <ltp-list@lists.sourceforge.net>; Thu, 7 Jan 2010 06:37:10 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o07Bb9RM014310
	for <ltp-list@lists.sourceforge.net>; Thu, 7 Jan 2010 06:37:09 -0500
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <364299f41001070132u26b9637bwa357b64e0c8cc365@mail.gmail.com>
References: <000301ca8f6e$bc72b8d0$35582a70$@co.jp>
	<364299f41001070132u26b9637bwa357b64e0c8cc365@mail.gmail.com>
Date: Thu, 07 Jan 2010 17:07:03 +0530
Message-Id: <1262864223.12213.39.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] Build failure with 2010-01-07 cvs
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net, Mitani <mitani@ryobi.co.jp>

Garret,

On Thu, 2010-01-07 at 01:32 -0800, Garrett Cooper wrote: 
> On Wed, Jan 6, 2010 at 11:55 PM, Mitani <mitani@ryobi.co.jp> wrote:
> > Hi,
> >
> > I tried to make with latest version (2010-01-07 cvs) in RHEL4.8
> > (2.6.9-89.ELsmp).
> > But it failed with following message:
> > ------------
> > gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
> > -I/home/LTP/ltp-2010-01-07/testcases/kernel/include -g
> > -I/home/LTP/ltp-2010-01-07/testcases/kernel/syscalls/get_mempolicy/../utils
> > -DNUMA_VERSION1_COMPATIBILITY -I../../../../include -I../../../../include
> > -L../../../../lib  get_mempolicy01.c   -lltp -lnuma -o get_mempolicy01
> > In file included from get_mempolicy01.c:78:
> > /home/LTP/ltp-2010-01-07/testcases/kernel/syscalls/get_mempolicy/../utils/nu
> > ma_helpers.h:81: error: redefinition of 'nodemask_set'
> > /usr/include/numa.h:45: error: previous definition of 'nodemask_set' was
> > here
> > /home/LTP/ltp-2010-01-07/testcases/kernel/syscalls/get_mempolicy/../utils/nu
> > ma_helpers.h:95: error: redefinition of 'nodemask_dump'
> > /home/LTP/ltp-2010-01-07/testcases/kernel/syscalls/get_mempolicy/../utils/nu
> > maif.h:85: error: previous definition of 'nodemask_dump' was here
> > make[4]: *** [get_mempolicy01] Error 1
> > ------------
> >
> > "numa_helpers.h" is as follows (comments are omitted):
> > ------------
> > #ifndef LTP_NUMA_HELPERS_H
> > #define LTP_NUMA_HELPERS_H
> >
> > #include "config.h"
> > #if HAVE_NUMA_H
> > #include <numa.h>
> >
> > static inline void nodemask_set(nodemask_t *mask, int node)
> >
> > {                                                       <----- L.81
> >        mask->n[node / (8*sizeof(unsigned long))] |=
> >                (1UL << (node % (8*sizeof(unsigned long))));
> > }
> >
> > static inline void nodemask_dump(const char *header, const nodemask_t *mask)
> > {                                                       <----- L.95
> >        int i;
> >        EPRINTF("%s", header);
> >        for (i = 0; i < NUMA_NUM_NODES/(sizeof(unsigned long)*8); i++)
> >                EPRINTF(" 0x%08lx", mask->n[i]);
> >        EPRINTF("\n");
> > }
> >
> > #else
> >
> > typedef struct nodemask_t { };
> >
> > static inline void nodemask_set(nodemask_t *mask, int node)
> > {
> >        return;
> > }
> >
> > static inline void nodemask_dump(const char *header, const nodemask_t *mask)
> > {
> >        return;
> > }
> >
> > #endif
> >
> > #endif
> > ------------
> >
> > In my system, HAVE_NUMA_H is defined as 1.
> >
> > The function "nodemask_set" defined in "/usr/include/numa.h" is same
> > as the one of "numa_helpers.h".
> > And the function "nodemask_dump" defined in "${LTPROOT}/testcases/kernel
> > /syscalls/utils/numa_helpers" is same as the one of "numa_helpers.h".
> >
> > Why are the same definitions necessary in "numa_helpers.h" on purpose?
> >
> >
> > I'm glad if I get your help.
> 
>     Try now please.
> Thanks,
> -Garrett

The get_mempolicy01 and mbind01 had build errors even for the December
2009 release. So, i have removed them and their reference in the tar.

Regards--
Subrata

> 
> ------------------------------------------------------------------------------
> This SF.Net email is sponsored by the Verizon Developer Community
> Take advantage of Verizon's best-in-class app development support
> A streamlined, 14 day to market process makes app distribution fast and easy
> Join now and get one step closer to millions of Verizon customers
> http://p.sf.net/sfu/verizon-dev2dev 
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
