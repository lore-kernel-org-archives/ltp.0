Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <iranna.ankad@in.ibm.com>) id 1NmP8a-0001nb-Im
	for ltp-list@lists.sourceforge.net; Tue, 02 Mar 2010 10:15:36 +0000
Received: from e28smtp07.in.ibm.com ([122.248.162.7])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NmP8X-0006bp-Qn
	for ltp-list@lists.sourceforge.net; Tue, 02 Mar 2010 10:15:36 +0000
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by e28smtp07.in.ibm.com (8.14.3/8.13.1) with ESMTP id o22AF5te024904
	for <ltp-list@lists.sourceforge.net>; Tue, 2 Mar 2010 15:45:05 +0530
Received: from d28av06.in.ibm.com (d28av06.in.ibm.com [9.184.220.48])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o22AF4jH2437224
	for <ltp-list@lists.sourceforge.net>; Tue, 2 Mar 2010 15:45:04 +0530
Received: from d28av06.in.ibm.com (loopback [127.0.0.1])
	by d28av06.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o22AF4cT004160
	for <ltp-list@lists.sourceforge.net>; Tue, 2 Mar 2010 15:45:04 +0530
Received: from d23ml063.in.ibm.com (d23ml063.in.ibm.com [9.124.105.25])
	by d28av06.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVin) with ESMTP id
	o22AF4Xc004157
	for <ltp-list@lists.sourceforge.net>; Tue, 2 Mar 2010 15:45:04 +0530
MIME-Version: 1.0
Message-ID: <OF3DD1AE6A.65D45C56-ON652576DA.002F585D-652576DA.00384F54@in.ibm.com>
From: Iranna D Ankad <iranna.ankad@in.ibm.com>
Date: Tue, 2 Mar 2010 15:41:46 +0530
Subject: [LTP] LTP's filecaps test gives false positive results
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5633764347359839684=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: Rishikesh K Rajak <risrajak@in.ibm.com>, Serge E Hallyn <sergeh@us.ibm.com>

This is a multipart message in MIME format.
--===============5633764347359839684==
Content-Type: multipart/alternative;
	boundary="=_alternative 00384F2D652576DA_="

This is a multipart message in MIME format.
--=_alternative 00384F2D652576DA_=
Content-Type: text/plain; charset="US-ASCII"

Hello ..
When I am trying to run LTP's filecaps test, it does not actually run the 
test, but ltp-pan report test PASSED.
This is happening in the latest LTP (ltp-full-20100228), including couple 
of past LTP releases (ex. November, December releases)

---------------------------------------------------------------------------------------------------------------------------------------------------
mx3950:/opt/ltp # ./runltp -f filecaps
INFO: creating /opt/ltp/results directory
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
LSB_VERSION="core-2.0-noarch:core-3.2-noarch:core-4.0-noarch:core-2.0-x86_64:core-3.2-x86_64:core-4.0-x86_64"
SUSE Linux Enterprise Server 11 (x86_64)
VERSION = 11
PATCHLEVEL = 1
Linux mx3950 2.6.32.8-default #1 SMP Fri Feb 26 18:45:10 EST 2010 x86_64 
x86_64 x86_64 GNU/Linux
 
Gnu C                  gcc (SUSE Linux) 4.3.4 [gcc-4_3-branch revision 
152973]
Gnu make               3.81
util-linux             ng 2.16)
mount                  ng 2.16 (with libblkid and selinux support)
modutils               3.11.1
e2fsprogs              1.41.9
PPP                    2.4.5
Linux C Library        2.11.1
Dynamic linker (ldd)   2.11.1
Procps                 3.2.7
Net-tools              1.60
iproute2              iproute2-ss090324
Kbd                    1.14.1
Sh-utils               6.12
Modules Loaded         radeon ttm drm_kms_helper drm i2c_algo_bit ipv6 
microcode fuse loop dm_mod rtc_cmos ses i2c_piix4 rtc_core sr_mod 
usb_storage rtc_lib acpi_memhotplug sg pcspkr serio_raw joydev enclosure 
button i2c_core cdrom usbhid hid ohci_hcd ehci_hcd sd_mod ssb crc_t10dif 
mmc_core usbcore pcmcia pcmcia_core edd ext3 mbcache jbd fan processor 
ata_generic thermal thermal_sys hwmon

free reports:
             total       used       free     shared    buffers     cached
Mem:      33019056    2530968   30488088          0     108020    1218628
-/+ buffers/cache:    1204320   31814736
Swap:     20964816          0   20964816

/proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 6
model name      : Intel(R) Xeon(TM) CPU 3.16GHz
stepping        : 8
cpu MHz         : 3169.236
cache size      : 8192 KB
physical id     : 0
siblings        : 4
core id         : 0
cpu cores       : 2
apicid          : 0
initial apicid  : 0
fpu             : yes
fpu_exception   : yes
cpuid level     : 6
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx 
lm constant_tsc pebs bts pni dtes64 monitor ds_cpl vmx est tm2 cid cx16 
xtpr pdcm lahf_lm tpr_shadow vnmi
bogomips        : 6338.47
clflush size    : 64
cache_alignment : 128
address sizes   : 40 bits physical, 48 bits virtual
power management:

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 6
model name      : Intel(R) Xeon(TM) CPU 3.16GHz
stepping        : 8
cpu MHz         : 3169.236
cache size      : 8192 KB
physical id     : 0
siblings        : 4
core id         : 0
cpu cores       : 2
apicid          : 1
initial apicid  : 1
fpu             : yes
fpu_exception   : yes
cpuid level     : 6
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx 
lm constant_tsc pebs bts pni dtes64 monitor ds_cpl vmx est tm2 cid cx16 
xtpr pdcm lahf_lm tpr_shadow vnmi
bogomips        : 6339.10
clflush size    : 64
cache_alignment : 128
address sizes   : 40 bits physical, 48 bits virtual
power management:

processor       : 2
vendor_id       : GenuineIntel
cpu family      : 15
model           : 6
model name      : Intel(R) Xeon(TM) CPU 3.16GHz
stepping        : 8
cpu MHz         : 3169.236
cache size      : 8192 KB
physical id     : 0
siblings        : 4
core id         : 1
cpu cores       : 2
apicid          : 2
initial apicid  : 2
fpu             : yes
fpu_exception   : yes
cpuid level     : 6
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx 
lm constant_tsc pebs bts pni dtes64 monitor ds_cpl vmx est tm2 cid cx16 
xtpr pdcm lahf_lm tpr_shadow vnmi
bogomips        : 6339.19
clflush size    : 64
cache_alignment : 128
address sizes   : 40 bits physical, 48 bits virtual
power management:

processor       : 3
vendor_id       : GenuineIntel
cpu family      : 15
model           : 6
model name      : Intel(R) Xeon(TM) CPU 3.16GHz
stepping        : 8
cpu MHz         : 3169.236
cache size      : 8192 KB
physical id     : 0
siblings        : 4
core id         : 1
cpu cores       : 2
apicid          : 3
initial apicid  : 3
fpu             : yes
fpu_exception   : yes
cpuid level     : 6
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx 
lm constant_tsc pebs bts pni dtes64 monitor ds_cpl vmx est tm2 cid cx16 
xtpr pdcm lahf_lm tpr_shadow vnmi
bogomips        : 6339.16
clflush size    : 64
cache_alignment : 128
address sizes   : 40 bits physical, 48 bits virtual
power management:

processor       : 4
vendor_id       : GenuineIntel
cpu family      : 15
model           : 6
model name      : Intel(R) Xeon(TM) CPU 3.16GHz
stepping        : 8
cpu MHz         : 3169.236
cache size      : 8192 KB
physical id     : 1
siblings        : 4
core id         : 0
cpu cores       : 2
apicid          : 4
initial apicid  : 4
fpu             : yes
fpu_exception   : yes
cpuid level     : 6
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx 
lm constant_tsc pebs bts pni dtes64 monitor ds_cpl vmx est tm2 cid cx16 
xtpr pdcm lahf_lm tpr_shadow vnmi
bogomips        : 6339.29
clflush size    : 64
cache_alignment : 128
address sizes   : 40 bits physical, 48 bits virtual
power management:

processor       : 5
vendor_id       : GenuineIntel
cpu family      : 15
model           : 6
model name      : Intel(R) Xeon(TM) CPU 3.16GHz
stepping        : 8
cpu MHz         : 3169.236
cache size      : 8192 KB
physical id     : 1
siblings        : 4
core id         : 0
cpu cores       : 2
apicid          : 5
initial apicid  : 5
fpu             : yes
fpu_exception   : yes
cpuid level     : 6
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx 
lm constant_tsc pebs bts pni dtes64 monitor ds_cpl vmx est tm2 cid cx16 
xtpr pdcm lahf_lm tpr_shadow vnmi
bogomips        : 6339.25
clflush size    : 64
cache_alignment : 128
address sizes   : 40 bits physical, 48 bits virtual
power management:

processor       : 6
vendor_id       : GenuineIntel
cpu family      : 15
model           : 6
model name      : Intel(R) Xeon(TM) CPU 3.16GHz
stepping        : 8
cpu MHz         : 3169.236
cache size      : 8192 KB
physical id     : 1
siblings        : 4
core id         : 1
cpu cores       : 2
apicid          : 6
initial apicid  : 6
fpu             : yes
fpu_exception   : yes
cpuid level     : 6
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx 
lm constant_tsc pebs bts pni dtes64 monitor ds_cpl vmx est tm2 cid cx16 
xtpr pdcm lahf_lm tpr_shadow vnmi
bogomips        : 6339.28
clflush size    : 64
cache_alignment : 128
address sizes   : 40 bits physical, 48 bits virtual
power management:

processor       : 7
vendor_id       : GenuineIntel
cpu family      : 15
model           : 6
model name      : Intel(R) Xeon(TM) CPU 3.16GHz
stepping        : 8
cpu MHz         : 3169.236
cache size      : 8192 KB
physical id     : 1
siblings        : 4
core id         : 1
cpu cores       : 2
apicid          : 7
initial apicid  : 7
fpu             : yes
fpu_exception   : yes
cpuid level     : 6
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx 
lm constant_tsc pebs bts pni dtes64 monitor ds_cpl vmx est tm2 cid cx16 
xtpr pdcm lahf_lm tpr_shadow vnmi
bogomips        : 6339.29
clflush size    : 64
cache_alignment : 128
address sizes   : 40 bits physical, 48 bits virtual
power management:

remove test cases which require the block device.
You can specify it with option -b
COMMAND:    /opt/ltp/bin/ltp-pan  -e -S   -a 12064     -n 12064  -p  -f 
/tmp/ltp-P00GfUUqLS/alltests -l 
/opt/ltp/results/LTP_RUN_ON-2010_Mar_02-04h_14m_57s.log  -C 
/opt/ltp/output/LTP_RUN_ON-2010_Mar_02-04h_14m_57s.failed
LOG File: /opt/ltp/results/LTP_RUN_ON-2010_Mar_02-04h_14m_57s.log
FAILED COMMAND File: 
/opt/ltp/output/LTP_RUN_ON-2010_Mar_02-04h_14m_57s.failed
Running tests.......
<<<test_start>>>
tag=Filecaps stime=1267521297
cmdline="filecapstest.sh"
contacts=""
analysis=exit
<<<test_output>>>
incrementing stop
Filecaps 0 CONF : System doesn't support execution of the test
setcap not installed. Please install libcap-2.11 or newer from
ftp://ftp.kernel.org/pub/linux/libs/security/linux-privs/libcap2
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>
INFO: ltp-pan reported all tests PASS
LTP Version: LTP-20100131
 
       ###############################################################"
 
            Done executing testcases."
            LTP Version:  LTP-20100131
       ###############################################################"
 
mx3950:/opt/ltp #

---------------------------------------------------------------------------------------------------------------------------------------------------

LTP reports setcap is installed, but actually, my system has setcap 
installed, along with all required libcap related rpms.

mx3950:/opt/ltp # setc
setcap      setconsole  setctsid 
mx3950:/opt/ltp #

mx3950:/opt/ltp # rpm -qa | grep cap
libcap1-1.10-6.10
libcap2-2.11-2.15
libcap-progs-2.11-2.15
libpcap0-0.9.8-50.4.32
libcap2-32bit-2.11-2.15
libcap1-32bit-1.10-6.10
mx3950:/opt/ltp # 
---------------------------------------------------------------------------------------------------------------------------------------------------


Here is the false positive log, which shows test PASSED, without actually 
running the test.

---------------------------------------------------------------------------------------------------------------------------------------------------

mx3950:/opt/ltp # cat results/LTP_RUN_ON-2010_Mar_02-04h_14m_57s.log 
Test Start Time: Tue Mar  2 04:14:57 2010
-----------------------------------------
Testcase                       Result     Exit Value
--------                       ------     ----------
Filecaps                       PASS       0 

-----------------------------------------------
Total Tests: 1
Total Failures: 0
Kernel Version: 2.6.32.8-default
Machine Architecture: x86_64
Hostname: mx3950

mx3950:/opt/ltp # 
---------------------------------------------------------------------------------------------------------------------------------------------------

Thanks!
-Iranna D Ankad
----------------------------------------------------------------------------------------------------
Linux-Technology Center, IBM India Software Labs
Manyata Embassy Park, BENGALURU - 560045,
Ph: +91-080-28055007   Extn: 55007
----------------------------------------------------------------------------------------------------
"If you don't have patience to test the software, the software will test 
your patience !!"
--=_alternative 00384F2D652576DA_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2 face="sans-serif">Hello ..</font>
<br><font size=2 face="sans-serif">When I am trying to run LTP's filecaps
test, it does not actually run the test, but ltp-pan report test PASSED.</font>
<br><font size=2 face="sans-serif">This is happening in the latest LTP
(ltp-full-20100228), including couple of past LTP releases (ex. November,
December releases)</font>
<br>
<br><font size=2 face="sans-serif">---------------------------------------------------------------------------------------------------------------------------------------------------</font>
<br><font size=2 face="sans-serif">mx3950:/opt/ltp # ./runltp -f filecaps</font>
<br><font size=2 face="sans-serif">INFO: creating /opt/ltp/results directory</font>
<br><font size=2 face="sans-serif">If some fields are empty or look unusual
you may have an old version.</font>
<br><font size=2 face="sans-serif">Compare to the current minimal requirements
in Documentation/Changes.</font>
<br><font size=2 face="sans-serif">&nbsp;</font>
<br><font size=2 face="sans-serif">LSB_VERSION=&quot;core-2.0-noarch:core-3.2-noarch:core-4.0-noarch:core-2.0-x86_64:core-3.2-x86_64:core-4.0-x86_64&quot;</font>
<br><font size=2 face="sans-serif">SUSE Linux Enterprise Server 11 (x86_64)</font>
<br><font size=2 face="sans-serif">VERSION = 11</font>
<br><font size=2 face="sans-serif">PATCHLEVEL = 1</font>
<br><font size=2 face="sans-serif">Linux mx3950 2.6.32.8-default #1 SMP
Fri Feb 26 18:45:10 EST 2010 x86_64 x86_64 x86_64 GNU/Linux</font>
<br><font size=2 face="sans-serif">&nbsp;</font>
<br><font size=2 face="sans-serif">Gnu C &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;gcc (SUSE Linux) 4.3.4 [gcc-4_3-branch revision
152973]</font>
<br><font size=2 face="sans-serif">Gnu make &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; 3.81</font>
<br><font size=2 face="sans-serif">util-linux &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; ng 2.16)</font>
<br><font size=2 face="sans-serif">mount &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;ng 2.16 (with libblkid and selinux support)</font>
<br><font size=2 face="sans-serif">modutils &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; 3.11.1</font>
<br><font size=2 face="sans-serif">e2fsprogs &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp;1.41.9</font>
<br><font size=2 face="sans-serif">PPP &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;2.4.5</font>
<br><font size=2 face="sans-serif">Linux C Library &nbsp; &nbsp; &nbsp;
&nbsp;2.11.1</font>
<br><font size=2 face="sans-serif">Dynamic linker (ldd) &nbsp; 2.11.1</font>
<br><font size=2 face="sans-serif">Procps &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; 3.2.7</font>
<br><font size=2 face="sans-serif">Net-tools &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp;1.60</font>
<br><font size=2 face="sans-serif">iproute2 &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp;iproute2-ss090324</font>
<br><font size=2 face="sans-serif">Kbd &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;1.14.1</font>
<br><font size=2 face="sans-serif">Sh-utils &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; 6.12</font>
<br><font size=2 face="sans-serif">Modules Loaded &nbsp; &nbsp; &nbsp;
&nbsp; radeon ttm drm_kms_helper drm i2c_algo_bit ipv6 microcode fuse loop
dm_mod rtc_cmos ses i2c_piix4 rtc_core sr_mod usb_storage rtc_lib acpi_memhotplug
sg pcspkr serio_raw joydev enclosure button i2c_core cdrom usbhid hid ohci_hcd
ehci_hcd sd_mod ssb crc_t10dif mmc_core usbcore pcmcia pcmcia_core edd
ext3 mbcache jbd fan processor ata_generic thermal thermal_sys hwmon</font>
<br>
<br><font size=2 face="sans-serif">free reports:</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;total &nbsp; &nbsp; &nbsp; used &nbsp; &nbsp; &nbsp; free &nbsp;
&nbsp; shared &nbsp; &nbsp;buffers &nbsp; &nbsp; cached</font>
<br><font size=2 face="sans-serif">Mem: &nbsp; &nbsp; &nbsp;33019056 &nbsp;
&nbsp;2530968 &nbsp; 30488088 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;0 &nbsp;
&nbsp; 108020 &nbsp; &nbsp;1218628</font>
<br><font size=2 face="sans-serif">-/+ buffers/cache: &nbsp; &nbsp;1204320
&nbsp; 31814736</font>
<br><font size=2 face="sans-serif">Swap: &nbsp; &nbsp; 20964816 &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;0 &nbsp; 20964816</font>
<br>
<br><font size=2 face="sans-serif">/proc/cpuinfo</font>
<br><font size=2 face="sans-serif">processor &nbsp; &nbsp; &nbsp; &nbsp;:
0</font>
<br><font size=2 face="sans-serif">vendor_id &nbsp; &nbsp; &nbsp; &nbsp;:
GenuineIntel</font>
<br><font size=2 face="sans-serif">cpu family &nbsp; &nbsp; &nbsp; &nbsp;:
15</font>
<br><font size=2 face="sans-serif">model &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;: 6</font>
<br><font size=2 face="sans-serif">model name &nbsp; &nbsp; &nbsp; &nbsp;:
Intel(R) Xeon(TM) CPU 3.16GHz</font>
<br><font size=2 face="sans-serif">stepping &nbsp; &nbsp; &nbsp; &nbsp;:
8</font>
<br><font size=2 face="sans-serif">cpu MHz &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;: 3169.236</font>
<br><font size=2 face="sans-serif">cache size &nbsp; &nbsp; &nbsp; &nbsp;:
8192 KB</font>
<br><font size=2 face="sans-serif">physical id &nbsp; &nbsp; &nbsp; &nbsp;:
0</font>
<br><font size=2 face="sans-serif">siblings &nbsp; &nbsp; &nbsp; &nbsp;:
4</font>
<br><font size=2 face="sans-serif">core id &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;: 0</font>
<br><font size=2 face="sans-serif">cpu cores &nbsp; &nbsp; &nbsp; &nbsp;:
2</font>
<br><font size=2 face="sans-serif">apicid &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;: 0</font>
<br><font size=2 face="sans-serif">initial apicid &nbsp; &nbsp; &nbsp;
&nbsp;: 0</font>
<br><font size=2 face="sans-serif">fpu &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;: yes</font>
<br><font size=2 face="sans-serif">fpu_exception &nbsp; &nbsp; &nbsp; &nbsp;:
yes</font>
<br><font size=2 face="sans-serif">cpuid level &nbsp; &nbsp; &nbsp; &nbsp;:
6</font>
<br><font size=2 face="sans-serif">wp &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;: yes</font>
<br><font size=2 face="sans-serif">flags &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;: fpu vme de pse tsc msr pae mce cx8
apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2
ss ht tm pbe syscall nx lm constant_tsc pebs bts pni dtes64 monitor ds_cpl
vmx est tm2 cid cx16 xtpr pdcm lahf_lm tpr_shadow vnmi</font>
<br><font size=2 face="sans-serif">bogomips &nbsp; &nbsp; &nbsp; &nbsp;:
6338.47</font>
<br><font size=2 face="sans-serif">clflush size &nbsp; &nbsp; &nbsp; &nbsp;:
64</font>
<br><font size=2 face="sans-serif">cache_alignment &nbsp; &nbsp; &nbsp;
&nbsp;: 128</font>
<br><font size=2 face="sans-serif">address sizes &nbsp; &nbsp; &nbsp; &nbsp;:
40 bits physical, 48 bits virtual</font>
<br><font size=2 face="sans-serif">power management:</font>
<br>
<br><font size=2 face="sans-serif">processor &nbsp; &nbsp; &nbsp; &nbsp;:
1</font>
<br><font size=2 face="sans-serif">vendor_id &nbsp; &nbsp; &nbsp; &nbsp;:
GenuineIntel</font>
<br><font size=2 face="sans-serif">cpu family &nbsp; &nbsp; &nbsp; &nbsp;:
15</font>
<br><font size=2 face="sans-serif">model &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;: 6</font>
<br><font size=2 face="sans-serif">model name &nbsp; &nbsp; &nbsp; &nbsp;:
Intel(R) Xeon(TM) CPU 3.16GHz</font>
<br><font size=2 face="sans-serif">stepping &nbsp; &nbsp; &nbsp; &nbsp;:
8</font>
<br><font size=2 face="sans-serif">cpu MHz &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;: 3169.236</font>
<br><font size=2 face="sans-serif">cache size &nbsp; &nbsp; &nbsp; &nbsp;:
8192 KB</font>
<br><font size=2 face="sans-serif">physical id &nbsp; &nbsp; &nbsp; &nbsp;:
0</font>
<br><font size=2 face="sans-serif">siblings &nbsp; &nbsp; &nbsp; &nbsp;:
4</font>
<br><font size=2 face="sans-serif">core id &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;: 0</font>
<br><font size=2 face="sans-serif">cpu cores &nbsp; &nbsp; &nbsp; &nbsp;:
2</font>
<br><font size=2 face="sans-serif">apicid &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;: 1</font>
<br><font size=2 face="sans-serif">initial apicid &nbsp; &nbsp; &nbsp;
&nbsp;: 1</font>
<br><font size=2 face="sans-serif">fpu &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;: yes</font>
<br><font size=2 face="sans-serif">fpu_exception &nbsp; &nbsp; &nbsp; &nbsp;:
yes</font>
<br><font size=2 face="sans-serif">cpuid level &nbsp; &nbsp; &nbsp; &nbsp;:
6</font>
<br><font size=2 face="sans-serif">wp &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;: yes</font>
<br><font size=2 face="sans-serif">flags &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;: fpu vme de pse tsc msr pae mce cx8
apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2
ss ht tm pbe syscall nx lm constant_tsc pebs bts pni dtes64 monitor ds_cpl
vmx est tm2 cid cx16 xtpr pdcm lahf_lm tpr_shadow vnmi</font>
<br><font size=2 face="sans-serif">bogomips &nbsp; &nbsp; &nbsp; &nbsp;:
6339.10</font>
<br><font size=2 face="sans-serif">clflush size &nbsp; &nbsp; &nbsp; &nbsp;:
64</font>
<br><font size=2 face="sans-serif">cache_alignment &nbsp; &nbsp; &nbsp;
&nbsp;: 128</font>
<br><font size=2 face="sans-serif">address sizes &nbsp; &nbsp; &nbsp; &nbsp;:
40 bits physical, 48 bits virtual</font>
<br><font size=2 face="sans-serif">power management:</font>
<br>
<br><font size=2 face="sans-serif">processor &nbsp; &nbsp; &nbsp; &nbsp;:
2</font>
<br><font size=2 face="sans-serif">vendor_id &nbsp; &nbsp; &nbsp; &nbsp;:
GenuineIntel</font>
<br><font size=2 face="sans-serif">cpu family &nbsp; &nbsp; &nbsp; &nbsp;:
15</font>
<br><font size=2 face="sans-serif">model &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;: 6</font>
<br><font size=2 face="sans-serif">model name &nbsp; &nbsp; &nbsp; &nbsp;:
Intel(R) Xeon(TM) CPU 3.16GHz</font>
<br><font size=2 face="sans-serif">stepping &nbsp; &nbsp; &nbsp; &nbsp;:
8</font>
<br><font size=2 face="sans-serif">cpu MHz &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;: 3169.236</font>
<br><font size=2 face="sans-serif">cache size &nbsp; &nbsp; &nbsp; &nbsp;:
8192 KB</font>
<br><font size=2 face="sans-serif">physical id &nbsp; &nbsp; &nbsp; &nbsp;:
0</font>
<br><font size=2 face="sans-serif">siblings &nbsp; &nbsp; &nbsp; &nbsp;:
4</font>
<br><font size=2 face="sans-serif">core id &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;: 1</font>
<br><font size=2 face="sans-serif">cpu cores &nbsp; &nbsp; &nbsp; &nbsp;:
2</font>
<br><font size=2 face="sans-serif">apicid &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;: 2</font>
<br><font size=2 face="sans-serif">initial apicid &nbsp; &nbsp; &nbsp;
&nbsp;: 2</font>
<br><font size=2 face="sans-serif">fpu &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;: yes</font>
<br><font size=2 face="sans-serif">fpu_exception &nbsp; &nbsp; &nbsp; &nbsp;:
yes</font>
<br><font size=2 face="sans-serif">cpuid level &nbsp; &nbsp; &nbsp; &nbsp;:
6</font>
<br><font size=2 face="sans-serif">wp &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;: yes</font>
<br><font size=2 face="sans-serif">flags &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;: fpu vme de pse tsc msr pae mce cx8
apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2
ss ht tm pbe syscall nx lm constant_tsc pebs bts pni dtes64 monitor ds_cpl
vmx est tm2 cid cx16 xtpr pdcm lahf_lm tpr_shadow vnmi</font>
<br><font size=2 face="sans-serif">bogomips &nbsp; &nbsp; &nbsp; &nbsp;:
6339.19</font>
<br><font size=2 face="sans-serif">clflush size &nbsp; &nbsp; &nbsp; &nbsp;:
64</font>
<br><font size=2 face="sans-serif">cache_alignment &nbsp; &nbsp; &nbsp;
&nbsp;: 128</font>
<br><font size=2 face="sans-serif">address sizes &nbsp; &nbsp; &nbsp; &nbsp;:
40 bits physical, 48 bits virtual</font>
<br><font size=2 face="sans-serif">power management:</font>
<br>
<br><font size=2 face="sans-serif">processor &nbsp; &nbsp; &nbsp; &nbsp;:
3</font>
<br><font size=2 face="sans-serif">vendor_id &nbsp; &nbsp; &nbsp; &nbsp;:
GenuineIntel</font>
<br><font size=2 face="sans-serif">cpu family &nbsp; &nbsp; &nbsp; &nbsp;:
15</font>
<br><font size=2 face="sans-serif">model &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;: 6</font>
<br><font size=2 face="sans-serif">model name &nbsp; &nbsp; &nbsp; &nbsp;:
Intel(R) Xeon(TM) CPU 3.16GHz</font>
<br><font size=2 face="sans-serif">stepping &nbsp; &nbsp; &nbsp; &nbsp;:
8</font>
<br><font size=2 face="sans-serif">cpu MHz &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;: 3169.236</font>
<br><font size=2 face="sans-serif">cache size &nbsp; &nbsp; &nbsp; &nbsp;:
8192 KB</font>
<br><font size=2 face="sans-serif">physical id &nbsp; &nbsp; &nbsp; &nbsp;:
0</font>
<br><font size=2 face="sans-serif">siblings &nbsp; &nbsp; &nbsp; &nbsp;:
4</font>
<br><font size=2 face="sans-serif">core id &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;: 1</font>
<br><font size=2 face="sans-serif">cpu cores &nbsp; &nbsp; &nbsp; &nbsp;:
2</font>
<br><font size=2 face="sans-serif">apicid &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;: 3</font>
<br><font size=2 face="sans-serif">initial apicid &nbsp; &nbsp; &nbsp;
&nbsp;: 3</font>
<br><font size=2 face="sans-serif">fpu &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;: yes</font>
<br><font size=2 face="sans-serif">fpu_exception &nbsp; &nbsp; &nbsp; &nbsp;:
yes</font>
<br><font size=2 face="sans-serif">cpuid level &nbsp; &nbsp; &nbsp; &nbsp;:
6</font>
<br><font size=2 face="sans-serif">wp &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;: yes</font>
<br><font size=2 face="sans-serif">flags &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;: fpu vme de pse tsc msr pae mce cx8
apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2
ss ht tm pbe syscall nx lm constant_tsc pebs bts pni dtes64 monitor ds_cpl
vmx est tm2 cid cx16 xtpr pdcm lahf_lm tpr_shadow vnmi</font>
<br><font size=2 face="sans-serif">bogomips &nbsp; &nbsp; &nbsp; &nbsp;:
6339.16</font>
<br><font size=2 face="sans-serif">clflush size &nbsp; &nbsp; &nbsp; &nbsp;:
64</font>
<br><font size=2 face="sans-serif">cache_alignment &nbsp; &nbsp; &nbsp;
&nbsp;: 128</font>
<br><font size=2 face="sans-serif">address sizes &nbsp; &nbsp; &nbsp; &nbsp;:
40 bits physical, 48 bits virtual</font>
<br><font size=2 face="sans-serif">power management:</font>
<br>
<br><font size=2 face="sans-serif">processor &nbsp; &nbsp; &nbsp; &nbsp;:
4</font>
<br><font size=2 face="sans-serif">vendor_id &nbsp; &nbsp; &nbsp; &nbsp;:
GenuineIntel</font>
<br><font size=2 face="sans-serif">cpu family &nbsp; &nbsp; &nbsp; &nbsp;:
15</font>
<br><font size=2 face="sans-serif">model &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;: 6</font>
<br><font size=2 face="sans-serif">model name &nbsp; &nbsp; &nbsp; &nbsp;:
Intel(R) Xeon(TM) CPU 3.16GHz</font>
<br><font size=2 face="sans-serif">stepping &nbsp; &nbsp; &nbsp; &nbsp;:
8</font>
<br><font size=2 face="sans-serif">cpu MHz &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;: 3169.236</font>
<br><font size=2 face="sans-serif">cache size &nbsp; &nbsp; &nbsp; &nbsp;:
8192 KB</font>
<br><font size=2 face="sans-serif">physical id &nbsp; &nbsp; &nbsp; &nbsp;:
1</font>
<br><font size=2 face="sans-serif">siblings &nbsp; &nbsp; &nbsp; &nbsp;:
4</font>
<br><font size=2 face="sans-serif">core id &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;: 0</font>
<br><font size=2 face="sans-serif">cpu cores &nbsp; &nbsp; &nbsp; &nbsp;:
2</font>
<br><font size=2 face="sans-serif">apicid &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;: 4</font>
<br><font size=2 face="sans-serif">initial apicid &nbsp; &nbsp; &nbsp;
&nbsp;: 4</font>
<br><font size=2 face="sans-serif">fpu &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;: yes</font>
<br><font size=2 face="sans-serif">fpu_exception &nbsp; &nbsp; &nbsp; &nbsp;:
yes</font>
<br><font size=2 face="sans-serif">cpuid level &nbsp; &nbsp; &nbsp; &nbsp;:
6</font>
<br><font size=2 face="sans-serif">wp &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;: yes</font>
<br><font size=2 face="sans-serif">flags &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;: fpu vme de pse tsc msr pae mce cx8
apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2
ss ht tm pbe syscall nx lm constant_tsc pebs bts pni dtes64 monitor ds_cpl
vmx est tm2 cid cx16 xtpr pdcm lahf_lm tpr_shadow vnmi</font>
<br><font size=2 face="sans-serif">bogomips &nbsp; &nbsp; &nbsp; &nbsp;:
6339.29</font>
<br><font size=2 face="sans-serif">clflush size &nbsp; &nbsp; &nbsp; &nbsp;:
64</font>
<br><font size=2 face="sans-serif">cache_alignment &nbsp; &nbsp; &nbsp;
&nbsp;: 128</font>
<br><font size=2 face="sans-serif">address sizes &nbsp; &nbsp; &nbsp; &nbsp;:
40 bits physical, 48 bits virtual</font>
<br><font size=2 face="sans-serif">power management:</font>
<br>
<br><font size=2 face="sans-serif">processor &nbsp; &nbsp; &nbsp; &nbsp;:
5</font>
<br><font size=2 face="sans-serif">vendor_id &nbsp; &nbsp; &nbsp; &nbsp;:
GenuineIntel</font>
<br><font size=2 face="sans-serif">cpu family &nbsp; &nbsp; &nbsp; &nbsp;:
15</font>
<br><font size=2 face="sans-serif">model &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;: 6</font>
<br><font size=2 face="sans-serif">model name &nbsp; &nbsp; &nbsp; &nbsp;:
Intel(R) Xeon(TM) CPU 3.16GHz</font>
<br><font size=2 face="sans-serif">stepping &nbsp; &nbsp; &nbsp; &nbsp;:
8</font>
<br><font size=2 face="sans-serif">cpu MHz &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;: 3169.236</font>
<br><font size=2 face="sans-serif">cache size &nbsp; &nbsp; &nbsp; &nbsp;:
8192 KB</font>
<br><font size=2 face="sans-serif">physical id &nbsp; &nbsp; &nbsp; &nbsp;:
1</font>
<br><font size=2 face="sans-serif">siblings &nbsp; &nbsp; &nbsp; &nbsp;:
4</font>
<br><font size=2 face="sans-serif">core id &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;: 0</font>
<br><font size=2 face="sans-serif">cpu cores &nbsp; &nbsp; &nbsp; &nbsp;:
2</font>
<br><font size=2 face="sans-serif">apicid &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;: 5</font>
<br><font size=2 face="sans-serif">initial apicid &nbsp; &nbsp; &nbsp;
&nbsp;: 5</font>
<br><font size=2 face="sans-serif">fpu &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;: yes</font>
<br><font size=2 face="sans-serif">fpu_exception &nbsp; &nbsp; &nbsp; &nbsp;:
yes</font>
<br><font size=2 face="sans-serif">cpuid level &nbsp; &nbsp; &nbsp; &nbsp;:
6</font>
<br><font size=2 face="sans-serif">wp &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;: yes</font>
<br><font size=2 face="sans-serif">flags &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;: fpu vme de pse tsc msr pae mce cx8
apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2
ss ht tm pbe syscall nx lm constant_tsc pebs bts pni dtes64 monitor ds_cpl
vmx est tm2 cid cx16 xtpr pdcm lahf_lm tpr_shadow vnmi</font>
<br><font size=2 face="sans-serif">bogomips &nbsp; &nbsp; &nbsp; &nbsp;:
6339.25</font>
<br><font size=2 face="sans-serif">clflush size &nbsp; &nbsp; &nbsp; &nbsp;:
64</font>
<br><font size=2 face="sans-serif">cache_alignment &nbsp; &nbsp; &nbsp;
&nbsp;: 128</font>
<br><font size=2 face="sans-serif">address sizes &nbsp; &nbsp; &nbsp; &nbsp;:
40 bits physical, 48 bits virtual</font>
<br><font size=2 face="sans-serif">power management:</font>
<br>
<br><font size=2 face="sans-serif">processor &nbsp; &nbsp; &nbsp; &nbsp;:
6</font>
<br><font size=2 face="sans-serif">vendor_id &nbsp; &nbsp; &nbsp; &nbsp;:
GenuineIntel</font>
<br><font size=2 face="sans-serif">cpu family &nbsp; &nbsp; &nbsp; &nbsp;:
15</font>
<br><font size=2 face="sans-serif">model &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;: 6</font>
<br><font size=2 face="sans-serif">model name &nbsp; &nbsp; &nbsp; &nbsp;:
Intel(R) Xeon(TM) CPU 3.16GHz</font>
<br><font size=2 face="sans-serif">stepping &nbsp; &nbsp; &nbsp; &nbsp;:
8</font>
<br><font size=2 face="sans-serif">cpu MHz &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;: 3169.236</font>
<br><font size=2 face="sans-serif">cache size &nbsp; &nbsp; &nbsp; &nbsp;:
8192 KB</font>
<br><font size=2 face="sans-serif">physical id &nbsp; &nbsp; &nbsp; &nbsp;:
1</font>
<br><font size=2 face="sans-serif">siblings &nbsp; &nbsp; &nbsp; &nbsp;:
4</font>
<br><font size=2 face="sans-serif">core id &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;: 1</font>
<br><font size=2 face="sans-serif">cpu cores &nbsp; &nbsp; &nbsp; &nbsp;:
2</font>
<br><font size=2 face="sans-serif">apicid &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;: 6</font>
<br><font size=2 face="sans-serif">initial apicid &nbsp; &nbsp; &nbsp;
&nbsp;: 6</font>
<br><font size=2 face="sans-serif">fpu &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;: yes</font>
<br><font size=2 face="sans-serif">fpu_exception &nbsp; &nbsp; &nbsp; &nbsp;:
yes</font>
<br><font size=2 face="sans-serif">cpuid level &nbsp; &nbsp; &nbsp; &nbsp;:
6</font>
<br><font size=2 face="sans-serif">wp &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;: yes</font>
<br><font size=2 face="sans-serif">flags &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;: fpu vme de pse tsc msr pae mce cx8
apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2
ss ht tm pbe syscall nx lm constant_tsc pebs bts pni dtes64 monitor ds_cpl
vmx est tm2 cid cx16 xtpr pdcm lahf_lm tpr_shadow vnmi</font>
<br><font size=2 face="sans-serif">bogomips &nbsp; &nbsp; &nbsp; &nbsp;:
6339.28</font>
<br><font size=2 face="sans-serif">clflush size &nbsp; &nbsp; &nbsp; &nbsp;:
64</font>
<br><font size=2 face="sans-serif">cache_alignment &nbsp; &nbsp; &nbsp;
&nbsp;: 128</font>
<br><font size=2 face="sans-serif">address sizes &nbsp; &nbsp; &nbsp; &nbsp;:
40 bits physical, 48 bits virtual</font>
<br><font size=2 face="sans-serif">power management:</font>
<br>
<br><font size=2 face="sans-serif">processor &nbsp; &nbsp; &nbsp; &nbsp;:
7</font>
<br><font size=2 face="sans-serif">vendor_id &nbsp; &nbsp; &nbsp; &nbsp;:
GenuineIntel</font>
<br><font size=2 face="sans-serif">cpu family &nbsp; &nbsp; &nbsp; &nbsp;:
15</font>
<br><font size=2 face="sans-serif">model &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;: 6</font>
<br><font size=2 face="sans-serif">model name &nbsp; &nbsp; &nbsp; &nbsp;:
Intel(R) Xeon(TM) CPU 3.16GHz</font>
<br><font size=2 face="sans-serif">stepping &nbsp; &nbsp; &nbsp; &nbsp;:
8</font>
<br><font size=2 face="sans-serif">cpu MHz &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;: 3169.236</font>
<br><font size=2 face="sans-serif">cache size &nbsp; &nbsp; &nbsp; &nbsp;:
8192 KB</font>
<br><font size=2 face="sans-serif">physical id &nbsp; &nbsp; &nbsp; &nbsp;:
1</font>
<br><font size=2 face="sans-serif">siblings &nbsp; &nbsp; &nbsp; &nbsp;:
4</font>
<br><font size=2 face="sans-serif">core id &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;: 1</font>
<br><font size=2 face="sans-serif">cpu cores &nbsp; &nbsp; &nbsp; &nbsp;:
2</font>
<br><font size=2 face="sans-serif">apicid &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;: 7</font>
<br><font size=2 face="sans-serif">initial apicid &nbsp; &nbsp; &nbsp;
&nbsp;: 7</font>
<br><font size=2 face="sans-serif">fpu &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;: yes</font>
<br><font size=2 face="sans-serif">fpu_exception &nbsp; &nbsp; &nbsp; &nbsp;:
yes</font>
<br><font size=2 face="sans-serif">cpuid level &nbsp; &nbsp; &nbsp; &nbsp;:
6</font>
<br><font size=2 face="sans-serif">wp &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;: yes</font>
<br><font size=2 face="sans-serif">flags &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;: fpu vme de pse tsc msr pae mce cx8
apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2
ss ht tm pbe syscall nx lm constant_tsc pebs bts pni dtes64 monitor ds_cpl
vmx est tm2 cid cx16 xtpr pdcm lahf_lm tpr_shadow vnmi</font>
<br><font size=2 face="sans-serif">bogomips &nbsp; &nbsp; &nbsp; &nbsp;:
6339.29</font>
<br><font size=2 face="sans-serif">clflush size &nbsp; &nbsp; &nbsp; &nbsp;:
64</font>
<br><font size=2 face="sans-serif">cache_alignment &nbsp; &nbsp; &nbsp;
&nbsp;: 128</font>
<br><font size=2 face="sans-serif">address sizes &nbsp; &nbsp; &nbsp; &nbsp;:
40 bits physical, 48 bits virtual</font>
<br><font size=2 face="sans-serif">power management:</font>
<br>
<br><font size=2 face="sans-serif">remove test cases which require the
block device.</font>
<br><font size=2 face="sans-serif">You can specify it with option -b</font>
<br><font size=2 face="sans-serif">COMMAND: &nbsp; &nbsp;/opt/ltp/bin/ltp-pan
&nbsp;-e -S &nbsp; -a 12064 &nbsp; &nbsp; -n 12064 &nbsp;-p &nbsp;-f /tmp/ltp-P00GfUUqLS/alltests
-l /opt/ltp/results/LTP_RUN_ON-2010_Mar_02-04h_14m_57s.log &nbsp;-C /opt/ltp/output/LTP_RUN_ON-2010_Mar_02-04h_14m_57s.failed</font>
<br><font size=2 face="sans-serif">LOG File: /opt/ltp/results/LTP_RUN_ON-2010_Mar_02-04h_14m_57s.log</font>
<br><font size=2 face="sans-serif">FAILED COMMAND File: /opt/ltp/output/LTP_RUN_ON-2010_Mar_02-04h_14m_57s.failed</font>
<br><font size=2 face="sans-serif">Running tests.......</font>
<br><font size=2 face="sans-serif">&lt;&lt;&lt;test_start&gt;&gt;&gt;</font>
<br><font size=2 face="sans-serif">tag=Filecaps stime=1267521297</font>
<br><font size=2 face="sans-serif">cmdline=&quot;filecapstest.sh&quot;</font>
<br><font size=2 face="sans-serif">contacts=&quot;&quot;</font>
<br><font size=2 face="sans-serif">analysis=exit</font>
<br><font size=2 face="sans-serif">&lt;&lt;&lt;test_output&gt;&gt;&gt;</font>
<br><font size=2 face="sans-serif">incrementing stop</font>
<br><font size=2 color=red face="sans-serif">Filecaps 0 CONF : System doesn't
support execution of the test</font>
<br><font size=2 color=red face="sans-serif">setcap not installed. Please
install libcap-2.11 or newer from</font>
<br><font size=2 color=red face="sans-serif">ftp://ftp.kernel.org/pub/linux/libs/security/linux-privs/libcap2</font>
<br><font size=2 face="sans-serif">&lt;&lt;&lt;execution_status&gt;&gt;&gt;</font>
<br><font size=2 face="sans-serif">initiation_status=&quot;ok&quot;</font>
<br><font size=2 face="sans-serif">duration=0 termination_type=exited termination_id=0
corefile=no</font>
<br><font size=2 face="sans-serif">cutime=0 cstime=0</font>
<br><font size=2 face="sans-serif">&lt;&lt;&lt;test_end&gt;&gt;&gt;</font>
<br><font size=2 face="sans-serif">INFO: ltp-pan reported all tests PASS</font>
<br><font size=2 face="sans-serif">LTP Version: LTP-20100131</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; </font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp;###############################################################&quot;</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; </font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
Done executing testcases.&quot;</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
LTP Version: &nbsp;LTP-20100131</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp;###############################################################&quot;</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp;</font>
<br><font size=2 face="sans-serif">mx3950:/opt/ltp #</font>
<br>
<br><font size=2 face="sans-serif">---------------------------------------------------------------------------------------------------------------------------------------------------</font>
<br>
<br><font size=2 face="sans-serif">LTP reports setcap is installed, but
actually, my system has setcap installed, along with all required libcap
related rpms.</font>
<br>
<br><font size=2 face="sans-serif">mx3950:/opt/ltp # setc</font>
<br><font size=2 face="sans-serif">setcap &nbsp; &nbsp; &nbsp;setconsole
&nbsp;setctsid &nbsp; &nbsp;</font>
<br><font size=2 face="sans-serif">mx3950:/opt/ltp #</font>
<br>
<br><font size=2 face="sans-serif">mx3950:/opt/ltp # rpm -qa | grep cap</font>
<br><font size=2 face="sans-serif">libcap1-1.10-6.10</font>
<br><font size=2 face="sans-serif">libcap2-2.11-2.15</font>
<br><font size=2 face="sans-serif">libcap-progs-2.11-2.15</font>
<br><font size=2 face="sans-serif">libpcap0-0.9.8-50.4.32</font>
<br><font size=2 face="sans-serif">libcap2-32bit-2.11-2.15</font>
<br><font size=2 face="sans-serif">libcap1-32bit-1.10-6.10</font>
<br><font size=2 face="sans-serif">mx3950:/opt/ltp # </font>
<br><font size=2 face="sans-serif">---------------------------------------------------------------------------------------------------------------------------------------------------</font>
<br>
<br>
<br><font size=2 face="sans-serif">Here is the false positive log, which
shows test PASSED, without actually running the test.</font>
<br>
<br><font size=2 face="sans-serif">---------------------------------------------------------------------------------------------------------------------------------------------------</font>
<br>
<br><font size=2 face="sans-serif">mx3950:/opt/ltp # cat results/LTP_RUN_ON-2010_Mar_02-04h_14m_57s.log
</font>
<br><font size=2 face="sans-serif">Test Start Time: Tue Mar &nbsp;2 04:14:57
2010</font>
<br><font size=2 face="sans-serif">-----------------------------------------</font>
<br><font size=2 face="sans-serif">Testcase &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Result &nbsp; &nbsp; Exit
Value</font>
<br><font size=2 face="sans-serif">-------- &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ------ &nbsp; &nbsp; ----------</font>
<br><font size=2 face="sans-serif">Filecaps &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; PASS &nbsp; &nbsp; &nbsp;
0 &nbsp; &nbsp;</font>
<br>
<br><font size=2 face="sans-serif">-----------------------------------------------</font>
<br><font size=2 face="sans-serif">Total Tests: 1</font>
<br><font size=2 face="sans-serif">Total Failures: 0</font>
<br><font size=2 face="sans-serif">Kernel Version: 2.6.32.8-default</font>
<br><font size=2 face="sans-serif">Machine Architecture: x86_64</font>
<br><font size=2 face="sans-serif">Hostname: mx3950</font>
<br>
<br><font size=2 face="sans-serif">mx3950:/opt/ltp # </font>
<br><font size=2 face="sans-serif">---------------------------------------------------------------------------------------------------------------------------------------------------</font>
<br>
<br><font size=2 face="sans-serif">Thanks!</font>
<br><font size=2 face="sans-serif">-Iranna D Ankad<br>
----------------------------------------------------------------------------------------------------<br>
Linux-Technology Center, IBM India Software Labs<br>
Manyata Embassy Park, BENGALURU - 560045,<br>
Ph: +91-080-28055007 &nbsp; Extn: 55007<br>
----------------------------------------------------------------------------------------------------<br>
&quot;If you don't have patience to test the software, the software will
test your patience !!&quot;</font>
--=_alternative 00384F2D652576DA_=--


--===============5633764347359839684==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
--===============5633764347359839684==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5633764347359839684==--

