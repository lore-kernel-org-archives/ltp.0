Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <naresh.kernel@gmail.com>) id 1MMM9Y-0000qf-0h
	for ltp-list@lists.sourceforge.net; Thu, 02 Jul 2009 13:16:40 +0000
Received: from mail-qy0-f200.google.com ([209.85.221.200])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MMM9X-0004Jm-3z
	for ltp-list@lists.sourceforge.net; Thu, 02 Jul 2009 13:16:39 +0000
Received: by qyk38 with SMTP id 38so1851462qyk.28
	for <ltp-list@lists.sourceforge.net>;
	Thu, 02 Jul 2009 06:16:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1246539672.9700.7.camel@subratamodak.linux.ibm.com>
References: <f5a7b3810907020556y371595fenf19bdbf7b5ea1d3e@mail.gmail.com>
	<1246539672.9700.7.camel@subratamodak.linux.ibm.com>
Date: Thu, 2 Jul 2009 18:41:00 +0530
Message-ID: <f5a7b3810907020611x2a4bd2ecy72947428a3484547@mail.gmail.com>
From: naresh kamboju <naresh.kernel@gmail.com>
Subject: Re: [LTP] rt_sigaction FAIL -> PASS
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
Cc: ltp-list@lists.sourceforge.net

On Thu, Jul 2, 2009 at 6:31 PM, Subrata Modak<subrata@linux.vnet.ibm.com> w=
rote:
> On Thu, 2009-07-02 at 18:26 +0530, naresh kamboju wrote:
>> Hi,
>>
>> I have noticed design issues in rt_sigaction test case.
>> After few changes test case reported as PASS.
>>
>> Shall I change the design and generate new patches.
>
> Yes, you can. But, provide the reasons for all - why you want to change
> the old, what does the old do/doesn=B4t and what does the new do/doesn
> =B4t :-)

Thanks for the info.
I'll send a patch in short.

Best regards
Naresh Kamboju
>
> Regards--
> Subrata
>
>>
>> Best regards,
>> Naresh Kamboju
>
>

---------------------------------------------------------------------------=
---
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
