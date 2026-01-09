Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 065C7D232D2
	for <ltp@archiver.kernel.org>; Fri,  9 Jan 2026 02:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1767926392; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=DMKzlQ3P6pf/Y7UFp4HEYp9dpwOBmpjVPQOPaiQ6Y8g=;
 b=RwzZb8iTB28imeDA7nHVeu+pKz8gvGbKFMZ1jVPNWGDyErObeKdTq2GIEhEGC6u9k961J
 WBaHe61+X6ETh2NbJPsV6toDJKgVuJPSG7Y8EaQ+GDdnjgJXVCj2i4/oQFXbDyO9uHThz0+
 LRVhb4iExy0s26kE1ZBm1UXOhCFxySk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 327943C67C0
	for <ltp@archiver.kernel.org>; Fri,  9 Jan 2026 03:39:52 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 82C573C65DF
 for <ltp@lists.linux.it>; Fri,  9 Jan 2026 03:39:26 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id AB9AC2009E1
 for <ltp@lists.linux.it>; Fri,  9 Jan 2026 03:39:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767926363;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=DcKXcfNkUEomBnk7IdDjfhp6no36N3qn6OEqXVdYLic=;
 b=IQwFH/OBbSIPCHNX6lMxzmCfSGuBUq8kk8zLZFPB+Neujp7zaYhvdcU7SEfoiqZxq7CpkT
 JM9thma8cU1+iVqGbc6jvvrKxQVJge5ldodHOPq/X7JdABmlovHi3PCDWlLeTC3OKoBm2z
 vdZDyrYx8h8Ui2VvR8EFlRPmEyfvT3E=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-1-lTpqi53uOyu4-A38FdC36g-1; Thu,
 08 Jan 2026 21:39:20 -0500
X-MC-Unique: lTpqi53uOyu4-A38FdC36g-1
X-Mimecast-MFC-AGG-ID: lTpqi53uOyu4-A38FdC36g_1767926359
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1FCEC1956048; Fri,  9 Jan 2026 02:39:19 +0000 (UTC)
Received: from fedora-laptop-x1.redhat.com (unknown [10.72.116.22])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4512A18001D5; Fri,  9 Jan 2026 02:39:16 +0000 (UTC)
To: ltp@lists.linux.it
Date: Fri,  9 Jan 2026 10:39:14 +0800
Message-ID: <20260109023914.45555-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: S7la-KkEa8TU4Onpj11OGh7a60qe5vU149XDbf6QHus_1767926359
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] libs: adopt lib* prefix instead of tst_* for libs/
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Cc: Pradeep Susarla <pradeep.susarla@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The intention of moving these headers under include/ was to expose them as
global interfaces, but using the tst_* prefix there is misleading. Headers
corresponding to ltp/libs* code should follow the libs* naming to distinguish
them from the core tst_* API.

Rename the following headers/sources to use a lib* prefix and update all
includes accordingly:

  include/ipcmsg.h  -> include/libipcmsg.h
  include/ipcsem.h  -> include/libipcsem.h
  include/tst_numa.h -> include/libnuma.h
  libs/numa/tst_numa.c -> libs/numa/libnuma.c
  include/tst_uinput.h -> include/libuinput.h
  libs/uinput/tst_uinput.c -> libs/uinput/libuinput.c
  include/parse_vdso.h -> include/libparse_vdso.h
  libs/vdso/parse_vdso.c -> libs/vdso/libparse_vdso.c
  libs/sigwait/sigwait.c -> libs/sigwait/libsigwait.c

Also adjust include guards to match the new header names.

No functional changes intended.

==== NOTE ====
From Petr Vorel:

  "Although lib/ vs libs/ is a bit strange, kept these libraries separate
  (i.e. no move libs/*/ into lib/), because these libraries are built only when
  they are needed. I.e. for testing random test one does not need to wait for
  building these additional libraries (although building them does not take long,
  building LTP main library and tests takes much longer)."

Signed-off-by: Li Wang <liwang@redhat.com>
Cc: Pradeep Susarla <pradeep.susarla@gmail.com>
---
 include/{ipcmsg.h => libipcmsg.h}                         | 8 ++++----
 include/{ipcsem.h => libipcsem.h}                         | 6 +++---
 include/{tst_numa.h => libnuma.h}                         | 6 +++---
 include/{parse_vdso.h => libparse_vdso.h}                 | 6 +++---
 include/libsigwait.h                                      | 6 +++---
 include/libswap.h                                         | 4 ++--
 include/{tst_uinput.h => libuinput.h}                     | 6 +++---
 include/tst_uid.h                                         | 6 +++---
 include/ujson.h                                           | 6 +++---
 include/ujson_common.h                                    | 6 +++---
 include/ujson_reader.h                                    | 6 +++---
 include/ujson_utf.h                                       | 6 +++---
 libs/ipc/libipc.c                                         | 4 ++--
 libs/numa/{tst_numa.c => libnuma.c}                       | 2 +-
 libs/sigwait/{sigwait.c => libsigwait.c}                  | 0
 libs/uinput/{tst_uinput.c => libuinput.c}                 | 2 +-
 libs/vdso/{parse_vdso.c => libparse_vdso.c}               | 0
 libs/vdso/vdso_helpers.c                                  | 2 +-
 testcases/kernel/input/input_common.h                     | 2 +-
 testcases/kernel/mem/cpuset/cpuset02.c                    | 2 +-
 testcases/kernel/mem/ksm/ksm06.c                          | 2 +-
 testcases/kernel/syscalls/clock_gettime/clock_gettime04.c | 2 +-
 testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c | 2 +-
 testcases/kernel/syscalls/get_mempolicy/get_mempolicy02.c | 2 +-
 testcases/kernel/syscalls/ipc/semctl/semctl06.c           | 2 +-
 testcases/kernel/syscalls/mbind/mbind01.c                 | 2 +-
 testcases/kernel/syscalls/mbind/mbind02.c                 | 2 +-
 testcases/kernel/syscalls/mbind/mbind03.c                 | 2 +-
 testcases/kernel/syscalls/mbind/mbind04.c                 | 2 +-
 testcases/kernel/syscalls/set_mempolicy/set_mempolicy01.c | 2 +-
 testcases/kernel/syscalls/set_mempolicy/set_mempolicy02.c | 2 +-
 testcases/kernel/syscalls/set_mempolicy/set_mempolicy03.c | 2 +-
 testcases/kernel/syscalls/set_mempolicy/set_mempolicy04.c | 2 +-
 testcases/kernel/uevents/uevent03.c                       | 2 +-
 34 files changed, 57 insertions(+), 57 deletions(-)
 rename include/{ipcmsg.h => libipcmsg.h} (93%)
 rename include/{ipcsem.h => libipcsem.h} (95%)
 rename include/{tst_numa.h => libnuma.h} (97%)
 rename include/{parse_vdso.h => libparse_vdso.h} (93%)
 rename include/{tst_uinput.h => libuinput.h} (93%)
 rename libs/numa/{tst_numa.c => libnuma.c} (99%)
 rename libs/sigwait/{sigwait.c => libsigwait.c} (100%)
 rename libs/uinput/{tst_uinput.c => libuinput.c} (99%)
 rename libs/vdso/{parse_vdso.c => libparse_vdso.c} (100%)

diff --git a/include/ipcmsg.h b/include/libipcmsg.h
similarity index 93%
rename from include/ipcmsg.h
rename to include/libipcmsg.h
index 3b3fa32c0..3cca7386b 100644
--- a/include/ipcmsg.h
+++ b/include/libipcmsg.h
@@ -18,11 +18,11 @@
  */
 
 /*
- * ipcmsg.h - common definitions for the IPC message tests.
+ * libipcmsg.h - common definitions for the IPC message tests.
  */
 
-#ifndef __IPCMSG_H
-#define __IPCMSG_H	1
+#ifndef LIBIPCMSG_H__
+#define LIBIPCMSG_H__	1
 
 #include <errno.h>
 #include <sys/ipc.h>
@@ -63,4 +63,4 @@ int getuserid(char *);
 int get_max_msgqueues(void);
 int get_used_msgqueues(void);
 
-#endif /* ipcmsg.h */
+#endif /* libipcmsg.h */
diff --git a/include/ipcsem.h b/include/libipcsem.h
similarity index 95%
rename from include/ipcsem.h
rename to include/libipcsem.h
index 09a0b3cbe..fff98f7ab 100644
--- a/include/ipcsem.h
+++ b/include/libipcsem.h
@@ -21,8 +21,8 @@
  * ipcsem.h - common definitions for the IPC semaphore tests
  */
 
-#ifndef __IPCSEM_H
-#define __IPCSEM_H
+#ifndef LIBIPCSEM_H__
+#define LIBIPCSEM_H__
 
 #include <errno.h>
 #include <sys/ipc.h>
@@ -52,4 +52,4 @@ void rm_sema(int sem_id);
 int getipckey();
 int getuserid(char *);
 
-#endif /* ipcsem.h */
+#endif /* libipcsem.h */
diff --git a/include/tst_numa.h b/include/libnuma.h
similarity index 97%
rename from include/tst_numa.h
rename to include/libnuma.h
index a1f961630..2a3b99dac 100644
--- a/include/tst_numa.h
+++ b/include/libnuma.h
@@ -2,8 +2,8 @@
  * Copyright (c) 2018 Cyril Hrubis <chrubis@suse.cz>
  */
 
-#ifndef TST_NUMA_H__
-#define TST_NUMA_H__
+#ifndef LIBNUMA_H__
+#define LIBNUMA_H__
 
 #include <string.h>
 
@@ -119,4 +119,4 @@ enum tst_numa_types {
  */
 struct tst_nodemap *tst_get_nodemap(int type, size_t min_mem_kb);
 
-#endif /* TST_NUMA_H__ */
+#endif /* LIBNUMA_H__ */
diff --git a/include/parse_vdso.h b/include/libparse_vdso.h
similarity index 93%
rename from include/parse_vdso.h
rename to include/libparse_vdso.h
index 5212fc659..2170c553c 100644
--- a/include/parse_vdso.h
+++ b/include/libparse_vdso.h
@@ -4,8 +4,8 @@
  * Author: Viresh Kumar <viresh.kumar@linaro.org>
  */
 
-#ifndef PARSE_VDSO_H__
-#define PARSE_VDSO_H__
+#ifndef LIBPARSE_VDSO_H__
+#define LIBPARSE_VDSO_H__
 
 #include <stdint.h>
 
@@ -38,4 +38,4 @@ extern void *vdso_sym(const char *version, const char *name);
 typedef int (*gettime_t)(clockid_t clk_id, void *ts);
 void find_clock_gettime_vdso(gettime_t *ptr_vdso_gettime,
 			     gettime_t *ptr_vdso_gettime64);
-#endif /* PARSE_VDSO_H__ */
+#endif /* LIBPARSE_VDSO_H__ */
diff --git a/include/libsigwait.h b/include/libsigwait.h
index 2fca578b1..3dcd7eb85 100644
--- a/include/libsigwait.h
+++ b/include/libsigwait.h
@@ -4,8 +4,8 @@
  * Author: Viresh Kumar <viresh.kumar@linaro.org>
  */
 
-#ifndef SIGWAIT_H__
-#define SIGWAIT_H__
+#ifndef LIBSIGWAIT_H__
+#define LIBSIGWAIT_H__
 
 #include "tst_test.h"
 #include "tst_timer.h"
@@ -41,4 +41,4 @@ void test_bad_address2(swi_func sigwaitinfo, int signo LTP_ATTRIBUTE_UNUSED,
 void test_bad_address3(swi_func sigwaitinfo, int signo LTP_ATTRIBUTE_UNUSED,
 		       enum tst_ts_type type LTP_ATTRIBUTE_UNUSED);
 void sigwait_setup(void);
-#endif /* SIGWAIT_H__ */
+#endif /* LIBSIGWAIT_H__ */
diff --git a/include/libswap.h b/include/libswap.h
index b22b992ee..bf0fe2356 100644
--- a/include/libswap.h
+++ b/include/libswap.h
@@ -11,8 +11,8 @@
  * Contains common content for all swapon/swapoff tests.
  */
 
-#ifndef __LIBSWAP_H__
-#define __LIBSWAP_H__
+#ifndef LIBSWAP_H__
+#define LIBSWAP_H__
 
 enum swapfile_method {
     SWAPFILE_BY_SIZE,
diff --git a/include/tst_uinput.h b/include/libuinput.h
similarity index 93%
rename from include/tst_uinput.h
rename to include/libuinput.h
index cf351cdfb..f21268339 100644
--- a/include/tst_uinput.h
+++ b/include/libuinput.h
@@ -3,8 +3,8 @@
  * Copyright (c) 2019 Cyril Hrubis <chrubis@suse.cz>
  */
 
-#ifndef TST_UINPUT_H__
-#define TST_UINPUT_H__
+#ifndef LIBUINPUT_H__
+#define LIBUINPUT_H__
 
 /**
  * Tries to open the uinput device.
@@ -44,4 +44,4 @@ void setup_mouse_events(int fd);
  */
 void destroy_input_device(int fd);
 
-#endif	/* TST_UINPUT_H__ */
+#endif	/* LIBUINPUT_H__ */
diff --git a/include/tst_uid.h b/include/tst_uid.h
index e604effce..2237ddcbf 100644
--- a/include/tst_uid.h
+++ b/include/tst_uid.h
@@ -2,8 +2,8 @@
  * Copyright (c) 2021 Linux Test Project
  */
 
-#ifndef TST_UID_H_
-#define TST_UID_H_
+#ifndef TST_UID_H__
+#define TST_UID_H__
 
 #include <sys/types.h>
 
@@ -37,4 +37,4 @@ int tst_check_resgid_(const char *file, const int lineno, const char *callstr,
 #define tst_check_resgid(cstr, rgid, egid, sgid) \
 	tst_check_resgid_(__FILE__, __LINE__, (cstr), (rgid), (egid), (sgid))
 
-#endif /* TST_UID_H_ */
+#endif /* TST_UID_H__ */
diff --git a/include/ujson.h b/include/ujson.h
index 8faeb18f0..1a4bb6bd9 100644
--- a/include/ujson.h
+++ b/include/ujson.h
@@ -3,11 +3,11 @@
  * Copyright (C) 2021-2024 Cyril Hrubis <metan@ucw.cz>
  */
 
-#ifndef UJSON_H
-#define UJSON_H
+#ifndef UJSON_H__
+#define UJSON_H__
 
 #include <ujson_common.h>
 #include <ujson_reader.h>
 #include <ujson_writer.h>
 
-#endif /* UJSON_H */
+#endif /* UJSON_H__ */
diff --git a/include/ujson_common.h b/include/ujson_common.h
index ed31c090d..11382c4fb 100644
--- a/include/ujson_common.h
+++ b/include/ujson_common.h
@@ -8,8 +8,8 @@
  * @brief Common JSON reader/writer definitions.
  */
 
-#ifndef UJSON_COMMON_H
-#define UJSON_COMMON_H
+#ifndef UJSON_COMMON_H__
+#define UJSON_COMMON_H__
 
 /** @brief Maximal error message length. */
 #define UJSON_ERR_MAX 128
@@ -66,4 +66,4 @@ typedef struct ujson_val ujson_val;
 /** @brief An array size macro. */
 #define UJSON_ARRAY_SIZE(array) (sizeof(array) / sizeof(*array))
 
-#endif /* UJSON_COMMON_H */
+#endif /* UJSON_COMMON_H__ */
diff --git a/include/ujson_reader.h b/include/ujson_reader.h
index 273fe624a..8608b6c81 100644
--- a/include/ujson_reader.h
+++ b/include/ujson_reader.h
@@ -14,8 +14,8 @@
  * if error has happened at the end of the sequence.
  */
 
-#ifndef UJSON_READER_H
-#define UJSON_READER_H
+#ifndef UJSON_READER_H__
+#define UJSON_READER_H__
 
 #include <stdio.h>
 #include <ujson_common.h>
@@ -540,4 +540,4 @@ static inline int ujson_reader_consumed(ujson_reader *self)
 	return self->off >= self->len;
 }
 
-#endif /* UJSON_H */
+#endif /* UJSON_H__ */
diff --git a/include/ujson_utf.h b/include/ujson_utf.h
index f939fbe8c..313213d8e 100644
--- a/include/ujson_utf.h
+++ b/include/ujson_utf.h
@@ -8,8 +8,8 @@
  * @brief Unicode helper macros and functions.
  */
 
-#ifndef UJSON_UTF_H
-#define UJSON_UTF_H
+#ifndef UJSON_UTF_H__
+#define UJSON_UTF_H__
 
 #include <stdint.h>
 #include <stddef.h>
@@ -165,4 +165,4 @@ static inline int ujson_to_utf8(uint32_t unicode, char *buf)
 	return 4;
 }
 
-#endif /* UJSON_UTF_H */
+#endif /* UJSON_UTF_H__ */
diff --git a/libs/ipc/libipc.c b/libs/ipc/libipc.c
index c2ecbf02d..7ccb3eb68 100644
--- a/libs/ipc/libipc.c
+++ b/libs/ipc/libipc.c
@@ -35,8 +35,8 @@
  */
 
 #define LIBIPC
-#include "ipcmsg.h"
-#include "ipcsem.h"
+#include "libipcmsg.h"
+#include "libipcsem.h"
 
 #include <pwd.h>
 #include <sys/ipc.h>
diff --git a/libs/numa/tst_numa.c b/libs/numa/libnuma.c
similarity index 99%
rename from libs/numa/tst_numa.c
rename to libs/numa/libnuma.c
index c3297013b..802b45dd4 100644
--- a/libs/numa/tst_numa.c
+++ b/libs/numa/libnuma.c
@@ -14,7 +14,7 @@
 
 #define TST_NO_DEFAULT_MAIN
 #include "tst_test.h"
-#include "tst_numa.h"
+#include "libnuma.h"
 #include "lapi/numaif.h"
 
 void tst_nodemap_print_counters(struct tst_nodemap *nodes)
diff --git a/libs/sigwait/sigwait.c b/libs/sigwait/libsigwait.c
similarity index 100%
rename from libs/sigwait/sigwait.c
rename to libs/sigwait/libsigwait.c
diff --git a/libs/uinput/tst_uinput.c b/libs/uinput/libuinput.c
similarity index 99%
rename from libs/uinput/tst_uinput.c
rename to libs/uinput/libuinput.c
index 16e689153..00f3d3498 100644
--- a/libs/uinput/tst_uinput.c
+++ b/libs/uinput/libuinput.c
@@ -12,7 +12,7 @@
 #define TST_NO_DEFAULT_MAIN
 #include "tst_test.h"
 
-#include "tst_uinput.h"
+#include "libuinput.h"
 #include "tst_safe_stdio.h"
 
 #define VIRTUAL_DEVICE "virtual-device-ltp"
diff --git a/libs/vdso/parse_vdso.c b/libs/vdso/libparse_vdso.c
similarity index 100%
rename from libs/vdso/parse_vdso.c
rename to libs/vdso/libparse_vdso.c
diff --git a/libs/vdso/vdso_helpers.c b/libs/vdso/vdso_helpers.c
index 208c12f65..6f7a2fd9d 100644
--- a/libs/vdso/vdso_helpers.c
+++ b/libs/vdso/vdso_helpers.c
@@ -7,7 +7,7 @@
 #define TST_NO_DEFAULT_MAIN
 #include "tst_test.h"
 
-#include "parse_vdso.h"
+#include "libparse_vdso.h"
 #include "config.h"
 
 #ifdef HAVE_GETAUXVAL
diff --git a/testcases/kernel/input/input_common.h b/testcases/kernel/input/input_common.h
index 5b1755771..9caff2b77 100644
--- a/testcases/kernel/input/input_common.h
+++ b/testcases/kernel/input/input_common.h
@@ -10,7 +10,7 @@
 #include <poll.h>
 
 #include "tst_test.h"
-#include "tst_uinput.h"
+#include "libuinput.h"
 
 static inline int open_event_device(void)
 {
diff --git a/testcases/kernel/mem/cpuset/cpuset02.c b/testcases/kernel/mem/cpuset/cpuset02.c
index ccfddd6a2..3bc20c6c2 100644
--- a/testcases/kernel/mem/cpuset/cpuset02.c
+++ b/testcases/kernel/mem/cpuset/cpuset02.c
@@ -18,7 +18,7 @@
 
 #ifdef HAVE_NUMA_V2
 #include <numaif.h>
-#include "tst_numa.h"
+#include "libnuma.h"
 
 #define MNTPOINT "hugetlbfs/"
 #define HUGE_PAGE_FILE MNTPOINT "hugepagefile"
diff --git a/testcases/kernel/mem/ksm/ksm06.c b/testcases/kernel/mem/ksm/ksm06.c
index a8e73275d..41102a577 100644
--- a/testcases/kernel/mem/ksm/ksm06.c
+++ b/testcases/kernel/mem/ksm/ksm06.c
@@ -32,7 +32,7 @@
 #include <limits.h>
 
 #include "tst_test.h"
-#include "tst_numa.h"
+#include "libnuma.h"
 #include "ksm_helper.h"
 #include "ksm_test.h"
 
diff --git a/testcases/kernel/syscalls/clock_gettime/clock_gettime04.c b/testcases/kernel/syscalls/clock_gettime/clock_gettime04.c
index 4f262da00..08d1b2d43 100644
--- a/testcases/kernel/syscalls/clock_gettime/clock_gettime04.c
+++ b/testcases/kernel/syscalls/clock_gettime/clock_gettime04.c
@@ -13,7 +13,7 @@
  */
 
 #include "config.h"
-#include "parse_vdso.h"
+#include "libparse_vdso.h"
 #include "time64_variants.h"
 #include "tst_timer.h"
 #include "tst_safe_clocks.h"
diff --git a/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c b/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
index 3c854d109..9b7f1eb09 100644
--- a/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
+++ b/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
@@ -22,7 +22,7 @@
 #include <numa.h>
 #include <numaif.h>
 #include <errno.h>
-#include "tst_numa.h"
+#include "libnuma.h"
 
 #define MEM_LENGTH	(4 * 1024 * 1024)
 #define PAGES_ALLOCATED 16u
diff --git a/testcases/kernel/syscalls/get_mempolicy/get_mempolicy02.c b/testcases/kernel/syscalls/get_mempolicy/get_mempolicy02.c
index 79ff5d94f..dad1d8b64 100644
--- a/testcases/kernel/syscalls/get_mempolicy/get_mempolicy02.c
+++ b/testcases/kernel/syscalls/get_mempolicy/get_mempolicy02.c
@@ -22,7 +22,7 @@
 #include <numa.h>
 #include <numaif.h>
 #include <errno.h>
-#include "tst_numa.h"
+#include "libnuma.h"
 
 #define PAGES_ALLOCATED 16u
 
diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl06.c b/testcases/kernel/syscalls/ipc/semctl/semctl06.c
index b8734c2fa..2c2c72fd0 100644
--- a/testcases/kernel/syscalls/ipc/semctl/semctl06.c
+++ b/testcases/kernel/syscalls/ipc/semctl/semctl06.c
@@ -53,7 +53,7 @@
 #include <signal.h>
 #include "test.h"
 #include <sys/wait.h>
-#include "ipcsem.h"
+#include "libipcsem.h"
 
 int local_flag = 1;
 
diff --git a/testcases/kernel/syscalls/mbind/mbind01.c b/testcases/kernel/syscalls/mbind/mbind01.c
index 4b8d168cd..d6610630f 100644
--- a/testcases/kernel/syscalls/mbind/mbind01.c
+++ b/testcases/kernel/syscalls/mbind/mbind01.c
@@ -17,7 +17,7 @@
 #include "config.h"
 #include "numa_helper.h"
 #include "tst_test.h"
-#include "tst_numa.h"
+#include "libnuma.h"
 #include "lapi/numaif.h"
 
 #ifdef HAVE_NUMA_V2
diff --git a/testcases/kernel/syscalls/mbind/mbind02.c b/testcases/kernel/syscalls/mbind/mbind02.c
index cd6a03226..06b0a564d 100644
--- a/testcases/kernel/syscalls/mbind/mbind02.c
+++ b/testcases/kernel/syscalls/mbind/mbind02.c
@@ -21,7 +21,7 @@
 # include <numaif.h>
 #endif
 #include "tst_test.h"
-#include "tst_numa.h"
+#include "libnuma.h"
 
 #ifdef HAVE_NUMA_V2
 
diff --git a/testcases/kernel/syscalls/mbind/mbind03.c b/testcases/kernel/syscalls/mbind/mbind03.c
index 3d477c9cb..8e04b6802 100644
--- a/testcases/kernel/syscalls/mbind/mbind03.c
+++ b/testcases/kernel/syscalls/mbind/mbind03.c
@@ -18,7 +18,7 @@
 # include "mbind.h"
 #endif
 #include "tst_test.h"
-#include "tst_numa.h"
+#include "libnuma.h"
 
 #ifdef HAVE_NUMA_V2
 
diff --git a/testcases/kernel/syscalls/mbind/mbind04.c b/testcases/kernel/syscalls/mbind/mbind04.c
index 50028835f..0fd6b94c3 100644
--- a/testcases/kernel/syscalls/mbind/mbind04.c
+++ b/testcases/kernel/syscalls/mbind/mbind04.c
@@ -18,7 +18,7 @@
 # include "mbind.h"
 #endif
 #include "tst_test.h"
-#include "tst_numa.h"
+#include "libnuma.h"
 
 #ifdef HAVE_NUMA_V2
 
diff --git a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy01.c b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy01.c
index 39e7156d0..9c038131f 100644
--- a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy01.c
+++ b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy01.c
@@ -17,7 +17,7 @@
 # include <numaif.h>
 #endif
 #include "tst_test.h"
-#include "tst_numa.h"
+#include "libnuma.h"
 
 #ifdef HAVE_NUMA_V2
 
diff --git a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy02.c b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy02.c
index 3db9c2009..19443da61 100644
--- a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy02.c
+++ b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy02.c
@@ -18,7 +18,7 @@
 # include <numaif.h>
 #endif
 #include "tst_test.h"
-#include "tst_numa.h"
+#include "libnuma.h"
 
 #ifdef HAVE_NUMA_V2
 
diff --git a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy03.c b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy03.c
index 5cfcda6d8..578ba2513 100644
--- a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy03.c
+++ b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy03.c
@@ -15,7 +15,7 @@
 # include <numa.h>
 #endif
 #include "tst_test.h"
-#include "tst_numa.h"
+#include "libnuma.h"
 
 #define MNTPOINT "mntpoint"
 #define PAGES_ALLOCATED 16u
diff --git a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy04.c b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy04.c
index 2a1d2e1b9..2d83453f0 100644
--- a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy04.c
+++ b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy04.c
@@ -26,7 +26,7 @@
 # include <numaif.h>
 #endif
 #include "tst_test.h"
-#include "tst_numa.h"
+#include "libnuma.h"
 
 #define MNTPOINT "mntpoint"
 #define FILES 10
diff --git a/testcases/kernel/uevents/uevent03.c b/testcases/kernel/uevents/uevent03.c
index 126c924f1..aa2f9752a 100644
--- a/testcases/kernel/uevents/uevent03.c
+++ b/testcases/kernel/uevents/uevent03.c
@@ -18,7 +18,7 @@
 #include <sys/sysmacros.h>
 #include <linux/uinput.h>
 #include "tst_test.h"
-#include "tst_uinput.h"
+#include "libuinput.h"
 #include "uevent.h"
 
 static int mouse_fd;
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
