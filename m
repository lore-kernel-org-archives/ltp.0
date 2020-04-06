From: Pankaj Vinadrao Joshi <Pankaj.VJ@exaleapsemi.com>
Date: Mon, 6 Apr 2020 15:03:07 +0000
Subject: [LTP] zram01,zram02,zram03 testcase failure
Message-ID: <MAXPR0101MB1468857B20832FCFDB53C877EEC20@MAXPR0101MB1468.INDPRD01.PROD.OUTLOOK.COM>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
I am trying run ltp on x86 with 5.3.0 but i am getting following errors for zram01,zram02,zram3

DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=18.04
DISTRIB_CODENAME=bionic
DISTRIB_DESCRIPTION="Ubuntu 18.04.4 LTS"
NAME="Ubuntu"
VERSION="18.04.4 LTS (Bionic Beaver)"
ID=ubuntu
ID_LIKE=debian
PRETTY_NAME="Ubuntu 18.04.4 LTS"
VERSION_ID="18.04"
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
VERSION_CODENAME=bionic
UBUNTU_CODENAME=bionic

uname:
Linux pankajjoshi 5.3.0-45-generic #37~18.04.1-Ubuntu SMP Fri Mar 27 15:58:10 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux

/proc/cmdline
BOOT_IMAGE=/boot/vmlinuz-5.3.0-45-generic root=UUID=f56ebd1c-40eb-4995-a23e-afd3aa727650 ro quiet splash vt.handoff=1

Gnu C                  gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
Clang
Gnu make               4.1
util-linux             2.31.1
mount                  linux 2.31.1 (libmount 2.31.1: selinux, btrfs, assert, debug)
modutils               24
e2fsprogs              1.44.1
PPP                    2.4.7
Linux C Library        > libc.2.27
Dynamic linker (ldd)   2.27
Procps                 3.3.12
Net-tools              2.10-alpha
iproute2               iproute2-ss180129
iputils                iputils-s20161105
Kbd                    2.0.4
Sh-utils               8.28
Modules Loaded         ntfs n_gsm caif_serial pps_ldisc slcan ppp_synctty n_hdlc mkiss ax25 ppp_async slip serport snd_seq_dummy binfmt_misc rfcomm btrfs xor zstd_compress raid6_pq xfs libcrc32c zram ccm cmac bnep nls_iso8859_1 x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel joydev kvm irqbypass mei_hdcp hid_multitouch intel_rapl_msr crct10dif_pclmul crc32_pclmul ghash_clmulni_intel dell_laptop dell_smm_hwmon aesni_intel aes_x86_64 snd_soc_skl snd_soc_hdac_hda snd_hda_codec_hdmi snd_hda_ext_core snd_soc_skl_ipc crypto_simd cryptd glue_helper snd_soc_sst_ipc snd_soc_sst_dsp snd_soc_acpi_intel_match ath10k_pci snd_soc_acpi snd_hda_codec_realtek snd_hda_codec_generic ath10k_core intel_cstate ath snd_soc_core uvcvideo ledtrig_audio intel_rapl_perf snd_compress ac97_bus videobuf2_vmalloc mac80211 videobuf2_memops snd_pcm_dmaengine videobuf2_v4l2 i915 videobuf2_common cfg80211 videodev mc btusb rtsx_usb_ms btrtl btbcm libarc4 btintel memstick drm_kms_helper bluetooth snd_hda_intel snd_intel_nhlt drm ecdh_generic i2c_algo_bit fb_sys_fops syscopyarea ecc snd_hda_codec sysfillrect input_leds serio_raw dell_wmi snd_hda_core sysimgblt dell_smbios dcdbas wmi_bmof dell_wmi_descriptor snd_hwdep snd_pcm snd_seq_midi acpi_pad mei_me snd_seq_midi_event intel_xhci_usb_role_switch roles snd_rawmidi mei snd_seq idma64 mac_hid intel_hid snd_seq_device snd_timer snd virt_dma soundcore int3403_thermal sparse_keymap intel_lpss_pci intel_lpss processor_thermal_device intel_rapl_common intel_soc_dts_iosf int3400_thermal acpi_thermal_rel intel_pch_thermal int3402_thermal int340x_thermal_zone sch_fq_codel parport_pc ppdev lp parport ip_tables x_tables autofs4 rtsx_usb_sdmmc hid_generic rtsx_usb usbhid i2c_hid psmouse r8169 ahci realtek libahci wmi hid pinctrl_sunrisepoint pinctrl_intel video

free reports:
              total        used        free      shared  buff/cache   available
Mem:       16296708     2524572     2326052      383432    11446084    13047448
Swap:       2097148      123648     1973500

cpuinfo:
Architecture:        x86_64
CPU op-mode(s):      32-bit, 64-bit
Byte Order:          Little Endian
CPU(s):              4
On-line CPU(s) list: 0-3
Thread(s) per core:  2
Core(s) per socket:  2
Socket(s):           1
NUMA node(s):        1
Vendor ID:           GenuineIntel
CPU family:          6
Model:               142
Model name:          Intel(R) Core(TM) i3-7020U CPU @ 2.30GHz
Stepping:            9
CPU MHz:             2300.141
CPU max MHz:         2300.0000
CPU min MHz:         400.0000
BogoMIPS:            4599.93
Virtualization:      VT-x
L1d cache:           32K
L1i cache:           32K
L2 cache:            256K
L3 cache:            3072K
NUMA node0 CPU(s):   0-3
Flags:               fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb invpcid_single pti ssbd ibrs ibpb stibp tpr_shadow vnmi flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid mpx rdseed adx smap clflushopt intel_pt xsaveopt xsavec xgetbv1 xsaves dtherm arat pln pts hwp hwp_notify hwp_act_window hwp_epp md_clear flush_l1d

AppArmor enabled
apparmor module is loaded.
37 profiles are loaded.
35 profiles are in enforce mode.
   /sbin/dhclient
   /snap/core/8935/usr/lib/snapd/snap-confine
   /snap/core/8935/usr/lib/snapd/snap-confine//mount-namespace-capture-helper
   /usr/bin/evince
   /usr/bin/evince-previewer
   /usr/bin/evince-previewer//sanitized_helper
   /usr/bin/evince-thumbnailer
   /usr/bin/evince//sanitized_helper
   /usr/bin/man
   /usr/lib/NetworkManager/nm-dhcp-client.action
   /usr/lib/NetworkManager/nm-dhcp-helper
   /usr/lib/connman/scripts/dhclient-script
   /usr/lib/cups/backend/cups-pdf
   /usr/lib/snapd/snap-confine
   /usr/lib/snapd/snap-confine//mount-namespace-capture-helper
   /usr/sbin/cups-browsed
   /usr/sbin/cupsd
   /usr/sbin/cupsd//third_party
   /usr/sbin/ippusbxd
   /usr/sbin/tcpdump
   libreoffice-senddoc
   libreoffice-soffice//gpg
   libreoffice-xpdfimport
   man_filter
   man_groff
   snap-update-ns.core
   snap-update-ns.gnome-calculator
   snap-update-ns.gnome-characters
   snap-update-ns.gnome-logs
   snap-update-ns.gnome-system-monitor
   snap.core.hook.configure
   snap.gnome-calculator.gnome-calculator
   snap.gnome-characters.gnome-characters
   snap.gnome-logs.gnome-logs
   snap.gnome-system-monitor.gnome-system-monitor
2 profiles are in complain mode.
   libreoffice-oopslash
   libreoffice-soffice
4 processes have profiles defined.
4 processes are in enforce mode.
   /sbin/dhclient (1051)
   /sbin/dhclient (1123)
   /usr/sbin/cups-browsed (9147)
   /usr/sbin/cupsd (9146)
0 processes are in complain mode.
0 processes are unconfined but have a profile defined.

SELinux mode: unknown
no big block device was specified on commandline.
Tests which require a big block device are disabled.
You can specify it with option -z
COMMAND:    /opt/ltp/bin/ltp-pan   -e -S   -a 14168     -n 14168 -p -f /tmp/ltp-sSwnaYNEDL/alltests -l /opt/ltp/results/LTP_RUN_ON-2020_04_06-19h_44m_15s.log  -C /opt/ltp/output/LTP_RUN_ON-2020_04_06-19h_44m_15s.failed -T /opt/ltp/output/LTP_RUN_ON-2020_04_06-19h_44m_15s.tconf
INFO: Restricted to zram01
LOG File: /opt/ltp/results/LTP_RUN_ON-2020_04_06-19h_44m_15s.log
FAILED COMMAND File: /opt/ltp/output/LTP_RUN_ON-2020_04_06-19h_44m_15s.failed
TCONF COMMAND File: /opt/ltp/output/LTP_RUN_ON-2020_04_06-19h_44m_15s.tconf
Running tests.......
<<<test_start>>>
tag=zram01 stime=1586182456
cmdline="zram01.sh"
contacts=""
analysis=exit
<<<test_output>>>
zram01 1 TINFO: timeout per run is 0h 5m 0s
zram01 1 TINFO: create '4' zram device(s)
zram01 1 TPASS: test succeeded
zram01 1 TCONF: The device attribute max_comp_streams was introduced in kernel 3.15 and deprecated in 4.7
zram01 2 TINFO: test that we can set compression algorithm
zram01 2 TINFO: supported algs: lzo lzo-rle lz4 lz4hc 842 zstd
sh: echo: I/O error
zram01 2 TFAIL: can't set 'lzo' to /sys/block/zram0/comp_algorithm
sh: echo: I/O error
sh: echo: I/O error
sh: echo: I/O error
sh: echo: I/O error
zram01 2 TINFO: AppArmor enabled, this may affect test results
zram01 2 TINFO: it can be disabled with TST_DISABLE_APPARMOR=1 (requires super/root)
zram01 2 TINFO: loaded AppArmor profiles: none

Summary:
passed   1
failed   1
skipped  1

Running tests.......
<<<test_start>>>
tag=zram02 stime=1586184287
cmdline="zram02.sh"
contacts=""
analysis=exit
<<<test_output>>>
zram02 1 TINFO: timeout per run is 0h 5m 0s
zram02 1 TINFO: create '1' zram device(s)
zram02 1 TFAIL: unexpected num of devices: 4
sh: echo: I/O error
zram02 1 TINFO: AppArmor enabled, this may affect test results
zram02 1 TINFO: it can be disabled with TST_DISABLE_APPARMOR=1 (requires super/root)
zram02 1 TINFO: loaded AppArmor profiles: none

Summary:
passed   0
failed   1
skipped  0
warnings 0
incrementing stop
<<<execution_status>>>

unning tests.......
<<<test_start>>>
tag=zram03 stime=1586184558
cmdline="zram03"
contacts=""
analysis=exit
<<<test_output>>>
zram03      0  TINFO  :  create a zram device with 536870912 bytes in size.
zram03      1  TBROK  :  safe_file_ops.c:301: Failed to close FILE '/sys/block/zram0/disksize' at zram03.c:87: errno=EBUSY(16): Device or resource busy
zram03      2  TBROK  :  safe_file_ops.c:301: Remaining cases broken
incrementing stop
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=2 corefile=no
cutime=0 cstime=0
<<<test_end>>>
INFO: ltp-pan reported some tests FAIL
LTP Version: 20200120-31-g452c5132d

       ###############################################################

            Done executing testcases.
            LTP Version:  20200120-31-g452c5132d
       #############################################

what could the reason that all zram related tests are getting failed??


Thanks !
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200406/cb1806b3/attachment-0001.htm>
