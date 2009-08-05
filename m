Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MYkii-0005bc-2V
	for ltp-list@lists.sourceforge.net; Wed, 05 Aug 2009 17:56:12 +0000
Received: from e38.co.us.ibm.com ([32.97.110.159])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MYkid-0007uU-PX
	for ltp-list@lists.sourceforge.net; Wed, 05 Aug 2009 17:56:12 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e38.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n75HqTDe003202
	for <ltp-list@lists.sourceforge.net>; Wed, 5 Aug 2009 11:52:29 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n75Htkhe154488
	for <ltp-list@lists.sourceforge.net>; Wed, 5 Aug 2009 11:55:47 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n75HtjXA015792
	for <ltp-list@lists.sourceforge.net>; Wed, 5 Aug 2009 11:55:45 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <20090805105529.23399.60242.sendpatchset@subratamodak.linux.ibm.com>
References: <20090805105529.23399.60242.sendpatchset@subratamodak.linux.ibm.com>
Content-Type: multipart/mixed; boundary="=-JjBnzbp098IIo+gFZaX6"
Date: Wed, 05 Aug 2009 23:25:39 +0530
Message-Id: <1249494939.3623.12.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Integration of MCE test suite into LTP
Reply-To: subrata@linux.vnet.ibm.com
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
To: Huang Ying <ying.huang@intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>, ltp-list@lists.sourceforge.net


--=-JjBnzbp098IIo+gFZaX6
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Huang Ying,

On Wed, 2009-08-05 at 16:25 +0530, Subrata Modak wrote:
> Hi Huang Ying,
> 
> >On Tue, 2009-06-30 at 10:56 +0800, Huang Ying wrote:
> >Hi, All,
> > 
> > We are working on a test suite to test the Linux kernel MCE handling
> > logic named mce-test, which can be find at:
> > git://git.kernel.org/pub/scm/utils/cpu/mce/mce-test.git. There is a
> > HOWTO for it, which is attached with the mail.
> > 
> > We think the testing target of mce-test is part of that of LTP, so it is
> > better to integrate mce-test into LTP. Do you think so?
> > 
> > As for integration scheme, maybe we can first add mce-test into LTP as a
> > separate test case, just as kdump test case. What's your opinions?
> > 
> > Any comment is welcome!
> > 
> 
> Sorry for the very late response to your proposal. Please find below the
> first patch which will integrate the existing mce-test to LTP. I had just
> done a sanity checking of building it. The following patch will still need:
> 
> 1) Exclusive testing and sharing those results with the LTP community,

My initial first tests results are:

# uname -a
Linux x206f 2.6.29-gcov #1 SMP Fri Jun 19 12:14:27 IST 2009 i686 i686
i386 GNU/Linux

# grep -i mce ../../kernels/linux-2.6.29/.config 
CONFIG_X86_MCE=y
# CONFIG_X86_MCE_NONFATAL is not set
CONFIG_X86_MCE_P4THERMAL=y

# which gcov
/usr/bin/gcov

# grep -i cov ../../kernels/linux-2.6.29/.config 
# Linux kernel version: 2.6.29-gcov
# GCOV coverage profiling
CONFIG_GCOV_PROFILE=y
CONFIG_GCOV_ALL=y
CONFIG_GCOV_PROC=m
CONFIG_GCOV_HAMMER=y

# which mcelog
/usr/sbin/mcelog

# which mce-inject
/usr/sbin/mce-inject

# cat /proc/cpuinfo 
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 3
model name      : Intel(R) Pentium(R) 4 CPU 2.80GHz
stepping        : 4
cpu MHz         : 2800.490
cache size      : 1024 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 1
apicid          : 0
initial apicid  : 0
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
constant_tsc pebs bts pni dtes64 monitor ds_cpl cid xtpr
bogomips        : 5600.98
clflush size    : 64
power management:

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 3
model name      : Intel(R) Pentium(R) 4 CPU 2.80GHz
stepping        : 4
cpu MHz         : 2800.490
cache size      : 1024 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 1
apicid          : 1
initial apicid  : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
constant_tsc pebs bts pni dtes64 monitor ds_cpl cid xtpr
bogomips        : 5600.04
clflush size    : 64
power management:

# vi Makefile 
test-simple:
        $(MAKE) reset
        #./drivers/simple/driver.sh simple.conf
        ./drivers/simple/driver.sh simple_non_panic.conf

# make test-simple
make reset
make[1]: Entering directory `/root/subrata/ltp/mce-test'
rm -rf work/*
rm -rf results/*
make[1]: Leaving directory `/root/subrata/ltp/mce-test'
#./drivers/simple/driver.sh simple.conf
./drivers/simple/driver.sh simple_non_panic.conf
gcov is not supported by kernel, or there is no gcov utility installed,
disable gcov support.
/root/subrata/ltp/mce-test/lib/mce.sh: line
304: /sys/devices/system/machinecheck/machinecheck0/fake_panic: No such
file or directory

soft-inj/non-panic/corrected:
  Failed: can not get mce log from /dev/mcelog
  Failed: MCE log is different from input
  Passed: No kernel warning or bug
/root/subrata/ltp/mce-test/lib/mce.sh: line
304: /sys/devices/system/machinecheck/machinecheck0/fake_panic: No such
file or directory
/root/subrata/ltp/mce-test/lib/mce.sh: line
304: /sys/devices/system/machinecheck/machinecheck0/fake_panic: No such
file or directory

soft-inj/non-panic/corrected_hold:
  Failed: can not get mce log from /dev/mcelog
  Failed: MCE log is different from input
  Passed: No kernel warning or bug
/root/subrata/ltp/mce-test/lib/mce.sh: line
304: /sys/devices/system/machinecheck/machinecheck0/fake_panic: No such
file or directory
/root/subrata/ltp/mce-test/lib/mce.sh: line
304: /sys/devices/system/machinecheck/machinecheck0/fake_panic: No such
file or directory

soft-inj/non-panic/corrected_no_en:
  Failed: can not get mce log from /dev/mcelog
  Failed: MCE log is different from input
  Passed: No kernel warning or bug
/root/subrata/ltp/mce-test/lib/mce.sh: line
304: /sys/devices/system/machinecheck/machinecheck0/fake_panic: No such
file or directory
/root/subrata/ltp/mce-test/lib/mce.sh: line
304: /sys/devices/system/machinecheck/machinecheck0/fake_panic: No such
file or directory

soft-inj/non-panic/corrected_over:
  Failed: can not get mce log from /dev/mcelog
  Failed: MCE log is different from input
  Passed: No kernel warning or bug
/root/subrata/ltp/mce-test/lib/mce.sh: line
304: /sys/devices/system/machinecheck/machinecheck0/fake_panic: No such
file or directory

Please also find the results attached.

Some inconsistencies:
1) GCOV is already built in the booted kernel, still the error message,
2) Absence of /sys/devices/system/machinecheck/ though the
kernel .config suggests that:
CONFIG_X86_MCE=y
# CONFIG_X86_MCE_NONFATAL is not set
CONFIG_X86_MCE_P4THERMAL=y

Is there something i am missing in the setup ?

Regards--
Subrata

> 2) Comments for and rewriting of this patch for coding styles,
> 3) Sign off from Huang Ying <ying.huang@intel.com>, or, the concerned Authors,
> 
> Patch-created-for-ltp-integration-by: Subrata Modak<subrata@linux.vnet.ibm.com>
> Signed-off-by-is-still-required-from: Huang Ying <ying.huang@intel.com>
> ---

> ---
> Regards--
> Subrata
> 
> > 
> > Best Regards,
> > Huang Ying

--=-JjBnzbp098IIo+gFZaX6
Content-Disposition: attachment; filename=results.tgz
Content-Type: application/x-compressed-tar; name=results.tgz
Content-Transfer-Encoding: base64

H4sIANLPeUoAA+2bS1PbMBSFs/av0LozbfSy3bKjKe0wHR5D6JoJiUhdgs3IDu3Pr2ynkKRQc91Y
gcn5No4f4Toc3ysdybImn8+KvN/rEO6I47DeRnqxrfcX9ISQKlI6irk7L7iWvMfCLm/qD/O8GFnG
eoXJCx/xXhh2of+7aVIk0zSzZvMxSoGje90f01/W+kutdRg5/aXmosf45m/lb3Zc/zfBtu8AbJM/
+Z8nN7cz000zUOV7eJ/v69vl+h9LXuV/GErP9d9m2T/zv+n8K2VN/3p3wzGq+q/1U/oLEeuH9l9L
p7/mUnqu/zuqf5BnV8XbJP3RT7P07e0oTcb9cWatGRdmshcw9nmUzNwnNh6lLM0KNjUFuxkbNsum
7MpmN6w/MXd9d8QdWLr8aHBQXZLkbJJcXRlr0qK+Pklv54W78nSU5+WVxxm7NjY1M/ZzZNMknbLM
ssv5NPjnrV18z2Yv+v7S7MKkL/kGsztjt3t/2372wV/1//6J2WQMQvu/8H9a8RDtvw+e0v+hYvx/
DJL+Sjn9IxEL6O+DZv1Xm9w2jwNJf9fx41IIHUN/H5D1v3aNPjFGQ///Ef2lawLQ//cBWf+6I0iK
0UJ/JSPo7wOy/tYUc5uSYjTrLx/0F6rU3//4747qL+DCdpqW9f/CGmf5nxmjKf9VGK3VfxXKGPnv
g8HpN8aDj/vHX5kIzocDxn/x4Pzw6MAdPTs8LXf5Xnns6HBxcv/TpzP3YXQ5ngTD8/3zb0O390Hz
FYKjwZf7kzw4PTsZHAyHJ+6L1R8LyrCiDitJYd1jotuH3fZ/++VBzv/MJtMLmgmg9/8UV+j/e4Gi
fzWk3WIAoBT4+eM/lf9X3t//gP7P1J8+AEDK/0p/KaIQ+e8Duv70AYAW+usY/T8v0PWnDwA06y/X
x3/CEP7fC/D/u03b+k8ZAGjKf6XEWv1XUYz898KS/1ckI84fXPh7vgrB/PO2MWH1NwM9/+kDAPT+
n7N/6P97gaJ/+cZY5/P/up7/jyP4fx+Q9e96/l/X8/9aIf99QNa/6/n/Wn8Vov57gax/1/P/qp7/
Vxz6+wD+f7dpWf83O/+/7P91Pf+vMf7rhSX/T5uIX/LiE74K/P/rgZz/Xc//1/nPI/T/vUDQv/VK
kFLg567/FVGpf7kCFP7fBxT9W1j/ClL+V+//CvcF5L8PKPq3sP4VLfSv3v+B/t1D0b+F9a9o1l+u
rv90+sdo/70A/7/b0Os/yfpXNOV/5JJ9bf1PKJH/Xtj++//dDQFQFxlUP+nxdQZj+s/jr2KEg5L/
Lax/Bb3/JznWfwIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAE/zG3KBtAQAeAAA


--=-JjBnzbp098IIo+gFZaX6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--=-JjBnzbp098IIo+gFZaX6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--=-JjBnzbp098IIo+gFZaX6--


