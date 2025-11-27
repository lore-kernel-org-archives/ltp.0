Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 511FAD116E6
	for <ltp@archiver.kernel.org>; Thu, 27 Nov 2025 01:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1764207694; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=eHZWhXDqnPlfPiSvaQW5YEBKb7iInbLs6FgKupl8fa8=;
 b=nM2QpLgVQE0nt+RWc3vggGct3YvfwHU+2elQzbBhyRjoWp9imtdsxlvOc+WGx7JKNeIF7
 mRnlkigP6evoG7iKXyh4SHAjwmuwq/dqr/AlPZ2fy+p79No5r8wOrNeemxIwZgMxjP492HZ
 6NSJCl3uHWEc4uliNer+qysVirApd3o=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 700633CAC22
	for <ltp@archiver.kernel.org>; Thu, 27 Nov 2025 02:41:34 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CC6383C8232
 for <ltp@lists.linux.it>; Thu, 27 Nov 2025 02:41:14 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E5DAF1A00439
 for <ltp@lists.linux.it>; Thu, 27 Nov 2025 02:41:13 +0100 (CET)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4779cb0a33fso2691835e9.0
 for <ltp@lists.linux.it>; Wed, 26 Nov 2025 17:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1764207673; x=1764812473; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yKCERojUlZzta30GqyPjQ2Xxts8tnz3Siqq5ZdLdU74=;
 b=aIQKgHRckkGyHq97ggalTXXg40Jyy11NcVukKr2YT2V3QV475n9jwBbLQfxGg8hApx
 Zb+o/SWzgb4BlZbUPdtbyJfiYlZtx10qGCgw0BMNBH+FKAYUM7eB/ZmUm/2BDboqx3ZF
 78nj3WyE19ifguxOuDZ4nf7MH01UXD8pddserPMOqsga30U+/gSJF+YpFGcJj972zVRX
 OmJMnv3ROKq6DA78NV+Vv289KHqaqdnv1xdx/FrvST9ja44Fm5adIvxfEItf1F+R5uiK
 6j2a+viQpRHDEjSdNG3i1D4DULzmIyujVP88roGxHYDnIO1+cw50IYClirbLlbQaiM/A
 8xcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764207673; x=1764812473;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yKCERojUlZzta30GqyPjQ2Xxts8tnz3Siqq5ZdLdU74=;
 b=FpnvA6Prbe6o30XZgqRn08STptEScDRVqrtlMNUf80tM2JkZPUSJ2q+ia5B7/lOCP1
 VERc5+Se5ZZir3DUn6sak36lFHT+5Cy8JzqhLtsRKLTHUVt3L+Vbz4tVcAZ49+madCp+
 ywLXXtnCNNmNrD0r2oUAX0WTWXQwpu0BQVLe9ROe74WZhHsKthRw39EMXokMwoCWpGCH
 ZE3IMkDffRu/B9FJ6xkMYMBsTnxyHCSm+NIdWDzzlHkfwSqCimGA5puCmAJTtkH6KBzN
 li0SqRKTleewWrBsy5zgpYWDHeD9bxahAhziPskq9ifqnQCZhRvf9XwTndZL9vLz95ox
 y6zw==
X-Gm-Message-State: AOJu0YzUSwJfro/Im1vsQjch00naEh/mBwn+Uuw7MccyZ5ZnozN4aewx
 YNbRov2/Ijcv3Yu8CA+eToqjsYWoxnNLuLqkA1eu2Ucfs/RaoBsCk+FdiPk0wY2Yng7iTUL29P9
 85S0=
X-Gm-Gg: ASbGncs85Z3Ngl0MJ9Qu2ohO4GzRFNnf6eV0jcUZtMcEf56M6hSHm9jY2LY9+YXATzJ
 AV9gW5AtuwBrpv4G+f4ohDGWhmu4k/qejwU4XfHLlu9qPo0xd7i1yjBRsc1n3KaLzS8IFOCJCA7
 eNPmiGf5nb7jnIwbbJVfeFN+n9jPESTOPwTq8jsSStFc2jaHjxZMBY4e7BqwrCJBsLr/m1Mnfge
 hzZpCBFNv0fWg3HYY2R2phgA6Xdvh7Y/Tu9EgmdLivnZgpf0KBFnUlur2OXrdSWTFoRmQ70DfUY
 2zBz3ANCQNSLtgcHdyRYTiG8K/BIO6O+quZ3fOHff+MR/w1vC1O0GnIcz+LGHl21MBBjN6I5kTU
 PY0bQKoDQWHVKdGNCKnA06y9hny8xfIv6DmKTtpcjFDzyw38zUzrHehec4yLIvi+mZSHY/lbOQE
 Z8HUBgOXxU1w==
X-Google-Smtp-Source: AGHT+IGuHyfnnFB7QJqqt6JOHrgK7kepdcm+FEy5SSzvatWZ1GH7d9+dCqE5taUAdkTgY53gkvuupg==
X-Received: by 2002:a05:600c:4506:b0:477:7bca:8b2b with SMTP id
 5b1f17b1804b1-477c0190e57mr266216575e9.15.1764207673010; 
 Wed, 26 Nov 2025 17:41:13 -0800 (PST)
Received: from localhost ([202.127.77.110])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-29b5b1075basm207019755ad.21.2025.11.26.17.41.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Nov 2025 17:41:12 -0800 (PST)
To: ltp@lists.linux.it
Date: Thu, 27 Nov 2025 09:39:58 -0500
Message-ID: <20251127143959.9416-1-wegao@suse.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] listmount04.c: Update case support
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

New kernel commit lead test case failure with following error message:
listmount04.c:128: TFAIL: invalid mnt_id_req.spare expected EINVAL: EBADF (9)

Detail of new kernel commit:
commit: 78f0e33cd6c939a555aa80dbed2fec6b333a7660
fs/namespace: correctly handle errors returned by grab_requested_mnt_ns

Signed-off-by: Wei Gao <wegao@suse.com>
---
 configure.ac                                   |  1 +
 .../kernel/syscalls/listmount/listmount04.c    | 18 ++++++++++++------
 2 files changed, 13 insertions(+), 6 deletions(-)

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
index a52bad064..3be3be4f2 100644
--- a/testcases/kernel/syscalls/listmount/listmount04.c
+++ b/testcases/kernel/syscalls/listmount/listmount04.c
@@ -18,6 +18,7 @@
 #include "lapi/mount.h"
 #include "lapi/syscalls.h"
 
+#ifdef HAVE_STRUCT_MNT_ID_REQ_MNT_NS_FD
 #define MNT_SIZE 32
 
 static struct mnt_id_req *request;
@@ -26,7 +27,7 @@ static uint64_t mnt_ids[MNT_SIZE];
 static struct tcase {
 	int req_usage;
 	uint32_t size;
-	uint32_t spare;
+	uint32_t mnt_ns_fd;
 	uint64_t mnt_id;
 	uint64_t param;
 	uint64_t *mnt_ids;
@@ -73,12 +74,12 @@ static struct tcase {
 	{
 		.req_usage = 1,
 		.size = MNT_ID_REQ_SIZE_VER0,
-		.spare = -1,
+		.mnt_ns_fd = -1,
 		.mnt_id = LSMT_ROOT,
 		.mnt_ids = mnt_ids,
 		.nr_mnt_ids = MNT_SIZE,
-		.exp_errno = EINVAL,
-		.msg = "invalid mnt_id_req.spare",
+		.exp_errno = EBADF,
+		.msg = "invalid mnt_id_req.mnt_ns_fd bad file descriptor",
 	},
 	{
 		.req_usage = 1,
@@ -122,7 +123,7 @@ static void run(unsigned int n)
 		req->mnt_id = tc->mnt_id;
 		req->param = tc->param;
 		req->size = tc->size;
-		req->spare = tc->spare;
+		req->mnt_ns_fd = tc->mnt_ns_fd;
 	}
 
 	TST_EXP_FAIL(tst_syscall(__NR_listmount, req, tc->mnt_ids,
@@ -133,9 +134,14 @@ static void run(unsigned int n)
 static struct tst_test test = {
 	.test = run,
 	.tcnt = ARRAY_SIZE(tcases),
-	.min_kver = "6.8",
+	.min_kver = "6.18",
 	.bufs = (struct tst_buffers []) {
 		{ &request, .size = MNT_ID_REQ_SIZE_VER0 },
 		{},
 	},
 };
+
+#else
+	TST_TEST_TCONF(
+		"This system does not support mnt_id_req.mnt_ns_fd.");
+#endif /* HAVE_STRUCT_MNT_ID_REQ_MNT_NS_FD */
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
