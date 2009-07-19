Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MSP3a-00074C-KO
	for ltp-list@lists.sourceforge.net; Sun, 19 Jul 2009 05:35:30 +0000
Received: from wf-out-1314.google.com ([209.85.200.172])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MSP3T-0003j6-DE
	for ltp-list@lists.sourceforge.net; Sun, 19 Jul 2009 05:35:30 +0000
MIME-Version: 1.0
In-Reply-To: <200907190126.47767.vapier@gentoo.org>
References: <1247741996.3886.5.camel@dyn9002018117.watson.ibm.com>
	<364299f40907182215q56ff7c3au5971afb877d4aa15@mail.gmail.com>
	<200907190126.47767.vapier@gentoo.org>
Date: Sat, 18 Jul 2009 22:35:22 -0700
Message-ID: <364299f40907182235m7bbcc16bka760ffc2d0ae3384@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] ltp: IMA cross platform fixes
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
Cc: waqar afridi <afridi.waqar@gmail.com>, ltp-list@lists.sourceforge.net, Shaz <shazalive@gmail.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>, ltp-list <ltp-list@lists.sf.net>

On Sat, Jul 18, 2009 at 10:26 PM, Mike Frysinger<vapier@gentoo.org> wrote:
> On Sunday 19 July 2009 01:15:04 Garrett Cooper wrote:
>> =A0 =A0 /bin/sh should remain the standard, but a number of changes need
>> to happen to the .sh scripts to make them POSIX compatible, e.g.
>> backticks execution should become $(), etc. Let's not make things
>> bash-only...
>
> umm, `cmd` is in POSIX

    Not anymore; a fellow bourne shell-ist at work noted that it
wasn't POSIX compliant anymore, after consulting the POSIX 2001
reference:

http://publib.boulder.ibm.com/infocenter/systems/index.jsp?topic=3D/com.ibm=
.aix.baseadmn/doc/baseadmndita/korn_shell_comm_sub.htm

Thanks,
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
