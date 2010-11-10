Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PG61B-0002yq-Gn
	for ltp-list@lists.sourceforge.net; Wed, 10 Nov 2010 08:26:57 +0000
Received: from mail-ww0-f41.google.com ([74.125.82.41])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PG61A-0003p2-D8
	for ltp-list@lists.sourceforge.net; Wed, 10 Nov 2010 08:26:57 +0000
Received: by wwb29 with SMTP id 29so880084wwb.4
	for <ltp-list@lists.sourceforge.net>;
	Wed, 10 Nov 2010 00:26:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4CDA4BAA.6090507@cn.fujitsu.com>
References: <4CD7A81E.1020603@cn.fujitsu.com> <4CDA4BAA.6090507@cn.fujitsu.com>
Date: Wed, 10 Nov 2010 00:26:49 -0800
Message-ID: <AANLkTimS7Wh-awOrYVPnN_1asnS_cGxvWE1X3DrA=k4u@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [RFC][PATCH]Skip DOTS category always
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
To: Gui Jianfeng <guijianfeng@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

On Tue, Nov 9, 2010 at 11:37 PM, Gui Jianfeng
<guijianfeng@cn.fujitsu.com> wrote:
> Bian Naimeng wrote:
>> After applied commit 43b57dbb4b959203bda5743ee7ff36c627e0911c, some erro=
r are caught
>> when install test suite.
>>
>> make[2]: Entering directory `/home/biannm/ltp-882ad81/testcases/DOTS'
>> make[2]: *** No rule to make target `install'. =A0Stop.
>> make[2]: Leaving directory `/home/biannm/ltp-882ad81/testcases/DOTS'
>> make[1]: *** [install] Error 2
>> make[1]: Leaving directory `/home/biannm/ltp-882ad81/testcases'
>> make: *** [testcases-install] Error 2
>>
>> The commit 43b57dbb4b959203bda5743ee7ff36c627e0911c looks to fix some co=
nfigure error
>> reported by mitani-san. But at the older LTP, Dots is be filtered out al=
ways, why we
>> add a checking, it looks unnecessary.
>>
>> ------
>> Dots need be skip always.
>>
>> Signed-off-by: Bian Naimeng <biannm@cn.fujitsu.com>
>
> Hi Garrettt,
>
> This installation failure is really noisy. Would you Apply this patch?

    DOTS is no longer built as part of the standard build as of last
night and unless someone speaks up opposing it, it's going away
tomorrow evening.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
The Next 800 Companies to Lead America's Growth: New Video Whitepaper
David G. Thomson, author of the best-selling book "Blueprint to a =

Billion" shares his insights and actions to help propel your =

business during the next growth cycle. Listen Now!
http://p.sf.net/sfu/SAP-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
