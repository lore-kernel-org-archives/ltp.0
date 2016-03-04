From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Date: Fri, 4 Mar 2016 16:52:17 +0530
Subject: [LTP] [PATCH] rt_sigaction.h: adjust for ARC
Message-ID: <1457090537-23825-1-git-send-email-vgupta@synopsys.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

ARC uses the no-legacy syscall ABI where there is no need for
kernel_sigaction interworking.

Further we rely on default SA_RESTORER in libc for sigreturn.

To me all the song-and-dance in ltp_rt_sigaction() doesn't make sense.
The intent it to test whatever platform libc + kernel combination
provides and to that end any fixups in LTP seem odd to me.
So for ARC just call what libc provides and don't claim to support
more/less.

e.g. rt_sigaction02 fails for ARC, since libc sigaction does following

| int __libc_sigaction (int sig, const struct sigaction *act, struct sigaction *oact)
| {
|	struct sigaction kact;
|
|	if (act && !(act->sa_flags & SA_RESTORER)) {
|		kact.sa_restorer = __default_rt_sa_restorer;

So we don't get the EFAULT for @act == -1 which kernel would provide.
Instead we get a segv rightawat. But that's fine, that is how our system
works.

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 include/lapi/rt_sigaction.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/lapi/rt_sigaction.h b/include/lapi/rt_sigaction.h
index 3a5a763ce094..12af3c3b7b27 100644
--- a/include/lapi/rt_sigaction.h
+++ b/include/lapi/rt_sigaction.h
@@ -155,6 +155,13 @@ static void __attribute__((used)) __sigreturn_stub(void)
 static int ltp_rt_sigaction(int signum, const struct sigaction *act,
 			struct sigaction *oact, size_t sigsetsize)
 {
+#ifdef __arc__
+	/*
+	 * No playing games with various internals of sigaction / fields
+	 * just use whatever libc + kernel provide
+	 */
+	return sigaction(signum, act, oact);
+#else
 	int ret;
 	struct kernel_sigaction kact, koact;
 	struct kernel_sigaction *kact_p = NULL;
@@ -218,6 +225,7 @@ static int ltp_rt_sigaction(int signum, const struct sigaction *act,
 	}
 
 	return ret;
+#endif
 }
 
 #endif /* LTP_RT_SIGACTION_H */
-- 
2.5.0

