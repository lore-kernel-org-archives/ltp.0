Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1QMmH5-00032s-Vm
	for ltp-list@lists.sourceforge.net; Wed, 18 May 2011 19:19:15 +0000
Received: from mail-vw0-f47.google.com ([209.85.212.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1QMmH3-0004Op-Jw
	for ltp-list@lists.sourceforge.net; Wed, 18 May 2011 19:19:15 +0000
Received: by mail-vw0-f47.google.com with SMTP id 2so2143277vws.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 18 May 2011 12:19:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <loom.20110518T201407-12@post.gmane.org>
References: <loom.20110518T201407-12@post.gmane.org>
Date: Wed, 18 May 2011 12:19:13 -0700
Message-ID: <BANLkTinmF0SyfJHRrmD+ox6wnUx6LOTvgg@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] LTP version in ChangeLog not updated?
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
To: Sandip Bhattacharya <sandipb@foss-community.com>
Cc: ltp-list@lists.sourceforge.net

On Wed, May 18, 2011 at 11:16 AM, Sandip Bhattacharya
<sandipb@foss-community.com> wrote:
> I just cloned the LTP git repo from SF and ran the suite. Strangely, the =
report
> showed the LTP version to be an old one. Is something amiss?
>
>
> $ git log -1
> commit 61ac0eaf2a3f24378ed0ab20a1613134ab83843a
> Author: Cyril Hrubis <chrubis@suse.cz>
> Date: =A0 Wed May 11 17:08:32 2011 +0200
>
> =A0 =A0Add newline to include/cleanup.c to stop GCC from whining.
>
> =A0 =A0Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
>
>
> $ head ChangeLog
> LTP-20100831
>
> commit dd59d49d75598d163f1b4599067a9f0dcb70e6c4
> Author: Garrett Cooper <yanegomi@gmail.com>
> Date: =A0 Tue Aug 31 23:09:49 2010 -0700
>
> =A0 =A0The cacheflush system call does not return EINVAL in the latest Li=
nux
> =A0 =A0kernel. see the link:
> =A0 =A0A related patch about the cacheflush function:
> =A0 =A0http://lkml.org/lkml/2009/4/9/203

Updating the ChangeLog is a manual procedure (shouldn't be, but it is).
-Garrett

---------------------------------------------------------------------------=
---
What Every C/C++ and Fortran developer Should Know!
Read this article and learn how Intel has extended the reach of its =

next-generation tools to help Windows* and Linux* C/C++ and Fortran =

developers boost performance applications - including clusters. =

http://p.sf.net/sfu/intel-dev2devmay
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
