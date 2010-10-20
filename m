Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <joyarjit@gmail.com>) id 1P8Rit-0003S9-FM
	for ltp-list@lists.sourceforge.net; Wed, 20 Oct 2010 06:00:27 +0000
Received: from mail-wy0-f175.google.com ([74.125.82.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1P8Riq-0004j9-UT
	for ltp-list@lists.sourceforge.net; Wed, 20 Oct 2010 06:00:27 +0000
Received: by wyb40 with SMTP id 40so3348209wyb.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 19 Oct 2010 23:00:19 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 20 Oct 2010 11:30:19 +0530
Message-ID: <AANLkTinR7pDvxfq32hkVSFq-wrkiJk-9O1JPkehpKQw-@mail.gmail.com>
From: ARJIT SHARMA <joyarjit@gmail.com>
Subject: [LTP] smack testcase
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3863610932828769689=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net, Garrett Cooper <yanegomi@gmail.com>

--===============3863610932828769689==
Content-Type: multipart/alternative; boundary=001636416b97c876130493061ff5

--001636416b97c876130493061ff5
Content-Type: text/plain; charset=ISO-8859-1

Hi,

     Inside the smack testcase, the sript "smack_common.sh" has a function
named "check_onlycap()" , please tell me its functionality  as every time
this function is reporting that   onlycap is "" not the expected "".

the log of the testcase is as follows---




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
Mem:        255368      21240     234128          0          0      11764
-/+ buffers/cache:       9476     245892
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
COMMAND:    /opt/ltp/bin/ltp-pan  -e -S   -a 1255     -n 1255  -p  -f
/tmp/ltp-MqPLzA1261/alltests -l /opt/ltp/results/smack.result  -C
/opt/ltp/output/LTP_RUN_ON-smack.result.failed
LOG File: /opt/ltp/results/smack.result
FAILED COMMAND File: /opt/ltp/output/LTP_RUN_ON-smack.result.failed
Running tests.......
<<<test_start>>>
tag=smack_set_ambient stime=618
cmdline="smack_set_ambient.sh"
contacts=""
analysis=exit
<<<test_output>>>
The smack label reported for /smack/onlycap is "", not the expected "".
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=1 cstime=5
<<<test_end>>>
<<<test_start>>>
tag=smack_set_current stime=618
cmdline="smack_set_current.sh"
contacts=""
analysis=exit
<<<test_output>>>
The smack label reported for /smack/onlycap is "", not the expected "".
<<<execution_status>>>
initiation_status="ok"
duration=1 termination_type=exited termination_id=1 corefile=no
cutime=1 cstime=5
<<<test_end>>>
<<<test_start>>>
tag=smack_set_doi stime=619
cmdline=" smack_set_doi.sh"
contacts=""
analysis=exit
<<<test_output>>>
The smack label reported for /smack/onlycap is "", not the expected "".
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=2 cstime=6
<<<test_end>>>
<<<test_start>>>
tag=smack_set_netlabel stime=619
cmdline="smack_set_netlabel.sh"
contacts=""
analysis=exit
<<<test_output>>>
The smack label reported for /smack/onlycap is "", not the expected "".
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=3 cstime=3
<<<test_end>>>
<<<test_start>>>
tag=smack_set_socket_labels stime=619
cmdline="smack_set_socket_labels"
contacts=""
analysis=exit
<<<test_output>>>
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=smack_set_cipso stime=619
cmdline=" smack_set_cipso.sh"
contacts=""
analysis=exit
<<<test_output>>>
The smack label reported for /smack/onlycap is "", not the expected "".
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=2 cstime=4
<<<test_end>>>
<<<test_start>>>
tag=smack_set_direct stime=619
cmdline="smack_set_direct.sh"
contacts=""
analysis=exit
<<<test_output>>>
The smack label reported for /smack/onlycap is "", not the expected "".
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=0 cstime=4
<<<test_end>>>
<<<test_start>>>
tag=smack_set_load stime=619
cmdline=" smack_set_load.sh"
contacts=""
analysis=exit
<<<test_output>>>
The smack label reported for /smack/onlycap is "", not the expected "".
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=1 cstime=5
<<<test_end>>>
<<<test_start>>>
tag=smack_set_onlycap stime=619
cmdline="smack_set_onlycap.sh"
contacts=""
analysis=exit
<<<test_output>>>
The smack label reported for /smack/onlycap is "", not the expected "".
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=0 cstime=6
<<<test_end>>>
<<<test_start>>>
tag=smack_file_access stime=619
cmdline="smack_file_access.sh"
contacts=""
analysis=exit
<<<test_output>>>
The smack label reported for /smack/onlycap is "", not the expected "".
incrementing stop
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=1 cstime=6
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

--001636416b97c876130493061ff5
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Hi,</div>
<div>=A0</div>
<div>=A0=A0=A0=A0 Inside the smack testcase, the sript &quot;smack_common.s=
h&quot; has a function named &quot;check_onlycap()&quot; , please tell me i=
ts functionality=A0 as every time this function is reporting=A0that=A0=A0 o=
nlycap is &quot;&quot; not the expected &quot;&quot;.</div>

<div>=A0</div>
<div>the log of the testcase is as follows---</div>
<div>=A0</div>
<div>=A0</div>
<div>=A0</div>
<div>=A0</div>
<div>INFO: creating /opt/ltp/results directory<br>If some fields are empty =
or look unusual you may have an old version.<br>Compare to the current mini=
mal requirements in Documentation/Changes.<br>=A0<br>Linux 192.168.1.10 2.6=
.32 #2 SMP Tue Oct 19 17:34:35 IST 2010 armv7l unknown unknown GNU/Linux<br=
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
=A0=A0=A0=A0=A0=A0=A0=A0=A0 3.2.7<br>Net-tools=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 1.60<br>iproute2=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 iprout=
e2-ss100224<br>
Console-tools=A0=A0=A0=A0=A0=A0=A0=A0=A0 0.2.3<br>Sh-utils=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 5.2.1<br>Modules Loaded=A0=A0=A0=A0=A0=A0=A0=A0=
 </div>
<div>free reports:<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 total=A0=A0=A0=
=A0=A0=A0 used=A0=A0=A0=A0=A0=A0 free=A0=A0=A0=A0 shared=A0=A0=A0 buffers=
=A0=A0=A0=A0 cached<br>Mem:=A0=A0=A0=A0=A0=A0=A0 255368=A0=A0=A0=A0=A0 2124=
0=A0=A0=A0=A0 234128=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0=A0=A0=A0=A0=A0 11764<br>-/+ buffers/cache:=A0=A0=A0=A0=A0=A0 9476=A0=
=A0=A0=A0 245892<br>
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
-e -S=A0=A0 -a 1255=A0=A0=A0=A0 -n 1255=A0 -p=A0 -f /tmp/ltp-MqPLzA1261/all=
tests -l /opt/ltp/results/smack.result=A0 -C /opt/ltp/output/LTP_RUN_ON-sma=
ck.result.failed<br>
LOG File: /opt/ltp/results/smack.result<br>FAILED COMMAND File: /opt/ltp/ou=
tput/LTP_RUN_ON-smack.result.failed<br>Running tests.......<br>&lt;&lt;&lt;=
test_start&gt;&gt;&gt;<br>tag=3Dsmack_set_ambient stime=3D618<br>cmdline=3D=
&quot;smack_set_ambient.sh&quot;<br>
contacts=3D&quot;&quot;<br>analysis=3Dexit<br>&lt;&lt;&lt;test_output&gt;&g=
t;&gt;<br>The smack label reported for /smack/onlycap is &quot;&quot;, not =
the expected &quot;&quot;.<br>&lt;&lt;&lt;execution_status&gt;&gt;&gt;<br>i=
nitiation_status=3D&quot;ok&quot;<br>
duration=3D0 termination_type=3Dexited termination_id=3D1 corefile=3Dno<br>=
cutime=3D1 cstime=3D5<br>&lt;&lt;&lt;test_end&gt;&gt;&gt;<br>&lt;&lt;&lt;te=
st_start&gt;&gt;&gt;<br>tag=3Dsmack_set_current stime=3D618<br>cmdline=3D&q=
uot;smack_set_current.sh&quot;<br>
contacts=3D&quot;&quot;<br>analysis=3Dexit<br>&lt;&lt;&lt;test_output&gt;&g=
t;&gt;<br>The smack label reported for /smack/onlycap is &quot;&quot;, not =
the expected &quot;&quot;.<br>&lt;&lt;&lt;execution_status&gt;&gt;&gt;<br>i=
nitiation_status=3D&quot;ok&quot;<br>
duration=3D1 termination_type=3Dexited termination_id=3D1 corefile=3Dno<br>=
cutime=3D1 cstime=3D5<br>&lt;&lt;&lt;test_end&gt;&gt;&gt;<br>&lt;&lt;&lt;te=
st_start&gt;&gt;&gt;<br>tag=3Dsmack_set_doi stime=3D619<br>cmdline=3D&quot;=
=A0smack_set_doi.sh&quot;<br>
contacts=3D&quot;&quot;<br>analysis=3Dexit<br>&lt;&lt;&lt;test_output&gt;&g=
t;&gt;<br>The smack label reported for /smack/onlycap is &quot;&quot;, not =
the expected &quot;&quot;.<br>&lt;&lt;&lt;execution_status&gt;&gt;&gt;<br>i=
nitiation_status=3D&quot;ok&quot;<br>
duration=3D0 termination_type=3Dexited termination_id=3D1 corefile=3Dno<br>=
cutime=3D2 cstime=3D6<br>&lt;&lt;&lt;test_end&gt;&gt;&gt;<br>&lt;&lt;&lt;te=
st_start&gt;&gt;&gt;<br>tag=3Dsmack_set_netlabel stime=3D619<br>cmdline=3D&=
quot;smack_set_netlabel.sh&quot;<br>
contacts=3D&quot;&quot;<br>analysis=3Dexit<br>&lt;&lt;&lt;test_output&gt;&g=
t;&gt;<br>The smack label reported for /smack/onlycap is &quot;&quot;, not =
the expected &quot;&quot;.<br>&lt;&lt;&lt;execution_status&gt;&gt;&gt;<br>i=
nitiation_status=3D&quot;ok&quot;<br>
duration=3D0 termination_type=3Dexited termination_id=3D1 corefile=3Dno<br>=
cutime=3D3 cstime=3D3<br>&lt;&lt;&lt;test_end&gt;&gt;&gt;<br>&lt;&lt;&lt;te=
st_start&gt;&gt;&gt;<br>tag=3Dsmack_set_socket_labels stime=3D619<br>cmdlin=
e=3D&quot;smack_set_socket_labels&quot;<br>
contacts=3D&quot;&quot;<br>analysis=3Dexit<br>&lt;&lt;&lt;test_output&gt;&g=
t;&gt;<br>&lt;&lt;&lt;execution_status&gt;&gt;&gt;<br>initiation_status=3D&=
quot;ok&quot;<br>duration=3D0 termination_type=3Dexited termination_id=3D0 =
corefile=3Dno<br>
cutime=3D0 cstime=3D0<br>&lt;&lt;&lt;test_end&gt;&gt;&gt;<br>&lt;&lt;&lt;te=
st_start&gt;&gt;&gt;<br>tag=3Dsmack_set_cipso stime=3D619<br>cmdline=3D&quo=
t;=A0smack_set_cipso.sh&quot;<br>contacts=3D&quot;&quot;<br>analysis=3Dexit=
<br>&lt;&lt;&lt;test_output&gt;&gt;&gt;<br>
The smack label reported for /smack/onlycap is &quot;&quot;, not the expect=
ed &quot;&quot;.<br>&lt;&lt;&lt;execution_status&gt;&gt;&gt;<br>initiation_=
status=3D&quot;ok&quot;<br>duration=3D0 termination_type=3Dexited terminati=
on_id=3D1 corefile=3Dno<br>
cutime=3D2 cstime=3D4<br>&lt;&lt;&lt;test_end&gt;&gt;&gt;<br>&lt;&lt;&lt;te=
st_start&gt;&gt;&gt;<br>tag=3Dsmack_set_direct stime=3D619<br>cmdline=3D&qu=
ot;smack_set_direct.sh&quot;<br>contacts=3D&quot;&quot;<br>analysis=3Dexit<=
br>&lt;&lt;&lt;test_output&gt;&gt;&gt;<br>
The smack label reported for /smack/onlycap is &quot;&quot;, not the expect=
ed &quot;&quot;.<br>&lt;&lt;&lt;execution_status&gt;&gt;&gt;<br>initiation_=
status=3D&quot;ok&quot;<br>duration=3D0 termination_type=3Dexited terminati=
on_id=3D1 corefile=3Dno<br>
cutime=3D0 cstime=3D4<br>&lt;&lt;&lt;test_end&gt;&gt;&gt;<br>&lt;&lt;&lt;te=
st_start&gt;&gt;&gt;<br>tag=3Dsmack_set_load stime=3D619<br>cmdline=3D&quot=
;=A0smack_set_load.sh&quot;<br>contacts=3D&quot;&quot;<br>analysis=3Dexit<b=
r>&lt;&lt;&lt;test_output&gt;&gt;&gt;<br>
The smack label reported for /smack/onlycap is &quot;&quot;, not the expect=
ed &quot;&quot;.<br>&lt;&lt;&lt;execution_status&gt;&gt;&gt;<br>initiation_=
status=3D&quot;ok&quot;<br>duration=3D0 termination_type=3Dexited terminati=
on_id=3D1 corefile=3Dno<br>
cutime=3D1 cstime=3D5<br>&lt;&lt;&lt;test_end&gt;&gt;&gt;<br>&lt;&lt;&lt;te=
st_start&gt;&gt;&gt;<br>tag=3Dsmack_set_onlycap stime=3D619<br>cmdline=3D&q=
uot;smack_set_onlycap.sh&quot;<br>contacts=3D&quot;&quot;<br>analysis=3Dexi=
t<br>&lt;&lt;&lt;test_output&gt;&gt;&gt;<br>
The smack label reported for /smack/onlycap is &quot;&quot;, not the expect=
ed &quot;&quot;.<br>&lt;&lt;&lt;execution_status&gt;&gt;&gt;<br>initiation_=
status=3D&quot;ok&quot;<br>duration=3D0 termination_type=3Dexited terminati=
on_id=3D1 corefile=3Dno<br>
cutime=3D0 cstime=3D6<br>&lt;&lt;&lt;test_end&gt;&gt;&gt;<br>&lt;&lt;&lt;te=
st_start&gt;&gt;&gt;<br>tag=3Dsmack_file_access stime=3D619<br>cmdline=3D&q=
uot;smack_file_access.sh&quot;<br>contacts=3D&quot;&quot;<br>analysis=3Dexi=
t<br>&lt;&lt;&lt;test_output&gt;&gt;&gt;<br>
The smack label reported for /smack/onlycap is &quot;&quot;, not the expect=
ed &quot;&quot;.<br>incrementing stop<br>&lt;&lt;&lt;execution_status&gt;&g=
t;&gt;<br>initiation_status=3D&quot;ok&quot;<br>duration=3D0 termination_ty=
pe=3Dexited termination_id=3D1 corefile=3Dno<br>
cutime=3D1 cstime=3D6<br>&lt;&lt;&lt;test_end&gt;&gt;&gt;<br>INFO: ltp-pan =
reported some tests FAIL<br>LTP Version: LTP-20100131<br>=A0=A0=A0=A0=A0=A0=
=A0 <br>=A0=A0=A0=A0=A0=A0 ################################################=
###############&quot;<br>=A0=A0=A0=A0=A0=A0=A0 <br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Done executing testcases.&quot;<br>=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 LTP Version:=A0 LTP-20100131<br>=A0=A0=A0=A0=A0=
=A0 ###############################################################&quot;<b=
r>=A0=A0=A0=A0=A0=A0 <br></div>
<div>=A0</div>
<div><br clear=3D"all"><br>-- <br></div>
<div>Best Regards,</div>
<div>Arjit Sharma.</div><br>

--001636416b97c876130493061ff5--


--===============3863610932828769689==
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
--===============3863610932828769689==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============3863610932828769689==--

