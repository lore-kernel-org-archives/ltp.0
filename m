From: Aditya Upadhyay <aadit0402@gmail.com>
Date: Thu, 3 May 2018 01:59:24 +0530
Subject: [LTP] Want to contribute
Message-ID: <CAMZxAxcE7deAzonfmhX9YMWSy7sRgHCn3=oC_zaEi6KVBYMd=w@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Developers,

This is Aditya Upadhyay, Mentor at RTEMS Organization in Google Summer
of Code-2018. Previously, I was a student intern at the same
organization.

One of the NetBSD members has suggested me to contribute to this
project. I have gone through the wiki page:
http://ltp.sourceforge.net/documentation/how-to/ltp.php#_3.1

I have completed with the environment setup of LTP and run the
test-cases using runltp script.

I have no idea about finding the issue while running the test-cases.
At this point of time, I have no idea about fixing the issue. Would
you like to share any pointers regarding "How to find the issue"?
These are the outputs of this command: ./runltp -f syscalls -s madvise :

aditya@aditya-Lenovo-ideapad-110-15ACL:/opt/ltp$ sudo ./runltp -f
syscalls -s madvise
INFO: creating /opt/ltp/results directory
Checking for required user/group ids

'nobody' user id and group found.
'bin' user id and group found.
'daemon' user id and group found.
Users group found.
Sys group found.
Required users/groups exist.
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

/etc/lsb-release
/etc/os-release
DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=16.04
DISTRIB_CODENAME=xenial
DISTRIB_DESCRIPTION="Ubuntu 16.04.4 LTS"
NAME="Ubuntu"
VERSION="16.04.4 LTS (Xenial Xerus)"
ID=ubuntu
ID_LIKE=debian
PRETTY_NAME="Ubuntu 16.04.4 LTS"
VERSION_ID="16.04"
HOME_URL="http://www.ubuntu.com/"
SUPPORT_URL="http://help.ubuntu.com/"
BUG_REPORT_URL="http://bugs.launchpad.net/ubuntu/"
VERSION_CODENAME=xenial
UBUNTU_CODENAME=xenial

uname:
Linux aditya-Lenovo-ideapad-110-15ACL 4.4.0-123-generic
#147~14.04.1-Ubuntu SMP Wed Apr 25 11:40:07 UTC 2018 x86_64 x86_64
x86_64 GNU/Linux

/proc/cmdline
BOOT_IMAGE=/boot/vmlinuz-4.4.0-123-generic
root=UUID=1c512730-f3c7-4ead-a336-8fedd2679a17 ro quiet splash
vt.handoff=7

Gnu C                  gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
Gnu make               4.1
util-linux             linux 2.27.1
mount                  linux 2.27.1 (libmount 2.27.0: selinux, assert, debug)
modutils               22
e2fsprogs              1.42.13
PPP                    2.4.7
Linux C Library        > libc.2.23
Dynamic linker (ldd)   2.23
Procps                 3.3.10
Net-tools              1.60
iproute2               iproute2-ss151103
iputils                iputils-s20121221
Kbd                    1.15.5
Sh-utils               8.25
Modules Loaded         cmac drbg ansi_cprng ctr ccm xt_CHECKSUM
iptable_mangle ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat
nf_nat_ipv4 nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack
nf_conntrack ipt_REJECT nf_reject_ipv4 xt_tcpudp bridge stp llc rfcomm
ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter
ip_tables x_tables pci_stub vboxpci vboxnetadp vboxnetflt vboxdrv bnep
arc4 rtsx_usb_ms memstick uvcvideo kvm_amd kvm videobuf2_vmalloc
videobuf2_memops videobuf2_v4l2 videobuf2_core v4l2_common videodev
irqbypass ath10k_pci ath10k_core media crct10dif_pclmul btusb
crc32_pclmul ghash_clmulni_intel btrtl btbcm aesni_intel btintel ath
snd_hda_codec_realtek bluetooth snd_hda_codec_generic
snd_hda_codec_hdmi snd_hda_intel aes_x86_64 mac80211 lrw snd_hda_codec
snd_hda_core gf128mul glue_helper snd_hwdep ablk_helper snd_pcm cryptd
snd_seq_midi snd_seq_midi_event joydev cfg80211 snd_rawmidi snd_seq
input_leds serio_raw snd_seq_device fam15h_power snd_timer
edac_mce_amd k10temp edac_core snd ideapad_laptop binfmt_misc
sparse_keymap wmi soundcore i2c_piix4 shpchp mac_hid ccp tpm_crb
parport_pc ppdev lp parport autofs4 rtsx_usb_sdmmc rtsx_usb amdkfd
amd_iommu_v2 radeon i2c_algo_bit ttm psmouse drm_kms_helper
syscopyarea sysfillrect ahci sysimgblt fb_sys_fops libahci drm r8169
mii fjes video

free reports:
              total        used        free      shared  buff/cache   available
Mem:        3435040     2051988      447544       80260      935508      974956
Swap:             0           0           0

/proc/cpuinfo
processor    : 0
vendor_id    : AuthenticAMD
cpu family    : 22
model        : 48
model name    : AMD A4-7210 APU with AMD Radeon R3 Graphics
stepping    : 1
microcode    : 0x7030105
cpu MHz        : 1000.000
cache size    : 2048 KB
physical id    : 0
siblings    : 4
core id        : 0
cpu cores    : 4
apicid        : 0
initial apicid    : 0
fpu        : yes
fpu_exception    : yes
cpuid level    : 13
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext
fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc
extd_apicid aperfmperf eagerfpu pni pclmulqdq monitor ssse3 cx16
sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm
cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch
osvw ibs skinit wdt topoext perfctr_nb bpext perfctr_l2 cpb hw_pstate
rsb_ctxsw retpoline retpoline_amd vmmcall bmi1 xsaveopt arat npt lbrv
svm_lock nrip_save tsc_scale flushbyasid decodeassists pausefilter
pfthreshold
bugs        : fxsave_leak sysret_ss_attrs spectre_v1 spectre_v2
bogomips    : 3593.10
TLB size    : 1024 4K pages
clflush size    : 64
cache_alignment    : 64
address sizes    : 40 bits physical, 48 bits virtual
power management: ts ttp tm 100mhzsteps hwpstate cpb [12] [13]

processor    : 1
vendor_id    : AuthenticAMD
cpu family    : 22
model        : 48
model name    : AMD A4-7210 APU with AMD Radeon R3 Graphics
stepping    : 1
microcode    : 0x7030105
cpu MHz        : 1200.000
cache size    : 2048 KB
physical id    : 0
siblings    : 4
core id        : 1
cpu cores    : 4
apicid        : 1
initial apicid    : 1
fpu        : yes
fpu_exception    : yes
cpuid level    : 13
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext
fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc
extd_apicid aperfmperf eagerfpu pni pclmulqdq monitor ssse3 cx16
sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm
cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch
osvw ibs skinit wdt topoext perfctr_nb bpext perfctr_l2 cpb hw_pstate
rsb_ctxsw retpoline retpoline_amd vmmcall bmi1 xsaveopt arat npt lbrv
svm_lock nrip_save tsc_scale flushbyasid decodeassists pausefilter
pfthreshold
bugs        : fxsave_leak sysret_ss_attrs spectre_v1 spectre_v2
bogomips    : 3593.10
TLB size    : 1024 4K pages
clflush size    : 64
cache_alignment    : 64
address sizes    : 40 bits physical, 48 bits virtual
power management: ts ttp tm 100mhzsteps hwpstate cpb [12] [13]

processor    : 2
vendor_id    : AuthenticAMD
cpu family    : 22
model        : 48
model name    : AMD A4-7210 APU with AMD Radeon R3 Graphics
stepping    : 1
microcode    : 0x7030105
cpu MHz        : 1000.000
cache size    : 2048 KB
physical id    : 0
siblings    : 4
core id        : 2
cpu cores    : 4
apicid        : 2
initial apicid    : 2
fpu        : yes
fpu_exception    : yes
cpuid level    : 13
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext
fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc
extd_apicid aperfmperf eagerfpu pni pclmulqdq monitor ssse3 cx16
sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm
cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch
osvw ibs skinit wdt topoext perfctr_nb bpext perfctr_l2 cpb hw_pstate
rsb_ctxsw retpoline retpoline_amd vmmcall bmi1 xsaveopt arat npt lbrv
svm_lock nrip_save tsc_scale flushbyasid decodeassists pausefilter
pfthreshold
bugs        : fxsave_leak sysret_ss_attrs spectre_v1 spectre_v2
bogomips    : 3593.10
TLB size    : 1024 4K pages
clflush size    : 64
cache_alignment    : 64
address sizes    : 40 bits physical, 48 bits virtual
power management: ts ttp tm 100mhzsteps hwpstate cpb [12] [13]

processor    : 3
vendor_id    : AuthenticAMD
cpu family    : 22
model        : 48
model name    : AMD A4-7210 APU with AMD Radeon R3 Graphics
stepping    : 1
microcode    : 0x7030105
cpu MHz        : 1800.000
cache size    : 2048 KB
physical id    : 0
siblings    : 4
core id        : 3
cpu cores    : 4
apicid        : 3
initial apicid    : 3
fpu        : yes
fpu_exception    : yes
cpuid level    : 13
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext
fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc
extd_apicid aperfmperf eagerfpu pni pclmulqdq monitor ssse3 cx16
sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm
cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch
osvw ibs skinit wdt topoext perfctr_nb bpext perfctr_l2 cpb hw_pstate
rsb_ctxsw retpoline retpoline_amd vmmcall bmi1 xsaveopt arat npt lbrv
svm_lock nrip_save tsc_scale flushbyasid decodeassists pausefilter
pfthreshold
bugs        : fxsave_leak sysret_ss_attrs spectre_v1 spectre_v2
bogomips    : 3593.10
TLB size    : 1024 4K pages
clflush size    : 64
cache_alignment    : 64
address sizes    : 40 bits physical, 48 bits virtual
power management: ts ttp tm 100mhzsteps hwpstate cpb [12] [13]

no big block device was specified on commandline.
Tests which require a big block device are disabled.
You can specify it with option -z
COMMAND:    /opt/ltp/bin/ltp-pan   -e -S   -a 15076     -n 15076 -p -f
/tmp/ltp-S9nmOwzHaY/alltests -l
/opt/ltp/results/LTP_RUN_ON-2018_05_03-01h_37m_37s.log  -C
/opt/ltp/output/LTP_RUN_ON-2018_05_03-01h_37m_37s.failed -T
/opt/ltp/output/LTP_RUN_ON-2018_05_03-01h_37m_37s.tconf
INFO: Restricted to madvise
LOG File: /opt/ltp/results/LTP_RUN_ON-2018_05_03-01h_37m_37s.log
FAILED COMMAND File: /opt/ltp/output/LTP_RUN_ON-2018_05_03-01h_37m_37s.failed
TCONF COMMAND File: /opt/ltp/output/LTP_RUN_ON-2018_05_03-01h_37m_37s.tconf
Running tests.......
<<<test_start>>>
tag=madvise01 stime=1525291661
cmdline="madvise01"
contacts=""
analysis=exit
<<<test_output>>>
tst_test.c:987: INFO: Timeout per run is 0h 05m 00s
madvise01.c:118: PASS: madvise test for MADV_NORMAL PASSED
madvise01.c:118: PASS: madvise test for MADV_RANDOM PASSED
madvise01.c:118: PASS: madvise test for MADV_SEQUENTIAL PASSED
madvise01.c:118: PASS: madvise test for MADV_WILLNEED PASSED
madvise01.c:118: PASS: madvise test for MADV_DONTNEED PASSED
madvise01.c:118: PASS: madvise test for MADV_REMOVE PASSED
madvise01.c:118: PASS: madvise test for MADV_DONTFORK PASSED
madvise01.c:118: PASS: madvise test for MADV_DOFORK PASSED
madvise01.c:118: PASS: madvise test for MADV_HWPOISON PASSED
madvise01.c:118: PASS: madvise test for MADV_MERGEABLE PASSED
madvise01.c:118: PASS: madvise test for MADV_UNMERGEABLE PASSED
madvise01.c:118: PASS: madvise test for MADV_HUGEPAGE PASSED
madvise01.c:118: PASS: madvise test for MADV_NOHUGEPAGE PASSED
madvise01.c:118: PASS: madvise test for MADV_DONTDUMP PASSED
madvise01.c:118: PASS: madvise test for MADV_DODUMP PASSED
madvise01.c:110: CONF: MADV_FREE is not supported

Summary:
passed   15
failed   0
skipped  1
warnings 0
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=madvise02 stime=1525291661
cmdline="madvise02"
contacts=""
analysis=exit
<<<test_output>>>
tst_test.c:987: INFO: Timeout per run is 0h 05m 00s
madvise02.c:164: PASS: failed as expected: EINVAL
madvise02.c:164: PASS: failed as expected: EINVAL
madvise02.c:164: PASS: failed as expected: EINVAL
madvise02.c:157: CONF: MADV_MERGEABLE is not supported
madvise02.c:157: CONF: MADV_UNMERGEABLE is not supported
madvise02.c:164: PASS: failed as expected: ENOMEM
madvise02.c:164: PASS: failed as expected: ENOMEM
madvise02.c:157: CONF: MADV_WILLNEED is not supported

Summary:
passed   5
failed   0
skipped  3
warnings 0
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=1
<<<test_end>>>
<<<test_start>>>
tag=madvise05 stime=1525291661
cmdline="madvise05"
contacts=""
analysis=exit
<<<test_output>>>
tst_test.c:987: INFO: Timeout per run is 0h 05m 00s
madvise05.c:47: PASS: issue has not been reproduced

Summary:
passed   1
failed   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=madvise06 stime=1525291661
cmdline="madvise06"
contacts=""
analysis=exit
<<<test_output>>>
tst_test.c:987: INFO: Timeout per run is 0h 05m 00s
madvise06.c:65: INFO: dropping caches
madvise06.c:76: CONF: System swap is too small (838860800 bytes needed)

Summary:
passed   0
failed   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status="ok"
duration=1 termination_type=exited termination_id=32 corefile=no
cutime=0 cstime=53
<<<test_end>>>
<<<test_start>>>
tag=madvise07 stime=1525291662
cmdline="madvise07"
contacts=""
analysis=exit
<<<test_output>>>
tst_test.c:987: INFO: Timeout per run is 0h 05m 00s
madvise07.c:57: INFO: mmap(0, 4096, PROT_READ | PROT_WRITE,
MAP_ANONYMOUS | MAP_PRIVATE, -1, 0)
madvise07.c:66: INFO: madvise(0x7efbf7ffc000, 4096, MADV_HWPOISON)
madvise07.c:95: PASS: Received SIGBUS after accessing poisoned page

Summary:
passed   1
failed   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=madvise08 stime=1525291662
cmdline="madvise08"
contacts=""
analysis=exit
<<<test_output>>>
tst_test.c:987: INFO: Timeout per run is 0h 05m 00s
madvise08.c:87: INFO: System core pattern is 'core'
madvise08.c:91: INFO: Temporary core pattern is
'/tmp/ltp-S9nmOwzHaY/FAfx4P/dump-%p'
madvise08.c:133: INFO: Dump file should be dump-15217
madvise08.c:217: PASS: madvise(..., MADV_DONTDUMP)
madvise08.c:133: INFO: Dump file should be dump-15218
madvise08.c:221: PASS: madvise(..., MADV_DODUMP)

Summary:
passed   2
failed   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=1
<<<test_end>>>
<<<test_start>>>
tag=madvise09 stime=1525291662
cmdline="madvise09"
contacts=""
analysis=exit
<<<test_output>>>
incrementing stop
tst_test.c:987: INFO: Timeout per run is 0h 05m 00s
madvise09.c:327: INFO: Swap accounting is disabled
madvise09.c:331: CONF: MADV_FREE does not work without swap

Summary:
passed   0
failed   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=32 corefile=no
cutime=0 cstime=0
<<<test_end>>>
INFO: ltp-pan reported all tests PASS
LTP Version: 20180118-161-gf7e4049

       ###############################################################

            Done executing testcases.
            LTP Version:  20180118-161-gf7e4049
       ###############################################################

aditya@aditya-Lenovo-ideapad-110-15ACL:/opt/ltp$

Regards,
Aditya Upadhyay
