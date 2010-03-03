Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <maxin.john@gmail.com>) id 1NmrwV-0007bx-Lq
	for ltp-list@lists.sourceforge.net; Wed, 03 Mar 2010 17:01:03 +0000
Received: from mail-pz0-f171.google.com ([209.85.222.171])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NmrwU-0000FN-Ju
	for ltp-list@lists.sourceforge.net; Wed, 03 Mar 2010 17:01:03 +0000
Received: by pzk1 with SMTP id 1so316392pzk.10
	for <ltp-list@lists.sourceforge.net>;
	Wed, 03 Mar 2010 09:00:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4B8E5DF3.7090502@calsoftinc.com>
References: <4B8E3B7F.8050301@calsoftinc.com>
	<20100303124352.GD23601@linux.vnet.ibm.com>
	<4B8E5DF3.7090502@calsoftinc.com>
Date: Wed, 3 Mar 2010 22:30:56 +0530
Message-ID: <9debc4411003030900t971da33pfbe9ea4e994d74d4@mail.gmail.com>
From: Maxin John <maxin.john@gmail.com>
Content-Type: multipart/mixed; boundary=000e0cd312c605d1930480e86dd2
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
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net, Shwetabh <shwetabh.goel@calsoftinc.com>

--000e0cd312c605d1930480e86dd2
Content-Type: text/plain; charset=ISO-8859-1

Hi Shwetabh,

> 3. Went to /opt/ltp directory and tried to execute cpuhotplug test:
> [root@localhost ~]# cd /opt/ltp/
> [root@localhost ltp]# ./runltp -f cpuhotplug
>

Please find attached the quick 'n' dirty patch
(cpu_hotplugin_makefile.patch) to execute cpuhotplugin test.
I have observed that the 'hotplug' directory is not included in
"testcases/kernel/Makefile". I have also
created a Makefile in 'hotplug/cpu_hotplug' directory.

After applying this patch, I have followed the usual ./configure;
make; sudo make install steps and executed
the cpuhotplug test and observed the below given output . It seems
like the test execution is "not so good" in
my machine. Your mileage may vary.

Garret,Rishi, please review the patch and let me know your comments.

Signed-off-by: Maxin B. John <maxin.john@gmail.com>

------------------------------------------------------------------------------------------------------------------------------------------
maxin@maxin-laptop:/opt/ltp$ sudo ./runltp -f cpuhotplug
INFO: creating /opt/ltp/output directory
INFO: creating /opt/ltp/results directory
Checking for required user/group ids

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=9.10
DISTRIB_CODENAME=karmic
DISTRIB_DESCRIPTION="Ubuntu 9.10"
Linux maxin-laptop 2.6.31-19-generic #56-Ubuntu SMP Thu Jan 28
01:26:53 UTC 2010 i686 GNU/Linux

'nobody' user id and group found.
'bin' user id and group found.
'daemon' user id and group found.
Users group found.
Sys group found.
Required users/groups exist.
Gnu C                  gcc (Ubuntu 4.4.1-4ubuntu9) 4.4.1
Gnu make               3.81
util-linux             ng 2.16)
mount                  ng 2.16 (with libblkid and selinux support)
modutils               3.10
e2fsprogs              1.41.9
PPP                    2.4.5
Linux C Library        2.10.1
Dynamic linker (ldd)   2.10.1
Procps                 3.2.8
Net-tools              1.60
iproute2              iproute2-ss090324
Kbd                    1.15
Sh-utils               7.4
Modules Loaded         usb_storage binfmt_misc ppdev
snd_hda_codec_conexant snd_hda_intel snd_hda_codec snd_hwdep
snd_pcm_oss snd_mixer_oss snd_pcm snd_seq_dummy joydev snd_seq_oss
snd_seq_midi arc4 snd_rawmidi snd_seq_midi_event snd_seq ecb snd_timer
snd_seq_device iptable_filter snd soundcore snd_page_alloc b43
ip_tables psmouse mac80211 x_tables serio_raw cfg80211 led_class lp
parport fbcon tileblit font bitblit softcursor i915 drm i2c_algo_bit
ssb 8139too 8139cp mii intel_agp agpgart video output

free reports:
             total       used       free     shared    buffers     cached
Mem:        241116     235908       5208          0      10116      87660
-/+ buffers/cache:     138132     102984
Swap:      1028152     154292     873860

/proc/cpuinfo
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 14
model name	: Intel(R) Celeron(R) M CPU        420  @ 1.60GHz
stepping	: 8
cpu MHz		: 1596.045
cache size	: 1024 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 10
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic mtrr pge mca cmov
clflush dts acpi mmx fxsr sse sse2 ss tm pbe nx constant_tsc up
arch_perfmon bts pni monitor tm2 xtpr pdcm
bogomips	: 3192.09
clflush size	: 64
power management:

remove test cases which require the block device.
You can specify it with option -b
COMMAND:    /opt/ltp/bin/ltp-pan  -e -S   -a 7506     -n 7506  -p  -f
/tmp/ltp-07KEC2Bcm4/alltests -l
/opt/ltp/results/LTP_RUN_ON-2010_Mar_03-22h_14m_34s.log  -C
/opt/ltp/output/LTP_RUN_ON-2010_Mar_03-22h_14m_34s.failed
-e LOG File: /opt/ltp/results/LTP_RUN_ON-2010_Mar_03-22h_14m_34s.log
-e FAILED COMMAND File:
/opt/ltp/output/LTP_RUN_ON-2010_Mar_03-22h_14m_34s.failed
Running tests.......
<<<test_start>>>
tag=CPUHOTPLUG stime=1267634676
cmdline="(cd $LTPROOT/testcases/kernel/hotplug/cpu_hotplug/; ./runtests.sh)"
contacts=""
analysis=exit
<<<test_output>>>
cd: 1: can't cd to /opt/ltp/testcases/kernel/hotplug/cpu_hotplug/
incrementing stop
CPU:        1
LOOPS:      1
LHCS_PATH:  /opt/ltp/testcases/bin
Name:   hotplug01
Date:   Wed Mar  3 22:14:36 IST 2010
Desc:   What happens to disk controller interrupts when offlining CPUs?

CPU is 1
Error: cpu1 not found
hotplug01      FAIL: cpu1 not found!
Wed Mar  3 22:14:37 IST 2010
Name:   hotplug02
Date:   Wed Mar  3 22:14:37 IST 2010
Desc:   What happens to a process when its CPU is offlined?

CPU is 1
Error: cpu1 not found
hotplug02      FAIL: cpu1 not found!
Wed Mar  3 22:14:37 IST 2010
exit: 35: Illegal number: -1
Name:   hotplug03
Date:   Wed Mar  3 22:14:37 IST 2010
Desc:   Do tasks get scheduled to a newly on-lined CPU?

CPU is 1
Error: CPU1 not found
hotplug03      FAIL: CPU1 not found!
Wed Mar  3 22:14:37 IST 2010
exit: 31: Illegal number: -1
Name:   hotplug04
Date:   Wed Mar  3 22:14:37 IST 2010
Desc:   Does it prevent us from offlining the last CPU?

functional/hotplug04.sh: 65: on[1]=cpuidle: not found
functional/hotplug04.sh: 65: Bad substitution
Name:   Hotplug Test - Test Case 6
Date:   Wed Mar  3 22:14:37 IST 2010
Desc:   Verify user tools can handle adding and removing CPUs.

Name:   hotplug06.top
Date:   Wed Mar  3 22:14:37 IST 2010
Desc:   Does top work properly when CPU hotplug events occur?

CPU is 1
Error: CPU1 not found
hotplug06.top      FAIL: CPU1 not found!
Wed Mar  3 22:14:37 IST 2010
exit: 31: Illegal number: -1


Name:   hotplug06.sar
Date:   Wed Mar  3 22:14:37 IST 2010
Desc:   Does sar behave properly during CPU hotplug events?

CPU is 1
Error: CPU1 not found
hotplug06.sar      FAIL: CPU1 not found!
Wed Mar  3 22:14:37 IST 2010
exit: 31: Illegal number: -1

Name:   HotPlug Test - Test Case 7
Date:   Wed Mar  3 22:14:37 IST 2010
Desc:   What happens when hotplugging during a heavy workload?
Issue:  Hotplug bugs have been found during kernel compiles

get_affinity_mask 7652
cat: /sys/devices/system/cpu/cpu1/online: No such file or directory
[: 57: =: unexpected operator
Error:  CPU1 cannot be onlined
Wed Mar  3 22:14:37 IST 2010
functional/hotplug07.sh: 64: disown: not found
<<<execution_status>>>
initiation_status="ok"
duration=1 termination_type=exited termination_id=1 corefile=no
cutime=3 cstime=3
<<<test_end>>>
INFO: ltp-pan reported some tests FAIL
LTP Version: LTP-20100228

       ###############################################################"

            Done executing testcases."
            LTP Version:  LTP-20100228
       ###############################################################"

maxin@maxin-laptop:/opt/ltp$ cd results/
maxin@maxin-laptop:/opt/ltp/results$ cat LTP_RUN_ON-2010_Mar_03-22h_14m_34s.log
Test Start Time: Wed Mar  3 22:14:36 2010
-----------------------------------------
Testcase                       Result     Exit Value
--------                       ------     ----------
CPUHOTPLUG                     FAIL       1

-----------------------------------------------
Total Tests: 1
Total Failures: 1
Kernel Version: 2.6.31-19-generic
Machine Architecture: i686
Hostname: maxin-laptop

--000e0cd312c605d1930480e86dd2
Content-Type: text/x-patch; charset=US-ASCII; name="cpu_hotplug_makefile.patch"
Content-Disposition: attachment; filename="cpu_hotplug_makefile.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g6cd452w0

ZGlmZiAtdU5yIGx0cC1mdWxsLTIwMTAwMjI4LW9yaWcvdGVzdGNhc2VzL2tlcm5lbC9ob3RwbHVn
L2NwdV9ob3RwbHVnL01ha2VmaWxlIGx0cC1mdWxsLTIwMTAwMjI4L3Rlc3RjYXNlcy9rZXJuZWwv
aG90cGx1Zy9jcHVfaG90cGx1Zy9NYWtlZmlsZQotLS0gbHRwLWZ1bGwtMjAxMDAyMjgtb3JpZy90
ZXN0Y2FzZXMva2VybmVsL2hvdHBsdWcvY3B1X2hvdHBsdWcvTWFrZWZpbGUJMTk3MC0wMS0wMSAw
NTozMDowMC4wMDAwMDAwMDAgKzA1MzAKKysrIGx0cC1mdWxsLTIwMTAwMjI4L3Rlc3RjYXNlcy9r
ZXJuZWwvaG90cGx1Zy9jcHVfaG90cGx1Zy9NYWtlZmlsZQkyMDEwLTAzLTAzIDIxOjQ2OjMzLjAw
MDAwMDAwMCArMDUzMApAQCAtMCwwICsxLDI3IEBACisjCisjICAgIGtlcm5lbC9ob3RwbHVnL2Nw
dV9ob3RwbHVnIHRlc3Qgc3VpdGUgTWFrZWZpbGUuCisjCisjICAgIFRoaXMgcHJvZ3JhbSBpcyBm
cmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5CisjICAg
IGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgYXMg
cHVibGlzaGVkIGJ5CisjICAgIHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb247IGVpdGhlciB2
ZXJzaW9uIDIgb2YgdGhlIExpY2Vuc2UsIG9yCisjICAgIChhdCB5b3VyIG9wdGlvbikgYW55IGxh
dGVyIHZlcnNpb24uCisjCisjICAgIFRoaXMgcHJvZ3JhbSBpcyBkaXN0cmlidXRlZCBpbiB0aGUg
aG9wZSB0aGF0IGl0IHdpbGwgYmUgdXNlZnVsLAorIyAgICBidXQgV0lUSE9VVCBBTlkgV0FSUkFO
VFk7IHdpdGhvdXQgZXZlbiB0aGUgaW1wbGllZCB3YXJyYW50eSBvZgorIyAgICBNRVJDSEFOVEFC
SUxJVFkgb3IgRklUTkVTUyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UuICBTZWUgdGhlCisjICAg
IEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGZvciBtb3JlIGRldGFpbHMuCisjCisjICAgIFlv
dSBzaG91bGQgaGF2ZSByZWNlaXZlZCBhIGNvcHkgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBM
aWNlbnNlIGFsb25nCisjICAgIHdpdGggdGhpcyBwcm9ncmFtOyBpZiBub3QsIHdyaXRlIHRvIHRo
ZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb24sIEluYy4sCisjICAgIDUxIEZyYW5rbGluIFN0cmVl
dCwgRmlmdGggRmxvb3IsIEJvc3RvbiwgTUEgMDIxMTAtMTMwMSBVU0EuCisjCisjIE1heGluIEIu
IEpvaG4sIE1hcmNoIDIwMTAKKwordG9wX3NyY2RpciAgICAgICAgICAgICAgICAgICAgICA/PSAu
Li8uLi8uLi8uLgorCitpbmNsdWRlICQodG9wX3NyY2RpcikvaW5jbHVkZS9tay9lbnZfcHJlLm1r
CisKK0lOU1RBTExfVEFSR0VUUyAgICAgICAgICAgICAgICAgOj0gcnVudGVzdHMuc2ggZnVuY3Rp
b25hbC8qIGluY2x1ZGUvKiB0b29scy8qCisKK2luY2x1ZGUgJCh0b3Bfc3JjZGlyKS9pbmNsdWRl
L21rL2dlbmVyaWNfbGVhZl90YXJnZXQubWsKKwpkaWZmIC11TnIgbHRwLWZ1bGwtMjAxMDAyMjgt
b3JpZy90ZXN0Y2FzZXMva2VybmVsL2hvdHBsdWcvbWVtb3J5X2hvdHBsdWcvTWFrZWZpbGUgbHRw
LWZ1bGwtMjAxMDAyMjgvdGVzdGNhc2VzL2tlcm5lbC9ob3RwbHVnL21lbW9yeV9ob3RwbHVnL01h
a2VmaWxlCi0tLSBsdHAtZnVsbC0yMDEwMDIyOC1vcmlnL3Rlc3RjYXNlcy9rZXJuZWwvaG90cGx1
Zy9tZW1vcnlfaG90cGx1Zy9NYWtlZmlsZQkyMDEwLTAzLTAxIDIwOjI4OjI4LjAwMDAwMDAwMCAr
MDUzMAorKysgbHRwLWZ1bGwtMjAxMDAyMjgvdGVzdGNhc2VzL2tlcm5lbC9ob3RwbHVnL21lbW9y
eV9ob3RwbHVnL01ha2VmaWxlCTIwMTAtMDMtMDMgMjE6NDY6MTIuMDAwMDAwMDAwICswNTMwCkBA
IC0yOSw2ICsyOSw4IEBACiBMRExJQlMJCSs9ICQoTlVNQV9MSUJTKQogTERMSUJTCQk6PSAkKGZp
bHRlci1vdXQgLWxsdHAsJChMRExJQlMpKQogCitJTlNUQUxMX1RBUkdFVFMgOj0gbWVtdG95CisK
IE1BS0VfVEFSR0VUUwk6PSBtZW10b3kKIAogbWVtdG95OiAkKHBhdHN1YnN0ICQoYWJzX3NyY2Rp
cikvJS5jLCUubywkKHdpbGRjYXJkICQoYWJzX3NyY2RpcikvKi5jKSkKZGlmZiAtdU5yIGx0cC1m
dWxsLTIwMTAwMjI4LW9yaWcvdGVzdGNhc2VzL2tlcm5lbC9NYWtlZmlsZSBsdHAtZnVsbC0yMDEw
MDIyOC90ZXN0Y2FzZXMva2VybmVsL01ha2VmaWxlCi0tLSBsdHAtZnVsbC0yMDEwMDIyOC1vcmln
L3Rlc3RjYXNlcy9rZXJuZWwvTWFrZWZpbGUJMjAxMC0wMy0wMSAyMDoyODoyOC4wMDAwMDAwMDAg
KzA1MzAKKysrIGx0cC1mdWxsLTIwMTAwMjI4L3Rlc3RjYXNlcy9rZXJuZWwvTWFrZWZpbGUJMjAx
MC0wMy0wMyAyMTo0NTo1Mi4wMDAwMDAwMDAgKzA1MzAKQEAgLTI3LDcgKzI3LDcgQEAKIGlmbmVx
ICgkKFVDTElOVVgpLDEpCiBTVUJESVJTCQk6PSBjb250YWluZXJzIGNvbm5lY3RvcnMgY29udHJv
bGxlcnMgZnMgaW8gaXBjIG1lbSBudW1hIFwKIAkJICAgcGVyZm9ybWFuY2VfY291bnRlcnMgcG93
ZXJfbWFuYWdlbWVudCBwdHkgc2NoZWQgc2VjdXJpdHkgXAotCQkgICBzeXNjYWxscyB0aW1lcnMK
KwkJICAgc3lzY2FsbHMgdGltZXJzIGhvdHBsdWcKIGVsc2UKIFNVQkRJUlMJCTo9IHN5c2NhbGxz
CiBlbmRpZgo=
--000e0cd312c605d1930480e86dd2
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
--000e0cd312c605d1930480e86dd2
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--000e0cd312c605d1930480e86dd2--

