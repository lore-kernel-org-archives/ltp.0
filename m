Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ACB310BA426
	for <ltp@archiver.kernel.org>; Fri, 27 Mar 2026 04:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774587364; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=3lJNeT9xuxYVSi2FH9VzSN/CNnINOa6M6hA6HFM8YWA=;
 b=XhTYTKOuRHrj5GzZrW601sqTI5aFEZp0Mg0TESv+NuRVJ8YIqkR5u0zlqinAKt82YwtfO
 wITEYxL6KKYcALVdobbZke1xJ5g4krHaItGDpZpcNyruUV0Oh5qB2kApIENtKsiv/wKiKsn
 6a0e/kaR3y/zUlJNz+VEXHOao8NK7GU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EECA53D9F02
	for <ltp@archiver.kernel.org>; Fri, 27 Mar 2026 05:56:03 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C5B1B3C52FE
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 05:55:40 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B47DD2005CA
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 05:55:39 +0100 (CET)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-486fe2024a9so12825495e9.0
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 21:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774587339; x=1775192139; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3V9Ty+TaXHCe7kH6xHjStdsBb2ODUD7bundjScmJWeE=;
 b=RLT6dM+8/X0f/XD6Fb1AyucUJb4TTSkhlCyWTyKxztFpy507jYopeNIpYnIfIm857e
 +U4xUQQgrHWOsf7D9jOTjiSRnLEb6q231Q3Rif4OlkbwwjzZZHEGlKlfyMp3zBQfKXss
 t0UEQjlCp56S5ELedawA3Yvz6a3HxmDdpCi82BAiMrGEo02w6myL3+wmhhAsMOzEKNAk
 /VmnJEKEz7SV6PXjI9bwUuAtj8BxeDlBKy4cHtJXhwHd/ju6k10vgIDmCAJLuzBCKX9W
 4hQm04yS2Xpn1TYA5BStaAkfoJqzTjoXzQGyqL0DsLw0qvBMYeullu5qqAhPZu3V5PBR
 krqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774587339; x=1775192139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3V9Ty+TaXHCe7kH6xHjStdsBb2ODUD7bundjScmJWeE=;
 b=AfRYfYx5SVsIQu/d8Tuo6uQlYf8ekKs4dfKUbWrRZhYmGqAvYTKDUsb0/EiM3c+vaQ
 IeINsSZuVK8RSGASUfeWvm+QTjjnCko7vFEO0gBfgxhfIEtuAGQiMKPjmFaMeF/02iX3
 Ny8GIpvurKc8QeOk9eydjgGCuwJBHoU3yNmC3oA/KH9cMjr3+TsojisW8CBc9bYvBtxQ
 dyXwchPdjaDKavQDn07hj2tCmswNbtjH5hh1RlJ8BQ5unachVvlhG/3d8qqQYnyBI0YN
 gUYqu0LB35t82Bo5LQN3FvZR+xx0ReJ4Q+q8XWs47WSfACz0O6q+pRvFaxiL5XC1g3FC
 71Pg==
X-Gm-Message-State: AOJu0YwfoiOp6zYmDoWMmtKTUPT+Ax2qare/XRUu5BBpOZ1ap38bc1D7
 sIRqbMGlB7HO1V2CW/z+8qnG46o51viwRT7WtNyxm9RLf49qfYM8wHBCuy9TLvMsCRhjLwgdWak
 cR9s=
X-Gm-Gg: ATEYQzz1xZffP3cU74kDMaxbzbY/1P51hpN/70jLMi1Rb4vd9xPrgFapCmz7UEGeMwi
 T6jo4eWmVPidkSmQhqr6dsZF/qPzkuVOIiZaKt0TY4wkNIbkbU14n4fF1rXMydz2/DOnP3IUM0O
 zA3sHSFLWnk+faOaxBlkX82gZLMJ7K0WVLrcWO6rA0YeA79h85Vf3osFP7Rjz33rC3Pspgt053O
 fx/hR8HCP0RJqvGIpKpVW3Ha0mf4hTf6W2EXdvEPLqVPKtSG/XJXKchJRVPZhrFUaD4dIZNwNg7
 Uh2H5aEvfwlo3bMbj2ftyBjd0no6YivZBf3Q0DVVKkyC9A+zw6IJzEnRf+W//KIJD1EkVQi0p/b
 u+5C/inFvr6KQ/zzPsKzigH1W99CpN7oWOrT1qFw1WzWoT2iJR0BTr99C13CAQ1UQbLUfaIAsIl
 OCC3K8bOzHaWs=
X-Received: by 2002:a05:600c:a408:b0:485:9a50:3370 with SMTP id
 5b1f17b1804b1-48727d735a7mr12867165e9.8.1774587338816; 
 Thu, 26 Mar 2026 21:55:38 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-43b919cf1c4sm12597173f8f.23.2026.03.26.21.55.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 21:55:38 -0700 (PDT)
To: ltp@lists.linux.it
Date: Fri, 27 Mar 2026 04:55:27 +0000
Message-ID: <20260327045536.7852-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260326012908.6885-1-wegao@suse.com>
References: <20260326012908.6885-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6] fanotify22.c: handle multiple asynchronous error
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
v5->v6:
- Changed ret from int to ssize_t to correctly match the return type of the read() system call.
- Add Defensive Check ensure read_len has not reached or exceeded BUF_SIZE before calling read().
- Use TERRNO flag to replace manual strerror(errno)

 .../kernel/syscalls/fanotify/fanotify22.c     | 89 ++++++++++++++++++-
 1 file changed, 85 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify22.c b/testcases/kernel/syscalls/fanotify/fanotify22.c
index e8002b160..931f59bed 100644
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
@@ -134,10 +135,53 @@ static struct test_case {
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
+			continue;
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
@@ -248,19 +292,56 @@ static void check_event(char *buf, size_t len, const struct test_case *ex)
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
+		if (read_len >= BUF_SIZE)
+			tst_brk(TBROK, "Event buffer full");
+
+		char *current_pos = event_buf + read_len;
+		ssize_t ret = read(fd_notify, current_pos, BUF_SIZE - read_len);
+
+		if (ret < 0) {
+			tst_brk(TBROK | TERRNO, "%s: read failed", tcase->name);
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
