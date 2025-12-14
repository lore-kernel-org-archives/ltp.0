Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5980FD5B161
	for <ltp@archiver.kernel.org>; Sun, 14 Dec 2025 02:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1765678577; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=TEVu8oHnu0NNGkq2bvG03tEqYUSTtZmXCf39PclMmBQ=;
 b=qLde8PuB5V1DEusWv9jOmEstuBzoKhBIvZO/Yzq3gZCbz8z+JvzagbMIzCl95+27wUsGc
 PqTxm6QzY8h+W7lLCnDw5I6JfFC8B8ns7kHhBfIjUs8QzhJVVHLD6W+b+LV9i+c01mbe7r4
 RwQbQ/nbMa8hGYgjcVlRmIXijjTCIAY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D83CA3CF324
	for <ltp@archiver.kernel.org>; Sun, 14 Dec 2025 03:16:17 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 082733CA807
 for <ltp@lists.linux.it>; Sun, 14 Dec 2025 03:15:53 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BC5DB1A00346
 for <ltp@lists.linux.it>; Sun, 14 Dec 2025 03:15:52 +0100 (CET)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-42e33956e76so1129543f8f.3
 for <ltp@lists.linux.it>; Sat, 13 Dec 2025 18:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1765678552; x=1766283352; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IADJKEPwuC7bcJtAh4npvNln0UySkDubC8OpdSTH+CQ=;
 b=AzzAFmGN80XrXaYRN6e+SGMmoXO4Du9O2iWzWy+uNNZTaQb8v+83Ol6dXIpX/L3xUP
 p7UGrSf+VrSouJ58vy76osMXy7lXEH/q9PE7T66VW5a1a7BQqnC8WQDjDyoBb06MGpkG
 bqqW6I2MdSMRQSXOh3M9qmDlOXiosDX+L2f0OlT0nA55WQhV0qIHeyVNNEyUFvGDfhkq
 EeAfDXF9HO7Qo6OwmNt5laRh7Rd84V/EkHzt0BG97BpL1ZHiHcEYtKT7Qx698MIzVylj
 NjbJlSYgllDbm7ohiXrFeTJAHoX2QJpPB/OXHDS1gQ0AmTuXuxftLTxdWT1kRhRU081U
 yu8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765678552; x=1766283352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IADJKEPwuC7bcJtAh4npvNln0UySkDubC8OpdSTH+CQ=;
 b=puLWGZfd9YfOD/IJGvECuKmTU3PurfyA885e2Y87i9KqaC71n31u1WexE0EB/jBo+Q
 CxVFO84joAYRc4pFrwydEXyMsaQrhw19joYwY0mTDvPXH2hIU18nx4cslOkCnq3IV+AX
 mEHohiQQokjpLZhFyUfyKZNrtU3MlEwZVTew4+MDIdfmO/9p0EEaA+EmpQvHV2a2gMAZ
 EuhaM5U+ez5s3nCtgVmUQEwypiZRSy4Ph9aZwq75INiUmUJQcgvm/ZHPhkYiq1mTedEv
 1oyjhok/pKUr/m7+G2EJVrhG4sx2DbjH9TgQHK+6QhRS1d2lZrtYGRMxBQBzl+/aRepI
 aCjA==
X-Gm-Message-State: AOJu0YxrHKol+Ki4rD6fn7F50e+dDY0/V5hKUyE2hNYekzn1jjUz4m/r
 3WhUqk7nuxb8CkS8ohtuwh8tpjgfGSwwCltdPFF3XqVPpg9pbzdUeQCmuwj6osN0Y2iF4a2Jv5U
 45ZE=
X-Gm-Gg: AY/fxX5Bvysfi4KWkeeyZxlXx5L1GX42L2Ip7v8kpNzJ35JrVf9KKeYVjg3IVjuKY4C
 Ni0YIk5H9Rtm5fb+Hj9eG+JitWwofl78CLoeJM/kH8bX5UTXOkNzvcre1xiNaYxxMq7fq8cB+3C
 ZJ70ye2wk/lxhIHRGx91OhC7OFPoSnGf7EvVOOJhbg4NL1Upv/wugtalciXcftIbuWB+iOVJeBn
 Xddbllp/Ln7IR2OV7EMV2GzNSKw859J37YsuiZch4d20i5twqcqi3hdpgkYTP2Z1LHYi1lun3e6
 krGqbEzxBy3ml8qKNA2GhSnIp+4UGA2c2ZZlKA28BdszNcZ86g0inY+h2DFvgXi5Ojo4/Cu0yxp
 tUi7zf203WtpivMTgwJRAGaLxvW/6z8LEV3iGOg2//T7J7/+xoOql0mnZG32Pf5pkU7Ka5LGTrj
 I=
X-Google-Smtp-Source: AGHT+IFXDkhvcHZs33yj66Oe4p/Dyt5skdUCFJiiHQr71e+FPPZVjw+iB70haunl9CcGV1Rghz8qqg==
X-Received: by 2002:a05:6000:1446:b0:42b:3e60:18c7 with SMTP id
 ffacd0b85a97d-42fb44ec3b0mr7708301f8f.36.1765678551817; 
 Sat, 13 Dec 2025 18:15:51 -0800 (PST)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-42fbbeb5298sm9380351f8f.20.2025.12.13.18.15.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Dec 2025 18:15:51 -0800 (PST)
To: ltp@lists.linux.it
Date: Sun, 14 Dec 2025 02:15:20 +0000
Message-ID: <20251214021541.3256-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251212115244.2027-1-wegao@suse.com>
References: <20251212115244.2027-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6] listmount04.c: Update case support
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
 configure.ac                                  |  2 +-
 include/lapi/mount.h                          | 10 +++--
 .../kernel/syscalls/listmount/listmount.h     |  2 +-
 .../kernel/syscalls/listmount/listmount04.c   | 37 +++++++++++++++++--
 .../kernel/syscalls/statmount/statmount.h     |  2 +-
 5 files changed, 44 insertions(+), 9 deletions(-)

diff --git a/configure.ac b/configure.ac
index 0480f46ca..a0ebbb34d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -262,7 +262,7 @@ AC_CHECK_TYPES([struct cachestat_range],,,[#include <sys/mman.h>])
 AC_CHECK_TYPES([struct cachestat],,,[#include <sys/mman.h>])
 
 # Defined in <linux/mount.h>, but include/lapi/mount.h includes <sys/mount.h> */
-AC_CHECK_TYPES([struct mnt_id_req],,,[#include <sys/mount.h>])
+AC_CHECK_MEMBERS([struct mnt_id_req.mnt_ns_fd],,,[#include <sys/mount.h>])
 AC_CHECK_TYPES([struct statmount],,,[#include <sys/mount.h>])
 AC_CHECK_MEMBERS([struct statmount.mnt_ns_id],,,[#include <unistd.h>
 #include <linux/mount.h>])
diff --git a/include/lapi/mount.h b/include/lapi/mount.h
index 0f7bb5e43..3b296fc9c 100644
--- a/include/lapi/mount.h
+++ b/include/lapi/mount.h
@@ -45,14 +45,18 @@
 # define MS_NOSYMFOLLOW 256
 #endif
 
-#ifndef HAVE_STRUCT_MNT_ID_REQ
-struct mnt_id_req {
+struct mnt_id_req_fallback {
 	uint32_t size;
-	uint32_t spare;
+	uint32_t mnt_ns_fd;
 	uint64_t mnt_id;
 	uint64_t param;
 	uint64_t mnt_ns_id;
 };
+
+#ifndef HAVE_STRUCT_MNT_ID_REQ_MNT_NS_FD
+typedef struct mnt_id_req_fallback mnt_id_req;
+#else
+typedef struct mnt_id_req mnt_id_req;
 #endif
 
 #ifndef HAVE_STRUCT_STATMOUNT
diff --git a/testcases/kernel/syscalls/listmount/listmount.h b/testcases/kernel/syscalls/listmount/listmount.h
index aad927f71..e7ef375d7 100644
--- a/testcases/kernel/syscalls/listmount/listmount.h
+++ b/testcases/kernel/syscalls/listmount/listmount.h
@@ -15,7 +15,7 @@
 static inline ssize_t listmount(uint64_t mnt_id, uint64_t last_mnt_id,
 			 uint64_t list[], size_t num, unsigned int flags)
 {
-	struct mnt_id_req req = {
+	mnt_id_req req = {
 		.size = MNT_ID_REQ_SIZE_VER0,
 		.mnt_id = mnt_id,
 		.param = last_mnt_id,
diff --git a/testcases/kernel/syscalls/listmount/listmount04.c b/testcases/kernel/syscalls/listmount/listmount04.c
index a6921a249..c1f00d99a 100644
--- a/testcases/kernel/syscalls/listmount/listmount04.c
+++ b/testcases/kernel/syscalls/listmount/listmount04.c
@@ -14,14 +14,18 @@
 
 #define _GNU_SOURCE
 
+#include "config.h"
 #include "tst_test.h"
 #include "lapi/mount.h"
 #include "lapi/syscalls.h"
 
 #define MNT_SIZE 32
+#define BEFORE_6_18 1
+#define AFTER_6_18 2
 
-static struct mnt_id_req *request;
+static mnt_id_req *request;
 static uint64_t mnt_ids[MNT_SIZE];
+static int kver;
 
 static struct tcase {
 	int req_usage;
@@ -34,6 +38,7 @@ static struct tcase {
 	uint64_t flags;
 	int exp_errno;
 	char *msg;
+	int kver;
 } tcases[] = {
 	{
 		.req_usage = 0,
@@ -79,6 +84,18 @@ static struct tcase {
 		.nr_mnt_ids = MNT_SIZE,
 		.exp_errno = EINVAL,
 		.msg = "invalid mnt_id_req.spare",
+		.kver = BEFORE_6_18,
+	},
+	{
+		.req_usage = 1,
+		.size = MNT_ID_REQ_SIZE_VER0,
+		.spare = -1,
+		.mnt_id = LSMT_ROOT,
+		.mnt_ids = mnt_ids,
+		.nr_mnt_ids = MNT_SIZE,
+		.exp_errno = EBADF,
+		.msg = "invalid mnt_id_req.mnt_ns_fd",
+		.kver = AFTER_6_18,
 	},
 	{
 		.req_usage = 1,
@@ -113,7 +130,12 @@ static struct tcase {
 static void run(unsigned int n)
 {
 	struct tcase *tc = &tcases[n];
-	struct mnt_id_req *req = NULL;
+	mnt_id_req *req = NULL;
+
+	if (tc->kver && tc->kver != kver) {
+		tst_res(TCONF, "Skip the case that is not suitable for the current kernel version");
+		return;
+	}
 
 	memset(mnt_ids, 0, sizeof(mnt_ids));
 
@@ -122,7 +144,7 @@ static void run(unsigned int n)
 		req->mnt_id = tc->mnt_id;
 		req->param = tc->param;
 		req->size = tc->size;
-		req->spare = tc->spare;
+		req->mnt_ns_fd = tc->spare;
 	}
 
 	TST_EXP_FAIL(tst_syscall(__NR_listmount, req, tc->mnt_ids,
@@ -130,8 +152,17 @@ static void run(unsigned int n)
 		"%s", tc->msg);
 }
 
+static void setup(void)
+{
+	if (tst_kvercmp(6, 18, 0) >= 0)
+		kver = AFTER_6_18;
+	else
+		kver = BEFORE_6_18;
+}
+
 static struct tst_test test = {
 	.test = run,
+	.setup = setup,
 	.tcnt = ARRAY_SIZE(tcases),
 	.min_kver = "6.11",
 	.bufs = (struct tst_buffers []) {
diff --git a/testcases/kernel/syscalls/statmount/statmount.h b/testcases/kernel/syscalls/statmount/statmount.h
index d21d7f8da..4217a82d8 100644
--- a/testcases/kernel/syscalls/statmount/statmount.h
+++ b/testcases/kernel/syscalls/statmount/statmount.h
@@ -16,7 +16,7 @@
 static inline int statmount(uint64_t mnt_id, uint64_t mask, struct statmount *buf,
 		     size_t bufsize, unsigned int flags)
 {
-	struct mnt_id_req req = {
+	mnt_id_req req = {
 		.size = MNT_ID_REQ_SIZE_VER0,
 		.mnt_id = mnt_id,
 		.param = mask,
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
