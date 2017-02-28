From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 28 Feb 2017 12:11:42 +0100
Subject: [LTP] [COMMITTED] [PATCH 20/23] syscalls/timerfd01: Make use of
	tst_parse_opts()
In-Reply-To: <20170228111145.3265-1-chrubis@suse.cz>
References: <20170228111145.3265-1-chrubis@suse.cz>
Message-ID: <20170228111145.3265-20-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

+ Fix warning

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/timerfd/timerfd01.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/timerfd/timerfd01.c b/testcases/kernel/syscalls/timerfd/timerfd01.c
index 00bae88..4a3cf2f 100644
--- a/testcases/kernel/syscalls/timerfd/timerfd01.c
+++ b/testcases/kernel/syscalls/timerfd/timerfd01.c
@@ -132,7 +132,8 @@ int TST_TOTAL = 3;
 
 int main(int ac, char **av)
 {
-	int i, tfd;
+	int tfd;
+	unsigned int i;
 	long ticks;
 	unsigned long long tnow, ttmr;
 	u_int64_t uticks;
@@ -142,6 +143,8 @@ int main(int ac, char **av)
 		{CLOCK_REALTIME, "CLOCK REALTIME"},
 	};
 
+	tst_parse_opts(ac, av, NULL, NULL);
+
 	if ((tst_kvercmp(2, 6, 25)) < 0) {
 		tst_resm(TCONF, "This test can only run on kernels that are ");
 		tst_resm(TCONF, "2.6.25 and higher");
-- 
2.10.2

