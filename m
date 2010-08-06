Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1OhQU7-0005yN-Ta
	for ltp-list@lists.sourceforge.net; Fri, 06 Aug 2010 17:13:31 +0000
Received: from mail-gx0-f174.google.com ([209.85.161.174])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OhQU5-0001ry-OF
	for ltp-list@lists.sourceforge.net; Fri, 06 Aug 2010 17:13:31 +0000
MIME-Version: 1.0
In-Reply-To: <52CF90264091A14888078A031D780F43062CA316@ism-mail03.corp.ad.wrs.com>
References: <4C56CAAF020000E800067098@sinclair.provo.novell.com>
	<52CF90264091A14888078A031D780F43062CA316@ism-mail03.corp.ad.wrs.com>
Date: Fri, 6 Aug 2010 10:13:23 -0700
Message-ID: <AANLkTimPQfqQdh+ZgAtRnr+v+=VJiAEb=EVfOPk6bTJ0@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [Patch] The sysctl system call will return EACCES error
	number on the new kernel
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
To: "Fu, Yingang" <Yingang.Fu@windriver.com>
Cc: ltp-list <ltp-list@lists.sf.net>

On Fri, Aug 6, 2010 at 2:52 AM, Fu, Yingang <Yingang.Fu@windriver.com> wrot=
e:
> =A0 =A0 The sysctl system call will return EACCES error number on the new
> kernel when
> =A0 =A0the user try to change the system parameter under
> /proc/sys/kernel/ostype and
> =A0 =A0some other readonly parameters, but sysctl03 expected EPERM which
> will cause
> =A0 =A0the test fail.

There's some history behind this issue: http://lkml.org/lkml/2010/3/4/309 .

Given that documentation is probably not up to date for this yet, I'll
just integrate the code that was provided (by Shi?) into the
repository later on today or tomorrow. But the patch you provided
doesn't make sense, even in terms of C code (you probably missed
braces or something)...

Thanks,
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
