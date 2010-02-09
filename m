Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NereC-0000Dn-4a
	for ltp-list@lists.sourceforge.net; Tue, 09 Feb 2010 15:05:04 +0000
Received: from mail-px0-f195.google.com ([209.85.216.195])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NereA-0001kt-Py
	for ltp-list@lists.sourceforge.net; Tue, 09 Feb 2010 15:05:03 +0000
Received: by pxi33 with SMTP id 33so253681pxi.10
	for <ltp-list@lists.sourceforge.net>;
	Tue, 09 Feb 2010 07:04:54 -0800 (PST)
Mime-Version: 1.0 (Apple Message framework v1077)
From: Garrett Cooper <yanegomi@gmail.com>
In-Reply-To: <27514892.post@talk.nabble.com>
Date: Tue, 9 Feb 2010 06:58:18 -0800
Message-Id: <D2EE7EC1-F550-4B83-B2D4-7026538597CC@gmail.com>
References: <cc0b83a21002041616i7cf66f4apbfa1628c69d20dfe@mail.gmail.com>
	<27498190.post@talk.nabble.com>
	<f5a7b3811002090253u412c926ds3f0ef9895631e4f6@mail.gmail.com>
	<27514892.post@talk.nabble.com>
Subject: Re: [LTP] Got warning message "FATAL: Test suite not installed
	correctly INFO: as root user type 'make ;
	make install'" on ltp-full-20100131 while running ./runltp even i
	have installed correctly
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
To: shachin <er_sachin@rediffmail.com>
Cc: ltp-list@lists.sourceforge.net

On Feb 9, 2010, at 5:08 AM, shachin wrote:

> 
> hi ,
> pls find below the system details:
> 
> Package automake-1.9.6-2.1.noarch 
> 
> Package autoconf-2.59-1.mlos1.noarch
> 
> [root@mwg5 ~]# cat /proc/cpuinfo
> processor       : 0
> vendor_id       : GenuineIntel
> cpu family      : 6
> model           : 26
> model name      : Intel(R) Xeon(R) CPU           E5540  @ 2.53GHz
> stepping        : 5
> cpu MHz         : 2526.996
> cache size      : 8192 KB
> physical id     : 1
> siblings        : 8
> core id         : 0
> cpu cores       : 4
> apicid          : 16
> initial apicid  : 16
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 11
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
> cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
> rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl pni monitor
> ds_cpl vmx est tm2 ssse3 cx16 xtpr dca sse4_1 sse4_2 popcnt lahf_lm ida
> bogomips        : 5053.99
> clflush size    : 64
> cache_alignment : 64
> address sizes   : 40 bits physical, 48 bits virtual
> power management:
> 
> processor       : 1
> vendor_id       : GenuineIntel
> cpu family      : 6
> model           : 26
> model name      : Intel(R) Xeon(R) CPU           E5540  @ 2.53GHz
> stepping        : 5
> cpu MHz         : 2526.996
> cache size      : 8192 KB
> physical id     : 1
> siblings        : 8
> core id         : 1
> cpu cores       : 4
> apicid          : 18
> initial apicid  : 18
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 11
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
> cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
> rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl pni monitor
> ds_cpl vmx est tm2 ssse3 cx16 xtpr dca sse4_1 sse4_2 popcnt lahf_lm ida
> bogomips        : 5053.93
> clflush size    : 64
> cache_alignment : 64
> address sizes   : 40 bits physical, 48 bits virtual
> power management:
> 
> processor       : 2
> vendor_id       : GenuineIntel
> cpu family      : 6
> model           : 26
> model name      : Intel(R) Xeon(R) CPU           E5540  @ 2.53GHz
> stepping        : 5
> cpu MHz         : 2526.996
> cache size      : 8192 KB
> physical id     : 1
> siblings        : 8
> core id         : 2
> cpu cores       : 4
> apicid          : 20
> initial apicid  : 20
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 11
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
> cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
> rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl pni monitor
> ds_cpl vmx est tm2 ssse3 cx16 xtpr dca sse4_1 sse4_2 popcnt lahf_lm ida
> bogomips        : 5053.94
> clflush size    : 64
> cache_alignment : 64
> address sizes   : 40 bits physical, 48 bits virtual
> power management:
> 
> processor       : 3
> vendor_id       : GenuineIntel
> cpu family      : 6
> model           : 26
> model name      : Intel(R) Xeon(R) CPU           E5540  @ 2.53GHz
> stepping        : 5
> cpu MHz         : 2526.996
> cache size      : 8192 KB
> physical id     : 1
> siblings        : 8
> core id         : 3
> cpu cores       : 4
> apicid          : 22
> initial apicid  : 22
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 11
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
> cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
> rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl pni monitor
> ds_cpl vmx est tm2 ssse3 cx16 xtpr dca sse4_1 sse4_2 popcnt lahf_lm ida
> bogomips        : 5053.94
> clflush size    : 64
> cache_alignment : 64
> address sizes   : 40 bits physical, 48 bits virtual
> power management:
> 
> processor       : 4
> vendor_id       : GenuineIntel
> cpu family      : 6
> model           : 26
> model name      : Intel(R) Xeon(R) CPU           E5540  @ 2.53GHz
> stepping        : 5
> cpu MHz         : 2526.996
> cache size      : 8192 KB
> physical id     : 1
> siblings        : 8
> core id         : 0
> cpu cores       : 4
> apicid          : 17
> initial apicid  : 17
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 11
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
> cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
> rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl pni monitor
> ds_cpl vmx est tm2 ssse3 cx16 xtpr dca sse4_1 sse4_2 popcnt lahf_lm ida
> bogomips        : 5053.93
> clflush size    : 64
> cache_alignment : 64
> address sizes   : 40 bits physical, 48 bits virtual
> power management:
> 
> processor       : 5
> vendor_id       : GenuineIntel
> cpu family      : 6
> model           : 26
> model name      : Intel(R) Xeon(R) CPU           E5540  @ 2.53GHz
> stepping        : 5
> cpu MHz         : 2526.996
> cache size      : 8192 KB
> physical id     : 1
> siblings        : 8
> core id         : 1
> cpu cores       : 4
> apicid          : 19
> initial apicid  : 19
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 11
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
> cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
> rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl pni monitor
> ds_cpl vmx est tm2 ssse3 cx16 xtpr dca sse4_1 sse4_2 popcnt lahf_lm ida
> bogomips        : 5053.94
> clflush size    : 64
> cache_alignment : 64
> address sizes   : 40 bits physical, 48 bits virtual
> power management:
> 
> processor       : 6
> vendor_id       : GenuineIntel
> cpu family      : 6
> model           : 26
> model name      : Intel(R) Xeon(R) CPU           E5540  @ 2.53GHz
> stepping        : 5
> cpu MHz         : 2526.996
> cache size      : 8192 KB
> physical id     : 1
> siblings        : 8
> core id         : 2
> cpu cores       : 4
> apicid          : 21
> initial apicid  : 21
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 11
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
> cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
> rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl pni monitor
> ds_cpl vmx est tm2 ssse3 cx16 xtpr dca sse4_1 sse4_2 popcnt lahf_lm ida
> bogomips        : 5053.93
> clflush size    : 64
> cache_alignment : 64
> address sizes   : 40 bits physical, 48 bits virtual
> power management:
> 
> processor       : 7
> vendor_id       : GenuineIntel
> cpu family      : 6
> model           : 26
> model name      : Intel(R) Xeon(R) CPU           E5540  @ 2.53GHz
> stepping        : 5
> cpu MHz         : 2526.996
> cache size      : 8192 KB
> physical id     : 1
> siblings        : 8
> core id         : 3
> cpu cores       : 4
> apicid          : 23
> initial apicid  : 23
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 11
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
> cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
> rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl pni monitor
> ds_cpl vmx est tm2 ssse3 cx16 xtpr dca sse4_1 sse4_2 popcnt lahf_lm ida
> bogomips        : 5053.92
> clflush size    : 64
> cache_alignment : 64
> address sizes   : 40 bits physical, 48 bits virtual
> power management:
> 
> [root@mwg5 ~]#
> 
> [root@mwg5 ~]# uname -a
> Linux mwg5 2.6.27-19.mlos1-x86_64-smp #1 SMP Thu Jan 21 16:57:58 CET 2010
> x86_64 x86_64 x86_64 GNU/Linux
> [root@mwg5 ~]# uname -r
> 2.6.27-19.mlos1-x86_64-smp
> 
> now after untar the build i run the command
> ./configure
> 
> its run successfully but when i run the command
> ./make
> 
> following error occurs:
> 
> make[4]: Leaving directory
> `/opt/stress/ltp-full-20100131/testcases/kernel/syscalls/signal'
> make[4]: Entering directory
> `/opt/stress/ltp-full-20100131/testcases/kernel/syscalls/signalfd'
> make -C "/opt/stress/ltp-full-20100131/testcases/kernel/include" -f
> "/opt/stress/ltp-full-20100131/testcases/kernel/include/Makefile" all
> make[5]: Entering directory
> `/opt/stress/ltp-full-20100131/testcases/kernel/include'
> make[5]: Nothing to be done for `all'.
> make[5]: Leaving directory
> `/opt/stress/ltp-full-20100131/testcases/kernel/include'
> gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall 
> -I/opt/stress/ltp-full-20100131/testcases/kernel/include
> -I../../../../include -I../../../../include   -L../../../../lib 
> signalfd01.c   -lltp -o signalfd01
> In file included from /usr/include/asm/fcntl.h:1,
>                 from /usr/include/linux/fcntl.h:4,
>                 from /usr/include/linux/signalfd.h:12,
>                 from signalfd01.c:64:
> /usr/include/asm-generic/fcntl.h:117: error: redefinition of 'struct flock'
> /usr/include/asm-generic/fcntl.h:140: error: redefinition of 'struct
> flock64'
> make[4]: *** [signalfd01] Error 1
> make[4]: Leaving directory
> `/opt/stress/ltp-full-20100131/testcases/kernel/syscalls/signalfd'
> make[3]: *** [all] Error 2
> make[3]: Leaving directory
> `/opt/stress/ltp-full-20100131/testcases/kernel/syscalls'
> make[2]: *** [all] Error 2
> make[2]: Leaving directory `/opt/stress/ltp-full-20100131/testcases/kernel'
> make[1]: *** [all] Error 2
> make[1]: Leaving directory `/opt/stress/ltp-full-20100131/testcases'
> make: *** [testcases-all] Error 2
> [root@mwg5 ltp-full-20100131]#
> 
> 
> please let me know how i will solve this issue 
> 
> thanks in advance for help
> 
> thanks
> shachin
> 
> 
> 
> 
> 
> 
> naresh kamboju wrote:
>> 
>> Hi Shachin,
>> 
>>> Hi shachin here,
>> 
>>> Even i am unable to use  ltp-full-20100131 build i also got warning
> message
>>> "FATAL: Test suite not installed correctly
>>> INFO: as root user type 'make ; make install'
>>> [root@mwg5 ltp-full-20100131]#'
>>> even i have installed it correctly.
>> 
>>> is anybody can help out on this?
>> 
>> when we do "make install" the binaries will copied in to
>> /opt/ltp/testcase/bin/ as default path.
>> please check the what are the files available under the /opt/ltp
>> #cd /opt/ltp/
>> # tree
>> 
>> and please run the runltp command from
>> #cd /opt/ltp/
>> #./runltp
>> 
>> Hope it works
>> please let me knw if u find any issues again.

Shachin,
	Please read INSTALL; it clearly and succinctly states the autotools requirement and states how the tests must be installed in order to work. In this particular case your copy of autoconf and automake is too old (and I'd take a stab that your m4 is also too old); that's part of the reason why you're running into compile failures (my guess is that you didn't run configure to completion and the defaults config.h was setup to function with more recent copies of Linux -- it's your job to hand tailor the config.h if you don't have a sufficiently new copy of autotools to use...).
Thanks,
-Garrett
------------------------------------------------------------------------------
The Planet: dedicated and managed hosting, cloud storage, colocation
Stay online with enterprise data centers and the best network in the business
Choose flexible plans and management services without long-term contracts
Personal 24x7 support from experience hosting pros just a phone call away.
http://p.sf.net/sfu/theplanet-com
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
