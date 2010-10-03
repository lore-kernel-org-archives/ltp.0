Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1P2CgL-0002Px-PI
	for ltp-list@lists.sourceforge.net; Sun, 03 Oct 2010 00:44:01 +0000
Received: from mail-iw0-f175.google.com ([209.85.214.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1P2CgK-000770-MJ
	for ltp-list@lists.sourceforge.net; Sun, 03 Oct 2010 00:44:01 +0000
Received: by iwn2 with SMTP id 2so7044002iwn.34
	for <ltp-list@lists.sourceforge.net>;
	Sat, 02 Oct 2010 17:43:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1386780373.997641285829881764.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
References: <1320440485.401261285262435919.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
	<1386780373.997641285829881764.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
Date: Sat, 2 Oct 2010 17:43:53 -0700
Message-ID: <AANLkTi=zDi8xfWBL5EsP6T82WXp3Yi=0-k+G1HsvONEE@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] Re: fix incorrect parsing of df command in
	ftruncate04.sh
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
To: Caspar Zhang <czhang@redhat.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

On Wed, Sep 29, 2010 at 11:58 PM, Caspar Zhang <czhang@redhat.com> wrote:
>
> ----- "Caspar Zhang" <czhang@redhat.com> wrote:
>
>> Sorry for missing [PATCH] tag, now added.
>>
>> Thanks,
>> Caspar
>> ----- "Caspar Zhang" <czhang@redhat.com> wrote:
>>
>> > Hi all, an error in ftruncate04 test is found,
>> > The problem I see is due to incorrect parsing
>> > of `df` command output:
>> >
>> > <<<test_start>>>
>> > tag=3Dftruncate04 stime=3D1284729392
>> > cmdline=3D"ftruncate04.sh"
>> > contacts=3D""
>> > analysis=3Dexit
>> > <<<test_output>>>
>> > DEV: =A0 =A0 =A0 =A0 /dev/mapper/vg_rhel6beta-lv_root
>> > MOUNT_POINT: /dev/mapper/vg_rhel6beta-lv_root
>> > FLAG: =A0 =A0 =A0 =A0rw,mand
>> > ftruncate04 =A0 =A01 =A0TPASS =A0: =A0Test passed.
>> > mount: you must specify the filesystem type
>> > ftruncate04.sh : ERROR : mounting /dev/mapper/vg_rhel6beta-lv_root
>> > remount,rw,mand failed
>> > incrementing stop
>> > <<<execution_status>>>
>> > initiation_status=3D"ok"
>> > duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
>> > cutime=3D1 cstime=3D7
>> > <<<test_end>>>
>> >
>> > # mount | head -1
>> > /dev/mapper/vg_rhel6beta-lv_root on / type ext4 (rw,mand)
>> >
>> > # df .
>> > Filesystem =A0 =A0 =A0 =A0 =A0 1K-blocks =A0 =A0 =A0Used Available Use=
% Mounted on
>> > /dev/mapper/vg_rhel6beta-lv_root
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A02523808 =A0 2436384 =A0=
 =A0 =A0 =A0 0 100% /
>> >
>> > A patch is attached to fix this problem. After applied the patch,
>> > the failure gone:
>> >
>> > <<<test_start>>>
>> > tag=3Dftruncate04 stime=3D1284729277
>> > cmdline=3D"ftruncate04.sh"
>> > contacts=3D""
>> > analysis=3Dexit
>> > <<<test_output>>>
>> > DEV: =A0 =A0 =A0 =A0 /dev/mapper/vg_rhel6beta-lv_root
>> > MOUNT_POINT: /
>> > FLAG: =A0 =A0 =A0 =A0rw,mand
>> > ftruncate04 =A0 =A01 =A0TPASS =A0: =A0Test passed.
>> > incrementing stop
>> > <<<execution_status>>>
>> > initiation_status=3D"ok"
>> > duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
>> > cutime=3D1 cstime=3D9
>> > <<<test_end>>>
>> >
>> > # mount | head -1
>> > /dev/mapper/vg_rhel6beta-lv_root on / type ext4 (rw)
>> > # df -P .
>> > Filesystem =A0 =A0 =A0 =A0 1024-blocks =A0 =A0 =A0Used Available Capac=
ity Mounted
>> on
>> > /dev/mapper/vg_rhel6beta-lv_root =A0 2523808 =A0 2436380 =A0 =A0 =A0 =
=A0 0
>> > 100% /
>> >
>> > So the test without the patch leaves the system in inconsistent
>> state
>> > (mand option is kept for the filesystem) which is bad.
>> >
>> > Signed-off-by: Caspar Zhang <czhang@redhat.com>
>> >
>> > ---
>> >
>> ltp-full-20100331.old/testcases/kernel/syscalls/ftruncate/ftruncate04.sh
>> > 2010-09-17 15:06:44.292158981 +0200
>> > +++
>> > ltp-full-20100331/testcases/kernel/syscalls/ftruncate/ftruncate04.sh
>> > 2010-09-17 15:10:26.646160911 +0200
>> > @@ -18,7 +18,7 @@
>> > =A0 =A0 =A0export TST_TOTAL=3D1
>> > =A0fi
>> > =A0cd ${TMPDIR:=3D/tmp}
>> > -set -- $(df . | awk '/^\// { print $1, $NF }')
>> > +set -- $(df -P . | awk '/^\// { print $1, $NF }')
>> > =A0DEV=3D$1; MOUNT_POINT=3D$2
>> > =A0if [ "x$DEV" =3D x -o "x$MOUNT_POINT" =3D x ] ; then
>> > =A0 =A0 =A0tst_resm TCONF "backend mountpoint for $TMPDIR does not
>> > correspond to a real device:"
>> >
>> >
>> > Thanks,
>> > Caspar
>
> Hi, any comments on this?
>
> Thanks,
> Caspar

    Looks fine (portable on Fedora 13 and FreeBSD at least), and it's
standard as per the opengroup SUS page (
http://www.opengroup.org/onlinepubs/009695399/utilities/df.html ).
Committed.
Thanks!
-Garrett

---------------------------------------------------------------------------=
---
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
