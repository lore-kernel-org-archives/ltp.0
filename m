Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sujith.h@gmail.com>) id 1SfTQf-0002Yo-RS
	for ltp-list@lists.sourceforge.net; Fri, 15 Jun 2012 10:06:57 +0000
Received: from mail-gh0-f175.google.com ([209.85.160.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1SfTQZ-0006Vj-UL
	for ltp-list@lists.sourceforge.net; Fri, 15 Jun 2012 10:06:57 +0000
Received: by ghbz2 with SMTP id z2so2175323ghb.34
	for <ltp-list@lists.sourceforge.net>;
	Fri, 15 Jun 2012 03:06:46 -0700 (PDT)
MIME-Version: 1.0
From: sujith h <sujith.h@gmail.com>
Date: Fri, 15 Jun 2012 15:36:26 +0530
Message-ID: <CADyYWLnDv=Zf5LdUkYqsDCKAGG3r9=DhTPcsVf0rnNBHBtx1XQ@mail.gmail.com>
Content-Type: multipart/mixed; boundary=14dae9340ebb5099fe04c27ff971
Subject: [LTP] Found a bug in the file_test.sh
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--14dae9340ebb5099fe04c27ff971
Content-Type: multipart/alternative; boundary=14dae9340ebb5099f304c27ff96f

--14dae9340ebb5099f304c27ff96f
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

I was testing the file command test case and noticed a small issue in the
file_test.sh script.
The below mentioned is the output of the script executed:

root@freescale-qsb:/opt/ltp# ./runltp -p -l file.log -f
/opt/ltp/runtest/mycustomtest
INFO: creating /opt/ltp/results directory
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

MontaVista Automotive Technology Platform 1.1, (.dev-snapshot-20120604)
Linux freescale-qsb 2.6.38.8.mvatp-fsl-imx53 #1 PREEMPT Wed Jun 6 00:55:46
PDT 2012 armv7l GNU/Linux

Gnu C                  arm-montavista-linux-gnueabi-gcc (MontaVista Linux
Sourcery G++ 4.4-312) 4.4.1
Gnu make               3.81
util-linux             ng 2.17)
mount                  ng 2.17 (with libblkid support)
modutils               3.4
/opt/ltp/ver_linux: line 52: ldd: not found
awk: cmd. line:1: (FILENAME=3D- FNR=3D1) fatal: attempt to access field -1
/opt/ltp/ver_linux: line 55: ldd: not found
Procps                 3.2.8
iproute2              iproute2-ss100224
Kbd                    70:
Sh-utils               8.5
Modules Loaded         ipv6 evbug exportfs nfsd

free reports:
             total       used       free     shared    buffers     cached
Mem:        870808      47296     823512          0         44      23200
-/+ buffers/cache:      24052     846756
Swap:            0          0          0

/proc/cpuinfo
Processor       : ARMv7 Processor rev 5 (v7l)
BogoMIPS        : 999.42
Features        : swp half thumb fastmult vfp edsp neon vfpv3
CPU implementer : 0x41
CPU architecture: 7
CPU variant     : 0x2
CPU part        : 0xc08
CPU revision    : 5

Hardware        : Freescale MX53 LOCO Board
Revision        : 53021
Serial          : 0000000000000000
remove test cases which require the block device.
You can specify it with option -b
COMMAND:    /opt/ltp/bin/ltp-pan  -e -S   -a 3153     -n 3153  -p  -f
/tmp/ltp-wHY6LgV3Pc/alltests -l /opt/ltp/results/file.log  -C
/opt/ltp/output/LTP_RUN_ON-file.log.failed
LOG File: /opt/ltp/results/file.log
FAILED COMMAND File: /opt/ltp/output/LTP_RUN_ON-file.log.failed
Running tests.......
<<<test_start>>>
tag=3Dfile stime=3D1204614
cmdline=3D"export TCdat=3D$LTPROOT/testcases/bin; file_test.sh"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
incrementing stop
file01      0  TINFO  :  TEST #1: file command recogizes ASCII text files
file01      1  TPASS  :  file: Recognised ASCII file correctly
file02      0  TINFO  :  TEST #2: file command recognizes bash shell script=
s
file02      2  TPASS  :  file: Recognised bash shell script correctly
file03      0  TINFO  :  TEST #3: file command recognizes korn shell script=
s
file03      3  TPASS  :  file: recognised korn shell script
file04      0  TINFO  :  TEST #4: file command recognizes C shell scripts
file04      4  TPASS  :  file: Recognised C shell script correctly
file05      0  TINFO  :  TEST #5: file command recognizes C programs text
file05      5  TPASS  :  file: Recognised C program text correctly
file06      0  TINFO  :  TEST #6: file command recognizes ELF executables
file06      6  TPASS  :  file: Recognized ELF binary executable
file07      0  TINFO  :  TEST #7: file command recognizes tar files.
file07      7  TPASS  :  file: Recognised tar files
file08      0  TINFO  :  TEST #8: file command recognizes tar zip files
file08      8  TBROK  :  expected string: gzip compressed data, deflated,
original filename, `files.tar'
file08      9  TBROK  :  Remaining cases broken
file08      8  TFAIL  :  file: Failed to Recognize tar zip. Reason:
/tmp/files.tar.gz: cannot open `/tmp/files.tar.gz' (No such file or
directory)
file09      0  TINFO  :  TEST #9: file command recognizes RPM files
file09      9  TCONF  :  rpm not installed
file10      0  TINFO  :  TEST #10: file command recognizes vmlinu file
file10     10  TPASS  :  file: Recognised vmlinu file correctly
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D6 termination_type=3Dexited termination_id=3D1 corefile=3Dno
cutime=3D31 cstime=3D25
<<<test_end>>>
INFO: ltp-pan reported some tests FAIL
LTP Version: 20120401

       ###############################################################

            Done executing testcases.
            LTP Version:  20120401
       ###############################################################


Here we can see that the script couldn't find the files.tar.gz file and
exited. The problem I noticed in the script was, when the script executes
the gzip command on the files.tar, the files.tar.gz file is created in the
$PWD and hence it has to be moved to the $LTPTMP directory. After doing
this change the output of the script was mentioned below:

root@freescale-qsb:/opt# /opt/ltp/runltp -p -l file.log -f
/opt/ltp/runtest/mycustomtest
INFO: creating /opt/ltp/results directory
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

MontaVista Automotive Technology Platform 1.1, (.dev-snapshot-20120604)
Linux freescale-qsb 2.6.38.8.mvatp-fsl-imx53 #1 PREEMPT Wed Jun 6 00:55:46
PDT 2012 armv7l GNU/Linux

Gnu C                  arm-montavista-linux-gnueabi-gcc (MontaVista Linux
Sourcery G++ 4.4-312) 4.4.1
Gnu make               3.81
util-linux             ng 2.17)
mount                  ng 2.17 (with libblkid support)
modutils               3.4
/opt/ltp/ver_linux: line 52: ldd: not found
awk: cmd. line:1: (FILENAME=3D- FNR=3D1) fatal: attempt to access field -1
/opt/ltp/ver_linux: line 55: ldd: not found
Procps                 3.2.8
iproute2              iproute2-ss100224
Kbd                    70:
Sh-utils               8.5
Modules Loaded         ipv6 evbug exportfs nfsd

free reports:
             total       used       free     shared    buffers     cached
Mem:        870808      64280     806528          0         44      38204
-/+ buffers/cache:      26032     844776
Swap:            0          0          0

/proc/cpuinfo
Processor       : ARMv7 Processor rev 5 (v7l)
BogoMIPS        : 999.42
Features        : swp half thumb fastmult vfp edsp neon vfpv3
CPU implementer : 0x41
CPU architecture: 7
CPU variant     : 0x2
CPU part        : 0xc08
CPU revision    : 5

Hardware        : Freescale MX53 LOCO Board
Revision        : 53021
Serial          : 0000000000000000
remove test cases which require the block device.
You can specify it with option -b
COMMAND:    /opt/ltp/bin/ltp-pan  -e -S   -a 8100     -n 8100  -p  -f
/tmp/ltp-hkmNZkJsaD/alltests -l /opt/ltp/results/file.log  -C
/opt/ltp/output/LTP_RUN_ON-file.log.failed
LOG File: /opt/ltp/results/file.log
FAILED COMMAND File: /opt/ltp/output/LTP_RUN_ON-file.log.failed
Running tests.......
<<<test_start>>>
tag=3Dfile stime=3D1210390
cmdline=3D"export TCdat=3D$LTPROOT/testcases/bin; file_test.sh"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
incrementing stop
file01      0  TINFO  :  TEST #1: file command recogizes ASCII text files
file01      1  TPASS  :  file: Recognised ASCII file correctly
file02      0  TINFO  :  TEST #2: file command recognizes bash shell script=
s
file02      2  TPASS  :  file: Recognised bash shell script correctly
file03      0  TINFO  :  TEST #3: file command recognizes korn shell script=
s
file03      3  TPASS  :  file: recognised korn shell script
file04      0  TINFO  :  TEST #4: file command recognizes C shell scripts
file04      4  TPASS  :  file: Recognised C shell script correctly
file05      0  TINFO  :  TEST #5: file command recognizes C programs text
file05      5  TPASS  :  file: Recognised C program text correctly
file06      0  TINFO  :  TEST #6: file command recognizes ELF executables
file06      6  TPASS  :  file: Recognized ELF binary executable
file07      0  TINFO  :  TEST #7: file command recognizes tar files.
file07      7  TPASS  :  file: Recognised tar files
file08      0  TINFO  :  TEST #8: file command recognizes tar zip files
file08      8  TPASS  :  file: Recognised tar zip file
file09      0  TINFO  :  TEST #9: file command recognizes RPM files
file09      9  TCONF  :  rpm not installed
file10      0  TINFO  :  TEST #10: file command recognizes vmlinu file
file10     10  TPASS  :  file: Recognised vmlinu file correctly
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D4 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D32 cstime=3D9
<<<test_end>>>
INFO: ltp-pan reported all tests PASS
LTP Version: 20120401

       ###############################################################

            Done executing testcases.
            LTP Version:  20120401
       ###############################################################


Hence I am attaching the patch along with this mail. If this is not the
mailing list to post the patch, please let me know so that I can do so.


Thanks,
Sujith H


--=20
=E0=B4=B8=E0=B5=81=E0=B4=9C=E0=B4=BF=E0=B4=A4=E0=B5=8D =E0=B4=B9=E0=B4=B0=
=E0=B4=BF=E0=B4=A6=E0=B4=BE=E0=B4=B8=E0=B4=A8=E0=B5=8D
Bangalore
<Project>Contributor to KDE project
http://fci.wikia.com/wiki/Anti-DRM-Campaign
<Blog> http://sujithh.info

--14dae9340ebb5099f304c27ff96f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,<div><br></div><div>I was testing the file command test case and noticed=
 a small issue in the file_test.sh script.</div><div>The below mentioned is=
 the output of the script executed:</div><div><br></div><div><div>root@free=
scale-qsb:/opt/ltp# ./runltp -p -l file.log -f /opt/ltp/runtest/mycustomtes=
t=C2=A0</div>

<div>INFO: creating /opt/ltp/results directory</div><div>If some fields are=
 empty or look unusual you may have an old version.</div><div>Compare to th=
e current minimal requirements in Documentation/Changes.</div><div>=C2=A0</=
div>

<div>MontaVista Automotive Technology Platform 1.1, (.dev-snapshot-20120604=
)</div><div>Linux freescale-qsb 2.6.38.8.mvatp-fsl-imx53 #1 PREEMPT Wed Jun=
 6 00:55:46 PDT 2012 armv7l GNU/Linux</div><div>=C2=A0</div><div>Gnu C =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0arm-montavista-l=
inux-gnueabi-gcc (MontaVista Linux Sourcery G++ 4.4-312) 4.4.1</div>

<div>Gnu make =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3.81</div><d=
iv>util-linux =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ng 2.17)</div><div>=
mount =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ng 2.17=
 (with libblkid support)</div><div>modutils =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 3.4</div><div>/opt/ltp/ver_linux: line 52: ldd: not found=
</div>

<div>awk: cmd. line:1: (FILENAME=3D- FNR=3D1) fatal: attempt to access fiel=
d -1</div><div>/opt/ltp/ver_linux: line 55: ldd: not found</div><div>Procps=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3.2.8</div><div>ip=
route2 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iproute2-ss100224</d=
iv>

<div>Kbd =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A070:</div><div>Sh-utils =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
8.5</div><div>Modules Loaded =C2=A0 =C2=A0 =C2=A0 =C2=A0 ipv6 evbug exportf=
s nfsd</div><div><br></div><div>free reports:</div><div>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0total =C2=A0 =C2=A0 =C2=A0 used =C2=A0 =C2=
=A0 =C2=A0 free =C2=A0 =C2=A0 shared =C2=A0 =C2=A0buffers =C2=A0 =C2=A0 cac=
hed</div>

<div>Mem: =C2=A0 =C2=A0 =C2=A0 =C2=A0870808 =C2=A0 =C2=A0 =C2=A047296 =C2=
=A0 =C2=A0 823512 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 44 =C2=A0 =C2=A0 =C2=A023200</div><div>-/+ buffers/cache: =C2=A0 =C2=
=A0 =C2=A024052 =C2=A0 =C2=A0 846756</div><div>Swap: =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A00</div><div><br></div><div>/proc/cpuinfo</div>

<div>Processor =C2=A0 =C2=A0 =C2=A0 : ARMv7 Processor rev 5 (v7l)</div><div=
>BogoMIPS =C2=A0 =C2=A0 =C2=A0 =C2=A0: 999.42</div><div>Features =C2=A0 =C2=
=A0 =C2=A0 =C2=A0: swp half thumb fastmult vfp edsp neon vfpv3=C2=A0</div><=
div>CPU implementer : 0x41</div><div>CPU architecture: 7</div>

<div>CPU variant =C2=A0 =C2=A0 : 0x2</div><div>CPU part =C2=A0 =C2=A0 =C2=
=A0 =C2=A0: 0xc08</div><div>CPU revision =C2=A0 =C2=A0: 5</div><div><br></d=
iv><div>Hardware =C2=A0 =C2=A0 =C2=A0 =C2=A0: Freescale MX53 LOCO Board</di=
v><div>Revision =C2=A0 =C2=A0 =C2=A0 =C2=A0: 53021</div><div>Serial =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0: 0000000000000000</div>

<div>remove test cases which require the block device.</div><div>You can sp=
ecify it with option -b</div><div>COMMAND: =C2=A0 =C2=A0/opt/ltp/bin/ltp-pa=
n =C2=A0-e -S =C2=A0 -a 3153 =C2=A0 =C2=A0 -n 3153 =C2=A0-p =C2=A0-f /tmp/l=
tp-wHY6LgV3Pc/alltests -l /opt/ltp/results/file.log =C2=A0-C /opt/ltp/outpu=
t/LTP_RUN_ON-file.log.failed</div>

<div>LOG File: /opt/ltp/results/file.log</div><div>FAILED COMMAND File: /op=
t/ltp/output/LTP_RUN_ON-file.log.failed</div><div>Running tests.......</div=
><div>&lt;&lt;&lt;test_start&gt;&gt;&gt;</div><div>tag=3Dfile stime=3D12046=
14</div>

<div>cmdline=3D&quot;export TCdat=3D$LTPROOT/testcases/bin; file_test.sh&qu=
ot;</div><div>contacts=3D&quot;&quot;</div><div>analysis=3Dexit</div><div>&=
lt;&lt;&lt;test_output&gt;&gt;&gt;</div><div>incrementing stop</div><div>fi=
le01 =C2=A0 =C2=A0 =C2=A00 =C2=A0TINFO =C2=A0: =C2=A0TEST #1: file command =
recogizes ASCII text files</div>

<div>file01 =C2=A0 =C2=A0 =C2=A01 =C2=A0TPASS =C2=A0: =C2=A0file: Recognise=
d ASCII file correctly</div><div>file02 =C2=A0 =C2=A0 =C2=A00 =C2=A0TINFO =
=C2=A0: =C2=A0TEST #2: file command recognizes bash shell scripts</div><div=
>file02 =C2=A0 =C2=A0 =C2=A02 =C2=A0TPASS =C2=A0: =C2=A0file: Recognised ba=
sh shell script correctly</div>

<div>file03 =C2=A0 =C2=A0 =C2=A00 =C2=A0TINFO =C2=A0: =C2=A0TEST #3: file c=
ommand recognizes korn shell scripts</div><div>file03 =C2=A0 =C2=A0 =C2=A03=
 =C2=A0TPASS =C2=A0: =C2=A0file: recognised korn shell script</div><div>fil=
e04 =C2=A0 =C2=A0 =C2=A00 =C2=A0TINFO =C2=A0: =C2=A0TEST #4: file command r=
ecognizes C shell scripts</div>

<div>file04 =C2=A0 =C2=A0 =C2=A04 =C2=A0TPASS =C2=A0: =C2=A0file: Recognise=
d C shell script correctly</div><div>file05 =C2=A0 =C2=A0 =C2=A00 =C2=A0TIN=
FO =C2=A0: =C2=A0TEST #5: file command recognizes C programs text</div><div=
>file05 =C2=A0 =C2=A0 =C2=A05 =C2=A0TPASS =C2=A0: =C2=A0file: Recognised C =
program text correctly</div>

<div>file06 =C2=A0 =C2=A0 =C2=A00 =C2=A0TINFO =C2=A0: =C2=A0TEST #6: file c=
ommand recognizes ELF executables</div><div>file06 =C2=A0 =C2=A0 =C2=A06 =
=C2=A0TPASS =C2=A0: =C2=A0file: Recognized ELF binary executable</div><div>=
file07 =C2=A0 =C2=A0 =C2=A00 =C2=A0TINFO =C2=A0: =C2=A0TEST #7: file comman=
d recognizes tar files.</div>

<div>file07 =C2=A0 =C2=A0 =C2=A07 =C2=A0TPASS =C2=A0: =C2=A0file: Recognise=
d tar files</div><div>file08 =C2=A0 =C2=A0 =C2=A00 =C2=A0TINFO =C2=A0: =C2=
=A0TEST #8: file command recognizes tar zip files</div><div>file08 =C2=A0 =
=C2=A0 =C2=A08 =C2=A0TBROK =C2=A0: =C2=A0expected string: gzip compressed d=
ata, deflated,</div>

<div>original filename, `files.tar&#39;</div><div>file08 =C2=A0 =C2=A0 =C2=
=A09 =C2=A0TBROK =C2=A0: =C2=A0Remaining cases broken</div><div>file08 =C2=
=A0 =C2=A0 =C2=A08 =C2=A0TFAIL =C2=A0: =C2=A0file: Failed to Recognize tar =
zip. Reason:</div><div>/tmp/files.tar.gz: cannot open `/tmp/files.tar.gz&#3=
9; (No such file or directory)</div>

<div>file09 =C2=A0 =C2=A0 =C2=A00 =C2=A0TINFO =C2=A0: =C2=A0TEST #9: file c=
ommand recognizes RPM files</div><div>file09 =C2=A0 =C2=A0 =C2=A09 =C2=A0TC=
ONF =C2=A0: =C2=A0rpm not installed</div><div>file10 =C2=A0 =C2=A0 =C2=A00 =
=C2=A0TINFO =C2=A0: =C2=A0TEST #10: file command recognizes vmlinu file</di=
v><div>file10 =C2=A0 =C2=A0 10 =C2=A0TPASS =C2=A0: =C2=A0file: Recognised v=
mlinu file correctly</div>

<div>&lt;&lt;&lt;execution_status&gt;&gt;&gt;</div><div>initiation_status=
=3D&quot;ok&quot;</div><div>duration=3D6 termination_type=3Dexited terminat=
ion_id=3D1 corefile=3Dno</div><div>cutime=3D31 cstime=3D25</div><div>&lt;&l=
t;&lt;test_end&gt;&gt;&gt;</div>

<div>INFO: ltp-pan reported some tests FAIL</div><div>LTP Version: 20120401=
</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0</div><div>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0###############################################################</div=
><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 Done executing testcases.</div>

<div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 LTP Version: =C2=A020120401<=
/div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0######################################=
#########################</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0</div></div>=
<div><br></div><div>Here we can see that the script couldn&#39;t find the f=
iles.tar.gz file and exited. The problem I noticed in the script was, when =
the script executes the gzip command on the files.tar, the files.tar.gz fil=
e is created in the $PWD and hence it has to be moved to the $LTPTMP direct=
ory. After doing this change the output of the script was mentioned below:<=
/div>

<div><br></div><div><div>root@freescale-qsb:/opt# /opt/ltp/runltp -p -l fil=
e.log -f /opt/ltp/runtest/mycustomtest=C2=A0</div><div>INFO: creating /opt/=
ltp/results directory</div><div>If some fields are empty or look unusual yo=
u may have an old version.</div>

<div>Compare to the current minimal requirements in Documentation/Changes.<=
/div><div>=C2=A0</div><div>MontaVista Automotive Technology Platform 1.1, (=
.dev-snapshot-20120604)</div><div>Linux freescale-qsb 2.6.38.8.mvatp-fsl-im=
x53 #1 PREEMPT Wed Jun 6 00:55:46 PDT 2012 armv7l GNU/Linux</div>

<div>=C2=A0</div><div>Gnu C =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0arm-montavista-linux-gnueabi-gcc (MontaVista Linux Sourcer=
y G++ 4.4-312) 4.4.1</div><div>Gnu make =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 3.81</div><div>util-linux =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 ng 2.17)</div><div>mount =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0ng 2.17 (with libblkid support)</div>

<div>modutils =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3.4</div><di=
v>/opt/ltp/ver_linux: line 52: ldd: not found</div><div>awk: cmd. line:1: (=
FILENAME=3D- FNR=3D1) fatal: attempt to access field -1</div><div>/opt/ltp/=
ver_linux: line 55: ldd: not found</div>

<div>Procps =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3.2.8</=
div><div>iproute2 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iproute2-=
ss100224</div><div>Kbd =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A070:</div><div>Sh-utils =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 8.5</div><div>Modules Loaded =C2=A0 =C2=A0 =C2=A0 =C2=A0 ipv6=
 evbug exportfs nfsd</div>

<div><br></div><div>free reports:</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0total =C2=A0 =C2=A0 =C2=A0 used =C2=A0 =C2=A0 =C2=A0 free =
=C2=A0 =C2=A0 shared =C2=A0 =C2=A0buffers =C2=A0 =C2=A0 cached</div><div>Me=
m: =C2=A0 =C2=A0 =C2=A0 =C2=A0870808 =C2=A0 =C2=A0 =C2=A064280 =C2=A0 =C2=
=A0 806528 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
44 =C2=A0 =C2=A0 =C2=A038204</div><div>-/+ buffers/cache: =C2=A0 =C2=A0 =C2=
=A026032 =C2=A0 =C2=A0 844776</div>

<div>Swap: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A00 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00</div><div><br></div><div=
>/proc/cpuinfo</div><div>Processor =C2=A0 =C2=A0 =C2=A0 : ARMv7 Processor r=
ev 5 (v7l)</div><div>BogoMIPS =C2=A0 =C2=A0 =C2=A0 =C2=A0: 999.42</div><div=
>Features =C2=A0 =C2=A0 =C2=A0 =C2=A0: swp half thumb fastmult vfp edsp neo=
n vfpv3=C2=A0</div>

<div>CPU implementer : 0x41</div><div>CPU architecture: 7</div><div>CPU var=
iant =C2=A0 =C2=A0 : 0x2</div><div>CPU part =C2=A0 =C2=A0 =C2=A0 =C2=A0: 0x=
c08</div><div>CPU revision =C2=A0 =C2=A0: 5</div><div><br></div><div>Hardwa=
re =C2=A0 =C2=A0 =C2=A0 =C2=A0: Freescale MX53 LOCO Board</div>

<div>Revision =C2=A0 =C2=A0 =C2=A0 =C2=A0: 53021</div><div>Serial =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0: 0000000000000000</div><div>remove test cases w=
hich require the block device.</div><div>You can specify it with option -b<=
/div><div>COMMAND: =C2=A0 =C2=A0/opt/ltp/bin/ltp-pan =C2=A0-e -S =C2=A0 -a =
8100 =C2=A0 =C2=A0 -n 8100 =C2=A0-p =C2=A0-f /tmp/ltp-hkmNZkJsaD/alltests -=
l /opt/ltp/results/file.log =C2=A0-C /opt/ltp/output/LTP_RUN_ON-file.log.fa=
iled</div>

<div>LOG File: /opt/ltp/results/file.log</div><div>FAILED COMMAND File: /op=
t/ltp/output/LTP_RUN_ON-file.log.failed</div><div>Running tests.......</div=
><div>&lt;&lt;&lt;test_start&gt;&gt;&gt;</div><div>tag=3Dfile stime=3D12103=
90</div>

<div>cmdline=3D&quot;export TCdat=3D$LTPROOT/testcases/bin; file_test.sh&qu=
ot;</div><div>contacts=3D&quot;&quot;</div><div>analysis=3Dexit</div><div>&=
lt;&lt;&lt;test_output&gt;&gt;&gt;</div><div>incrementing stop</div><div>fi=
le01 =C2=A0 =C2=A0 =C2=A00 =C2=A0TINFO =C2=A0: =C2=A0TEST #1: file command =
recogizes ASCII text files</div>

<div>file01 =C2=A0 =C2=A0 =C2=A01 =C2=A0TPASS =C2=A0: =C2=A0file: Recognise=
d ASCII file correctly</div><div>file02 =C2=A0 =C2=A0 =C2=A00 =C2=A0TINFO =
=C2=A0: =C2=A0TEST #2: file command recognizes bash shell scripts</div><div=
>file02 =C2=A0 =C2=A0 =C2=A02 =C2=A0TPASS =C2=A0: =C2=A0file: Recognised ba=
sh shell script correctly</div>

<div>file03 =C2=A0 =C2=A0 =C2=A00 =C2=A0TINFO =C2=A0: =C2=A0TEST #3: file c=
ommand recognizes korn shell scripts</div><div>file03 =C2=A0 =C2=A0 =C2=A03=
 =C2=A0TPASS =C2=A0: =C2=A0file: recognised korn shell script</div><div>fil=
e04 =C2=A0 =C2=A0 =C2=A00 =C2=A0TINFO =C2=A0: =C2=A0TEST #4: file command r=
ecognizes C shell scripts</div>

<div>file04 =C2=A0 =C2=A0 =C2=A04 =C2=A0TPASS =C2=A0: =C2=A0file: Recognise=
d C shell script correctly</div><div>file05 =C2=A0 =C2=A0 =C2=A00 =C2=A0TIN=
FO =C2=A0: =C2=A0TEST #5: file command recognizes C programs text</div><div=
>file05 =C2=A0 =C2=A0 =C2=A05 =C2=A0TPASS =C2=A0: =C2=A0file: Recognised C =
program text correctly</div>

<div>file06 =C2=A0 =C2=A0 =C2=A00 =C2=A0TINFO =C2=A0: =C2=A0TEST #6: file c=
ommand recognizes ELF executables</div><div>file06 =C2=A0 =C2=A0 =C2=A06 =
=C2=A0TPASS =C2=A0: =C2=A0file: Recognized ELF binary executable</div><div>=
file07 =C2=A0 =C2=A0 =C2=A00 =C2=A0TINFO =C2=A0: =C2=A0TEST #7: file comman=
d recognizes tar files.</div>

<div>file07 =C2=A0 =C2=A0 =C2=A07 =C2=A0TPASS =C2=A0: =C2=A0file: Recognise=
d tar files</div><div>file08 =C2=A0 =C2=A0 =C2=A00 =C2=A0TINFO =C2=A0: =C2=
=A0TEST #8: file command recognizes tar zip files</div><div>file08 =C2=A0 =
=C2=A0 =C2=A08 =C2=A0TPASS =C2=A0: =C2=A0file: Recognised tar zip file</div=
><div>file09 =C2=A0 =C2=A0 =C2=A00 =C2=A0TINFO =C2=A0: =C2=A0TEST #9: file =
command recognizes RPM files</div>

<div>file09 =C2=A0 =C2=A0 =C2=A09 =C2=A0TCONF =C2=A0: =C2=A0rpm not install=
ed</div><div>file10 =C2=A0 =C2=A0 =C2=A00 =C2=A0TINFO =C2=A0: =C2=A0TEST #1=
0: file command recognizes vmlinu file</div><div>file10 =C2=A0 =C2=A0 10 =
=C2=A0TPASS =C2=A0: =C2=A0file: Recognised vmlinu file correctly</div><div>=
&lt;&lt;&lt;execution_status&gt;&gt;&gt;</div>

<div>initiation_status=3D&quot;ok&quot;</div><div>duration=3D4 termination_=
type=3Dexited termination_id=3D0 corefile=3Dno</div><div>cutime=3D32 cstime=
=3D9</div><div>&lt;&lt;&lt;test_end&gt;&gt;&gt;</div><div>INFO: ltp-pan rep=
orted all tests PASS</div>

<div>LTP Version: 20120401</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0</div=
><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0##########################################=
#####################</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0</div><div=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Done executing testcases.</div><=
div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 LTP Version: =C2=A020120401</=
div>

<div>=C2=A0 =C2=A0 =C2=A0 =C2=A0###########################################=
####################</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0</div></div><div>=
<br></div><div>Hence I am attaching the patch along with this mail. If this=
 is not the mailing list to post the patch, please let me know so that I ca=
n do so.</div>

<div><br></div><div><br></div><div>Thanks,</div><div>Sujith H</div><div><br=
 clear=3D"all"><div><br></div>-- <br>=E0=B4=B8=E0=B5=81=E0=B4=9C=E0=B4=BF=
=E0=B4=A4=E0=B5=8D =E0=B4=B9=E0=B4=B0=E0=B4=BF=E0=B4=A6=E0=B4=BE=E0=B4=B8=
=E0=B4=A8=E0=B5=8D<br>Bangalore<br>&lt;Project&gt;Contributor to KDE projec=
t<br><a href=3D"http://fci.wikia.com/wiki/Anti-DRM-Campaign" target=3D"_bla=
nk">http://fci.wikia.com/wiki/Anti-DRM-Campaign</a><br>

&lt;Blog&gt; <a href=3D"http://sujithh.info" target=3D"_blank">http://sujit=
hh.info</a><br><br>
</div>

--14dae9340ebb5099f304c27ff96f--

--14dae9340ebb5099fe04c27ff971
Content-Type: application/octet-stream; 
	name="0001-Modifiying-the-file_test.sh-because-of-the-failure-n.patch"
Content-Disposition: attachment; 
	filename="0001-Modifiying-the-file_test.sh-because-of-the-failure-n.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h3h3de7a0

RnJvbSBiMTg4YzliY2E1MDgyMmIxNmMyMjg4YjVhMDQ0MzAzOWUwNjhlMWJkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdWppdGggSCA8c2hhcmlkYXNhbkBtdmlzdGEuY29tPgpEYXRl
OiBGcmksIDE1IEp1biAyMDEyIDE1OjIzOjMxICswNTMwClN1YmplY3Q6IFtQQVRDSF0gTW9kaWZp
eWluZyB0aGUgZmlsZV90ZXN0LnNoIGJlY2F1c2Ugb2YgdGhlIGZhaWx1cmUgbm90aWNlZAogaW4g
dGhlIHRlc3Q4LiBnemlwIHdoZW4gZXhlY3V0ZWQgb24gdGhlICREL2ZpbGVzLnRhciB3aWxsCiBj
cmVhdGUgdGhlIGZpbGVzLnRhci5neiBpbiB0aGUgJFBXRC4gSGVuY2Ugd2UgbmVlZCB0byBtb3Zl
CiBmaWxlcy50YXIuZ3ogdG8gdGhlICRELyBkaXJlY3RvcnkuCgotLS0KIHRlc3RjYXNlcy9jb21t
YW5kcy9hZGUvZmlsZS9maWxlX3Rlc3Quc2ggfCAgICAzICsrLQogMSBmaWxlcyBjaGFuZ2VkLCAy
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2Nv
bW1hbmRzL2FkZS9maWxlL2ZpbGVfdGVzdC5zaCBiL3Rlc3RjYXNlcy9jb21tYW5kcy9hZGUvZmls
ZS9maWxlX3Rlc3Quc2gKaW5kZXggNzA0MjBlMy4uYWZlNzkxYiAxMDA3NTUKLS0tIGEvdGVzdGNh
c2VzL2NvbW1hbmRzL2FkZS9maWxlL2ZpbGVfdGVzdC5zaAorKysgYi90ZXN0Y2FzZXMvY29tbWFu
ZHMvYWRlL2ZpbGUvZmlsZV90ZXN0LnNoCkBAIC00NDAsNyArNDQwLDggQEAgdGhlbgogICAgICRM
VFBCSU4vdHN0X2JyayBUQlJPSyAkTFRQVE1QL2ZpbGUub3V0IE5VTEwgXAogICAgICAgICAiZmls
ZTogZ3ppcCBmYWlsZWQgdW5leHBlY3RlZGx5LiBSZWFzb246IgogZmkKLSAgICAKKworbXYgJFBX
RC9maWxlcy50YXIuZ3ogJExUUFRNUC8gICAgCiBmaWxlICRMVFBUTVAvZmlsZXMudGFyLmd6ID4g
JExUUFRNUC9maWxlLm91dCAyPiYxCiBpZiBbICQ/IC1lcSAwIF0KIHRoZW4KLS0gCjEuNy43LjYK
Cg==
--14dae9340ebb5099fe04c27ff971
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
--14dae9340ebb5099fe04c27ff971
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--14dae9340ebb5099fe04c27ff971--

