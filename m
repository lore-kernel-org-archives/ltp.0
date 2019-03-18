From: Vineet Gupta <vineet.gupta1@synopsys.com>
Date: Mon, 18 Mar 2019 12:52:44 -0700
Subject: [LTP] [PATCH v2] autodetect fts support and tests depending on it
In-Reply-To: <20190318181940.GA5494@dell5510>
References: <20190318181940.GA5494@dell5510>
Message-ID: <1552938764-15101-1-git-send-email-vgupta@synopsys.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 configure.ac                          | 1 +
 testcases/kernel/controllers/Makefile | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/configure.ac b/configure.ac
index e002c248eab2..10b2f6b1e43b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -33,6 +33,7 @@ AC_PROG_YACC
 AC_PREFIX_DEFAULT(/opt/ltp)
 
 AC_CHECK_HEADERS([ \
+    fts.h \
     ifaddrs.h \
     keyutils.h \
     linux/can.h \
diff --git a/testcases/kernel/controllers/Makefile b/testcases/kernel/controllers/Makefile
index 404073947904..a1626ae03695 100644
--- a/testcases/kernel/controllers/Makefile
+++ b/testcases/kernel/controllers/Makefile
@@ -29,6 +29,12 @@ LIBDIR			:= libcontrollers
 LIB			:= $(LIBDIR)/libcontrollers.a
 FILTER_OUT_DIRS		:= $(LIBDIR)
 
+# controllers/cpuset/cpuset_lib/libcpuset.c uses fts
+# which may not be available/configured in the libc build
+ifndef HAVE_FTS_H
+FILTER_OUT_DIRS	+= cpuset
+endif
+
 $(LIBDIR):
 	mkdir -p "$@"
 
-- 
2.7.4

