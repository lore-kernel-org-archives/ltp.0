Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F045C7EE23
	for <ltp@archiver.kernel.org>; Thu,  1 Jun 2023 08:54:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1B7933CCEEF
	for <ltp@archiver.kernel.org>; Thu,  1 Jun 2023 10:54:39 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 532383CCE35
 for <ltp@lists.linux.it>; Thu,  1 Jun 2023 10:54:29 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 02C2B1400063
 for <ltp@lists.linux.it>; Thu,  1 Jun 2023 10:54:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685609667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Pj/a/fqPa6+VuFYydtt1Ydwxc01UKmQ9WR4BQ4cQfIc=;
 b=Tju5NTedPFwIuei8alErhhC8f+DuD27cvj6ASlwG4nhg+InVfpCR8+/xkj4wvfiC4yyE2F
 +MEHSPwoZK9ajPlGk4aGlc4IqRNXK3B3R37Lc3vSuipC2aj/zk/0Ol90F6+d1wj/XZt1yZ
 hScru9L6eg1tTingb2qVmyaI0V+UXh0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-64-6I5-nOhwN8u4iXKzSsEZBw-1; Thu, 01 Jun 2023 04:54:25 -0400
X-MC-Unique: 6I5-nOhwN8u4iXKzSsEZBw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 55327800159
 for <ltp@lists.linux.it>; Thu,  1 Jun 2023 08:54:25 +0000 (UTC)
Received: from liwang-workstation.lab.eng.nay.redhat.com (unknown
 [10.66.145.229])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 65214112132C
 for <ltp@lists.linux.it>; Thu,  1 Jun 2023 08:54:24 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Thu,  1 Jun 2023 16:54:22 +0800
Message-Id: <20230601085422.52874-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] include: remove outdated ipcshm.h
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Since it has been replaced by libnewipc.h header file, and
there has no inclusion in any LTP tests, so let's remove it.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 include/ipcshm.h | 54 ------------------------------------------------
 1 file changed, 54 deletions(-)
 delete mode 100644 include/ipcshm.h

diff --git a/include/ipcshm.h b/include/ipcshm.h
deleted file mode 100644
index 08307d4ab..000000000
--- a/include/ipcshm.h
+++ /dev/null
@@ -1,54 +0,0 @@
-/*
- *
- *   Copyright (c) International Business Machines  Corp., 2001
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
- */
-
-/*
- * ipcshm.h - common definitions for the IPC shared memory tests
- */
-
-#ifndef __IPCSHM_H
-#define __IPCSHM_H
-
-#include <errno.h>
-#include <sys/wait.h>
-#include <sys/ipc.h>
-#include <sys/shm.h>
-
-#include "test.h"
-
-void cleanup(void);
-void setup(void);
-
-#define SHM_RD	0400
-#define SHM_WR	0200
-#define SHM_RW	SHM_RD | SHM_WR
-
-#define SHM_SIZE	2048	/* a resonable size for a memory segment */
-#define INT_SIZE	4	/* instead of sizeof(int) */
-
-#define MODE_MASK	0x01FF	/* to get the lower nine permission bits */
-				/* from shmid_ds.ipc_perm.mode		 */
-
-key_t shmkey;			/* an IPC key generated by ftok() */
-
-void rm_shm(int shm_id);
-
-int getipckey();
-int getuserid(char*);
-
-#endif /* ipcshm.h */
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
