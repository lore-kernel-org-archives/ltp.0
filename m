Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1OxhJr-0007Sb-4F
	for ltp-list@lists.sourceforge.net; Mon, 20 Sep 2010 14:26:11 +0000
Received: from mail-gx0-f174.google.com ([209.85.161.174])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OxhJn-0007T3-4C
	for ltp-list@lists.sourceforge.net; Mon, 20 Sep 2010 14:26:11 +0000
MIME-Version: 1.0
In-Reply-To: <4C971855020000E800068F16@sinclair.provo.novell.com>
References: <4C936C31020000E800068DF2@sinclair.provo.novell.com>
	<AANLkTimUonwvA6PRiTzM01aC6EUf3SMp+ACfG0TJci2S@mail.gmail.com>
	<4C971855020000E800068F16@sinclair.provo.novell.com>
Date: Mon, 20 Sep 2010 07:26:01 -0700
Message-ID: <AANLkTik78x1qk+M1Q2pqpRnUi64V9zBcmV84A5vUwj=G@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [Patch] enable hyperthreading tests
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
To: Murlin Wenzel <mwenzel@novell.com>
Cc: ltp-list <ltp-list@lists.sf.net>

On Mon, Sep 20, 2010 at 7:16 AM, Murlin Wenzel <mwenzel@novell.com> wrote:
>>>> On 9/17/2010 at 03:22 PM, in message
> <AANLkTimUonwvA6PRiTzM01aC6EUf3SMp+ACfG0TJci2S@mail.gmail.com>, Garrett C=
ooper
> <yanegomi@gmail.com> wrote:
>> On Fri, Sep 17, 2010 at 12:25 PM, Murlin Wenzel <mwenzel@novell.com> wro=
te:
>>> Currently the hyperthreading tests will only run on 32bit (i386) os
>> versions. =A0HT is also supported on x86_64, so I changed defines to all=
ow
>> either os version.
>>>
>>> Signed-off-by: Murlin Ray Wenzel <mwenzel@novell.com>
>>
>> Seems sane. Could you change `i386 architecture' to `x86 architecture'
>> please?
>> Thanks,
>> -Garrett
>
> Added requested change from i386 to x86 in print statements.

    Committed. As a sidenote, it's referred to as SMT, not HTT in
newer processors. SMT is the more generalized implementation of HTT.
Cheers,
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
