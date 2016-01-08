From: Khem Raj <raj.khem@gmail.com>
Date: Fri,  8 Jan 2016 08:11:26 +0000
Subject: [LTP] [PATCH 06/31] sendfile: Use off64_t instead of __off64_t
In-Reply-To: <1452240711-51180-1-git-send-email-raj.khem@gmail.com>
References: <1452240711-51180-1-git-send-email-raj.khem@gmail.com>
Message-ID: <1452240711-51180-6-git-send-email-raj.khem@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

__off64_t is specific to glibc where as off64_t is widely available
Add _GNU_SOURCE for off64_t defines from sys/types.h
Fixes
<command-line>:0:7: error: unknown type name 'off64_t'
sendfile02.c:97:18: note: in expansion of macro 'OFF_T'

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 testcases/kernel/syscalls/sendfile/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/sendfile/Makefile b/testcases/kernel/syscalls/sendfile/Makefile
index df7b63f..1bd1b57 100644
--- a/testcases/kernel/syscalls/sendfile/Makefile
+++ b/testcases/kernel/syscalls/sendfile/Makefile
@@ -21,6 +21,6 @@ top_srcdir		?= ../../../..
 include $(top_srcdir)/include/mk/testcases.mk
 include $(abs_srcdir)/../utils/newer_64.mk
 
-%_64: CPPFLAGS += -D_FILE_OFFSET_BITS=64 -DOFF_T=__off64_t
+%_64: CPPFLAGS += -D_FILE_OFFSET_BITS=64 -DOFF_T=off64_t -D_GNU_SOURCE
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
-- 
2.7.0

