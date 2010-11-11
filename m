Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PGU6q-0004E7-It
	for ltp-list@lists.sourceforge.net; Thu, 11 Nov 2010 10:10:24 +0000
Received: from mail-wy0-f175.google.com ([74.125.82.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PGU6p-0000xm-Hh
	for ltp-list@lists.sourceforge.net; Thu, 11 Nov 2010 10:10:24 +0000
Received: by wyi11 with SMTP id 11so962719wyi.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 11 Nov 2010 02:10:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4CDB6AEC.9090604@cn.fujitsu.com>
References: <4CDB6AEC.9090604@cn.fujitsu.com>
Date: Thu, 11 Nov 2010 02:10:17 -0800
Message-ID: <AANLkTikrWZ8TN3budzuxbUJgVEtzpt802G3DXYsZLGY2@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [POSIX][PATCH 0/4]Get rid of some test for aio_suspend.
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

2010/11/10 Bian Naimeng <biannm@cn.fujitsu.com>:
> Some aio_suspend tests are redundantly, so we should remove them.
>
> Signed-off-by: Bian Naimeng <biannm@cn.fujitsu.com>
>
> ------
>
> =A0.../conformance/interfaces/aio_suspend/6-1.c =A0 =A0 =A0 | =A0217 ----=
--------------
> =A0.../conformance/interfaces/aio_suspend/7-1.c =A0 =A0 =A0 | =A0242 ----=
----------------
> =A0.../conformance/interfaces/aio_suspend/8-1.c =A0 =A0 =A0 | =A0240 ----=
---------------
> =A0.../conformance/interfaces/aio_suspend/9-1.c =A0 =A0 =A0 | =A0242 ----=
----------------
> =A04 files changed, 0 insertions(+), 941 deletions(-)

This implies that the tests are broken and need to be fixed (see
assertions.xml for more details about what the tests need to test).

---------------------------------------------------------------------------=
---
Centralized Desktop Delivery: Dell and VMware Reference Architecture
Simplifying enterprise desktop deployment and management using
Dell EqualLogic storage and VMware View: A highly scalable, end-to-end
client virtualization framework. Read more!
http://p.sf.net/sfu/dell-eql-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
