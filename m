From: Petr Vorel <pvorel@suse.cz>
Date: Fri,  9 Jun 2017 21:12:52 +0200
Subject: [LTP] [PATCH v2 4/4] syscalls/mq_*: Cleanup unused _POSIX_C_SOURCE
	macro
In-Reply-To: <20170609191252.9870-1-pvorel@suse.cz>
References: <20170609191252.9870-1-pvorel@suse.cz>
Message-ID: <20170609191252.9870-4-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/syscalls/mq_notify/Makefile       | 1 -
 testcases/kernel/syscalls/mq_timedreceive/Makefile | 1 -
 testcases/kernel/syscalls/mq_unlink/Makefile       | 1 -
 3 files changed, 3 deletions(-)

diff --git a/testcases/kernel/syscalls/mq_notify/Makefile b/testcases/kernel/syscalls/mq_notify/Makefile
index 1b4a564e0..7b9304212 100644
--- a/testcases/kernel/syscalls/mq_notify/Makefile
+++ b/testcases/kernel/syscalls/mq_notify/Makefile
@@ -20,7 +20,6 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-CPPFLAGS		?= -D_POSIX_C_SOURCE=$(shell getconf _POSIX_MESSAGE_PASSING)L
 CPPFLAGS		+= -I$(abs_srcdir)/../utils
 LDLIBS			+= -lpthread -lrt
 
diff --git a/testcases/kernel/syscalls/mq_timedreceive/Makefile b/testcases/kernel/syscalls/mq_timedreceive/Makefile
index 1b4a564e0..7b9304212 100644
--- a/testcases/kernel/syscalls/mq_timedreceive/Makefile
+++ b/testcases/kernel/syscalls/mq_timedreceive/Makefile
@@ -20,7 +20,6 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-CPPFLAGS		?= -D_POSIX_C_SOURCE=$(shell getconf _POSIX_MESSAGE_PASSING)L
 CPPFLAGS		+= -I$(abs_srcdir)/../utils
 LDLIBS			+= -lpthread -lrt
 
diff --git a/testcases/kernel/syscalls/mq_unlink/Makefile b/testcases/kernel/syscalls/mq_unlink/Makefile
index 2e1628e9f..71ebae98b 100644
--- a/testcases/kernel/syscalls/mq_unlink/Makefile
+++ b/testcases/kernel/syscalls/mq_unlink/Makefile
@@ -20,7 +20,6 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-CPPFLAGS		?= -D_POSIX_C_SOURCE=$(shell getconf _POSIX_MESSAGE_PASSING)L
 LDLIBS			+= -lpthread -lrt
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
-- 
2.12.2

