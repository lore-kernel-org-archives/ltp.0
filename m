Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PfTja-0006eE-T2
	for ltp-list@lists.sourceforge.net; Wed, 19 Jan 2011 08:49:42 +0000
Received: from mail-wy0-f175.google.com ([74.125.82.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.72) id 1PfTja-0000DU-02
	for ltp-list@lists.sourceforge.net; Wed, 19 Jan 2011 08:49:42 +0000
Received: by wyb40 with SMTP id 40so571518wyb.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 19 Jan 2011 00:49:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <639439003.56154.1295424539927.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
References: <1818642692.56149.1295424534765.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<639439003.56154.1295424539927.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
Date: Wed, 19 Jan 2011 00:49:35 -0800
Message-ID: <AANLkTi=vTZLe9qf0LeDPVsspRG1ZxWCkG1HVXm=MMZcQ@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] tests require root users
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

On Wed, Jan 19, 2011 at 12:08 AM, CAI Qian <caiqian@redhat.com> wrote:
> Signed-off-by: CAI Qian <caiqian@redhat.com>
> ---
> =A0testcases/kernel/mem/cpuset/cpuset01.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =
=A03 ++-
> =A0testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c | =A0 =A01 +
> =A0testcases/kernel/syscalls/mlock/mlock03.c =A0 =A0 =A0 =A0 =A0| =A0 =A0=
4 +++-
> =A0testcases/kernel/syscalls/mmap/mmap10.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 =
=A03 ++-
> =A0testcases/kernel/syscalls/mmap/mmap11.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 =
=A03 ++-
> =A05 files changed, 10 insertions(+), 4 deletions(-)

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
