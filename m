Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Ol8gL-0003u5-UO
	for ltp-list@lists.sourceforge.net; Mon, 16 Aug 2010 23:01:29 +0000
Received: from mail-bw0-f47.google.com ([209.85.214.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Ol8gJ-000322-9t
	for ltp-list@lists.sourceforge.net; Mon, 16 Aug 2010 23:01:29 +0000
Received: by bwz12 with SMTP id 12so3070924bwz.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 16 Aug 2010 16:01:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1281970341.5120.18.camel@subratamodak.linux.ibm.com>
References: <20100804235206.GA1388@us.ibm.com>
	<AANLkTin5Eyx=SgLNRDzzBe+LAW35FCz=vVxgwun0BGNk@mail.gmail.com>
	<20100805014358.GA14122@us.ibm.com>
	<1281970341.5120.18.camel@subratamodak.linux.ibm.com>
Date: Mon, 16 Aug 2010 16:01:21 -0700
Message-ID: <AANLkTim5a5QasWWpcOarGaOnLJzJpyVKSB22HuCm6qKs@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
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
To: subrata@linux.vnet.ibm.com
Cc: ltp-list@lists.sourceforge.net, Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>

On Mon, Aug 16, 2010 at 7:52 AM, Subrata Modak
<subrata@linux.vnet.ibm.com> wrote:
>
> On Wed, 2010-08-04 at 18:43 -0700, Sukadev Bhattiprolu wrote:
>> Garrett Cooper [yanegomi@gmail.com] wrote:
>> | On Wed, Aug 4, 2010 at 4:52 PM, Sukadev Bhattiprolu
>> | <sukadev@linux.vnet.ibm.com> wrote:
>> | >
>> | > pidns31: mq_open() fails with EACCESS.
>> | >
>> | > pidns31 test case fails with EACCESS - due to the leading '/' in
>> | > mqname. See comments in the patch below for details.
>> | >
>> | > Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
>> | > ---
>> | > Index: testcases/kernel/containers/pidns/pidns31.c
>> | > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> | > RCS file: /cvsroot/ltp/ltp/testcases/kernel/containers/pidns/pidns31=
.c,v
>> | > retrieving revision 1.6
>> | > diff -u -p -r1.6 pidns31.c
>> | > --- testcases/kernel/containers/pidns/pidns31.c 14 Nov 2009 23:58:26=
 -0000 =A0 =A0 =A01.6
>> | > +++ testcases/kernel/containers/pidns/pidns31.c 4 Aug 2010 23:24:54 =
-0000
>> | > @@ -61,7 +61,14 @@
>> | > =A0char *TCID =3D "pidns31";
>> | > =A0int TST_TOTAL =3D 1;
>> | >
>> | > -char *mqname =3D "/mq1";
>> | > +
>> | > +/*
>> | > + * NOTE: The mq_open() interface in glibc requires mqname to start =
with a '/'
>> | > + * =A0 =A0 =A0and the glibc call skips the leading '/' when invokin=
g the system
>> | > + * =A0 =A0 =A0call. Since we bypass the glibc mq_open() (and use sy=
scall()) we
>> | > + * =A0 =A0 =A0define mqname without the leading '/'.
>> | > + */
>> | > +char *mqname =3D "mq1";
>> | > =A0int result =3D TFAIL;
>> | >
>> | > =A0int errno;
>> | > @@ -264,6 +271,7 @@ int main(int argc, char *argv[])
>> | > =A0 =A0 =A0 =A0}
>> | >
>> | > =A0 =A0 =A0 =A0syscall(__NR_mq_unlink, mqname);
>> | > +
>> | > =A0 =A0 =A0 =A0mqd =3D syscall(__NR_mq_open, mqname, O_RDWR|O_CREAT|=
O_EXCL, 0777, NULL);
>> | > =A0 =A0 =A0 =A0if (mqd =3D=3D (mqd_t)-1) {
>> | > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TBROK, "parent: mq_open() fa=
iled (%s)",
>> |
>> | Did Linux become non-POSIX compliant :) (from
>> | <http://www.opengroup.org/onlinepubs/000095399/functions/mq_open.html>=
)?
>>
>> Heh. Good question but I think the mq_open() from glibc is compliant
>> with this. I am just not sure if the call via syscall() needs to be
>> compliant.
>>
>> But if that is a concern, we need a separate a test case for that -
>> pidns31 is using mq_* to test an unrelated feature. I think would
>> make sense to apply this fix, allowing LTP to test the feature even
>> on older distros.
>>
>> Or pidns31 can go back to using the library interface and we could
>> skip the test on old distros.
>
> I would prefer this.

Do I hear someone volunteering to add the required autoconf tests and
tests for this :)?

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
