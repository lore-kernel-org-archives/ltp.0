From: Kenneth Magic <kmagic@google.com>
Date: Tue, 28 Aug 2018 11:21:30 -0700
Subject: [LTP]  [PATCH] Skip additional reserved signals in Android.
Message-ID: <CABHszYvs7e3WveuV+_X5H6APfQHmnn6=MgwfHD8rSLGDQajVOA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

In Android's bionic libc, two additional signals are reserved
and need to be skipped in the test.

Signed-off-by: Kenneth Magic <kmagic@google.com>
---
 testcases/kernel/syscalls/sighold/sighold02.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/testcases/kernel/syscalls/sighold/sighold02.c
b/testcases/kernel/syscalls/sighold/sighold02.c
index 8df5fa7db..fdd0e736d 100644
--- a/testcases/kernel/syscalls/sighold/sighold02.c
+++ b/testcases/kernel/syscalls/sighold/sighold02.c
@@ -59,6 +59,12 @@
 #define SIGCANCEL 32
 #define SIGTIMER 33

+/* Reserved in Android's bionic libc */
+#ifdef __ANDROID__
+# define SIGLIBCORE 34
+# define SIGDEBUGGERD 35
+#endif
+
 /* ensure NUMSIGS is defined */
 #ifndef NUMSIGS
 # define NUMSIGS NSIG
@@ -84,6 +90,10 @@ static int skip_sig(int sig)
  case SIGSTOP:
  case SIGCANCEL:
  case SIGTIMER:
+#ifdef __ANDROID__
+ case SIGLIBCORE:
+ case SIGDEBUGGERD:
+#endif
  return 1;
  default:
  return 0;
-- 
2.19.0.rc0.228.g281dcd1b4d0-goog
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180828/8ceb5293/attachment.html>
