Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1OgoVR-00074h-BT
	for ltp-list@lists.sourceforge.net; Thu, 05 Aug 2010 00:40:21 +0000
Received: from mail-gx0-f175.google.com ([209.85.161.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OgoVQ-0001aJ-60
	for ltp-list@lists.sourceforge.net; Thu, 05 Aug 2010 00:40:21 +0000
Received: by gxk2 with SMTP id 2so2924460gxk.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 04 Aug 2010 17:40:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100804235206.GA1388@us.ibm.com>
References: <20100804235206.GA1388@us.ibm.com>
Date: Wed, 4 Aug 2010 17:40:14 -0700
Message-ID: <AANLkTin5Eyx=SgLNRDzzBe+LAW35FCz=vVxgwun0BGNk@mail.gmail.com>
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
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net

On Wed, Aug 4, 2010 at 4:52 PM, Sukadev Bhattiprolu
<sukadev@linux.vnet.ibm.com> wrote:
>
> pidns31: mq_open() fails with EACCESS.
>
> pidns31 test case fails with EACCESS - due to the leading '/' in
> mqname. See comments in the patch below for details.
>
> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> ---
> Index: testcases/kernel/containers/pidns/pidns31.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> RCS file: /cvsroot/ltp/ltp/testcases/kernel/containers/pidns/pidns31.c,v
> retrieving revision 1.6
> diff -u -p -r1.6 pidns31.c
> --- testcases/kernel/containers/pidns/pidns31.c 14 Nov 2009 23:58:26 -000=
0 =A0 =A0 =A01.6
> +++ testcases/kernel/containers/pidns/pidns31.c 4 Aug 2010 23:24:54 -0000
> @@ -61,7 +61,14 @@
> =A0char *TCID =3D "pidns31";
> =A0int TST_TOTAL =3D 1;
>
> -char *mqname =3D "/mq1";
> +
> +/*
> + * NOTE: The mq_open() interface in glibc requires mqname to start with =
a '/'
> + * =A0 =A0 =A0and the glibc call skips the leading '/' when invoking the=
 system
> + * =A0 =A0 =A0call. Since we bypass the glibc mq_open() (and use syscall=
()) we
> + * =A0 =A0 =A0define mqname without the leading '/'.
> + */
> +char *mqname =3D "mq1";
> =A0int result =3D TFAIL;
>
> =A0int errno;
> @@ -264,6 +271,7 @@ int main(int argc, char *argv[])
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0syscall(__NR_mq_unlink, mqname);
> +
> =A0 =A0 =A0 =A0mqd =3D syscall(__NR_mq_open, mqname, O_RDWR|O_CREAT|O_EXC=
L, 0777, NULL);
> =A0 =A0 =A0 =A0if (mqd =3D=3D (mqd_t)-1) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TBROK, "parent: mq_open() failed =
(%s)",

Did Linux become non-POSIX compliant :) (from
<http://www.opengroup.org/onlinepubs/000095399/functions/mq_open.html>)?

If name begins with the slash character, then processes calling
mq_open() with the same value of name shall refer to the same message
queue object, as long as that name has not been removed. If name does
not begin with the slash character, the effect is
implementation-defined. The interpretation of slash characters other
than the leading slash character in name is implementation-defined. If
the name argument is not the name of an existing message queue and
creation is not requested, mq_open() shall fail and return an error.

...

[EACCES]
    The message queue exists and the permissions specified by oflag
are denied, or the message queue does not exist and permission to
create the message queue is denied.

I think that one needs to do more digging to determine whether or not
the error is valid, because your description and the requirements
above don't make sense...

Thanks,
-Garrett

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
