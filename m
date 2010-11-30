Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <joyarjit@gmail.com>) id 1PNIqp-0003zs-5q
	for ltp-list@lists.sourceforge.net; Tue, 30 Nov 2010 05:34:03 +0000
Received: from mail-wy0-f175.google.com ([74.125.82.175])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PNIqn-0002o4-14
	for ltp-list@lists.sourceforge.net; Tue, 30 Nov 2010 05:34:03 +0000
Received: by wyb40 with SMTP id 40so5150526wyb.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 29 Nov 2010 21:33:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20101129133724.GA4065@hallyn.com>
References: <AANLkTinw1Yc+QGtMuKH=xep4VGjusBdO2+mQeQhmM15K@mail.gmail.com>
	<20101129133724.GA4065@hallyn.com>
Date: Tue, 30 Nov 2010 11:03:55 +0530
Message-ID: <AANLkTimLXaH_mRJ7xxfj93RJt6wPEcheC3Mg6nONkSq4@mail.gmail.com>
From: ARJIT SHARMA <joyarjit@gmail.com>
Subject: Re: [LTP] networkstress tests
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2064347530108779441=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: "Serge E. Hallyn" <serge.hallyn@canonical.com>, ltp-list@lists.sourceforge.net, Garrett Cooper <yanegomi@gmail.com>
Cc: ajay.khandelwal@st.com

--===============2064347530108779441==
Content-Type: multipart/alternative; boundary=001485f775b2dd2ef404963e886c

--001485f775b2dd2ef404963e886c
Content-Type: text/plain; charset=ISO-8859-1

Actually Network related tests are failing, like :--

network_stress.broken_ip

network_stress.icmp

network_stress.interface

network_stress.multicast

network_stress.tcp



here I am sending you the log of "network_stress.broken.ip" testcase...
similar error is come in all the above mentioned tests
"TBROK: Failed to get the interface name at the remote host.".





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




On Mon, Nov 29, 2010 at 7:07 PM, Serge E. Hallyn <serge.hallyn@canonical.com
> wrote:

>  Quoting ARJIT SHARMA (joyarjit@gmail.com):
> >  Hi,
> >
> >       I was trying to run network stress tests on my side, but none of
> them
> > is passing.
> >
> >       it is not able to find the harware address at remote host, altough
> the
> > settings and configurations are as required and as mentioned in README
> and
> > INSTALL files.
> >
> >       So can u please tell me that whether these stress tests are meant
> to
> > be run on embedded boards, do they always cause problems, if u have
> executed
> > them?
>
> Which tests exactly are failing?  (You say network stress tests, but cc:d
> me implying you meant netns netsts)  Can you send us the relevant logs?
>



-- 
Best Regards,
Arjit Sharma.

--001485f775b2dd2ef404963e886c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Actually Network related tests are failing, like :--</div>
<div>=A0</div>
<div>network_stress.broken_ip</div>
<div>=A0</div>
<div>network_stress.icmp</div>
<div>=A0</div>
<div>network_stress.interface</div>
<div>=A0</div>
<div>network_stress.multicast</div>
<div>=A0</div>
<div>network_stress.tcp</div>
<div>=A0</div>
<div>=A0</div>
<div><br>here I am sending you the log of &quot;network_stress.broken.ip&qu=
ot; testcase...</div>
<div>similar error is come in all the above mentioned tests=A0 </div>
<div>&quot;TBROK: Failed to get the interface name at the remote host.&quot=
;.</div>
<div>=A0</div>
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
<div><br>=A0</div>
<div class=3D"gmail_quote">On Mon, Nov 29, 2010 at 7:07 PM, Serge E. Hallyn=
 <span dir=3D"ltr">&lt;<a href=3D"mailto:serge.hallyn@canonical.com" target=
=3D"_blank">serge.hallyn@canonical.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div>
<div></div>
<div>Quoting ARJIT SHARMA (<a href=3D"mailto:joyarjit@gmail.com" target=3D"=
_blank">joyarjit@gmail.com</a>):<br>&gt; =A0Hi,<br>&gt;<br>&gt; =A0 =A0 =A0=
 I was trying to run network stress tests on my side, but none of them<br>&=
gt; is passing.<br>
&gt;<br>&gt; =A0 =A0 =A0 it is not able to find the harware address at remo=
te host, altough the<br>&gt; settings and configurations are as required an=
d as mentioned in README and<br>&gt; INSTALL files.<br>&gt;<br>&gt; =A0 =A0=
 =A0 So can u please tell me that whether these stress tests are meant to<b=
r>
&gt; be run on embedded boards, do they always cause problems, if u have ex=
ecuted<br>&gt; them?<br><br></div></div>Which tests exactly are failing? =
=A0(You say network stress tests, but cc:d<br>me implying you meant netns n=
etsts) =A0Can you send us the relevant logs?<br>
</blockquote></div><br><br clear=3D"all"><br>-- <br>
<div>Best Regards,</div>
<div>Arjit Sharma.</div><br>

--001485f775b2dd2ef404963e886c--


--===============2064347530108779441==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Increase Visibility of Your 3D Game App & Earn a Chance To Win $500!
Tap into the largest installed PC base & get more eyes on your game by
optimizing for Intel(R) Graphics Technology. Get started today with the
Intel(R) Software Partner Program. Five $500 cash prizes are up for grabs.
http://p.sf.net/sfu/intelisp-dev2dev
--===============2064347530108779441==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============2064347530108779441==--

