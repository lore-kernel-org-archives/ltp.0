Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <joyarjit@gmail.com>) id 1P8SGc-0002cA-AT
	for ltp-list@lists.sourceforge.net; Wed, 20 Oct 2010 06:35:18 +0000
Received: from mail-ww0-f53.google.com ([74.125.82.53])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1P8SGa-0001Kq-SQ
	for ltp-list@lists.sourceforge.net; Wed, 20 Oct 2010 06:35:18 +0000
Received: by wwb17 with SMTP id 17so2310001wwb.10
	for <ltp-list@lists.sourceforge.net>;
	Tue, 19 Oct 2010 23:35:11 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 20 Oct 2010 12:05:08 +0530
Message-ID: <AANLkTi=ZhUY9+FnGMzyKSEAyrDyoBCmB5JZr+QOH+z7C@mail.gmail.com>
From: ARJIT SHARMA <joyarjit@gmail.com>
Subject: [LTP] NFS testcase error
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3961733210955163843=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net, hannuxx@gmail.com, Garrett Cooper <yanegomi@gmail.com>
Cc: ajay.khandelwal@st.com

--===============3961733210955163843==
Content-Type: multipart/alternative; boundary=0016364164e94e6d500493069cb4

--0016364164e94e6d500493069cb4
Content-Type: text/plain; charset=ISO-8859-1

Hi,

      During the execution of NFS testcase in ARM architechture, 5 out of 8
tests are failing.

      There is very strange kind of error occuring in few tests which i am
not able to track, actually what is happening is that, instead of  looking
for the file say " /opt/ltp/testcases bin/nfs02 " it is looking for
" /opt/ltp/testcases bin/nfs02493 " or something like this kind of random
file, which does not exists.

      Hence occurs "Permission denied" and test fails.

      This problem is also in few other tests, but here i am telling
you this problem with reference to NFS testcase.

      I am also sending you the log of the testcase, please suggest ways to
correct it and why this occurs.....

Ltp version             >>              Ltp-intermediate-20100228

Processor              >>              armv7 processor

Kernel version        >>              2.6.32 (LSP3.0-alpha)


INFO: creating /opt/ltp/results directory
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux 192.168.1.10 2.6.32 #2 SMP Fri Aug 27 12:31:08 IST 2010 armv7l unknown
unknown GNU/Linux

Gnu C                  gcc (GCC) 4.5.0
Gnu make               3.81
util-linux             ng 2.16.1)
mount                  ng 2.16.1 (with libblkid support)
modutils               3.1
e2fsprogs              1.41.9
PPP                    2.4.4
Linux C Library        2.10.1
Dynamic linker (ldd)   2.10.1
Linux C++ Library      6.0.14
Procps                 100.
Net-tools              1.60
iproute2              iproute2-ss100224
Console-tools          0.2.3
Sh-utils               5.2.1
Modules Loaded
free reports:
             total       used       free     shared    buffers     cached
Mem:        255556      58804     196752          0          0      45884
-/+ buffers/cache:      12920     242636
Swap:            0          0          0
/proc/cpuinfo
Processor : ARMv7 Processor rev 1 (v7l)
processor : 0
BogoMIPS : 996.14
processor : 1
BogoMIPS : 996.14
Features : swp half thumb fastmult vfp edsp vfpv3 vfpv3d16
CPU implementer : 0x41
CPU architecture: 7
CPU variant : 0x1
CPU part : 0xc09
CPU revision : 1
Hardware : ST-SPEAR1300-EVB
Revision : 0000
Serial  : 0000000000000000
remove test cases which require the block device.
You can specify it with option -b
COMMAND:    /opt/ltp/bin/ltp-pan  -e -S   -a 375     -n 375  -p  -f
/tmp/ltp-aCaatAb381/alltests -l /opt/ltp/results/nfs.result  -C
/opt/ltp/output/LTP_RUN_ON-nfs.result.failed
LOG File: /opt/ltp/results/nfs.result
FAILED COMMAND File: /opt/ltp/output/LTP_RUN_ON-nfs.result.failed
Running tests.......
<<<test_start>>>
tag=nfs01 stime=351719851
cmdline="export VERSION SOCKET_TYPE; TCbin=$LTPROOT/testcases/bin nfs01"
contacts=""
analysis=exit
<<<test_output>>>
/opt/ltp/testcases/bin/nfs01: line 203: test_resm: command not found
<<<execution_status>>>
initiation_status="ok"
duration=1 termination_type=exited termination_id=0 corefile=no
cutime=2 cstime=7
<<<test_end>>>
<<<test_start>>>
tag=nfs02 stime=351719852
cmdline="export VERSION SOCKET_TYPE; TCbin=$LTPROOT/testcases/bin nfs02"
contacts=""
analysis=exit
<<<test_output>>>
do_setup nfs02
Test Options:
 VERSION: 2
 RHOST: 192.168.1.10
 SOCKET_TYPE: udp
 NFS_TYPE: nfs
 TESTDIR: /tmp/nfs02493.testdir
Permission denied.
do_cleanup nfs02
umount: /opt/ltp/testcases/bin/nfs02493: not found
rmdir: `/opt/ltp/testcases/bin/nfs02493': No such file or directory
Permission denied.
Permission denied.
Test Failed: Could not create /tmp/nfs02493.testdir from 192.168.1.10
<<<execution_status>>>
initiation_status="ok"
duration=3 termination_type=exited termination_id=1 corefile=no
cutime=6 cstime=15
<<<test_end>>>
<<<test_start>>>
tag=nfs03 stime=351719855
cmdline="export VERSION SOCKET_TYPE; TCbin=$LTPROOT/testcases/bin nfs03"
contacts=""
analysis=exit
<<<test_output>>>
Test Options:
 VERSION: 2
 SOCKET_TYPE: udp
 TESTDIR: /tmp/nfs03507.testdir
 RHOST: 192.168.1.10
 NFS_TYPE: nfs
Test Parameters:
 Number of Directories: 100
 Number of Files per Directory:  100
 Number of nfsds tested: 1
Setting up remote machine: 192.168.1.10
Permission denied.
Cleaning up testcase
umount: /opt/ltp/testcases/bin/nfs03507: not mounted
Cannot umount /opt/ltp/testcases/bin/nfs03507
Permission denied.
Permission denied.
Permission denied.
Test Failed: Could not create remote directory
<<<execution_status>>>
initiation_status="ok"
duration=2 termination_type=exited termination_id=1 corefile=no
cutime=8 cstime=18
<<<test_end>>>
<<<test_start>>>
tag=nfs04 stime=351719857
cmdline="export VERSION SOCKET_TYPE; TCbin=$LTPROOT/testcases/bin nfs04"
contacts=""
analysis=exit
<<<test_output>>>
Test Options:
 VERSION: 2
 RHOST: 192.168.1.10
 FILESIZE: 10
 SOCKET_TYPE: udp
 TESTDIR: /tmp/nfs04525.testdir
 NFS_TYPE: nfs
 LOOPS: 1
nfs04       0  TINFO  :  Setting up remote machine: 192.168.1.10
Permission denied.
umount: /tmp/nfs04525: not mounted
nfs04       1  TBROK  :  Cannot umount /tmp/nfs04525
Permission denied.
Permission denied.
nfs04       1  TFAIL  :  Test Failed: Could not create remote directory
<<<execution_status>>>
initiation_status="ok"
duration=3 termination_type=exited termination_id=1 corefile=no
cutime=3 cstime=21
<<<test_end>>>
<<<test_start>>>
tag=nfslock01 stime=351719860
cmdline="export VERSION; nfslock01"
contacts=""
analysis=exit
<<<test_output>>>
doing Setup
Testing locking
locking /opt/ltp/testcases/bin/nfslock544/nfs_flock_idata file and writing
data
: doing /opt/ltp/testcases/bin/nfslock01.
Test Successful
<<<execution_status>>>
initiation_status="ok"
duration=22 termination_type=exited termination_id=0 corefile=no
cutime=20 cstime=433
<<<test_end>>>
<<<test_start>>>
tag=nfsstress stime=351719882
cmdline="export VERSION SOCKET_TYPE; nfsstress 20 50 1"
contacts=""
analysis=exit
<<<test_output>>>
Test Options:
 VERSION: 2
 RHOST: 192.168.1.10
 SOCKET_TYPE: udp
 NFS_TYPE: nfs
Test Parameters:
 Number of Directories: 20
 Number of Files per Directory: 50
 Number of Threads: 1
Setting up remote machine: 192.168.1.10
Permission denied.
Cleaning up testcase
umount: /opt/ltp/testcases/bin/nfsstress563: not mounted
Cannot umount /opt/ltp/testcases/bin/nfsstress563
Permission denied.
Permission denied.
Test Failed: Could not create remote directory
<<<execution_status>>>
initiation_status="ok"
duration=4 termination_type=exited termination_id=1 corefile=no
cutime=7 cstime=18
<<<test_end>>>
<<<test_start>>>
tag=nfsstat01 stime=351719886
cmdline="export VERSION; TCbin=$LTPROOT/testcases/bin nfsstat01"
contacts=""
analysis=exit
<<<test_output>>>
do_setup nfsstat01
This test runs LOCALLY.
do_cleanup nfsstat01
Unmounting TESTDIR
umount: /tmp/nfsstat01582.testdir: not found
Unmounting EXPORTDIR
umount: /tmp/nfsstat01582: not found
Test PASS
<<<execution_status>>>
initiation_status="ok"
duration=10 termination_type=exited termination_id=0 corefile=no
cutime=6 cstime=18
<<<test_end>>>
<<<test_start>>>
tag=nfsx-linux stime=351719896
cmdline="export VERSION SOCKET_TYPE; TCbin=$LTPROOT/testcases/bin fsx.sh"
contacts=""
analysis=exit
<<<test_output>>>
Test Options:
 VERSION: 2
 RHOST: 192.168.1.10
 ITERATIONS: 50000
 SOCKET_TYPE: udp
 NFS_TYPE: nfs
Setting up remote machine: 192.168.1.10
Permission denied.
Cleaning up testcase
Unmounting /opt/ltp/testcases/bin/fsx597
umount: /opt/ltp/testcases/bin/fsx597: not mounted
/opt/ltp/testcases/bin/fsx.sh: line 174: error: command not found
Permission denied.
Permission denied.
Test Failed: Could not create remote directory
incrementing stop
<<<execution_status>>>
initiation_status="ok"
duration=2 termination_type=exited termination_id=1 corefile=no
cutime=5 cstime=10
<<<test_end>>>
INFO: ltp-pan reported some tests FAIL
LTP Version: LTP-20100131

       ###############################################################"

            Done executing testcases."
            LTP Version:  LTP-20100131
       ###############################################################"



-- 
Best Regards,
Arjit Sharma.

--0016364164e94e6d500493069cb4
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Hi,</div>
<div>=A0</div>
<div>=A0=A0=A0=A0=A0 During the execution of NFS testcase in ARM architecht=
ure, 5 out of 8 tests are failing.</div>
<div>=A0</div>
<div>=A0=A0=A0=A0=A0=A0There is very strange kind of error occuring in few =
tests=A0which i am not able to track, actually what is happening is that, i=
nstead of=A0 looking for the file say=A0&quot; /opt/ltp/testcases bin/nfs02=
=A0&quot; it is looking for &quot;=A0/opt/ltp/testcases bin/nfs02493 &quot;=
 or something like this kind of random file, which does not exists.=A0</div=
>

<div>=A0</div>
<div>=A0=A0=A0=A0=A0 Hence occurs &quot;Permission denied&quot; and test fa=
ils.</div>
<div>=A0</div>
<div>=A0=A0=A0=A0=A0 This problem is also in=A0few other tests, but here i =
am telling you=A0this problem with reference to NFS testcase.</div>
<div>=A0</div>
<div>=A0=A0=A0=A0=A0 I am also sending you the log of the testcase, please =
suggest ways to correct it and why this occurs.....</div>
<div>=A0</div>
<div>Ltp version=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 &gt;&gt;=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 Ltp-intermediate-20100228</div>
<div>=A0</div>
<div>Processor=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 &gt;&gt;=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 armv7 processor</div>
<div>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 </div>
<div>Kernel version=A0=A0=A0=A0=A0=A0=A0 &gt;&gt;=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 2.6.32 (LSP3.0-alpha)</div>
<div>=A0</div>
<div>=A0</div>
<div>INFO: creating /opt/ltp/results directory<br>If some fields are empty =
or look unusual you may have an old version.<br>Compare to the current mini=
mal requirements in Documentation/Changes.<br>=A0<br>Linux 192.168.1.10 2.6=
.32 #2 SMP Fri Aug 27 12:31:08 IST 2010 armv7l unknown unknown GNU/Linux<br=
>
=A0<br>Gnu C=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 gcc (GCC) 4=
.5.0<br>Gnu make=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 3.81<br>util-lin=
ux=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ng 2.16.1)<br>mount=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ng 2.16.1 (with libblkid support)<br>m=
odutils=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 3.1<br>e2fsprogs=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1.41.9<br>
PPP=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 2.4.4<br>Linux=
 C Library=A0=A0=A0=A0=A0=A0=A0 2.10.1<br>Dynamic linker (ldd)=A0=A0 2.10.1=
<br>Linux C++ Library=A0=A0=A0=A0=A0 6.0.14<br>Procps=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 100.<br>Net-tools=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 1.60<br>iproute2=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 iproute2-=
ss100224<br>
Console-tools=A0=A0=A0=A0=A0=A0=A0=A0=A0 0.2.3<br>Sh-utils=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 5.2.1<br>Modules Loaded=A0=A0=A0=A0=A0=A0=A0=A0=
 </div>
<div>free reports:<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 total=A0=A0=A0=
=A0=A0=A0 used=A0=A0=A0=A0=A0=A0 free=A0=A0=A0=A0 shared=A0=A0=A0 buffers=
=A0=A0=A0=A0 cached<br>Mem:=A0=A0=A0=A0=A0=A0=A0 255556=A0=A0=A0=A0=A0 5880=
4=A0=A0=A0=A0 196752=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0=A0=A0=A0=A0=A0 45884<br>-/+ buffers/cache:=A0=A0=A0=A0=A0 12920=A0=A0=
=A0=A0 242636<br>
Swap:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 0</div>
<div>/proc/cpuinfo<br>Processor=A0: ARMv7 Processor rev 1 (v7l)<br>processo=
r=A0: 0<br>BogoMIPS=A0: 996.14</div>
<div>processor=A0: 1<br>BogoMIPS=A0: 996.14</div>
<div>Features=A0: swp half thumb fastmult vfp edsp vfpv3 vfpv3d16 <br>CPU i=
mplementer=A0: 0x41<br>CPU architecture: 7<br>CPU variant=A0: 0x1<br>CPU pa=
rt=A0: 0xc09<br>CPU revision=A0: 1</div>
<div>Hardware=A0: ST-SPEAR1300-EVB<br>Revision=A0: 0000<br>Serial=A0=A0: 00=
00000000000000<br>remove test cases which require the block device.<br>You =
can specify it with option -b<br>COMMAND:=A0=A0=A0 /opt/ltp/bin/ltp-pan=A0 =
-e -S=A0=A0 -a 375=A0=A0=A0=A0 -n 375=A0 -p=A0 -f /tmp/ltp-aCaatAb381/allte=
sts -l /opt/ltp/results/nfs.result=A0 -C /opt/ltp/output/LTP_RUN_ON-nfs.res=
ult.failed<br>
LOG File: /opt/ltp/results/nfs.result<br>FAILED COMMAND File: /opt/ltp/outp=
ut/LTP_RUN_ON-nfs.result.failed<br>Running tests.......<br>&lt;&lt;&lt;test=
_start&gt;&gt;&gt;<br>tag=3Dnfs01 stime=3D351719851<br>cmdline=3D&quot;expo=
rt VERSION SOCKET_TYPE; TCbin=3D$LTPROOT/testcases/bin nfs01&quot;<br>
contacts=3D&quot;&quot;<br>analysis=3Dexit<br>&lt;&lt;&lt;test_output&gt;&g=
t;&gt;<br>/opt/ltp/testcases/bin/nfs01: line 203: test_resm: command not fo=
und<br>&lt;&lt;&lt;execution_status&gt;&gt;&gt;<br>initiation_status=3D&quo=
t;ok&quot;<br>
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno<br>=
cutime=3D2 cstime=3D7<br>&lt;&lt;&lt;test_end&gt;&gt;&gt;<br>&lt;&lt;&lt;te=
st_start&gt;&gt;&gt;<br>tag=3Dnfs02 stime=3D351719852<br>cmdline=3D&quot;ex=
port VERSION SOCKET_TYPE; TCbin=3D$LTPROOT/testcases/bin nfs02&quot;<br>
contacts=3D&quot;&quot;<br>analysis=3Dexit<br>&lt;&lt;&lt;test_output&gt;&g=
t;&gt;<br>do_setup nfs02</div>
<div>Test Options:<br>=A0VERSION: 2<br>=A0RHOST: 192.168.1.10<br>=A0SOCKET_=
TYPE: udp<br>=A0NFS_TYPE: nfs<br>=A0TESTDIR: /tmp/nfs02493.testdir<br>Permi=
ssion denied.<br>do_cleanup nfs02 <br>umount: /opt/ltp/testcases/bin/nfs024=
93: not found<br>
rmdir: `/opt/ltp/testcases/bin/nfs02493&#39;: No such file or directory<br>=
Permission denied.<br>Permission denied.<br>Test Failed: Could not create /=
tmp/nfs02493.testdir from 192.168.1.10<br>&lt;&lt;&lt;execution_status&gt;&=
gt;&gt;<br>
initiation_status=3D&quot;ok&quot;<br>duration=3D3 termination_type=3Dexite=
d termination_id=3D1 corefile=3Dno<br>cutime=3D6 cstime=3D15<br>&lt;&lt;&lt=
;test_end&gt;&gt;&gt;<br>&lt;&lt;&lt;test_start&gt;&gt;&gt;<br>tag=3Dnfs03 =
stime=3D351719855<br>
cmdline=3D&quot;export VERSION SOCKET_TYPE; TCbin=3D$LTPROOT/testcases/bin =
nfs03&quot;<br>contacts=3D&quot;&quot;<br>analysis=3Dexit<br>&lt;&lt;&lt;te=
st_output&gt;&gt;&gt;</div>
<div>Test Options:<br>=A0VERSION: 2<br>=A0SOCKET_TYPE: udp<br>=A0TESTDIR: /=
tmp/nfs03507.testdir<br>=A0RHOST: 192.168.1.10<br>=A0NFS_TYPE: nfs</div>
<div>Test Parameters:<br>=A0Number of Directories: 100<br>=A0Number of File=
s per Directory:=A0 100<br>=A0Number of nfsds tested: 1</div>
<div>Setting up remote machine: 192.168.1.10<br>Permission denied.<br>Clean=
ing up testcase<br>umount: /opt/ltp/testcases/bin/nfs03507: not mounted<br>=
Cannot umount /opt/ltp/testcases/bin/nfs03507<br>Permission denied.<br>
Permission denied.<br>Permission denied.<br>Test Failed: Could not create r=
emote directory<br>&lt;&lt;&lt;execution_status&gt;&gt;&gt;<br>initiation_s=
tatus=3D&quot;ok&quot;<br>duration=3D2 termination_type=3Dexited terminatio=
n_id=3D1 corefile=3Dno<br>
cutime=3D8 cstime=3D18<br>&lt;&lt;&lt;test_end&gt;&gt;&gt;<br>&lt;&lt;&lt;t=
est_start&gt;&gt;&gt;<br>tag=3Dnfs04 stime=3D351719857<br>cmdline=3D&quot;e=
xport VERSION SOCKET_TYPE; TCbin=3D$LTPROOT/testcases/bin nfs04&quot;<br>co=
ntacts=3D&quot;&quot;<br>
analysis=3Dexit<br>&lt;&lt;&lt;test_output&gt;&gt;&gt;</div>
<div>Test Options:<br>=A0VERSION: 2<br>=A0RHOST: 192.168.1.10<br>=A0FILESIZ=
E: 10<br>=A0SOCKET_TYPE: udp<br>=A0TESTDIR: /tmp/nfs04525.testdir<br>=A0NFS=
_TYPE: nfs<br>=A0LOOPS: 1<br>nfs04=A0=A0=A0=A0=A0=A0 0=A0 TINFO=A0 :=A0 Set=
ting up remote machine: 192.168.1.10<br>
Permission denied.<br>umount: /tmp/nfs04525: not mounted<br>nfs04=A0=A0=A0=
=A0=A0=A0 1=A0 TBROK=A0 :=A0 Cannot umount /tmp/nfs04525<br>Permission deni=
ed.<br>Permission denied.<br>nfs04=A0=A0=A0=A0=A0=A0 1=A0 TFAIL=A0 :=A0 Tes=
t Failed: Could not create remote directory<br>
&lt;&lt;&lt;execution_status&gt;&gt;&gt;<br>initiation_status=3D&quot;ok&qu=
ot;<br>duration=3D3 termination_type=3Dexited termination_id=3D1 corefile=
=3Dno<br>cutime=3D3 cstime=3D21<br>&lt;&lt;&lt;test_end&gt;&gt;&gt;<br>&lt;=
&lt;&lt;test_start&gt;&gt;&gt;<br>
tag=3Dnfslock01 stime=3D351719860<br>cmdline=3D&quot;export VERSION; nfsloc=
k01&quot;<br>contacts=3D&quot;&quot;<br>analysis=3Dexit<br>&lt;&lt;&lt;test=
_output&gt;&gt;&gt;<br>doing Setup<br>Testing locking<br>locking /opt/ltp/t=
estcases/bin/nfslock544/nfs_flock_idata file and writing data<br>
: doing /opt/ltp/testcases/bin/nfslock01.<br>Test Successful<br>&lt;&lt;&lt=
;execution_status&gt;&gt;&gt;<br>initiation_status=3D&quot;ok&quot;<br>dura=
tion=3D22 termination_type=3Dexited termination_id=3D0 corefile=3Dno<br>cut=
ime=3D20 cstime=3D433<br>
&lt;&lt;&lt;test_end&gt;&gt;&gt;<br>&lt;&lt;&lt;test_start&gt;&gt;&gt;<br>t=
ag=3Dnfsstress stime=3D351719882<br>cmdline=3D&quot;export VERSION SOCKET_T=
YPE; nfsstress 20 50 1&quot;<br>contacts=3D&quot;&quot;<br>analysis=3Dexit<=
br>&lt;&lt;&lt;test_output&gt;&gt;&gt;</div>

<div>Test Options:<br>=A0VERSION: 2<br>=A0RHOST: 192.168.1.10<br>=A0SOCKET_=
TYPE: udp<br>=A0NFS_TYPE: nfs</div>
<div>Test Parameters:<br>=A0Number of Directories: 20<br>=A0Number of Files=
 per Directory: 50<br>=A0Number of Threads: 1</div>
<div>Setting up remote machine: 192.168.1.10<br>Permission denied.<br>Clean=
ing up testcase<br>umount: /opt/ltp/testcases/bin/nfsstress563: not mounted=
<br>Cannot umount /opt/ltp/testcases/bin/nfsstress563<br>Permission denied.=
<br>
Permission denied.<br>Test Failed: Could not create remote directory<br>&lt=
;&lt;&lt;execution_status&gt;&gt;&gt;<br>initiation_status=3D&quot;ok&quot;=
<br>duration=3D4 termination_type=3Dexited termination_id=3D1 corefile=3Dno=
<br>cutime=3D7 cstime=3D18<br>
&lt;&lt;&lt;test_end&gt;&gt;&gt;<br>&lt;&lt;&lt;test_start&gt;&gt;&gt;<br>t=
ag=3Dnfsstat01 stime=3D351719886<br>cmdline=3D&quot;export VERSION; TCbin=
=3D$LTPROOT/testcases/bin nfsstat01&quot;<br>contacts=3D&quot;&quot;<br>ana=
lysis=3Dexit<br>
&lt;&lt;&lt;test_output&gt;&gt;&gt;<br>do_setup nfsstat01<br>This test runs=
 LOCALLY.<br>do_cleanup nfsstat01 <br>Unmounting TESTDIR<br>umount: /tmp/nf=
sstat01582.testdir: not found<br>Unmounting EXPORTDIR<br>umount: /tmp/nfsst=
at01582: not found<br>
Test PASS<br>&lt;&lt;&lt;execution_status&gt;&gt;&gt;<br>initiation_status=
=3D&quot;ok&quot;<br>duration=3D10 termination_type=3Dexited termination_id=
=3D0 corefile=3Dno<br>cutime=3D6 cstime=3D18<br>&lt;&lt;&lt;test_end&gt;&gt=
;&gt;<br>&lt;&lt;&lt;test_start&gt;&gt;&gt;<br>
tag=3Dnfsx-linux stime=3D351719896<br>cmdline=3D&quot;export VERSION SOCKET=
_TYPE; TCbin=3D$LTPROOT/testcases/bin fsx.sh&quot;<br>contacts=3D&quot;&quo=
t;<br>analysis=3Dexit<br>&lt;&lt;&lt;test_output&gt;&gt;&gt;</div>
<div>Test Options:<br>=A0VERSION: 2<br>=A0RHOST: 192.168.1.10<br>=A0ITERATI=
ONS: 50000<br>=A0SOCKET_TYPE: udp<br>=A0NFS_TYPE: nfs<br>Setting up remote =
machine: 192.168.1.10<br>Permission denied.<br>Cleaning up testcase<br>Unmo=
unting /opt/ltp/testcases/bin/fsx597<br>
umount: /opt/ltp/testcases/bin/fsx597: not mounted<br>/opt/ltp/testcases/bi=
n/fsx.sh: line 174: error: command not found<br>Permission denied.<br>Permi=
ssion denied.<br>Test Failed: Could not create remote directory<br>incremen=
ting stop<br>
&lt;&lt;&lt;execution_status&gt;&gt;&gt;<br>initiation_status=3D&quot;ok&qu=
ot;<br>duration=3D2 termination_type=3Dexited termination_id=3D1 corefile=
=3Dno<br>cutime=3D5 cstime=3D10<br>&lt;&lt;&lt;test_end&gt;&gt;&gt;<br>INFO=
: ltp-pan reported some tests FAIL<br>
LTP Version: LTP-20100131<br>=A0=A0=A0=A0=A0=A0=A0 <br>=A0=A0=A0=A0=A0=A0 #=
##############################################################&quot;<br>=A0=
=A0=A0=A0=A0=A0=A0 <br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Done executing tes=
tcases.&quot;<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 LTP Version:=A0 LTP-2010=
0131<br>
=A0=A0=A0=A0=A0=A0 ########################################################=
#######&quot;<br>=A0=A0=A0=A0=A0=A0 <br><br clear=3D"all"><br>-- <br></div>
<div>Best Regards,</div>
<div>Arjit Sharma.</div><br>

--0016364164e94e6d500493069cb4--


--===============3961733210955163843==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Download new Adobe(R) Flash(R) Builder(TM) 4
The new Adobe(R) Flex(R) 4 and Flash(R) Builder(TM) 4 (formerly 
Flex(R) Builder(TM)) enable the development of rich applications that run
across multiple browsers and platforms. Download your free trials today!
http://p.sf.net/sfu/adobe-dev2dev
--===============3961733210955163843==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============3961733210955163843==--

