Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MSP3v-0002Ax-Vt
	for ltp-list@lists.sourceforge.net; Sun, 19 Jul 2009 05:35:51 +0000
Received: from mail-px0-f190.google.com ([209.85.216.190])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MSP3r-0003q4-6O
	for ltp-list@lists.sourceforge.net; Sun, 19 Jul 2009 05:35:51 +0000
Received: by pxi28 with SMTP id 28so1375464pxi.28
	for <ltp-list@lists.sourceforge.net>;
	Sat, 18 Jul 2009 22:35:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <200907190122.36427.vapier@gentoo.org>
References: <4A5E7649.9040705@cn.fujitsu.com>
	<364299f40907182147l4239c229m25eb180ea7c8ebf9@mail.gmail.com>
	<200907190122.36427.vapier@gentoo.org>
Date: Sat, 18 Jul 2009 22:35:46 -0700
Message-ID: <364299f40907182235w20963c85nac20db697902d04e@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] fix the system call number of exit_group01
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

On Sat, Jul 18, 2009 at 10:22 PM, Mike Frysinger<vapier@gentoo.org> wrote:
> On Sunday 19 July 2009 00:47:29 Garrett Cooper wrote:
>> On Wed, Jul 15, 2009 at 5:37 PM, Wei Yongjun<yjwei@cn.fujitsu.com> wrote:
>> > The system call number is depend on the system architecture, not always
>> > 252. This patch fixed the problem.
>> >
>> > --- a/testcases/kernel/syscalls/exit_group/exit_group01.c
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TEST(sys=
call(252,4));
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TEST(sys=
call(__NR_exit_group,4));
>>
>> =A0 =A0 The best way to do this (IMHO) may be to add the relevant syscall
>> number to the architecture specific .in file in
>> testcases/kernel/include. Do you have the syscall number for your
>> architecture?
>
> both should be done. =A0syscall() should never be used with a hardcoded #.

Agreed.
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
