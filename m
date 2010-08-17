Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1OlSQr-0004Gd-Oz
	for ltp-list@lists.sourceforge.net; Tue, 17 Aug 2010 20:06:49 +0000
Received: from mail-bw0-f47.google.com ([209.85.214.47])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OlSQq-0007Oa-So
	for ltp-list@lists.sourceforge.net; Tue, 17 Aug 2010 20:06:49 +0000
Received: by bwz12 with SMTP id 12so4096234bwz.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 17 Aug 2010 13:06:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTin4Fcwsf6dQU6mSmBJgGhGWpWXntVtQQ4sk157K@mail.gmail.com>
References: <4C6AB19B.6060706@redhat.com>
	<AANLkTimurpbzZtn50_UNh0SRWsBPNWDcCYpbinNPH4Gj@mail.gmail.com>
	<AANLkTikdoWmHJT0-J_tSEar1698-_pO9mepCZp27ZWnZ@mail.gmail.com>
	<AANLkTikeApsK=CMUjO6B26GDZmWkFWTWwBn0RUE9bPC3@mail.gmail.com>
	<AANLkTin4Fcwsf6dQU6mSmBJgGhGWpWXntVtQQ4sk157K@mail.gmail.com>
Date: Tue, 17 Aug 2010 13:06:42 -0700
Message-ID: <AANLkTinG4UpHN01dd+d=LGCeqQBFCX1kZ1t=goPKwr_q@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] running LTP on uClinux
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: dmarlin@redhat.com, ltp-list <ltp-list@lists.sourceforge.net>

On Tue, Aug 17, 2010 at 12:58 PM, Mike Frysinger <vapier@gentoo.org> wrote:
> On Tue, Aug 17, 2010 at 3:51 PM, Garrett Cooper wrote:
>> On Tue, Aug 17, 2010 at 9:42 AM, Mike Frysinger wrote:
>>> On Tue, Aug 17, 2010 at 12:31 PM, Garrett Cooper wrote:
>>>> Let me know how this patch works for you.
>>>
>>> the logic in lib/Makefile should be unified with this
>>
>> lib.mk picks up env_post.mk, so it's already caught there. Or are you
>> referring to how libltp is built and what headers are picked up from
>> include/ ?
>
> i mean there should not be more than one place in the whole tree which
> adds -DUCLINUX/etc... =A0if we merge your patch, there will be. =A0i'm not
> saying your patch is wrong, just that something needs fixing to avoid
> the aforementioned scenario.

Sure. I had forgotten whether or not there was still a reference to
UCLINUX in lib/Makefile. Thanks for the reminder :).
-Garrett

---------------------------------------------------------------------------=
---
This SF.net email is sponsored by =


Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev =

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
