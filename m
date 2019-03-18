From: Vineet Gupta <vineet.gupta1@synopsys.com>
Date: Mon, 18 Mar 2019 13:06:42 -0700
Subject: [LTP] [PATCH] auto filter aio tests of libc can't support aio
In-Reply-To: <20190318181940.GA5494@dell5510>
References: <20190318181940.GA5494@dell5510>
Message-ID: <1552939602-22335-1-git-send-email-vgupta@synopsys.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

uClibc-ng lacks libaio.h and thus LTP UCLIBC=1 builds need to filter
out aio tests which it currently doesn't.

FWIW the tests sources themselves use a slightly different guard
HAVE_LIBAIO (while autotool generate HAVE_LIBAIO_H).
Anyhow that seems pointless as aio tests should not even build of libc
doesn't support the prerequsute header.

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 testcases/kernel/io/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/testcases/kernel/io/Makefile b/testcases/kernel/io/Makefile
index 7db02882a530..3afae3888f63 100644
--- a/testcases/kernel/io/Makefile
+++ b/testcases/kernel/io/Makefile
@@ -24,4 +24,8 @@ top_srcdir		?= ../../..
 
 include $(top_srcdir)/include/mk/env_pre.mk
 
+ifndef HAVE_LIBAIO_H
+FILTER_OUT_DIRS	+= aio
+endif
+
 include $(top_srcdir)/include/mk/generic_trunk_target.mk
-- 
2.7.4

