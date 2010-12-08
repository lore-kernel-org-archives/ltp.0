Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PQFvR-0003mD-Gp
	for ltp-list@lists.sourceforge.net; Wed, 08 Dec 2010 09:03:01 +0000
Received: from mail-wy0-f175.google.com ([74.125.82.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PQFvQ-00067R-FE
	for ltp-list@lists.sourceforge.net; Wed, 08 Dec 2010 09:03:01 +0000
Received: by wyb40 with SMTP id 40so839914wyb.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 08 Dec 2010 01:02:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1887538489.253411291707401443.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
References: <1023907111.253391291707398584.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<1887538489.253411291707401443.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
Date: Wed, 8 Dec 2010 01:02:51 -0800
Message-ID: <AANLkTimHnh_gDnxjYhLDBnHQaCH_cy-7KeRWLom+jYqF@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH v2] munmap() don't check sysctl_max_mapcount
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

On Mon, Dec 6, 2010 at 11:36 PM,  <caiqian@redhat.com> wrote:
> >From http://lkml.org/lkml/2009/10/2/85:
>
> On ia64, the following test program exit abnormally, because glibc
> thread library called abort().
>
> =A0=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> =A0(gdb) bt
> =A0#0 =A00xa000000000010620 in __kernel_syscall_via_break ()
> =A0#1 =A00x20000000003208e0 in raise () from /lib/libc.so.6.1
> =A0#2 =A00x2000000000324090 in abort () from /lib/libc.so.6.1
> =A0#3 =A00x200000000027c3e0 in __deallocate_stack () from
> =A0 =A0 /lib/libpthread.so.0
> =A0#4 =A00x200000000027f7c0 in start_thread () from /lib/libpthread.so.0
> =A0#5 =A00x200000000047ef60 in __clone2 () from /lib/libc.so.6.1
> =A0=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> The fact is, glibc call munmap() when thread exitng time for freeing
> stack, and it assume munlock() never fail. However, munmap() often make
> vma splitting and it with many mapcount make -ENOMEM.
>
> Oh well, stack unfreeing is not reasonable option. Also munlock() via
> free() shouldn't failed.
>
> Thus, munmap() shoudn't check max-mapcount.

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
