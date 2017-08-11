From: Daniel Lezcano <daniel.lezcano@linaro.org>
Date: Fri, 11 Aug 2017 12:54:46 +0000
Subject: [LTP] [PATCH V2 2/2] syscalls/pselect: Add a zero latency constraint
In-Reply-To: <1502456086-14696-1-git-send-email-daniel.lezcano@linaro.org>
References: <337916262.70548323.1502450718721.JavaMail.zimbra@redhat.com>
 <1502456086-14696-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1502456086-14696-2-git-send-email-daniel.lezcano@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The pselect_01 testcase works well on an x86 as it is a fast platform, with
fast exit latency idle routine.

However on ARM[64] the idle routine can take much more time, for example
1500us.

The pselect fails on the ARM[64] platforms because of these slow exit latencies,
the delay between the expected expiration and the observed one is not
acceptable.

The fix could be to increase the deviation on ARM64 but that wouldn't make
sense as some platforms, for the same architecture, can have faster or
different delays, hence we can potentially miss a bug.

The simplest solution is to set the cpu_dma latency constraint to zero, so the
idle driver will always choose the fastest idle state, thus fixing the issue
above. The latency constraint will apply only for this test.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 testcases/kernel/syscalls/pselect/pselect01.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testcases/kernel/syscalls/pselect/pselect01.c b/testcases/kernel/syscalls/pselect/pselect01.c
index a2b5339..42027b6 100644
--- a/testcases/kernel/syscalls/pselect/pselect01.c
+++ b/testcases/kernel/syscalls/pselect/pselect01.c
@@ -44,6 +44,9 @@ int sample_fn(int clk_id, long long usec)
 }
 
 static struct tst_test test = {
+	.needs_root = 1,
+	.needs_latency = 1,
+	.latency = 0,
 	.tid = "pselect()",
 	.sample = sample_fn,
 };
-- 
2.1.4

