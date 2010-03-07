Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NoO8Z-0002hD-CX
	for ltp-list@lists.sourceforge.net; Sun, 07 Mar 2010 21:35:47 +0000
Received: from mail-iw0-f202.google.com ([209.85.223.202])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NoO8Y-0006gR-MS
	for ltp-list@lists.sourceforge.net; Sun, 07 Mar 2010 21:35:47 +0000
Received: by iwn40 with SMTP id 40so345650iwn.1
	for <ltp-list@lists.sourceforge.net>;
	Sun, 07 Mar 2010 13:35:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <9debc4411003070900o5362e9ddq5ec4ea06d297d2fc@mail.gmail.com>
References: <9debc4411003070900o5362e9ddq5ec4ea06d297d2fc@mail.gmail.com>
Date: Sun, 7 Mar 2010 13:35:41 -0800
Message-ID: <364299f41003071335v1c610170h4d5511080273dc32@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] runtest/io file modification to run aio02 test
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

On Sun, Mar 7, 2010 at 9:00 AM, Maxin John <maxin.john@gmail.com> wrote:
> Hi All,
>
> I have observed that, while executing the io tests in LTP, the 'aio02'
> test failed to get executed:
>
> -------------------------------------------------------------------------=
-------------------------
> $./runtests -f =A0io
>
> Running tests.......
> <<<test_start>>>
> tag=3Daio01 stime=3D1267980185
> cmdline=3D"aio01"
> contacts=3D""
> analysis=3Dexit
> <<<test_output>>>
> aio01 =A0 =A0 =A0 1 =A0TPASS =A0: =A0Test 1: 10 writes in =A0 0.000102 sec
> aio01 =A0 =A0 =A0 2 =A0TPASS =A0: =A0Test 2: 10 reads in =A0 0.000056 sec
> aio01 =A0 =A0 =A0 3 =A0TPASS =A0: =A0Test 3: 10 prep,writes in =A0 0.0000=
70 sec
> aio01 =A0 =A0 =A0 4 =A0TPASS =A0: =A0Test 4: 10 prep,reads in =A0 0.00005=
1 sec
> aio01 =A0 =A0 =A0 5 =A0TPASS =A0: =A0Test 5: 10 reads and writes in =A0 0=
.000108 sec
> aio01 =A0 =A0 =A0 6 =A0TPASS =A0: =A0Test 6: 10 read,write,verify in 0.00=
0108 sec
> <<<execution_status>>>
> initiation_status=3D"ok"
> duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
> cutime=3D0 cstime=3D0
> <<<test_end>>>
> <<<test_start>>>
> tag=3Daio02 stime=3D1267980185
> cmdline=3D"runfstests.sh aio_tio"
> contacts=3D""
> analysis=3Dexit
> <<<test_output>>>
> Starting the Tests
> incrementing stop
> Test run starting at =A0Sun Mar 7 22:13:05 IST 2010
> Missing the test program. You must pass a test path/name for testing
> usage: runfstests.sh [ -a test name ]
>
> example: runfstests.sh -a cases/aio_tio
>
> <<<execution_status>>>
> initiation_status=3D"ok"
> duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
> cutime=3D0 cstime=3D0
> <<<test_end>>>
> INFO: ltp-pan reported all tests PASS
> LTP Version: LTP-20100228
>
> -------------------------------------------------------------------------=
------------------------------
>
> The "aio02_io_runtest.patch" makes the necessary changes in =A0"io" file
> in "runtest" directory.
>
> Signed-off-by: Maxin B. John <maxin.john@gmail.com>
>
> Warm Regards,
> Maxin B. John
>

Good eye. Here's the patch I'm going to apply, because it doesn't
require expr(1) and is POSIX compliant:

diff --git a/testcases/kernel/io/aio/aio02/runfstests.sh b/testcases/kernel=
/io/a
index eeed389..4e3190c 100755
--- a/testcases/kernel/io/aio/aio02/runfstests.sh
+++ b/testcases/kernel/io/aio/aio02/runfstests.sh
@@ -45,10 +45,10 @@ fi
    res=3D$?
    if [ $res -eq 0 ] ;
    then str=3D"";
-   passes=3D$[passes +1];
+       : $(( passes +=3D 1 ))
    else
    str=3D" -- FAILED";
-   fails=3D$[fails +1];
+       : $(( fails +=3D 1 ))
    fi
 #done

Thanks!
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
