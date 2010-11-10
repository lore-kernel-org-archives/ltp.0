Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <joyarjit@gmail.com>) id 1PG2rL-0002B7-3o
	for ltp-list@lists.sourceforge.net; Wed, 10 Nov 2010 05:04:35 +0000
Received: from mail-ww0-f53.google.com ([74.125.82.53])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PG2rJ-0008KG-DZ
	for ltp-list@lists.sourceforge.net; Wed, 10 Nov 2010 05:04:35 +0000
Received: by wwi17 with SMTP id 17so334979wwi.10
	for <ltp-list@lists.sourceforge.net>;
	Tue, 09 Nov 2010 21:04:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <AANLkTin2ec6mhb1BEo9fTvYASxYRBZc0bYbRhy02Z4Q8@mail.gmail.com>
References: <AANLkTin2ec6mhb1BEo9fTvYASxYRBZc0bYbRhy02Z4Q8@mail.gmail.com>
Date: Wed, 10 Nov 2010 10:34:27 +0530
Message-ID: <AANLkTimMZzXqBLNvEZ_Z7bViEdrKGKzCN=YywzeBQRkJ@mail.gmail.com>
From: ARJIT SHARMA <joyarjit@gmail.com>
Subject: Re: [LTP] important issue
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============6256108783090132621=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>, ltp-list@lists.sourceforge.net
Cc: ajay.khandelwal@st.com

--===============6256108783090132621==
Content-Type: multipart/alternative; boundary=0016364d236dade2a70494abca47

--0016364d236dade2a70494abca47
Content-Type: text/plain; charset=ISO-8859-1

HI,

      here i am sending the log of the problem so that you can sugggest some
method to solve this issue.




INFO: creating /opt/ltp/results directory
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

STMicroelectronics Base Distribution 2.4
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
Mem:        255368      20632     234736          0          0      10948
-/+ buffers/cache:       9684     245684
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
COMMAND:    /opt/ltp/bin/ltp-pan  -e -S   -a 1241     -n 1241  -p  -f
/tmp/ltp-HcxbKw1247/alltests -l
/opt/ltp/results/network_stress.broken_ip.result  -C
/opt/ltp/output/LTP_RUN_ON-network_stress.broken_ip.result.failed
LOG File: /opt/ltp/results/network_stress.broken_ip.result
FAILED COMMAND File:
/opt/ltp/output/LTP_RUN_ON-network_stress.broken_ip.result.failed
Running tests.......
<<<test_start>>>
tag=broken_ip4-version stime=278
cmdline="broken_ip4-version"
contacts=""
analysis=exit
<<<test_output>>>
broken_ip4-version01    0  TINFO  :  Verify that the kernel is not crashed
with receiving a large number of IPv4 packets that have wrong value in
version field.
broken_ip4-version01    0  TINFO  :  - Test duration is 3600 [sec]
cut: option requires an argument -- 'f'
Try `cut --help' for more information.
HWaddr list () is something wrong.
broken_ip4-version01    1  TBROK  :  Failed to get the interface name at the
remote host
<<<execution_status>>>
initiation_status="ok"
duration=1 termination_type=exited termination_id=1 corefile=no
cutime=8 cstime=19
<<<test_end>>>
<<<test_start>>>
tag=broken_ip4-ihl stime=279
cmdline="broken_ip4-ihl"
contacts=""
analysis=exit
<<<test_output>>>
broken_ip4-ihl01    0  TINFO  :  Verify that the kernel is not crashed with
receiving a large number of IPv4 packets that have wrong value in the header
length field.
broken_ip4-ihl01    0  TINFO  :  - Test duration is 3600 [sec]
cut: option requires an argument -- 'f'
Try `cut --help' for more information.
HWaddr list () is something wrong.
broken_ip4-ihl01    1  TBROK  :  Failed to get the interface name at the
remote host
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=11 cstime=21
<<<test_end>>>
<<<test_start>>>
tag=broken_ip4-totlen stime=279
cmdline="broken_ip4-totlen"
contacts=""
analysis=exit
<<<test_output>>>
broken_ip4-totlen01    0  TINFO  :  Verify that the kernel is not crashed
with receiving a large number of IPv4 packets that have wrong value in the
total length field.
broken_ip4-totlen01    0  TINFO  :  - Test duration is 3600 [sec]
cut: option requires an argument -- 'f'
Try `cut --help' for more information.
HWaddr list () is something wrong.
broken_ip4-totlen01    1  TBROK  :  Failed to get the interface name at the
remote host
<<<execution_status>>>
initiation_status="ok"
duration=1 termination_type=exited termination_id=1 corefile=no
cutime=10 cstime=24
<<<test_end>>>
<<<test_start>>>
tag=broken_ip4-fragment stime=280
cmdline="broken_ip4-fragment"
contacts=""
analysis=exit
<<<test_output>>>
broken_ip4-fragment01    0  TINFO  :  Verify that the kernel is not crashed
with receiving a large number of IPv4 packets that have wrong fragment
information
broken_ip4-fragment01    0  TINFO  :  - Test duration is 3600 [sec]
cut: option requires an argument -- 'f'
Try `cut --help' for more information.
HWaddr list () is something wrong.
broken_ip4-fragment01    1  TBROK  :  Failed to get the interface name at
the remote host
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=11 cstime=14
<<<test_end>>>
<<<test_start>>>
tag=broken_ip4-protcol stime=280
cmdline="broken_ip4-protcol"
contacts=""
analysis=exit
<<<test_output>>>
broken_ip4-protocol01    0  TINFO  :  Verify that the kernel is not crashed
with receiving a large number of IPv4 packets that have wrong value in the
protocol field
broken_ip4-protocol01    0  TINFO  :  - Test duration is 3600 [sec]
cut: option requires an argument -- 'f'
Try `cut --help' for more information.
HWaddr list () is something wrong.
broken_ip4-protocol01    1  TBROK  :  Failed to get the interface name at
the remote host
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=7 cstime=21
<<<test_end>>>
<<<test_start>>>
tag=broken_ip4-checksum stime=280
cmdline="broken_ip4-checksum"
contacts=""
analysis=exit
<<<test_output>>>
broken_ip4-checksum01    0  TINFO  :  Verify that the kernel is not crashed
with receiving a large number of IPv4 packets that have wrong value in the
checksum field
broken_ip4-checksum01    0  TINFO  :  - Test duration is 3600 [sec]
cut: option requires an argument -- 'f'
Try `cut --help' for more information.
HWaddr list () is something wrong.
broken_ip4-checksum01    1  TBROK  :  Failed to get the interface name at
the remote host
<<<execution_status>>>
initiation_status="ok"
duration=1 termination_type=exited termination_id=1 corefile=no
cutime=6 cstime=22
<<<test_end>>>
<<<test_start>>>
tag=broken_ip4-dstaddr stime=281
cmdline="broken_ip4-dstaddr"
contacts=""
analysis=exit
<<<test_output>>>
broken_ip4-dstaddr01    0  TINFO  :  Verify that the kernel is not crashed
with receiving a large number of IPv4 packets whose destination address is
wrong (destination MAC address is correct)
broken_ip4-dstaddr01    0  TINFO  :  - Test duration is 3600 [sec]
cut: option requires an argument -- 'f'
Try `cut --help' for more information.
HWaddr list () is something wrong.
broken_ip4-dstaddr01    1  TBROK  :  Failed to get the interface name at the
remote host
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=9 cstime=18
<<<test_end>>>
<<<test_start>>>
tag=broken_ip6-dstaddr stime=281
cmdline="broken_ip6-dstaddr"
contacts=""
analysis=exit
<<<test_output>>>
broken_ip6-dstaddr01    0  TINFO  :  Verify that the kernel is not crashed
with receiving a large number of IPv6 packets whose destination address is
wrong (destination MAC address is correct)
broken_ip6-dstaddr01    0  TINFO  :  - Test duration is 3600 [sec]
cut: option requires an argument -- 'f'
Try `cut --help' for more information.
HWaddr list () is something wrong.
broken_ip6-dstaddr01    1  TBROK  :  Failed to get the interface name at the
remote host
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=6 cstime=20
<<<test_end>>>
<<<test_start>>>
tag=broken_ip6-nexthdr stime=281
cmdline="broken_ip6-nexthdr"
contacts=""
analysis=exit
<<<test_output>>>
broken_ip6-nexthdr01    0  TINFO  :  Verify that the kernel is not crashed
with receiving a large number of IPv6 packets that have wrong value in the
next header field.
broken_ip6-nexthdr01    0  TINFO  :  - Test duration is 3600 [sec]
cut: option requires an argument -- 'f'
Try `cut --help' for more information.
HWaddr list () is something wrong.
broken_ip6-nexthdr01    1  TBROK  :  Failed to get the interface name at the
remote host
<<<execution_status>>>
initiation_status="ok"
duration=1 termination_type=exited termination_id=1 corefile=no
cutime=6 cstime=18
<<<test_end>>>
<<<test_start>>>
tag=broken_ip6-plen stime=282
cmdline="broken_ip6-plen"
contacts=""
analysis=exit
<<<test_output>>>
broken_ip6-plen01    0  TINFO  :  Verify that the kernel is not crashed with
receiving a large number of IPv6 packets that have wrong value in the
payload length field.
broken_ip6-plen01    0  TINFO  :  - Test duration is 3600 [sec]
cut: option requires an argument -- 'f'
Try `cut --help' for more information.
HWaddr list () is something wrong.
broken_ip6-plen01    1  TBROK  :  Failed to get the interface name at the
remote host
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=5 cstime=23
<<<test_end>>>
<<<test_start>>>
tag=broken_ip6-version stime=282
cmdline="broken_ip6-version"
contacts=""
analysis=exit
<<<test_output>>>
broken_ip6-version01    0  TINFO  :  Verify that the kernel is not crashed
with receiving a large number of IPv6 packets that have wrong value in
version field.
broken_ip6-version01    0  TINFO  :  - Test duration is 3600 [sec]
cut: option requires an argument -- 'f'
Try `cut --help' for more information.
HWaddr list () is something wrong.
broken_ip6-version01    1  TBROK  :  Failed to get the interface name at the
remote host
incrementing stop
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=11 cstime=22
<<<test_end>>>
INFO: ltp-pan reported some tests FAIL
LTP Version: LTP-20100131

       ###############################################################"

            Done executing testcases."
            LTP Version:  LTP-20100131
       ###############################################################"









On Tue, Nov 9, 2010 at 2:16 PM, ARJIT SHARMA <joyarjit@gmail.com> wrote:

> Hi Garrett,
>
>                  As i am running LTP on embedded system ie. on the board
> through network file system(NFS).
>
>                  I have ARM architechture and STlinux-2.4 Distribution.
>
>                 so, i cannot give remote acess of my environment, and these
> tests are very important to execute, i tried with many changes for these
> tests, but cant get a way out.
>
>                 Although i can send u log of the testcase.
>
>                 please suggest me some way to resolve this problem.
> --
> Best Regards,
> Arjit Sharma.
>
>


-- 
Best Regards,
Arjit Sharma.

--0016364d236dade2a70494abca47
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>HI,</div>
<div align=3D"right">=A0</div>
<div>=A0=A0=A0=A0=A0 here i am sending the log of the problem so that you c=
an sugggest some method to=A0solve this issue.<br></div>
<div>=A0</div>
<div>=A0</div>
<div>=A0</div>
<div>=A0</div>
<div>INFO: creating /opt/ltp/results directory<br>If some fields are empty =
or look unusual you may have an old version.<br>Compare to the current mini=
mal requirements in Documentation/Changes.<br>=A0<br>STMicroelectronics Bas=
e Distribution 2.4<br>
Linux 192.168.1.10 2.6.32 #2 SMP Tue Oct 19 17:34:35 IST 2010 armv7l unknow=
n unknown GNU/Linux<br>=A0<br>Gnu C=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 gcc (GCC) 4.5.0<br>Gnu make=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 3.81<br>util-linux=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ng 2.16.1)=
<br>mount=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ng 2.16.1 (wit=
h libblkid support)<br>
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
=A0=A0=A0=A0 cached<br>Mem:=A0=A0=A0=A0=A0=A0=A0 255368=A0=A0=A0=A0=A0 2063=
2=A0=A0=A0=A0 234736=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0=A0=A0=A0=A0=A0 10948<br>-/+ buffers/cache:=A0=A0=A0=A0=A0=A0 9684=A0=
=A0=A0=A0 245684<br>
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
-e -S=A0=A0 -a 1241=A0=A0=A0=A0 -n 1241=A0 -p=A0 -f /tmp/ltp-HcxbKw1247/all=
tests -l /opt/ltp/results/network_stress.broken_ip.result=A0 -C /opt/ltp/ou=
tput/LTP_RUN_ON-network_stress.broken_ip.result.failed<br>
LOG File: /opt/ltp/results/network_stress.broken_ip.result<br>FAILED COMMAN=
D File: /opt/ltp/output/LTP_RUN_ON-network_stress.broken_ip.result.failed<b=
r>Running tests.......<br>&lt;&lt;&lt;test_start&gt;&gt;&gt;<br>tag=3Dbroke=
n_ip4-version stime=3D278<br>
cmdline=3D&quot;broken_ip4-version&quot;<br>contacts=3D&quot;&quot;<br>anal=
ysis=3Dexit<br>&lt;&lt;&lt;test_output&gt;&gt;&gt;<br>broken_ip4-version01=
=A0=A0=A0 0=A0 TINFO=A0 :=A0 Verify that the kernel is not crashed with rec=
eiving a large number of IPv4 packets that have wrong value in version fiel=
d.<br>
broken_ip4-version01=A0=A0=A0 0=A0 TINFO=A0 :=A0 - Test duration is 3600 [s=
ec]<br>cut: option requires an argument -- &#39;f&#39;<br>Try `cut --help&#=
39; for more information.<br>HWaddr list () is something wrong.<br>broken_i=
p4-version01=A0=A0=A0 1=A0 TBROK=A0 :=A0 Failed to get the interface name a=
t the remote host<br>
&lt;&lt;&lt;execution_status&gt;&gt;&gt;<br>initiation_status=3D&quot;ok&qu=
ot;<br>duration=3D1 termination_type=3Dexited termination_id=3D1 corefile=
=3Dno<br>cutime=3D8 cstime=3D19<br>&lt;&lt;&lt;test_end&gt;&gt;&gt;<br>&lt;=
&lt;&lt;test_start&gt;&gt;&gt;<br>
tag=3Dbroken_ip4-ihl stime=3D279<br>cmdline=3D&quot;broken_ip4-ihl&quot;<br=
>contacts=3D&quot;&quot;<br>analysis=3Dexit<br>&lt;&lt;&lt;test_output&gt;&=
gt;&gt;<br>broken_ip4-ihl01=A0=A0=A0 0=A0 TINFO=A0 :=A0 Verify that the ker=
nel is not crashed with receiving a large number of IPv4 packets that have =
wrong value in the header length field.<br>
broken_ip4-ihl01=A0=A0=A0 0=A0 TINFO=A0 :=A0 - Test duration is 3600 [sec]<=
br>cut: option requires an argument -- &#39;f&#39;<br>Try `cut --help&#39; =
for more information.<br>HWaddr list () is something wrong.<br>broken_ip4-i=
hl01=A0=A0=A0 1=A0 TBROK=A0 :=A0 Failed to get the interface name at the re=
mote host<br>
&lt;&lt;&lt;execution_status&gt;&gt;&gt;<br>initiation_status=3D&quot;ok&qu=
ot;<br>duration=3D0 termination_type=3Dexited termination_id=3D1 corefile=
=3Dno<br>cutime=3D11 cstime=3D21<br>&lt;&lt;&lt;test_end&gt;&gt;&gt;<br>&lt=
;&lt;&lt;test_start&gt;&gt;&gt;<br>
tag=3Dbroken_ip4-totlen stime=3D279<br>cmdline=3D&quot;broken_ip4-totlen&qu=
ot;<br>contacts=3D&quot;&quot;<br>analysis=3Dexit<br>&lt;&lt;&lt;test_outpu=
t&gt;&gt;&gt;<br>broken_ip4-totlen01=A0=A0=A0 0=A0 TINFO=A0 :=A0 Verify tha=
t the kernel is not crashed with receiving a large number of IPv4 packets t=
hat have wrong value in the total length field.<br>
broken_ip4-totlen01=A0=A0=A0 0=A0 TINFO=A0 :=A0 - Test duration is 3600 [se=
c]<br>cut: option requires an argument -- &#39;f&#39;<br>Try `cut --help&#3=
9; for more information.<br>HWaddr list () is something wrong.<br>broken_ip=
4-totlen01=A0=A0=A0 1=A0 TBROK=A0 :=A0 Failed to get the interface name at =
the remote host<br>
&lt;&lt;&lt;execution_status&gt;&gt;&gt;<br>initiation_status=3D&quot;ok&qu=
ot;<br>duration=3D1 termination_type=3Dexited termination_id=3D1 corefile=
=3Dno<br>cutime=3D10 cstime=3D24<br>&lt;&lt;&lt;test_end&gt;&gt;&gt;<br>&lt=
;&lt;&lt;test_start&gt;&gt;&gt;<br>
tag=3Dbroken_ip4-fragment stime=3D280<br>cmdline=3D&quot;broken_ip4-fragmen=
t&quot;<br>contacts=3D&quot;&quot;<br>analysis=3Dexit<br>&lt;&lt;&lt;test_o=
utput&gt;&gt;&gt;<br>broken_ip4-fragment01=A0=A0=A0 0=A0 TINFO=A0 :=A0 Veri=
fy that the kernel is not crashed with receiving a large number of IPv4 pac=
kets that have wrong fragment information<br>
broken_ip4-fragment01=A0=A0=A0 0=A0 TINFO=A0 :=A0 - Test duration is 3600 [=
sec]<br>cut: option requires an argument -- &#39;f&#39;<br>Try `cut --help&=
#39; for more information.<br>HWaddr list () is something wrong.<br>broken_=
ip4-fragment01=A0=A0=A0 1=A0 TBROK=A0 :=A0 Failed to get the interface name=
 at the remote host<br>
&lt;&lt;&lt;execution_status&gt;&gt;&gt;<br>initiation_status=3D&quot;ok&qu=
ot;<br>duration=3D0 termination_type=3Dexited termination_id=3D1 corefile=
=3Dno<br>cutime=3D11 cstime=3D14<br>&lt;&lt;&lt;test_end&gt;&gt;&gt;<br>&lt=
;&lt;&lt;test_start&gt;&gt;&gt;<br>
tag=3Dbroken_ip4-protcol stime=3D280<br>cmdline=3D&quot;broken_ip4-protcol&=
quot;<br>contacts=3D&quot;&quot;<br>analysis=3Dexit<br>&lt;&lt;&lt;test_out=
put&gt;&gt;&gt;<br>broken_ip4-protocol01=A0=A0=A0 0=A0 TINFO=A0 :=A0 Verify=
 that the kernel is not crashed with receiving a large number of IPv4 packe=
ts that have wrong value in the protocol field<br>
broken_ip4-protocol01=A0=A0=A0 0=A0 TINFO=A0 :=A0 - Test duration is 3600 [=
sec]<br>cut: option requires an argument -- &#39;f&#39;<br>Try `cut --help&=
#39; for more information.<br>HWaddr list () is something wrong.<br>broken_=
ip4-protocol01=A0=A0=A0 1=A0 TBROK=A0 :=A0 Failed to get the interface name=
 at the remote host<br>
&lt;&lt;&lt;execution_status&gt;&gt;&gt;<br>initiation_status=3D&quot;ok&qu=
ot;<br>duration=3D0 termination_type=3Dexited termination_id=3D1 corefile=
=3Dno<br>cutime=3D7 cstime=3D21<br>&lt;&lt;&lt;test_end&gt;&gt;&gt;<br>&lt;=
&lt;&lt;test_start&gt;&gt;&gt;<br>
tag=3Dbroken_ip4-checksum stime=3D280<br>cmdline=3D&quot;broken_ip4-checksu=
m&quot;<br>contacts=3D&quot;&quot;<br>analysis=3Dexit<br>&lt;&lt;&lt;test_o=
utput&gt;&gt;&gt;<br>broken_ip4-checksum01=A0=A0=A0 0=A0 TINFO=A0 :=A0 Veri=
fy that the kernel is not crashed with receiving a large number of IPv4 pac=
kets that have wrong value in the checksum field<br>
broken_ip4-checksum01=A0=A0=A0 0=A0 TINFO=A0 :=A0 - Test duration is 3600 [=
sec]<br>cut: option requires an argument -- &#39;f&#39;<br>Try `cut --help&=
#39; for more information.<br>HWaddr list () is something wrong.<br>broken_=
ip4-checksum01=A0=A0=A0 1=A0 TBROK=A0 :=A0 Failed to get the interface name=
 at the remote host<br>
&lt;&lt;&lt;execution_status&gt;&gt;&gt;<br>initiation_status=3D&quot;ok&qu=
ot;<br>duration=3D1 termination_type=3Dexited termination_id=3D1 corefile=
=3Dno<br>cutime=3D6 cstime=3D22<br>&lt;&lt;&lt;test_end&gt;&gt;&gt;<br>&lt;=
&lt;&lt;test_start&gt;&gt;&gt;<br>
tag=3Dbroken_ip4-dstaddr stime=3D281<br>cmdline=3D&quot;broken_ip4-dstaddr&=
quot;<br>contacts=3D&quot;&quot;<br>analysis=3Dexit<br>&lt;&lt;&lt;test_out=
put&gt;&gt;&gt;<br>broken_ip4-dstaddr01=A0=A0=A0 0=A0 TINFO=A0 :=A0 Verify =
that the kernel is not crashed with receiving a large number of IPv4 packet=
s whose destination address is wrong (destination MAC address is correct)<b=
r>
broken_ip4-dstaddr01=A0=A0=A0 0=A0 TINFO=A0 :=A0 - Test duration is 3600 [s=
ec]<br>cut: option requires an argument -- &#39;f&#39;<br>Try `cut --help&#=
39; for more information.<br>HWaddr list () is something wrong.<br>broken_i=
p4-dstaddr01=A0=A0=A0 1=A0 TBROK=A0 :=A0 Failed to get the interface name a=
t the remote host<br>
&lt;&lt;&lt;execution_status&gt;&gt;&gt;<br>initiation_status=3D&quot;ok&qu=
ot;<br>duration=3D0 termination_type=3Dexited termination_id=3D1 corefile=
=3Dno<br>cutime=3D9 cstime=3D18<br>&lt;&lt;&lt;test_end&gt;&gt;&gt;<br>&lt;=
&lt;&lt;test_start&gt;&gt;&gt;<br>
tag=3Dbroken_ip6-dstaddr stime=3D281<br>cmdline=3D&quot;broken_ip6-dstaddr&=
quot;<br>contacts=3D&quot;&quot;<br>analysis=3Dexit<br>&lt;&lt;&lt;test_out=
put&gt;&gt;&gt;<br>broken_ip6-dstaddr01=A0=A0=A0 0=A0 TINFO=A0 :=A0 Verify =
that the kernel is not crashed with receiving a large number of IPv6 packet=
s whose destination address is wrong (destination MAC address is correct)<b=
r>
broken_ip6-dstaddr01=A0=A0=A0 0=A0 TINFO=A0 :=A0 - Test duration is 3600 [s=
ec]<br>cut: option requires an argument -- &#39;f&#39;<br>Try `cut --help&#=
39; for more information.<br>HWaddr list () is something wrong.<br>broken_i=
p6-dstaddr01=A0=A0=A0 1=A0 TBROK=A0 :=A0 Failed to get the interface name a=
t the remote host<br>
&lt;&lt;&lt;execution_status&gt;&gt;&gt;<br>initiation_status=3D&quot;ok&qu=
ot;<br>duration=3D0 termination_type=3Dexited termination_id=3D1 corefile=
=3Dno<br>cutime=3D6 cstime=3D20<br>&lt;&lt;&lt;test_end&gt;&gt;&gt;<br>&lt;=
&lt;&lt;test_start&gt;&gt;&gt;<br>
tag=3Dbroken_ip6-nexthdr stime=3D281<br>cmdline=3D&quot;broken_ip6-nexthdr&=
quot;<br>contacts=3D&quot;&quot;<br>analysis=3Dexit<br>&lt;&lt;&lt;test_out=
put&gt;&gt;&gt;<br>broken_ip6-nexthdr01=A0=A0=A0 0=A0 TINFO=A0 :=A0 Verify =
that the kernel is not crashed with receiving a large number of IPv6 packet=
s that have wrong value in the next header field.<br>
broken_ip6-nexthdr01=A0=A0=A0 0=A0 TINFO=A0 :=A0 - Test duration is 3600 [s=
ec]<br>cut: option requires an argument -- &#39;f&#39;<br>Try `cut --help&#=
39; for more information.<br>HWaddr list () is something wrong.<br>broken_i=
p6-nexthdr01=A0=A0=A0 1=A0 TBROK=A0 :=A0 Failed to get the interface name a=
t the remote host<br>
&lt;&lt;&lt;execution_status&gt;&gt;&gt;<br>initiation_status=3D&quot;ok&qu=
ot;<br>duration=3D1 termination_type=3Dexited termination_id=3D1 corefile=
=3Dno<br>cutime=3D6 cstime=3D18<br>&lt;&lt;&lt;test_end&gt;&gt;&gt;<br>&lt;=
&lt;&lt;test_start&gt;&gt;&gt;<br>
tag=3Dbroken_ip6-plen stime=3D282<br>cmdline=3D&quot;broken_ip6-plen&quot;<=
br>contacts=3D&quot;&quot;<br>analysis=3Dexit<br>&lt;&lt;&lt;test_output&gt=
;&gt;&gt;<br>broken_ip6-plen01=A0=A0=A0 0=A0 TINFO=A0 :=A0 Verify that the =
kernel is not crashed with receiving a large number of IPv6 packets that ha=
ve wrong value in the payload length field.<br>
broken_ip6-plen01=A0=A0=A0 0=A0 TINFO=A0 :=A0 - Test duration is 3600 [sec]=
<br>cut: option requires an argument -- &#39;f&#39;<br>Try `cut --help&#39;=
 for more information.<br>HWaddr list () is something wrong.<br>broken_ip6-=
plen01=A0=A0=A0 1=A0 TBROK=A0 :=A0 Failed to get the interface name at the =
remote host<br>
&lt;&lt;&lt;execution_status&gt;&gt;&gt;<br>initiation_status=3D&quot;ok&qu=
ot;<br>duration=3D0 termination_type=3Dexited termination_id=3D1 corefile=
=3Dno<br>cutime=3D5 cstime=3D23<br>&lt;&lt;&lt;test_end&gt;&gt;&gt;<br>&lt;=
&lt;&lt;test_start&gt;&gt;&gt;<br>
tag=3Dbroken_ip6-version stime=3D282<br>cmdline=3D&quot;broken_ip6-version&=
quot;<br>contacts=3D&quot;&quot;<br>analysis=3Dexit<br>&lt;&lt;&lt;test_out=
put&gt;&gt;&gt;<br>broken_ip6-version01=A0=A0=A0 0=A0 TINFO=A0 :=A0 Verify =
that the kernel is not crashed with receiving a large number of IPv6 packet=
s that have wrong value in version field.<br>
broken_ip6-version01=A0=A0=A0 0=A0 TINFO=A0 :=A0 - Test duration is 3600 [s=
ec]<br>cut: option requires an argument -- &#39;f&#39;<br>Try `cut --help&#=
39; for more information.<br>HWaddr list () is something wrong.<br>broken_i=
p6-version01=A0=A0=A0 1=A0 TBROK=A0 :=A0 Failed to get the interface name a=
t the remote host<br>
incrementing stop<br>&lt;&lt;&lt;execution_status&gt;&gt;&gt;<br>initiation=
_status=3D&quot;ok&quot;<br>duration=3D0 termination_type=3Dexited terminat=
ion_id=3D1 corefile=3Dno<br>cutime=3D11 cstime=3D22<br>&lt;&lt;&lt;test_end=
&gt;&gt;&gt;<br>
INFO: ltp-pan reported some tests FAIL<br>LTP Version: LTP-20100131<br>=A0=
=A0=A0=A0=A0=A0=A0 <br>=A0=A0=A0=A0=A0=A0 #################################=
##############################&quot;<br>=A0=A0=A0=A0=A0=A0=A0 <br>=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 Done executing testcases.&quot;<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 LTP Version:=A0 LTP-20100131<br>=A0=A0=A0=
=A0=A0=A0 ###############################################################&q=
uot;<br>=A0=A0=A0=A0=A0=A0 <br></div>
<div>=A0</div>
<div>=A0</div>
<div>=A0</div>
<div>=A0</div>
<div>=A0</div>
<div>=A0</div>
<div><br>=A0</div>
<div class=3D"gmail_quote">On Tue, Nov 9, 2010 at 2:16 PM, ARJIT SHARMA <sp=
an dir=3D"ltr">&lt;<a href=3D"mailto:joyarjit@gmail.com">joyarjit@gmail.com=
</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div>Hi Garrett,</div>
<div>=A0</div>
<div>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 As i am running LTP o=
n embedded system ie. on the board through network file system(NFS).</div>
<div>=A0</div>
<div>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 I have=A0ARM architec=
hture and STlinux-2.4 Distribution.</div>
<div>=A0</div>
<div>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 so, i cannot give remote=
 acess of my environment, and these tests are very important to execute, i =
tried with many changes for these tests, but cant get a way out.</div>
<div>=A0</div>
<div>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Although i can send u lo=
g of the testcase.</div>
<div>=A0</div>
<div>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 please suggest me=A0some=
 way to resolve this problem.<br>-- <br></div>
<div>Best Regards,</div>
<div>Arjit Sharma.</div><font color=3D"#888888"><br></font></blockquote></d=
iv><br><br clear=3D"all"><br>-- <br>
<div>Best Regards,</div>
<div>Arjit Sharma.</div><br>

--0016364d236dade2a70494abca47--


--===============6256108783090132621==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
The Next 800 Companies to Lead America's Growth: New Video Whitepaper
David G. Thomson, author of the best-selling book "Blueprint to a 
Billion" shares his insights and actions to help propel your 
business during the next growth cycle. Listen Now!
http://p.sf.net/sfu/SAP-dev2dev
--===============6256108783090132621==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============6256108783090132621==--

