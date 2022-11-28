Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6F5CC43217
	for <ltp@archiver.kernel.org>; Mon, 28 Nov 2022 11:18:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 718093CC666
	for <ltp@archiver.kernel.org>; Mon, 28 Nov 2022 12:18:54 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2636A3C288D
 for <ltp@lists.linux.it>; Mon, 28 Nov 2022 12:18:44 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 20773200075
 for <ltp@lists.linux.it>; Mon, 28 Nov 2022 12:18:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669634321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NtN7Ebw9gCY2fUA5nR6xMoZSc8DPvcb/v5vWL3BIUeQ=;
 b=ILbz2z7r1LLrqCCSjW9ZfVIUH/+G8m6cYIzYGjDI5nnkieCz1OHhalHwYOCpUYM6o4n8Rz
 3hmTYyGN6w2MBDt4z+utofXZg7lXromwNg2kqb4dcdQgGXMuGu3Oiha+GbvTxOpM4DNKe4
 hs12szKRe5fsfnP/WvReVTNSkzWTKf4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-97-o0Jn0fPnOsO3OYps7j2Kfg-1; Mon, 28 Nov 2022 06:18:40 -0500
X-MC-Unique: o0Jn0fPnOsO3OYps7j2Kfg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CCF3F101A528;
 Mon, 28 Nov 2022 11:18:39 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.192.246])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 90EC6C15BA4;
 Mon, 28 Nov 2022 11:18:38 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: ltp@lists.linux.it
Date: Mon, 28 Nov 2022 12:18:31 +0100
Message-Id: <20221128111833.98937-2-david@redhat.com>
In-Reply-To: <20221128111833.98937-1-david@redhat.com>
References: <20221128111833.98937-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 1/3] lapi/userfaultfd.h: Preparation for removing
 compile-time TCONF handling from userfaultfd testcases
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
Cc: David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Let's provide a minimal include/lapi/userfaultfd.h that contains the
initial userfaultfd uabi from v4.1, plus selected additions from other
releases relevant for the two testcases we have for now.

We can extend this header later as required, for example, once testcases
want to test userfaultfd-wp support.

Note that some dead code (#ifdef 0) and unnecessary definitions that keep
changing (UFFD_API_IOCTLS) were dropped from the v4.1 version.

Suggested-by: Martin Doucha <mdoucha@suse.cz>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/lapi/userfaultfd.h | 190 +++++++++++++++++++++++++++++++++++++
 1 file changed, 190 insertions(+)
 create mode 100644 include/lapi/userfaultfd.h

diff --git a/include/lapi/userfaultfd.h b/include/lapi/userfaultfd.h
new file mode 100644
index 000000000..4d52b7c4b
--- /dev/null
+++ b/include/lapi/userfaultfd.h
@@ -0,0 +1,190 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2007 Davide Libenzi <davidel@xmailserver.org>
+ * Copyright (C) 2015,2022 Red Hat, Inc.
+ *
+ * Mostly copied/adapted from <linux/userfaultfd.h>
+ */
+
+#ifndef LAPI_USERFAULTFD_H__
+#define LAPI_USERFAULTFD_H__
+
+#include <unistd.h>
+#include <sys/types.h>
+#include "lapi/syscalls.h"
+
+#ifdef HAVE_LINUX_USERFAULTFD_H
+#include <linux/userfaultfd.h>
+#endif
+
+/* userfaultfd support was added in v4.1 */
+#ifndef UFFD_API
+#define UFFD_API ((__u64)0xAA)
+
+/*
+ * Valid ioctl command number range with this API is from 0x00 to
+ * 0x3F.  UFFDIO_API is the fixed number, everything else can be
+ * changed by implementing a different UFFD_API. If sticking to the
+ * same UFFD_API more ioctl can be added and userland will be aware of
+ * which ioctl the running kernel implements through the ioctl command
+ * bitmask written by the UFFDIO_API.
+ */
+#define _UFFDIO_REGISTER		(0x00)
+#define _UFFDIO_UNREGISTER		(0x01)
+#define _UFFDIO_WAKE			(0x02)
+#define _UFFDIO_COPY			(0x03)
+#define _UFFDIO_ZEROPAGE		(0x04)
+#define _UFFDIO_API			(0x3F)
+
+/* userfaultfd ioctl ids */
+#define UFFDIO 0xAA
+#define UFFDIO_API		_IOWR(UFFDIO, _UFFDIO_API,	\
+				      struct uffdio_api)
+#define UFFDIO_REGISTER		_IOWR(UFFDIO, _UFFDIO_REGISTER, \
+				      struct uffdio_register)
+#define UFFDIO_UNREGISTER	_IOR(UFFDIO, _UFFDIO_UNREGISTER,	\
+				     struct uffdio_range)
+#define UFFDIO_WAKE		_IOR(UFFDIO, _UFFDIO_WAKE,	\
+				     struct uffdio_range)
+#define UFFDIO_COPY		_IOWR(UFFDIO, _UFFDIO_COPY,	\
+				      struct uffdio_copy)
+#define UFFDIO_ZEROPAGE		_IOWR(UFFDIO, _UFFDIO_ZEROPAGE,	\
+				      struct uffdio_zeropage)
+
+/* read() structure */
+struct uffd_msg {
+	__u8	event;
+
+	__u8	reserved1;
+	__u16	reserved2;
+	__u32	reserved3;
+
+	union {
+		struct {
+			__u64	flags;
+			__u64	address;
+		} pagefault;
+
+		struct {
+			/* unused reserved fields */
+			__u64	reserved1;
+			__u64	reserved2;
+			__u64	reserved3;
+		} reserved;
+	} arg;
+} __packed;
+
+/*
+ * Start at 0x12 and not at 0 to be more strict against bugs.
+ */
+#define UFFD_EVENT_PAGEFAULT	0x12
+
+/* flags for UFFD_EVENT_PAGEFAULT */
+#define UFFD_PAGEFAULT_FLAG_WRITE	(1<<0)	/* If this was a write fault */
+#define UFFD_PAGEFAULT_FLAG_WP		(1<<1)	/* If reason is VM_UFFD_WP */
+
+struct uffdio_api {
+	/* userland asks for an API number and the features to enable */
+	__u64 api;
+	/*
+	 * Kernel answers below with the all available features for
+	 * the API, this notifies userland of which events and/or
+	 * which flags for each event are enabled in the current
+	 * kernel.
+	 *
+	 * Note: UFFD_EVENT_PAGEFAULT and UFFD_PAGEFAULT_FLAG_WRITE
+	 * are to be considered implicitly always enabled in all kernels as
+	 * long as the uffdio_api.api requested matches UFFD_API.
+	 */
+	__u64 features;
+
+	__u64 ioctls;
+};
+
+struct uffdio_range {
+	__u64 start;
+	__u64 len;
+};
+
+struct uffdio_register {
+	struct uffdio_range range;
+#define UFFDIO_REGISTER_MODE_MISSING	((__u64)1<<0)
+#define UFFDIO_REGISTER_MODE_WP		((__u64)1<<1)
+	__u64 mode;
+
+	/*
+	 * kernel answers which ioctl commands are available for the
+	 * range, keep at the end as the last 8 bytes aren't read.
+	 */
+	__u64 ioctls;
+};
+
+struct uffdio_copy {
+	__u64 dst;
+	__u64 src;
+	__u64 len;
+	/*
+	 * There will be a wrprotection flag later that allows to map
+	 * pages wrprotected on the fly. And such a flag will be
+	 * available if the wrprotection ioctl are implemented for the
+	 * range according to the uffdio_register.ioctls.
+	 */
+#define UFFDIO_COPY_MODE_DONTWAKE		((__u64)1<<0)
+	__u64 mode;
+
+	/*
+	 * "copy" is written by the ioctl and must be at the end: the
+	 * copy_from_user will not read the last 8 bytes.
+	 */
+	__s64 copy;
+};
+
+struct uffdio_zeropage {
+	struct uffdio_range range;
+#define UFFDIO_ZEROPAGE_MODE_DONTWAKE		((__u64)1<<0)
+	__u64 mode;
+
+	/*
+	 * "zeropage" is written by the ioctl and must be at the end:
+	 * the copy_from_user will not read the last 8 bytes.
+	 */
+	__s64 zeropage;
+};
+#endif /* UFFD_API */
+
+
+/* UFFD_USER_MODE_ONLY was added in v5.11 */
+#ifndef UFFD_USER_MODE_ONLY
+#define UFFD_USER_MODE_ONLY 1
+#endif /* UFFD_USER_MODE_ONLY */
+
+
+/* UFFD_PAGEFAULT_FLAG_MINOR and UFFDIO_CONTINUE were added in v5.13 */
+#ifndef UFFD_PAGEFAULT_FLAG_MINOR
+#define UFFD_FEATURE_MINOR_HUGETLBFS		(1<<9)
+#define UFFDIO_REGISTER_MODE_MINOR	((__u64)1<<2)
+
+#define _UFFDIO_CONTINUE		(0x07)
+#define UFFDIO_CONTINUE		_IOWR(UFFDIO, _UFFDIO_CONTINUE,	\
+				      struct uffdio_continue)
+
+struct uffdio_continue {
+	struct uffdio_range range;
+#define UFFDIO_CONTINUE_MODE_DONTWAKE		((__u64)1<<0)
+	__u64 mode;
+
+	/*
+	 * Fields below here are written by the ioctl and must be at the end:
+	 * the copy_from_user will not read past here.
+	 */
+	__s64 mapped;
+};
+#endif /* UFFD_PAGEFAULT_FLAG_MINOR */
+
+
+/* UFFD_FEATURE_MINOR_SHMEM was added in v5.14 */
+#ifndef UFFD_FEATURE_MINOR_SHMEM
+#define UFFD_FEATURE_MINOR_SHMEM		(1<<10)
+#endif /* UFFD_FEATURE_MINOR_SHMEM */
+
+#endif /* LAPI_USERFAULTFD_H__ */
-- 
2.38.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
