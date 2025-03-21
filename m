Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7639DC36000
	for <ltp@archiver.kernel.org>; Fri, 21 Mar 2025 15:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1742569932; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=xvUmth3q+D1fSIYj6Ubaf28+FV2Z3q5hQItKN1VJs/s=;
 b=BCmN1Fnvr38dxdVCMOFX68cSKb5tR4wIadhTB2D+vLgSHFLCFDUgp+ZpH2ZMrP74YSFIr
 AvdQGHijZO4qOCb50iHltvtAmNN4HNllr9Ph8SSsm4OzDn+A2WOd2XcRx9aAFyz3R0Drr1Z
 n1PsvIZwDB9exS24Tu1isZFDmvfFAMg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 16AD53CAE2D
	for <ltp@archiver.kernel.org>; Fri, 21 Mar 2025 16:12:12 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8D8523CAD72
 for <ltp@lists.linux.it>; Fri, 21 Mar 2025 16:11:49 +0100 (CET)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C036B200212
 for <ltp@lists.linux.it>; Fri, 21 Mar 2025 16:11:48 +0100 (CET)
Received: by mail-wr1-x444.google.com with SMTP id
 ffacd0b85a97d-3913d45a148so1747554f8f.3
 for <ltp@lists.linux.it>; Fri, 21 Mar 2025 08:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1742569907; x=1743174707; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=th8lmtDBVdmtvzTbUlx2Plmrt/w/QjWm7OhR5DiMMck=;
 b=RIat7iOrf3b+PXyyjWNbn9Bul4ZAPXLon3+4fWltLGIDGl6LzWEBH/gxs1Ff3e6QHm
 kU6NGvpDIBdP0e0f6fXMz2SHt7oX5RpnqKGimViwyfLHdI5UwVHbgjQ0PwS/A9UMyYfm
 QQB83yLHJ6QUuCtG31e+CF0JdzYobrmLSooqJfWF++uKidzLBPIBHAKgw6cd4KHe/1JE
 JEAJXjGpiwva4VYotW6nKNUXdWEFMgAh8SiSB6abAeZyvXggmCULMNjBQK5XsD+3Qt6/
 7oY/Qj+bblwW23lDN9FsrZJwNiM/0So9vCRByHkSnfnJD1wsGv+XwUykAs/Up5iwbMf2
 i7Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742569907; x=1743174707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=th8lmtDBVdmtvzTbUlx2Plmrt/w/QjWm7OhR5DiMMck=;
 b=lDD50kGmXZPtUZUtL/b78B5xtsQghapilLhQnXIzXMdKH3cR24hRr+ijjzdh/Ur5YP
 32P7kS1ZoVdDGMNm2mV4sSByZr5WDqW7jsCHb7voSkOjh2EIl7dPXXEc4JbMLo9/UVFn
 B6HzooIXwOz0Mmvwa6lAjORL1O1ydEsBVBbesrd5q9M4YUGHWx+Z7w7SIOw8hqWH9g8K
 uAhLzTEZHEeCaaJ3B63OclLr7/AuCiCLVbd6gOkrULCS6QBkdaUF5Rs9TxyOf1PGIM4d
 5ug05QvY17cb3dCnsF1iqXaGaeWz+q+30KdaH8rRQeEGetin4VxguqrQze1QDY5di8C0
 wg4g==
X-Gm-Message-State: AOJu0YziSLdvKzdeXXk8nrJLGDQm3X63J3eWw0bELkjLz9D+C9j+UARk
 tkf824TGmGpT2cc3F8iBMZ0TAQi2GJ3hUSJ+mk5PHr3ayX8yB9kXl1pWQpRScgAXzuqrWUrRayA
 RAFwwmVo=
X-Gm-Gg: ASbGncvXdrEWSyV84pTzfnl6AewXFK3lFimNL+waEYwdUx0yXeLigLn4G6II9u1aw9E
 vu0ZMs2wXl/2cmZqJwNFUK94eAKpA2ed717athprjtL1O2dp3Nlq+2v2g+VlKT5KGX13HiqNBuc
 vKivxOFisEMaclvsiAlWbukyDvXv7ehgVfGjWDNbDdk9/SU/1012C2svl85UjyAbJGyW+3rzRJ3
 9wXuS7RU74W3+ac4E7ip2p3rK4l9aIHRBlQ15nNVjeqnd1U3ZVuwco9Y/RGoLv4PN/6d7WjsSqd
 40QPQ7rtoJiikPSbJFyyPsph6xEaYawXszj2n+YzWvmo
X-Google-Smtp-Source: AGHT+IEOz28jCbafIm+DmEi5TbXuZkY0CKmgzHoau+5ngMIFBBD/On0DeNrIy4EKSL1ngap2Uf/hpw==
X-Received: by 2002:a5d:5889:0:b0:391:3f64:ecfe with SMTP id
 ffacd0b85a97d-3997f8f8339mr4001315f8f.10.1742569907303; 
 Fri, 21 Mar 2025 08:11:47 -0700 (PDT)
Received: from localhost ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22780f4a034sm17874065ad.98.2025.03.21.08.11.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Mar 2025 08:11:46 -0700 (PDT)
To: ltp@lists.linux.it
Date: Fri, 21 Mar 2025 11:11:43 -0400
Message-Id: <20250321151143.11332-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250321034248.3501-1-wegao@suse.com>
References: <20250321034248.3501-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] mount08.c: Restrict overmounting of ephemeral
 entities
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

Add a new test to verify that mount will raise ENOENT if we try to mount
on magic links under /proc/<pid>/fd/<nr>.
Refer to the following kernel commit for more information:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d80b065bb172

Signed-off-by: Wei Gao <wegao@suse.com>
Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                           |  1 +
 testcases/kernel/syscalls/mount/.gitignore |  1 +
 testcases/kernel/syscalls/mount/mount08.c  | 57 ++++++++++++++++++++++
 3 files changed, 59 insertions(+)
 create mode 100644 testcases/kernel/syscalls/mount/mount08.c

diff --git a/runtest/syscalls b/runtest/syscalls
index ded035ee8..d3abc8b85 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -852,6 +852,7 @@ mount04 mount04
 mount05 mount05
 mount06 mount06
 mount07 mount07
+mount08 mount08
 
 mount_setattr01 mount_setattr01
 
diff --git a/testcases/kernel/syscalls/mount/.gitignore b/testcases/kernel/syscalls/mount/.gitignore
index 80885dbf0..3eee5863a 100644
--- a/testcases/kernel/syscalls/mount/.gitignore
+++ b/testcases/kernel/syscalls/mount/.gitignore
@@ -6,3 +6,4 @@
 /mount05
 /mount06
 /mount07
+/mount08
diff --git a/testcases/kernel/syscalls/mount/mount08.c b/testcases/kernel/syscalls/mount/mount08.c
new file mode 100644
index 000000000..1938c5519
--- /dev/null
+++ b/testcases/kernel/syscalls/mount/mount08.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 Wei Gao <wegao@suse.com>
+ */
+
+/*\
+ * Verify that mount will raise ENOENT if we try to mount on magic links
+ * under /proc/<pid>/fd/<nr>.
+ */
+
+#include "tst_test.h"
+#include <sys/mount.h>
+#include "tst_safe_file_at.h"
+
+#define MNTPOINT "mntpoint"
+#define FOO MNTPOINT "/foo"
+#define BAR MNTPOINT "/bar"
+
+static void run(void)
+{
+	char path[PATH_MAX];
+	int foo_fd, newfd, proc_fd;
+
+	foo_fd = SAFE_OPEN(FOO, O_RDONLY | O_NONBLOCK, 0640);
+	newfd = SAFE_DUP(foo_fd);
+	SAFE_CLOSE(foo_fd);
+
+	sprintf(path, "/proc/%d/fd/%d", getpid(), newfd);
+
+	proc_fd = SAFE_OPENAT(AT_FDCWD, path, O_PATH | O_NOFOLLOW);
+
+	sprintf(path, "/proc/%d/fd/%d", getpid(), proc_fd);
+
+	TST_EXP_FAIL(
+		mount(BAR, path, "", MS_BIND, 0),
+		ENOENT,
+		"mount() on proc failed expectedly"
+	);
+}
+
+static void setup(void)
+{
+	SAFE_CREAT(FOO, 0777);
+	SAFE_CREAT(BAR, 0777);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.needs_root = 1,
+	.mntpoint = MNTPOINT,
+	.min_kver = "6.12",
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "d80b065bb172"},
+		{}
+	}
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
