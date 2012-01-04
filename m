Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1RiPa7-0004HN-C8
	for ltp-list@lists.sourceforge.net; Wed, 04 Jan 2012 12:04:35 +0000
Received: from mail-tul01m020-f175.google.com ([209.85.214.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1RiPa6-0007h1-Je
	for ltp-list@lists.sourceforge.net; Wed, 04 Jan 2012 12:04:35 +0000
Received: by obcwn6 with SMTP id wn6so19173887obc.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 04 Jan 2012 04:04:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4F043605.9050703@imgtec.com>
References: <4F02E1B9.2090603@imgtec.com>
	<CAGH67wRnBFxdBgQos0Px8GscXQ+Sn30JNmM-z2KU7-v6Vc7d3A@mail.gmail.com>
	<4F043605.9050703@imgtec.com>
Date: Wed, 4 Jan 2012 04:04:29 -0800
Message-ID: <CAGH67wR_qD3pc_k7qdeyRWq60V6qr6A7yeT9Q4zcYTLrJ-WBkA@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH 09/21] realtime/lib/Makefile: Fix path for
	config.mk
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
To: Markos Chandras <Markos.Chandras@imgtec.com>
Cc: ltp-list@lists.sourceforge.net

On Wed, Jan 4, 2012 at 3:20 AM, Markos Chandras
<Markos.Chandras@imgtec.com> wrote:
> On 01/03/2012 07:24 PM, Garrett Cooper wrote:
>>
>> On Tue, Jan 3, 2012 at 3:08 AM, Markos Chandras
>> <Markos.Chandras@imgtec.com> =A0wrote:
>>>
>>> Hi, please review the attached patch
>>
>>
>> No -- this breaks out-of-tree compiles.
>> -Garrett
>
> But without this patch, the in-tree 'distclean' target is broken

    Hmmm... it worked once upon a time. I'll look at this when I have a cha=
nce.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Ridiculously easy VDI. With Citrix VDI-in-a-Box, you don't need a complex
infrastructure or vast IT resources to deliver seamless, secure access to
virtual desktops. With this all-in-one solution, easily deploy virtual =

desktops for less than the cost of PCs and save 60% on VDI infrastructure =

costs. Try it free! http://p.sf.net/sfu/Citrix-VDIinabox
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
