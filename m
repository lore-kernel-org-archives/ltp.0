From: Rafael David Tinoco <rafael.tinoco@linaro.org>
Date: Wed, 10 Oct 2018 08:41:36 -0300
Subject: [LTP] [PATCH v2 2/2] futex/futex_wake04.c: raise delay waiting for
	threads
In-Reply-To: <20181010114136.23957-1-rafael.tinoco@linaro.org>
References: <20181010104317.GB1990@rei>
 <20181010114136.23957-1-rafael.tinoco@linaro.org>
Message-ID: <20181010114136.23957-2-rafael.tinoco@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

usleep() time was too small if test is being executed in slower terminal
devices (specially embedded systems). Raising it to 0.001 seconds was
enough to finish 10240 iterations in around 90 seconds in a 4 vcpu kvm
guest (fully emulated serial being used as console).

Link: https://bugs.linaro.org/show_bug.cgi?id=3984
Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
---
 testcases/kernel/syscalls/futex/futex_wake04.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/futex/futex_wake04.c b/testcases/kernel/syscalls/futex/futex_wake04.c
index 1ae9599ab..bd10e56af 100644
--- a/testcases/kernel/syscalls/futex/futex_wake04.c
+++ b/testcases/kernel/syscalls/futex/futex_wake04.c
@@ -175,8 +175,9 @@ static void wakeup_thread2(void)
 				tst_strerrno(res));
 	}
 
+    /* 0.001 seconds: less might cause lockups for slower terminals */
 	while (wait_for_threads(2))
-		usleep(100);
+		usleep(1000);
 
 	futex_wake(futex2, 1, 0);
 
-- 
2.19.1

