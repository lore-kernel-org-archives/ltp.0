From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 26 Sep 2019 04:29:41 -0400 (EDT)
Subject: [LTP] LTP Release
In-Reply-To: <20190925112236.GA17496@rei.lan>
References: <20190906130707.GA7515@rei.lan> <20190925112236.GA17496@rei.lan>
Message-ID: <748796853.2255246.1569486581084.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi!
> I did a few testruns and so far it looks good.
> 
> I've send one patch for acct02, which is mostly cosmetic, that I would
> like to get merged.
> 
> I would still consider merging the eBPF regression test, does anybody
> have a strong opinion on this?
> 
> Apart from this preadv203 sometimes fails to trigger EAGAIN on virtual
> machines, but I doubt we can fix this before the release, I will try to
> do so later on.
> 
> The rest seems to be good, i.e. failures does not seem to be bugs in
> tests.
> 
> What is the status from rest of you? Is there anything that should be
> considered for the release? Is something failing unexpectedly?

I'm thinking if we should patch BPF tests to increase max lock memory
to +1MB. On Fedora30 default limit is '64', and I found couple
systems which by default come very close to that limit right after boot.
So even one iteration of BPF tests will hit a failure.

# lscpu 
Architecture:        x86_64
CPU op-mode(s):      32-bit, 64-bit
Byte Order:          Little Endian
Address sizes:       40 bits physical, 48 bits virtual
CPU(s):              16
On-line CPU(s) list: 0-15
Thread(s) per core:  2
Core(s) per socket:  4
Socket(s):           2
NUMA node(s):        2
Vendor ID:           GenuineIntel
CPU family:          6
Model:               26
Model name:          Intel(R) Xeon(R) CPU           E5530  @ 2.40GHz
Stepping:            5
CPU MHz:             1596.091
CPU max MHz:         2395.0000
CPU min MHz:         1596.0000
BogoMIPS:            4788.26
Virtualization:      VT-x
L1d cache:           32K
L1i cache:           32K
L2 cache:            256K
L3 cache:            8192K
NUMA node0 CPU(s):   0,2,4,6,8,10,12,14
NUMA node1 CPU(s):   1,3,5,7,9,11,13,15
Flags:               fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ht tm pbe syscall nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm dca sse4_1 sse4_2 popcnt lahf_lm pti tpr_shadow vnmi flexpriority ept vpid dtherm ida

# uname -r
5.3.0-351c8a0.cki

# cat /etc/redhat-release 
Fedora release 30 (Thirty)

> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
> 
