From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 18 Jan 2016 16:38:32 +0100
Subject: [LTP] [BUG] oom hangs the system,
 NMI backtrace shows most CPUs in shrink_slab
Message-ID: <569D06F8.4040209@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

I'm seeing system occasionally hanging after "oom01" testcase
from LTP triggers OOM.

Here's a console log obtained from v4.4-8606 (shows oom, followed
by blocked task messages, followed by me triggering sysrq-t):
  http://jan.stancek.eu/tmp/oom_hangs/oom_hang_v4.4-8606.txt
  http://jan.stancek.eu/tmp/oom_hangs/config-v4.4-8606.txt

I'm running this patch on top, to trigger sysrq-t (system is in remote location):

diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 36e2697..f1a27f3 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -77,6 +77,7 @@
 #include <linux/string.h>
 #include <linux/netfilter_ipv4.h>
 #include <linux/slab.h>
+#include <linux/sched.h>
 #include <net/snmp.h>
 #include <net/ip.h>
 #include <net/route.h>
@@ -917,6 +918,10 @@ static bool icmp_echo(struct sk_buff *skb)
                icmp_param.data_len        = skb->len;
                icmp_param.head_len        = sizeof(struct icmphdr);
                icmp_reply(&icmp_param, skb);
+               if (icmp_param.data_len == 1025) {
+                       printk("icmp_echo: %d\n", icmp_param.data_len);
+                       show_state();
+               }
        }
        /* should there be an ICMP stat for ignored echos? */
        return true;


oom01 testcase used to be single threaded, which however caused
tests to run a long time on big boxes with 4+TB of RAM. So, to speed
memory consumption we made it to consume memory in multiple threads.

This was roughly the time kernels started hanging during OOM.
I went back to try older longterm stable releases (3.10.94, 3.12.52), but
I could reproduce problem here as well. So it seems that problem always
existed, but only recent test change exposed it.

I have couple bare metal systems where it triggers within couple hours. For
example: 1x CPU Intel(R) Xeon(R) CPU E3-1285L with 16GB ram. It's not arch
specific, it happens on ppc64 be/le lpar's or KVM guests too.

My reproducer involves running LTP's oom01 testcase in loop. The core
of test is alloc_mem(), which is a combination of mmap/mlock/madvice
and touching all pages:
  https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/mem/lib/mem.c#L29

Regards,
Jan
