Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 678ACC35FFA
	for <ltp@archiver.kernel.org>; Wed, 19 Mar 2025 19:28:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E7E8D3CAE09
	for <ltp@archiver.kernel.org>; Wed, 19 Mar 2025 20:28:46 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 753F63CADE3
 for <ltp@lists.linux.it>; Wed, 19 Mar 2025 20:27:50 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D5CE3600780
 for <ltp@lists.linux.it>; Wed, 19 Mar 2025 20:27:49 +0100 (CET)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43948f77f1aso70945e9.0
 for <ltp@lists.linux.it>; Wed, 19 Mar 2025 12:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742412469; x=1743017269; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mblE+Ft2ih1erCT0PqX5nmbhW/CX00wyEKVw2ovi+Xk=;
 b=kG42i2GI64sPtIrj5HkxdzU1ZIbhrfOiTAA48PxUzjBpFV4QmhbnRJpKCA2H3APoHp
 Uohp6QeXiiOgYZtRp/amXVr4LpTgzZcKDqt+w0lfdw9F8BF/4IQocMIRvOWJDNtVP2HN
 IRPT3O6Gul67EN0Ykc9vyBzXP838Lal5UfxK8TvcWozRspoQVHI1Ihsfqr6GGtnXfXS1
 xyJUw3zz0d7mOHtbiU7ub3sQ+IzZ1n+Am/9yZyfa/FM+4UR0U8Uiud1z+Ol4o/ywczsj
 GbY/XQFN1/XQO3QNnbxaQc+xJ2ubVc+JaF0D5Pg8iXoVN1yJFHnp7mMPg2BCa/Dx7PZv
 P2OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742412469; x=1743017269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mblE+Ft2ih1erCT0PqX5nmbhW/CX00wyEKVw2ovi+Xk=;
 b=w4GO8S5jBrFLwgGYl3j2s2p0DcKQsvSe5w3uv1n1vZCkdUOcpE3E4d/5f9+CfPV7Kc
 BNYwC7sdrVlrzkq4CyyWvtDF/rWysCTJly9eafFZKNA1jkJn2sKZS3WiWuhK2N+HRACH
 McPqqm+oUgWj/dXjhWrhAO3nX1R/F0duBG+ZMn0m1tSCKHgbpsKFCeBrlEcQc+IRGvEC
 rzQiuLbzm8olhKNMcNI8f4hck+6jUl1aKRp22xC/5QmH36Fmuanr+V9+vhvYWUiqPWx+
 qCgyzhbnoVfpxji5xq/Scasais20axYe97c+dbgK13VMlvk9uyuqhArmXKN5xf7Anbhj
 DGiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1tnATXuhX4rf9PIdWhQcczt6xIAQakAHp9Fv/SIJRkbTsOgR8ZrHzVfGOTJY/AnLoemw=@lists.linux.it
X-Gm-Message-State: AOJu0Ywii+FM2J3VGAeieZjnXqJhD3eCeXw81edA2Y9M/RzdFZIylWfc
 3D5mecj9KmE4QBrouFZqiR25/PkaAkFU9w0eTSVe91TWt/JVdcnPGHe9Nm/R
X-Gm-Gg: ASbGncsxZrKKa6cSb8il+jnxZtvmFAj6ZNJsVrDb+40E/XTiniY7QLrdjtZckyfWAC1
 n1/4+rdJw5ygn50QJmqhoCOfORrheTEVThLTfLwIv9tZYYkuf50VPXPHJJwhVEPTkOZ2WhBU4mP
 V9aqTE8zh345bNRtkZw2NSb/QhStdc6YyEXJdPdsSaZcDjLpDnMQriSjFDPnuJbYQQuPUgH+4ha
 aUTQXgn+IiIBYEretvAFeWwaArNdn+Pqmfo8I6DX3sP8uta56QjuZQF38H2ZbnW5KeiZJkBj6Fu
 piv3lSE+u0bvXRlFp3jfz+6gc7oZqkOyWk+3+tZ8p1X1jJTLdFXWR1pYRMm9ZQQ4YZW84LWW4rn
 +V53Byo44WptaFYZ5/fLUt57sI/XvBIbxKD+GWtsJtA==
X-Google-Smtp-Source: AGHT+IGZw4YVcA/0hEKgzEse75LUjp3gQH9XSbRa3jtbEWB/2REgVy8LBoaTbjxGNQvnTnyNOF9TdA==
X-Received: by 2002:a05:600c:1ca1:b0:43c:ea1a:720a with SMTP id
 5b1f17b1804b1-43d46b5a82fmr20156515e9.1.1742412468865; 
 Wed, 19 Mar 2025 12:27:48 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl
 (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d4453225bsm26531585e9.7.2025.03.19.12.27.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 12:27:48 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Wed, 19 Mar 2025 20:27:41 +0100
Message-Id: <20250319192742.999506-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250319192742.999506-1-amir73il@gmail.com>
References: <20250319192742.999506-1-amir73il@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/3] fanotify24: print range info for pre-content
 events
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

range info is expected only for pre-content events

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 configure.ac                                   |  3 ++-
 include/lapi/fanotify.h                        | 12 ++++++++++++
 .../kernel/syscalls/fanotify/fanotify24.c      | 18 ++++++++++++++++++
 3 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 344b2ae2c..9b9883eac 100644
--- a/configure.ac
+++ b/configure.ac
@@ -179,7 +179,8 @@ AC_CHECK_TYPES([enum kcmp_type],,,[#include <linux/kcmp.h>])
 AC_CHECK_TYPES([struct acct_v3],,,[#include <sys/acct.h>])
 AC_CHECK_TYPES([struct af_alg_iv, struct sockaddr_alg],,,[# include <linux/if_alg.h>])
 AC_CHECK_TYPES([struct fanotify_event_info_fid, struct fanotify_event_info_error,
-		struct fanotify_event_info_header, struct fanotify_event_info_pidfd],,,[#include <sys/fanotify.h>])
+		struct fanotify_event_info_header, struct fanotify_event_info_pidfd,
+		struct fanotify_event_info_range],,,[#include <sys/fanotify.h>])
 AC_CHECK_TYPES([struct file_clone_range],,,[#include <linux/fs.h>])
 AC_CHECK_TYPES([struct file_dedupe_range],,,[#include <linux/fs.h>])
 
diff --git a/include/lapi/fanotify.h b/include/lapi/fanotify.h
index 9076685e8..76907ea5f 100644
--- a/include/lapi/fanotify.h
+++ b/include/lapi/fanotify.h
@@ -178,6 +178,9 @@ typedef struct {
 #ifndef FAN_EVENT_INFO_TYPE_ERROR
 #define FAN_EVENT_INFO_TYPE_ERROR	5
 #endif
+#ifndef FAN_EVENT_INFO_TYPE_RANGE
+#define FAN_EVENT_INFO_TYPE_RANGE	6
+#endif
 
 #ifndef FAN_EVENT_INFO_TYPE_OLD_DFID_NAME
 #define FAN_EVENT_INFO_TYPE_OLD_DFID_NAME	10
@@ -217,6 +220,15 @@ struct fanotify_event_info_error {
 };
 #endif /* HAVE_STRUCT_FANOTIFY_EVENT_INFO_ERROR */
 
+#ifndef HAVE_STRUCT_FANOTIFY_EVENT_INFO_RANGE
+struct fanotify_event_info_range {
+	struct fanotify_event_info_header hdr;
+	__u32 pad;
+	__u64 offset;
+	__u64 count;
+};
+#endif /* HAVE_STRUCT_FANOTIFY_EVENT_INFO_RANGE */
+
 /* NOTE: only for struct fanotify_event_info_fid */
 #ifdef HAVE_STRUCT_FANOTIFY_EVENT_INFO_FID_FSID___VAL
 # define FSID_VAL_MEMBER(fsid, i) (fsid.__val[i])
diff --git a/testcases/kernel/syscalls/fanotify/fanotify24.c b/testcases/kernel/syscalls/fanotify/fanotify24.c
index 539f74137..2d2479b39 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify24.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify24.c
@@ -339,6 +339,7 @@ static void test_fanotify(unsigned int n)
 	 */
 	while (test_num < EVENT_SET_MAX && fd_notify != -1) {
 		struct fanotify_event_metadata *event;
+		struct fanotify_event_info_range *range;
 
 		if (i == len) {
 			/* Get more events */
@@ -367,6 +368,7 @@ static void test_fanotify(unsigned int n)
 			test_num--;
 
 		event = (struct fanotify_event_metadata *)&event_buf[i];
+		range = (struct fanotify_event_info_range *)(event + 1);
 		/* Permission events cannot be merged, so the event mask
 		 * reported should exactly match the event mask within the
 		 * event set.
@@ -386,6 +388,22 @@ static void test_fanotify(unsigned int n)
 				(unsigned int)event->pid,
 				(unsigned int)child_pid,
 				event->fd);
+		} else if (event->mask & LTP_PRE_CONTENT_EVENTS) {
+			if (range->hdr.info_type != FAN_EVENT_INFO_TYPE_RANGE) {
+				tst_res(TFAIL,
+					"got event: mask=%llx pid=%u fd=%d "
+					"(expected range info)",
+					(unsigned long long)event->mask,
+					(unsigned int)event->pid,
+					event->fd);
+			} else {
+				tst_res(TPASS,
+					"got event: mask=%llx pid=%u fd=%d "
+					"offset=%llu count=%llu",
+					(unsigned long long)event->mask,
+					(unsigned int)event->pid, event->fd,
+					range->offset, range->count);
+			}
 		} else {
 			tst_res(TPASS,
 				"got event: mask=%llx pid=%u fd=%d",
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
