Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <czhang@redhat.com>) id 1NHznf-0006IC-Rm
	for ltp-list@lists.sourceforge.net; Tue, 08 Dec 2009 13:08:19 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NHznZ-0008BN-Eo
	for ltp-list@lists.sourceforge.net; Tue, 08 Dec 2009 13:08:19 +0000
Date: Tue, 8 Dec 2009 08:07:59 -0500 (EST)
From: Caspar Zhang <czhang@redhat.com>
Message-ID: <1429667615.6061260277679532.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
In-Reply-To: <862970112.6041260277607150.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Subject: Re: [LTP] make error
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: yali_ning <yali_ning@126.com>, ltp-list@lists.sourceforge.net


----- "Mike Frysinger" <vapier@gentoo.org> wrote:

> On Thursday 12 November 2009 01:20:37 yali_ning wrote:
> >   I came across an error , when compiling the ltp-20091030. the step
> is :
> > 
> > gcc -Wall -g -Os -g -O2 -fno-strict-aliasing -pipe -Wall 
> > 
> -I/mnt/sdb1/nly1/ltp-1030/ltp-full-20091031/testcases/kernel/include
> >  -I../../../../include -I../../../../include   -L../../../../lib 
> vfork.c  
> >  -lltp -o vfork In file included from /usr/include/asm/ptrace.h:58,
> >                  from /usr/include/linux/ptrace.h:49,
> >                  from vfork.c:45:
> > /usr/include/asm/fpu.h:57: error: redefinition of 'struct
> ia64_fpreg'
> > In file included from /usr/include/linux/ptrace.h:49,
> >                  from vfork.c:45:
> > /usr/include/asm/ptrace.h:208: error: redefinition of 'struct
> >  pt_all_user_regs'
> 
> this should be fixed already in latest cvs
> -mike
No, I tried to install latest cvs version under RHEL5.4 on a ia64
machine but the same error still existed.

What puzzled me is, it said it was the redefinition-error, but I 
couldn't even find the originally defined structs.

Thanks,
Caspar

------------------------------------------------------------------------------
Return on Information:
Google Enterprise Search pays you back
Get the facts.
http://p.sf.net/sfu/google-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
