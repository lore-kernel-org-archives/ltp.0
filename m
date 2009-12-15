Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NKdF8-0003jA-RE
	for ltp-list@lists.sourceforge.net; Tue, 15 Dec 2009 19:39:34 +0000
Received: from mail-pw0-f43.google.com ([209.85.160.43])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NKdF4-0008Q1-LE
	for ltp-list@lists.sourceforge.net; Tue, 15 Dec 2009 19:39:34 +0000
Received: by pwj11 with SMTP id 11so151722pwj.2
	for <ltp-list@lists.sourceforge.net>;
	Tue, 15 Dec 2009 11:39:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <000001ca7d4d$e2a9e7e0$a7fdb7a0$@co.jp>
References: <000001ca7d4d$e2a9e7e0$a7fdb7a0$@co.jp>
Date: Tue, 15 Dec 2009 11:39:24 -0800
Message-ID: <364299f40912151139s38bd457eg88c6908d805f6ab4@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] fix compiling error on ia64 platform
	(ltp-full-20091130)
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Mitani <mitani@ryobi.co.jp>
Cc: ltp-list@lists.sourceforge.net

On Mon, Dec 14, 2009 at 10:14 PM, Mitani <mitani@ryobi.co.jp> wrote:
> Hi,
>
> I applied following Casper's patch to "ltp-2009-12-10" cvs,
> then "make" succeeded in RHEL5.4 ia64 system:
> http://www.mail-archive.com/ltp-list@lists.sourceforge.net/msg08991.html
>
> On the other hand, I used Repository's following sources,
> but "make" failed.
> =A0- "ptrace.h" =A0 (Revision 1.9)
> =A0- "ptrace04.c" (Revision 1.13)
>
> But, at least, I think that the Repository's revision about "ptrace04.c"
> is right. And "ptrace04.c" of "ltp-2009-12-15" cvs is same one.
>
>
> Today, I arranged Casper's "ptrace.h" patch for "ltp-2009-12-15" cvs
> and applied it to this cvs, and "make" succeeded.
>
>
> I tried following other systems as using this patch, and succeeded:
> =A0- RHEL5.4(kernel : 2.6.18-164.el5) and x86 architecture
> =A0- RHEL5.4(kernel : 2.6.18-164.el5) and x86_64 architecture
> =A0- RHEL4.8(kernel : 2.6.9-89.ELsmp) and x86 architecture

Until this issue is resolved (I ran into problems trying to use
crossdev, so I'll have to manually inspect headers after I track down
which versions are used in the Redhat distros specified), please
remember that you _can_ always comment out the line which says:

/* Define to 1 if you have the <asm/ptrace.h> header file. */
#define HAVE_ASM_PTRACE_H 1

Actually, I think I'll just remove that header check if the build
passes unless Mike objects, because we really shouldn't be
#include'ing asm/* headers without having a good reason to do so
because it results in pain of this magnitude...

Thanks,
-Garrett

---------------------------------------------------------------------------=
---
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev =

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
