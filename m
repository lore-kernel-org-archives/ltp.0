Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <joyarjit@gmail.com>) id 1P1AGY-00021g-Gg
	for ltp-list@lists.sourceforge.net; Thu, 30 Sep 2010 03:57:06 +0000
Received: from mail-ww0-f53.google.com ([74.125.82.53])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1P1AGW-0004vM-Pm
	for ltp-list@lists.sourceforge.net; Thu, 30 Sep 2010 03:57:06 +0000
Received: by wwi18 with SMTP id 18so30873wwi.10
	for <ltp-list@lists.sourceforge.net>;
	Wed, 29 Sep 2010 20:56:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100929174258.GA4493@hannu-ubuntu>
References: <AANLkTinH_rH7iU4efFX8Bw9PUU_5DgMwR3q6p-bMZrOp@mail.gmail.com>
	<AANLkTin18VbZ7bO6++nPd_Fz1J4FHQRn4akkqTDLYeT5@mail.gmail.com>
	<20100929174258.GA4493@hannu-ubuntu>
Date: Thu, 30 Sep 2010 09:26:55 +0530
Message-ID: <AANLkTi=8QDOYT9bR+aQSWcDdMRvUx+FbqydU-CD-3Zpb@mail.gmail.com>
From: ARJIT SHARMA <joyarjit@gmail.com>
Subject: Re: [LTP] LHOST_HWADDR
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4257293672943464139=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============4257293672943464139==
Content-Type: multipart/alternative; boundary=0016364d281fad9221049172111c

--0016364d281fad9221049172111c
Content-Type: text/plain; charset=ISO-8859-1

Thanxxx.....  Hannu....

i'll try it, wheather these network stress cases pass on my architechture or
not......

On Wed, Sep 29, 2010 at 11:12 PM, Hannu Heikkinen <hannuxx@iki.fi> wrote:

> Hi,
>
> Sorry about top posting, but I just briefly mention that please read
> <ltp-source-dir>/testcases/network/stress/README file. U have to setup
> values
> for RHOST etc env vars found in testscripts/networkstress.sh.
>
> br,
> Hannu
>
> On 28/09/10 10:09 +0530, ARJIT SHARMA wrote:
> > Hi
> >
> >      During the execution of network related tests i am getting the error
> as
> > "environment variable LHOST_HWADDR not set"
> >      i tried solving this problem even by given static hwaddr in the
> > testscript "networkstress.sh" but same error is coming.
> >      i am runnning LTP on armv7 architechture.
> >      Here i am also sending you the log file, please help me out to solve
> > this problem.
> >
> >
> >                  INFO: creating /opt/ltp/results directory
> > If some fields are empty or look unusual you may have an old version.
> > Compare to the current minimal requirements in Documentation/Changes.
> >
> > Linux 192.168.1.10 2.6.32 #2 SMP Fri Aug 27 12:31:08 IST 2010 armv7l
> unknown
> > unknown GNU/Linux
> >
> > Gnu C                  gcc (GCC) 4.5.0
> > Gnu make               3.81
> > util-linux             ng 2.16.1)
> > mount                  ng 2.16.1 (with libblkid support)
> > modutils               3.1
> > e2fsprogs              1.41.9
> > PPP                    2.4.4
> > Linux C Library        2.10.1
> > Dynamic linker (ldd)   2.10.1
> > Linux C++ Library      6.0.14
> > Procps                 3.2.7
> > Net-tools              1.60
> > iproute2              iproute2-ss100224
> > Console-tools          0.2.3
> > Sh-utils               5.2.1
> > Modules Loaded
> > free reports:
> >              total       used       free     shared    buffers     cached
> > Mem:        255556      24508     231048          0          0      14620
> > -/+ buffers/cache:       9888     245668
> > Swap:            0          0          0
> > /proc/cpuinfo
> > Processor : ARMv7 Processor rev 1 (v7l)
> > processor : 0
> > BogoMIPS : 996.14
> > processor : 1
> > BogoMIPS : 996.14
> > Features : swp half thumb fastmult vfp edsp vfpv3 vfpv3d16
> > CPU implementer : 0x41
> > CPU architecture: 7
> > CPU variant : 0x1
> > CPU part : 0xc09
> > CPU revision : 1
> > Hardware : ST-SPEAR1300-EVB
> > Revision : 0000
> > Serial  : 0000000000000000
> > remove test cases which require the block device.
> > You can specify it with option -b
> > COMMAND:    /opt/ltp/bin/ltp-pan  -e -S   -a 12621     -n 12621  -p  -f
> > /tmp/ltp-isNlo12627/alltests -l
> > /opt/ltp/results/network_stress.broken_ip.result  -C
> > /opt/ltp/output/LTP_RUN_ON-network_stress.broken_ip.result.failed
> > LOG File: /opt/ltp/results/network_stress.broken_ip.result
> > FAILED COMMAND File:
> > /opt/ltp/output/LTP_RUN_ON-network_stress.broken_ip.result.failed
> > Running tests.......
> > <<<test_start>>>
> > tag=broken_ip4-version stime=351622598
> > cmdline="broken_ip4-version"
> > contacts=""
> > analysis=exit
> > <<<test_output>>>
> > broken_ip4-version01    0  TINFO  :  Verify that the kernel is not
> crashed
> > with receiving a large number of IPv4 packets that have wrong value in
> > version field.
> > broken_ip4-version01    1  TBROK  :  Environment variable LHOST_HWADDRS
> is
> > not set.
> > <<<execution_status>>>
> > initiation_status="ok"
> > duration=0 termination_type=exited termination_id=1 corefile=no
> > cutime=3 cstime=10
> > <<<test_end>>>
> > <<<test_start>>>
> > tag=broken_ip4-ihl stime=351622598
> > cmdline="broken_ip4-ihl"
> > contacts=""
> > analysis=exit
> > <<<test_output>>>
> > broken_ip4-ihl01    0  TINFO  :  Verify that the kernel is not crashed
> with
> > receiving a large number of IPv4 packets that have wrong value in the
> header
> > length field.
> > broken_ip4-ihl01    1  TBROK  :  Environment variable LHOST_HWADDRS is
> not
> > set.
> > <<<execution_status>>>
> > initiation_status="ok"
> > duration=0 termination_type=exited termination_id=1 corefile=no
> > cutime=3 cstime=7
> > <<<test_end>>>
> > <<<test_start>>>
> > tag=broken_ip4-totlen stime=351622598
> > cmdline="broken_ip4-totlen"
> > contacts=""
> > analysis=exit
> > <<<test_output>>>
> > broken_ip4-totlen01    0  TINFO  :  Verify that the kernel is not crashed
> > with receiving a large number of IPv4 packets that have wrong value in
> the
> > total length field.
> > broken_ip4-totlen01    1  TBROK  :  Environment variable LHOST_HWADDRS is
> > not set.
> > <<<execution_status>>>
> > initiation_status="ok"
> > duration=0 termination_type=exited termination_id=1 corefile=no
> > cutime=7 cstime=5
> > <<<test_end>>>
> > <<<test_start>>>
> > tag=broken_ip4-fragment stime=351622598
> > cmdline="broken_ip4-fragment"
> > contacts=""
> > analysis=exit
> > <<<test_output>>>
> > broken_ip4-fragment01    0  TINFO  :  Verify that the kernel is not
> crashed
> > with receiving a large number of IPv4 packets that have wrong fragment
> > information
> > broken_ip4-fragment01    1  TBROK  :  Environment variable LHOST_HWADDRS
> is
> > not set.
> > <<<execution_status>>>
> > initiation_status="ok"
> > duration=0 termination_type=exited termination_id=1 corefile=no
> > cutime=2 cstime=13
> > <<<test_end>>>
> > <<<test_start>>>
> > tag=broken_ip4-protcol stime=351622598
> > cmdline="broken_ip4-protcol"
> > contacts=""
> > analysis=exit
> > <<<test_output>>>
> > broken_ip4-protocol01    0  TINFO  :  Verify that the kernel is not
> crashed
> > with receiving a large number of IPv4 packets that have wrong value in
> the
> > protocol field
> > broken_ip4-protocol01    1  TBROK  :  Environment variable LHOST_HWADDRS
> is
> > not set.
> > <<<execution_status>>>
> > initiation_status="ok"
> > duration=0 termination_type=exited termination_id=1 corefile=no
> > cutime=4 cstime=8
> > <<<test_end>>>
> > <<<test_start>>>
> > tag=broken_ip4-checksum stime=351622598
> > cmdline="broken_ip4-checksum"
> > contacts=""
> > analysis=exit
> > <<<test_output>>>
> > broken_ip4-checksum01    0  TINFO  :  Verify that the kernel is not
> crashed
> > with receiving a large number of IPv4 packets that have wrong value in
> the
> > checksum field
> > broken_ip4-checksum01    1  TBROK  :  Environment variable LHOST_HWADDRS
> is
> > not set.
> > <<<execution_status>>>
> > initiation_status="ok"
> > duration=0 termination_type=exited termination_id=1 corefile=no
> > cutime=5 cstime=7
> > <<<test_end>>>
> > <<<test_start>>>
> > tag=broken_ip4-dstaddr stime=351622598
> > cmdline="broken_ip4-dstaddr"
> > contacts=""
> > analysis=exit
> > <<<test_output>>>
> > broken_ip4-dstaddr01    0  TINFO  :  Verify that the kernel is not
> crashed
> > with receiving a large number of IPv4 packets whose destination address
> is
> > wrong (destination MAC address is correct)
> > broken_ip4-dstaddr01    1  TBROK  :  Environment variable LHOST_HWADDRS
> is
> > not set.
> > <<<execution_status>>>
> > initiation_status="ok"
> > duration=1 termination_type=exited termination_id=1 corefile=no
> > cutime=3 cstime=9
> > <<<test_end>>>
> > <<<test_start>>>
> > tag=broken_ip6-dstaddr stime=351622599
> > cmdline="broken_ip6-dstaddr"
> > contacts=""
> > analysis=exit
> > <<<test_output>>>
> > broken_ip6-dstaddr01    0  TINFO  :  Verify that the kernel is not
> crashed
> > with receiving a large number of IPv6 packets whose destination address
> is
> > wrong (destination MAC address is correct)
> > broken_ip6-dstaddr01    1  TBROK  :  Environment variable LHOST_HWADDRS
> is
> > not set.
> > <<<execution_status>>>
> > initiation_status="ok"
> > duration=0 termination_type=exited termination_id=1 corefile=no
> > cutime=1 cstime=12
> > <<<test_end>>>
> > <<<test_start>>>
> > tag=broken_ip6-nexthdr stime=351622599
> > cmdline="broken_ip6-nexthdr"
> > contacts=""
> > analysis=exit
> > <<<test_output>>>
> > broken_ip6-nexthdr01    0  TINFO  :  Verify that the kernel is not
> crashed
> > with receiving a large number of IPv6 packets that have wrong value in
> the
> > next header field.
> > broken_ip6-nexthdr01    1  TBROK  :  Environment variable LHOST_HWADDRS
> is
> > not set.
> > <<<execution_status>>>
> > initiation_status="ok"
> > duration=0 termination_type=exited termination_id=1 corefile=no
> > cutime=7 cstime=7
> > <<<test_end>>>
> > <<<test_start>>>
> > tag=broken_ip6-plen stime=351622599
> > cmdline="broken_ip6-plen"
> > contacts=""
> > analysis=exit
> > <<<test_output>>>
> > broken_ip6-plen01    0  TINFO  :  Verify that the kernel is not crashed
> with
> > receiving a large number of IPv6 packets that have wrong value in the
> > payload length field.
> > broken_ip6-plen01    1  TBROK  :  Environment variable LHOST_HWADDRS is
> not
> > set.
> > <<<execution_status>>>
> > initiation_status="ok"
> > duration=0 termination_type=exited termination_id=1 corefile=no
> > cutime=2 cstime=9
> > <<<test_end>>>
> > <<<test_start>>>
> > tag=broken_ip6-version stime=351622599
> > cmdline="broken_ip6-version"
> > contacts=""
> > analysis=exit
> > <<<test_output>>>
> > broken_ip6-version01    0  TINFO  :  Verify that the kernel is not
> crashed
> > with receiving a large number of IPv6 packets that have wrong value in
> > version field.
> > broken_ip6-version01    1  TBROK  :  Environment variable LHOST_HWADDRS
> is
> > not set.
> > incrementing stop
> > <<<execution_status>>>
> > initiation_status="ok"
> > duration=0 termination_type=exited termination_id=1 corefile=no
> > cutime=3 cstime=7
> > <<<test_end>>>
> > INFO: ltp-pan reported some tests FAIL
> > LTP Version: LTP-20100131
> >
> >        ###############################################################"
> >
> >             Done executing testcases."
> >             LTP Version:  LTP-20100131
> >        ###############################################################"
> >
> >
> >
> >
> > --
> > Regards,
> > Arjit Sharma.
>
> >
> ------------------------------------------------------------------------------
> > Start uncovering the many advantages of virtual appliances
> > and start using them to simplify application deployment and
> > accelerate your shift to cloud computing.
> > http://p.sf.net/sfu/novell-sfdev2dev
>
> > _______________________________________________
> > Ltp-list mailing list
> > Ltp-list@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/ltp-list
>
>


-- 
Regards,
Arjit Sharma.

--0016364d281fad9221049172111c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Thanxxx.....=A0 Hannu....</div>
<div>=A0</div>
<div>i&#39;ll try it, wheather these network stress cases pass on my archit=
echture or not......<br><br></div>
<div class=3D"gmail_quote">On Wed, Sep 29, 2010 at 11:12 PM, Hannu Heikkine=
n <span dir=3D"ltr">&lt;<a href=3D"mailto:hannuxx@iki.fi">hannuxx@iki.fi</a=
>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Hi,<br><br>Sorry about top posti=
ng, but I just briefly mention that please read<br>&lt;ltp-source-dir&gt;/t=
estcases/network/stress/README file. U have to setup values<br>
for RHOST etc env vars found in testscripts/networkstress.sh.<br><br>br,<br=
>Hannu<br>
<div>
<div></div>
<div class=3D"h5"><br>On 28/09/10 10:09 +0530, ARJIT SHARMA wrote:<br>&gt; =
Hi<br>&gt;<br>&gt; =A0 =A0 =A0During the execution of network related tests=
 i am getting the error as<br>&gt; &quot;environment variable LHOST_HWADDR =
not set&quot;<br>
&gt; =A0 =A0 =A0i tried solving this problem even by given static hwaddr in=
 the<br>&gt; testscript &quot;networkstress.sh&quot; but same error is comi=
ng.<br>&gt; =A0 =A0 =A0i am runnning LTP on armv7 architechture.<br>&gt; =
=A0 =A0 =A0Here i am also sending you the log file, please help me out to s=
olve<br>
&gt; this problem.<br>&gt;<br>&gt;<br>&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0INFO: creating /opt/ltp/results directory<br>&gt; If some fields are emp=
ty or look unusual you may have an old version.<br>&gt; Compare to the curr=
ent minimal requirements in Documentation/Changes.<br>
&gt;<br>&gt; Linux 192.168.1.10 2.6.32 #2 SMP Fri Aug 27 12:31:08 IST 2010 =
armv7l unknown<br>&gt; unknown GNU/Linux<br>&gt;<br>&gt; Gnu C =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0gcc (GCC) 4.5.0<br>&gt; Gnu make =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 3.81<br>&gt; util-linux =A0 =A0 =A0 =A0 =A0 =A0 ng 2.16.1)<br>
&gt; mount =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ng 2.16.1 (with libblkid supp=
ort)<br>&gt; modutils =A0 =A0 =A0 =A0 =A0 =A0 =A0 3.1<br>&gt; e2fsprogs =A0=
 =A0 =A0 =A0 =A0 =A0 =A01.41.9<br>&gt; PPP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A02.4.4<br>&gt; Linux C Library =A0 =A0 =A0 =A02.10.1<br>&gt; Dynamic =
linker (ldd) =A0 2.10.1<br>
&gt; Linux C++ Library =A0 =A0 =A06.0.14<br>&gt; Procps =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 3.2.7<br>&gt; Net-tools =A0 =A0 =A0 =A0 =A0 =A0 =A01.60<br>&gt=
; iproute2 =A0 =A0 =A0 =A0 =A0 =A0 =A0iproute2-ss100224<br>&gt; Console-too=
ls =A0 =A0 =A0 =A0 =A00.2.3<br>&gt; Sh-utils =A0 =A0 =A0 =A0 =A0 =A0 =A0 5.=
2.1<br>
&gt; Modules Loaded<br>&gt; free reports:<br>&gt; =A0 =A0 =A0 =A0 =A0 =A0 =
=A0total =A0 =A0 =A0 used =A0 =A0 =A0 free =A0 =A0 shared =A0 =A0buffers =
=A0 =A0 cached<br>&gt; Mem: =A0 =A0 =A0 =A0255556 =A0 =A0 =A024508 =A0 =A0 =
231048 =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A014620<br>&gt; -=
/+ buffers/cache: =A0 =A0 =A0 9888 =A0 =A0 245668<br>
&gt; Swap: =A0 =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =
=A00<br>&gt; /proc/cpuinfo<br>&gt; Processor : ARMv7 Processor rev 1 (v7l)<=
br>&gt; processor : 0<br>&gt; BogoMIPS : 996.14<br>&gt; processor : 1<br>&g=
t; BogoMIPS : 996.14<br>&gt; Features : swp half thumb fastmult vfp edsp vf=
pv3 vfpv3d16<br>
&gt; CPU implementer : 0x41<br>&gt; CPU architecture: 7<br>&gt; CPU variant=
 : 0x1<br>&gt; CPU part : 0xc09<br>&gt; CPU revision : 1<br>&gt; Hardware :=
 ST-SPEAR1300-EVB<br>&gt; Revision : 0000<br>&gt; Serial =A0: 0000000000000=
000<br>
&gt; remove test cases which require the block device.<br>&gt; You can spec=
ify it with option -b<br>&gt; COMMAND: =A0 =A0/opt/ltp/bin/ltp-pan =A0-e -S=
 =A0 -a 12621 =A0 =A0 -n 12621 =A0-p =A0-f<br>&gt; /tmp/ltp-isNlo12627/allt=
ests -l<br>&gt; /opt/ltp/results/network_stress.broken_ip.result =A0-C<br>
&gt; /opt/ltp/output/LTP_RUN_ON-network_stress.broken_ip.result.failed<br>&=
gt; LOG File: /opt/ltp/results/network_stress.broken_ip.result<br>&gt; FAIL=
ED COMMAND File:<br>&gt; /opt/ltp/output/LTP_RUN_ON-network_stress.broken_i=
p.result.failed<br>
&gt; Running tests.......<br>&gt; &lt;&lt;&lt;test_start&gt;&gt;&gt;<br>&gt=
; tag=3Dbroken_ip4-version stime=3D351622598<br>&gt; cmdline=3D&quot;broken=
_ip4-version&quot;<br>&gt; contacts=3D&quot;&quot;<br>&gt; analysis=3Dexit<=
br>&gt; &lt;&lt;&lt;test_output&gt;&gt;&gt;<br>
&gt; broken_ip4-version01 =A0 =A00 =A0TINFO =A0: =A0Verify that the kernel =
is not crashed<br>&gt; with receiving a large number of IPv4 packets that h=
ave wrong value in<br>&gt; version field.<br>&gt; broken_ip4-version01 =A0 =
=A01 =A0TBROK =A0: =A0Environment variable LHOST_HWADDRS is<br>
&gt; not set.<br>&gt; &lt;&lt;&lt;execution_status&gt;&gt;&gt;<br>&gt; init=
iation_status=3D&quot;ok&quot;<br>&gt; duration=3D0 termination_type=3Dexit=
ed termination_id=3D1 corefile=3Dno<br>&gt; cutime=3D3 cstime=3D10<br>&gt; =
&lt;&lt;&lt;test_end&gt;&gt;&gt;<br>
&gt; &lt;&lt;&lt;test_start&gt;&gt;&gt;<br>&gt; tag=3Dbroken_ip4-ihl stime=
=3D351622598<br>&gt; cmdline=3D&quot;broken_ip4-ihl&quot;<br>&gt; contacts=
=3D&quot;&quot;<br>&gt; analysis=3Dexit<br>&gt; &lt;&lt;&lt;test_output&gt;=
&gt;&gt;<br>
&gt; broken_ip4-ihl01 =A0 =A00 =A0TINFO =A0: =A0Verify that the kernel is n=
ot crashed with<br>&gt; receiving a large number of IPv4 packets that have =
wrong value in the header<br>&gt; length field.<br>&gt; broken_ip4-ihl01 =
=A0 =A01 =A0TBROK =A0: =A0Environment variable LHOST_HWADDRS is not<br>
&gt; set.<br>&gt; &lt;&lt;&lt;execution_status&gt;&gt;&gt;<br>&gt; initiati=
on_status=3D&quot;ok&quot;<br>&gt; duration=3D0 termination_type=3Dexited t=
ermination_id=3D1 corefile=3Dno<br>&gt; cutime=3D3 cstime=3D7<br>&gt; &lt;&=
lt;&lt;test_end&gt;&gt;&gt;<br>
&gt; &lt;&lt;&lt;test_start&gt;&gt;&gt;<br>&gt; tag=3Dbroken_ip4-totlen sti=
me=3D351622598<br>&gt; cmdline=3D&quot;broken_ip4-totlen&quot;<br>&gt; cont=
acts=3D&quot;&quot;<br>&gt; analysis=3Dexit<br>&gt; &lt;&lt;&lt;test_output=
&gt;&gt;&gt;<br>
&gt; broken_ip4-totlen01 =A0 =A00 =A0TINFO =A0: =A0Verify that the kernel i=
s not crashed<br>&gt; with receiving a large number of IPv4 packets that ha=
ve wrong value in the<br>&gt; total length field.<br>&gt; broken_ip4-totlen=
01 =A0 =A01 =A0TBROK =A0: =A0Environment variable LHOST_HWADDRS is<br>
&gt; not set.<br>&gt; &lt;&lt;&lt;execution_status&gt;&gt;&gt;<br>&gt; init=
iation_status=3D&quot;ok&quot;<br>&gt; duration=3D0 termination_type=3Dexit=
ed termination_id=3D1 corefile=3Dno<br>&gt; cutime=3D7 cstime=3D5<br>&gt; &=
lt;&lt;&lt;test_end&gt;&gt;&gt;<br>
&gt; &lt;&lt;&lt;test_start&gt;&gt;&gt;<br>&gt; tag=3Dbroken_ip4-fragment s=
time=3D351622598<br>&gt; cmdline=3D&quot;broken_ip4-fragment&quot;<br>&gt; =
contacts=3D&quot;&quot;<br>&gt; analysis=3Dexit<br>&gt; &lt;&lt;&lt;test_ou=
tput&gt;&gt;&gt;<br>
&gt; broken_ip4-fragment01 =A0 =A00 =A0TINFO =A0: =A0Verify that the kernel=
 is not crashed<br>&gt; with receiving a large number of IPv4 packets that =
have wrong fragment<br>&gt; information<br>&gt; broken_ip4-fragment01 =A0 =
=A01 =A0TBROK =A0: =A0Environment variable LHOST_HWADDRS is<br>
&gt; not set.<br>&gt; &lt;&lt;&lt;execution_status&gt;&gt;&gt;<br>&gt; init=
iation_status=3D&quot;ok&quot;<br>&gt; duration=3D0 termination_type=3Dexit=
ed termination_id=3D1 corefile=3Dno<br>&gt; cutime=3D2 cstime=3D13<br>&gt; =
&lt;&lt;&lt;test_end&gt;&gt;&gt;<br>
&gt; &lt;&lt;&lt;test_start&gt;&gt;&gt;<br>&gt; tag=3Dbroken_ip4-protcol st=
ime=3D351622598<br>&gt; cmdline=3D&quot;broken_ip4-protcol&quot;<br>&gt; co=
ntacts=3D&quot;&quot;<br>&gt; analysis=3Dexit<br>&gt; &lt;&lt;&lt;test_outp=
ut&gt;&gt;&gt;<br>
&gt; broken_ip4-protocol01 =A0 =A00 =A0TINFO =A0: =A0Verify that the kernel=
 is not crashed<br>&gt; with receiving a large number of IPv4 packets that =
have wrong value in the<br>&gt; protocol field<br>&gt; broken_ip4-protocol0=
1 =A0 =A01 =A0TBROK =A0: =A0Environment variable LHOST_HWADDRS is<br>
&gt; not set.<br>&gt; &lt;&lt;&lt;execution_status&gt;&gt;&gt;<br>&gt; init=
iation_status=3D&quot;ok&quot;<br>&gt; duration=3D0 termination_type=3Dexit=
ed termination_id=3D1 corefile=3Dno<br>&gt; cutime=3D4 cstime=3D8<br>&gt; &=
lt;&lt;&lt;test_end&gt;&gt;&gt;<br>
&gt; &lt;&lt;&lt;test_start&gt;&gt;&gt;<br>&gt; tag=3Dbroken_ip4-checksum s=
time=3D351622598<br>&gt; cmdline=3D&quot;broken_ip4-checksum&quot;<br>&gt; =
contacts=3D&quot;&quot;<br>&gt; analysis=3Dexit<br>&gt; &lt;&lt;&lt;test_ou=
tput&gt;&gt;&gt;<br>
&gt; broken_ip4-checksum01 =A0 =A00 =A0TINFO =A0: =A0Verify that the kernel=
 is not crashed<br>&gt; with receiving a large number of IPv4 packets that =
have wrong value in the<br>&gt; checksum field<br>&gt; broken_ip4-checksum0=
1 =A0 =A01 =A0TBROK =A0: =A0Environment variable LHOST_HWADDRS is<br>
&gt; not set.<br>&gt; &lt;&lt;&lt;execution_status&gt;&gt;&gt;<br>&gt; init=
iation_status=3D&quot;ok&quot;<br>&gt; duration=3D0 termination_type=3Dexit=
ed termination_id=3D1 corefile=3Dno<br>&gt; cutime=3D5 cstime=3D7<br>&gt; &=
lt;&lt;&lt;test_end&gt;&gt;&gt;<br>
&gt; &lt;&lt;&lt;test_start&gt;&gt;&gt;<br>&gt; tag=3Dbroken_ip4-dstaddr st=
ime=3D351622598<br>&gt; cmdline=3D&quot;broken_ip4-dstaddr&quot;<br>&gt; co=
ntacts=3D&quot;&quot;<br>&gt; analysis=3Dexit<br>&gt; &lt;&lt;&lt;test_outp=
ut&gt;&gt;&gt;<br>
&gt; broken_ip4-dstaddr01 =A0 =A00 =A0TINFO =A0: =A0Verify that the kernel =
is not crashed<br>&gt; with receiving a large number of IPv4 packets whose =
destination address is<br>&gt; wrong (destination MAC address is correct)<b=
r>&gt; broken_ip4-dstaddr01 =A0 =A01 =A0TBROK =A0: =A0Environment variable =
LHOST_HWADDRS is<br>
&gt; not set.<br>&gt; &lt;&lt;&lt;execution_status&gt;&gt;&gt;<br>&gt; init=
iation_status=3D&quot;ok&quot;<br>&gt; duration=3D1 termination_type=3Dexit=
ed termination_id=3D1 corefile=3Dno<br>&gt; cutime=3D3 cstime=3D9<br>&gt; &=
lt;&lt;&lt;test_end&gt;&gt;&gt;<br>
&gt; &lt;&lt;&lt;test_start&gt;&gt;&gt;<br>&gt; tag=3Dbroken_ip6-dstaddr st=
ime=3D351622599<br>&gt; cmdline=3D&quot;broken_ip6-dstaddr&quot;<br>&gt; co=
ntacts=3D&quot;&quot;<br>&gt; analysis=3Dexit<br>&gt; &lt;&lt;&lt;test_outp=
ut&gt;&gt;&gt;<br>
&gt; broken_ip6-dstaddr01 =A0 =A00 =A0TINFO =A0: =A0Verify that the kernel =
is not crashed<br>&gt; with receiving a large number of IPv6 packets whose =
destination address is<br>&gt; wrong (destination MAC address is correct)<b=
r>&gt; broken_ip6-dstaddr01 =A0 =A01 =A0TBROK =A0: =A0Environment variable =
LHOST_HWADDRS is<br>
&gt; not set.<br>&gt; &lt;&lt;&lt;execution_status&gt;&gt;&gt;<br>&gt; init=
iation_status=3D&quot;ok&quot;<br>&gt; duration=3D0 termination_type=3Dexit=
ed termination_id=3D1 corefile=3Dno<br>&gt; cutime=3D1 cstime=3D12<br>&gt; =
&lt;&lt;&lt;test_end&gt;&gt;&gt;<br>
&gt; &lt;&lt;&lt;test_start&gt;&gt;&gt;<br>&gt; tag=3Dbroken_ip6-nexthdr st=
ime=3D351622599<br>&gt; cmdline=3D&quot;broken_ip6-nexthdr&quot;<br>&gt; co=
ntacts=3D&quot;&quot;<br>&gt; analysis=3Dexit<br>&gt; &lt;&lt;&lt;test_outp=
ut&gt;&gt;&gt;<br>
&gt; broken_ip6-nexthdr01 =A0 =A00 =A0TINFO =A0: =A0Verify that the kernel =
is not crashed<br>&gt; with receiving a large number of IPv6 packets that h=
ave wrong value in the<br>&gt; next header field.<br>&gt; broken_ip6-nexthd=
r01 =A0 =A01 =A0TBROK =A0: =A0Environment variable LHOST_HWADDRS is<br>
&gt; not set.<br>&gt; &lt;&lt;&lt;execution_status&gt;&gt;&gt;<br>&gt; init=
iation_status=3D&quot;ok&quot;<br>&gt; duration=3D0 termination_type=3Dexit=
ed termination_id=3D1 corefile=3Dno<br>&gt; cutime=3D7 cstime=3D7<br>&gt; &=
lt;&lt;&lt;test_end&gt;&gt;&gt;<br>
&gt; &lt;&lt;&lt;test_start&gt;&gt;&gt;<br>&gt; tag=3Dbroken_ip6-plen stime=
=3D351622599<br>&gt; cmdline=3D&quot;broken_ip6-plen&quot;<br>&gt; contacts=
=3D&quot;&quot;<br>&gt; analysis=3Dexit<br>&gt; &lt;&lt;&lt;test_output&gt;=
&gt;&gt;<br>
&gt; broken_ip6-plen01 =A0 =A00 =A0TINFO =A0: =A0Verify that the kernel is =
not crashed with<br>&gt; receiving a large number of IPv6 packets that have=
 wrong value in the<br>&gt; payload length field.<br>&gt; broken_ip6-plen01=
 =A0 =A01 =A0TBROK =A0: =A0Environment variable LHOST_HWADDRS is not<br>
&gt; set.<br>&gt; &lt;&lt;&lt;execution_status&gt;&gt;&gt;<br>&gt; initiati=
on_status=3D&quot;ok&quot;<br>&gt; duration=3D0 termination_type=3Dexited t=
ermination_id=3D1 corefile=3Dno<br>&gt; cutime=3D2 cstime=3D9<br>&gt; &lt;&=
lt;&lt;test_end&gt;&gt;&gt;<br>
&gt; &lt;&lt;&lt;test_start&gt;&gt;&gt;<br>&gt; tag=3Dbroken_ip6-version st=
ime=3D351622599<br>&gt; cmdline=3D&quot;broken_ip6-version&quot;<br>&gt; co=
ntacts=3D&quot;&quot;<br>&gt; analysis=3Dexit<br>&gt; &lt;&lt;&lt;test_outp=
ut&gt;&gt;&gt;<br>
&gt; broken_ip6-version01 =A0 =A00 =A0TINFO =A0: =A0Verify that the kernel =
is not crashed<br>&gt; with receiving a large number of IPv6 packets that h=
ave wrong value in<br>&gt; version field.<br>&gt; broken_ip6-version01 =A0 =
=A01 =A0TBROK =A0: =A0Environment variable LHOST_HWADDRS is<br>
&gt; not set.<br>&gt; incrementing stop<br>&gt; &lt;&lt;&lt;execution_statu=
s&gt;&gt;&gt;<br>&gt; initiation_status=3D&quot;ok&quot;<br>&gt; duration=
=3D0 termination_type=3Dexited termination_id=3D1 corefile=3Dno<br>&gt; cut=
ime=3D3 cstime=3D7<br>
&gt; &lt;&lt;&lt;test_end&gt;&gt;&gt;<br>&gt; INFO: ltp-pan reported some t=
ests FAIL<br>&gt; LTP Version: LTP-20100131<br>&gt;<br>&gt; =A0 =A0 =A0 =A0=
###############################################################&quot;<br>&g=
t;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 Done executing testcases.&quot;<br>&gt; =A0 =
=A0 =A0 =A0 =A0 =A0 LTP Version: =A0LTP-20100131<br>&gt; =A0 =A0 =A0 =A0###=
############################################################&quot;<br>&gt;<=
br>&gt;<br>&gt;<br>&gt;<br>&gt; --<br>
&gt; Regards,<br>&gt; Arjit Sharma.<br><br></div></div>&gt; ---------------=
---------------------------------------------------------------<br>&gt; Sta=
rt uncovering the many advantages of virtual appliances<br>&gt; and start u=
sing them to simplify application deployment and<br>
&gt; accelerate your shift to cloud computing.<br>&gt; <a href=3D"http://p.=
sf.net/sfu/novell-sfdev2dev" target=3D"_blank">http://p.sf.net/sfu/novell-s=
fdev2dev</a><br><br>&gt; _______________________________________________<br=
>
&gt; Ltp-list mailing list<br>&gt; <a href=3D"mailto:Ltp-list@lists.sourcef=
orge.net">Ltp-list@lists.sourceforge.net</a><br>&gt; <a href=3D"https://lis=
ts.sourceforge.net/lists/listinfo/ltp-list" target=3D"_blank">https://lists=
.sourceforge.net/lists/listinfo/ltp-list</a><br>
<br></blockquote></div><br><br clear=3D"all"><br>-- <br>
<div>Regards,</div>
<div>Arjit Sharma.</div><br>

--0016364d281fad9221049172111c--


--===============4257293672943464139==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
--===============4257293672943464139==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============4257293672943464139==--

