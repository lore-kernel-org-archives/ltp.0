Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Ol1vI-0008LH-Se
	for ltp-list@lists.sourceforge.net; Mon, 16 Aug 2010 15:48:28 +0000
Received: from mail-bw0-f47.google.com ([209.85.214.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Ol1vH-0005dJ-M8
	for ltp-list@lists.sourceforge.net; Mon, 16 Aug 2010 15:48:28 +0000
Received: by bwz12 with SMTP id 12so2664231bwz.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 16 Aug 2010 08:48:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4C5666AC.60308@oracle.com>
References: <4C5666AC.60308@oracle.com>
Date: Mon, 16 Aug 2010 08:48:17 -0700
Message-ID: <AANLkTinzpQFWKH3chM+2DxPbTCcR-LMrok9kav-y=7e5@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] LTP-20100630:quota_remount_test01.sh test fails.
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
To: gurudas.pai@oracle.com
Cc: ltp-list@lists.sourceforge.net

On Sun, Aug 1, 2010 at 11:33 PM, Gurudas Pai <gurudas.pai@oracle.com> wrote:
> Hi,
>
> quota_remount_test01.sh test fails.
>
> <<<test_start>>>
> tag=3Dquota_remount_test01 stime=3D1280709472
> cmdline=3D"quota_remount_test01.sh"
> contacts=3D""
> analysis=3Dexit
> <<<test_output>>>
> incrementing stop
> quota_remount_test01 =A0 =A00 =A0TINFO =A0: =A0Successfully mounted the F=
ile System
> quota_remount_test01 =A0 =A00 =A0TINFO =A0: =A0Successfully Created Quota=
 Files
> quota_remount_test01 =A0 =A00 =A0TINFO =A0: =A0Successfully Turned on Quo=
ta
> quota_remount_test01 =A0 =A00 =A0TINFO =A0: =A0Successfully wrote to the =
filesystem
> quota: invalid option -- f
> quota: Usage: quota [-guqxvs] [-l | -Q] [-i] [-F quotaformat]
> =A0 =A0 =A0 =A0 quota [-qxvs] [-l | -Q] [-i] [-F quotaformat] -u username=
 ...
> =A0 =A0 =A0 =A0 quota [-qxvs] [-l | -Q] [-i] [-F quotaformat] -g groupnam=
e ...
> Bugs to: mvw@planets.elm.net, jack@suse.cz
> quota_remount_test01 =A0 =A00 =A0TINFO =A0: =A0Successfully Remounted Rea=
d-Only FS
> quota_remount_test01 =A0 =A00 =A0TINFO =A0: =A0Successfully Remounted Rea=
d-Write FS
> quota: invalid option -- f
> quota: Usage: quota [-guqxvs] [-l | -Q] [-i] [-F quotaformat]
> =A0 =A0 =A0 =A0 quota [-qxvs] [-l | -Q] [-i] [-F quotaformat] -u username=
 ...
> =A0 =A0 =A0 =A0 quota [-qxvs] [-l | -Q] [-i] [-F quotaformat] -g groupnam=
e ...
> Bugs to: mvw@planets.elm.net, jack@suse.cz
> Usage did not change after remount
> quota_remount_test01 =A0 =A01 =A0TFAIL =A0: =A0Quota on Remount Failed
> <<<execution_status>>>
> initiation_status=3D"ok"
> duration=3D1 termination_type=3Dexited termination_id=3D1 corefile=3Dno
> cutime=3D1 cstime=3D20
> <<<test_end>>>
> INFO: ltp-pan reported some tests FAIL
> LTP Version: LTP-20100630

What Linux distro and what version of whatever package that quota
comes with (might be coreutils*, but Linux keeps on playing musical
chairs with the applications and it varies from distro to distro)?

From what I see above, maybe your distro should just fix the command
to be BSD compatible like most other distros have done; -f corresponds
to:

     -f path
             Only display quota information for the file system that contai=
ns
             the specified path.  This can be any file within a mounted file
             system.

Otherwise the test is going to become unnecessarily complicated.

-Garrett

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
