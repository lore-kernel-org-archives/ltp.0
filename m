Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MPP8O-0003ub-FW
	for ltp-list@lists.sourceforge.net; Fri, 10 Jul 2009 23:04:04 +0000
Received: from an-out-0708.google.com ([209.85.132.244])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MPP8N-0003gF-AY
	for ltp-list@lists.sourceforge.net; Fri, 10 Jul 2009 23:04:04 +0000
Received: by an-out-0708.google.com with SMTP id c38so614922ana.37
	for <ltp-list@lists.sourceforge.net>;
	Fri, 10 Jul 2009 16:04:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1247254145.5040.3.camel@subratamodak.linux.ibm.com>
References: <4A5436D4.6070201@petalogix.com>
	<364299f40907080719q4ab01842v7e47a352b8214b8a@mail.gmail.com>
	<4A54AEFA.3030100@petalogix.com>
	<364299f40907082230m27683f17yd042bd569d0a5165@mail.gmail.com>
	<4A55C646.5060805@petalogix.com>
	<364299f40907091011y2f988746n562e183b5d4276be@mail.gmail.com>
	<4A5782A5.2050301@petalogix.com>
	<364299f40907101221i1da178c5xc0211627c0872e85@mail.gmail.com>
	<1247254145.5040.3.camel@subratamodak.linux.ibm.com>
Date: Fri, 10 Jul 2009 16:04:02 -0700
Message-ID: <364299f40907101604l1239e7d6g1d2be3ca1def2869@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] IDcheck.sh - awk problem
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
To: subrata@linux.vnet.ibm.com
Cc: Mike Frysinger <vapier.adi@gmail.com>, LTP <ltp-list@lists.sourceforge.net>

On Fri, Jul 10, 2009 at 12:29 PM, Subrata
Modak<subrata@linux.vnet.ibm.com> wrote:
> On Fri, 2009-07-10 at 12:21 -0700, Garrett Cooper wrote:
>> On Fri, Jul 10, 2009 at 11:04 AM, Michal
>> Simek<michal.simek@petalogix.com> wrote:
>> > Garrett Cooper wrote:
>> >>
>> >> Wow. I must have been tired at the time; no idea why I used filter
>> >> instead of strip. Please try this instead.
>> >>
>> >> Signed-off-by: Garrett Cooper <yanegomi@gmail.com>
>> >>
>> > Sorry for delay.
>> >
>> > Tested-by: Michal Simek <monstr@monstr.eu>
>>
>> Subrata,
>> =A0 =A0 The fix for IDcheck.sh / the top-level Makefile is ready to be
>> committed to HEAD. Are we ok for commit?
>
> Garrett,
>
> Please go ahead. I am making for some final preparations for OLS
> 2009 ;-). Would you all be interested to see my paper:
>
> http://www.linuxsymposium.org/2009/view_abstract.php?content_key=3D24,
> http://www.linuxsymposium.org/2009/view_abstract.php?content_key=3D25,

Committed.

Sure! Looks like an interesting read -- feel free to copy the glibc
stuff that we found a few days ago as a reference if you like :}.

If you want me to check in my nose-based python unittests for
IDcheck.sh, I can do that as well.

Thanks!
-Garrett

---------------------------------------------------------------------------=
---
Enter the BlackBerry Developer Challenge  =

This is your chance to win up to $100,000 in prizes! For a limited time, =

vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize=
  =

details at: http://p.sf.net/sfu/Challenge
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
