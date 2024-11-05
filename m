Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69628D1CA28
	for <ltp@archiver.kernel.org>; Tue,  5 Nov 2024 05:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1730784350; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=ZJDQ9ifU1e7j6rI90W5LDPF5VK7F2s/f0gxV2iSMtLQ=;
 b=l0wbdM3r5U4EwG/0M2ZQP/ej1h1qE8ci2IQJHkdlkivsyadHlX7n3U0HG9+bMEjuZDF9i
 Rcp1uoaFVlFTbhm8274/TRLspmNEuz96MNOW9S9Npt+FUqJfe3hyVELN+PhaFyADhcJA6P7
 dJNx3QofVE3TPpEq5aqZtZ4LtCG1/J8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 265703D1B59
	for <ltp@archiver.kernel.org>; Tue,  5 Nov 2024 06:25:50 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 714283CAA90
 for <ltp@lists.linux.it>; Tue,  5 Nov 2024 06:25:27 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4A7BD1012BC7
 for <ltp@lists.linux.it>; Tue,  5 Nov 2024 06:25:25 +0100 (CET)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-37d4ac91d97so4253025f8f.2
 for <ltp@lists.linux.it>; Mon, 04 Nov 2024 21:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1730784324; x=1731389124; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=eT0IsDfPtGubqVJjongD81DFD1PiubtOXbCOoki6vRM=;
 b=JL27BZEcick+bONdqT+lYxN/IObwMbmayQQB73WqhLT15+Orc2dvu12aqnbFs0OnFW
 qnULp3hWTMHSjgDDU8Go6r60Pwv7UOh+1wtiyr+2jQLlY3tqGOz/R4Yau65oTQZT5MHs
 PQ5wXbJxv2zQaAUUOmwDd3aZkG8U7fRaI2nu6cQ/7ULsrxCcRKwf4ZO8oS17DMXm9wAd
 STfOKyTfkP+2557PWgODoOCIkWQJX648do4TlO+xjM/+Dgs5qwbYvcYFVC93Y1EkjFfR
 ysuF4AsKpMzg3mX9mmhpNdEYQyrtn7W/x7l76ZCx+hqxk8CBpNJQCYXk7nXwpr8di4xz
 jqZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730784324; x=1731389124;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eT0IsDfPtGubqVJjongD81DFD1PiubtOXbCOoki6vRM=;
 b=iOOv4Ur97INgA2PIVSGE3jQXke8StprV6qhVOY3zpuZoXzifm1Up8SgFJ+4NuuKz6m
 FgTyU/fJ2oI1XoWhiDkzb2I3OIgafA1M6hsmE+U1uzRPleMvA077J2HAnqGC4/RjWpa1
 MSGWKSX4P8HisxbJZC38/58m8udCm1gzU8rMN0DtVHbKbCcDCu7nhJRjWQ7UJKbhZgcN
 cC9ddQ0yUe+IOQAI6QWgeCu6y6HPQmE7vmv+l0X5zopdNbVhvBZOmubV2K+IjV984QVN
 hMixTa9ZTF3OoXZ94HH1ai7S1GOIVTyuwXq3hUAKoxPKKOOHZAJMsaNNFvcr2kGVtFOH
 kwMw==
X-Gm-Message-State: AOJu0YyMpEt1oYruRCeHmyye4rySzq2/32HmOyAZ9fWoJiwaYlENTSDY
 ua+Fv8oGt6AkiRjV76KlSxyG9MPQd2mYL9QtTUWh1YJBzibGFnFwGFjJoml3zd7Xl/EGhjKF0Hk
 =
X-Google-Smtp-Source: AGHT+IET/x2K+o8BVwike1auhu9lghYQ6g7OkL6QLfKAAwGK2RSUIi2G1voL+xzdqokXViMyFkeS2Q==
X-Received: by 2002:a5d:59a3:0:b0:37d:3e6d:6a00 with SMTP id
 ffacd0b85a97d-381c7ac3d10mr13322361f8f.47.1730784324225; 
 Mon, 04 Nov 2024 21:25:24 -0800 (PST)
Received: from localhost ([2a07:de40:b240:0:dc1a:df90:dc1a:df90])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10d4983sm14873668f8f.33.2024.11.04.21.25.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 21:25:23 -0800 (PST)
To: ltp@lists.linux.it
Date: Tue,  5 Nov 2024 00:25:07 -0500
Message-Id: <20241105052507.29630-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Move cpuset_lib code to libs/ directory
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Wei Gao <wegao@suse.com>
---
 .../cpuset/cpuset_lib => include}/cpuset.h    |  0
 .../bitmask.h => include/cpuset_bitmask.h     |  0
 .../common.h => include/cpuset_common.h       |  0
 .../cpuinfo.h => include/cpuset_cpuinfo.h     |  0
 .../meminfo.h => include/cpuset_meminfo.h     |  0
 .../cpuset => libs}/cpuset_lib/Makefile       |  2 +-
 .../cpuset => libs}/cpuset_lib/cpuinfo.c      |  6 +++---
 .../cpuset => libs}/cpuset_lib/libbitmask.c   |  2 +-
 .../cpuset => libs}/cpuset_lib/libcpuset.c    |  4 ++--
 .../cpuset => libs}/cpuset_lib/meminfo.c      |  6 +++---
 testcases/kernel/controllers/cpuset/Makefile  | 16 ---------------
 .../kernel/controllers/cpuset/Makefile.inc    | 20 +++++++++----------
 .../cpuset/cpuset_base_ops_test/Makefile      |  3 +++
 .../cpuset/cpuset_exclusive_test/Makefile     |  3 +++
 .../cpuset/cpuset_hierarchy_test/Makefile     |  3 +++
 .../cpuset/cpuset_hotplug_test/Makefile       |  3 +++
 .../cpuset_hotplug_test/cpuset_list_compute.c |  4 ++--
 .../cpuset/cpuset_inherit_test/Makefile       |  3 +++
 .../cpuset/cpuset_load_balance_test/Makefile  |  3 +++
 .../cpuset_load_balance_test/cpuset_cpu_hog.c |  6 +++---
 .../cpuset_sched_domains_check.c              |  8 ++++----
 .../cpuset_memory_pressure_test/Makefile      |  5 +++++
 .../cpuset/cpuset_memory_spread_test/Makefile |  5 +++++
 .../cpuset_mem_hog.c                          |  2 +-
 .../cpuset/cpuset_memory_test/Makefile        |  3 +++
 .../cpuset_memory_test/cpuset_memory_test.c   |  2 +-
 .../cpuset/cpuset_syscall_test/Makefile       |  3 +++
 .../cpuset_syscall_test/cpuset_syscall_test.c |  4 ++--
 28 files changed, 67 insertions(+), 49 deletions(-)
 rename {testcases/kernel/controllers/cpuset/cpuset_lib => include}/cpuset.h (100%)
 rename testcases/kernel/controllers/cpuset/cpuset_lib/bitmask.h => include/cpuset_bitmask.h (100%)
 rename testcases/kernel/controllers/cpuset/cpuset_lib/common.h => include/cpuset_common.h (100%)
 rename testcases/kernel/controllers/cpuset/cpuset_lib/cpuinfo.h => include/cpuset_cpuinfo.h (100%)
 rename testcases/kernel/controllers/cpuset/cpuset_lib/meminfo.h => include/cpuset_meminfo.h (100%)
 rename {testcases/kernel/controllers/cpuset => libs}/cpuset_lib/Makefile (97%)
 rename {testcases/kernel/controllers/cpuset => libs}/cpuset_lib/cpuinfo.c (99%)
 rename {testcases/kernel/controllers/cpuset => libs}/cpuset_lib/libbitmask.c (99%)
 rename {testcases/kernel/controllers/cpuset => libs}/cpuset_lib/libcpuset.c (99%)
 rename {testcases/kernel/controllers/cpuset => libs}/cpuset_lib/meminfo.c (96%)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_lib/cpuset.h b/include/cpuset.h
similarity index 100%
rename from testcases/kernel/controllers/cpuset/cpuset_lib/cpuset.h
rename to include/cpuset.h
diff --git a/testcases/kernel/controllers/cpuset/cpuset_lib/bitmask.h b/include/cpuset_bitmask.h
similarity index 100%
rename from testcases/kernel/controllers/cpuset/cpuset_lib/bitmask.h
rename to include/cpuset_bitmask.h
diff --git a/testcases/kernel/controllers/cpuset/cpuset_lib/common.h b/include/cpuset_common.h
similarity index 100%
rename from testcases/kernel/controllers/cpuset/cpuset_lib/common.h
rename to include/cpuset_common.h
diff --git a/testcases/kernel/controllers/cpuset/cpuset_lib/cpuinfo.h b/include/cpuset_cpuinfo.h
similarity index 100%
rename from testcases/kernel/controllers/cpuset/cpuset_lib/cpuinfo.h
rename to include/cpuset_cpuinfo.h
diff --git a/testcases/kernel/controllers/cpuset/cpuset_lib/meminfo.h b/include/cpuset_meminfo.h
similarity index 100%
rename from testcases/kernel/controllers/cpuset/cpuset_lib/meminfo.h
rename to include/cpuset_meminfo.h
diff --git a/testcases/kernel/controllers/cpuset/cpuset_lib/Makefile b/libs/cpuset_lib/Makefile
similarity index 97%
rename from testcases/kernel/controllers/cpuset/cpuset_lib/Makefile
rename to libs/cpuset_lib/Makefile
index 1b6a40bea..87f454ee1 100644
--- a/testcases/kernel/controllers/cpuset/cpuset_lib/Makefile
+++ b/libs/cpuset_lib/Makefile
@@ -21,7 +21,7 @@
 # Cyril Hrubis, October 2009
 #
 
-top_srcdir 		?= ../../../../..
+top_srcdir 		?= ../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
diff --git a/testcases/kernel/controllers/cpuset/cpuset_lib/cpuinfo.c b/libs/cpuset_lib/cpuinfo.c
similarity index 99%
rename from testcases/kernel/controllers/cpuset/cpuset_lib/cpuinfo.c
rename to libs/cpuset_lib/cpuinfo.c
index 575a61bcd..0d4fedf1d 100644
--- a/testcases/kernel/controllers/cpuset/cpuset_lib/cpuinfo.c
+++ b/libs/cpuset_lib/cpuinfo.c
@@ -7,10 +7,10 @@
 #include <err.h>
 #include <errno.h>
 
-#include "bitmask.h"
+#include "cpuset_bitmask.h"
 #include "cpuset.h"
-#include "common.h"
-#include "cpuinfo.h"
+#include "cpuset_common.h"
+#include "cpuset_cpuinfo.h"
 
 #if HAVE_LINUX_MEMPOLICY_H
 
diff --git a/testcases/kernel/controllers/cpuset/cpuset_lib/libbitmask.c b/libs/cpuset_lib/libbitmask.c
similarity index 99%
rename from testcases/kernel/controllers/cpuset/cpuset_lib/libbitmask.c
rename to libs/cpuset_lib/libbitmask.c
index dbae375c6..41f4625ac 100644
--- a/testcases/kernel/controllers/cpuset/cpuset_lib/libbitmask.c
+++ b/libs/cpuset_lib/libbitmask.c
@@ -27,7 +27,7 @@
 #include <stdlib.h>
 #include <stdint.h>
 
-#include "bitmask.h"
+#include "cpuset_bitmask.h"
 #include "tst_minmax.h"
 
 struct bitmask {
diff --git a/testcases/kernel/controllers/cpuset/cpuset_lib/libcpuset.c b/libs/cpuset_lib/libcpuset.c
similarity index 99%
rename from testcases/kernel/controllers/cpuset/cpuset_lib/libcpuset.c
rename to libs/cpuset_lib/libcpuset.c
index 9a81c23eb..b1f2bedd0 100644
--- a/testcases/kernel/controllers/cpuset/cpuset_lib/libcpuset.c
+++ b/libs/cpuset_lib/libcpuset.c
@@ -43,9 +43,9 @@
 #include <utime.h>
 #include <sys/utsname.h>	/* for cpuset_would_crash_kernel() */
 
-#include "bitmask.h"
+#include "cpuset_bitmask.h"
 #include "cpuset.h"
-#include "common.h"
+#include "cpuset_common.h"
 #include "test.h"
 #include "lapi/syscalls.h"
 #include "config.h"
diff --git a/testcases/kernel/controllers/cpuset/cpuset_lib/meminfo.c b/libs/cpuset_lib/meminfo.c
similarity index 96%
rename from testcases/kernel/controllers/cpuset/cpuset_lib/meminfo.c
rename to libs/cpuset_lib/meminfo.c
index fa7762f02..44f64b0ea 100644
--- a/testcases/kernel/controllers/cpuset/cpuset_lib/meminfo.c
+++ b/libs/cpuset_lib/meminfo.c
@@ -1,10 +1,10 @@
 #include <stdio.h>
 #include <string.h>
 
-#include "common.h"
-#include "bitmask.h"
+#include "cpuset_common.h"
+#include "cpuset_bitmask.h"
 #include "cpuset.h"
-#include "meminfo.h"
+#include "cpuset_meminfo.h"
 
 #define LIST_PRESENT_MEM_FILE	"/sys/devices/system/node/possible"
 #define LIST_ONLINE_MEM_FILE	"/sys/devices/system/node/online"
diff --git a/testcases/kernel/controllers/cpuset/Makefile b/testcases/kernel/controllers/cpuset/Makefile
index 153cd2b20..401c785c6 100644
--- a/testcases/kernel/controllers/cpuset/Makefile
+++ b/testcases/kernel/controllers/cpuset/Makefile
@@ -25,21 +25,5 @@ top_srcdir		?= ../../../..
 include $(top_srcdir)/include/mk/env_pre.mk
 
 INSTALL_TARGETS		:= *.sh
-LIBDIR			:= cpuset_lib
-FILTER_OUT_DIRS		:= $(LIBDIR)
-LIB			:= $(LIBDIR)/libcpu_set.a
-
-$(LIBDIR):
-	mkdir -p "$@"
-
-$(LIB): $(LIBDIR)
-	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" all
-
-MAKE_DEPS		:= $(LIB)
-
-trunk-clean:: | lib-clean
-
-lib-clean:: $(LIBDIR)
-	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" clean
 
 include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/kernel/controllers/cpuset/Makefile.inc b/testcases/kernel/controllers/cpuset/Makefile.inc
index c03dd77d7..e023e9066 100644
--- a/testcases/kernel/controllers/cpuset/Makefile.inc
+++ b/testcases/kernel/controllers/cpuset/Makefile.inc
@@ -20,28 +20,28 @@
 # Ngie Cooper, July 2009
 #
 
-LIBCPUSET_DIR		:= ../cpuset_lib
-
-LIBCPUSET		:= $(LIBCPUSET_DIR)/libcpu_set.a
-
 LIBCONTROLLERS_DIR	:= ../../libcontrollers
 
 LIBCONTROLLERS		:= $(LIBCONTROLLERS_DIR)/libcontrollers.a
 
-$(LIBCPUSET_DIR) $(LIBCONTROLLERS_DIR): %:
+LIBCPUSET_DIR       := ../../../../../libs/cpuset_lib
+
+LIBCPUSET           := $(LIBCPUSET_DIR)/libcpu_set.a
+
+$(LIBCONTROLLERS_DIR):
 	mkdir -p "$@"
 
 $(LIBCONTROLLERS): $(LIBCONTROLLERS_DIR)
 	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" all
 
-$(LIBCPUSET): $(LIBCPUSET_DIR) | $(LIBCONTROLLERS)
-	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" all
+$(LIBCPUSET):
+	$(MAKE) -C $(LIBCPUSET_DIR) -f "$(abs_srcdir)/$(LIBCPUSET_DIR)/Makefile" all
 
-MAKE_DEPS		:= $(LIBCONTROLLERS) $(LIBCPUSET)
+MAKE_DEPS       := $(LIBCONTROLLERS) $(LIBCPUSET)
 
-LDFLAGS			+= -L$(abs_builddir)/$(LIBCPUSET_DIR) -L$(abs_builddir)/$(LIBCONTROLLERS_DIR)
+LDFLAGS			+= -L$(abs_builddir)/$(LIBCONTROLLERS_DIR)
 
-LDLIBS			:= -lcpu_set -lcontrollers -lltp $(LDLIBS)
+LDLIBS			:= -lcontrollers -lltp $(LDLIBS)
 
 INSTALL_TARGETS		?= *.sh
 
diff --git a/testcases/kernel/controllers/cpuset/cpuset_base_ops_test/Makefile b/testcases/kernel/controllers/cpuset/cpuset_base_ops_test/Makefile
index 6d7d5092e..c1bc711e4 100644
--- a/testcases/kernel/controllers/cpuset/cpuset_base_ops_test/Makefile
+++ b/testcases/kernel/controllers/cpuset/cpuset_base_ops_test/Makefile
@@ -22,9 +22,12 @@
 
 top_srcdir              ?= ../../../../..
 
+LTPLIBS = cpuset_lib
+
 include $(top_srcdir)/include/mk/testcases.mk
 include $(abs_srcdir)/../Makefile.inc
 
+LTPLDLIBS = -lcpu_set
 MAKE_TARGETS		:=
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/controllers/cpuset/cpuset_exclusive_test/Makefile b/testcases/kernel/controllers/cpuset/cpuset_exclusive_test/Makefile
index 265562288..d0b5157c1 100644
--- a/testcases/kernel/controllers/cpuset/cpuset_exclusive_test/Makefile
+++ b/testcases/kernel/controllers/cpuset/cpuset_exclusive_test/Makefile
@@ -22,9 +22,12 @@
 
 top_srcdir              ?= ../../../../..
 
+LTPLIBS = cpuset_lib
+
 include $(top_srcdir)/include/mk/testcases.mk
 include $(abs_srcdir)/../Makefile.inc
 
+LTPLDLIBS = -lcpu_set
 MAKE_TARGETS		:=
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/controllers/cpuset/cpuset_hierarchy_test/Makefile b/testcases/kernel/controllers/cpuset/cpuset_hierarchy_test/Makefile
index 0c60b2025..87e1275f9 100644
--- a/testcases/kernel/controllers/cpuset/cpuset_hierarchy_test/Makefile
+++ b/testcases/kernel/controllers/cpuset/cpuset_hierarchy_test/Makefile
@@ -22,9 +22,12 @@
 
 top_srcdir              ?= ../../../../..
 
+LTPLIBS = cpuset_lib
+
 include $(top_srcdir)/include/mk/testcases.mk
 include $(abs_srcdir)/../Makefile.inc
 
+LTPLDLIBS           = -lcpu_set
 MAKE_TARGETS		:=
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/Makefile b/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/Makefile
index e5c984b84..81b04af49 100644
--- a/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/Makefile
+++ b/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/Makefile
@@ -22,9 +22,12 @@
 
 top_srcdir              ?= ../../../../..
 
+LTPLIBS = cpuset_lib
+
 include $(top_srcdir)/include/mk/testcases.mk
 include $(abs_srcdir)/../Makefile.inc
 
+LTPLDLIBS       = -lcpu_set
 LDLIBS			+= -lpthread -lrt
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/cpuset_list_compute.c b/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/cpuset_list_compute.c
index 1c66b863a..9811a9fc0 100644
--- a/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/cpuset_list_compute.c
+++ b/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/cpuset_list_compute.c
@@ -8,8 +8,8 @@
 #include <pwd.h>
 #include <err.h>
 
-#include "../cpuset_lib/common.h"
-#include "../cpuset_lib/bitmask.h"
+#include "cpuset_common.h"
+#include "cpuset_bitmask.h"
 
 #define MAX_STRING_SIZE	400
 #define MAX_NBITS	1024
diff --git a/testcases/kernel/controllers/cpuset/cpuset_inherit_test/Makefile b/testcases/kernel/controllers/cpuset/cpuset_inherit_test/Makefile
index d2a4528bb..0e46c6f26 100644
--- a/testcases/kernel/controllers/cpuset/cpuset_inherit_test/Makefile
+++ b/testcases/kernel/controllers/cpuset/cpuset_inherit_test/Makefile
@@ -22,9 +22,12 @@
 
 top_srcdir              ?= ../../../../..
 
+LTPLIBS = cpuset_lib
+
 include $(top_srcdir)/include/mk/testcases.mk
 include $(abs_srcdir)/../Makefile.inc
 
+LTPLDLIBS = -lcpu_set
 MAKE_TARGETS		:=
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/Makefile b/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/Makefile
index 86b3f273c..3cec1539c 100644
--- a/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/Makefile
+++ b/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/Makefile
@@ -22,9 +22,12 @@
 
 top_srcdir              ?= ../../../../..
 
+LTPLIBS = cpuset_lib
+
 include $(top_srcdir)/include/mk/testcases.mk
 include $(abs_srcdir)/../Makefile.inc
 
+LTPLDLIBS       = -lcpu_set
 LDLIBS			+= -lm
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_cpu_hog.c b/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_cpu_hog.c
index 125ebd1c7..7a77e03bf 100644
--- a/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_cpu_hog.c
+++ b/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_cpu_hog.c
@@ -39,9 +39,9 @@ int TST_TOTAL = 1;
 
 #if HAVE_LINUX_MEMPOLICY_H
 
-#include "../cpuset_lib/common.h"
-#include "../cpuset_lib/bitmask.h"
-#include "../cpuset_lib/cpuset.h"
+#include "cpuset_common.h"
+#include "cpuset_bitmask.h"
+#include "cpuset.h"
 
 #define MAX_NPROCS	1000
 #define USAGE	("Usage: %s [-p nprocs] [-h]\n"		\
diff --git a/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_sched_domains_check.c b/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_sched_domains_check.c
index 1151b9654..fcc4f8523 100644
--- a/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_sched_domains_check.c
+++ b/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_sched_domains_check.c
@@ -31,10 +31,10 @@
 
 #include "test.h"
 
-#include "../cpuset_lib/bitmask.h"
-#include "../cpuset_lib/cpuset.h"
-#include "../cpuset_lib/common.h"
-#include "../cpuset_lib/cpuinfo.h"
+#include "cpuset_bitmask.h"
+#include "cpuset.h"
+#include "cpuset_common.h"
+#include "cpuset_cpuinfo.h"
 
 char *TCID = "cpuset_check_domains";
 int TST_TOTAL = 1;
diff --git a/testcases/kernel/controllers/cpuset/cpuset_memory_pressure_test/Makefile b/testcases/kernel/controllers/cpuset/cpuset_memory_pressure_test/Makefile
index fe9cc18b5..2c86422e9 100644
--- a/testcases/kernel/controllers/cpuset/cpuset_memory_pressure_test/Makefile
+++ b/testcases/kernel/controllers/cpuset/cpuset_memory_pressure_test/Makefile
@@ -22,6 +22,11 @@
 
 top_srcdir              ?= ../../../../..
 
+LTPLIBS = cpuset_lib
+
 include $(top_srcdir)/include/mk/testcases.mk
 include $(abs_srcdir)/../Makefile.inc
+
+LTPLDLIBS = -lcpu_set
+
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/Makefile b/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/Makefile
index b3c76f0de..2d92716f3 100644
--- a/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/Makefile
+++ b/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/Makefile
@@ -22,6 +22,11 @@
 
 top_srcdir              ?= ../../../../..
 
+LTPLIBS = cpuset_lib
+
 include $(top_srcdir)/include/mk/testcases.mk
 include $(abs_srcdir)/../Makefile.inc
+
+LTPLDLIBS = -lcpu_set
+
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_mem_hog.c b/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_mem_hog.c
index 56e039eee..846b65770 100644
--- a/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_mem_hog.c
+++ b/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_mem_hog.c
@@ -32,7 +32,7 @@
 #include <sys/stat.h>
 #include <fcntl.h>
 
-#include "../cpuset_lib/common.h"
+#include "cpuset_common.h"
 
 #define BUFFER_SIZE 100
 
diff --git a/testcases/kernel/controllers/cpuset/cpuset_memory_test/Makefile b/testcases/kernel/controllers/cpuset/cpuset_memory_test/Makefile
index d427026a2..33def486e 100644
--- a/testcases/kernel/controllers/cpuset/cpuset_memory_test/Makefile
+++ b/testcases/kernel/controllers/cpuset/cpuset_memory_test/Makefile
@@ -22,9 +22,12 @@
 
 top_srcdir              ?= ../../../../..
 
+LTPLIBS = cpuset_lib
+
 include $(top_srcdir)/include/mk/testcases.mk
 include $(abs_srcdir)/../Makefile.inc
 
+LTPLDLIBS   = -lcpu_set
 LDLIBS		+= -lpthread
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_test.c b/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_test.c
index 9912d8d6a..9a5debe6b 100644
--- a/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_test.c
+++ b/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_test.c
@@ -42,7 +42,7 @@ int TST_TOTAL = 1;
 
 #if HAVE_LINUX_MEMPOLICY_H
 
-#include "../cpuset_lib/cpuset.h"
+#include "cpuset.h"
 
 static int fd;
 
diff --git a/testcases/kernel/controllers/cpuset/cpuset_syscall_test/Makefile b/testcases/kernel/controllers/cpuset/cpuset_syscall_test/Makefile
index 3f5e591f9..5d3b34913 100644
--- a/testcases/kernel/controllers/cpuset/cpuset_syscall_test/Makefile
+++ b/testcases/kernel/controllers/cpuset/cpuset_syscall_test/Makefile
@@ -22,9 +22,12 @@
 
 top_srcdir              ?= ../../../../..
 
+LTPLIBS = cpuset_lib
+
 include $(top_srcdir)/include/mk/testcases.mk
 include $(abs_srcdir)/../Makefile.inc
 
+LTPLDLIBS = -lcpu_set
 LDLIBS                  += $(NUMA_LIBS)
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_test.c b/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_test.c
index 16a01aa03..e1947bf4d 100644
--- a/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_test.c
+++ b/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_test.c
@@ -48,8 +48,8 @@ int TST_TOTAL = 1;
 #ifdef HAVE_NUMA_V2
 #include <numaif.h>
 
-#include "../cpuset_lib/cpuset.h"
-#include "../cpuset_lib/bitmask.h"
+#include "cpuset.h"
+#include "cpuset_bitmask.h"
 
 static unsigned long mask;
 static int test = -1;
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
