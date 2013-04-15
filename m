Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1URZuI-0002xC-8y
	for ltp-list@lists.sourceforge.net; Mon, 15 Apr 2013 03:16:38 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1URZuG-0008Pf-BU
	for ltp-list@lists.sourceforge.net; Mon, 15 Apr 2013 03:16:38 +0000
Message-ID: <516B7077.1000001@redhat.com>
Date: Mon, 15 Apr 2013 11:13:59 +0800
From: Zhouping Liu <zliu@redhat.com>
MIME-Version: 1.0
References: <cover.1365411883.git.zliu@redhat.com>
	<3bc25be7511978a5ccb9faad218e397743d1820b.1365411883.git.zliu@redhat.com>
	<516B52DB.2000004@cn.fujitsu.com>
In-Reply-To: <516B52DB.2000004@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v2 1/3] mm/thp: new case thp04.c
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
To: gaowanlong@cn.fujitsu.com
Cc: LTP List <ltp-list@lists.sourceforge.net>

On 04/15/2013 09:07 AM, Wanlong Gao wrote:
> On 04/08/2013 05:10 PM, Zhouping Liu wrote:
>> The case is desinged to test THP functionality.
>>
>> when one process allocate hugepage aligned anonymouse pages,
>> kernel thread 'khugepaged' controlled by sysfs knobs
>> /sys/kernel/mm/transparent_hugepage/* will scan them, and make
>> them as transparent hugepage if they are suited, you can find out
>> how many transparent hugepages are there in one process from
>> /proc/<pid>/smaps, among the file contents, 'AnonHugePages' entry
>> stand for transparent hugepage.
> # ./runltp -s thp04
> INFO: creating /opt/ltp/results directory
>
>      INFO: no command files were provided. Will execute the following
>            runtest scenario files:
>
> syscalls fs fs_perms_simple fsx dio io mm ipc sched math nptl pty containers fs_bind controllers filecaps cap_bounds fcntl-locktests connectors admin_tools timers power_management_tests numa hugetlb commands hyperthreading
>
> If some fields are empty or look unusual you may have an old version.
> Compare to the current minimal requirements in Documentation/Changes.
>   
> Fedora release 18 (Spherical Cow)
> NAME=Fedora
> VERSION="18 (Spherical Cow)"
> ID=fedora
> VERSION_ID=18
> PRETTY_NAME="Fedora 18 (Spherical Cow)"
> ANSI_COLOR="0;34"
> CPE_NAME="cpe:/o:fedoraproject:fedora:18"
> Fedora release 18 (Spherical Cow)
> Fedora release 18 (Spherical Cow)
> Linux gaowanlong 3.9.0-rc6 #1 SMP Mon Apr 8 16:03:08 CST 2013 x86_64 x86_64 x86_64 GNU/Linux
>   
> Gnu C                  gcc (GCC) 4.7.2 20121109 (Red Hat 4.7.2-8)
> Gnu make               3.82
> util-linux             linux 2.22.2
> mount                  linux 2.22.2 (libmount 2.22.0: selinux, debug)
> modutils               12
> e2fsprogs              1.42.5
> PPP                    2.4.5
> isdn4k-utils           3.13
> Linux C Library        > libc.2.16
> Dynamic linker (ldd)   2.16
> Procps                 3.3.3-20120807git
> Net-tools              2.0
> iproute2              iproute2-ss121001
> Kbd                    1.15.3wip
> Sh-utils               8.17
> Modules Loaded         tcp_lp fuse ebtable_nat ebtables bridge stp llc lockd bnep sunrpc bluetooth rfkill xt_CHECKSUM iptable_mangle ipt_MASQUERADE ip6t_REJECT iptable_nat nf_conntrack_ipv4 nf_conntrack_ipv6 nf_defrag_ipv4 nf_nat_ipv4 nf_defrag_ipv6 nf_nat xt_conntrack nf_conntrack ip6table_filter ip6_tables snd_hda_codec_realtek snd_hda_intel snd_hda_codec snd_hwdep snd_seq coretemp snd_seq_device crc32c_intel vhost_net snd_pcm ghash_clmulni_intel tun iTCO_wdt iTCO_vendor_support macvtap snd_page_alloc microcode macvlan snd_timer kvm_intel pcspkr i2c_i801 serio_raw snd r8169 kvm lpc_ich mei mii mfd_core soundcore wmi uinput i915 video i2c_algo_bit drm_kms_helper drm i2c_core
>
> free reports:
>               total       used       free     shared    buffers     cached
> Mem:       8025000    7563668     461332          0     730920    4891316
> -/+ buffers/cache:    1941432    6083568
> Swap:      4194300      16212    4178088
>
> /proc/cpuinfo
> processor	: 0
> vendor_id	: GenuineIntel
> cpu family	: 6
> model		: 42
> model name	: Intel(R) Core(TM) i5-2400 CPU @ 3.10GHz
> stepping	: 7
> microcode	: 0x28
> cpu MHz		: 1600.000
> cache size	: 6144 KB
> physical id	: 0
> siblings	: 4
> core id		: 0
> cpu cores	: 4
> apicid		: 0
> initial apicid	: 0
> fpu		: yes
> fpu_exception	: yes
> cpuid level	: 13
> wp		: yes
> flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx lahf_lm ida arat epb xsaveopt pln pts dtherm tpr_shadow vnmi flexpriority ept vpid
> bogomips	: 6185.61
> clflush size	: 64
> cache_alignment	: 64
> address sizes	: 36 bits physical, 48 bits virtual
> power management:
>
> processor	: 1
> vendor_id	: GenuineIntel
> cpu family	: 6
> model		: 42
> model name	: Intel(R) Core(TM) i5-2400 CPU @ 3.10GHz
> stepping	: 7
> microcode	: 0x28
> cpu MHz		: 1600.000
> cache size	: 6144 KB
> physical id	: 0
> siblings	: 4
> core id		: 1
> cpu cores	: 4
> apicid		: 2
> initial apicid	: 2
> fpu		: yes
> fpu_exception	: yes
> cpuid level	: 13
> wp		: yes
> flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx lahf_lm ida arat epb xsaveopt pln pts dtherm tpr_shadow vnmi flexpriority ept vpid
> bogomips	: 6185.61
> clflush size	: 64
> cache_alignment	: 64
> address sizes	: 36 bits physical, 48 bits virtual
> power management:
>
> processor	: 2
> vendor_id	: GenuineIntel
> cpu family	: 6
> model		: 42
> model name	: Intel(R) Core(TM) i5-2400 CPU @ 3.10GHz
> stepping	: 7
> microcode	: 0x28
> cpu MHz		: 1700.000
> cache size	: 6144 KB
> physical id	: 0
> siblings	: 4
> core id		: 2
> cpu cores	: 4
> apicid		: 4
> initial apicid	: 4
> fpu		: yes
> fpu_exception	: yes
> cpuid level	: 13
> wp		: yes
> flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx lahf_lm ida arat epb xsaveopt pln pts dtherm tpr_shadow vnmi flexpriority ept vpid
> bogomips	: 6185.61
> clflush size	: 64
> cache_alignment	: 64
> address sizes	: 36 bits physical, 48 bits virtual
> power management:
>
> processor	: 3
> vendor_id	: GenuineIntel
> cpu family	: 6
> model		: 42
> model name	: Intel(R) Core(TM) i5-2400 CPU @ 3.10GHz
> stepping	: 7
> microcode	: 0x28
> cpu MHz		: 3101.000
> cache size	: 6144 KB
> physical id	: 0
> siblings	: 4
> core id		: 3
> cpu cores	: 4
> apicid		: 6
> initial apicid	: 6
> fpu		: yes
> fpu_exception	: yes
> cpuid level	: 13
> wp		: yes
> flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx lahf_lm ida arat epb xsaveopt pln pts dtherm tpr_shadow vnmi flexpriority ept vpid
> bogomips	: 6185.61
> clflush size	: 64
> cache_alignment	: 64
> address sizes	: 36 bits physical, 48 bits virtual
> power management:
>
> remove test cases which require the block device.
> You can specify it with option -b
> COMMAND:    /opt/ltp/bin/ltp-pan  -e -S   -a 7824     -n 7824  -p  -f /tmp/ltp-n5AW6K9C4X/alltests -l /opt/ltp/results/LTP_RUN_ON-2013_Apr_15-09h_03m_29s.log  -C /opt/ltp/output/LTP_RUN_ON-2013_Apr_15-09h_03m_29s.failed
> INFO: Restricted to thp04
> LOG File: /opt/ltp/results/LTP_RUN_ON-2013_Apr_15-09h_03m_29s.log
> FAILED COMMAND File: /opt/ltp/output/LTP_RUN_ON-2013_Apr_15-09h_03m_29s.failed
> Running tests.......
> <<<test_start>>>
> tag=thp04_1 stime=1365987809
> cmdline="thp04"
> contacts=""
> analysis=exit
> <<<test_output>>>
> thp04       0  TINFO  :  Start to test transparent hugepage...
> thp04       0  TINFO  :  There are 2 children allocating 64 transparent hugepages
> thp04       0  TINFO  :  Stop all children...
> thp04       0  TINFO  :  child[7966] stop here
> thp04       0  TINFO  :  child[7965] stop here
> thp04       0  TINFO  :  Start to scan all transparent hugepages...
> thp04       0  TINFO  :  khugepaged daemon takes 20s to scan all thp pages
> thp04       0  TINFO  :  Start to verify transparent hugepage size...
> thp04       1  TFAIL  :  child[7964] got 0KB thps - expect 131072KB thps
> thp04       2  TFAIL  :  child[7964] got 0KB thps - expect 131072KB thps
> thp04       0  TINFO  :  Wake up all children...

depending on your system's memory info:

free reports:
              total       used       free     shared    buffers     cached
Mem:       8025000    7563668     461332          0     730920    4891316
-/+ buffers/cache:    1941432    6083568
Swap:      4194300      16212    4178088

your system has 8Gb RAM and there's 460Mb memory left when you start to 
test thp04 serial cases.
I guess the cases failed because of the low memory.

can you re-test them on the system with enough memory? and provide the 
value of /proc/sys/vm/min_free_kbytes,
I think 1Gb memory left is enough to test the new THP case.

also I'm very confused why the above case didn't get any THPs, maybe 
there's some performance issues...

Thanks,
Zhouping

> <<<execution_status>>>
> initiation_status="ok"
> duration=20 termination_type=exited termination_id=1 corefile=no
> cutime=4 cstime=12
> <<<test_end>>>
> <<<test_start>>>
> tag=thp04_2 stime=1365987829
> cmdline="thp04 -n 10 -N 20"
> contacts=""
> analysis=exit
> <<<test_output>>>
> thp04       0  TINFO  :  Start to test transparent hugepage...
> thp04       0  TINFO  :  There are 10 children allocating 20 transparent hugepages
> thp04       0  TINFO  :  Stop all children...
> thp04       0  TINFO  :  child[7970] stop here
> thp04       0  TINFO  :  child[7979] stop here
> thp04       0  TINFO  :  child[7973] stop here
> thp04       0  TINFO  :  child[7978] stop here
> thp04       0  TINFO  :  child[7974] stop here
> thp04       0  TINFO  :  child[7972] stop here
> thp04       0  TINFO  :  child[7975] stop here
> thp04       0  TINFO  :  child[7971] stop here
> thp04       0  TINFO  :  child[7977] stop here
> thp04       0  TINFO  :  child[7976] stop here
> thp04       0  TINFO  :  Start to scan all transparent hugepages...
> thp04       0  TINFO  :  khugepaged daemon takes 30s to scan all thp pages
> thp04       0  TINFO  :  Start to verify transparent hugepage size...
> thp04       1  TFAIL  :  child[7969] got 6144KB thps - expect 40960KB thps
> thp04       2  TFAIL  :  child[7969] got 4096KB thps - expect 40960KB thps
> thp04       3  TFAIL  :  child[7969] got 24576KB thps - expect 40960KB thps
> thp04       4  TFAIL  :  child[7969] got 14336KB thps - expect 40960KB thps
> thp04       5  TFAIL  :  child[7969] got 12288KB thps - expect 40960KB thps
> thp04       6  TFAIL  :  child[7969] got 4096KB thps - expect 40960KB thps
> thp04       7  TFAIL  :  child[7969] got 8192KB thps - expect 40960KB thps
> thp04       8  TFAIL  :  child[7969] got 8192KB thps - expect 40960KB thps
> thp04       9  TFAIL  :  child[7969] got 6144KB thps - expect 40960KB thps
> thp04      10  TFAIL  :  child[7969] got 16384KB thps - expect 40960KB thps
> thp04       0  TINFO  :  Wake up all children...
> <<<execution_status>>>
> initiation_status="ok"
> duration=30 termination_type=exited termination_id=1 corefile=no
> cutime=7 cstime=30
> <<<test_end>>>
> <<<test_start>>>
> tag=thp04_3 stime=1365987859
> cmdline="thp04 -n 1 -N 300"
> contacts=""
> analysis=exit
> <<<test_output>>>
> incrementing stop
> thp04       0  TINFO  :  Start to test transparent hugepage...
> thp04       0  TINFO  :  There are 1 children allocating 300 transparent hugepages
> thp04       0  TINFO  :  Stop all children...
> thp04       0  TINFO  :  child[7990] stop here
> thp04       0  TINFO  :  Start to scan all transparent hugepages...
> thp04       0  TINFO  :  khugepaged daemon takes 20s to scan all thp pages
> thp04       0  TINFO  :  Start to verify transparent hugepage size...
> thp04       1  TFAIL  :  child[7989] got 77824KB thps - expect 614400KB thps
> thp04       0  TINFO  :  Wake up all children...
> <<<execution_status>>>
> initiation_status="ok"
> duration=20 termination_type=exited termination_id=1 corefile=no
> cutime=8 cstime=34
> <<<test_end>>>
> INFO: ltp-pan reported some tests FAIL
> LTP Version: 20120903-189-g3e5f790
>
>         ###############################################################
>
>              Done executing testcases.
>              LTP Version:  20120903-189-g3e5f790
>         ###############################################################
>
>


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
