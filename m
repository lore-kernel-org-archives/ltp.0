Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NmxoU-0003Sq-GQ
	for ltp-list@lists.sourceforge.net; Wed, 03 Mar 2010 23:17:10 +0000
Received: from mail-pw0-f47.google.com ([209.85.160.47])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NmxoR-0003jj-Ti
	for ltp-list@lists.sourceforge.net; Wed, 03 Mar 2010 23:17:10 +0000
Received: by pwi5 with SMTP id 5so1128982pwi.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 03 Mar 2010 15:17:01 -0800 (PST)
References: <4B8E3B7F.8050301@calsoftinc.com>
	<20100303124352.GD23601@linux.vnet.ibm.com>
	<4B8E5DF3.7090502@calsoftinc.com>
	<9debc4411003030900t971da33pfbe9ea4e994d74d4@mail.gmail.com>
Message-Id: <BD77C355-AF47-4A92-8231-145DDBC8F54D@gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
In-Reply-To: <9debc4411003030900t971da33pfbe9ea4e994d74d4@mail.gmail.com>
Mime-Version: 1.0 (iPhone Mail 7E18)
Date: Wed, 3 Mar 2010 15:16:47 -0800
Subject: Re: [LTP] Missing test tools in recent ltp builds
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
To: Maxin John <maxin.john@gmail.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>, Shwetabh <shwetabh.goel@calsoftinc.com>

On Mar 3, 2010, at 9:00 AM, Maxin John <maxin.john@gmail.com> wrote:

> Hi Shwetabh,
>
>> 3. Went to /opt/ltp directory and tried to execute cpuhotplug test:
>> [root@localhost ~]# cd /opt/ltp/
>> [root@localhost ltp]# ./runltp -f cpuhotplug
>>
>
> Please find attached the quick 'n' dirty patch
> (cpu_hotplugin_makefile.patch) to execute cpuhotplugin test.
> I have observed that the 'hotplug' directory is not included in
> "testcases/kernel/Makefile". I have also
> created a Makefile in 'hotplug/cpu_hotplug' directory.
>
> After applying this patch, I have followed the usual ./configure;
> make; sudo make install steps and executed
> the cpuhotplug test and observed the below given output . It seems
> like the test execution is "not so good" in
> my machine. Your mileage may vary.
>
> Garret,Rishi, please review the patch and let me know your comments.
>
> Signed-off-by: Maxin B. John <maxin.john@gmail.com>
>
> ---
> ---
> ---
> ---
> ---
> ---
> ---
> ---
> ---
> ---
> ---
> ---
> ---
> ---
> ---
> ---
> ---
> ---
> ---
> ---
> ---
> ---
> ---
> ---------------------------------------------------------------------
> maxin@maxin-laptop:/opt/ltp$ sudo ./runltp -f cpuhotplug
> INFO: creating /opt/ltp/output directory
> INFO: creating /opt/ltp/results directory
> Checking for required user/group ids
>
> If some fields are empty or look unusual you may have an old version.
> Compare to the current minimal requirements in Documentation/Changes.
>
> DISTRIB_ID=Ubuntu
> DISTRIB_RELEASE=9.10
> DISTRIB_CODENAME=karmic
> DISTRIB_DESCRIPTION="Ubuntu 9.10"
> Linux maxin-laptop 2.6.31-19-generic #56-Ubuntu SMP Thu Jan 28
> 01:26:53 UTC 2010 i686 GNU/Linux
>
> 'nobody' user id and group found.
> 'bin' user id and group found.
> 'daemon' user id and group found.
> Users group found.
> Sys group found.
> Required users/groups exist.
> Gnu C                  gcc (Ubuntu 4.4.1-4ubuntu9) 4.4.1
> Gnu make               3.81
> util-linux             ng 2.16)
> mount                  ng 2.16 (with libblkid and selinux support)
> modutils               3.10
> e2fsprogs              1.41.9
> PPP                    2.4.5
> Linux C Library        2.10.1
> Dynamic linker (ldd)   2.10.1
> Procps                 3.2.8
> Net-tools              1.60
> iproute2              iproute2-ss090324
> Kbd                    1.15
> Sh-utils               7.4
> Modules Loaded         usb_storage binfmt_misc ppdev
> snd_hda_codec_conexant snd_hda_intel snd_hda_codec snd_hwdep
> snd_pcm_oss snd_mixer_oss snd_pcm snd_seq_dummy joydev snd_seq_oss
> snd_seq_midi arc4 snd_rawmidi snd_seq_midi_event snd_seq ecb snd_timer
> snd_seq_device iptable_filter snd soundcore snd_page_alloc b43
> ip_tables psmouse mac80211 x_tables serio_raw cfg80211 led_class lp
> parport fbcon tileblit font bitblit softcursor i915 drm i2c_algo_bit
> ssb 8139too 8139cp mii intel_agp agpgart video output
>
> free reports:
>             total       used       free     shared    buffers      
> cached
> Mem:        241116     235908       5208          0      10116       
> 87660
> -/+ buffers/cache:     138132     102984
> Swap:      1028152     154292     873860
>
> /proc/cpuinfo
> processor    : 0
> vendor_id    : GenuineIntel
> cpu family    : 6
> model        : 14
> model name    : Intel(R) Celeron(R) M CPU        420  @ 1.60GHz
> stepping    : 8
> cpu MHz        : 1596.045
> cache size    : 1024 KB
> fdiv_bug    : no
> hlt_bug        : no
> f00f_bug    : no
> coma_bug    : no
> fpu        : yes
> fpu_exception    : yes
> cpuid level    : 10
> wp        : yes
> flags        : fpu vme de pse tsc msr pae mce cx8 apic mtrr pge mca  
> cmov
> clflush dts acpi mmx fxsr sse sse2 ss tm pbe nx constant_tsc up
> arch_perfmon bts pni monitor tm2 xtpr pdcm
> bogomips    : 3192.09
> clflush size    : 64
> power management:
>
> remove test cases which require the block device.
> You can specify it with option -b
> COMMAND:    /opt/ltp/bin/ltp-pan  -e -S   -a 7506     -n 7506  -p  -f
> /tmp/ltp-07KEC2Bcm4/alltests -l
> /opt/ltp/results/LTP_RUN_ON-2010_Mar_03-22h_14m_34s.log  -C
> /opt/ltp/output/LTP_RUN_ON-2010_Mar_03-22h_14m_34s.failed
> -e LOG File: /opt/ltp/results/LTP_RUN_ON-2010_Mar_03-22h_14m_34s.log
> -e FAILED COMMAND File:
> /opt/ltp/output/LTP_RUN_ON-2010_Mar_03-22h_14m_34s.failed
> Running tests.......
> <<<test_start>>>
> tag=CPUHOTPLUG stime=1267634676
> cmdline="(cd $LTPROOT/testcases/kernel/hotplug/cpu_hotplug/; ./ 
> runtests.sh)"
> contacts=""
> analysis=exit
> <<<test_output>>>
> cd: 1: can't cd to /opt/ltp/testcases/kernel/hotplug/cpu_hotplug/
> incrementing stop
> CPU:        1
> LOOPS:      1
> LHCS_PATH:  /opt/ltp/testcases/bin
> Name:   hotplug01
> Date:   Wed Mar  3 22:14:36 IST 2010
> Desc:   What happens to disk controller interrupts when offlining  
> CPUs?
>
> CPU is 1
> Error: cpu1 not found
> hotplug01      FAIL: cpu1 not found!
> Wed Mar  3 22:14:37 IST 2010
> Name:   hotplug02
> Date:   Wed Mar  3 22:14:37 IST 2010
> Desc:   What happens to a process when its CPU is offlined?
>
> CPU is 1
> Error: cpu1 not found
> hotplug02      FAIL: cpu1 not found!
> Wed Mar  3 22:14:37 IST 2010
> exit: 35: Illegal number: -1
> Name:   hotplug03
> Date:   Wed Mar  3 22:14:37 IST 2010
> Desc:   Do tasks get scheduled to a newly on-lined CPU?
>
> CPU is 1
> Error: CPU1 not found
> hotplug03      FAIL: CPU1 not found!
> Wed Mar  3 22:14:37 IST 2010
> exit: 31: Illegal number: -1
> Name:   hotplug04
> Date:   Wed Mar  3 22:14:37 IST 2010
> Desc:   Does it prevent us from offlining the last CPU?
>
> functional/hotplug04.sh: 65: on[1]=cpuidle: not found
> functional/hotplug04.sh: 65: Bad substitution

Double ouch. Most likely involves a bashism...

> Name:   Hotplug Test - Test Case 6
> Date:   Wed Mar  3 22:14:37 IST 2010
> Desc:   Verify user tools can handle adding and removing CPUs.
>
> Name:   hotplug06.top
> Date:   Wed Mar  3 22:14:37 IST 2010
> Desc:   Does top work properly when CPU hotplug events occur?
>
> CPU is 1
> Error: CPU1 not found
> hotplug06.top      FAIL: CPU1 not found!
> Wed Mar  3 22:14:37 IST 2010
> exit: 31: Illegal number: -1

Incorrect (*ash hates explicitly signed numbers; signedness not  
mentioned in POSIX spec).

> Name:   hotplug06.sar
> Date:   Wed Mar  3 22:14:37 IST 2010
> Desc:   Does sar behave properly during CPU hotplug events?
>
> CPU is 1
> Error: CPU1 not found
> hotplug06.sar      FAIL: CPU1 not found!
> Wed Mar  3 22:14:37 IST 2010
> exit: 31: Illegal number: -1
>
> Name:   HotPlug Test - Test Case 7
> Date:   Wed Mar  3 22:14:37 IST 2010
> Desc:   What happens when hotplugging during a heavy workload?
> Issue:  Hotplug bugs have been found during kernel compiles
>
> get_affinity_mask 7652
> cat: /sys/devices/system/cpu/cpu1/online: No such file or directory
> [: 57: =: unexpected operator

Noise.

> Error:  CPU1 cannot be onlined
> Wed Mar  3 22:14:37 IST 2010
> functional/hotplug07.sh: 64: disown: not found

Missing command or bad path set.

> <<<execution_status>>>
> initiation_status="ok"
> duration=1 termination_type=exited termination_id=1 corefile=no
> cutime=3 cstime=3
> <<<test_end>>>
> INFO: ltp-pan reported some tests FAIL
> LTP Version: LTP-20100228
>
>       ###############################################################"
>
>            Done executing testcases."
>            LTP Version:  LTP-20100228
>       ###############################################################"
>
> maxin@maxin-laptop:/opt/ltp$ cd results/
> maxin@maxin-laptop:/opt/ltp/results$ cat  
> LTP_RUN_ON-2010_Mar_03-22h_14m_34s.log
> Test Start Time: Wed Mar  3 22:14:36 2010
> -----------------------------------------
> Testcase                       Result     Exit Value
> --------                       ------     ----------
> CPUHOTPLUG                     FAIL       1
>
> -----------------------------------------------
> Total Tests: 1
> Total Failures: 1
> Kernel Version: 2.6.31-19-generic
> Machine Architecture: i686
> Hostname: maxin-laptop
> <cpu_hotplug_makefile.patch>

It looks better but it's going to need a minor amount of fudging in  
the scripts to source the appropriate scripts to execute cpuhotplug's  
tests... I'll pick this up tomorrow if it's not done by then...
Thanks,
-Garrett

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
