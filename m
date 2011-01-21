Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PgD8A-0003jG-4h
	for ltp-list@lists.sourceforge.net; Fri, 21 Jan 2011 09:18:06 +0000
Received: from mail-wy0-f175.google.com ([74.125.82.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.72) id 1PgD89-0004bB-51
	for ltp-list@lists.sourceforge.net; Fri, 21 Jan 2011 09:18:06 +0000
Received: by wyb40 with SMTP id 40so1486135wyb.34
	for <ltp-list@lists.sourceforge.net>;
	Fri, 21 Jan 2011 01:17:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4D394E65.2010601@cn.fujitsu.com>
References: <4D39456D.4040308@cn.fujitsu.com>
	<AANLkTik7Zp+LZ8VcMGZMoHtdhcdKHkiqEOCN7s-nbE0c@mail.gmail.com>
	<4D394E65.2010601@cn.fujitsu.com>
Date: Fri, 21 Jan 2011 01:17:58 -0800
Message-ID: <AANLkTin5FE_kRx9Z-tUMUHgTxd69vDJPbtDz4D+2z_Ey@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] fix error of wrong return code in cases
 rt_sigsuspend01, sched_getaffinity01, ftest06, sem02 and hugemmap03
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
To: Peng Haitao <penght@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

On Fri, Jan 21, 2011 at 1:14 AM, Peng Haitao <penght@cn.fujitsu.com> wrote:
> Hi Garrett,
>
> Garrett Cooper said the following on 2011-1-21 16:43:
>> On Fri, Jan 21, 2011 at 12:35 AM, Peng Haitao <penght@cn.fujitsu.com> wr=
ote:
>>> Hi Garrett,
>>>
>>> "return 1" should be replaced with "tst_exit()" in the following cases.
>>
>> =A0 =A0 Patch please?
>
> The patch is in the first mail. Do you need an attached patch?

    Please see the style guide ( doc/style-guide.rst ) for requested
behavior on what to do when contributing patches.
Thanks!
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
