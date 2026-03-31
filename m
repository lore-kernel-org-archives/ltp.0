Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 791BB1061B2E
	for <ltp@archiver.kernel.org>; Tue, 31 Mar 2026 11:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774955966; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=Hfsjpws9Pm/QQ/0axEwWX+TYuYveYzF+dl8QVoHekFE=;
 b=hqUd66xCn8/n25ZPLJWqgomTbXYRjNmUDnYYa7cgJIEuslEcKsYYpST/T8qFluLNNHY34
 08hIi4FmHM1nuRlnxPpq2IQOtFD1iq8HRmulqZ5RGHFqZe96xlzoUIMdRX3AxUqoCpjnWgX
 dXZETXRoHuBXTrysSOHqqO8PoMvwhtE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0D0133E4ECE
	for <ltp@archiver.kernel.org>; Tue, 31 Mar 2026 13:19:26 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ACA6C3CD981
 for <ltp@lists.linux.it>; Tue, 31 Mar 2026 13:19:01 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E6A141401250
 for <ltp@lists.linux.it>; Tue, 31 Mar 2026 13:19:00 +0200 (CEST)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-43cfde3c3f3so1698196f8f.3
 for <ltp@lists.linux.it>; Tue, 31 Mar 2026 04:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774955940; x=1775560740; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vLOMIizp25xRODfAoZCehKJCf+CAt/xEoAArzta5sK0=;
 b=fpVrIMsfmQBf7cJHEF//BLRkMcuw2kRErgoPctE22cnwhkbuijkvU+91mxcGiI4kYa
 OJ5hLbdollNBDN08VKcy6pcekzVepytMRHBs9+UaO2hSr+a28gnIs7OWeiMO/9pw6Yxb
 xg3etKUZoNZ204lCH8kyr0A3Ep59Lil+hiek10tBkJCc0SOPyG5rRvpNEWCxviFVPnOb
 vmPMFkaYk8XwG0zK7csBkYoWQkk2O23u7PJdrSuhq1vbq2SqJiuCeqbWmehwxJhdkZN0
 frlA67O5DRpHjUjU5m7UCOSFA8Fv5qJvYya3eUA/t18d17e8arQde/LDyFORafflX1m2
 zyZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774955940; x=1775560740;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vLOMIizp25xRODfAoZCehKJCf+CAt/xEoAArzta5sK0=;
 b=kPqV+iXMuUWcALS+GWFzDLM9w+grG7qExDFJ517c0Sl60Y8ZRqesVVZND+kExWgGuK
 iLQlNx3iVwpy8O7D/kYFsA19TNjnY3ktZW4Pl8/F5Ie+KrsiaLdonYu65Ckv5ZxEx1JC
 QQSI6QW+9AUf3n5lK+8A7a1NbI5Ew3oMPk0BzjTfQnOAmRihcmYa7eC7E9OZf2QZ8Yif
 GCaWYdyXZRbLalEB2E+Q9sUVdv55c4aOVWSz0QxmbcFHx4TsMFfW/XvZ3hgf3mGVVjCr
 dRmfmlq2cnPaY98/Qz/yf5BbQ3oXDbecYyLz9wz33puhJVTqtPYQuTZKCpxP60VBnnnt
 s7JA==
X-Gm-Message-State: AOJu0YzfF47g8v0t09t4wAQzCIi4p7f6et6Wweqwa630tl+INTFAPtmB
 EQ76CAi0Hn8YLwvdA2D9c5191YMDn4UhsqBNLeaQeo4RZR21O6phBh/7BslZE6ZXXlKGI/huOzf
 50OU=
X-Gm-Gg: ATEYQzzAN1VoYhpddRPOLLEIG114MIQs5lVlgA89KZGLW0lWb6ZktJCvqbvLHttIk2u
 u/kLPj9b7fLOpv1fUmjEU5DBo6iY0mcwP8tWhY1zRcEAEkM5Chis35ukAbG/mHaYHlISDwfJb5H
 aVB51aHUs7h3Ch1UjbKFdJ98dsqkGEDw6fftp5QR72wVFIhyKme2/Sy+XAr3AS3IhHvbUwKJc73
 1isBCqEig9O/q+nAQjxwEHd4tGeCdBulge4C8whSnTPuY0C5RvEhrWRQZYDY2A6g196gyIH9Clx
 bPGu1WSP0dLiL7V7DE28LwNMaPOCjYIaRkN8IYIB5zINCsjN1gEfoPPrELl6Ke8P7vHXJT0Dg6j
 PBTxRFoFXHz8u/C6PKihnpebiQHTsXFS6ZJAESESP94aoZJuThd27sToE8Lmv8RibsBaW3nM72A
 bCFO7BC8aS1eo=
X-Received: by 2002:a05:6000:40dd:b0:43b:998c:9bbe with SMTP id
 ffacd0b85a97d-43b9e9e8e75mr27160455f8f.13.1774955939911; 
 Tue, 31 Mar 2026 04:18:59 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-43cf257b72dsm26677072f8f.34.2026.03.31.04.18.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 04:18:59 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue, 31 Mar 2026 11:18:39 +0000
Message-ID: <20260331111857.10995-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317114635.944-1-wegao@suse.com>
References: <20260317114635.944-1-wegao@suse.com>
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
v6->v7:
- validation check to accept either error or error2 in check_error_event_info_error

 .../kernel/syscalls/fanotify/fanotify22.c     | 113 +++++++++++++++---
 1 file changed, 96 insertions(+), 17 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify22.c b/testcases/kernel/syscalls/fanotify/fanotify22.c
index e8002b160..f5d59b99d 100644
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
@@ -177,14 +220,15 @@ static int check_error_event_info_error(struct fanotify_event_info_error *info_e
 	int fail = 0;
 
 	if (info_error->error_count != ex->error_count) {
-		tst_res(TFAIL, "%s: Unexpected error_count (%d!=%d)",
-			ex->name, info_error->error_count, ex->error_count);
+		tst_res(TFAIL, "Unexpected error_count (%d!=%d)",
+			info_error->error_count, ex->error_count);
 		fail++;
 	}
 
-	if (info_error->error != ex->error) {
-		tst_res(TFAIL, "%s: Unexpected error code value (%d!=%d)",
-			ex->name, info_error->error, ex->error);
+	if (info_error->error != ex->error &&
+	    (ex->error2 == 0 || info_error->error != ex->error2)) {
+		tst_res(TFAIL, "Unexpected error code value (%d!=%d)",
+			info_error->error, ex->error);
 		fail++;
 	}
 
@@ -248,19 +292,54 @@ static void check_event(char *buf, size_t len, const struct test_case *ex)
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
