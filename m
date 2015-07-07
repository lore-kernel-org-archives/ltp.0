Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <mujeeb.adil@gmail.com>) id 1ZCLKY-0005La-Ij
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2015 05:22:06 +0000
Received: from mail-oi0-f46.google.com ([209.85.218.46])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZCLKW-0004K6-SU
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2015 05:22:06 +0000
Received: by oiaf66 with SMTP id f66so102030398oia.3
	for <ltp-list@lists.sourceforge.net>;
	Mon, 06 Jul 2015 22:21:59 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 7 Jul 2015 10:51:59 +0530
Message-ID: <CANBXnMk9SoMKBGcuMqxTrgYz5EUkgX6P-gKG7q0NGW2ni_nKHg@mail.gmail.com>
From: Adil Mujeeb <mujeeb.adil@gmail.com>
Subject: [LTP] LTP newbie
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5719036841989503028=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============5719036841989503028==
Content-Type: multipart/alternative; boundary=001a113d67069a8627051a423381

--001a113d67069a8627051a423381
Content-Type: text/plain; charset=UTF-8

Hi,


 I am new to LTP and just setup on my machine.

I am interested in running syscall test. How to run only syscall tests?


 I tried with following:


 $ ./runltp -f $PWD/runtest/syscalls -p -q -l result.log -o result.out temp/

INFO: creating /home/adil/work/testing/opt/ltp/results directory

Checking for required user/group ids


 'nobody' user id and group found.

'bin' user id and group found.

'daemon' user id and group found.

Users group found.

Sys group found.

Required users/groups exist.

losetup: /dev/loop0: failed to set up loop device: No such file or directory

losetup failed to create block device

no block device was specified on commandline.

Block device could not be created using loopback device

Tests which require block device are disabled.

You can specify it with option -b

no big block device was specified on commandline.

Tests which require a big block device are disabled.

You can specify it with option -z

INFO: Test start time: Tue Jul  7 13:42:01 JST 2015

COMMAND:    /home/adil/work/testing/opt/ltp/bin/ltp-pan  -q  -e -S   -a
5349     -n 5349  -p  -f


 /tmp/ltp-Ic7CiNlVjB/alltests -l
/home/adil/work/testing/opt/ltp/results/result.log -o


 /home/adil/work/testing/opt/ltp/output/result.out -C


 /home/adil/work/testing/opt/ltp/output/LTP_RUN_ON-result.out.failed -T


 /home/adil/work/testing/opt/ltp/output/LTP_RUN_ON-result.out.tconf

LOG File: /home/adil/work/testing/opt/ltp/results/result.log

OUTPUT File: /home/adil/work/testing/opt/ltp/output/result.out

FAILED COMMAND File:
/home/adil/work/testing/opt/ltp/output/LTP_RUN_ON-result.out.failed

TCONF COMMAND File:
/home/adil/work/testing/opt/ltp/output/LTP_RUN_ON-result.out.tconf

-----------------


 I could not see any progress message. So I cancel it by pressing Ctrl+C


 It gives following message:


 INFO: ltp-pan reported some tests FAIL

LTP Version: 20150420

INFO: Test end time: Tue Jul  7 13:42:44 JST 2015


        ###############################################################


             Done executing testcases.

            LTP Version:  20150420

       ###############################################################


 losetup: /dev/loop0: detach failed: No such file or directory


 Following is my understanding:

1. my temp directory path not considered which i specified on the command
line

2. I ask for syscalls test execution, but looks like it is executing
alltests

3. No progress message displayed


 I tried going through documentation but there is no simple example how to
test a subset of test. Also is there any document which gives the test
category structure and in each category how many test cases? Can i know how
many tests cases covered in syscalls?

Thanks,

Adil

--001a113d67069a8627051a423381
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div style=3D"font-size:12pt;color:#000000;background-colo=
r:#ffffff;font-family:Calibri,Arial,Helvetica,sans-serif"><p><br></p>
<p>Hi,</p>
<p><br>
</p>
<p>I am new to LTP and just setup on my machine.=C2=A0</p>
<p>I am interested in running syscall test. How to run only syscall tests?<=
/p>
<p><br>
</p>
<p>I tried with following:</p>
<p><br>
</p>
<p>$ ./runltp -f $PWD/runtest/syscalls -p -q -l result.log -o result.out te=
mp/</p>
<p>INFO: creating /home/adil/work/testing/opt/ltp/results directory</p>
<p>Checking for required user/group ids</p>
<p><br>
</p>
<p>&#39;nobody&#39; user id and group found.</p>
<p>&#39;bin&#39; user id and group found.</p>
<p>&#39;daemon&#39; user id and group found.</p>
<p>Users group found.</p>
<p>Sys group found.</p>
<p>Required users/groups exist.</p>
<p>losetup: /dev/loop0: failed to set up loop device: No such file or direc=
tory</p>
<p>losetup failed to create block device</p>
<p>no block device was specified on commandline.</p>
<p>Block device could not be created using loopback device</p>
<p>Tests which require block device are disabled.</p>
<p>You can specify it with option -b</p>
<p>no big block device was specified on commandline.</p>
<p>Tests which require a big block device are disabled.</p>
<p>You can specify it with option -z</p>
<p>INFO: Test start time: Tue Jul =C2=A07 13:42:01 JST 2015</p>
<p>COMMAND: =C2=A0 =C2=A0/home/adil/work/testing/opt/ltp/bin/ltp-pan =C2=A0=
-q =C2=A0-e -S =C2=A0 -a 5349 =C2=A0 =C2=A0 -n 5349 =C2=A0-p =C2=A0-f=C2=A0=
</p>
<p><br>
</p>
<p>/tmp/ltp-Ic7CiNlVjB/alltests -l /home/adil/work/testing/opt/ltp/results/=
result.log -o=C2=A0</p>
<p><br>
</p>
<p>/home/adil/work/testing/opt/ltp/output/result.out -C=C2=A0</p>
<p><br>
</p>
<p>/home/adil/work/testing/opt/ltp/output/LTP_RUN_ON-result.out.failed -T=
=C2=A0</p>
<p><br>
</p>
<p>/home/adil/work/testing/opt/ltp/output/LTP_RUN_ON-result.out.tconf</p>
<p>LOG File: /home/adil/work/testing/opt/ltp/results/result.log</p>
<p>OUTPUT File: /home/adil/work/testing/opt/ltp/output/result.out</p>
<p>FAILED COMMAND File: /home/adil/work/testing/opt/ltp/output/LTP_RUN_ON-r=
esult.out.failed</p>
<p>TCONF COMMAND File: /home/adil/work/testing/opt/ltp/output/LTP_RUN_ON-re=
sult.out.tconf</p>
<p>-----------------</p>
<p><br>
</p>
<p>I could not see any progress message. So I cancel it by pressing Ctrl+C<=
/p>
<p><br>
</p>
<p>It gives following message:</p>
<p><br>
</p>
<p>INFO: ltp-pan reported some tests FAIL</p>
<p>LTP Version: 20150420</p>
<p>INFO: Test end time: Tue Jul =C2=A07 13:42:44 JST 2015</p>
<p><br>
</p>
<p>=C2=A0 =C2=A0 =C2=A0 =C2=A0#############################################=
##################</p>
<p><br>
</p>
<p>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Done executing testcases.</p>
<p>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 LTP Version: =C2=A020150420</p=
>
<p>=C2=A0 =C2=A0 =C2=A0 =C2=A0#############################################=
##################</p>
<p><br>
</p>
<p>losetup: /dev/loop0: detach failed: No such file or directory</p>
<p><br>
</p>
<p>Following is my understanding:</p>
<p>1. my temp directory path not considered which i specified on the comman=
d line</p>
<p>2. I ask for syscalls test execution, but looks like it is executing all=
tests</p>
<p>3. No progress message displayed</p>
<p><br>
</p>
<p>I tried going through documentation but there is no simple example how t=
o test a subset of test. Also is there any document which gives the test ca=
tegory structure and in each category how many test cases? Can i know how m=
any tests cases covered in syscalls?</p><p>Thanks,</p><p>Adil</p></div></di=
v>

--001a113d67069a8627051a423381--


--===============5719036841989503028==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
--===============5719036841989503028==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5719036841989503028==--

