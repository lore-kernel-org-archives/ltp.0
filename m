Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1URXtF-0006gE-Q3
	for ltp-list@lists.sourceforge.net; Mon, 15 Apr 2013 01:07:25 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1URXtC-0006l9-FJ
	for ltp-list@lists.sourceforge.net; Mon, 15 Apr 2013 01:07:25 +0000
Message-ID: <516B52DB.2000004@cn.fujitsu.com>
Date: Mon, 15 Apr 2013 09:07:39 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <cover.1365411883.git.zliu@redhat.com>
	<3bc25be7511978a5ccb9faad218e397743d1820b.1365411883.git.zliu@redhat.com>
In-Reply-To: <3bc25be7511978a5ccb9faad218e397743d1820b.1365411883.git.zliu@redhat.com>
Subject: Re: [LTP] [PATCH v2 1/3] mm/thp: new case thp04.c
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
To: Zhouping Liu <zliu@redhat.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

On 04/08/2013 05:10 PM, Zhouping Liu wrote:
> The case is desinged to test THP functionality.
> 
> when one process allocate hugepage aligned anonymouse pages,
> kernel thread 'khugepaged' controlled by sysfs knobs
> /sys/kernel/mm/transparent_hugepage/* will scan them, and make
> them as transparent hugepage if they are suited, you can find out
> how many transparent hugepages are there in one process from
> /proc/<pid>/smaps, among the file contents, 'AnonHugePages' entry
> stand for transparent hugepage.

# ./runltp -s thp04
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
Linux gaowanlong 3.9.0-rc6 #1 SMP Mon Apr 8 16:03:08 CST 2013 x86_64 x86_64 x86_64 GNU/Linux
 
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
Modules Loaded         tcp_lp fuse ebtable_nat ebtables bridge stp llc lockd bnep sunrpc bluetooth rfkill xt_CHECKSUM iptable_mangle ipt_MASQUERADE ip6t_REJECT iptable_nat nf_conntrack_ipv4 nf_conntrack_ipv6 nf_defrag_ipv4 nf_nat_ipv4 nf_defrag_ipv6 nf_nat xt_conntrack nf_conntrack ip6table_filter ip6_tables snd_hda_codec_realtek snd_hda_intel snd_hda_codec snd_hwdep snd_seq coretemp snd_seq_device crc32c_intel vhost_net snd_pcm ghash_clmulni_intel tun iTCO_wdt iTCO_vendor_support macvtap snd_page_alloc microcode macvlan snd_timer kvm_intel pcspkr i2c_i801 serio_raw snd r8169 kvm lpc_ich mei mii mfd_core soundcore wmi uinput i915 video i2c_algo_bit drm_kms_helper drm i2c_core

free reports:
             total       used       free     shared    buffers     cached
Mem:       8025000    7563668     461332          0     730920    4891316
-/+ buffers/cache:    1941432    6083568
Swap:      4194300      16212    4178088

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
bogomips	: 6185.61
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
bogomips	: 6185.61
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
cpu MHz		: 1700.000
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
bogomips	: 6185.61
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
cpu MHz		: 3101.000
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
bogomips	: 6185.61
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

remove test cases which require the block device.
You can specify it with option -b
COMMAND:    /opt/ltp/bin/ltp-pan  -e -S   -a 7824     -n 7824  -p  -f /tmp/ltp-n5AW6K9C4X/alltests -l /opt/ltp/results/LTP_RUN_ON-2013_Apr_15-09h_03m_29s.log  -C /opt/ltp/output/LTP_RUN_ON-2013_Apr_15-09h_03m_29s.failed
INFO: Restricted to thp04
LOG File: /opt/ltp/results/LTP_RUN_ON-2013_Apr_15-09h_03m_29s.log
FAILED COMMAND File: /opt/ltp/output/LTP_RUN_ON-2013_Apr_15-09h_03m_29s.failed
Running tests.......
<<<test_start>>>
tag=thp04_1 stime=1365987809
cmdline="thp04"
contacts=""
analysis=exit
<<<test_output>>>
thp04       0  TINFO  :  Start to test transparent hugepage...
thp04       0  TINFO  :  There are 2 children allocating 64 transparent hugepages
thp04       0  TINFO  :  Stop all children...
thp04       0  TINFO  :  child[7966] stop here
thp04       0  TINFO  :  child[7965] stop here
thp04       0  TINFO  :  Start to scan all transparent hugepages...
thp04       0  TINFO  :  khugepaged daemon takes 20s to scan all thp pages
thp04       0  TINFO  :  Start to verify transparent hugepage size...
thp04       1  TFAIL  :  child[7964] got 0KB thps - expect 131072KB thps
thp04       2  TFAIL  :  child[7964] got 0KB thps - expect 131072KB thps
thp04       0  TINFO  :  Wake up all children...
<<<execution_status>>>
initiation_status="ok"
duration=20 termination_type=exited termination_id=1 corefile=no
cutime=4 cstime=12
<<<test_end>>>
<<<test_start>>>
tag=thp04_2 stime=1365987829
cmdline="thp04 -n 10 -N 20"
contacts=""
analysis=exit
<<<test_output>>>
thp04       0  TINFO  :  Start to test transparent hugepage...
thp04       0  TINFO  :  There are 10 children allocating 20 transparent hugepages
thp04       0  TINFO  :  Stop all children...
thp04       0  TINFO  :  child[7970] stop here
thp04       0  TINFO  :  child[7979] stop here
thp04       0  TINFO  :  child[7973] stop here
thp04       0  TINFO  :  child[7978] stop here
thp04       0  TINFO  :  child[7974] stop here
thp04       0  TINFO  :  child[7972] stop here
thp04       0  TINFO  :  child[7975] stop here
thp04       0  TINFO  :  child[7971] stop here
thp04       0  TINFO  :  child[7977] stop here
thp04       0  TINFO  :  child[7976] stop here
thp04       0  TINFO  :  Start to scan all transparent hugepages...
thp04       0  TINFO  :  khugepaged daemon takes 30s to scan all thp pages
thp04       0  TINFO  :  Start to verify transparent hugepage size...
thp04       1  TFAIL  :  child[7969] got 6144KB thps - expect 40960KB thps
thp04       2  TFAIL  :  child[7969] got 4096KB thps - expect 40960KB thps
thp04       3  TFAIL  :  child[7969] got 24576KB thps - expect 40960KB thps
thp04       4  TFAIL  :  child[7969] got 14336KB thps - expect 40960KB thps
thp04       5  TFAIL  :  child[7969] got 12288KB thps - expect 40960KB thps
thp04       6  TFAIL  :  child[7969] got 4096KB thps - expect 40960KB thps
thp04       7  TFAIL  :  child[7969] got 8192KB thps - expect 40960KB thps
thp04       8  TFAIL  :  child[7969] got 8192KB thps - expect 40960KB thps
thp04       9  TFAIL  :  child[7969] got 6144KB thps - expect 40960KB thps
thp04      10  TFAIL  :  child[7969] got 16384KB thps - expect 40960KB thps
thp04       0  TINFO  :  Wake up all children...
<<<execution_status>>>
initiation_status="ok"
duration=30 termination_type=exited termination_id=1 corefile=no
cutime=7 cstime=30
<<<test_end>>>
<<<test_start>>>
tag=thp04_3 stime=1365987859
cmdline="thp04 -n 1 -N 300"
contacts=""
analysis=exit
<<<test_output>>>
incrementing stop
thp04       0  TINFO  :  Start to test transparent hugepage...
thp04       0  TINFO  :  There are 1 children allocating 300 transparent hugepages
thp04       0  TINFO  :  Stop all children...
thp04       0  TINFO  :  child[7990] stop here
thp04       0  TINFO  :  Start to scan all transparent hugepages...
thp04       0  TINFO  :  khugepaged daemon takes 20s to scan all thp pages
thp04       0  TINFO  :  Start to verify transparent hugepage size...
thp04       1  TFAIL  :  child[7989] got 77824KB thps - expect 614400KB thps
thp04       0  TINFO  :  Wake up all children...
<<<execution_status>>>
initiation_status="ok"
duration=20 termination_type=exited termination_id=1 corefile=no
cutime=8 cstime=34
<<<test_end>>>
INFO: ltp-pan reported some tests FAIL
LTP Version: 20120903-189-g3e5f790

       ###############################################################

            Done executing testcases.
            LTP Version:  20120903-189-g3e5f790
       ###############################################################

> 
> Signed-off-by: Zhouping Liu <zliu@redhat.com>
> ---
>  runtest/mm                         |   3 +
>  testcases/kernel/mem/include/mem.h |  11 +++
>  testcases/kernel/mem/lib/mem.c     | 186 +++++++++++++++++++++++++++++++++++++
>  testcases/kernel/mem/thp/thp04.c   | 136 +++++++++++++++++++++++++++
>  4 files changed, 336 insertions(+)
>  create mode 100644 testcases/kernel/mem/thp/thp04.c
> 
> diff --git a/runtest/mm b/runtest/mm
> index 56b83f8..3fbb20f 100644
> --- a/runtest/mm
> +++ b/runtest/mm
> @@ -84,6 +84,9 @@ swapping01 swapping01 -i 5
>  thp01 thp01 -I 120
>  thp02 thp02
>  thp03 thp03
> +thp04_1 thp04
> +thp04_2 thp04 -n 10 -N 20
> +thp04_3 thp04 -n 1 -N 300
>  
>  vma01 vma01
>  vma02 vma02
> diff --git a/testcases/kernel/mem/include/mem.h b/testcases/kernel/mem/include/mem.h
> index fdf558e..ccae47d 100644
> --- a/testcases/kernel/mem/include/mem.h
> +++ b/testcases/kernel/mem/include/mem.h
> @@ -32,6 +32,17 @@ void testoom(int mempolicy, int lite);
>  
>  #define PATH_KSM		"/sys/kernel/mm/ksm/"
>  
> +/* THP */
> +
> +#define PATH_THP		"/sys/kernel/mm/transparent_hugepage/"
> +#define PATH_KHPD		PATH_THP "khugepaged/"
> +
> +int opt_nr_child, opt_nr_thps;
> +char *opt_nr_child_str, *opt_nr_thps_str;
> +void test_transparent_hugepage(int nr_child, int nr_thps, int hg_aligned);
> +void check_thp_options(int *nr_child, int *nr_thps);
> +void thp_usage(void);
> +
>  /* HUGETLB */
>  
>  #define PATH_SHMMAX		"/proc/sys/kernel/shmmax"
> diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
> index c9525e5..84b36bc 100644
> --- a/testcases/kernel/mem/lib/mem.c
> +++ b/testcases/kernel/mem/lib/mem.c
> @@ -501,6 +501,192 @@ void ksm_usage(void)
>  	printf("  -u      Memory allocation unit in MB\n");
>  }
>  
> +/* THP */
> +
> +static int alloc_transparent_hugepages(int nr_thps, int hg_aligned)
> +{
> +	unsigned long hugepagesize, size;
> +	void *addr;
> +	int ret;
> +
> +	hugepagesize = read_meminfo("Hugepagesize:") * KB;
> +	size = nr_thps * hugepagesize;
> +
> +	if (hg_aligned) {
> +		ret = posix_memalign(&addr, hugepagesize, size);
> +		if (ret != 0) {
> +			printf("posix_memalign failed\n");
> +			return -1;
> +		}
> +	} else {
> +		addr = mmap(NULL, size, PROT_READ|PROT_WRITE,
> +			    MAP_PRIVATE|MAP_ANON, -1, 0);
> +		if (addr == MAP_FAILED) {
> +			perror("mmap");
> +			return -1;
> +		}
> +	}
> +
> +	memset(addr, 10, size);
> +
> +	tst_resm(TINFO, "child[%d] stop here", getpid());
> +	/*
> +	 * stop here, until the father finish to calculate
> +	 * all the transparent hugepages.
> +	 */
> +	if (raise(SIGSTOP) == -1) {
> +		perror("kill");
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
> +static void khugepaged_scan_done(void)
> +{
> +	int changing = 1, count = 0;
> +	long old_pages_collapsed, old_defrag;
> +	long old_max_ptes_none, old_pages_to_scan;
> +	long pages_collapsed = 0, pages_to_scan = 0;
> +	long defrag = 0, max_ptes_none = 0;
> +
> +	while (changing) {
> +		/*
> +		 * as 'khugepaged' run 100% during testing, so 10s
> +		 * is an enough for us to recognize if 'khugepaged'
> +		 * finish scanning proceses' anonymouse hugepages
> +		 * or not.
> +		 */
> +		sleep(10);
> +		count++;
> +
> +		SAFE_FILE_SCANF(cleanup, PATH_KHPD "pages_collapsed",
> +			       "%ld", &pages_collapsed);
> +		SAFE_FILE_SCANF(cleanup, PATH_KHPD "defrag", "%ld", &defrag);
> +		SAFE_FILE_SCANF(cleanup, PATH_KHPD "max_ptes_none",
> +			       "%ld", &max_ptes_none);
> +		SAFE_FILE_SCANF(cleanup, PATH_KHPD "pages_to_scan",
> +			       "%ld", &pages_to_scan);
> +
> +		if (pages_collapsed != old_pages_collapsed ||
> +		    pages_to_scan != old_pages_to_scan ||
> +		    max_ptes_none != old_max_ptes_none ||
> +		    defrag != old_defrag) {
> +			old_pages_collapsed = pages_collapsed;
> +			old_pages_to_scan = pages_to_scan;
> +			old_max_ptes_none = max_ptes_none;
> +			old_defrag = defrag;
> +		} else {
> +			changing = 0;
> +		}
> +	}
> +
> +	tst_resm(TINFO, "khugepaged daemon takes %ds to scan all thp pages",
> +		 count * 10);
> +}
> +
> +static void verify_thp_size(int *child, int nr_child, int nr_thps)
> +{
> +	FILE *fp;
> +	char path[BUFSIZ], buf[BUFSIZ], line[BUFSIZ];
> +	int i, ret;
> +	long expect_thps; /* the amount of per child's transparent hugepages */
> +	long val, actual_thps;
> +	long hugepagesize;
> +
> +	hugepagesize = read_meminfo("Hugepagesize:");
> +	expect_thps = nr_thps * hugepagesize;
> +
> +	for (i = 0; i < nr_child; i++) {
> +		actual_thps = 0;
> +
> +		snprintf(path, BUFSIZ, "/proc/%d/smaps", child[i]);
> +		fp = fopen(path, "r");
> +		while (fgets(line, BUFSIZ, fp) != NULL) {
> +			ret = sscanf(line, "%64s %ld", buf, &val);
> +			if (ret == 2 && val != 0) {
> +				if (strcmp(buf, "AnonHugePages:") == 0)
> +					actual_thps += val;
> +			}
> +		}
> +
> +		if (actual_thps != expect_thps)
> +			tst_resm(TFAIL, "child[%d] got %ldKB thps - expect %ld"
> +				"KB thps", getpid(), actual_thps, expect_thps);
> +		fclose(fp);
> +	}
> +}
> +
> +void test_transparent_hugepage(int nr_child, int nr_thps, int hg_aligned)
> +{
> +	unsigned long hugepagesize;
> +	int i, *pid, ret, status;
> +	char path[BUFSIZ];
> +
> +	hugepagesize = read_meminfo("Hugepagesize:");
> +
> +	pid = malloc(nr_child * sizeof(int));
> +	if (pid == NULL)
> +		tst_brkm(TBROK | TERRNO, cleanup, "malloc");
> +
> +	for (i = 0; i < nr_child; i++) {
> +		switch (pid[i] = fork()) {
> +		case -1:
> +			tst_brkm(TBROK | TERRNO, cleanup, "fork");
> +
> +		case 0:
> +			ret = alloc_transparent_hugepages(nr_thps, hg_aligned);
> +			exit(ret);
> +		}
> +	}
> +
> +	tst_resm(TINFO, "Stop all children...");
> +	for (i = 0; i < nr_child; i++) {
> +		if (waitpid(pid[i], &status, WUNTRACED) == -1)
> +			tst_brkm(TBROK|TERRNO, cleanup, "waitpid");
> +		if (!WIFSTOPPED(status))
> +			tst_brkm(TBROK, cleanup,
> +				 "child[%d] was not stoppted", pid[i]);
> +	}
> +
> +	tst_resm(TINFO, "Start to scan all transparent hugepages...");
> +	khugepaged_scan_done();
> +
> +	tst_resm(TINFO, "Start to verify transparent hugepage size...");
> +	verify_thp_size(pid, nr_child, nr_thps);
> +
> +	tst_resm(TINFO, "Wake up all children...");
> +	for (i = 0; i < nr_child; i++) {
> +		if (kill(pid[i], SIGCONT) == -1)
> +			tst_brkm(TBROK | TERRNO, cleanup,
> +				 "signal continue child[%d]", pid[i]);
> +	}
> +
> +	/* wait all children finish himself task */
> +	for (i = 0; i < nr_child; i++) {
> +		if (waitpid(pid[i], &status, 0) == -1)
> +			tst_brkm(TBROK|TERRNO, cleanup, "waitpid %d", pid[i]);
> +
> +		if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
> +			tst_resm(TFAIL, "the child[%d] unexpectedly failed:"
> +				 " %d", pid[i], status);
> +	}
> +}
> +
> +void check_thp_options(int *nr_child, int *nr_thps)
> +{
> +	if (opt_nr_child)
> +		*nr_child = SAFE_STRTOL(NULL, opt_nr_child_str, 0, LONG_MAX);
> +	if (opt_nr_thps)
> +		*nr_thps = SAFE_STRTOL(NULL, opt_nr_thps_str, 0, LONG_MAX);
> +}
> +
> +void thp_usage(void)
> +{
> +	printf("  -n      Number of processes\n");
> +	printf("  -N      Number of transparent hugepages\n");
> +}
> +
>  /* cpuset/memcg */
>  
>  static void gather_node_cpus(char *cpus, long nd)
> diff --git a/testcases/kernel/mem/thp/thp04.c b/testcases/kernel/mem/thp/thp04.c
> new file mode 100644
> index 0000000..0f6c553
> --- /dev/null
> +++ b/testcases/kernel/mem/thp/thp04.c
> @@ -0,0 +1,136 @@
> +/*
> + * Copyright (C) 2013 Linux Test Project
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of version 2 of the GNU General Public
> + * License as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it would be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> + *
> + * Further, this software is distributed without any warranty that it
> + * is free of the rightful claim of any third person regarding
> + * infringement or the like.  Any license provided herein, whether
> + * implied or otherwise, applies only to this software file.  Patent
> + * licenses, if any, provided herein do not apply to combinations of
> + * this program with other software, or any other product whatsoever.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write the Free Software
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> + * 02110-1301, USA.
> + */
> +
> +/*
> + * The case is designed to test the functionality of transparent
> + * hugepage - THP
> + *
> + * when one process allocate hugepage aligned anonymouse pages,
> + * kernel thread 'khugepaged' controlled by sysfs knobs
> + * /sys/kernel/mm/transparent_hugepage/ will scan them, and make
> + * them as transparent hugepage if they are suited, you can find out
> + * how many transparent hugepages are there in one process from
> + * /proc/<pid>/smaps, among the file contents, 'AnonHugePages' entry
> + * stand for transparent hugepage.
> + */
> +
> +#include <sys/types.h>
> +#include <sys/mman.h>
> +#include <sys/stat.h>
> +#include <sys/wait.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <signal.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include "test.h"
> +#include "usctest.h"
> +#include "mem.h"
> +
> +char *TCID = "thp04";
> +int TST_TOTAL = 1;
> +
> +option_t thp_options[] = {
> +	{"n:", &opt_nr_child, &opt_nr_child_str},
> +	{"N:", &opt_nr_thps, &opt_nr_thps_str},
> +	{NULL, NULL, NULL}
> +};
> +
> +static int pre_thp_scan_sleep_millisecs;
> +static int pre_thp_alloc_sleep_millisecs;
> +static char pre_thp_enabled[BUFSIZ];
> +
> +int main(int argc, char *argv[])
> +{
> +	int lc;
> +	char *msg;
> +	int nr_child = 2, nr_thps = 64;
> +
> +	msg = parse_opts(argc, argv, thp_options, thp_usage);
> +	if (msg != NULL)
> +		tst_brkm(TBROK, tst_exit, "OPTION PARSING ERROR - %s", msg);
> +	check_thp_options(&nr_child, &nr_thps);
> +
> +	setup();
> +
> +	tst_resm(TINFO, "Start to test transparent hugepage...");
> +	tst_resm(TINFO, "There are %d children allocating %d "
> +			"transparent hugepages", nr_child, nr_thps);
> +
> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +		tst_count = 0;
> +
> +		test_transparent_hugepage(nr_child, nr_thps, 1);
> +	}
> +
> +	cleanup();
> +	tst_exit();
> +}
> +
> +void setup(void)
> +{
> +	char path[BUFSIZ];
> +
> +	tst_require_root(NULL);
> +
> +	if (access(PATH_THP, F_OK) == -1)
> +		tst_brkm(TCONF, NULL, "THP is not enabled");
> +
> +	snprintf(path, BUFSIZ, PATH_KHPD "scan_sleep_millisecs");
> +	SAFE_FILE_SCANF(NULL, path, "%d", &pre_thp_scan_sleep_millisecs);
> +	/* set 0 to khugepaged/scan_sleep_millisecs to run khugepaged 100% */
> +	SAFE_FILE_PRINTF(cleanup, path, "%d", 0);
> +
> +	snprintf(path, BUFSIZ, PATH_KHPD "alloc_sleep_millisecs");
> +	SAFE_FILE_SCANF(NULL, path, "%d", &pre_thp_alloc_sleep_millisecs);
> +	/*
> +	 * set 0 to khugepaged/alloc_sleep_millisecs to make sure khugepaged
> +	 * don't stop if there's a hugepage allcation failure.
> +	 */
> +	SAFE_FILE_PRINTF(NULL, path, "%d", 0);
> +
> +	snprintf(path, BUFSIZ, PATH_THP "enabled");
> +	write_file(path, "always");
> +
> +	tst_sig(FORK, DEF_HANDLER, NULL);
> +	TEST_PAUSE;
> +}
> +
> +void cleanup(void)
> +{
> +	char path[BUFSIZ];
> +
> +	snprintf(path, BUFSIZ, PATH_KHPD "scan_sleep_millisecs");
> +	SAFE_FILE_PRINTF(NULL, path, "%d", pre_thp_scan_sleep_millisecs);
> +
> +	snprintf(path, BUFSIZ, PATH_KHPD "alloc_sleep_millisecs");
> +	SAFE_FILE_PRINTF(NULL, path, "%d", pre_thp_alloc_sleep_millisecs);
> +
> +	snprintf(path, BUFSIZ, PATH_THP "enabled");
> +	write_file(path, pre_thp_enabled);
> +
> +	TEST_CLEANUP;
> +}
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
