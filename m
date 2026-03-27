Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADF7C10ED66D
	for <ltp@archiver.kernel.org>; Fri, 27 Mar 2026 12:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774614905; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=dd1y5tZ5C495h+Zr0Ndphv2qOTvkFi5JldzqhPFBrcg=;
 b=NHcVoEa/Rh4HZrs7f0p6/qn4thfdcaScKewptkoH+c4M9Ggmc9R8qGzTaYc/ND5+ZhDeK
 1cmKg0zhs1d4vFriAw6IvvYL2EhnMxZ6/Q3aBaxZwzIOygoM7zKMHRFv0Rtbjx8N+GIvDlq
 VvfJyzhfIkt+wBtSchm+6laLyVfU/50=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 356FE3CFB21
	for <ltp@archiver.kernel.org>; Fri, 27 Mar 2026 13:35:05 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0283C3CFAA2
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 13:34:40 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 95D851400C6C
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 13:34:39 +0100 (CET)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-439af7d77f0so1635484f8f.0
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 05:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774614879; x=1775219679; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rNRrgE1tER98BINclEGxXEvwAF0gwMjJpQQAriYGo2c=;
 b=AYCzSFxIVplE+tkJT/4K4ws6HdULiV2zwbH33MCTkzS4mXqL6N64RQwEV8KkQ/oPQa
 U5FqvzmVEkN1MMEWDnPcncMhAEAaK0hu1aivGA3cdustk4OVNMERxy33jnsJHmLvn/Ru
 z6fuw+EjZwOqMSgNASfcUyxLdieDzmWVj8cZ6RAtLFn+YT2Adsd+VA/97ZXafZvt5LkV
 36Iz55Xr9+T5g8o8gohX5dh7YCeHmY2jb1eCB9FEnIkW4MWUpJrgt4d9LPs5xEE3YQ7Y
 GfeVuWgw7YCwVT6i7ikVJbmvFuV1B+yIbVqFteCoCDXXUKyYhKh/JWYJlhMX+ZYrcPVw
 sKhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774614879; x=1775219679;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rNRrgE1tER98BINclEGxXEvwAF0gwMjJpQQAriYGo2c=;
 b=d5AJppPssAg6eGoFNV3pyCh7J0w8atqkItcM5Q4C9krH8LmbvjAfOfXwUVovTAjQuo
 SfYTHxinlBr5caqr1akABKHpd3wGqhL0hPaVTwDGZUAB3wugofPx3mUuSkXcFlgIOItE
 T1EzNMdl+FW/h3usxD8rKS5SVFqKi9ebAKhkk9XrnBIEfNyjKn2EUMQqh3prZkHnQhJ8
 QIN6Gbhq85mwjM55AyL7hlmDHfS6HXZJxe+85uvyba7aac9PdMsHgvXHj2yZrRoz2ZOp
 KhdBmXs+HjyZCSxbQG/uPlGoGiQ7t/oN7U9inG5RodMfA1djuvnx2cqOXkDuDLd4Jbu3
 9Uog==
X-Gm-Message-State: AOJu0YzmucvTpW+p+HQT36gMG7pZ3xZYfJj2CCdVbdBVp5xPyoTDOTbL
 GXdtGrd3nbbtHBn4czvKMU+e5EoJWOjm7mQM8mQ9ae5vvL14LCQcf00jytSXAbnl0S4xAAJUVal
 X06k=
X-Gm-Gg: ATEYQzwFRh2Yh87F+SqbgBnhdXeXqaVd+cqqJFlifz7LOoeeCbU8K7DwXVDpwwAin9I
 OESSXHYX17gD/XKuFSLfRQ50t4PVIFY5B2g6GJE5Toi7WfMHDEaVNjM5Dyxz1iN27Nck7dXyvWw
 LCe1RBiIBzzMfYOWxIMIfulGV/cMlxVgxKhletZQSUlWr4J1gEUdk+ceKUcdDxdcmMmCUjWWycJ
 wh3EjIIbKeDbc4iOi5vqaNHspueZiq/sKhBV/mIZ0iNRnOmGr13NDJ5az2RA7Q4vrbWMUVjBCae
 AmHyPiNz83RVknahFhLlkHKBXslOpGkVCVp/Zx88n0v453tDU2+TY3orj/FGNA26OB7CrGuReBL
 bsttP+Rqd+NKW+KAopNl/Z4eaa7AzcoJ2JrG1cIAb6mstdmPiz8wgBwQe1yT08BPAgbrs6mc7eX
 tO7UTuWEWkrHg=
X-Received: by 2002:a05:6000:1a85:b0:43b:3d44:6624 with SMTP id
 ffacd0b85a97d-43b9e987decmr3906320f8f.2.1774614878567; 
 Fri, 27 Mar 2026 05:34:38 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-43b9192e3f9sm15746574f8f.7.2026.03.27.05.34.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 05:34:38 -0700 (PDT)
To: ltp@lists.linux.it
Date: Fri, 27 Mar 2026 12:33:04 +0000
Message-ID: <20260327123436.8195-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327045536.7852-1-wegao@suse.com>
References: <20260327045536.7852-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7] fanotify22.c: handle multiple asynchronous error
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
   notification fd between two events. Use a poll() and read() loop to wait
   until the expected event.

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
v6 -> v7:
- Replaced read() with SAFE_READ().
- Added TINFO message at the start of do_test().
- Removed redundant test case names from error messages.
- Improved buffer overflow check in do_test().

 .../kernel/syscalls/fanotify/fanotify22.c     | 110 +++++++++++++++---
 1 file changed, 94 insertions(+), 16 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify22.c b/testcases/kernel/syscalls/fanotify/fanotify22.c
index e8002b160..9a555c247 100644
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
@@ -134,37 +135,79 @@ static struct test_case {
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
+			tst_res(TFAIL, "Event [%d] missing error info", event_num);
+			continue;
+		}
+
+		if (info->error != ex->error && (ex->error2 == 0 || info->error != ex->error2)) {
+			tst_res(TFAIL, "Event [%d] unexpected errno (%d)",
+					event_num, info->error);
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
 	struct file_handle *fh = (struct file_handle *) &fid->handle;
 
 	if (memcmp(&fid->fsid, &ex->fid->fsid, sizeof(fid->fsid))) {
-		tst_res(TFAIL, "%s: Received bad FSID type (%x...!=%x...)",
-			ex->name, FSID_VAL_MEMBER(fid->fsid, 0),
+		tst_res(TFAIL, "Received bad FSID type (%x...!=%x...)",
+			FSID_VAL_MEMBER(fid->fsid, 0),
 			ex->fid->fsid.val[0]);
 
 		return 1;
 	}
 	if (fh->handle_type != ex->fid->handle.handle_type) {
-		tst_res(TFAIL, "%s: Received bad file_handle type (%d!=%d)",
-			ex->name, fh->handle_type, ex->fid->handle.handle_type);
+		tst_res(TFAIL, "Received bad file_handle type (%d!=%d)",
+			fh->handle_type, ex->fid->handle.handle_type);
 		return 1;
 	}
 
 	if (fh->handle_bytes != ex->fid->handle.handle_bytes) {
-		tst_res(TFAIL, "%s: Received bad file_handle len (%d!=%d)",
-			ex->name, fh->handle_bytes, ex->fid->handle.handle_bytes);
+		tst_res(TFAIL, "Received bad file_handle len (%d!=%d)",
+			fh->handle_bytes, ex->fid->handle.handle_bytes);
 		return 1;
 	}
 
 	if (memcmp(fh->f_handle, ex->fid->handle.f_handle, fh->handle_bytes)) {
-		tst_res(TFAIL, "%s: Received wrong handle. "
-			"Expected (%x...) got (%x...) ", ex->name,
+		tst_res(TFAIL, "Received wrong handle. "
+			"Expected (%x...) got (%x...) ",
 			*(int *)ex->fid->handle.f_handle, *(int *)fh->f_handle);
 		return 1;
 	}
@@ -177,14 +220,14 @@ static int check_error_event_info_error(struct fanotify_event_info_error *info_e
 	int fail = 0;
 
 	if (info_error->error_count != ex->error_count) {
-		tst_res(TFAIL, "%s: Unexpected error_count (%d!=%d)",
-			ex->name, info_error->error_count, ex->error_count);
+		tst_res(TFAIL, "Unexpected error_count (%d!=%d)",
+			info_error->error_count, ex->error_count);
 		fail++;
 	}
 
 	if (info_error->error != ex->error) {
-		tst_res(TFAIL, "%s: Unexpected error code value (%d!=%d)",
-			ex->name, info_error->error, ex->error);
+		tst_res(TFAIL, "Unexpected error code value (%d!=%d)",
+			info_error->error, ex->error);
 		fail++;
 	}
 
@@ -248,19 +291,54 @@ static void check_event(char *buf, size_t len, const struct test_case *ex)
 static void do_test(unsigned int i)
 {
 	const struct test_case *tcase = &testcases[i];
-	size_t read_len;
+	size_t read_len = 0;
+	struct pollfd pfd;
+	unsigned int accumulated_count = 0;
+
+	tst_res(TINFO, "Test case: %s", tcase->name);
 
 	SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_ADD|FAN_MARK_FILESYSTEM,
 			   FAN_FS_ERROR, AT_FDCWD, MOUNT_PATH);
 
 	tcase->trigger_error();
 
-	read_len = SAFE_READ(0, fd_notify, event_buf, BUF_SIZE);
+	pfd.fd = fd_notify;
+	pfd.events = POLLIN;
+
+	while (accumulated_count < tcase->error_count) {
+		if (poll(&pfd, 1, 5000) <= 0) {
+			tst_res(TFAIL, "Timeout waiting for events");
+			goto out;
+		}
+
+		if (BUF_SIZE - read_len < FAN_EVENT_METADATA_LEN)
+			tst_brk(TBROK, "Insufficient buffer space for next event");
+
+		char *current_pos = event_buf + read_len;
+		ssize_t ret = SAFE_READ(0, fd_notify, current_pos, BUF_SIZE - read_len);
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
