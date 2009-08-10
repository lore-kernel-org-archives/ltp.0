Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MaX3d-0005ia-9E
	for Ltp-list@lists.sourceforge.net; Mon, 10 Aug 2009 15:45:09 +0000
Received: from mail-qy0-f181.google.com ([209.85.221.181])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MaX3W-000550-U9
	for Ltp-list@lists.sourceforge.net; Mon, 10 Aug 2009 15:45:09 +0000
Received: by qyk11 with SMTP id 11so2718887qyk.28
	for <Ltp-list@lists.sourceforge.net>;
	Mon, 10 Aug 2009 08:44:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <6213bc560908100129r7d59547ale6f55de87e858470@mail.gmail.com>
References: <6213bc560908070826u6c2b321ay446997891f2cc21f@mail.gmail.com>
	<1249892426.5187.12.camel@subratamodak.linux.ibm.com>
	<6213bc560908100129r7d59547ale6f55de87e858470@mail.gmail.com>
Date: Mon, 10 Aug 2009 08:44:57 -0700
Message-ID: <364299f40908100844l44497151g750f745648080c24@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] add_key01 & add_key02 test cases fails and shown as PASS
	in log file
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
To: srikanth krishnakar <skrishnakar@gmail.com>
Cc: Ltp-list@lists.sourceforge.net

On Mon, Aug 10, 2009 at 1:29 AM, srikanth
krishnakar<skrishnakar@gmail.com> wrote:
>
>
> On Mon, Aug 10, 2009 at 1:50 PM, Subrata Modak <subrata@linux.vnet.ibm.co=
m>
> wrote:
>>
>> On Fri, 2009-08-07 at 20:56 +0530, srikanth krishnakar wrote:
>> > I see these two test cases are failing on PowerPC target (ppc440) as
>> > shown in output file, but they are listed as PASS in log file of the
>> > LTP :
>> >
>> > Target : PowerPC (ppc440)
>> > Kernel: Linux-2.6.29
>> > LTP Version : ltp-full-20090731
>> >
>> > LTP output file :
>> > #############
>> >
>> >
>> > 1. add_key01
>> > --------------------
>> >
>> > <<<test_start>>>
>> > tag=3Dadd_key01 stime=3D1248549741
>> > cmdline=3D"add_key01"
>> > contacts=3D""
>> > analysis=3Dexit
>> > <<<test_output>>>
>> > add_key01 =A0 =A01 =A0TFAIL =A0: =A0add_key01 failed - errno =3D 38 : =
Function not
>> > implemented
>> > <<<execution_status>>>
>> > initiation_status=3D"ok"
>> > duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
>> > cutime=3D0 cstime=3D0
>> > <<<test_end>>>
>> >
>> > 2. add_key02
>> > ----------------------
>> >
>> > <<<test_start>>>
>> > tag=3Dadd_key02 stime=3D1248549741
>> > cmdline=3D"add_key02"
>> > contacts=3D""
>> > analysis=3Dexit
>> > <<<test_output>>>
>> > add_key02 =A0 =A00 =A0TINFO =A0: =A0call add_key() with wrong args got
>> > UNEXPECTED errno:38
>> > add_key02 =A0 =A01 =A0TFAIL =A0: =A0add_key02 failed - errno =3D 38 : =
Function not
>> > implemented
>> > <<<execution_status>>>
>> > initiation_status=3D"ok"
>> > duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
>> > cutime=3D0 cstime=3D1
>> > <<<test_end>>>
>> >
>> > --------------------------------------------------------
>> >
>> > BUT the Log file shows as PASS to the above test cases :
>> >
>> > ###########################
>> >
>> > add_key01 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0PASS =A0 =A0 =A0 0
>> > add_key02 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0PASS =A0 =A0 =A0 0
>> >
>> > ###########################
>> >
>> >
>> > May anyone explain, why it is so ? Is it a known behaviour ?
>>
>> No. It is not. On my X_32, it passes fine.
>
> Is it PowePC target on which you have tested ?
>>
>>
>> $ ./testcases/bin/add_key01
>> add_key01 =A0 =A01 =A0TPASS =A0: =A0add_key call succeeded
>> $ echo $?
>> 0
>> $ ./testcases/bin/add_key02
>> add_key02 =A0 =A00 =A0TINFO =A0: =A0call add_key() with wrong args got E=
XPECTED
>> errno:22
>> add_key02 =A0 =A01 =A0TPASS =A0: =A0add_key call succeeded
>> $ echo $?
>> 0
>> $ uname -a
>> Linux 2.6.18-92.el5 #1 SMP Tue Apr 29 13:16:12 EDT 2008 i686 i686 i386
>> GNU/Linux

Hi Srikanth,
    I think that the error is fairly intuitive (function not
implemented). Are you sure that your subarchitecture supports
add_key(2)?
Hi Subrata,
    As far as the actual issue is concerned, I think that the problem
is that someone's exiting with exit(0) instead of tst_exit()...
Thanks,
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
