Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1N5Lsm-00049S-Lw
	for ltp-list@lists.sourceforge.net; Tue, 03 Nov 2009 16:05:20 +0000
Received: from mail-px0-f179.google.com ([209.85.216.179])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N5Lsh-0002EQ-QC
	for ltp-list@lists.sourceforge.net; Tue, 03 Nov 2009 16:05:20 +0000
Received: by pxi9 with SMTP id 9so3968702pxi.4
	for <ltp-list@lists.sourceforge.net>;
	Tue, 03 Nov 2009 08:05:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <200911031050.38755.vapier@gentoo.org>
References: <1257220567.10382.3.camel@munipradeep-laptop>
	<1257238010.5162.12.camel@subratamodak.linux.ibm.com>
	<364299f40911030501y1c16a694r4ef8bfbfc80cb9cf@mail.gmail.com>
	<200911031050.38755.vapier@gentoo.org>
Date: Tue, 3 Nov 2009 08:05:10 -0800
Message-ID: <364299f40911030805m5e40d9c8w74a69d7f452200f8@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [Ltp-results] Got warning message on ltp-full-20091031
	while running ./configure
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
Cc: ltp-list@lists.sourceforge.net, ltp-list <ltp-list@lists.sf.net>

On Tue, Nov 3, 2009 at 7:50 AM, Mike Frysinger <vapier@gentoo.org> wrote:
> On Tuesday 03 November 2009 08:01:08 Garrett Cooper wrote:
>> >> On Tue, 2009-11-03 at 09:26 +0530, Munipradeep Beerakam wrote:
>> >> > I got the following warning messages while running "./configure" on
>> >> > the ltp-full-20091031. However, make and make install worked fine.
>> >> >
>> >> > configure: WARNING: linux/genetlink.h: present but cannot be compil=
ed
>> >> > configure: WARNING: linux/genetlink.h: =A0 =A0 check for missing
>> >> > prerequisite headers?
>> >> > configure: WARNING: linux/genetlink.h: see the Autoconf documentati=
on
>> >> > configure: WARNING: linux/genetlink.h: =A0 =A0 section "Present But=
 Cannot
>> >> > Be Compiled"
>> >> > configure: WARNING: linux/genetlink.h: proceeding with the
>> >> > preprocessor's result
>> >> > configure: WARNING: linux/genetlink.h: in the future, the compiler
>> >> > will take precedence
>> >> > configure: WARNING: =A0 =A0 ##
>> >> > ------------------------------------------------ ##
>> >> > configure: WARNING: =A0 =A0 ## Report this to
>> >> > ltp-results@lists.sourceforge.net ##
>> >> > configure: WARNING: =A0 =A0 ##
>> >> > ------------------------------------------------ ##
>>
>> =A0 =A0 Yeah -- I need to find the header that defines u32 (instead of
>> uint32 or uint32_t). Does anyone know which one was that again? I
>> thought it was a kernel specific datatype (and in that event it
>> shouldn't be exported).
>
> correct -- nothing in userspace should be using u32. =A0if the kernel hea=
ders
> are, they're broken and need fixing, so complain to lkml/your distro.

    That's what I figured -- ok. The test and the app should also be
converted to straight linux/genetlink.h, because linux/genetlink.h is
a superset of linux/netlink.h.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay =

ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
