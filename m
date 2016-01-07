From: Khem Raj <raj.khem@gmail.com>
Date: Thu,  7 Jan 2016 17:46:44 +0000
Subject: [LTP] [PATCH 3/3] Add knob to control tirpc support
In-Reply-To: <1452188804-8959-1-git-send-email-raj.khem@gmail.com>
References: <1452188804-8959-1-git-send-email-raj.khem@gmail.com>
Message-ID: <1452188804-8959-3-git-send-email-raj.khem@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Fathi Boudra <fathi.boudra@linaro.org>

allow to disable tirpc. Helps to disable it at top level for eg. musl it
does not yet work.

Signed-off-by: Fathi Boudra <fathi.boudra@linaro.org>
Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 configure.ac | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/configure.ac b/configure.ac
index d1095b6..687622c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -98,6 +98,13 @@ if test "x$with_python" = xyes; then
 else
     AC_SUBST([WITH_PYTHON],["no"])
 fi
+
+# TI RPC
+AC_ARG_WITH([tirpc],
+  AC_HELP_STRING([--without-tirpc],
+    [without libtirpc support]),
+  [],[with_tirpc=yes],
+)
 # END tools knobs
 
 # Testsuites knobs
@@ -177,7 +184,9 @@ LTP_CHECK_RENAMEAT2
 LTP_CHECK_FALLOCATE
 LTP_CHECK_SYSCALL_FCNTL
 LTP_CHECK_SYSCALL_PERF_EVENT_OPEN
+if test "x$with_tirpc" = xyes; then
 LTP_CHECK_TIRPC
+fi
 LTP_CHECK_TEE
 LTP_CHECK_SPLICE
 LTP_CHECK_VMSPLICE
-- 
2.7.0

