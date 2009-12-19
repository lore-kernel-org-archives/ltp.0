Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NLraz-0003V2-Fv
	for ltp-list@lists.sourceforge.net; Sat, 19 Dec 2009 05:11:13 +0000
Received: from mail-px0-f189.google.com ([209.85.216.189])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NLraq-000697-DB
	for ltp-list@lists.sourceforge.net; Sat, 19 Dec 2009 05:11:13 +0000
Received: by pxi27 with SMTP id 27so844765pxi.4
	for <ltp-list@lists.sourceforge.net>;
	Fri, 18 Dec 2009 21:10:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <200912181331.36093.vapier@gentoo.org>
References: <000001ca7d4d$e2a9e7e0$a7fdb7a0$@co.jp>
	<364299f40912151139s38bd457eg88c6908d805f6ab4@mail.gmail.com>
	<200912181331.36093.vapier@gentoo.org>
Date: Fri, 18 Dec 2009 21:10:58 -0800
Message-ID: <364299f40912182110w7e5591f1k4f1c59b292b642ad@mail.gmail.com>
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: ltp-list@lists.sourceforge.net

On Fri, Dec 18, 2009 at 10:31 AM, Mike Frysinger <vapier@gentoo.org> wrote:
> On Tuesday 15 December 2009 14:39:24 Garrett Cooper wrote:
>> Until this issue is resolved (I ran into problems trying to use
>> crossdev, so I'll have to manually inspect headers after I track down
>> which versions are used in the Redhat distros specified), please
>> remember that you _can_ always comment out the line which says:
>>
>> /* Define to 1 if you have the <asm/ptrace.h> header file. */
>> #define HAVE_ASM_PTRACE_H 1
>>
>> Actually, I think I'll just remove that header check if the build
>> passes unless Mike objects, because we really shouldn't be
>> #include'ing asm/* headers without having a good reason to do so
>> because it results in pain of this magnitude...
>
> i guess i dont know why you've made changes to the ptrace.h header at all.
> the original one i committed still works for me on bfin/ia64/x86/x86_64. =
=A0i
> dont recall any questions being posted to the list about the logic, just
> random shuffling to try and "fix" errors that i have yet to see.

    You're right. I've reverted to your original copy and everything
just works on my Gentoo box. I need to determine if our headers are
f'ed up at work -- I wouldn't be surprised if that's the case.
    If others need for this to be fixed on their toolchains /
platforms, we'll definitely need access to the tools and/or maybe the
hardware in order to verify that the changes are sane.
Thanks as always :\,
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
