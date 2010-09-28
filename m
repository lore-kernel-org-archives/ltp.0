Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <joyarjit@gmail.com>) id 1P0Ryh-0000Yw-Km
	for ltp-list@lists.sourceforge.net; Tue, 28 Sep 2010 04:39:43 +0000
Received: from mail-wy0-f175.google.com ([74.125.82.175])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1P0Ryg-0000FE-4M
	for ltp-list@lists.sourceforge.net; Tue, 28 Sep 2010 04:39:43 +0000
Received: by mail-wy0-f175.google.com with SMTP id 35so3523805wyb.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 27 Sep 2010 21:39:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTinH_rH7iU4efFX8Bw9PUU_5DgMwR3q6p-bMZrOp@mail.gmail.com>
References: <AANLkTinH_rH7iU4efFX8Bw9PUU_5DgMwR3q6p-bMZrOp@mail.gmail.com>
Date: Tue, 28 Sep 2010 10:09:41 +0530
Message-ID: <AANLkTin18VbZ7bO6++nPd_Fz1J4FHQRn4akkqTDLYeT5@mail.gmail.com>
From: ARJIT SHARMA <joyarjit@gmail.com>
Subject: [LTP] LHOST_HWADDR
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1516794234617812613=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============1516794234617812613==
Content-Type: multipart/alternative; boundary=00151748e7c2f1441804914a6e80

--00151748e7c2f1441804914a6e80
Content-Type: text/plain; charset=ISO-8859-1

Hi

     During the execution of network related tests i am getting the error as
"environment variable LHOST_HWADDR not set"
     i tried solving this problem even by given static hwaddr in the
testscript "networkstress.sh" but same error is coming.
     i am runnning LTP on armv7 architechture.
     Here i am also sending you the log file, please help me out to solve
this problem.


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
Procps                 3.2.7
Net-tools              1.60
iproute2              iproute2-ss100224
Console-tools          0.2.3
Sh-utils               5.2.1
Modules Loaded
free reports:
             total       used       free     shared    buffers     cached
Mem:        255556      24508     231048          0          0      14620
-/+ buffers/cache:       9888     245668
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
COMMAND:    /opt/ltp/bin/ltp-pan  -e -S   -a 12621     -n 12621  -p  -f
/tmp/ltp-isNlo12627/alltests -l
/opt/ltp/results/network_stress.broken_ip.result  -C
/opt/ltp/output/LTP_RUN_ON-network_stress.broken_ip.result.failed
LOG File: /opt/ltp/results/network_stress.broken_ip.result
FAILED COMMAND File:
/opt/ltp/output/LTP_RUN_ON-network_stress.broken_ip.result.failed
Running tests.......
<<<test_start>>>
tag=broken_ip4-version stime=351622598
cmdline="broken_ip4-version"
contacts=""
analysis=exit
<<<test_output>>>
broken_ip4-version01    0  TINFO  :  Verify that the kernel is not crashed
with receiving a large number of IPv4 packets that have wrong value in
version field.
broken_ip4-version01    1  TBROK  :  Environment variable LHOST_HWADDRS is
not set.
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=3 cstime=10
<<<test_end>>>
<<<test_start>>>
tag=broken_ip4-ihl stime=351622598
cmdline="broken_ip4-ihl"
contacts=""
analysis=exit
<<<test_output>>>
broken_ip4-ihl01    0  TINFO  :  Verify that the kernel is not crashed with
receiving a large number of IPv4 packets that have wrong value in the header
length field.
broken_ip4-ihl01    1  TBROK  :  Environment variable LHOST_HWADDRS is not
set.
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=3 cstime=7
<<<test_end>>>
<<<test_start>>>
tag=broken_ip4-totlen stime=351622598
cmdline="broken_ip4-totlen"
contacts=""
analysis=exit
<<<test_output>>>
broken_ip4-totlen01    0  TINFO  :  Verify that the kernel is not crashed
with receiving a large number of IPv4 packets that have wrong value in the
total length field.
broken_ip4-totlen01    1  TBROK  :  Environment variable LHOST_HWADDRS is
not set.
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=7 cstime=5
<<<test_end>>>
<<<test_start>>>
tag=broken_ip4-fragment stime=351622598
cmdline="broken_ip4-fragment"
contacts=""
analysis=exit
<<<test_output>>>
broken_ip4-fragment01    0  TINFO  :  Verify that the kernel is not crashed
with receiving a large number of IPv4 packets that have wrong fragment
information
broken_ip4-fragment01    1  TBROK  :  Environment variable LHOST_HWADDRS is
not set.
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=2 cstime=13
<<<test_end>>>
<<<test_start>>>
tag=broken_ip4-protcol stime=351622598
cmdline="broken_ip4-protcol"
contacts=""
analysis=exit
<<<test_output>>>
broken_ip4-protocol01    0  TINFO  :  Verify that the kernel is not crashed
with receiving a large number of IPv4 packets that have wrong value in the
protocol field
broken_ip4-protocol01    1  TBROK  :  Environment variable LHOST_HWADDRS is
not set.
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=4 cstime=8
<<<test_end>>>
<<<test_start>>>
tag=broken_ip4-checksum stime=351622598
cmdline="broken_ip4-checksum"
contacts=""
analysis=exit
<<<test_output>>>
broken_ip4-checksum01    0  TINFO  :  Verify that the kernel is not crashed
with receiving a large number of IPv4 packets that have wrong value in the
checksum field
broken_ip4-checksum01    1  TBROK  :  Environment variable LHOST_HWADDRS is
not set.
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=5 cstime=7
<<<test_end>>>
<<<test_start>>>
tag=broken_ip4-dstaddr stime=351622598
cmdline="broken_ip4-dstaddr"
contacts=""
analysis=exit
<<<test_output>>>
broken_ip4-dstaddr01    0  TINFO  :  Verify that the kernel is not crashed
with receiving a large number of IPv4 packets whose destination address is
wrong (destination MAC address is correct)
broken_ip4-dstaddr01    1  TBROK  :  Environment variable LHOST_HWADDRS is
not set.
<<<execution_status>>>
initiation_status="ok"
duration=1 termination_type=exited termination_id=1 corefile=no
cutime=3 cstime=9
<<<test_end>>>
<<<test_start>>>
tag=broken_ip6-dstaddr stime=351622599
cmdline="broken_ip6-dstaddr"
contacts=""
analysis=exit
<<<test_output>>>
broken_ip6-dstaddr01    0  TINFO  :  Verify that the kernel is not crashed
with receiving a large number of IPv6 packets whose destination address is
wrong (destination MAC address is correct)
broken_ip6-dstaddr01    1  TBROK  :  Environment variable LHOST_HWADDRS is
not set.
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=1 cstime=12
<<<test_end>>>
<<<test_start>>>
tag=broken_ip6-nexthdr stime=351622599
cmdline="broken_ip6-nexthdr"
contacts=""
analysis=exit
<<<test_output>>>
broken_ip6-nexthdr01    0  TINFO  :  Verify that the kernel is not crashed
with receiving a large number of IPv6 packets that have wrong value in the
next header field.
broken_ip6-nexthdr01    1  TBROK  :  Environment variable LHOST_HWADDRS is
not set.
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=7 cstime=7
<<<test_end>>>
<<<test_start>>>
tag=broken_ip6-plen stime=351622599
cmdline="broken_ip6-plen"
contacts=""
analysis=exit
<<<test_output>>>
broken_ip6-plen01    0  TINFO  :  Verify that the kernel is not crashed with
receiving a large number of IPv6 packets that have wrong value in the
payload length field.
broken_ip6-plen01    1  TBROK  :  Environment variable LHOST_HWADDRS is not
set.
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=2 cstime=9
<<<test_end>>>
<<<test_start>>>
tag=broken_ip6-version stime=351622599
cmdline="broken_ip6-version"
contacts=""
analysis=exit
<<<test_output>>>
broken_ip6-version01    0  TINFO  :  Verify that the kernel is not crashed
with receiving a large number of IPv6 packets that have wrong value in
version field.
broken_ip6-version01    1  TBROK  :  Environment variable LHOST_HWADDRS is
not set.
incrementing stop
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=3 cstime=7
<<<test_end>>>
INFO: ltp-pan reported some tests FAIL
LTP Version: LTP-20100131

       ###############################################################"

            Done executing testcases."
            LTP Version:  LTP-20100131
       ###############################################################"




-- 
Regards,
Arjit Sharma.

--00151748e7c2f1441804914a6e80
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote"><br>
<div><br clear=3D"all">Hi</div>
<div>=A0</div>
<div>=A0=A0=A0=A0 During the execution of network related tests i am gettin=
g the error as &quot;environment variable LHOST_HWADDR not set&quot;</div>
<div>=A0=A0=A0=A0=A0i tried solving this problem even by given static=A0hwa=
ddr in the testscript &quot;networkstress.sh&quot; but same error is coming=
.</div>
<div>=A0=A0=A0=A0=A0i am=A0runnning LTP on armv7 architechture.</div>
<div>=A0=A0=A0=A0 Here i=A0am also=A0sending you the log file, please=A0hel=
p me out to solve this problem.</div>
<div>=A0</div>
<div>=A0</div>
<div>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 INFO: creating /opt/l=
tp/results directory<br>If some fields are empty or look unusual you may ha=
ve an old version.<br>Compare to the current minimal requirements in Docume=
ntation/Changes.<br>=A0<br>Linux 192.168.1.10 2.6.32 #2 SMP Fri Aug 27 12:3=
1:08 IST 2010 armv7l unknown unknown GNU/Linux<br>
=A0<br>Gnu C=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 gcc (GCC) 4=
.5.0<br>Gnu make=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 3.81<br>util-lin=
ux=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ng 2.16.1)<br>mount=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ng 2.16.1 (with libblkid support)<br>m=
odutils=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 3.1<br>e2fsprogs=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1.41.9<br>
PPP=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 2.4.4<br>Linux=
 C Library=A0=A0=A0=A0=A0=A0=A0 2.10.1<br>Dynamic linker (ldd)=A0=A0 2.10.1=
<br>Linux C++ Library=A0=A0=A0=A0=A0 6.0.14<br>Procps=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 3.2.7<br>Net-tools=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 1.60<br>iproute2=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 iprout=
e2-ss100224<br>
Console-tools=A0=A0=A0=A0=A0=A0=A0=A0=A0 0.2.3<br>Sh-utils=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 5.2.1<br>Modules Loaded=A0=A0=A0=A0=A0=A0=A0=A0=
 </div>
<div>free reports:<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 total=A0=A0=A0=
=A0=A0=A0 used=A0=A0=A0=A0=A0=A0 free=A0=A0=A0=A0 shared=A0=A0=A0 buffers=
=A0=A0=A0=A0 cached<br>Mem:=A0=A0=A0=A0=A0=A0=A0 255556=A0=A0=A0=A0=A0 2450=
8=A0=A0=A0=A0 231048=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0=A0=A0=A0=A0=A0 14620<br>-/+ buffers/cache:=A0=A0=A0=A0=A0=A0 9888=A0=
=A0=A0=A0 245668<br>
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
-e -S=A0=A0 -a 12621=A0=A0=A0=A0 -n 12621=A0 -p=A0 -f /tmp/ltp-isNlo12627/a=
lltests -l /opt/ltp/results/network_stress.broken_ip.result=A0 -C /opt/ltp/=
output/LTP_RUN_ON-network_stress.broken_ip.result.failed<br>
LOG File: /opt/ltp/results/network_stress.broken_ip.result<br>FAILED COMMAN=
D File: /opt/ltp/output/LTP_RUN_ON-network_stress.broken_ip.result.failed<b=
r>Running tests.......<br>&lt;&lt;&lt;test_start&gt;&gt;&gt;<br>tag=3Dbroke=
n_ip4-version stime=3D351622598<br>
cmdline=3D&quot;broken_ip4-version&quot;<br>contacts=3D&quot;&quot;<br>anal=
ysis=3Dexit<br>&lt;&lt;&lt;test_output&gt;&gt;&gt;<br>broken_ip4-version01=
=A0=A0=A0 0=A0 TINFO=A0 :=A0 Verify that the kernel is not crashed with rec=
eiving a large number of IPv4 packets that have wrong value in version fiel=
d.<br>
broken_ip4-version01=A0=A0=A0 1=A0 TBROK=A0 :=A0 Environment variable LHOST=
_HWADDRS is not set.<br>&lt;&lt;&lt;execution_status&gt;&gt;&gt;<br>initiat=
ion_status=3D&quot;ok&quot;<br>duration=3D0 termination_type=3Dexited termi=
nation_id=3D1 corefile=3Dno<br>
cutime=3D3 cstime=3D10<br>&lt;&lt;&lt;test_end&gt;&gt;&gt;<br>&lt;&lt;&lt;t=
est_start&gt;&gt;&gt;<br>tag=3Dbroken_ip4-ihl stime=3D351622598<br>cmdline=
=3D&quot;broken_ip4-ihl&quot;<br>contacts=3D&quot;&quot;<br>analysis=3Dexit=
<br>&lt;&lt;&lt;test_output&gt;&gt;&gt;<br>
broken_ip4-ihl01=A0=A0=A0 0=A0 TINFO=A0 :=A0 Verify that the kernel is not =
crashed with receiving a large number of IPv4 packets that have wrong value=
 in the header length field.<br>broken_ip4-ihl01=A0=A0=A0 1=A0 TBROK=A0 :=
=A0 Environment variable LHOST_HWADDRS is not set.<br>
&lt;&lt;&lt;execution_status&gt;&gt;&gt;<br>initiation_status=3D&quot;ok&qu=
ot;<br>duration=3D0 termination_type=3Dexited termination_id=3D1 corefile=
=3Dno<br>cutime=3D3 cstime=3D7<br>&lt;&lt;&lt;test_end&gt;&gt;&gt;<br>&lt;&=
lt;&lt;test_start&gt;&gt;&gt;<br>
tag=3Dbroken_ip4-totlen stime=3D351622598<br>cmdline=3D&quot;broken_ip4-tot=
len&quot;<br>contacts=3D&quot;&quot;<br>analysis=3Dexit<br>&lt;&lt;&lt;test=
_output&gt;&gt;&gt;<br>broken_ip4-totlen01=A0=A0=A0 0=A0 TINFO=A0 :=A0 Veri=
fy that the kernel is not crashed with receiving a large number of IPv4 pac=
kets that have wrong value in the total length field.<br>
broken_ip4-totlen01=A0=A0=A0 1=A0 TBROK=A0 :=A0 Environment variable LHOST_=
HWADDRS is not set.<br>&lt;&lt;&lt;execution_status&gt;&gt;&gt;<br>initiati=
on_status=3D&quot;ok&quot;<br>duration=3D0 termination_type=3Dexited termin=
ation_id=3D1 corefile=3Dno<br>
cutime=3D7 cstime=3D5<br>&lt;&lt;&lt;test_end&gt;&gt;&gt;<br>&lt;&lt;&lt;te=
st_start&gt;&gt;&gt;<br>tag=3Dbroken_ip4-fragment stime=3D351622598<br>cmdl=
ine=3D&quot;broken_ip4-fragment&quot;<br>contacts=3D&quot;&quot;<br>analysi=
s=3Dexit<br>
&lt;&lt;&lt;test_output&gt;&gt;&gt;<br>broken_ip4-fragment01=A0=A0=A0 0=A0 =
TINFO=A0 :=A0 Verify that the kernel is not crashed with receiving a large =
number of IPv4 packets that have wrong fragment information<br>broken_ip4-f=
ragment01=A0=A0=A0 1=A0 TBROK=A0 :=A0 Environment variable LHOST_HWADDRS is=
 not set.<br>
&lt;&lt;&lt;execution_status&gt;&gt;&gt;<br>initiation_status=3D&quot;ok&qu=
ot;<br>duration=3D0 termination_type=3Dexited termination_id=3D1 corefile=
=3Dno<br>cutime=3D2 cstime=3D13<br>&lt;&lt;&lt;test_end&gt;&gt;&gt;<br>&lt;=
&lt;&lt;test_start&gt;&gt;&gt;<br>
tag=3Dbroken_ip4-protcol stime=3D351622598<br>cmdline=3D&quot;broken_ip4-pr=
otcol&quot;<br>contacts=3D&quot;&quot;<br>analysis=3Dexit<br>&lt;&lt;&lt;te=
st_output&gt;&gt;&gt;<br>broken_ip4-protocol01=A0=A0=A0 0=A0 TINFO=A0 :=A0 =
Verify that the kernel is not crashed with receiving a large number of IPv4=
 packets that have wrong value in the protocol field<br>
broken_ip4-protocol01=A0=A0=A0 1=A0 TBROK=A0 :=A0 Environment variable LHOS=
T_HWADDRS is not set.<br>&lt;&lt;&lt;execution_status&gt;&gt;&gt;<br>initia=
tion_status=3D&quot;ok&quot;<br>duration=3D0 termination_type=3Dexited term=
ination_id=3D1 corefile=3Dno<br>
cutime=3D4 cstime=3D8<br>&lt;&lt;&lt;test_end&gt;&gt;&gt;<br>&lt;&lt;&lt;te=
st_start&gt;&gt;&gt;<br>tag=3Dbroken_ip4-checksum stime=3D351622598<br>cmdl=
ine=3D&quot;broken_ip4-checksum&quot;<br>contacts=3D&quot;&quot;<br>analysi=
s=3Dexit<br>
&lt;&lt;&lt;test_output&gt;&gt;&gt;<br>broken_ip4-checksum01=A0=A0=A0 0=A0 =
TINFO=A0 :=A0 Verify that the kernel is not crashed with receiving a large =
number of IPv4 packets that have wrong value in the checksum field<br>broke=
n_ip4-checksum01=A0=A0=A0 1=A0 TBROK=A0 :=A0 Environment variable LHOST_HWA=
DDRS is not set.<br>
&lt;&lt;&lt;execution_status&gt;&gt;&gt;<br>initiation_status=3D&quot;ok&qu=
ot;<br>duration=3D0 termination_type=3Dexited termination_id=3D1 corefile=
=3Dno<br>cutime=3D5 cstime=3D7<br>&lt;&lt;&lt;test_end&gt;&gt;&gt;<br>&lt;&=
lt;&lt;test_start&gt;&gt;&gt;<br>
tag=3Dbroken_ip4-dstaddr stime=3D351622598<br>cmdline=3D&quot;broken_ip4-ds=
taddr&quot;<br>contacts=3D&quot;&quot;<br>analysis=3Dexit<br>&lt;&lt;&lt;te=
st_output&gt;&gt;&gt;<br>broken_ip4-dstaddr01=A0=A0=A0 0=A0 TINFO=A0 :=A0 V=
erify that the kernel is not crashed with receiving a large number of IPv4 =
packets whose destination address is wrong (destination MAC address is corr=
ect)<br>
broken_ip4-dstaddr01=A0=A0=A0 1=A0 TBROK=A0 :=A0 Environment variable LHOST=
_HWADDRS is not set.<br>&lt;&lt;&lt;execution_status&gt;&gt;&gt;<br>initiat=
ion_status=3D&quot;ok&quot;<br>duration=3D1 termination_type=3Dexited termi=
nation_id=3D1 corefile=3Dno<br>
cutime=3D3 cstime=3D9<br>&lt;&lt;&lt;test_end&gt;&gt;&gt;<br>&lt;&lt;&lt;te=
st_start&gt;&gt;&gt;<br>tag=3Dbroken_ip6-dstaddr stime=3D351622599<br>cmdli=
ne=3D&quot;broken_ip6-dstaddr&quot;<br>contacts=3D&quot;&quot;<br>analysis=
=3Dexit<br>
&lt;&lt;&lt;test_output&gt;&gt;&gt;<br>broken_ip6-dstaddr01=A0=A0=A0 0=A0 T=
INFO=A0 :=A0 Verify that the kernel is not crashed with receiving a large n=
umber of IPv6 packets whose destination address is wrong (destination MAC a=
ddress is correct)<br>
broken_ip6-dstaddr01=A0=A0=A0 1=A0 TBROK=A0 :=A0 Environment variable LHOST=
_HWADDRS is not set.<br>&lt;&lt;&lt;execution_status&gt;&gt;&gt;<br>initiat=
ion_status=3D&quot;ok&quot;<br>duration=3D0 termination_type=3Dexited termi=
nation_id=3D1 corefile=3Dno<br>
cutime=3D1 cstime=3D12<br>&lt;&lt;&lt;test_end&gt;&gt;&gt;<br>&lt;&lt;&lt;t=
est_start&gt;&gt;&gt;<br>tag=3Dbroken_ip6-nexthdr stime=3D351622599<br>cmdl=
ine=3D&quot;broken_ip6-nexthdr&quot;<br>contacts=3D&quot;&quot;<br>analysis=
=3Dexit<br>
&lt;&lt;&lt;test_output&gt;&gt;&gt;<br>broken_ip6-nexthdr01=A0=A0=A0 0=A0 T=
INFO=A0 :=A0 Verify that the kernel is not crashed with receiving a large n=
umber of IPv6 packets that have wrong value in the next header field.<br>br=
oken_ip6-nexthdr01=A0=A0=A0 1=A0 TBROK=A0 :=A0 Environment variable LHOST_H=
WADDRS is not set.<br>
&lt;&lt;&lt;execution_status&gt;&gt;&gt;<br>initiation_status=3D&quot;ok&qu=
ot;<br>duration=3D0 termination_type=3Dexited termination_id=3D1 corefile=
=3Dno<br>cutime=3D7 cstime=3D7<br>&lt;&lt;&lt;test_end&gt;&gt;&gt;<br>&lt;&=
lt;&lt;test_start&gt;&gt;&gt;<br>
tag=3Dbroken_ip6-plen stime=3D351622599<br>cmdline=3D&quot;broken_ip6-plen&=
quot;<br>contacts=3D&quot;&quot;<br>analysis=3Dexit<br>&lt;&lt;&lt;test_out=
put&gt;&gt;&gt;<br>broken_ip6-plen01=A0=A0=A0 0=A0 TINFO=A0 :=A0 Verify tha=
t the kernel is not crashed with receiving a large number of IPv6 packets t=
hat have wrong value in the payload length field.<br>
broken_ip6-plen01=A0=A0=A0 1=A0 TBROK=A0 :=A0 Environment variable LHOST_HW=
ADDRS is not set.<br>&lt;&lt;&lt;execution_status&gt;&gt;&gt;<br>initiation=
_status=3D&quot;ok&quot;<br>duration=3D0 termination_type=3Dexited terminat=
ion_id=3D1 corefile=3Dno<br>
cutime=3D2 cstime=3D9<br>&lt;&lt;&lt;test_end&gt;&gt;&gt;<br>&lt;&lt;&lt;te=
st_start&gt;&gt;&gt;<br>tag=3Dbroken_ip6-version stime=3D351622599<br>cmdli=
ne=3D&quot;broken_ip6-version&quot;<br>contacts=3D&quot;&quot;<br>analysis=
=3Dexit<br>
&lt;&lt;&lt;test_output&gt;&gt;&gt;<br>broken_ip6-version01=A0=A0=A0 0=A0 T=
INFO=A0 :=A0 Verify that the kernel is not crashed with receiving a large n=
umber of IPv6 packets that have wrong value in version field.<br>broken_ip6=
-version01=A0=A0=A0 1=A0 TBROK=A0 :=A0 Environment variable LHOST_HWADDRS i=
s not set.<br>
incrementing stop<br>&lt;&lt;&lt;execution_status&gt;&gt;&gt;<br>initiation=
_status=3D&quot;ok&quot;<br>duration=3D0 termination_type=3Dexited terminat=
ion_id=3D1 corefile=3Dno<br>cutime=3D3 cstime=3D7<br>&lt;&lt;&lt;test_end&g=
t;&gt;&gt;<br>
INFO: ltp-pan reported some tests FAIL<br>LTP Version: LTP-20100131<br>=A0=
=A0=A0=A0=A0=A0=A0 <br>=A0=A0=A0=A0=A0=A0 #################################=
##############################&quot;<br>=A0=A0=A0=A0=A0=A0=A0 <br>=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 Done executing testcases.&quot;<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 LTP Version:=A0 LTP-20100131<br>=A0=A0=A0=
=A0=A0=A0 ###############################################################&q=
uot;<br>=A0=A0=A0=A0=A0=A0 <br></div>
<div>=A0</div>
<div>=A0<br clear=3D"all"><br>-- <br></div></div>
<div>Regards,</div>
<div>Arjit Sharma.</div><br>

--00151748e7c2f1441804914a6e80--


--===============1516794234617812613==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
--===============1516794234617812613==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============1516794234617812613==--

