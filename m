Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Ma0iw-0003Ux-Ep
	for ltp-list@lists.sourceforge.net; Sun, 09 Aug 2009 05:13:38 +0000
Received: from qw-out-1920.google.com ([74.125.92.147])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Ma0it-0000zz-D5
	for ltp-list@lists.sourceforge.net; Sun, 09 Aug 2009 05:13:38 +0000
Received: by qw-out-1920.google.com with SMTP id 5so872996qwc.4
	for <ltp-list@lists.sourceforge.net>;
	Sat, 08 Aug 2009 22:13:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <364299f40908082026r1fa95822p538298b334eaaefa@mail.gmail.com>
References: <E69DB27D-E186-4934-AB69-C5EDB67A48AF@kernel.crashing.org>
	<1249494775.13131.18.camel@lucio-laptop>
	<3E7F2B7B-6BA8-4179-B973-5DA7F4D7618A@kernel.crashing.org>
	<364299f40908061024l42cd1200n99e6e762a77c91d2@mail.gmail.com>
	<D4B24F3A-3BF2-41BA-9626-2D13AC12B515@kernel.crashing.org>
	<2E55F490-102A-4179-B0F2-ED7F5C0D1A12@kernel.crashing.org>
	<364299f40908082026r1fa95822p538298b334eaaefa@mail.gmail.com>
Date: Sat, 8 Aug 2009 22:13:29 -0700
Message-ID: <364299f40908082213w425fae44u9b73efe43386353a@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] top of tree fails to build on PPC fc11 box
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
To: Kumar Gala <galak@kernel.crashing.org>
Cc: LTP <ltp-list@lists.sourceforge.net>

On Sat, Aug 8, 2009 at 8:26 PM, Garrett Cooper<yanegomi@gmail.com> wrote:
> On Thu, Aug 6, 2009 at 11:07 AM, Kumar Gala<galak@kernel.crashing.org> wr=
ote:
>>
>> On Aug 6, 2009, at 12:43 PM, Kumar Gala wrote:
>>
>>>> =A0Ok. I have the time now so I'll install F11 amd64 and see what
>>>> happens. Something leads me to think that the build toolchain is
>>>> fubared, but that's just a hunch, as my copy of F10 (the last time I
>>>> ran the build) worked.
>>>> Thanks,
>>>> -Garrett
>>>
>>> interesting since I saw the same issues w/F10 amd64.
>>>
>>> - k
>>
>> I also just tried installing clean versions of automake, autoconf, m4 to
>> match the versions in the INSTALL file and got:
>>
>> autoconf-2.61
>> automake-1.10.2
>> m4-1.4.12
>>
>> and still get the same issue:
>>
>> touch config.mk
>> aclocal -I m4
>> autoconf
>> configure.ac:9: error: possibly undefined macro: AC_PROG_AR
>> =A0 =A0 If this token and others are legitimate, please use m4_pattern_a=
llow.
>> =A0 =A0 See the Autoconf documentation.
>> make: *** [configure] Error 1
>
> Kumar,
> =A0 =A0I have no idea what's wrong with your install, but it compiles
> perfectly fine on Fedora 11 / x86. I'll try with Fedora 10 in a few
> mins...

And Fedora 10 passed too on x86.

Try running ac-maintainer-clean first, from the top, then run make
autotools, then ./configure . Does that work?

HTH,
-Garrett

---------------------------------------------------------------------------=
---
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day =

trial. Simplify your report design, integration and deployment - and focus =
on =

what you do best, core application coding. Discover what's new with =

Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
