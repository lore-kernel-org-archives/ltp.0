From: Steve Muckle <smuckle@google.com>
Date: Thu,  8 Nov 2018 17:46:16 -0800
Subject: [LTP] [PATCH 2/2] syscalls/sighold02: ignore reserved signals
In-Reply-To: <20181109014616.165281-1-smuckle@google.com>
References: <20181109014616.165281-1-smuckle@google.com>
Message-ID: <20181109014616.165281-2-smuckle@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Some signals may be internally used by the C library. Do not attempt to
verify these.

Change-Id: If5a6a9bd7bbeceacde6904393c7452d927fa7522
---
 testcases/kernel/syscalls/sighold/sighold02.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/testcases/kernel/syscalls/sighold/sighold02.c b/testcases/kernel/syscalls/sighold/sighold02.c
index fdd0e736d..d1d4b0b06 100644
--- a/testcases/kernel/syscalls/sighold/sighold02.c
+++ b/testcases/kernel/syscalls/sighold/sighold02.c
@@ -55,16 +55,6 @@
 # define NSIG _NSIG
 #endif
 
-/* Needed for NPTL */
-#define SIGCANCEL 32
-#define SIGTIMER 33
-
-/* Reserved in Android's bionic libc */
-#ifdef __ANDROID__
-# define SIGLIBCORE 34
-# define SIGDEBUGGERD 35
-#endif
-
 /* ensure NUMSIGS is defined */
 #ifndef NUMSIGS
 # define NUMSIGS NSIG
@@ -83,17 +73,14 @@ static int sigs_map[NUMSIGS];
 
 static int skip_sig(int sig)
 {
+	if (sig >= __SIGRTMIN && sig < SIGRTMIN)
+		return 1;
+
 	switch (sig) {
 	case SIGCHLD:
 	case SIGKILL:
 	case SIGALRM:
 	case SIGSTOP:
-	case SIGCANCEL:
-	case SIGTIMER:
-#ifdef __ANDROID__
-	case SIGLIBCORE:
-	case SIGDEBUGGERD:
-#endif
 		return 1;
 	default:
 		return 0;
-- 
2.19.1.930.g4563a0d9d0-goog

