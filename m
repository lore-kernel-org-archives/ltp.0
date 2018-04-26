From: Li Wang <liwang@redhat.com>
Date: Thu, 26 Apr 2018 15:02:00 +0800
Subject: [LTP] LTP cve-2017-5754 test fails on kernel-v4.17-rc2
Message-ID: <CAEemH2enj4MUFRc03CLzuHzqJGJFESeQvj5oitZ2Am+Ww=jVYA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi LKML & LTP,

LTP/meltdown.c fails on upstream kernel-v4.17-rc2 with both kvm and
bare-metal system. Please attention!!!

kernel-v4.17-rc2 FAIL
kernel-v4.17-rc1 PASS


=======================

Kernel Version: 4.17.0-rc2
Machine Architecture: x86_64

tst_test.c:1015: INFO: Timeout per run is 0h 50m 00s
meltdown.c:259: INFO: access time: cached = 51, uncached = 343, threshold = 132
meltdown.c:309: INFO: linux_proc_banner is at ffffffff8ba00060
meltdown.c:332: INFO: read ffffffff8ba00060 = 0x25 %
meltdown.c:332: INFO: read ffffffff8ba00061 = 0x73 s
meltdown.c:332: INFO: read ffffffff8ba00062 = 0x20
meltdown.c:332: INFO: read ffffffff8ba00063 = 0x76 v
meltdown.c:332: INFO: read ffffffff8ba00064 = 0x65 e
meltdown.c:332: INFO: read ffffffff8ba00065 = 0x72 r
meltdown.c:332: INFO: read ffffffff8ba00066 = 0x73 s
meltdown.c:332: INFO: read ffffffff8ba00067 = 0x69 i
meltdown.c:332: INFO: read ffffffff8ba00068 = 0x6f o
meltdown.c:332: INFO: read ffffffff8ba00069 = 0x6e n
meltdown.c:332: INFO: read ffffffff8ba0006a = 0x20
meltdown.c:332: INFO: read ffffffff8ba0006b = 0x25 %
meltdown.c:332: INFO: read ffffffff8ba0006c = 0x73 s
meltdown.c:342: FAIL: I was able to read your kernel memory!!!

Summary:
passed   0
failed   1
skipped  0
warnings 0


# lscpu
Architecture:          x86_64
CPU op-mode(s):        32-bit, 64-bit
Byte Order:            Little Endian
CPU(s):                2
On-line CPU(s) list:   0,1
Thread(s) per core:    1
Core(s) per socket:    1
Socket(s):             2
NUMA node(s):          1
Vendor ID:             GenuineIntel
CPU family:            6
Model:                 13
Model name:            QEMU Virtual CPU version (cpu64-rhel6)
Stepping:              3
CPU MHz:               2892.748
BogoMIPS:              5785.49
Hypervisor vendor:     KVM
Virtualization type:   full
L1d cache:             32K
L1i cache:             32K
L2 cache:              4096K
NUMA node0 CPU(s):     0,1
Flags:                 fpu de pse tsc msr pae mce cx8 apic mtrr pge mca
cmov pse36 clflush mmx fxsr sse sse2 syscall nx lm nopl cpuid pni cx16
hypervisor lahf_lm pti


-- 
Li Wang
liwang@redhat.com
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180426/96b97a20/attachment.html>
