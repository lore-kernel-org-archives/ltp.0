Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF88D3B7E2
	for <ltp@archiver.kernel.org>; Tue,  9 Dec 2025 00:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1765241003; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=QHi85T1E5mEnGrsGKCxNTHkw24fg+e1Sc5JQeE01Mm8=;
 b=QzgQubutlPl9nhNzVC5Q+l8bGp2ZAqRe/8VyORUHN0pV3deRiq6QxIxi6YaJ4zPMmVrH2
 HLJzcey00YPG2JhfP3ZTN9Q35Tp8DvJX1n4eubSlBHfpypxlESMbwnuo61ZbhwfNXLxEY/+
 wECeH4/7Nn0wp/F+/y8JoGYNRpB17xg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 35FE73CF609
	for <ltp@archiver.kernel.org>; Tue,  9 Dec 2025 01:43:23 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 770F53C9E6B
 for <ltp@lists.linux.it>; Tue,  9 Dec 2025 01:43:01 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7D16E140025C
 for <ltp@lists.linux.it>; Tue,  9 Dec 2025 01:43:00 +0100 (CET)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-47795f6f5c0so32510025e9.1
 for <ltp@lists.linux.it>; Mon, 08 Dec 2025 16:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1765240979; x=1765845779; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rT27HHn3e1bct2jNYInXSQSmYJw3yqB0W1yma4b6i1I=;
 b=aRM0uM39ClYcIGYfS4x8gDFFu+88uEuLo+kiFs/qKlE5NP2lWzKMfYrceAZkHaQV7p
 XG1qexvXBU7fGsVFS6jY2HnAerXqtKJyyLFOCcdDEGreSdB6HTtbGqD3iFRuMwR3Cclk
 BqZSRCnxsCIQFAgSdhLKAbYj33sI6aR60Q2L8tIR15fgIrFmbK5fm52GwAIAYEwhPSWv
 Lqho+hUuDgoWxQ3QReXtLBuWZe6baqXpDz6FVebMLCuwxcOPumACFqt5+RqGGoirRIAj
 T+zsREx8XQtiq1lw5Ew3loJSHODsjlrl9bhezOd5NSLgjtmYWzbsHlsRq9ZkPsoUuOpk
 FB8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765240979; x=1765845779;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rT27HHn3e1bct2jNYInXSQSmYJw3yqB0W1yma4b6i1I=;
 b=tMBOOOth9Y3fl9B4sL1xXuS2T9EffvvjWKmES224e9oTKGvakPbVjCfNUseSfI26Ul
 XAKEaX2HXsh7dS7NTUTL37Gx8axm7VdDIjCJDOvbFzzhOFZBKHLsHs2DlyGit6aL06rh
 0oJN1OZXCeuVOrHZJR1SJ4WWhIKq3MBkIt8csvU1sBDlfMSrKJYE1rxhbiwCZCWcf8VN
 VvK9on8YBwoJXFwEUrYuS2ISfStavzIUtOMq8WOF8JGcozwJWOxiCPO1wnkret06vKvx
 9wWuT2Xo4nXyfkxR2fOvKjHOyT0xfyoGnIP3pPh+v+q6sUOyYsb+HGdLYAOJ4wcplAQa
 IQ0A==
X-Gm-Message-State: AOJu0YzgdtR/M3Ae8clIeEC6O0H5OmtZnUNf1c0sYKmz/ZxeIaKG1yCL
 5fPfnIfVFJjI1xqKy63eU2QrgFBBsmrvA0p76SHQFcnweNEFszLXX1WxgNU0ZSljbk7pX6BOHhI
 9Chk=
X-Gm-Gg: ASbGncuE+LXjaPlTM4ui6XOKvzLamtBMw6rC7q7KXdZmd+IZufMCAcJ/lyZI8dK82z7
 PBpo198VNni7ybz2UeGRxTd4Kq4whl2pj0nmF51M1nUSvu8Hlwfv00hqil7h/z4z7igAG83/kFB
 uhQ+OJQqhMgcbxIEd2gLoagepJBXrL1AjD18gULyI1S9b422kzMmkcMQI94Ny5k6lumu+UucM7e
 7Q/Auq9y7KO31zI4XvHqSO9zKAdMLYJedwQ0dzB0lx4mmlgtaYAjj9aUv3yVjlYDwQDyw6xct/j
 /uut1/GTvdgR3WbrtP1iHuSLYLzFsnMczaCR9SHyBcheY1xTY4PlSiEk3pJF8G4vS71kiwbSzDM
 kvEnhq583rSEomMCtwscy08JrEctTcZLWa8zmBkF4Ev2SreMdl9nfbtmR6KLVKXQcGNbpRuFxrg
 U=
X-Google-Smtp-Source: AGHT+IH8RjXcgvCldgCfnS5vvwKWAeXs4lXElDyWV8/21fM0OeDGcmRcdZ/+Hex+uGA0SDUviP0Hiw==
X-Received: by 2002:a7b:c5cf:0:b0:479:3a89:121e with SMTP id
 5b1f17b1804b1-4793a89125dmr59349935e9.37.1765240979528; 
 Mon, 08 Dec 2025 16:42:59 -0800 (PST)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-47a7d397a2fsm5845635e9.5.2025.12.08.16.42.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Dec 2025 16:42:59 -0800 (PST)
To: ltp@lists.linux.it
Date: Tue,  9 Dec 2025 00:41:37 +0000
Message-ID: <20251209004242.31774-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251127143959.9416-1-wegao@suse.com>
References: <20251127143959.9416-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] listmount04.c: Update case support
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
 configure.ac                                    |  1 +
 .../kernel/syscalls/listmount/listmount04.c     | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

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
index a52bad064..0a198e6a9 100644
--- a/testcases/kernel/syscalls/listmount/listmount04.c
+++ b/testcases/kernel/syscalls/listmount/listmount04.c
@@ -26,7 +26,11 @@ static uint64_t mnt_ids[MNT_SIZE];
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
@@ -73,12 +77,21 @@ static struct tcase {
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
@@ -122,7 +135,11 @@ static void run(unsigned int n)
 		req->mnt_id = tc->mnt_id;
 		req->param = tc->param;
 		req->size = tc->size;
+#ifdef HAVE_STRUCT_MNT_ID_REQ_MNT_NS_FD
+		req->mnt_ns_fd = tc->mnt_ns_fd;
+#else
 		req->spare = tc->spare;
+#endif
 	}
 
 	TST_EXP_FAIL(tst_syscall(__NR_listmount, req, tc->mnt_ids,
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
