Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PfTwL-0005jv-Tk
	for ltp-list@lists.sourceforge.net; Wed, 19 Jan 2011 09:02:53 +0000
Received: from mail-ww0-f53.google.com ([74.125.82.53])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.72) id 1PfTwK-0007xM-Se
	for ltp-list@lists.sourceforge.net; Wed, 19 Jan 2011 09:02:53 +0000
Received: by wwi18 with SMTP id 18so598213wwi.10
	for <ltp-list@lists.sourceforge.net>;
	Wed, 19 Jan 2011 01:02:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <939890281.56169.1295424638444.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
References: <1653392548.56166.1295424632735.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<939890281.56169.1295424638444.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
Date: Wed, 19 Jan 2011 01:02:46 -0800
Message-ID: <AANLkTimDZjkcbbd9OFdRj--7iS7_Lo8XAvOfsRjho-Cx@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] fork13: pid reuse race
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
To: CAI Qian <caiqian@redhat.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

On Wed, Jan 19, 2011 at 12:10 AM, CAI Qian <caiqian@redhat.com> wrote:
> >From the mainline commit 5fdee8c4a5e1800489ce61963208f8cc55e42ea1:
>
> A program that repeatedly forks and waits is susceptible to having the
> same pid repeated, especially when it competes with another instance of
> the same program. =A0This is really bad for bash implementation.
> Furthermore, many shell scripts assume that pid numbers will not be used
> for some length of time.
>
> Race Description:
>
> A =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0B
>
> // pid =3D=3D offset =3D=3D n =A0 =A0 =A0 =A0 =A0 =A0// pid =3D=3D offset=
 =3D=3D n + 1
> test_and_set_bit(offset, map->page)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 test_and_=
set_bit(offset, map->page);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pid_ns->l=
ast_pid =3D pid;
> pid_ns->last_pid =3D pid;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 // pid =
=3D=3D n + 1 is freed (wait())
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 // Next f=
ork()...
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 last =3D =
pid_ns->last_pid; // =3D=3D n
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pid =3D l=
ast + 1;

Commit pending.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Protect Your Site and Customers from Malware Attacks
Learn about various malware tactics and how to avoid them. Understand =

malware threats, the impact they can have on your business, and how you =

can protect your company and customers by using code signing.
http://p.sf.net/sfu/oracle-sfdevnl
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
