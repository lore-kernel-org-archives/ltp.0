Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0B76D3E783
	for <ltp@archiver.kernel.org>; Thu, 11 Dec 2025 01:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1765418393; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=OzaMWSt5WVBCHiFeDwIlweXn3cXo280iDFIVhmL7nzY=;
 b=MEeb/ksY4DBXWjMRQ48rk/Eqw40UuPHT+GyeIV6isJwU8Rjv5UckUfdPI6ZvgsqcNkxf+
 Zz2veCYu2kJykCL53+SE6ui1+cCAhMCWAinq+V2yz3D3f9pL480yNXRsvmCxKoBpPZ4tyOE
 wHDN4jOiFr5duBSP1oHd+w+O4mkYAAo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B8B283CEFFA
	for <ltp@archiver.kernel.org>; Thu, 11 Dec 2025 02:59:53 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 284B53CE31F
 for <ltp@lists.linux.it>; Thu, 11 Dec 2025 02:59:30 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0346910004A7
 for <ltp@lists.linux.it>; Thu, 11 Dec 2025 02:59:29 +0100 (CET)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-47796a837c7so3252205e9.0
 for <ltp@lists.linux.it>; Wed, 10 Dec 2025 17:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1765418369; x=1766023169; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YKhlkhBDkb/ZwfrN7zIHIP6PIS/U6MVHMqfLf5SwXRQ=;
 b=QpygrMqS1hKXX6rYggW9NQSRQsYEHBCmSDefyLhagFba6/uGRKPbVotO5ETev+zV9d
 i3AiB64tYBqcYWRXHDVSZiJ/Qwb13cPbU9V9xzS1/UeTpYszas3B8J8BwY0crizhZn2M
 5oXmpJNOZvOF997OLuLO0GZt621q7tByUP2ZRN4d58o4MlQKqSefyhQZMAh4zukebhC6
 Vycxk8mbAENq+WjXEIYpVBR7h49jj8njj88lag/Ms6QjVoqBWa35e655pAlPNS04/5Ik
 iyhMXX7H2DuahnpeMFAuBNDIUXb6lpf+pW/jcQoUzHKe80la3FolrwOsJsVhErugYF0m
 TJzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765418369; x=1766023169;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YKhlkhBDkb/ZwfrN7zIHIP6PIS/U6MVHMqfLf5SwXRQ=;
 b=asIOt/bc3zh4+hYYr3yehN+8DMhI+iOiNVloMXTbIajeqBmOY06qa8v6FEa+eoZMN4
 f06+yxHH2ywmTBtc4TgIctygcRzWO7v9aLn5Mk8MNnL12Dg30qi6zrfsCIKrSju1syiv
 TyYUtAHN60GekouGypTldf+AWhoItWyYUHBhxdK2j0qBKh+5iaxhQXmqiGyqqd1VXPH5
 j8UBKZKd21qbk9SJ3YUxort3BYxQtGKxqcKyttgoY/wflBJu3I1KU1jpfGwIli/dfxGH
 FBvp2H1amrxE9a/rTvzAVEDSkdxIn9XICo1AJmeBU6R01G+ZnLY66rkec0GJRWQNxsdx
 ffpA==
X-Gm-Message-State: AOJu0Yy0rPpvJ9caApBjf0m6OmkfCAMh2MeKrVh69zzAcm9VXCTSx903
 H4lUqUclm8EKlYJgWK1BMS0uvO36C4oxnL5Eh9qHR5JWvWlwI3uuGwceVfLfU3Cj5mEsJAAdkcy
 8aRU=
X-Gm-Gg: AY/fxX4vgFUPH9wd4W0iGs4Yu5dJZnfyPkaMMad2ixOOP2F3bHmSr1RLdT8+D03aOFZ
 EZJ6BK7DQEO8kfprDgM8Ls83/cNSBiOBqFfvplpfGdklRPRfme3485q6h3dkbUf5XRxPqZ6e3E5
 vGJWP3qBUA66GMjVsyhQiP4WtI5ra+STFazD8jnpDOgW1Wk5LOIHMH5WW57TlDMufTZ3CJwkK/v
 GPxTO+9YmKxXS6+p3o7N16Fo3RfUuufxNq7bN/7TkbcrwD+vbgJNqip1RYIC8BBn1u4n/lMVmAE
 rVwLYV3jhxvK/p1SLmmW0m1PKGD1ruqGOgP7uXvg2Koq8Z6CSVzMZYcBOjRhb3qfEmrNx+zMzpg
 9Dc6e2zs22c4Y4rCTI+Pop9QZinAQ3+LZi77fITbxrkCrZq+UImy+yzxwdHXAYDnnuX9YVofWrl
 Q=
X-Google-Smtp-Source: AGHT+IFcJNyLhuazYwiW/zYPGscdKSpYAZavC/Xd+qWujSZKZ6gREVe5pqht8kA2SsBqRziytIGtrQ==
X-Received: by 2002:a05:6000:2388:b0:42f:8816:c01b with SMTP id
 ffacd0b85a97d-42fa3b0fb99mr4570207f8f.63.1765418368955; 
 Wed, 10 Dec 2025 17:59:28 -0800 (PST)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-42fa8b8a841sm2521798f8f.30.2025.12.10.17.59.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 17:59:28 -0800 (PST)
To: ltp@lists.linux.it
Date: Thu, 11 Dec 2025 01:59:05 +0000
Message-ID: <20251211015915.1086-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251210061957.32631-1-wegao@suse.com>
References: <20251210061957.32631-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] listmount04.c: Update case support
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
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---
 configure.ac                                  |  1 +
 .../kernel/syscalls/listmount/listmount04.c   | 26 ++++++++++++++++++-
 2 files changed, 26 insertions(+), 1 deletion(-)

v3->v4: fix grammatical errors 

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
index a6921a249..3579a4296 100644
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
+			tst_brk(TCONF, "Skipping test, kernel version should be >= 6.18");
+#else
+		if ((tst_kvercmp(6, 18, 0)) >= 0)
+			tst_brk(TCONF, "Skipping test, kernel version should be < 6.18");
+		else
+			req->spare = tc->spare;
+#endif
 	}
 
 	TST_EXP_FAIL(tst_syscall(__NR_listmount, req, tc->mnt_ids,
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
