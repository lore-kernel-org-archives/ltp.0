Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5157ED49206
	for <ltp@archiver.kernel.org>; Fri, 12 Dec 2025 11:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1765540399; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=LsLYbw0UyRDuJb13QeegwC0UH+EiNDbbDNjyOuhqjnM=;
 b=MQM5kFyY2LTJhSHgJfT86r1H8MxOU0Tlm4+lzE3em4Io2Adq51sFijHyhTYWLAwAueUX0
 j7BPzW8UJ7Zc7zDRLVCP+yVdVWhW919Spqa2y9wFRSA1bmDfI0b0Bh0CSQW9KS+HZejQi8J
 4JNGfkM5ilPcS8YTDejM+XP7UaFnq4Q=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CC03C3C84CC
	for <ltp@archiver.kernel.org>; Fri, 12 Dec 2025 12:53:19 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A1C673C5373
 for <ltp@lists.linux.it>; Fri, 12 Dec 2025 12:52:57 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9D0986005DD
 for <ltp@lists.linux.it>; Fri, 12 Dec 2025 12:52:56 +0100 (CET)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4779adb38d3so9607605e9.2
 for <ltp@lists.linux.it>; Fri, 12 Dec 2025 03:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1765540376; x=1766145176; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rUTGb8/xxcGUN29/VMOr2gSs+VlegnBGhFQUERJ6GmY=;
 b=hHKfkIWwFyQWOXeRP4pKjJAuEVkRNcVj0X2JG16xBj/YkkfyADiGui1izBAicSdxo1
 HanajMj16cJsv2aeJu1fMfo7UN7nxBzl4VFHl2OImWpZMnq4OmNdA1LwIRH1dNjsMl6H
 G3MNLuUXLABCBSnCqVFeRhAyO9QE15v4l280EC1xDZfAPNya802mc1ORB9IDrXU47izV
 /RcyUVAdYyon2PbURE3R6inwXu86ayIrMYqw82QHpot8PXOQVbfK31ZUCJ+VL3NeUh1l
 Vv6zkV1jBSLGFGqIuIkuIzL95GvflbV+Gqa7Def6SHE18JHy6wiEhaWIGZzTMwpsZQQ3
 4jUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765540376; x=1766145176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rUTGb8/xxcGUN29/VMOr2gSs+VlegnBGhFQUERJ6GmY=;
 b=CAiCnpoutsEpNmbfyxXivkOkQtzKXPlR9VM5qEUxdG81r8OwmABe8B0W4TMdBHrddn
 MTfUARz8ht64p2Nr3STYE/MtEriJdX9plO2BYZKEF4Y/XHK25w3IsuOfbsERQ6BdhOo5
 Xm9+AZf3k1zuwng25MeFSIT8vUTgzGlk3KOigRU6KtUwft/GXRaacEeXFVBWWpbQ8mnJ
 j4yApBGKn3/bBPk/f/NuX7bAel5hc5YuRBk28kZQE7wreCrjX4O4Wam7b48wWq2n8ynA
 pf1SdwCKed10enXbWdt6Jet9Ue4HvCvEW8MwCgfnlUjx3J1rJUB/uaMg0yMN9Tc1bKF3
 p+/g==
X-Gm-Message-State: AOJu0Yy21dy0NADc6JYsNwoOeDYKLx4xSNERoMVDxKbM6jXKaTu7R1Qv
 d4bek5fOG5XNeRqQd2tTlA4kWhCo4KUsZdccjeOlnoxpIMMsUesl9UhO5VuDyReS8kDpSCf2T9f
 ANdk=
X-Gm-Gg: AY/fxX76slIwdPKtH8uA0UcnBKdpWH6+QvuKN5sxMryA1F+1GqLIziA6y+zkrZRDkWp
 Whd4tqqohwm9vrCPYkkevEISlwQbW562ZGiuaedBxUOSi2gPmw9q6ns8zvoKV4W3GzT4GKPd8NU
 paeM8L+S7WW7noqQcvtMPSDZlHrrX1GmDgcR9xvkQDGKGJElpUUPjvTsEUB5OOTCDbXCNVD772o
 clL/vgCsZoq2bvvmJVt7QAzEUBL9gKcWbvn8HGQ0w+yN+p7Lr23vXZP0tdhtPPIBU9hSMPrOfpu
 yODqjCKSouIifjB6k2mzemTBqONIxOKonsPM6eK9LQMDDlsN5FvqEGH/1ISsCX+KZdzpO1j9PSO
 p9N8Rd220ZJROwgzWH4U2gDWemPIbH3lRFfa33U8IAgkwnelW/bvDvMFrIPUP9oPuoU743/t5oU
 o=
X-Google-Smtp-Source: AGHT+IEiBI4nbEOxh/NBiWJBXze737X4c/wuhg5yZ719A+9LHAO23V9QzrVUgoo1l85lgXMJ9JhotQ==
X-Received: by 2002:a05:600d:6443:10b0:477:7b30:a6fc with SMTP id
 5b1f17b1804b1-47a8f90f371mr15330135e9.30.1765540375700; 
 Fri, 12 Dec 2025 03:52:55 -0800 (PST)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-47a8f38a455sm27867695e9.1.2025.12.12.03.52.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Dec 2025 03:52:55 -0800 (PST)
To: ltp@lists.linux.it
Date: Fri, 12 Dec 2025 11:50:47 +0000
Message-ID: <20251212115244.2027-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251211015915.1086-1-wegao@suse.com>
References: <20251211015915.1086-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5] listmount04.c: Update case support
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
 configure.ac                                     |  1 +
 include/lapi/mount.h                             | 10 +++++++---
 .../kernel/syscalls/listmount/listmount04.c      | 16 +++++++++++++---
 3 files changed, 21 insertions(+), 6 deletions(-)

v4->v5: Update base solution of Cyril

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
diff --git a/include/lapi/mount.h b/include/lapi/mount.h
index 0f7bb5e43..7b1c4ca0f 100644
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
+#if !defined(HAVE_STRUCT_MNT_ID_REQ) || !HAVE_STRUCT_MNT_ID_REQ_MNT_NS_FD
+typedef struct mnt_id_req_fallback mnt_id_req;
+#else
+typedef struct mnt_id_req mnt_id_req;
 #endif
 
 #ifndef HAVE_STRUCT_STATMOUNT
diff --git a/testcases/kernel/syscalls/listmount/listmount04.c b/testcases/kernel/syscalls/listmount/listmount04.c
index a6921a249..955f98e20 100644
--- a/testcases/kernel/syscalls/listmount/listmount04.c
+++ b/testcases/kernel/syscalls/listmount/listmount04.c
@@ -14,13 +14,14 @@
 
 #define _GNU_SOURCE
 
+#include "config.h"
 #include "tst_test.h"
 #include "lapi/mount.h"
 #include "lapi/syscalls.h"
 
 #define MNT_SIZE 32
 
-static struct mnt_id_req *request;
+static mnt_id_req *request;
 static uint64_t mnt_ids[MNT_SIZE];
 
 static struct tcase {
@@ -113,7 +114,7 @@ static struct tcase {
 static void run(unsigned int n)
 {
 	struct tcase *tc = &tcases[n];
-	struct mnt_id_req *req = NULL;
+	mnt_id_req *req = NULL;
 
 	memset(mnt_ids, 0, sizeof(mnt_ids));
 
@@ -122,7 +123,7 @@ static void run(unsigned int n)
 		req->mnt_id = tc->mnt_id;
 		req->param = tc->param;
 		req->size = tc->size;
-		req->spare = tc->spare;
+		req->mnt_ns_fd = tc->spare;
 	}
 
 	TST_EXP_FAIL(tst_syscall(__NR_listmount, req, tc->mnt_ids,
@@ -130,8 +131,17 @@ static void run(unsigned int n)
 		"%s", tc->msg);
 }
 
+static void setup(void)
+{
+	if (tst_kvercmp(6, 18, 0) >= 0) {
+		tcases[4].exp_errno = EBADF;
+		tcases[4].msg = "invalid mnt_id_req.mnt_ns_fd (EBADF)";
+	}
+}
+
 static struct tst_test test = {
 	.test = run,
+	.setup = setup,
 	.tcnt = ARRAY_SIZE(tcases),
 	.min_kver = "6.11",
 	.bufs = (struct tst_buffers []) {
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
