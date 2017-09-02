From: Petr Vorel <petr.vorel@gmail.com>
Date: Sat,  2 Sep 2017 02:59:26 +0200
Subject: [LTP] [RFC PATCH 6/6] android: cve/stack_clash: Fix warning
In-Reply-To: <20170902005926.15923-1-petr.vorel@gmail.com>
References: <20170902005926.15923-1-petr.vorel@gmail.com>
Message-ID: <20170902005926.15923-7-petr.vorel@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

format '%lx' expects argument of type 'long unsigned int', but argument 8 has type 'ssize_t'

Still some warnings left in cve.

Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
 testcases/cve/stack_clash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/cve/stack_clash.c b/testcases/cve/stack_clash.c
index 2d2984824..ee537a3c5 100644
--- a/testcases/cve/stack_clash.c
+++ b/testcases/cve/stack_clash.c
@@ -85,7 +85,7 @@ void segv_handler(int sig, siginfo_t *info, void *data LTP_ATTRIBUTE_UNUSED)
 
 	tst_res(TINFO,
 		"mmap = [%lx, %lx), addr = %lx, diff = %lx, THRESHOLD = %lx",
-		mapped_addr, mmap_end, fault_addr, diff, THRESHOLD);
+		mapped_addr, mmap_end, fault_addr, (long)diff, THRESHOLD);
 	if (diff < 0 || (unsigned long)diff < THRESHOLD)
 		_exit(EXIT_FAILURE);
 	else
-- 
2.14.0

