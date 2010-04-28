Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <serge@us.ibm.com>) id 1O77Xh-0006ed-CH
	for ltp-list@lists.sourceforge.net; Wed, 28 Apr 2010 13:43:09 +0000
Received: from e39.co.us.ibm.com ([32.97.110.160])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1O77Xf-0005jR-T4
	for ltp-list@lists.sourceforge.net; Wed, 28 Apr 2010 13:43:09 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e39.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o3SDYXBD012414
	for <ltp-list@lists.sourceforge.net>; Wed, 28 Apr 2010 07:34:33 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	o3SDgv9D257924
	for <ltp-list@lists.sourceforge.net>; Wed, 28 Apr 2010 07:42:59 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o3SDgopY022714
	for <ltp-list@lists.sourceforge.net>; Wed, 28 Apr 2010 07:42:50 -0600
Date: Wed, 28 Apr 2010 08:42:52 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
Message-ID: <20100428134252.GA31204@us.ibm.com>
References: <1272444847.5696.9.camel@munipradeep-laptop>
	<y2q364299f41004280213xf8326524n9248b16b38d9cac4@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <y2q364299f41004280213xf8326524n9248b16b38d9cac4@mail.gmail.com>
Subject: Re: [LTP] mqns tests are failing
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Quoting Garrett Cooper (yanegomi@gmail.com):
> On Wed, Apr 28, 2010 at 1:54 AM, Munipradeep Beerakam
> <mpradeep@linux.vnet.ibm.com> wrote:
> > Hi,
> >
> > I noticed that mqns test cases are failing. I am using March 2010 LTP.
> > After changing mq_open syscall in mqns_01.c file, test is passing. Same
> > thing is happening w.r.t. other mqns test cases. Below is the change I
> > made.
> >
> > Changed
> > =A0 mqd =3D syscall(__NR_mq_open, SLASH_MQ1, O_RDWR|O_CREAT|O_EXCL,0777,
> > NULL);
> >
> > to
> > =A0 mqd =3D mq_open(SLASH_MQ1, O_RDWR|O_CREAT|O_EXCL, 0777, NULL);
> >
> > Failure output I got is below:
> > # ./mqns_01
> > posixmq_namespace_01 =A0 =A00 =A0TINFO =A0: =A0Testing posix mq namespa=
ces through
> > unshare(2).
> >
> > mq_open: Permission denied
> > posixmq_namespace_01 =A0 =A01 =A0TFAIL =A0: =A0mq_open failed
> >
> > After changing as above, I got the below output:
> > # ./mqns_01
> > posixmq_namespace_01 =A0 =A00 =A0TINFO =A0: =A0Testing posix mq namespa=
ces through
> > unshare(2).
> >
> > posixmq_namespace_01 =A0 =A00 =A0TINFO =A0: =A0Checking namespaces isol=
ation from
> > parent to child
> >
> > posixmq_namespace_01 =A0 =A01 =A0TPASS =A0: =A0child process didn't fin=
d mqueue
> >
> > So, my question is that what is the difference between the two, i.e.,
> > the previous one and the changed one. Both are calling the same mq_open

See http://www.mail-archive.com/ltp-list@lists.sourceforge.net/msg09073.html
for the ansswer.

> > system call. But first one is failing whereas the second one is
> > succeeding.
> >
> > So, do we need to modify all mqns test cases to the new form?
> =

>     Track down the execution path by first starting with glibc. It
> might be a library vs kernel mismatch or a bug. Make sure that the
> syscall number matches per your architecture, determine whether or not
> your architecture has issues executing code in a biarch manner (64-bit
> on 32-bit) if it applies.
> HTH,

-serge

---------------------------------------------------------------------------=
---
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
