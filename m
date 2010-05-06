Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1OA56H-0003GG-V6
	for ltp-list@lists.sourceforge.net; Thu, 06 May 2010 17:43:05 +0000
Received: from mail-iw0-f181.google.com ([209.85.223.181])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OA56F-0002Vq-TT
	for ltp-list@lists.sourceforge.net; Thu, 06 May 2010 17:43:05 +0000
MIME-Version: 1.0
In-Reply-To: <1273137244.26977.134.camel@lishuang-desktop>
References: <1273137244.26977.134.camel@lishuang-desktop>
Date: Thu, 6 May 2010 10:40:00 -0700
Message-ID: <n2u364299f41005061040yd280662cy81f31fc580af5a86@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] ltp inotify03 testcase failed in version of 20100228
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
To: Henry xu <feng.xu@windriver.com>
Cc: ltp-list <ltp-list@lists.sf.net>

On Thu, May 6, 2010 at 2:14 AM, Henry xu <feng.xu@windriver.com> wrote:
> Hi,all
>
> I test inotify03 in =A0ppc platform and product two fails as
> below.
> <<<test_start>>>
> tag=3Dinotify03 stime=3D1272626381
> cmdline=3D"inotify03 -D /dev/loop0 -T ext3"
> contacts=3D""
> analysis=3Dexit
> <<<test_output>>>
> inotify03 =A0 =A00 =A0TINFO =A0: =A0mount /dev/loop0 to mnt_18067 fstype=
=3Dext3
> inotify03 =A0 =A00 =A0TINFO =A0: =A0umount /dev/loop0
> inotify03 =A0 =A01 =A0TFAIL =A0: =A0get event: wd=3D1 mask=3D8000 (expect=
ed 2000)
> cookie=3D0 len=3D0
> inotify03 =A0 =A02 =A0TFAIL =A0: =A0don't get event: mask=3D8000
> inotify03 =A0 =A03 =A0TPASS =A0: =A0inotify_rm_watch (5, 1) return -1 err=
no=3D22 :
> Invalid argument
>
>
> when I type "./runltp -s inotify" for inotify test, the inotify03 test
> is =A0not been executed.The information is as below.
>
> I look into the code ,however I could not get why mask is equal to
> 8000.Could someone give your comments on this case?
>
> thanks in advance!
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> You can specify it with option -b
> COMMAND: =A0 =A0/opt/ltp-full/bin/ltp-pan =A0-e -S =A0 -a 26692 =A0 =A0 -=
n 26692 =A0-p
> -f /tmp/ltp-rUQUk26698/alltests
> -l /opt/ltp-full/results/LTP_RUN_ON-1970_Jan_02-02h_51m_52s.log
> -C /opt/ltp-full/output/LTP_RUN_ON-1970_Jan_02-02h_51m_52s.failed
> INFO: Restricted to inotify
> LOG File: /opt/ltp-full/results/LTP_RUN_ON-1970_Jan_02-02h_51m_52s.log
> FAILED COMMAND
> File: /opt/ltp-full/output/LTP_RUN_ON-1970_Jan_02-02h_51m_52s.failed
> Running tests.......
> <<<test_start>>>
> tag=3Dinotify_init1_01 stime=3D96713
> cmdline=3D"inotify_init1_01"
> contacts=3D""
> analysis=3Dexit
> <<<test_output>>>
> inotify_init1_01 =A0 =A01 =A0TPASS =A0: =A0inotify_init1(O_CLOEXEC) PASSED
> <<<execution_status>>>
> initiation_status=3D"ok"
> duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
> cutime=3D0 cstime=3D0
> <<<test_end>>>
> <<<test_start>>>
> tag=3Dinotify_init1_02 stime=3D96714
> cmdline=3D"inotify_init1_02"
> contacts=3D""
> analysis=3Dexit
> <<<test_output>>>
> inotify_init1_02 =A0 =A01 =A0TPASS =A0: =A0inotify_init1(IN_NONBLOCK) PAS=
SED
> <<<execution_status>>>
> initiation_status=3D"ok"
> duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
> cutime=3D0 cstime=3D0
> <<<test_end>>>
> <<<test_start>>>
> tag=3Dinotify01 stime=3D96714
> cmdline=3D"inotify01"
> contacts=3D""
> analysis=3Dexit
> <<<test_output>>>
> inotify01 =A0 =A01 =A0TPASS =A0: =A0get event: wd=3D1 mask=3D4 cookie=3D0=
 len=3D0
> inotify01 =A0 =A02 =A0TPASS =A0: =A0get event: wd=3D1 mask=3D20 cookie=3D=
0 len=3D0
> inotify01 =A0 =A03 =A0TPASS =A0: =A0get event: wd=3D1 mask=3D1 cookie=3D0=
 len=3D0
> inotify01 =A0 =A04 =A0TPASS =A0: =A0get event: wd=3D1 mask=3D10 cookie=3D=
0 len=3D0
> inotify01 =A0 =A05 =A0TPASS =A0: =A0get event: wd=3D1 mask=3D20 cookie=3D=
0 len=3D0
> inotify01 =A0 =A06 =A0TPASS =A0: =A0get event: wd=3D1 mask=3D2 cookie=3D0=
 len=3D0
> inotify01 =A0 =A07 =A0TPASS =A0: =A0get event: wd=3D1 mask=3D8 cookie=3D0=
 len=3D0
> <<<execution_status>>>
> initiation_status=3D"ok"
> duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
> cutime=3D0 cstime=3D0
> <<<test_end>>>
> <<<test_start>>>
> tag=3Dinotify02 stime=3D96714
> cmdline=3D"inotify02"
> contacts=3D""
> analysis=3Dexit
> <<<test_output>>>
> inotify02 =A0 =A01 =A0TPASS =A0: =A0get event: wd=3D1 mask=3D40000004 coo=
kie=3D0 len=3D0
> name=3D""
> inotify02 =A0 =A02 =A0TPASS =A0: =A0get event: wd=3D1 mask=3D100 cookie=
=3D0 len=3D16
> name=3D"test_file1"
> inotify02 =A0 =A03 =A0TPASS =A0: =A0get event: wd=3D1 mask=3D20 cookie=3D=
0 len=3D16
> name=3D"test_file1"
> inotify02 =A0 =A04 =A0TPASS =A0: =A0get event: wd=3D1 mask=3D8 cookie=3D0=
 len=3D16
> name=3D"test_file1"
> inotify02 =A0 =A05 =A0TPASS =A0: =A0get event: wd=3D1 mask=3D40 cookie=3D=
4553 len=3D16
> name=3D"test_file1"
> inotify02 =A0 =A06 =A0TPASS =A0: =A0get event: wd=3D1 mask=3D80 cookie=3D=
4553 len=3D16
> name=3D"test_file2"
> inotify02 =A0 =A07 =A0TPASS =A0: =A0get event: wd=3D1 mask=3D800 cookie=
=3D0 len=3D0
> name=3D""
> inotify02 =A0 =A08 =A0TPASS =A0: =A0get event: wd=3D1 mask=3D200 cookie=
=3D0 len=3D16
> name=3D"test_file2"
> inotify02 =A0 =A09 =A0TPASS =A0: =A0get event: wd=3D1 mask=3D800 cookie=
=3D0 len=3D0
> name=3D""
> incrementing stop
> <<<execution_status>>>
> initiation_status=3D"ok"
> duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
> cutime=3D0 cstime=3D0
> <<<test_end>>>
> INFO: ltp-pan reported all tests PASS
> LTP Version: LTP-20100228

    I saw this failure as well on powerpc with 2.6.24 when I was
running LTP on a regular basis. I never looked into why it was an
issue either.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
