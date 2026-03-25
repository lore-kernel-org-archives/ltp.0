Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71CBD106B526
	for <ltp@archiver.kernel.org>; Wed, 25 Mar 2026 12:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774442702; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=aE8cRbAykek8OXRT8zwjJCb1Qld6mrq5HpuS2gB6sTs=;
 b=HFpUPVANIFjTuf1LlKg5jM636OLyBV5TUu9QY+iKpvZfCzB0h1sRYTGs/b1CqgeWcXk44
 MIDe3Ua8Gncynq7tibxzFVsCESpknCTu1HaNicVNYaC5phGajQ7SYen5D/lMFkjjLKzeKme
 dkv0p1Z1bwDf3VciCXcg5dbhMP8U7nc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D09593E2FFF
	for <ltp@archiver.kernel.org>; Wed, 25 Mar 2026 13:45:02 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C0ADE3E2245
 for <ltp@lists.linux.it>; Wed, 25 Mar 2026 13:44:38 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B7EEC1400968
 for <ltp@lists.linux.it>; Wed, 25 Mar 2026 13:44:32 +0100 (CET)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-48541edecf9so21606095e9.1
 for <ltp@lists.linux.it>; Wed, 25 Mar 2026 05:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774442672; x=1775047472; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pi3nTzIItIxRnRlBJGYfsacbcryq1u5p5Qwn4ZnHTa0=;
 b=YUe3zhqGsubd3YwSwRu8J/yyXLeU40PMzg6BJIA2Vw07pcirEyVNFnfNUK49jUNtyB
 nYBtgCwSMid4rntFoY85g/K3f8JnNxJdR27RrBbEnevUCNtduj2T5/zV6nqvekmeXyGH
 oh+VThu1PorwUiDgI9Av8KGv1WY6MG+cz/iC8WqHjh3cs2I6W1i3msF9pRP/jB4SXqEZ
 vliPWxOoLbQT7fkP71NlVUSFfQbW5+/O9uWQAJvqE9EnUZx4IQjPBfQRAYPDFp+Y1z2L
 mPAzgdLUK5mEaryOr+cL/Rzf9GsscwG9U/EQ8tAYFOGi4TdY5uOllQvNcWZy432KyGC6
 A29g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774442672; x=1775047472;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pi3nTzIItIxRnRlBJGYfsacbcryq1u5p5Qwn4ZnHTa0=;
 b=DTJ92fycABDKpCmQApns2DMMH6YAZ+kvmvYiN1zrVoD5tzuYns/6i7f7drnumzK4so
 2LIAolJ6iGotLApPaffX0rvAK9KlwXukoU52lYgwuAzNFStasf1Hzsnl9BqCuP2IY8Na
 gU6EjpsCkK1gz0lCr20JsamG6HnGLO4CtmmEqVT6UoEWn++Y0gnBzg4uwOHzsAAqoou0
 INqI8mw/tFOHl5Czaat5kF9Jzsx43PuXhZOOJpwSEgXLq8k661jx3bqzkgSOyYUreXU3
 NLgUpbVcY4Pw8WQ2M9BnewQK+TNIm1VVImyom1I/fGbid97jAS2favvHmu3eIVUT97xM
 mYFQ==
X-Gm-Message-State: AOJu0Yw8/LMxhQqM45dwhcm1NoRH3EjpLpNqRat2SxYiVJZr6nS03Cd9
 wZcNj/qVZHD+KYj0BDFSn9OUpmtHDq7ypTPkgwueV32aOMdRXBAy+4FT1GGErPyxWrX3Abpos6G
 /QwM=
X-Gm-Gg: ATEYQzwhAqO8/R0PzdJXSptQMr29YinQVLlQBonLpnOlSh88V3T05ww1B//UpyJB1NS
 giSr8hMfVw7WgcdfwMolz7G0DdJIajaq62sY0Iz3Jdr0l7bboqP9WdV8Nue6cnzI/nGdnztcbbL
 CfTBeHJj6AIdPO5hM5J9ig7aEqomTjzUar6Uo/bRWTy+Bni8kCI35JaHtB5VzuihTLxbOhl2DDx
 rXre4xmQUzjvIwHP2o2aViulfSbnBMmXIB3RCDZzET3z6go2sGzAWTqkuSP/ylI5sPt6iTst1jV
 3jyThbSqs3Khe+z0DgbSCEGX+rx+1LmfTT395ovJtOlfbReG9dEZyldmT3qw2Ok8dpiVgJl/SJd
 xCcYvwoA3BoOknOcroaBY+e/Aca/v828EhVhV5vyPOAOPGIyKt5/0UvL1OixE/rd/mhHVMaDFpR
 mVoxcA4BetYtM=
X-Received: by 2002:a05:600c:190e:b0:483:7903:c3b1 with SMTP id
 5b1f17b1804b1-4871604c856mr50378265e9.20.1774442671708; 
 Wed, 25 Mar 2026 05:44:31 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-48716658352sm20364495e9.13.2026.03.25.05.44.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 05:44:31 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed, 25 Mar 2026 12:43:57 +0000
Message-ID: <20260325124428.6497-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260318064630.1604-1-wegao@suse.com>
References: <20260318064630.1604-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] fanotify22.c: handle multiple asynchronous error
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: Jan Kara <jack@suse.cz>, kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Since the introduction of the asynchronous fserror reporting framework
(kernel commit 81d2e13a57c9), fanotify22 has encountered sporadic failures
due to the non-deterministic nature of event delivery and merging:

1) tcase3 failure: A race condition occurs when the test reads the
   notification fd between two events. uses a poll() and read() loop to wait
   until the expected.

2) tcase4 failure: The kernel may deliver errors as independent events
   instead of a single merged event, since different worker kthread can
   end up generating each event so they won't be merged. As suggested by
   Jan Kara, this patch introduces a consolidate_events() helper. It iterates
   through the event buffer, accumulates the error_count from all independent
   events, and updates the first event's count in-place.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202602042124.87bd00e3-lkp@intel.com
Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Wei Gao <wegao@suse.com>
---
v3->v4:
1)Fixed read_len logic by using m->event_len inside the loop to avoid overcounting.
2)Removed redundant if (info) check in consolidate_events.

 .../kernel/syscalls/fanotify/fanotify22.c     | 86 ++++++++++++++++++-
 1 file changed, 82 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify22.c b/testcases/kernel/syscalls/fanotify/fanotify22.c
index e8002b160..e79213b40 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify22.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify22.c
@@ -28,6 +28,7 @@
 #include "tst_test.h"
 #include <sys/fanotify.h>
 #include <sys/types.h>
+#include <poll.h>
 
 #ifdef HAVE_SYS_FANOTIFY_H
 #include "fanotify.h"
@@ -88,7 +89,6 @@ static void trigger_bad_link_lookup(void)
 			ret, BAD_LINK, errno, EUCLEAN);
 }
 
-
 static void tcase3_trigger(void)
 {
 	trigger_bad_link_lookup();
@@ -104,6 +104,7 @@ static void tcase4_trigger(void)
 static struct test_case {
 	char *name;
 	int error;
+	int error2;
 	unsigned int error_count;
 	struct fanotify_fid_t *fid;
 	void (*trigger_error)(void);
@@ -134,10 +135,52 @@ static struct test_case {
 		.trigger_error = &tcase4_trigger,
 		.error_count = 2,
 		.error = EFSCORRUPTED,
+		.error2 = ESHUTDOWN,
 		.fid = &bad_file_fid,
 	}
 };
 
+static size_t consolidate_events(char *buf, size_t len, const struct test_case *ex)
+{
+	struct fanotify_event_metadata *metadata, *first = NULL;
+	struct fanotify_event_info_error *first_info = NULL;
+	unsigned int total_count = 0;
+	int event_num = 0;
+
+	for (metadata = (struct fanotify_event_metadata *)buf;
+			FAN_EVENT_OK(metadata, len);
+			metadata = FAN_EVENT_NEXT(metadata, len)) {
+
+		event_num++;
+		struct fanotify_event_info_error *info = get_event_info_error(metadata);
+
+		if (!info) {
+			tst_res(TFAIL, "%s: Event [%d] missing error info",
+					ex->name, event_num);
+			continue;
+		}
+
+		if (info->error != ex->error && (ex->error2 == 0 || info->error != ex->error2)) {
+			tst_res(TFAIL, "%s: Event [%d] unexpected errno (%d)",
+					ex->name, event_num, info->error);
+		}
+
+		if (!first) {
+			first = metadata;
+			first_info = info;
+		}
+		total_count += info->error_count;
+
+		tst_res(TINFO, "Event [%d]: errno=%d, error_count=%d",
+				event_num, info->error, info->error_count);
+	}
+
+	if (first_info)
+		first_info->error_count = total_count;
+
+	return (first) ? first->event_len : 0;
+}
+
 static int check_error_event_info_fid(struct fanotify_event_info_fid *fid,
 				 const struct test_case *ex)
 {
@@ -248,19 +291,54 @@ static void check_event(char *buf, size_t len, const struct test_case *ex)
 static void do_test(unsigned int i)
 {
 	const struct test_case *tcase = &testcases[i];
-	size_t read_len;
+	size_t read_len = 0;
+	struct pollfd pfd;
+	unsigned int accumulated_count = 0;
 
 	SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_ADD|FAN_MARK_FILESYSTEM,
 			   FAN_FS_ERROR, AT_FDCWD, MOUNT_PATH);
 
 	tcase->trigger_error();
 
-	read_len = SAFE_READ(0, fd_notify, event_buf, BUF_SIZE);
+	pfd.fd = fd_notify;
+	pfd.events = POLLIN;
+
+	while (accumulated_count < tcase->error_count) {
+		if (poll(&pfd, 1, 5000) <= 0) {
+			tst_res(TFAIL, "%s: Timeout waiting for events", tcase->name);
+			goto out;
+		}
+
+		char *current_pos = event_buf + read_len;
+		int ret = read(fd_notify, current_pos, BUF_SIZE - read_len);
+
+		if (ret < 0) {
+			tst_res(TFAIL, "%s: read failed: %s", tcase->name, strerror(errno));
+			goto out;
+		}
+
+		struct fanotify_event_metadata *m =
+			(struct fanotify_event_metadata *)current_pos;
+		while (FAN_EVENT_OK(m, ret)) {
+			struct fanotify_event_info_error *e = get_event_info_error(m);
+
+			if (e)
+				accumulated_count += e->error_count;
+
+			read_len += m->event_len;
+			m = FAN_EVENT_NEXT(m, ret);
+		}
+	}
+
+	read_len = consolidate_events(event_buf, read_len, tcase);
+
+	check_event(event_buf, read_len, tcase);
+
+out:
 
 	SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_REMOVE|FAN_MARK_FILESYSTEM,
 			   FAN_FS_ERROR, AT_FDCWD, MOUNT_PATH);
 
-	check_event(event_buf, read_len, tcase);
 	/* Unmount and mount the filesystem to get it out of the error state */
 	SAFE_UMOUNT(MOUNT_PATH);
 	SAFE_MOUNT(tst_device->dev, MOUNT_PATH, tst_device->fs_type, 0, NULL);
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
