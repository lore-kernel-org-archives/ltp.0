From: Li Wang <liwang@redhat.com>
Date: Mon, 1 Jul 2019 15:50:52 +0800
Subject: [LTP] [Kernel BUG?] SMSW operation get success on UMIP KVM guest
Message-ID: <CAEemH2cg01cdz=amrCWU00Xof9+cxmfR_DqCBaQe36QoGsakmA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello there,

LTP/umip_basic_test get failed on KVM UMIP system(kernel-v5.2-rc4.x86_64).
The test is only trying to do
     asm volatile("smsw %0\n" : "=m" (val));
and expect to get SIGSEGV in this SMSW operation, but it exits with 0
unexpectedly.

====================
# grep CONFIG_X86_INTEL_UMIP /boot/config-5.2.0-0.rc4.x86_64
CONFIG_X86_INTEL_UMIP=y

# lscpu |grep umip
Flags:               fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush mmx fxsr sse sse2 ss syscall nx pdpe1gb rdtscp
lm constant_tsc rep_good nopl xtopology cpuid tsc_known_freq pni pclmulqdq
ssse3 fma cx16 pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer
aes xsave avx f16c rdrand hypervisor lahf_lm abm 3dnowprefetch cpuid_fault
invpcid_single pti ssbd ibrs ibpb stibp fsgsbase tsc_adjust bmi1 hle avx2
smep bmi2 erms invpcid rtm mpx avx512f avx512dq rdseed adx smap clflushopt
clwb avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 xsaves arat umip
pku ospke md_clear

# ./umip_basic_test
...
umip_basic_test.c:68: INFO: TEST smsw, smsw result save at [0x7ffda00dca70]
umip_basic_test.c:118: FAIL: Didn't receive SIGSEGV, child exited with
exited with 0

You also could try this simplify reproducer:
----------------
#define _GNU_SOURCE
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/wait.h>

int main (void)
{
        int status;
        pid_t pid;

        pid = fork();
        if (pid == 0) {
                unsigned long val;
                printf("TEST smsw, smsw result save at [%p]\n", &val);
                asm volatile("smsw %0\n" : "=m" (val));
                exit(0);
        }

        waitpid(pid, &status, 0);

        if (WIFSIGNALED(status) && WTERMSIG(status) == SIGSEGV) {
                printf("PASS: Got SIGSEGV\n");
                return 0;
        }

        printf("FAIL: Didn't receive SIGSEGV, child exited with %d\n",
WEXITSTATUS(status));
        return -1;
}

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190701/24e61c3e/attachment-0001.htm>
