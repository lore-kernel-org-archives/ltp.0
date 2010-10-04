Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hannuxx@gmail.com>) id 1P2rDK-0002FS-CR
	for ltp-list@lists.sourceforge.net; Mon, 04 Oct 2010 20:00:46 +0000
Received: from mail-bw0-f47.google.com ([209.85.214.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1P2rDJ-0005Je-66
	for ltp-list@lists.sourceforge.net; Mon, 04 Oct 2010 20:00:46 +0000
Received: by bwz2 with SMTP id 2so5538513bwz.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 04 Oct 2010 13:00:39 -0700 (PDT)
Date: Mon, 4 Oct 2010 23:00:37 +0300
From: Hannu Heikkinen <hannuxx@iki.fi>
Message-ID: <20101004200037.GC997@debian-master.elisa-laajakaista.fi>
References: <4CA09D4D.6050708@st.com> <4CA34070.9070505@st.com>
	<20100930133120.GA4070@hannu-debian.research.nokia.com>
	<4CA469A0.5090700@st.com> <20101001040609.GA2090@hannu-ubuntu>
	<4CA9D0EB.5090309@st.com>
	<AANLkTim_Ay4yjdBfm8tzEiK_z4JzQyg6RRsR3E1tCH9h@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
In-Reply-To: <AANLkTim_Ay4yjdBfm8tzEiK_z4JzQyg6RRsR3E1tCH9h@mail.gmail.com>
Subject: Re: [LTP] ltp_clone alignment issues.
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 04/10/10 06:28 -0700, Garrett Cooper wrote:
> 
>     I believe this is already handled to some degree with the clone
> testcases. If not that should be added and I'll review patches which
> add this testing to LTP.
>     On a semi-unrelated note could you guys please test out the
> attached patch to make sure that there isn't a functional difference
> if you have access to ia64, s390, etc?
> Thanks,
> -Garrett

Hi,

after that CHILD_STACK_SIZE (def for as it has been 16384) tests passed in
AMD64 - Debian 64-bit and BeagleBoard 32-bit ARM (std linux-2.6 with
omap3_defconfig).

Test files are attached. I ran clones in /opt/ltp/testcases/bin straight.

br,
Hannu


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=clone-test-amd64

[hannu-debian:~:] uname -a
Linux hannu-debian 2.6.32-5-amd64 #1 SMP Fri Sep 17 21:50:19 UTC 2010 x86_64 GNU/Linux

root@hannu-debian:/opt/ltp/testcases/bin# cat /proc/cpuinfo 
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 15
model		: 107
model name	: AMD Athlon(tm) 64 X2 Dual Core Processor 4000+
stepping	: 1
cpu MHz		: 2099.700
cache size	: 512 KB
physical id	: 0
siblings	: 2
core id		: 0
cpu cores	: 2
apicid		: 0
initial apicid	: 0
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt rdtscp lm 3dnowext 3dnow rep_good extd_apicid pni cx16 lahf_lm cmp_legacy svm extapic cr8_legacy 3dnowprefetch
bogomips	: 4199.40
TLB size	: 1024 4K pages
clflush size	: 64
cache_alignment	: 64
address sizes	: 40 bits physical, 48 bits virtual
power management: ts fid vid ttp tm stc 100mhzsteps

processor	: 1
vendor_id	: AuthenticAMD
cpu family	: 15
model		: 107
model name	: AMD Athlon(tm) 64 X2 Dual Core Processor 4000+
stepping	: 1
cpu MHz		: 2099.700
cache size	: 512 KB
physical id	: 0
siblings	: 2
core id		: 1
cpu cores	: 2
apicid		: 1
initial apicid	: 1
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt rdtscp lm 3dnowext 3dnow rep_good extd_apicid pni cx16 lahf_lm cmp_legacy svm extapic cr8_legacy 3dnowprefetch
bogomips	: 4199.99
TLB size	: 1024 4K pages
clflush size	: 64
cache_alignment	: 64
address sizes	: 40 bits physical, 48 bits virtual
power management: ts fid vid ttp tm stc 100mhzsteps


root@hannu-debian:/opt/ltp/testcases/bin# ./clone01
clone01     1  TPASS  :  clone() returned 7639
root@hannu-debian:/opt/ltp/testcases/bin# ./clone02
clone02     1  TPASS  :  Test Passed
clone02     2  TPASS  :  Test Passed
root@hannu-debian:/opt/ltp/testcases/bin# ./clone03
clone03     1  TPASS  :  Test passed
root@hannu-debian:/opt/ltp/testcases/bin# ./clone04
clone04     1  TPASS  :  expected failure; Got EINVAL
root@hannu-debian:/opt/ltp/testcases/bin# ./clone05
clone05     1  TPASS  :  Test Passed
root@hannu-debian:/opt/ltp/testcases/bin# ./clone06
clone06     1  TPASS  :  Test Passed
root@hannu-debian:/opt/ltp/testcases/bin# ./clone07
clone07     1  TPASS  :  Use of return() in child did not cause SIGSEGV




--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=clone-test-arm32

#1 Test BeagleBoard:

root@beagleboard:/opt/ltp/testcases/bin# uname -a
Linux beagleboard 2.6.36-rc4-08510-g0cbe681-dirty #2 Sat Sep 18 12:54:00 EEST 2010 armv7l unknown

root@beagleboard:/opt/ltp/testcases/bin# cat /proc/cpuinfo
Processor       : ARMv7 Processor rev 3 (v7l)
BogoMIPS        : 482.11
Features        : swp half thumb fastmult vfp edsp thumbee neon vfpv3
CPU implementer : 0x41
CPU architecture: 7
CPU variant     : 0x1
CPU part        : 0xc08
CPU revision    : 3

Hardware        : OMAP3 Beagle Board
Revision        : 0020
Serial          : 0000000000000000
root@beagleboard:/opt/ltp/testcases/bin# ./clone01
clone01     1  TPASS  :  clone() returned 1957
root@beagleboard:/opt/ltp/testcases/bin# ./clone02
clone02     1  TPASS  :  Test Passed
clone02     2  TPASS  :  Test Passed
root@beagleboard:/opt/ltp/testcases/bin# ./clone03
clone03     1  TPASS  :  Test passed
root@beagleboard:/opt/ltp/testcases/bin# ./clone04
clone04     1  TPASS  :  expected failure; Got EINVAL
root@beagleboard:/opt/ltp/testcases/bin# ./clone05
clone05     1  TPASS  :  Test Passed
root@beagleboard:/opt/ltp/testcases/bin# ./clone06
clone06     1  TPASS  :  Test Passed
root@beagleboard:/opt/ltp/testcases/bin# ./clone07
clone07     1  TPASS  :  Use of return() in child did not cause SIGSEGV



--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Virtualization is moving to the mainstream and overtaking non-virtualized
environment for deploying applications. Does it make network security 
easier or more difficult to achieve? Read this whitepaper to separate the 
two and get a better understanding.
http://p.sf.net/sfu/hp-phase2-d2d
--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--WIyZ46R2i8wDzkSu--

