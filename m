Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NWIVN-000817-Nw
	for ltp-list@lists.sourceforge.net; Sat, 16 Jan 2010 23:56:33 +0000
Received: from mail-pw0-f43.google.com ([209.85.160.43])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NWIVM-0001H5-Tb
	for ltp-list@lists.sourceforge.net; Sat, 16 Jan 2010 23:56:33 +0000
Received: by pwj11 with SMTP id 11so1139992pwj.2
	for <ltp-list@lists.sourceforge.net>;
	Sat, 16 Jan 2010 15:56:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <200912190755.26999.vapier@gentoo.org>
References: <000001ca7d4d$e2a9e7e0$a7fdb7a0$@co.jp>
	<200912181331.36093.vapier@gentoo.org>
	<364299f40912182110w7e5591f1k4f1c59b292b642ad@mail.gmail.com>
	<200912190755.26999.vapier@gentoo.org>
Date: Sat, 16 Jan 2010 15:56:26 -0800
Message-ID: <364299f41001161556h9eb1dd4h5fa955044cd3b19b@mail.gmail.com>
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

On Sat, Dec 19, 2009 at 4:55 AM, Mike Frysinger <vapier@gentoo.org> wrote:
> On Saturday 19 December 2009 00:10:58 Garrett Cooper wrote:
>> On Fri, Dec 18, 2009 at 10:31 AM, Mike Frysinger <vapier@gentoo.org> wro=
te:
>> > On Tuesday 15 December 2009 14:39:24 Garrett Cooper wrote:
>> >> Until this issue is resolved (I ran into problems trying to use
>> >> crossdev, so I'll have to manually inspect headers after I track down
>> >> which versions are used in the Redhat distros specified), please
>> >> remember that you _can_ always comment out the line which says:
>> >>
>> >> /* Define to 1 if you have the <asm/ptrace.h> header file. */
>> >> #define HAVE_ASM_PTRACE_H 1
>> >>
>> >> Actually, I think I'll just remove that header check if the build
>> >> passes unless Mike objects, because we really shouldn't be
>> >> #include'ing asm/* headers without having a good reason to do so
>> >> because it results in pain of this magnitude...
>> >
>> > i guess i dont know why you've made changes to the ptrace.h header at
>> > all. the original one i committed still works for me on
>> > bfin/ia64/x86/x86_64. =A0i dont recall any questions being posted to t=
he
>> > list about the logic, just random shuffling to try and "fix" errors th=
at
>> > i have yet to see.
>>
>> =A0 =A0 You're right. I've reverted to your original copy and everything
>> just works on my Gentoo box. I need to determine if our headers are
>> f'ed up at work -- I wouldn't be surprised if that's the case.
>> =A0 =A0 If others need for this to be fixed on their toolchains /
>> platforms, we'll definitely need access to the tools and/or maybe the
>> hardware in order to verify that the changes are sane.
>
> feel free to post the error you're seeing at work with this version so we=
 can
> take a look.

    I'm not going to sweat it because it's most likely because the
build infrastructure and how they're cross-compiling junk and the
versioned packages used in my current group is fubar (paths are out of
whack and the sources are really feature incompatible). I'm leaving
the group in a week, so by the time they have to resolve this it may
or may not matter for them... thus, ultimately I don't care :}...
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Confere=
nce
attendees to learn about information security's most important issues throu=
gh
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
