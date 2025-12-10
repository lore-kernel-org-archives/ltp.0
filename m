Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A978D2CE17
	for <ltp@archiver.kernel.org>; Wed, 10 Dec 2025 06:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1765347624; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=tdOrRPIYnByuo5Uaro7GqRACUEfNUrYbyE/haeLOG54=;
 b=QaOn72Xc4tV1zUQzizWdZhT9Uy5hhR6U5NpSVkylnVAvqcm59MKimc0h0xpgbP+ticrLV
 RFOSGY0K3YgJ6WcCP6QBpSOkOEXY3bX90wDjIIfjD9BLkhqpVD8aPiKcptfcreXtOjxpayF
 lQI6swVZyPRiDUtYcIM5dRO9Al8e0/w=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E7C003CC9E7
	for <ltp@archiver.kernel.org>; Wed, 10 Dec 2025 07:20:24 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8C07F3C9A3C
 for <ltp@lists.linux.it>; Wed, 10 Dec 2025 07:20:04 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 740F3140024C
 for <ltp@lists.linux.it>; Wed, 10 Dec 2025 07:20:03 +0100 (CET)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-47a8195e515so8976815e9.0
 for <ltp@lists.linux.it>; Tue, 09 Dec 2025 22:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1765347602; x=1765952402; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+9I2vvJ0akeDQtTiVTIthHBJMXpof3IJaOK2JF3PFUQ=;
 b=ekAUpm8US5f3LE2KPeGKPdrfvpa2SNYs/7JE45XSh6/d+ZzwNy8D6wDcAl0GHzCvsv
 EG/MxgsoHuhl7nUfgnX2fel3ctual3/7MrHxX2vQ7lLlEjsFkvCNCDvZKHXkXr7jfHDE
 +8YhaOSr3nY0D72rJKhA1LkBF2Od3fERfc4s9eKflUtIZZSRxI4OgY6FG0sQCifFx4y0
 8fEa5S/lPVebj1OXn81m5gvqWY8qwIQ3cJqKbbBtpJTrhGNk1f4Zjh0XmGboCsCfWA1g
 tB8D92C/D337RXMTLUnvD8YyG/OmM0i9xoJs2ixRUJ7+nUWNygb3OkBAvXa7Seadqy+w
 Nw3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765347602; x=1765952402;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+9I2vvJ0akeDQtTiVTIthHBJMXpof3IJaOK2JF3PFUQ=;
 b=MOrmCryUw6tPZwKMJDXPN+p9Qx5fB6wLbQiNX4ENXSfw37pL5SfkWg8N+KOeVp2fSX
 jjJo3NT5VK3DmcBSsEdMz6SLS2bz5eK0fkiVpkFm+quLUXgsDbJxkxrnn0D4eduARyA7
 /bsuFqfaZx9g9nTVCzbZrEuFFuXNT8mcqCW6G9JETXBlxDfM9VC0fJjfRBkkvl3egeUy
 TuLLEn+y4xaLhb1FzYE6FzuFFdFi4WjWOhOyqXNQn3ybQd5oH9tmJi6Xyw9p0mwevMW7
 R8tlMYUZhpmqhMYfN89P5XVY9zD0S1AqxWRqj+Kqm4G43/He0Jy7SKhurhHNVzJLGvcA
 bk+A==
X-Gm-Message-State: AOJu0YyX9vnRiBs8YJuFxwC1tKSc54NHTBliVH+BbytmSbvZdsBf6+KG
 OO/d5nlK4G7wyyXQwu9/Sf4rKB2RQTMMUNlnEjH1zO9liJhhE5u1r5E+yntDbmMdNFn0uOWzvFr
 vNEU=
X-Gm-Gg: ASbGnct4CoHIziihzlReCMxl2laHh4lF3lDyfSm/kBeHscl8UoxD7YHQFi4gVzjwcpF
 W2sU6yMQyWbZFlOQRIodg8tQxfCMtADDZLV07ORRJLCU9UqqRHunQfP/9F75YfKMfhnsYxnIFJ9
 ByZSwWddWwxk5GBjEP3XKJgYaVGd8LpZ7TuOh0G+AI5PnT1XVXVYpCBzHicLpbr81CoTsKcK/5M
 EGV56wYHMIcrXH2u6rNgTYUSWBUE0m6cKprw5488uXObbjaGNCKl1BenE3Ii4j1YWiiD2S4gFSE
 CKLuwBAizdrVR2ZkUDguA8fZ1Shir2TuHlKqG7IACYT9AbA8ChVQWklw7/j6UhqlEpcbSBdYVN1
 d80LLSNfS0aRI621Ye8sD4HQKiX0Fh4MSuAg54Fir9dCmZw6s4i14mDvdIIrZi3M/07nuRTmrNt
 s=
X-Google-Smtp-Source: AGHT+IHvxblbjfsCj0NChsevuTvN8QlHhpcDeUU3wKJQ9Rp0GE8MpS0tPZ7d7VKx6chgKDzy9NOjTQ==
X-Received: by 2002:a05:600c:8709:b0:477:582e:7a81 with SMTP id
 5b1f17b1804b1-47a837fcb2fmr11875485e9.4.1765347602611; 
 Tue, 09 Dec 2025 22:20:02 -0800 (PST)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-47a82cb0a09sm25712025e9.0.2025.12.09.22.20.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Dec 2025 22:20:02 -0800 (PST)
To: ltp@lists.linux.it
Date: Wed, 10 Dec 2025 06:19:41 +0000
Message-ID: <20251210061957.32631-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251209004242.31774-1-wegao@suse.com>
References: <20251209004242.31774-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] listmount04.c: Update case support
 mnt_id_req.mnt_ns_fd
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

Kernel change from v6.18-rc7 lead test case failure with following error message:
listmount04.c:128: TFAIL: invalid mnt_id_req.spare expected EINVAL: EBADF (9)

Detail of new kernel commit:
commit: 78f0e33cd6c939a555aa80dbed2fec6b333a7660
fs/namespace: correctly handle errors returned by grab_requested_mnt_ns

Signed-off-by: Wei Gao <wegao@suse.com>
---
 configure.ac                                  |  1 +
 .../kernel/syscalls/listmount/listmount04.c   | 26 ++++++++++++++++++-
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 0480f46ca..fcff90799 100644
--- a/configure.ac
+++ b/configure.ac
@@ -263,6 +263,7 @@ AC_CHECK_TYPES([struct cachestat],,,[#include <sys/mman.h>])
 
 # Defined in <linux/mount.h>, but include/lapi/mount.h includes <sys/mount.h> */
 AC_CHECK_TYPES([struct mnt_id_req],,,[#include <sys/mount.h>])
+AC_CHECK_MEMBERS([struct mnt_id_req.mnt_ns_fd],,,[#include <sys/mount.h>])
 AC_CHECK_TYPES([struct statmount],,,[#include <sys/mount.h>])
 AC_CHECK_MEMBERS([struct statmount.mnt_ns_id],,,[#include <unistd.h>
 #include <linux/mount.h>])
diff --git a/testcases/kernel/syscalls/listmount/listmount04.c b/testcases/kernel/syscalls/listmount/listmount04.c
index a6921a249..973b472f6 100644
--- a/testcases/kernel/syscalls/listmount/listmount04.c
+++ b/testcases/kernel/syscalls/listmount/listmount04.c
@@ -14,6 +14,7 @@
 
 #define _GNU_SOURCE
 
+#include "config.h"
 #include "tst_test.h"
 #include "lapi/mount.h"
 #include "lapi/syscalls.h"
@@ -26,7 +27,11 @@ static uint64_t mnt_ids[MNT_SIZE];
 static struct tcase {
 	int req_usage;
 	uint32_t size;
+#ifdef HAVE_STRUCT_MNT_ID_REQ_MNT_NS_FD
+	uint32_t mnt_ns_fd;
+#else
 	uint32_t spare;
+#endif
 	uint64_t mnt_id;
 	uint64_t param;
 	uint64_t *mnt_ids;
@@ -73,12 +78,21 @@ static struct tcase {
 	{
 		.req_usage = 1,
 		.size = MNT_ID_REQ_SIZE_VER0,
+#ifdef HAVE_STRUCT_MNT_ID_REQ_MNT_NS_FD
+		.mnt_ns_fd = -1,
+#else
 		.spare = -1,
+#endif
 		.mnt_id = LSMT_ROOT,
 		.mnt_ids = mnt_ids,
 		.nr_mnt_ids = MNT_SIZE,
+#ifdef HAVE_STRUCT_MNT_ID_REQ_MNT_NS_FD
+		.exp_errno = EBADF,
+		.msg = "invalid mnt_id_req.mnt_ns_fd bad file descriptor",
+#else
 		.exp_errno = EINVAL,
 		.msg = "invalid mnt_id_req.spare",
+#endif
 	},
 	{
 		.req_usage = 1,
@@ -122,7 +136,17 @@ static void run(unsigned int n)
 		req->mnt_id = tc->mnt_id;
 		req->param = tc->param;
 		req->size = tc->size;
-		req->spare = tc->spare;
+#ifdef HAVE_STRUCT_MNT_ID_REQ_MNT_NS_FD
+		if ((tst_kvercmp(6, 18, 0)) >= 0)
+			req->mnt_ns_fd = tc->mnt_ns_fd;
+		else
+			tst_brk(TCONF, "Skipping test, kernel version should > 6.18");
+#else
+		if ((tst_kvercmp(6, 18, 0)) >= 0)
+			tst_brk(TCONF, "Skipping test, kernel version should < 6.18");
+		else
+			req->spare = tc->spare;
+#endif
 	}
 
 	TST_EXP_FAIL(tst_syscall(__NR_listmount, req, tc->mnt_ids,
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
