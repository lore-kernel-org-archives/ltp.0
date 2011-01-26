Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PhzWQ-0005ID-3B
	for ltp-list@lists.sourceforge.net; Wed, 26 Jan 2011 07:10:30 +0000
Received: from mail-wy0-f175.google.com ([74.125.82.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.72) id 1PhzWP-00083z-2k
	for ltp-list@lists.sourceforge.net; Wed, 26 Jan 2011 07:10:30 +0000
Received: by wyb40 with SMTP id 40so622386wyb.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 25 Jan 2011 23:10:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4D3FC82E.707@cn.fujitsu.com>
References: <4D3FC51B.3080306@cn.fujitsu.com>
	<AANLkTin52dVdOUf0K25Sma2NrGLmet9aK7tbUmg3fKds@mail.gmail.com>
	<4D3FC82E.707@cn.fujitsu.com>
Date: Tue, 25 Jan 2011 23:10:22 -0800
Message-ID: <AANLkTinu5ryOQW1MyO9Pywjm7Uph7WK11tfoMD2rU_1x@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] Fix Makefile of testcase/kernel/mem/ksm/
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
To: Bian Naimeng <biannm@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

On Tue, Jan 25, 2011 at 11:07 PM, Bian Naimeng <biannm@cn.fujitsu.com> wrot=
e:
>
>
> Garrett Cooper wrote:
>> On Tue, Jan 25, 2011 at 10:54 PM, Bian Naimeng <biannm@cn.fujitsu.com> w=
rote:
>>> There is not any directory at testcase/kernel/mem/ksm/,
>>> so replace generic_trunk_target.mk by generic_leaf_target.mk
>>>
>>> Signed-off-by: Bian Naimeng <biannm@cn.fujitsu.com>
>>>
>>> ---
>>> =A0testcases/kernel/mem/ksm/Makefile | =A0 =A02 +-
>>> =A01 files changed, 1 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/testcases/kernel/mem/ksm/Makefile b/testcases/kernel/mem/k=
sm/Makefile
>>> index 81509bf..22190f1 100644
>>> --- a/testcases/kernel/mem/ksm/Makefile
>>> +++ b/testcases/kernel/mem/ksm/Makefile
>>> @@ -39,5 +39,5 @@ trunk-clean:: | lib-clean
>>> =A0lib-clean:: $(LIBDIR)
>>> =A0 =A0 =A0 =A0$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" clean
>>>
>>> -include $(top_srcdir)/include/mk/generic_trunk_target.mk
>>> =A0include $(top_srcdir)/include/mk/testcases.mk
>>> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
>>
>> =A0 =A0 Forgot about that Makefile that Cai submitted. How about this in=
stead?
>
> Looks better than mine. Please commit it.

Committed -- thanks!
-Garrett

---------------------------------------------------------------------------=
---
Special Offer-- Download ArcSight Logger for FREE (a $49 USD value)!
Finally, a world-class log management solution at an even better price-free!
Download using promo code Free_Logger_4_Dev2Dev. Offer expires =

February 28th, so secure your free ArcSight Logger TODAY! =

http://p.sf.net/sfu/arcsight-sfd2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
