Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <joyarjit@gmail.com>) id 1P7jdk-0004Hx-0l
	for ltp-list@lists.sourceforge.net; Mon, 18 Oct 2010 06:56:12 +0000
Received: from mail-ew0-f47.google.com ([209.85.215.47])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1P7jdh-0000DR-CX
	for ltp-list@lists.sourceforge.net; Mon, 18 Oct 2010 06:56:11 +0000
Received: by ewy1 with SMTP id 1so412228ewy.34
	for <ltp-list@lists.sourceforge.net>;
	Sun, 17 Oct 2010 23:56:03 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 18 Oct 2010 12:26:03 +0530
Message-ID: <AANLkTinU5f4fco7BGZ0GiQoWVZNtGam7xZaT6gYTspML@mail.gmail.com>
From: ARJIT SHARMA <joyarjit@gmail.com>
Subject: [LTP] PTY
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8996919036918604159=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============8996919036918604159==
Content-Type: multipart/alternative; boundary=0016364d31736b9d2f0492deaba4

--0016364d31736b9d2f0492deaba4
Content-Type: text/plain; charset=ISO-8859-1

Hi


      this is the log of PTY testcase i am getting...

      all 3 tests ie. "pty01,ptem01 and hangup01"

      failing because ptsname() function call failed.....




INFO: creating /opt/ltp/results directory

If some fields are empty or look unusual you may have an old version.

Compare to the current minimal requirements in Documentation/Changes.



Linux 192.168.1.10 2.6.32 #1 SMP Fri Oct 8 16:13:17 IST 2010 armv7l unknown
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

Mem:        255252      28548     226704          0          0      18124

-/+ buffers/cache:      10424     244828

Swap:            0          0          0



/proc/cpuinfo

Processor              : ARMv7 Processor rev 1 (v7l)

processor              : 0

BogoMIPS            : 996.14



processor              : 1

BogoMIPS            : 996.14



Features : swp half thumb fastmult vfp edsp vfpv3 vfpv3d16

CPU implementer  : 0x41

CPU architecture: 7

CPU variant           : 0x1

CPU part                : 0xc09

CPU revision         : 1



Hardware               : ST-SPEAR1300-EVB

Revision                : 0000

Serial                      : 0000000000000000

remove test cases which require the block device.

You can specify it with option -b

COMMAND:    /opt/ltp/bin/ltp-pan  -e -S   -a 24047     -n 24047  -p  -f
/tmp/ltp-NJOed24053/alltests -l /opt/ltp/results/pty.result  -C
/opt/ltp/output/LTP_RUN_ON-pty.result.failed

LOG File: /opt/ltp/results/pty.result

FAILED COMMAND File: /opt/ltp/output/LTP_RUN_ON-pty.result.failed

Running tests.......

<<<test_start>>>

tag=pty01 stime=7577

cmdline="pty01"

contacts=""

analysis=exit

<<<test_output>>>

pty01       1  TBROK  :  ptsname() call failed

<<<execution_status>>>

initiation_status="ok"

duration=0 termination_type=exited termination_id=2 corefile=no

cutime=1 cstime=0

<<<test_end>>>

<<<test_start>>>

tag=ptem01 stime=7577

cmdline="ptem01"

contacts=""

analysis=exit

<<<test_output>>>

ptem01      1  TBROK  :  ptsname() call failed

<<<execution_status>>>

initiation_status="ok"

duration=0 termination_type=exited termination_id=2 corefile=no

cutime=0 cstime=3

<<<test_end>>>

<<<test_start>>>

tag=hangup01 stime=7577

cmdline="hangup01"

contacts=""

analysis=exit

<<<test_output>>>

hangup01    1  TBROK  :  ptsname

incrementing stop

<<<execution_status>>>

initiation_status="ok"

duration=0 termination_type=exited termination_id=2 corefile=no

cutime=0 cstime=1

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

--0016364d31736b9d2f0492deaba4
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div><br clear=3D"all">Hi=A0</div>
<div>=A0</div>
<div>=A0</div>
<div>=A0=A0=A0=A0=A0 this is the log of PTY testcase i am getting...</div>
<div>=A0</div>
<div>=A0=A0=A0=A0=A0 all 3 tests ie. &quot;pty01,ptem01 and hangup01&quot;<=
/div>
<div>=A0</div>
<div>=A0=A0=A0=A0=A0=A0failing because ptsname() function call failed.....<=
/div>
<div>=A0</div>
<div>=A0</div>
<div>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=20
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">INFO: creating /opt/ltp/results di=
rectory</font></span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">If some fields are empty or look u=
nusual you may have an old version.</font></span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">Compare to the current minimal req=
uirements in Documentation/Changes.</font></span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman"><span>=A0</span></font></span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">Linux 192.168.1.10 2.6.32 #1 SMP F=
ri Oct 8 16:13:17 IST 2010 armv7l unknown unknown GNU/Linux</font></span></=
p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman"><span>=A0</span></font></span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">Gnu C<span>=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 </span>gcc (GCC) 4.5.0</font></span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">Gnu make<span>=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 </span>3.81</font></span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">util-linux<span>=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 </span>ng 2.16.1)</font></span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">mount<span>=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 </span>ng 2.16.1 (with libblkid support)</fo=
nt></span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">modutils<span>=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 </span>3.1</font></span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">e2fsprogs<span>=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 </span>1.41.9</font></span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">PPP<span>=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 </span>2.4.4</font></span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">Linux C Library<span>=A0=A0=A0=A0=
=A0=A0=A0 </span>2.10.1</font></span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">Dynamic linker (ldd)<span>=A0=A0 <=
/span>2.10.1</font></span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">Linux C++ Library<span>=A0=A0=A0=
=A0=A0 </span>6.0.14</font></span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">Procps<span>=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 </span>3.2.7</font></span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">Net-tools<span>=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 </span>1.60</font></span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">iproute2<span>=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 </span>iproute2-ss100224</font></span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">Console-tools<span>=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 </span>0.2.3</font></span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">Sh-utils<span>=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 </span>5.2.1</font></span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">Modules Loaded<span>=A0=A0=A0=A0=
=A0=A0=A0=A0 </span></font></span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">=A0</font></span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">free reports:</font></span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman"><span>=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 </span>total<span>=A0=A0=A0=A0=A0=A0 </span>used<span>=A0=A0=A0=
=A0=A0=A0 </span>free<span>=A0=A0=A0=A0 </span>shared<span>=A0=A0=A0 </span=
>buffers<span>=A0=A0=A0=A0 </span>cached</font></span></p>

<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">Mem:<span>=A0=A0=A0=A0=A0=A0=A0 </=
span>255252<span>=A0=A0=A0=A0=A0 </span>28548<span>=A0=A0=A0=A0 </span>2267=
04<span>=A0=A0=A0=A0=A0=A0=A0=A0=A0 </span>0<span>=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 </span>0<span>=A0=A0=A0=A0=A0 </span>18124</font></span></p>

<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">-/+ buffers/cache:<span>=A0=A0=A0=
=A0=A0 </span>10424<span>=A0=A0=A0=A0 </span>244828</font></span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">Swap:<span>=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 </span>0<span>=A0=A0=A0=A0=A0=A0=A0=A0=A0 </span>0<span>=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 </span>0</font></span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">=A0</font></span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">/proc/cpuinfo</font></span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">Processor<span>=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 </span>: ARMv7 Processor rev 1 (v7l)</font></span></p=
>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">processor<span>=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 </span>: 0</font></span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">BogoMIPS<span>=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 </span>: 996.14</font></span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">=A0</font></span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">processor<span>=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 </span>: 1</font></span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">BogoMIPS<span>=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 </span>: 996.14</font></span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">=A0</font></span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">Features<span> </span>: swp half t=
humb fastmult vfp edsp vfpv3 vfpv3d16 </font></span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">CPU implementer<span>=A0 </span>: =
0x41</font></span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">CPU architecture: 7</font></span><=
/p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">CPU variant<span>=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 </span>: 0x1</font></span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">CPU part<span>=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 </span>: 0xc09</font></span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">CPU revision<span>=A0=A0=A0=A0=A0=
=A0=A0=A0 </span>: 1</font></span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">=A0</font></span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">Hardware<span>=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 </span>: ST-SPEAR1300-EVB</font></span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">Revision<span>=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 </span>: 0000</font></span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">Serial<span>=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 </span>: 0000000000000000</font>=
</span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">remove test cases which require th=
e block device.</font></span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">You can specify it with option -b<=
/font></span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">COMMAND:<span>=A0=A0=A0 </span>/op=
t/ltp/bin/ltp-pan<span>=A0 </span>-e -S<span>=A0=A0 </span>-a 24047<span>=
=A0=A0=A0=A0 </span>-n 24047<span>=A0 </span>-p<span>=A0 </span>-f /tmp/ltp=
-NJOed24053/alltests -l /opt/ltp/results/pty.result<span>=A0 </span>-C /opt=
/ltp/output/LTP_RUN_ON-pty.result.failed</font></span></p>

<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">LOG File: /opt/ltp/results/pty.res=
ult</font></span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">FAILED COMMAND File: /opt/ltp/outp=
ut/LTP_RUN_ON-pty.result.failed</font></span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">Running tests.......</font></span>=
</p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">&lt;&lt;&lt;test_start&gt;&gt;&gt;=
</font></span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">tag=3Dpty01 stime=3D7577</font></s=
pan></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">cmdline=3D&quot;pty01&quot;</font>=
</span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">contacts=3D&quot;&quot;</font></sp=
an></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">analysis=3Dexit</font></span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">&lt;&lt;&lt;test_output&gt;&gt;&gt=
;</font></span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">pty01<span>=A0=A0=A0=A0=A0=A0 </sp=
an>1<span>=A0 </span>TBROK<span>=A0 </span>:<span>=A0 </span>ptsname() call=
 failed</font></span></p>

<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">&lt;&lt;&lt;execution_status&gt;&g=
t;&gt;</font></span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">initiation_status=3D&quot;ok&quot;=
</font></span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">duration=3D0 termination_type=3Dex=
ited termination_id=3D2 corefile=3Dno</font></span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">cutime=3D1 cstime=3D0</font></span=
></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">&lt;&lt;&lt;test_end&gt;&gt;&gt;</=
font></span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">&lt;&lt;&lt;test_start&gt;&gt;&gt;=
</font></span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">tag=3Dptem01 stime=3D7577</font></=
span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">cmdline=3D&quot;ptem01&quot;</font=
></span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">contacts=3D&quot;&quot;</font></sp=
an></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">analysis=3Dexit</font></span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">&lt;&lt;&lt;test_output&gt;&gt;&gt=
;</font></span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">ptem01<span>=A0=A0=A0=A0=A0 </span=
>1<span>=A0 </span>TBROK<span>=A0 </span>:<span>=A0 </span>ptsname() call f=
ailed</font></span></p>

<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">&lt;&lt;&lt;execution_status&gt;&g=
t;&gt;</font></span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">initiation_status=3D&quot;ok&quot;=
</font></span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">duration=3D0 termination_type=3Dex=
ited termination_id=3D2 corefile=3Dno</font></span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">cutime=3D0 cstime=3D3</font></span=
></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">&lt;&lt;&lt;test_end&gt;&gt;&gt;</=
font></span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">&lt;&lt;&lt;test_start&gt;&gt;&gt;=
</font></span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">tag=3Dhangup01 stime=3D7577</font>=
</span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">cmdline=3D&quot;hangup01&quot;</fo=
nt></span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">contacts=3D&quot;&quot;</font></sp=
an></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">analysis=3Dexit</font></span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">&lt;&lt;&lt;test_output&gt;&gt;&gt=
;</font></span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">hangup01<span>=A0=A0=A0 </span>1<s=
pan>=A0 </span>TBROK<span>=A0 </span>:<span>=A0 </span>ptsname</font></span=
></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">incrementing stop</font></span></p=
>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">&lt;&lt;&lt;execution_status&gt;&g=
t;&gt;</font></span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">initiation_status=3D&quot;ok&quot;=
</font></span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">duration=3D0 termination_type=3Dex=
ited termination_id=3D2 corefile=3Dno</font></span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">cutime=3D0 cstime=3D1</font></span=
></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">&lt;&lt;&lt;test_end&gt;&gt;&gt;</=
font></span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">INFO: ltp-pan reported some tests =
FAIL</font></span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman">LTP Version: LTP-20100131</font></=
span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman"><span>=A0=A0=A0=A0=A0=A0=A0 </span=
></font></span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman"><span>=A0=A0=A0=A0=A0=A0 </span>##=
#############################################################&quot;</font><=
/span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman"><span>=A0=A0=A0=A0=A0=A0=A0 </span=
></font></span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman"><span>=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 </span>Done executing testcases.&quot;</font></span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman"><span>=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 </span>LTP Version:<span>=A0 </span>LTP-20100131</font></span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><font face=3D"Times New Roman"><span>=A0=A0=A0=A0=A0=A0 </span>##=
#############################################################&quot;</font><=
/span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0in 0in 0pt"><span style=3D"FONT-SI=
ZE: 10pt"><span><font face=3D"Times New Roman">=A0=A0=A0=A0=A0=A0 </font></=
span></span></p><br>-- <br></div>
<div>Best Regards,</div>
<div>Arjit Sharma.</div>

--0016364d31736b9d2f0492deaba4--


--===============8996919036918604159==
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
--===============8996919036918604159==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============8996919036918604159==--

