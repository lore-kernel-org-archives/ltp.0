Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <yanegomi@gmail.com>) id 1Ppa34-0006ed-Mc
	for ltp-list@lists.sourceforge.net; Wed, 16 Feb 2011 05:35:34 +0000
Received: from mail-wy0-f175.google.com ([74.125.82.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.74) id 1Ppa31-0004nX-VH
	for ltp-list@lists.sourceforge.net; Wed, 16 Feb 2011 05:35:34 +0000
Received: by wyb40 with SMTP id 40so946863wyb.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 15 Feb 2011 21:35:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4D5B4B51.2010301@cn.fujitsu.com>
References: <4D5A47E5.3060108@cn.fujitsu.com>
	<AANLkTikjFEnngX7__W7gK8UBTV8O50vf-My5unK_P=8p@mail.gmail.com>
	<4D5B4B51.2010301@cn.fujitsu.com>
Date: Tue, 15 Feb 2011 21:35:25 -0800
Message-ID: <AANLkTi=Q+WHsOq2Cxep605YKVET6Xk0G5CJUMB1tdZ=C@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] unshare01.c: TEST_RETURN is used wrong
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

On Tue, Feb 15, 2011 at 7:58 PM, Peng Haitao <penght@cn.fujitsu.com> wrote:
> Hi Garrett,
>
> Garrett Cooper said the following on 2011-2-15 22:29:
>>
>> How about this?
>
> =A0The patch is OK, thanks.
> but "break;" in block "default:" can be deleted:)

Sure -- thanks!
-Garrett

---------------------------------------------------------------------------=
---
The ultimate all-in-one performance toolkit: Intel(R) Parallel Studio XE:
Pinpoint memory and threading errors before they happen.
Find and fix more than 250 security defects in the development cycle.
Locate bottlenecks in serial and parallel code that limit performance.
http://p.sf.net/sfu/intel-dev2devfeb
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
