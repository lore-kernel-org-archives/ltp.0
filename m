Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MbVnY-0006bf-3F
	for ltp-list@lists.sourceforge.net; Thu, 13 Aug 2009 08:36:36 +0000
Received: from qw-out-1920.google.com ([74.125.92.146])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MbVnT-0005Ln-9F
	for ltp-list@lists.sourceforge.net; Thu, 13 Aug 2009 08:36:36 +0000
Received: by qw-out-1920.google.com with SMTP id 5so201722qwc.4
	for <ltp-list@lists.sourceforge.net>;
	Thu, 13 Aug 2009 01:36:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <200908130136.16712.vapier@gentoo.org>
References: <364299f40907182138w484cc898gac9fe00dbde75afd@mail.gmail.com>
	<200908130136.16712.vapier@gentoo.org>
Date: Thu, 13 Aug 2009 01:36:25 -0700
Message-ID: <364299f40908130136m7a7d389k207cb3d5f2a2dd53@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] Fix bad strerror calls in
	testcases/kernel/syscalls/waitid01.c
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

On Wed, Aug 12, 2009 at 10:36 PM, Mike Frysinger<vapier@gentoo.org> wrote:
> On Sunday 19 July 2009 00:38:39 Garrett Cooper wrote:
>> =A0int errnochoose(void){ =A0 //choose the relative errno
>>
>> =A0 =A0 =A0switch (TEST_ERRNO){
>> - =A0 =A0 =A0 =A0case =A0 =A00: =A0 =A0 =A0tst_exit();
>> - =A0 =A0 =A0 =A0case =A0 =A0ECHILD: strerror((int)"ECHILD");
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> - =A0 =A0 =A0 =A0case =A0 =A0EINTR: =A0strerror((int)"EINTR");
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> - =A0 =A0 =A0 =A0case =A0 =A0EINVAL: strerror((int)"EINVAL");
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> - =A0 =A0 =A0 =A0default: =A0 =A0 strerror((int)"Other Error");
>> + =A0 =A0 =A0 =A0case =A00: =A0 =A0 tst_exit();
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>> + =A0 =A0 =A0 =A0default: =A0 =A0 strerror(TEST_ERRNO);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0 =A0 }
>
> maybe i'm missing something, but strerror() doesnt write any output, it
> returns a string. =A0so ignoring the return value of strerror() makes it
> pointless. =A0which means this whole function is useless ?
> -mike

Yes, you're absolutely correct now that I think about it. perror(3)
would be a whole different beast...
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
