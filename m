Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1OvxEi-0006yi-1o
	for ltp-list@lists.sourceforge.net; Wed, 15 Sep 2010 19:01:40 +0000
Received: from mail-iw0-f175.google.com ([209.85.214.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OvxEh-0006rD-0O
	for ltp-list@lists.sourceforge.net; Wed, 15 Sep 2010 19:01:40 +0000
Received: by iwn2 with SMTP id 2so425282iwn.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 15 Sep 2010 12:01:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100915182052.GA2750@hannu-ubuntu>
References: <000401cb53c6$d7a16620$86e43260$@co.jp>
	<20100915134318.GD24784@hannu-debian.research.nokia.com>
	<AANLkTikYz9ppRN1FZBSnpyePoMV79GDWNA4umS7NLUn_@mail.gmail.com>
	<20100915182052.GA2750@hannu-ubuntu>
Date: Wed, 15 Sep 2010 12:01:33 -0700
Message-ID: <AANLkTik5HT2tDzaCfAU+7kgcsUNucrL6zPLZ3xdBF+kW@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] POSIX "sched_yield/1-1.c" build failed
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
To: Hannu Heikkinen <hannuxx@iki.fi>
Cc: ext Mitani <mitani@ryobi.co.jp>, "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

On Wed, Sep 15, 2010 at 11:20 AM, Hannu Heikkinen <hannuxx@iki.fi> wrote:
> On 15/09/10 09:18 -0700, Garrett Cooper wrote:
>> That seems like a reasonable thing to do, but here's an alternative
>> way to do this (less variables):
>>
>> --- a/testcases/open_posix_testsuite/include/posixtest.h
>> +++ b/testcases/open_posix_testsuite/include/posixtest.h
>> @@ -10,10 +10,24 @@
>> =A0 * return codes
>> =A0 */
>>
>> +/*
>> + * Define PTS_DEVELOPER_MODE if you want to compile for developer scena=
rios,
>> + * including reporting errors (as opposed to warnings), when compiling =
some
>> + * test programs.
>> + */
>> +
>> =A0#if defined(_GNU_SOURCE)
>> +#if defined(PTS_DEVELOPER_MODE)
>> =A0#error "Contains GNU-isms that need fixing."
>> +#else
>> +#warning "Contains GNU-isms that need fixing."
>> +#endif
>> =A0#elif defined(_BSD_SOURCE)
>> +#if defined(PTS_DEVELOPER_MODE)
>> =A0#error "Contains BSD-isms that need fixing."
>> +#else
>> +#warning "Contains BSD-isms that need fixing."
>> +#endif
>> =A0#endif
>>
>> =A0#define PTS_PASS =A0 =A0 =A0 =A00
>>
>> Thanks for the idea Hannu :),
>> -Garrett
>>
>
> Ok, even better, less is always good! Developer mode sounds good.
>
> Should this posixtest.h be kind of a must include for all test cases?
> Currently not all cases include this.

    Well, every affected testcase should include this :). Not all
files need to include this (there are a number of applications that
don't need what's defined here) -- so there's no sense in generating
more work than necessary :).
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
