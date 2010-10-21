Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <joyarjit@gmail.com>) id 1P8sBD-0001AD-85
	for ltp-list@lists.sourceforge.net; Thu, 21 Oct 2010 10:15:27 +0000
Received: from mail-ww0-f53.google.com ([74.125.82.53])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1P8sBA-000664-Mg
	for ltp-list@lists.sourceforge.net; Thu, 21 Oct 2010 10:15:27 +0000
Received: by wwb17 with SMTP id 17so3696452wwb.10
	for <ltp-list@lists.sourceforge.net>;
	Thu, 21 Oct 2010 03:15:18 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 21 Oct 2010 15:45:18 +0530
Message-ID: <AANLkTintyGapn9bbw+hVXbvo7veQhJVmxLgssyWhKOpJ@mail.gmail.com>
From: ARJIT SHARMA <joyarjit@gmail.com>
Subject: [LTP] Network_stress
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1237361820011671946=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net, Garrett Cooper <yanegomi@gmail.com>
Cc: ajay.khandelwal@st.com

--===============1237361820011671946==
Content-Type: multipart/alternative; boundary=001636498bb98a95d704931dcd74

--001636498bb98a95d704931dcd74
Content-Type: text/plain; charset=ISO-8859-1

Hi,

     During the execution of network_stress tests, after configuring the
kernel and all of the services as required.

     there is an error that "failed to get the interface name at the remote
host"

     actually it is not able to find the interface.

     please suggest me how can i overcome this problem......////


Ltp version             >>              Ltp-intermediate-20100228

Processor              >>              armv7 processor

Kernel version        >>              2.6.32 (LSP3.0-alpha)

     # Log of the testcase is as follows:--



INFO: creating /opt/ltp/results directory
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux 192.168.1.10 2.6.32 #2 SMP Tue Oct 19 17:34:35 IST 2010 armv7l unknown
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
Mem:        255368      21968     233400          0          0      11872
-/+ buffers/cache:      10096     245272
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
Hardware : ST-SPEAR1310-EVB
Revision : 0000
Serial  : 0000000000000000
remove test cases which require the block device.
You can specify it with option -b
COMMAND:    /opt/ltp/bin/ltp-pan  -e -S   -a 2130     -n 2130  -p  -f
/tmp/ltp-QKJGLA2136/alltests -l
/opt/ltp/results/network_stress.broken_ip.result  -C
/opt/ltp/output/LTP_RUN_ON-network_stress.broken_ip.result.failed
LOG File: /opt/ltp/results/network_stress.broken_ip.result
FAILED COMMAND File:
/opt/ltp/output/LTP_RUN_ON-network_stress.broken_ip.result.failed
Running tests.......
<<<test_start>>>
tag=broken_ip4-version stime=339
cmdline="broken_ip4-version"
contacts=""
analysis=exit
<<<test_output>>>
broken_ip4-version01    0  TINFO  :  Verify that the kernel is not crashed
with receiving a large number of IPv4 packets that have wrong value in
version field.
broken_ip4-version01    0  TINFO  :  - Test duration is 3600 [sec]
Interface which has 00:04:23:21:93:70 is not found.
broken_ip4-version01    1  TBROK  :  Failed to get the interface name at the
remote host
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=12 cstime=28
<<<test_end>>>
<<<test_start>>>
tag=broken_ip4-ihl stime=339
cmdline="broken_ip4-ihl"
contacts=""
analysis=exit
<<<test_output>>>
broken_ip4-ihl01    0  TINFO  :  Verify that the kernel is not crashed with
receiving a large number of IPv4 packets that have wrong value in the header
length field.
broken_ip4-ihl01    0  TINFO  :  - Test duration is 3600 [sec]
Interface which has 00:04:23:21:93:70 is not found.
broken_ip4-ihl01    1  TBROK  :  Failed to get the interface name at the
remote host
<<<execution_status>>>
initiation_status="ok"
duration=1 termination_type=exited termination_id=1 corefile=no
cutime=10 cstime=23
<<<test_end>>>
<<<test_start>>>
tag=broken_ip4-totlen stime=340
cmdline="broken_ip4-totlen"
contacts=""
analysis=exit
<<<test_output>>>
broken_ip4-totlen01    0  TINFO  :  Verify that the kernel is not crashed
with receiving a large number of IPv4 packets that have wrong value in the
total length field.
broken_ip4-totlen01    0  TINFO  :  - Test duration is 3600 [sec]
Interface which has 00:04:23:21:93:70 is not found.
broken_ip4-totlen01    1  TBROK  :  Failed to get the interface name at the
remote host
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=11 cstime=31
<<<test_end>>>
<<<test_start>>>
tag=broken_ip4-fragment stime=340
cmdline="broken_ip4-fragment"
contacts=""
analysis=exit
<<<test_output>>>
broken_ip4-fragment01    0  TINFO  :  Verify that the kernel is not crashed
with receiving a large number of IPv4 packets that have wrong fragment
information
broken_ip4-fragment01    0  TINFO  :  - Test duration is 3600 [sec]
Interface which has 00:04:23:21:93:70 is not found.
broken_ip4-fragment01    1  TBROK  :  Failed to get the interface name at
the remote host
<<<execution_status>>>
initiation_status="ok"
duration=1 termination_type=exited termination_id=1 corefile=no
cutime=7 cstime=39
<<<test_end>>>
<<<test_start>>>
tag=broken_ip4-protcol stime=341
cmdline="broken_ip4-protcol"
contacts=""
analysis=exit
<<<test_output>>>
broken_ip4-protocol01    0  TINFO  :  Verify that the kernel is not crashed
with receiving a large number of IPv4 packets that have wrong value in the
protocol field
broken_ip4-protocol01    0  TINFO  :  - Test duration is 3600 [sec]
Interface which has 00:04:23:21:93:70 is not found.
broken_ip4-protocol01    1  TBROK  :  Failed to get the interface name at
the remote host
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=17 cstime=27
<<<test_end>>>
<<<test_start>>>
tag=broken_ip4-checksum stime=341
cmdline="broken_ip4-checksum"
contacts=""
analysis=exit
<<<test_output>>>
broken_ip4-checksum01    0  TINFO  :  Verify that the kernel is not crashed
with receiving a large number of IPv4 packets that have wrong value in the
checksum field
broken_ip4-checksum01    0  TINFO  :  - Test duration is 3600 [sec]
Interface which has 00:04:23:21:93:70 is not found.
broken_ip4-checksum01    1  TBROK  :  Failed to get the interface name at
the remote host
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=9 cstime=29
<<<test_end>>>
<<<test_start>>>
tag=broken_ip4-dstaddr stime=341
cmdline="broken_ip4-dstaddr"
contacts=""
analysis=exit
<<<test_output>>>
broken_ip4-dstaddr01    0  TINFO  :  Verify that the kernel is not crashed
with receiving a large number of IPv4 packets whose destination address is
wrong (destination MAC address is correct)
broken_ip4-dstaddr01    0  TINFO  :  - Test duration is 3600 [sec]
Interface which has 00:04:23:21:93:70 is not found.
broken_ip4-dstaddr01    1  TBROK  :  Failed to get the interface name at the
remote host
<<<execution_status>>>
initiation_status="ok"
duration=1 termination_type=exited termination_id=1 corefile=no
cutime=15 cstime=31
<<<test_end>>>
<<<test_start>>>
tag=broken_ip6-dstaddr stime=342
cmdline="broken_ip6-dstaddr"
contacts=""
analysis=exit
<<<test_output>>>
broken_ip6-dstaddr01    0  TINFO  :  Verify that the kernel is not crashed
with receiving a large number of IPv6 packets whose destination address is
wrong (destination MAC address is correct)
broken_ip6-dstaddr01    0  TINFO  :  - Test duration is 3600 [sec]
Interface which has 00:04:23:21:93:70 is not found.
broken_ip6-dstaddr01    1  TBROK  :  Failed to get the interface name at the
remote host
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=12 cstime=26
<<<test_end>>>
<<<test_start>>>
tag=broken_ip6-nexthdr stime=342
cmdline="broken_ip6-nexthdr"
contacts=""
analysis=exit
<<<test_output>>>
broken_ip6-nexthdr01    0  TINFO  :  Verify that the kernel is not crashed
with receiving a large number of IPv6 packets that have wrong value in the
next header field.
broken_ip6-nexthdr01    0  TINFO  :  - Test duration is 3600 [sec]
Interface which has 00:04:23:21:93:70 is not found.
broken_ip6-nexthdr01    1  TBROK  :  Failed to get the interface name at the
remote host
<<<execution_status>>>
initiation_status="ok"
duration=1 termination_type=exited termination_id=1 corefile=no
cutime=8 cstime=30
<<<test_end>>>
<<<test_start>>>
tag=broken_ip6-plen stime=343
cmdline="broken_ip6-plen"
contacts=""
analysis=exit
<<<test_output>>>
broken_ip6-plen01    0  TINFO  :  Verify that the kernel is not crashed with
receiving a large number of IPv6 packets that have wrong value in the
payload length field.
broken_ip6-plen01    0  TINFO  :  - Test duration is 3600 [sec]
Interface which has 00:04:23:21:93:70 is not found.
broken_ip6-plen01    1  TBROK  :  Failed to get the interface name at the
remote host
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=10 cstime=24
<<<test_end>>>
<<<test_start>>>
tag=broken_ip6-version stime=343
cmdline="broken_ip6-version"
contacts=""
analysis=exit
<<<test_output>>>
broken_ip6-version01    0  TINFO  :  Verify that the kernel is not crashed
with receiving a large number of IPv6 packets that have wrong value in
version field.
broken_ip6-version01    0  TINFO  :  - Test duration is 3600 [sec]
Interface which has 00:04:23:21:93:70 is not found.
broken_ip6-version01    1  TBROK  :  Failed to get the interface name at the
remote host
incrementing stop
<<<execution_status>>>
initiation_status="ok"
duration=1 termination_type=exited termination_id=1 corefile=no
cutime=11 cstime=32
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

--001636498bb98a95d704931dcd74
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Hi,</div>
<div>=A0</div>
<div>=A0=A0=A0=A0 During the execution of network_stress tests, after confi=
guring the kernel and=A0all of the services as required.</div>
<div>=A0</div>
<div>=A0=A0=A0=A0 there is an error that &quot;failed to get the interface =
name at the remote host&quot; </div>
<div>=A0</div>
<div>=A0=A0=A0=A0 actually it is not able to find the interface.</div>
<div>=A0</div>
<div>=A0=A0=A0=A0=A0please suggest me how can i overcome this problem......=
////</div>
<div>=A0</div>
<div>=A0</div>
<div>Ltp version=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 &gt;&gt;=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 Ltp-intermediate-20100228<br>=A0<br>Processor=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 &gt;&gt;=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 armv7 processor<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <br>Kernel v=
ersion=A0=A0=A0=A0=A0=A0=A0 &gt;&gt;=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 2.6.32 (LSP3.0-alpha)</div>

<div>=A0</div>
<div>=A0=A0=A0=A0=A0#=A0Log of the testcase is as follows:--</div>
<div>=A0</div>
<div>=A0=A0=A0=A0 </div>
<div>=A0</div>
<div>INFO: creating /opt/ltp/results directory<br>If some fields are empty =
or look unusual you may have an old version.<br>Compare to the current mini=
mal requirements in Documentation/Changes.<br>=A0<br></div>
<div>Linux 192.168.1.10 2.6.32 #2 SMP Tue Oct 19 17:34:35 IST 2010 armv7l u=
nknown unknown GNU/Linux<br>=A0<br>Gnu C=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 gcc (GCC) 4.5.0<br>Gnu make=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 3.81<br>util-linux=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ng 2=
.16.1)<br>mount=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ng 2.16.=
1 (with libblkid support)<br>
modutils=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 3.1<br>e2fsprogs=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1.41.9<br>PPP=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 2.4.4<br>Linux C Library=A0=A0=A0=A0=A0=A0=
=A0 2.10.1<br>Dynamic linker (ldd)=A0=A0 2.10.1<br>Linux C++ Library=A0=A0=
=A0=A0=A0 6.0.14<br>Procps=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
3.2.7<br>
Net-tools=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1.60<br>iproute2=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 iproute2-ss100224<br>Console-tools=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0.2.3<br>Sh-utils=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 5.2.1<br>Modules Loaded=A0=A0=A0=A0=A0=A0=A0=A0 </div>
<div>free reports:<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 total=A0=A0=A0=
=A0=A0=A0 used=A0=A0=A0=A0=A0=A0 free=A0=A0=A0=A0 shared=A0=A0=A0 buffers=
=A0=A0=A0=A0 cached<br>Mem:=A0=A0=A0=A0=A0=A0=A0 255368=A0=A0=A0=A0=A0 2196=
8=A0=A0=A0=A0 233400=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0=A0=A0=A0=A0=A0 11872<br>-/+ buffers/cache:=A0=A0=A0=A0=A0 10096=A0=A0=
=A0=A0 245272<br>
Swap:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 0</div>
<div>/proc/cpuinfo<br>Processor=A0: ARMv7 Processor rev 1 (v7l)<br>processo=
r=A0: 0<br>BogoMIPS=A0: 996.14</div>
<div>processor=A0: 1<br>BogoMIPS=A0: 996.14</div>
<div>Features=A0: swp half thumb fastmult vfp edsp vfpv3 vfpv3d16 <br>CPU i=
mplementer=A0: 0x41<br>CPU architecture: 7<br>CPU variant=A0: 0x1<br>CPU pa=
rt=A0: 0xc09<br>CPU revision=A0: 1</div>
<div>Hardware=A0: ST-SPEAR1310-EVB<br>Revision=A0: 0000<br>Serial=A0=A0: 00=
00000000000000<br>remove test cases which require the block device.<br>You =
can specify it with option -b<br>COMMAND:=A0=A0=A0 /opt/ltp/bin/ltp-pan=A0 =
-e -S=A0=A0 -a 2130=A0=A0=A0=A0 -n 2130=A0 -p=A0 -f /tmp/ltp-QKJGLA2136/all=
tests -l /opt/ltp/results/network_stress.broken_ip.result=A0 -C /opt/ltp/ou=
tput/LTP_RUN_ON-network_stress.broken_ip.result.failed<br>
LOG File: /opt/ltp/results/network_stress.broken_ip.result<br>FAILED COMMAN=
D File: /opt/ltp/output/LTP_RUN_ON-network_stress.broken_ip.result.failed<b=
r>Running tests.......<br>&lt;&lt;&lt;test_start&gt;&gt;&gt;<br>tag=3Dbroke=
n_ip4-version stime=3D339<br>
cmdline=3D&quot;broken_ip4-version&quot;<br>contacts=3D&quot;&quot;<br>anal=
ysis=3Dexit<br>&lt;&lt;&lt;test_output&gt;&gt;&gt;<br>broken_ip4-version01=
=A0=A0=A0 0=A0 TINFO=A0 :=A0 Verify that the kernel is not crashed with rec=
eiving a large number of IPv4 packets that have wrong value in version fiel=
d.<br>
broken_ip4-version01=A0=A0=A0 0=A0 TINFO=A0 :=A0 - Test duration is 3600 [s=
ec]<br>Interface which has 00:04:23:21:93:70 is not found.<br>broken_ip4-ve=
rsion01=A0=A0=A0 1=A0 TBROK=A0 :=A0 Failed to get the interface name at the=
 remote host<br>&lt;&lt;&lt;execution_status&gt;&gt;&gt;<br>
initiation_status=3D&quot;ok&quot;<br>duration=3D0 termination_type=3Dexite=
d termination_id=3D1 corefile=3Dno<br>cutime=3D12 cstime=3D28<br>&lt;&lt;&l=
t;test_end&gt;&gt;&gt;<br>&lt;&lt;&lt;test_start&gt;&gt;&gt;<br>tag=3Dbroke=
n_ip4-ihl stime=3D339<br>
cmdline=3D&quot;broken_ip4-ihl&quot;<br>contacts=3D&quot;&quot;<br>analysis=
=3Dexit<br>&lt;&lt;&lt;test_output&gt;&gt;&gt;<br>broken_ip4-ihl01=A0=A0=A0=
 0=A0 TINFO=A0 :=A0 Verify that the kernel is not crashed with receiving a =
large number of IPv4 packets that have wrong value in the header length fie=
ld.<br>
broken_ip4-ihl01=A0=A0=A0 0=A0 TINFO=A0 :=A0 - Test duration is 3600 [sec]<=
br>Interface which has 00:04:23:21:93:70 is not found.<br>broken_ip4-ihl01=
=A0=A0=A0 1=A0 TBROK=A0 :=A0 Failed to get the interface name at the remote=
 host<br>&lt;&lt;&lt;execution_status&gt;&gt;&gt;<br>
initiation_status=3D&quot;ok&quot;<br>duration=3D1 termination_type=3Dexite=
d termination_id=3D1 corefile=3Dno<br>cutime=3D10 cstime=3D23<br>&lt;&lt;&l=
t;test_end&gt;&gt;&gt;<br>&lt;&lt;&lt;test_start&gt;&gt;&gt;<br>tag=3Dbroke=
n_ip4-totlen stime=3D340<br>
cmdline=3D&quot;broken_ip4-totlen&quot;<br>contacts=3D&quot;&quot;<br>analy=
sis=3Dexit<br>&lt;&lt;&lt;test_output&gt;&gt;&gt;<br>broken_ip4-totlen01=A0=
=A0=A0 0=A0 TINFO=A0 :=A0 Verify that the kernel is not crashed with receiv=
ing a large number of IPv4 packets that have wrong value in the total lengt=
h field.<br>
broken_ip4-totlen01=A0=A0=A0 0=A0 TINFO=A0 :=A0 - Test duration is 3600 [se=
c]<br>Interface which has 00:04:23:21:93:70 is not found.<br>broken_ip4-tot=
len01=A0=A0=A0 1=A0 TBROK=A0 :=A0 Failed to get the interface name at the r=
emote host<br>&lt;&lt;&lt;execution_status&gt;&gt;&gt;<br>
initiation_status=3D&quot;ok&quot;<br>duration=3D0 termination_type=3Dexite=
d termination_id=3D1 corefile=3Dno<br>cutime=3D11 cstime=3D31<br>&lt;&lt;&l=
t;test_end&gt;&gt;&gt;<br>&lt;&lt;&lt;test_start&gt;&gt;&gt;<br>tag=3Dbroke=
n_ip4-fragment stime=3D340<br>
cmdline=3D&quot;broken_ip4-fragment&quot;<br>contacts=3D&quot;&quot;<br>ana=
lysis=3Dexit<br>&lt;&lt;&lt;test_output&gt;&gt;&gt;<br>broken_ip4-fragment0=
1=A0=A0=A0 0=A0 TINFO=A0 :=A0 Verify that the kernel is not crashed with re=
ceiving a large number of IPv4 packets that have wrong fragment information=
<br>
broken_ip4-fragment01=A0=A0=A0 0=A0 TINFO=A0 :=A0 - Test duration is 3600 [=
sec]<br>Interface which has 00:04:23:21:93:70 is not found.<br>broken_ip4-f=
ragment01=A0=A0=A0 1=A0 TBROK=A0 :=A0 Failed to get the interface name at t=
he remote host<br>&lt;&lt;&lt;execution_status&gt;&gt;&gt;<br>
initiation_status=3D&quot;ok&quot;<br>duration=3D1 termination_type=3Dexite=
d termination_id=3D1 corefile=3Dno<br>cutime=3D7 cstime=3D39<br>&lt;&lt;&lt=
;test_end&gt;&gt;&gt;<br>&lt;&lt;&lt;test_start&gt;&gt;&gt;<br>tag=3Dbroken=
_ip4-protcol stime=3D341<br>
cmdline=3D&quot;broken_ip4-protcol&quot;<br>contacts=3D&quot;&quot;<br>anal=
ysis=3Dexit<br>&lt;&lt;&lt;test_output&gt;&gt;&gt;<br>broken_ip4-protocol01=
=A0=A0=A0 0=A0 TINFO=A0 :=A0 Verify that the kernel is not crashed with rec=
eiving a large number of IPv4 packets that have wrong value in the protocol=
 field<br>
broken_ip4-protocol01=A0=A0=A0 0=A0 TINFO=A0 :=A0 - Test duration is 3600 [=
sec]<br>Interface which has 00:04:23:21:93:70 is not found.<br>broken_ip4-p=
rotocol01=A0=A0=A0 1=A0 TBROK=A0 :=A0 Failed to get the interface name at t=
he remote host<br>&lt;&lt;&lt;execution_status&gt;&gt;&gt;<br>
initiation_status=3D&quot;ok&quot;<br>duration=3D0 termination_type=3Dexite=
d termination_id=3D1 corefile=3Dno<br>cutime=3D17 cstime=3D27<br>&lt;&lt;&l=
t;test_end&gt;&gt;&gt;<br>&lt;&lt;&lt;test_start&gt;&gt;&gt;<br>tag=3Dbroke=
n_ip4-checksum stime=3D341<br>
cmdline=3D&quot;broken_ip4-checksum&quot;<br>contacts=3D&quot;&quot;<br>ana=
lysis=3Dexit<br>&lt;&lt;&lt;test_output&gt;&gt;&gt;<br>broken_ip4-checksum0=
1=A0=A0=A0 0=A0 TINFO=A0 :=A0 Verify that the kernel is not crashed with re=
ceiving a large number of IPv4 packets that have wrong value in the checksu=
m field<br>
broken_ip4-checksum01=A0=A0=A0 0=A0 TINFO=A0 :=A0 - Test duration is 3600 [=
sec]<br>Interface which has 00:04:23:21:93:70 is not found.<br>broken_ip4-c=
hecksum01=A0=A0=A0 1=A0 TBROK=A0 :=A0 Failed to get the interface name at t=
he remote host<br>&lt;&lt;&lt;execution_status&gt;&gt;&gt;<br>
initiation_status=3D&quot;ok&quot;<br>duration=3D0 termination_type=3Dexite=
d termination_id=3D1 corefile=3Dno<br>cutime=3D9 cstime=3D29<br>&lt;&lt;&lt=
;test_end&gt;&gt;&gt;<br>&lt;&lt;&lt;test_start&gt;&gt;&gt;<br>tag=3Dbroken=
_ip4-dstaddr stime=3D341<br>
cmdline=3D&quot;broken_ip4-dstaddr&quot;<br>contacts=3D&quot;&quot;<br>anal=
ysis=3Dexit<br>&lt;&lt;&lt;test_output&gt;&gt;&gt;<br>broken_ip4-dstaddr01=
=A0=A0=A0 0=A0 TINFO=A0 :=A0 Verify that the kernel is not crashed with rec=
eiving a large number of IPv4 packets whose destination address is wrong (d=
estination MAC address is correct)<br>
broken_ip4-dstaddr01=A0=A0=A0 0=A0 TINFO=A0 :=A0 - Test duration is 3600 [s=
ec]<br>Interface which has 00:04:23:21:93:70 is not found.<br>broken_ip4-ds=
taddr01=A0=A0=A0 1=A0 TBROK=A0 :=A0 Failed to get the interface name at the=
 remote host<br>&lt;&lt;&lt;execution_status&gt;&gt;&gt;<br>
initiation_status=3D&quot;ok&quot;<br>duration=3D1 termination_type=3Dexite=
d termination_id=3D1 corefile=3Dno<br>cutime=3D15 cstime=3D31<br>&lt;&lt;&l=
t;test_end&gt;&gt;&gt;<br>&lt;&lt;&lt;test_start&gt;&gt;&gt;<br>tag=3Dbroke=
n_ip6-dstaddr stime=3D342<br>
cmdline=3D&quot;broken_ip6-dstaddr&quot;<br>contacts=3D&quot;&quot;<br>anal=
ysis=3Dexit<br>&lt;&lt;&lt;test_output&gt;&gt;&gt;<br>broken_ip6-dstaddr01=
=A0=A0=A0 0=A0 TINFO=A0 :=A0 Verify that the kernel is not crashed with rec=
eiving a large number of IPv6 packets whose destination address is wrong (d=
estination MAC address is correct)<br>
broken_ip6-dstaddr01=A0=A0=A0 0=A0 TINFO=A0 :=A0 - Test duration is 3600 [s=
ec]<br>Interface which has 00:04:23:21:93:70 is not found.<br>broken_ip6-ds=
taddr01=A0=A0=A0 1=A0 TBROK=A0 :=A0 Failed to get the interface name at the=
 remote host<br>&lt;&lt;&lt;execution_status&gt;&gt;&gt;<br>
initiation_status=3D&quot;ok&quot;<br>duration=3D0 termination_type=3Dexite=
d termination_id=3D1 corefile=3Dno<br>cutime=3D12 cstime=3D26<br>&lt;&lt;&l=
t;test_end&gt;&gt;&gt;<br>&lt;&lt;&lt;test_start&gt;&gt;&gt;<br>tag=3Dbroke=
n_ip6-nexthdr stime=3D342<br>
cmdline=3D&quot;broken_ip6-nexthdr&quot;<br>contacts=3D&quot;&quot;<br>anal=
ysis=3Dexit<br>&lt;&lt;&lt;test_output&gt;&gt;&gt;<br>broken_ip6-nexthdr01=
=A0=A0=A0 0=A0 TINFO=A0 :=A0 Verify that the kernel is not crashed with rec=
eiving a large number of IPv6 packets that have wrong value in the next hea=
der field.<br>
broken_ip6-nexthdr01=A0=A0=A0 0=A0 TINFO=A0 :=A0 - Test duration is 3600 [s=
ec]<br>Interface which has 00:04:23:21:93:70 is not found.<br>broken_ip6-ne=
xthdr01=A0=A0=A0 1=A0 TBROK=A0 :=A0 Failed to get the interface name at the=
 remote host<br>&lt;&lt;&lt;execution_status&gt;&gt;&gt;<br>
initiation_status=3D&quot;ok&quot;<br>duration=3D1 termination_type=3Dexite=
d termination_id=3D1 corefile=3Dno<br>cutime=3D8 cstime=3D30<br>&lt;&lt;&lt=
;test_end&gt;&gt;&gt;<br>&lt;&lt;&lt;test_start&gt;&gt;&gt;<br>tag=3Dbroken=
_ip6-plen stime=3D343<br>
cmdline=3D&quot;broken_ip6-plen&quot;<br>contacts=3D&quot;&quot;<br>analysi=
s=3Dexit<br>&lt;&lt;&lt;test_output&gt;&gt;&gt;<br>broken_ip6-plen01=A0=A0=
=A0 0=A0 TINFO=A0 :=A0 Verify that the kernel is not crashed with receiving=
 a large number of IPv6 packets that have wrong value in the payload length=
 field.<br>
broken_ip6-plen01=A0=A0=A0 0=A0 TINFO=A0 :=A0 - Test duration is 3600 [sec]=
<br>Interface which has 00:04:23:21:93:70 is not found.<br>broken_ip6-plen0=
1=A0=A0=A0 1=A0 TBROK=A0 :=A0 Failed to get the interface name at the remot=
e host<br>&lt;&lt;&lt;execution_status&gt;&gt;&gt;<br>
initiation_status=3D&quot;ok&quot;<br>duration=3D0 termination_type=3Dexite=
d termination_id=3D1 corefile=3Dno<br>cutime=3D10 cstime=3D24<br>&lt;&lt;&l=
t;test_end&gt;&gt;&gt;<br>&lt;&lt;&lt;test_start&gt;&gt;&gt;<br>tag=3Dbroke=
n_ip6-version stime=3D343<br>
cmdline=3D&quot;broken_ip6-version&quot;<br>contacts=3D&quot;&quot;<br>anal=
ysis=3Dexit<br>&lt;&lt;&lt;test_output&gt;&gt;&gt;<br>broken_ip6-version01=
=A0=A0=A0 0=A0 TINFO=A0 :=A0 Verify that the kernel is not crashed with rec=
eiving a large number of IPv6 packets that have wrong value in version fiel=
d.<br>
broken_ip6-version01=A0=A0=A0 0=A0 TINFO=A0 :=A0 - Test duration is 3600 [s=
ec]<br>Interface which has 00:04:23:21:93:70 is not found.<br>broken_ip6-ve=
rsion01=A0=A0=A0 1=A0 TBROK=A0 :=A0 Failed to get the interface name at the=
 remote host<br>incrementing stop<br>
&lt;&lt;&lt;execution_status&gt;&gt;&gt;<br>initiation_status=3D&quot;ok&qu=
ot;<br>duration=3D1 termination_type=3Dexited termination_id=3D1 corefile=
=3Dno<br>cutime=3D11 cstime=3D32<br>&lt;&lt;&lt;test_end&gt;&gt;&gt;<br>INF=
O: ltp-pan reported some tests FAIL<br>
LTP Version: LTP-20100131<br>=A0=A0=A0=A0=A0=A0=A0 <br>=A0=A0=A0=A0=A0=A0 #=
##############################################################&quot;<br>=A0=
=A0=A0=A0=A0=A0=A0 <br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Done executing tes=
tcases.&quot;<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 LTP Version:=A0 LTP-2010=
0131<br>
=A0=A0=A0=A0=A0=A0 ########################################################=
#######&quot;<br>=A0=A0=A0=A0=A0=A0 <br></div>
<div>=A0=A0=A0=A0=A0=A0=A0=A0 =A0</div>
<div>=A0=A0=A0=A0 <br>-- <br></div>
<div>Best Regards,</div>
<div>Arjit Sharma.</div><br>

--001636498bb98a95d704931dcd74--


--===============1237361820011671946==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Nokia and AT&T present the 2010 Calling All Innovators-North America contest
Create new apps & games for the Nokia N8 for consumers in  U.S. and Canada
$10 million total in prizes - $4M cash, 500 devices, nearly $6M in marketing
Develop with Nokia Qt SDK, Web Runtime, or Java and Publish to Ovi Store 
http://p.sf.net/sfu/nokia-dev2dev
--===============1237361820011671946==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============1237361820011671946==--

