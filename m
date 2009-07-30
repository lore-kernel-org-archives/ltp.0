Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MWbFR-0002mL-RX
	for ltp-list@lists.sourceforge.net; Thu, 30 Jul 2009 19:25:05 +0000
Received: from mail-pz0-f180.google.com ([209.85.222.180])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MWbFQ-00043L-Lg
	for ltp-list@lists.sourceforge.net; Thu, 30 Jul 2009 19:25:05 +0000
Received: by pzk10 with SMTP id 10so65375pzk.28
	for <ltp-list@lists.sourceforge.net>;
	Thu, 30 Jul 2009 12:24:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4A713E40.2010000@cn.fujitsu.com>
References: <4A70F86E.50608@cn.fujitsu.com>
	<364299f40907292019r494348dt1e895f0c180f3f58@mail.gmail.com>
	<4A713E40.2010000@cn.fujitsu.com>
Date: Thu, 30 Jul 2009 12:24:57 -0700
Message-ID: <364299f40907301224o4007a6bbnadd176f67d87bf2@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] Fix failure of the utimensat01 test
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
To: Wang Yong <wangyong2009@cn.fujitsu.com>
Cc: LTP <ltp-list@lists.sourceforge.net>

On Wed, Jul 29, 2009 at 11:31 PM, Wang Yong<wangyong2009@cn.fujitsu.com> wr=
ote:
>
> Garrett Cooper wrote as:
>>
>> On Wed, Jul 29, 2009 at 6:33 PM, Wang Yong<wangyong2009@cn.fujitsu.com>
>> wrote:
>>
>>>
>>> The error handling for "RW" opt of run_test brought about error results.
>>> This patch fixed that.
>>>
>>> Signed-off-by: WangYong <wangyong2009@cn.fujitsu.com>
>>>
>>> diff -Nurp a/testcases/kernel/syscalls/utimensat/utimensat_tests.sh
>>> b/testcases/kernel/syscalls/utimensat/utimensat_tests.sh
>>> --- a/testcases/kernel/syscalls/utimensat/utimensat_tests.sh
>>> =A02009-07-28 16:23:39.000000000 +0800
>>> +++ b/testcases/kernel/syscalls/utimensat/utimensat_tests.sh
>>> =A02009-07-28 17:32:26.000000000 +0800
>>> @@ -260,22 +260,22 @@ echo "Testing read-only file, owned by s
>>> =A0echo
>>>
>>
>> [...]
>>
>> Don't these changes actually conflict with the testcase's purpose,
>> given the messages echoed placed directly above the commands?
>> Thanks,
>> -Garrett
>>
>>
>
> Hi Garrett,
>
> This patch doesn't change the testcase's purpose.
> And the test results prove it.

Wang,
    You're changing everything to RW -- how is that not contradicting
the phrase `Testing read-only file'?
    Just because things fail doesn't necessarily mean that the entire
intent is incorrect. Let's make sure not to lose sight of that point
:).
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
