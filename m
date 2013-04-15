Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1UReqL-0007kj-J6
	for ltp-list@lists.sourceforge.net; Mon, 15 Apr 2013 08:32:53 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UReqJ-0002W3-5C
	for ltp-list@lists.sourceforge.net; Mon, 15 Apr 2013 08:32:53 +0000
Message-ID: <516BB803.6000603@cn.fujitsu.com>
Date: Mon, 15 Apr 2013 16:19:15 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <fd56c3851c2ada9667af4f51b0887282d5e43279.1366012538.git.jstancek@redhat.com>
In-Reply-To: <fd56c3851c2ada9667af4f51b0887282d5e43279.1366012538.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH v2] sendmsg testcase for
	ded34e0fe8fe8c2d595bfa30626654e4b87621e0
Reply-To: gaowanlong@cn.fujitsu.com
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

On 04/15/2013 03:58 PM, Jan Stancek wrote:
> reproducer for:
> BUG: unable to handle kernel NULL pointer dereference at 0000000000000250
> 
> fixed in 3.9.0-0.rc5:
>   commit ded34e0fe8fe8c2d595bfa30626654e4b87621e0
>   Author: Paul Moore <pmoore@redhat.com>
>   Date:   Mon Mar 25 03:18:33 2013 +0000
>     unix: fix a race condition in unix_release()
> 
> This reproducer should be able to trigger it easily on 4+ CPU systems
> just within couple of seconds.

I didn't get panic on my v3.9-rc4 system by this test case.

# ./runltp -s sendmsg02
INFO: creating /opt/ltp/results directory

    INFO: no command files were provided. Will execute the following
          runtest scenario files:

syscalls fs fs_perms_simple fsx dio io mm ipc sched math nptl pty containers fs_bind controllers filecaps cap_bounds fcntl-locktests connectors admin_tools timers power_management_tests numa hugetlb commands hyperthreading 

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Fedora release 18 (Spherical Cow)
NAME=Fedora
VERSION="18 (Spherical Cow)"
ID=fedora
VERSION_ID=18
PRETTY_NAME="Fedora 18 (Spherical Cow)"
ANSI_COLOR="0;34"
CPE_NAME="cpe:/o:fedoraproject:fedora:18"
Fedora release 18 (Spherical Cow)
Fedora release 18 (Spherical Cow)
Linux gaowanlong 3.9.0-rc4 #1 SMP Thu Mar 28 10:31:53 CST 2013 x86_64 x86_64 x86_64 GNU/Linux
 
Gnu C                  gcc (GCC) 4.7.2 20121109 (Red Hat 4.7.2-8)
Gnu make               3.82
util-linux             linux 2.22.2
mount                  linux 2.22.2 (libmount 2.22.0: selinux, debug)
modutils               12
e2fsprogs              1.42.5
PPP                    2.4.5
isdn4k-utils           3.13
Linux C Library        > libc.2.16
Dynamic linker (ldd)   2.16
Procps                 3.3.3-20120807git
Net-tools              2.0
iproute2              iproute2-ss121001
Kbd                    1.15.3wip
Sh-utils               8.17
Modules Loaded         fuse ebtable_nat ebtables bridge lockd xt_CHECKSUM stp llc iptable_mangle ip6t_REJECT ipt_MASQUERADE nf_conntrack_ipv6 iptable_nat bnep nf_defrag_ipv6 nf_conntrack_ipv4 sunrpc bluetooth nf_defrag_ipv4 nf_nat_ipv4 nf_nat xt_conntrack nf_conntrack ip6table_filter rfkill ip6_tables snd_hda_codec_realtek snd_hda_intel snd_hda_codec snd_hwdep snd_seq snd_seq_device snd_pcm snd_page_alloc snd_timer vhost_net coretemp snd tun crc32c_intel macvtap ghash_clmulni_intel macvlan r8169 iTCO_wdt kvm_intel iTCO_vendor_support soundcore microcode serio_raw i2c_i801 mei kvm mii lpc_ich pcspkr mfd_core wmi uinput i915 video i2c_algo_bit drm_kms_helper drm i2c_core

free reports:
             total       used       free     shared    buffers     cached
Mem:       8024996    3635968    4389028          0      88820    2838688
-/+ buffers/cache:     708460    7316536
Swap:      4194300          0    4194300

/proc/cpuinfo
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 42
model name	: Intel(R) Core(TM) i5-2400 CPU @ 3.10GHz
stepping	: 7
microcode	: 0x28
cpu MHz		: 1600.000
cache size	: 6144 KB
physical id	: 0
siblings	: 4
core id		: 0
cpu cores	: 4
apicid		: 0
initial apicid	: 0
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx lahf_lm ida arat epb xsaveopt pln pts dtherm tpr_shadow vnmi flexpriority ept vpid
bogomips	: 6185.66
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 42
model name	: Intel(R) Core(TM) i5-2400 CPU @ 3.10GHz
stepping	: 7
microcode	: 0x28
cpu MHz		: 1600.000
cache size	: 6144 KB
physical id	: 0
siblings	: 4
core id		: 1
cpu cores	: 4
apicid		: 2
initial apicid	: 2
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx lahf_lm ida arat epb xsaveopt pln pts dtherm tpr_shadow vnmi flexpriority ept vpid
bogomips	: 6185.66
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

processor	: 2
vendor_id	: GenuineIntel
cpu family	: 6
model		: 42
model name	: Intel(R) Core(TM) i5-2400 CPU @ 3.10GHz
stepping	: 7
microcode	: 0x28
cpu MHz		: 1600.000
cache size	: 6144 KB
physical id	: 0
siblings	: 4
core id		: 2
cpu cores	: 4
apicid		: 4
initial apicid	: 4
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx lahf_lm ida arat epb xsaveopt pln pts dtherm tpr_shadow vnmi flexpriority ept vpid
bogomips	: 6185.66
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

processor	: 3
vendor_id	: GenuineIntel
cpu family	: 6
model		: 42
model name	: Intel(R) Core(TM) i5-2400 CPU @ 3.10GHz
stepping	: 7
microcode	: 0x28
cpu MHz		: 1600.000
cache size	: 6144 KB
physical id	: 0
siblings	: 4
core id		: 3
cpu cores	: 4
apicid		: 6
initial apicid	: 6
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx lahf_lm ida arat epb xsaveopt pln pts dtherm tpr_shadow vnmi flexpriority ept vpid
bogomips	: 6185.66
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

remove test cases which require the block device.
You can specify it with option -b
COMMAND:    /opt/ltp/bin/ltp-pan  -e -S   -a 7867     -n 7867  -p  -f /tmp/ltp-3oA1m2ZbEN/alltests -l /opt/ltp/results/LTP_RUN_ON-2013_Apr_15-16h_17m_52s.log  -C /opt/ltp/output/LTP_RUN_ON-2013_Apr_15-16h_17m_52s.failed
INFO: Restricted to sendmsg02
LOG File: /opt/ltp/results/LTP_RUN_ON-2013_Apr_15-16h_17m_52s.log
FAILED COMMAND File: /opt/ltp/output/LTP_RUN_ON-2013_Apr_15-16h_17m_52s.failed
Running tests.......
<<<test_start>>>
tag=sendmsg02 stime=1366013872
cmdline="sendmsg02"
contacts=""
analysis=exit
<<<test_output>>>
incrementing stop
sendmsg02    1  TPASS  :  finished after 15 seconds
<<<execution_status>>>
initiation_status="ok"
duration=15 termination_type=exited termination_id=0 corefile=no
cutime=315 cstime=5436
<<<test_end>>>
INFO: ltp-pan reported all tests PASS
LTP Version: 20120903-189-g3e5f790

       ###############################################################

            Done executing testcases.
            LTP Version:  20120903-189-g3e5f790
       ###############################################################


Thanks,
Wanlong Gao


------------------------------------------------------------------------------
Precog is a next-generation analytics platform capable of advanced
analytics on semi-structured data. The platform includes APIs for building
apps and a phenomenal toolset for data science. Developers can use
our toolset for easy data analysis & visualization. Get a free account!
http://www2.precog.com/precogplatform/slashdotnewsletter
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
