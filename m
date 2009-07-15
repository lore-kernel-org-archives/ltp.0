Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <macli@brc.ubc.ca>) id 1MR8Q9-0004Kg-PK
	for ltp-list@lists.sourceforge.net; Wed, 15 Jul 2009 17:37:33 +0000
Received: from sparc.brc.ubc.ca ([137.82.2.12])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MR8Q5-0000Iw-1E
	for ltp-list@lists.sourceforge.net; Wed, 15 Jul 2009 17:37:33 +0000
Received: from mail (unknown [137.82.2.7])
	by sparc.brc.ubc.ca (Postfix) with ESMTP id D57965227210
	for <ltp-list@lists.sourceforge.net>;
	Wed, 15 Jul 2009 10:42:41 -0700 (PDT)
Date: Wed, 15 Jul 2009 10:55:36 -0700 (PDT)
From: "Li, Ming Chun" <macli@brc.ubc.ca>
Message-ID: <alpine.DEB.1.00.0907151048120.3370@mail.selltech.ca>
MIME-Version: 1.0
Subject: [LTP] LTP hung on 2.6.31-rc3 kernel and buffer overflow detected
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net


I started to run runalltests.sh yesterday on 2.6.31-rc3 kernel, It seems 
stopped yesterday and I have got following message on the running console:

------------
root@kernelhack:/usr/src/ltp-full-20090630# ./runalltests.sh
-e *******************************************************************
-e *******************************************************************
-e **                                                               **
-e ** This script is being re-written to cover all aspects of    **
-e ** testing LTP, which includes running all those tests which  **
-e ** are not run by default with ./runltp script. Special setup **
-e ** in system environment will be done to run all those tests  **
-e ** like the File System tests, SELinuxtest, etc               **
-e **                                                               **
-e *******************************************************************
-e *******************************************************************
-e Running Default LTP...
INFO: creating /usr/src/ltp-full-20090630/output directory
INFO: creating /usr/src/ltp-full-20090630/results directory

    INFO: no command files were provided, using default,
          system calls, memory management, IPC, scheduler
          direct io, file system, math and pty tests will
          now be executed

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Checking for required user/group ids

DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=9.04
DISTRIB_CODENAME=jaunty
DISTRIB_DESCRIPTION="Ubuntu 9.04"
Linux kernelhack 2.6.31-rc3-custom #1 SMP Tue Jul 14 11:41:06 PDT 2009 
i686 GNU/Linux

Gnu C                  gcc (Ubuntu 4.3.3-5ubuntu4) 4.3.3
Gnu make               3.81
'nobody' user id and group found.
'bin' user id and group found.
'daemon' user id and group found.
Users group found.
Sys group found.
util-linux             ng 2.14.2)
mount                  ng 2.14.2 (with libvolume_id and selinux support)

Required users/groups exist.
modutils               3.7-pre9
e2fsprogs              1.41.4
PPP                    2.4.5
Linux C Library        > libc.2.9
Dynamic linker (ldd)   2.9
Procps                 3.2.7
Net-tools              1.60
Kbd                    1.14.1
Sh-utils               6.10
Modules Loaded         binfmt_misc ppdev bridge stp bnep video output 
ipt_REJECT ipt_LOG xt_limit xt_tcpudp xt_state ipt_addrtype 
ip6table_filter ip6_tables nf_nat_irc nf_conntrack_irc nf_nat_ftp nf_nat 
nf_conntrack_ipv4 nf_defrag_ipv4 nf_conntrack_ftp nf_conntrack 
iptable_filter ip_tables x_tables lp parport i3000_edac serio_raw pcspkr 
iTCO_wdt iTCO_vendor_support edac_core usbhid tg3

free reports:
             total       used       free     shared    buffers     cached
Mem:        959704     637624     322080          0      36284     381988
-/+ buffers/cache:     219352     740352
Swap:      3002360      14960    2987400

/proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 15
model name      : Intel(R) Xeon(R) CPU            3040  @ 1.86GHz
stepping        : 2
cpu MHz         : 1862.034
cache size      : 2048 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 2
apicid          : 0
initial apicid  : 0
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 10
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm 
constant_tsc arch_perfmon pebs bts pni dtes64 monitor ds_cpl vmx est tm2 
ssse3 cx16 xtpr pdcm lahf_lm tpr_shadow
bogomips        : 3724.06
clflush size    : 64
power management:

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 15
model name      : Intel(R) Xeon(R) CPU            3040  @ 1.86GHz
stepping        : 2
cpu MHz         : 1862.034
cache size      : 2048 KB
physical id     : 0
siblings        : 2
core id         : 1
cpu cores       : 2
apicid          : 1
initial apicid  : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 10
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm 
constant_tsc arch_perfmon pebs bts pni dtes64 monitor ds_cpl vmx est tm2 
ssse3 cx16 xtpr pdcm lahf_lm tpr_shadow
bogomips        : 3724.10
clflush size    : 64
power management:

remove test cases which require the block device.
You can specify it with option -b
-e LOG File: 
/usr/src/ltp-full-20090630/results/LTP_RUN_ON-2009_Jul_14-14h_15m_46s.log
-e OUTPUT File: 
/usr/src/ltp-full-20090630/output/LTP_RUN_ON-2009_Jul_14-14h_15m_46s.output
-e FAILED COMMAND File: 
/usr/src/ltp-full-20090630/output/LTP_RUN_ON-2009_Jul_14-14h_15m_46s.failed
HTML File: /usr/src/ltp-full-20090630/output/2009_Jul_14-14h_15m_46s.html
Running tests.......
*** buffer overflow detected ***: growfiles terminated
======= Backtrace: =========
/lib/tls/i686/cmov/libc.so.6(__fortify_fail+0x48)[0xb7e5dda8]
/lib/tls/i686/cmov/libc.so.6[0xb7e5beb0]
/lib/tls/i686/cmov/libc.so.6[0xb7e5b5a8]
/lib/tls/i686/cmov/libc.so.6(_IO_default_xsputn+0xc8)[0xb7dcdbb8]
/lib/tls/i686/cmov/libc.so.6(_IO_vfprintf+0x6f3)[0xb7d9ff23]
/lib/tls/i686/cmov/libc.so.6(__vsprintf_chk+0xa4)[0xb7e5b654]
/lib/tls/i686/cmov/libc.so.6(__sprintf_chk+0x2d)[0xb7e5b59d]
growfiles[0x804dd52]
/lib/tls/i686/cmov/libc.so.6(__libc_start_main+0xe5)[0xb7d76775]
growfiles[0x8049441]
======= Memory map: ========
08048000-08059000 r-xp 00000000 fc:00 2525778    
/usr/src/ltp-full-20090630/testcases/bin/growfiles
08059000-0805a000 r--p 00010000 fc:00 2525778    
/usr/src/ltp-full-20090630/testcases/bin/growfiles
0805a000-0805b000 rw-p 00011000 fc:00 2525778    
/usr/src/ltp-full-20090630/testcases/bin/growfiles
0805b000-08060000 rw-p 00000000 00:00 0
087fd000-0881f000 rw-p 00000000 00:00 0          [heap]
b7d50000-b7d5d000 r-xp 00000000 fc:00 573453     /lib/libgcc_s.so.1
b7d5d000-b7d5e000 r--p 0000c000 fc:00 573453     /lib/libgcc_s.so.1
b7d5e000-b7d5f000 rw-p 0000d000 fc:00 573453     /lib/libgcc_s.so.1
b7d5f000-b7d60000 rw-p 00000000 00:00 0
b7d60000-b7ebc000 r-xp 00000000 fc:00 573599     
/lib/tls/i686/cmov/libc-2.9.so
b7ebc000-b7ebd000 ---p 0015c000 fc:00 573599     
/lib/tls/i686/cmov/libc-2.9.so
b7ebd000-b7ebf000 r--p 0015c000 fc:00 573599     
/lib/tls/i686/cmov/libc-2.9.so
b7ebf000-b7ec0000 rw-p 0015e000 fc:00 573599     
/lib/tls/i686/cmov/libc-2.9.so
b7ec0000-b7ec4000 rw-p 00000000 00:00 0
b7ec4000-b7ed9000 r-xp 00000000 fc:00 573615     
/lib/tls/i686/cmov/libpthread-2.9.so
b7ed9000-b7eda000 r--p 00014000 fc:00 573615     
/lib/tls/i686/cmov/libpthread-2.9.so
b7eda000-b7edb000 rw-p 00015000 fc:00 573615     
/lib/tls/i686/cmov/libpthread-2.9.so
b7edb000-b7edd000 rw-p 00000000 00:00 0
b7edd000-b7ee4000 r-xp 00000000 fc:00 573617     
/lib/tls/i686/cmov/librt-2.9.so
b7ee4000-b7ee5000 r--p 00006000 fc:00 573617     
/lib/tls/i686/cmov/librt-2.9.so
b7ee5000-b7ee6000 rw-p 00007000 fc:00 573617     
/lib/tls/i686/cmov/librt-2.9.so
b7ee6000-b7ee8000 rw-p 00000000 00:00 0
b7ee8000-b7ee9000 r-xp 00000000 00:00 0          [vdso]
b7ee9000-b7f05000 r-xp 00000000 fc:00 573454     /lib/ld-2.9.so
b7f05000-b7f06000 r--p 0001b000 fc:00 573454     /lib/ld-2.9.so
b7f06000-b7f07000 rw-p 0001c000 fc:00 573454     /lib/ld-2.9.so
bfd14000-bfd29000 rw-p 00000000 00:00 0          [stack]

*** buffer overflow detected ***: ftest03 terminated
======= Backtrace: =========
/lib/tls/i686/cmov/libc.so.6(__fortify_fail+0x48)[0xb7ea8da8]
/lib/tls/i686/cmov/libc.so.6[0xb7ea6eb0]
/lib/tls/i686/cmov/libc.so.6[0xb7ea65a8]
/lib/tls/i686/cmov/libc.so.6(_IO_default_xsputn+0xc8)[0xb7e18bb8]
/lib/tls/i686/cmov/libc.so.6(_IO_vfprintf+0xf4c)[0xb7deb77c]
/lib/tls/i686/cmov/libc.so.6(__vsprintf_chk+0xa4)[0xb7ea6654]
/lib/tls/i686/cmov/libc.so.6(__sprintf_chk+0x2d)[0xb7ea659d]
ftest03[0x804a891]
ftest03[0x804a94b]
/lib/tls/i686/cmov/libc.so.6(__libc_start_main+0xe5)[0xb7dc1775]
ftest03[0x8049471]
======= Memory map: ========
08048000-0804f000 r-xp 00000000 fc:00 2525788    
/usr/src/ltp-full-20090630/testcases/bin/ftest03
0804f000-08050000 r--p 00006000 fc:00 2525788    
/usr/src/ltp-full-20090630/testcases/bin/ftest03
08050000-08051000 rw-p 00007000 fc:00 2525788    
/usr/src/ltp-full-20090630/testcases/bin/ftest03
08051000-08056000 rw-p 00000000 00:00 0
0853b000-0855c000 rw-p 00000000 00:00 0          [heap]
b7d9b000-b7da8000 r-xp 00000000 fc:00 573453     /lib/libgcc_s.so.1
b7da8000-b7da9000 r--p 0000c000 fc:00 573453     /lib/libgcc_s.so.1
b7da9000-b7daa000 rw-p 0000d000 fc:00 573453     /lib/libgcc_s.so.1
b7daa000-b7dab000 rw-p 00000000 00:00 0
b7dab000-b7f07000 r-xp 00000000 fc:00 573599     
/lib/tls/i686/cmov/libc-2.9.so
b7f07000-b7f08000 ---p 0015c000 fc:00 573599     
/lib/tls/i686/cmov/libc-2.9.so
b7f08000-b7f0a000 r--p 0015c000 fc:00 573599     
/lib/tls/i686/cmov/libc-2.9.so
b7f0a000-b7f0b000 rw-p 0015e000 fc:00 573599     
/lib/tls/i686/cmov/libc-2.9.so
b7f0b000-b7f10000 rw-p 00000000 00:00 0
b7f10000-b7f11000 r-xp 00000000 00:00 0          [vdso]
b7f11000-b7f2d000 r-xp 00000000 fc:00 573454     /lib/ld-2.9.so
b7f2d000-b7f2e000 r--p 0001b000 fc:00 573454     /lib/ld-2.9.so
b7f2e000-b7f2f000 rw-p 0001c000 fc:00 573454     /lib/ld-2.9.so
bfec2000-bfed7000 rw-p 00000000 00:00 0          [stack]
*** buffer overflow detected ***: ftest07 terminated
======= Backtrace: =========
/lib/tls/i686/cmov/libc.so.6(__fortify_fail+0x48)[0xb7fbada8]
/lib/tls/i686/cmov/libc.so.6[0xb7fb8eb0]
/lib/tls/i686/cmov/libc.so.6[0xb7fb85a8]
/lib/tls/i686/cmov/libc.so.6(_IO_default_xsputn+0xc8)[0xb7f2abb8]
/lib/tls/i686/cmov/libc.so.6(_IO_vfprintf+0xf4c)[0xb7efd77c]
/lib/tls/i686/cmov/libc.so.6(__vsprintf_chk+0xa4)[0xb7fb8654]
/lib/tls/i686/cmov/libc.so.6(__sprintf_chk+0x2d)[0xb7fb859d]
ftest07[0x804aa29]
ftest07[0x804aadb]
/lib/tls/i686/cmov/libc.so.6(__libc_start_main+0xe5)[0xb7ed3775]
ftest07[0x8049461]
======= Memory map: ========
08048000-0804f000 r-xp 00000000 fc:00 2525792    
/usr/src/ltp-full-20090630/testcases/bin/ftest07
0804f000-08050000 r--p 00006000 fc:00 2525792    
/usr/src/ltp-full-20090630/testcases/bin/ftest07
08050000-08051000 rw-p 00007000 fc:00 2525792    
/usr/src/ltp-full-20090630/testcases/bin/ftest07
08051000-08056000 rw-p 00000000 00:00 0
09849000-0986a000 rw-p 00000000 00:00 0          [heap]
b7ead000-b7eba000 r-xp 00000000 fc:00 573453     /lib/libgcc_s.so.1
b7eba000-b7ebb000 r--p 0000c000 fc:00 573453     /lib/libgcc_s.so.1
b7ebb000-b7ebc000 rw-p 0000d000 fc:00 573453     /lib/libgcc_s.so.1
b7ebc000-b7ebd000 rw-p 00000000 00:00 0
b7ebd000-b8019000 r-xp 00000000 fc:00 573599     
/lib/tls/i686/cmov/libc-2.9.so
b8019000-b801a000 ---p 0015c000 fc:00 573599     
/lib/tls/i686/cmov/libc-2.9.so
b801a000-b801c000 r--p 0015c000 fc:00 573599     
/lib/tls/i686/cmov/libc-2.9.so
b801c000-b801d000 rw-p 0015e000 fc:00 573599     
/lib/tls/i686/cmov/libc-2.9.so
b801d000-b8022000 rw-p 00000000 00:00 0
b8022000-b8023000 r-xp 00000000 00:00 0          [vdso]
b8023000-b803f000 r-xp 00000000 fc:00 573454     /lib/ld-2.9.so
b803f000-b8040000 r--p 0001b000 fc:00 573454     /lib/ld-2.9.so
b8040000-b8041000 rw-p 0001c000 fc:00 573454     /lib/ld-2.9.so
bfbcb000-bfbe0000 rw-p 00000000 00:00 0          [stack]

(Console stops displaying message here for ever)

------------------------


Vincent Li
Biomedical Research Center
University of British Columbia

------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize  
details at: http://p.sf.net/sfu/Challenge
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
