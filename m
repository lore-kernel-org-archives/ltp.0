Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1OlSC4-0003GD-Bz
	for ltp-list@lists.sourceforge.net; Tue, 17 Aug 2010 19:51:32 +0000
Received: from mail-bw0-f47.google.com ([209.85.214.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OlSC3-0003tn-Dm
	for ltp-list@lists.sourceforge.net; Tue, 17 Aug 2010 19:51:32 +0000
Received: by bwz12 with SMTP id 12so4080880bwz.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 17 Aug 2010 12:51:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTikdoWmHJT0-J_tSEar1698-_pO9mepCZp27ZWnZ@mail.gmail.com>
References: <4C6AB19B.6060706@redhat.com>
	<AANLkTimurpbzZtn50_UNh0SRWsBPNWDcCYpbinNPH4Gj@mail.gmail.com>
	<AANLkTikdoWmHJT0-J_tSEar1698-_pO9mepCZp27ZWnZ@mail.gmail.com>
Date: Tue, 17 Aug 2010 12:51:25 -0700
Message-ID: <AANLkTikeApsK=CMUjO6B26GDZmWkFWTWwBn0RUE9bPC3@mail.gmail.com>
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

On Tue, Aug 17, 2010 at 9:42 AM, Mike Frysinger <vapier@gentoo.org> wrote:
> On Tue, Aug 17, 2010 at 12:31 PM, Garrett Cooper wrote:
>> It should be CPPFLAGS, and the definition should be in env_post.mk; I
>> never had a UCLINUX infrastructure to test with, so this might have
>> fallen between the cracks by accident about 8 months ago.
>
> building for a nommu target should work even when you're running a mmu
> toolchain for an mmu target. =A0the testcases simply assume things like
> fork() wont work and so fall back to ones that work in both places
> (like vfork). =A0the tests should be able to run & pass even with a mmu.

Ok.

>> Let me know how this patch works for you.
>
> the logic in lib/Makefile should be unified with this

lib.mk picks up env_post.mk, so it's already caught there. Or are you
referring to how libltp is built and what headers are picked up from
include/ ?
Thanks!
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
