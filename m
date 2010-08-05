Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <sukadev@linux.vnet.ibm.com>) id 1OgpPk-0004D4-SA
	for ltp-list@lists.sourceforge.net; Thu, 05 Aug 2010 01:38:32 +0000
Received: from e32.co.us.ibm.com ([32.97.110.150])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OgpPi-0003EE-Kx
	for ltp-list@lists.sourceforge.net; Thu, 05 Aug 2010 01:38:32 +0000
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e32.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o751UJ5c029642
	for <ltp-list@lists.sourceforge.net>; Wed, 4 Aug 2010 19:30:19 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o751cOrd165690
	for <ltp-list@lists.sourceforge.net>; Wed, 4 Aug 2010 19:38:24 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o751cOGp002789
	for <ltp-list@lists.sourceforge.net>; Wed, 4 Aug 2010 19:38:24 -0600
Date: Wed, 4 Aug 2010 18:43:58 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Message-ID: <20100805014358.GA14122@us.ibm.com>
References: <20100804235206.GA1388@us.ibm.com>
	<AANLkTin5Eyx=SgLNRDzzBe+LAW35FCz=vVxgwun0BGNk@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AANLkTin5Eyx=SgLNRDzzBe+LAW35FCz=vVxgwun0BGNk@mail.gmail.com>
Subject: Re: [LTP] pidns31: fix EACCESS error in mq_open()
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

Garrett Cooper [yanegomi@gmail.com] wrote:
| On Wed, Aug 4, 2010 at 4:52 PM, Sukadev Bhattiprolu
| <sukadev@linux.vnet.ibm.com> wrote:
| >
| > pidns31: mq_open() fails with EACCESS.
| >
| > pidns31 test case fails with EACCESS - due to the leading '/' in
| > mqname. See comments in the patch below for details.
| >
| > Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
| > ---
| > Index: testcases/kernel/containers/pidns/pidns31.c
| > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
| > RCS file: /cvsroot/ltp/ltp/testcases/kernel/containers/pidns/pidns31.c,v
| > retrieving revision 1.6
| > diff -u -p -r1.6 pidns31.c
| > --- testcases/kernel/containers/pidns/pidns31.c 14 Nov 2009 23:58:26 -0=
000 =A0 =A0 =A01.6
| > +++ testcases/kernel/containers/pidns/pidns31.c 4 Aug 2010 23:24:54 -00=
00
| > @@ -61,7 +61,14 @@
| > =A0char *TCID =3D "pidns31";
| > =A0int TST_TOTAL =3D 1;
| >
| > -char *mqname =3D "/mq1";
| > +
| > +/*
| > + * NOTE: The mq_open() interface in glibc requires mqname to start wit=
h a '/'
| > + * =A0 =A0 =A0and the glibc call skips the leading '/' when invoking t=
he system
| > + * =A0 =A0 =A0call. Since we bypass the glibc mq_open() (and use sysca=
ll()) we
| > + * =A0 =A0 =A0define mqname without the leading '/'.
| > + */
| > +char *mqname =3D "mq1";
| > =A0int result =3D TFAIL;
| >
| > =A0int errno;
| > @@ -264,6 +271,7 @@ int main(int argc, char *argv[])
| > =A0 =A0 =A0 =A0}
| >
| > =A0 =A0 =A0 =A0syscall(__NR_mq_unlink, mqname);
| > +
| > =A0 =A0 =A0 =A0mqd =3D syscall(__NR_mq_open, mqname, O_RDWR|O_CREAT|O_E=
XCL, 0777, NULL);
| > =A0 =A0 =A0 =A0if (mqd =3D=3D (mqd_t)-1) {
| > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TBROK, "parent: mq_open() faile=
d (%s)",
| =

| Did Linux become non-POSIX compliant :) (from
| <http://www.opengroup.org/onlinepubs/000095399/functions/mq_open.html>)?

Heh. Good question but I think the mq_open() from glibc is compliant
with this. I am just not sure if the call via syscall() needs to be
compliant.

But if that is a concern, we need a separate a test case for that -
pidns31 is using mq_* to test an unrelated feature. I think would
make sense to apply this fix, allowing LTP to test the feature even
on older distros.

Or pidns31 can go back to using the library interface and we could
skip the test on old distros.

Sukadev.

---------------------------------------------------------------------------=
---
The Palm PDK Hot Apps Program offers developers who use the
Plug-In Development Kit to bring their C/C++ apps to Palm for a share
of $1 Million in cash or HP Products. Visit us here for more details:
http://p.sf.net/sfu/dev2dev-palm
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
