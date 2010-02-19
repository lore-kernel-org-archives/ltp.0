Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NiWqO-0002XR-Pp
	for ltp-list@lists.sourceforge.net; Fri, 19 Feb 2010 17:40:48 +0000
Received: from mail-pw0-f47.google.com ([209.85.160.47])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NiWqN-0007zy-UC
	for ltp-list@lists.sourceforge.net; Fri, 19 Feb 2010 17:40:48 +0000
Received: by pwi5 with SMTP id 5so288462pwi.34
	for <ltp-list@lists.sourceforge.net>;
	Fri, 19 Feb 2010 09:40:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <9debc4411002181050u1a041f7cm72ed35337513834c@mail.gmail.com>
References: <9debc4411002181050u1a041f7cm72ed35337513834c@mail.gmail.com>
Date: Fri, 19 Feb 2010 09:40:39 -0800
Message-ID: <364299f41002190940m320d1d8ft45fdc626b5a2ca7f@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] fix for 'stress_floppy' not getting installed
	properly
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
To: Maxin John <maxin.john@gmail.com>
Cc: ltp-list@lists.sourceforge.net

On Thu, Feb 18, 2010 at 10:50 AM, Maxin John <maxin.john@gmail.com> wrote:
> Hi,
>
> I have tried to execute the 'io_floppy' test in =A0LTP Version: =A0LTP-20=
100131.1
>
> maxin@maxin-laptop:/opt/ltp$ ./runltp -f io_floppy
>
> This test failed since the 'stress_floppy' script was not installed prope=
rly.
> Please find the below given log:
> -----------------------------------------------------------
> ....
> Running tests.......
> <<<test_start>>>
> tag=3Dstress_floppy stime=3D1266516562
> cmdline=3D"export TCdat=3D$LTPROOT/testcases/kernel/io/stress_floppy; str=
ess_floppy"
> contacts=3D""
> analysis=3Dexit
> <<<test_output>>>
> sh: stress_floppy: not found
> incrementing stop
> <<<execution_status>>>
> initiation_status=3D"ok"
> duration=3D0 termination_type=3Dexited termination_id=3D127 corefile=3Dno
> cutime=3D0 cstime=3D0
> <<<test_end>>>
> INFO: ltp-pan reported some tests FAIL
> LTP Version: LTP-20100131.1
>
> =A0 =A0 =A0 #############################################################=
##"
>
> =A0 =A0 =A0 =A0 =A0 =A0Done executing testcases."
> =A0 =A0 =A0 =A0 =A0 =A0LTP Version: =A0LTP-20100131.1
> =A0 =A0 =A0 #############################################################=
##"
> -----------------------------------------------------------
>
> Attached patch(stress_floppy_Makefile.patch) fixes Makefile and the
> 'stress_floppy' script gets installed properly.
>
> -----------------------------------------------------------
> Running tests.......
> <<<test_start>>>
> tag=3Dstress_floppy stime=3D1266518427
> cmdline=3D"export TCdat=3D$LTPROOT/testcases/kernel/io/stress_floppy; str=
ess_floppy"
> contacts=3D""
> analysis=3Dexit
> <<<test_output>>>
> incrementing stop
> Testing format...
> /dev/fd0: No such file or directory
> Format failed!
> <<<execution_status>>>
> initiation_status=3D"ok"
> duration=3D0 termination_type=3Dexited termination_id=3D1 corefile=3Dno
> cutime=3D0 cstime=3D0
> <<<test_end>>>
> INFO: ltp-pan reported some tests FAIL
> LTP Version: LTP-20100131.1
> -----------------------------------------------------------
>
> Well, after applying this patch, the 'io_floppy' test fails successfully =
:)
> (Expected failure as I don't have a floppy drive)
>
> Signed-off-by: Maxin B. John <maxin.john@gmail.com>

Hmmm... not sure how this ended up in my spam folder... gg gmail.

I've committed your patch -- thanks for the help!

Cheers!
-Garrett

---------------------------------------------------------------------------=
---
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
