Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NaW0b-0008ML-7K
	for ltp-list@lists.sourceforge.net; Thu, 28 Jan 2010 15:10:13 +0000
Received: from mail-pz0-f179.google.com ([209.85.222.179])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NaW0Z-00058J-Sk
	for ltp-list@lists.sourceforge.net; Thu, 28 Jan 2010 15:10:13 +0000
Received: by pzk9 with SMTP id 9so688386pzk.28
	for <ltp-list@lists.sourceforge.net>;
	Thu, 28 Jan 2010 07:10:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1264687347.6232.48.camel@moss-pluto.epoch.ncsc.mil>
References: <1262988051.20881.42.camel@moss-pluto.epoch.ncsc.mil>
	<20100112153827.GB7975@us.ibm.com>
	<364299f41001150948u4df35c36g3d4b07b16af49f90@mail.gmail.com>
	<364299f41001260031h2529b9b0j1bbbacd9d3d85eae@mail.gmail.com>
	<1264516245.19890.22.camel@moss-pluto.epoch.ncsc.mil>
	<23804BFE-0FC7-45F8-939D-3729E39DB431@gmail.com>
	<1264619548.17372.27.camel@moss-pluto.epoch.ncsc.mil>
	<364299f41001271437k3f9bde57t64845d8d0054ba22@mail.gmail.com>
	<364299f41001272156p5f12bc94p4eba45d9df61fbc0@mail.gmail.com>
	<1264687347.6232.48.camel@moss-pluto.epoch.ncsc.mil>
Date: Thu, 28 Jan 2010 07:10:02 -0800
Message-ID: <364299f41001280710p36c82e32hae3faf6e6e242c4@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] regression: selinux testsuite broken since October
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
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>, ltp-list@lists.sourceforge.net

On Thu, Jan 28, 2010 at 6:02 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Wed, 2010-01-27 at 21:56 -0800, Garrett Cooper wrote:
>> On Wed, Jan 27, 2010 at 2:37 PM, Garrett Cooper <yanegomi@gmail.com> wro=
te:
>> > Ok. Send me a patch that does a readlink -f of the LTPPATH and set
>> > your PATH to include $LTPROOT/testcases/bin, and you'll be good to go
>>
>> =A0 =A0 Nevermind. I just committed the change... please retest and
>> hopefully all goes well for you this time around.
>
> Looks good. =A0Patch below fixes two bugs in the selinux tests, noticed by
> examining the selinux.outfile carefully for errors (No such file or
> directory, Segmentation fault).
>
> Index: testcases/kernel/security/selinux-testsuite/tests/file/selinux_fil=
e.sh
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/selinux-testsuite/te=
sts/file/selinux_file.sh,v
> retrieving revision 1.10
> diff -u -r1.10 selinux_file.sh
> --- testcases/kernel/security/selinux-testsuite/tests/file/selinux_file.s=
h =A0 =A0 =A026 Jan 2010 07:05:02 -0000 =A0 =A0 =A01.10
> +++ testcases/kernel/security/selinux-testsuite/tests/file/selinux_file.s=
h =A0 =A0 =A028 Jan 2010 13:50:31 -0000
> @@ -47,7 +47,8 @@
> =A0 =A0 =A0 =A0#
> =A0 =A0 =A0 =A0# Change the context of the test executable
> =A0 =A0 =A0 =A0#
> - =A0 =A0 =A0 chcon -t fileop_exec_t selinux_wait_io 2>&1 > /dev/null
> + =A0 =A0 =A0 LTPBIN=3D${LTPBIN:-$LTPROOT/testcases/bin}
> + =A0 =A0 =A0 chcon -t fileop_exec_t $LTPBIN/selinux_wait_io 2>&1 > /dev/=
null
>
> =A0 =A0 =A0 =A0#
> =A0 =A0 =A0 =A0# Get the SID of the good file.
> Index: testcases/kernel/security/selinux-testsuite/tests/shm/selinux_shma=
t.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/selinux-testsuite/te=
sts/shm/selinux_shmat.c,v
> retrieving revision 1.4
> diff -u -r1.4 selinux_shmat.c
> --- testcases/kernel/security/selinux-testsuite/tests/shm/selinux_shmat.c=
 =A0 =A0 =A0 13 Jan 2010 08:16:57 -0000 =A0 =A0 =A01.4
> +++ testcases/kernel/security/selinux-testsuite/tests/shm/selinux_shmat.c=
 =A0 =A0 =A0 28 Jan 2010 13:50:31 -0000
> @@ -40,7 +40,7 @@
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 1;
>
> =A0 =A0 =A0 =A0buf =3D shmat(id, 0, 0);
> - =A0 =A0 =A0 error =3D (*buf =3D=3D -1) ? -1 : 0;
> + =A0 =A0 =A0 error =3D (buf =3D=3D (void*)-1) ? -1 : 0;
> =A0 =A0 =A0 =A0printf("shmat: buf=3D%p, returned %d\n", buf, error);
> =A0 =A0 =A0 =A0return error;
> =A0}

Done -- thanks!
-Garrett

---------------------------------------------------------------------------=
---
The Planet: dedicated and managed hosting, cloud storage, colocation
Stay online with enterprise data centers and the best network in the busine=
ss
Choose flexible plans and management services without long-term contracts
Personal 24x7 support from experience hosting pros just a phone call away.
http://p.sf.net/sfu/theplanet-com
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
