From: Vineet Gupta <vineet.gupta1@synopsys.com>
Date: Tue, 12 Mar 2019 10:44:39 -0700
Subject: [LTP] [PATCH] cpuset: disable for UCLIBC
Message-ID: <1552412679-28694-1-git-send-email-vgupta@synopsys.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

libcpuset.c relies on FTS which is not enabled by default on uClibc.
Instead of needing to reconfigure, rebuild uClibc lets disable this test
for uClibc

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 testcases/kernel/controllers/Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/testcases/kernel/controllers/Makefile b/testcases/kernel/controllers/Makefile
index 404073947904..9f4abe28bfcf 100644
--- a/testcases/kernel/controllers/Makefile
+++ b/testcases/kernel/controllers/Makefile
@@ -29,6 +29,11 @@ LIBDIR			:= libcontrollers
 LIB			:= $(LIBDIR)/libcontrollers.a
 FILTER_OUT_DIRS		:= $(LIBDIR)
 
+# controllers/cpuset/cpuset_lib/libcpuset.c uses fts
+ifeq ($(UCLIBC),1)
+FILTER_OUT_DIRS	+= cpuset
+endif
+
 $(LIBDIR):
 	mkdir -p "$@"
 
-- 
2.7.4

