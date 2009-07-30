Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <naresh.kernel@gmail.com>) id 1MWOyf-0002QI-TX
	for ltp-list@lists.sourceforge.net; Thu, 30 Jul 2009 06:18:57 +0000
Received: from mail-yw0-f203.google.com ([209.85.211.203])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MWOyZ-0000ib-1i
	for ltp-list@lists.sourceforge.net; Thu, 30 Jul 2009 06:18:57 +0000
Received: by ywh41 with SMTP id 41so582159ywh.23
	for <ltp-list@lists.sourceforge.net>;
	Wed, 29 Jul 2009 23:18:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <364299f40907292020g4c35caa4u12081032154f6301@mail.gmail.com>
References: <f5a7b3810907290310h159a8fcby374e7d6b789a6d16@mail.gmail.com>
	<364299f40907292020g4c35caa4u12081032154f6301@mail.gmail.com>
Date: Thu, 30 Jul 2009 11:48:43 +0530
Message-ID: <f5a7b3810907292318y75e43a83x4678c3acecf72a81@mail.gmail.com>
From: naresh kamboju <naresh.kernel@gmail.com>
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>, Mike Frysinger <vapier@gentoo.org>, Brandon Philips <bphilips@suse.de>, maxin john <maxinbjohn@gmail.com>

Hi Garrett,

There were no discussions from 2005 in posix community.

Ref:

http://posixtest.sourceforge.net/
http://nptl.bullopensource.org/


Since open_posix_testsuite is sub module of LTP,
I have been reporting test cases bugs from 2008 and porting directly
to open Posix testsuite of LTP after LTP members review.

There are pretty good LTP members who review and works on posix.

Best regards,
Naresh Kamboju

On Thu, Jul 30, 2009 at 8:50 AM, Garrett Cooper<yanegomi@gmail.com> wrote:
> On Wed, Jul 29, 2009 at 3:10 AM, naresh kamboju<naresh.kernel@gmail.com> =
wrote:
>> Hi,
>>
>> I have notice HUNG status for pthread_equal/2-1.c under posix test suite.
>> conformance/interfaces/pthread_equal/2-1.test:execution:HUNG
>>
>> This because of while(do_it)loop is behaving as while(1).
>> do_it updated value from one thread is not reflecting in the other
>> thread because the type is not proper.
>> I have changed the type from char -> volatile int
>>
>> I have shared results before and after this patch.
>>
>> Before PATCH:
>> conformance/interfaces/pthread_equal/2-1.test:execution:HUNG
>>
>> After PATCH:
>> conformance/interfaces/pthread_equal/2-1.test:execution:PASS
>>
>> I have attached patch and below.
>> Please review the same.
>>
>> Best regards,
>> Naresh Kamboju
>>
>> Signed-off-by: Naresh Kamboju < naresh.kernel@gmail.com >
>>
>> diff -Naurb a/testcases/open_posix_testsuite/conformance/interfaces/pthr=
ead_equal/2-1.c
>> b/testcases/open_posix_testsuite/conformance/interfaces/pthread_equal/2-=
1.c
>> --- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_equa=
l/2-1.c 2005-06-03
>> 22:01:47.000000000 +0530
>> +++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_equa=
l/2-1.c 2009-07-29
>> 14:27:05.000000000 +0530
>> @@ -80,7 +80,7 @@
>> =A0/*********************************** =A0 =A0Test cases
>> *****************************************/
>> =A0/********************************************************************=
************************/
>>
>> -char do_it=3D1;
>> +volatile int do_it=3D1;
>> =A0unsigned long count_ope=3D0;
>> =A0#ifdef WITH_SYNCHRO
>> =A0sem_t semsig1;
>
> Naresh,
> =A0 =A0Have you contributed this back to openposix, or at the very least
> filed a bug about this that can be referenced?
> Thanks,
> -Garrett
>

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
