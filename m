Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PQFYu-0004CW-J8
	for ltp-list@lists.sourceforge.net; Wed, 08 Dec 2010 08:39:44 +0000
Received: from mail-wy0-f175.google.com ([74.125.82.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PQFYt-00039Y-Mo
	for ltp-list@lists.sourceforge.net; Wed, 08 Dec 2010 08:39:44 +0000
Received: by wyb40 with SMTP id 40so823564wyb.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 08 Dec 2010 00:39:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1066118806.253351291707245941.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
References: <507792947.253331291707242881.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<1066118806.253351291707245941.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
Date: Wed, 8 Dec 2010 00:39:37 -0800
Message-ID: <AANLkTi=EeyNsR3LbXQN+A7u2FdhaGCc-HWWuHtZmEdW1@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH v2] Stack size mapping is decreased through
 mlock/munlock call
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
To: caiqian@redhat.com
Cc: ltp-list <ltp-list@lists.sourceforge.net>

On Mon, Dec 6, 2010 at 11:34 PM,  <caiqian@redhat.com> wrote:
> This is to test kernel if it has a problem with shortening [stack]
> mapping through several loops of =A0mlock/munlock of /proc/self/maps.
>
> From:
> munlock =A0 =A0 76KiB bfef2000-bff05000 rw-p 00000000 00:00 0 =A0 =A0 =A0=
 =A0 =A0[stack]
>
> To:
> munlock =A0 =A0 44KiB bfefa000-bff05000 rw-p 00000000 00:00 0 =A0 =A0 =A0=
 =A0 =A0[stack]
>
> With more iterations - could drop to 0KiB.

Committed.

---------------------------------------------------------------------------=
---
What happens now with your Lotus Notes apps - do you make another costly =

upgrade, or settle for being marooned without product support? Time to move
off Lotus Notes and onto the cloud with Force.com, apps are easier to build,
use, and manage than apps on traditional platforms. Sign up for the Lotus =

Notes Migration Kit to learn more. http://p.sf.net/sfu/salesforce-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
