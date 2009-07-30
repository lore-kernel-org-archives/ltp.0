Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MWMCB-0003Jo-MF
	for ltp-list@lists.sourceforge.net; Thu, 30 Jul 2009 03:20:43 +0000
Received: from mail-pz0-f196.google.com ([209.85.222.196])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MWMC3-0001qP-Tn
	for ltp-list@lists.sourceforge.net; Thu, 30 Jul 2009 03:20:43 +0000
Received: by pzk34 with SMTP id 34so757797pzk.4
	for <ltp-list@lists.sourceforge.net>;
	Wed, 29 Jul 2009 20:20:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <f5a7b3810907290310h159a8fcby374e7d6b789a6d16@mail.gmail.com>
References: <f5a7b3810907290310h159a8fcby374e7d6b789a6d16@mail.gmail.com>
Date: Wed, 29 Jul 2009 20:20:29 -0700
Message-ID: <364299f40907292020g4c35caa4u12081032154f6301@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [FIX PATCH] open_posix_pthread_equal_2-1.c
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
To: naresh kamboju <naresh.kernel@gmail.com>
Cc: Mike Frysinger <vapier@gentoo.org>, ltp-list <ltp-list@lists.sourceforge.net>, maxin john <maxinbjohn@gmail.com>

On Wed, Jul 29, 2009 at 3:10 AM, naresh kamboju<naresh.kernel@gmail.com> wr=
ote:
> Hi,
>
> I have notice HUNG status for pthread_equal/2-1.c under posix test suite.
> conformance/interfaces/pthread_equal/2-1.test:execution:HUNG
>
> This because of while(do_it)loop is behaving as while(1).
> do_it updated value from one thread is not reflecting in the other
> thread because the type is not proper.
> I have changed the type from char -> volatile int
>
> I have shared results before and after this patch.
>
> Before PATCH:
> conformance/interfaces/pthread_equal/2-1.test:execution:HUNG
>
> After PATCH:
> conformance/interfaces/pthread_equal/2-1.test:execution:PASS
>
> I have attached patch and below.
> Please review the same.
>
> Best regards,
> Naresh Kamboju
>
> Signed-off-by: Naresh Kamboju < naresh.kernel@gmail.com >
>
> diff -Naurb a/testcases/open_posix_testsuite/conformance/interfaces/pthre=
ad_equal/2-1.c
> b/testcases/open_posix_testsuite/conformance/interfaces/pthread_equal/2-1=
.c
> --- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_equal=
/2-1.c 2005-06-03
> 22:01:47.000000000 +0530
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_equal=
/2-1.c 2009-07-29
> 14:27:05.000000000 +0530
> @@ -80,7 +80,7 @@
> =A0/*********************************** =A0 =A0Test cases
> *****************************************/
> =A0/*********************************************************************=
***********************/
>
> -char do_it=3D1;
> +volatile int do_it=3D1;
> =A0unsigned long count_ope=3D0;
> =A0#ifdef WITH_SYNCHRO
> =A0sem_t semsig1;

Naresh,
    Have you contributed this back to openposix, or at the very least
filed a bug about this that can be referenced?
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
