From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 18 Mar 2020 12:48:27 +0530
Subject: [LTP] [PATCH] syscalls/pidfd_send_signal: Use local pointer to
 verify signal data
Message-ID: <31b0bde3ac9d0e617c2878a9b4ae1e1dc1f39c10.1584515853.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The current check, uinfo->si_value.sival_int == DATA, will always
evaluate to true as we are checking uinfo by mistake instead of the
pointer passed to the callback. Fix it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 .../kernel/syscalls/pidfd_send_signal/pidfd_send_signal01.c     | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal01.c b/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal01.c
index 64dddad6643a..3137b6967371 100644
--- a/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal01.c
+++ b/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal01.c
@@ -26,7 +26,7 @@ static int pidfd;
 static void received_signal(int sig, siginfo_t *info, void *ucontext)
 {
 	if (info && ucontext) {
-		if (sig == SIGNAL && uinfo->si_value.sival_int == DATA) {
+		if (sig == SIGNAL && info->si_value.sival_int == DATA) {
 			tst_res(TPASS, "Received correct signal and data!");
 			sig_rec = 1;
 		} else {
-- 
2.21.0.rc0.269.g1a574e7a288b

