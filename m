From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 12 Nov 2019 04:56:12 -0500 (EST)
Subject: [LTP] 
 =?utf-8?q?=E2=9D=8C_FAIL=3A_Test_report_for_kernel_5=2E4?=
 =?utf-8?q?=2E0-rc6-dd89262=2Ecki_=28mainline=2Ekernel=2Eorg=29?=
In-Reply-To: <232041279.11531466.1573491604178.JavaMail.zimbra@redhat.com>
References: <cki.ECB352932E.9FL0Q68EC2@redhat.com>
 <232041279.11531466.1573491604178.JavaMail.zimbra@redhat.com>
Message-ID: <976393725.11648955.1573552572246.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> 
> ----- Original Message -----
> >      ? LTP lite
> 
> perf_event_open02 again:

I have a system [1] where it's consistently reproducible.
It looks like count_hardware_counters() reports incorrect number.
time_enabled and time_running are different but only barely (~0.7%).

# ./perf_event_open02 -v
at iteration:0 value:300357893 time_enabled:55368608 time_running:55368608
at iteration:1 value:600712498 time_enabled:54808179 time_running:54403148
perf_event_open02    0  TINFO  :  overall task clock: 54825931
perf_event_open02    0  TINFO  :  hw sum: 1442538620, task clock sum: 260919342
hw counters: 288507724 288507724 288507724 288507724 288507724
task clock counters: 51773047 52526664 52531694 52540386 51547551
perf_event_open02    0  TINFO  :  ratio: 4.759050
perf_event_open02    1  TFAIL  :  perf_event_open02.c:394: test failed (ratio was greater than )

Also do_work() completes pretty fast compared to a different host:

real	0m0.176s
user	0m0.163s
sys	0m0.003s

[1]
# lscpu 
Architecture:                    x86_64
CPU op-mode(s):                  32-bit, 64-bit
Byte Order:                      Little Endian
Address sizes:                   36 bits physical, 48 bits virtual
CPU(s):                          4
On-line CPU(s) list:             0-3
Thread(s) per core:              2
Core(s) per socket:              1
Socket(s):                       2
NUMA node(s):                    1
Vendor ID:                       GenuineIntel
CPU family:                      15
Model:                           3
Model name:                      Intel(R) Xeon(TM) CPU 3.40GHz
Stepping:                        4
CPU MHz:                         2800.000
CPU max MHz:                     3400.0000
CPU min MHz:                     2800.0000
BogoMIPS:                        6800.62
L1d cache:                       32 KiB
L2 cache:                        2 MiB
NUMA node0 CPU(s):               0-3
Vulnerability L1tf:              Mitigation; PTE Inversion
Vulnerability Mds:               Vulnerable: Clear CPU buffers attempted, no microcode; SMT vulnerable
Vulnerability Meltdown:          Mitigation; PTI
Vulnerability Spec store bypass: Vulnerable
Vulnerability Spectre v1:        Mitigation; usercopy/swapgs barriers and __user pointer sanitization
Vulnerability Spectre v2:        Mitigation; Full generic retpoline, STIBP disabled, RSB filling
Flags:                           fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall lm constant_tsc pebs bts nopl cpui
                                 d pni dtes64 monitor ds_cpl est tm2 cid xtpr pti

