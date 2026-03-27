Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7DB810ED665
	for <ltp@archiver.kernel.org>; Fri, 27 Mar 2026 12:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774614186; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=5wUQ6IqdJE6dFcByrQKKF/xoz2cH9bBSG2AigdxB8GM=;
 b=W1+DVLUW1yr7Hxuc9N6GTLwianGI20BFzvZVWPm4YeD8ZqqDBd3nJzaDk2MAzHGHA9Nbk
 mo35wegqV/iUm3oqaJMaFDmaQdBOVkOMxs0mbX8XQB1EfzSZOacQxDzsQFkDNu6+n8P3Ymc
 gP7dNLYZCw0up3pShtwlRUlOquxh5AA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7E8B13CFC0F
	for <ltp@archiver.kernel.org>; Fri, 27 Mar 2026 13:23:06 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0C8643CFAA2
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 13:22:42 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 57B8F60093F
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 13:22:42 +0100 (CET)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-43b9d3ebed5so692869f8f.1
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 05:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774614161; x=1775218961; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lu/2YxRnmTvIj2IwgKGo9VotoSd6iIiGO6UmNY1m/gc=;
 b=g4Gjep23j8JxrsalZfrSqvGdKHV+/2SrMBQ4jQtL62DiQwqmVQ/FgPJMlTfIufEjVZ
 WLKMvnfE/nB+g0Rr6imOHatMSE9jsrqAR4ixCcccRjPN/jUX9tcYSogjnpVm9kVjawyV
 JEZOhuaxlkGm5klxQH3g8zEd5E27Oo9MUDS+h2qJEzwu0udMzM25dmpy6XiPj0f0xK/0
 NGFXgaCELjrisq0lmbVKLDflWYNqbA4zgstUUVJkr1OUXSUqqmVCA/YGChSdpVNumosD
 2pAdIKpE4oHIywaPljiBH1BzAR3dXYLF8KgeZ99MX5S5957JggTeqgGXQvV7AEACF5hD
 Rpzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774614161; x=1775218961;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lu/2YxRnmTvIj2IwgKGo9VotoSd6iIiGO6UmNY1m/gc=;
 b=VWvdBFPc0LhdCmFEiv/TmB3j/0ktKDmzB2WAn7OQD9alcG4bYOrIa+pC4o+tcHeJIj
 +OpRb9B4uFceKYHWNqk6NWS8XwNgKPmEvMYxU4afkGmBG8B3lRzO+1tjoIl7O1CPQlHi
 7MbvyTNuOiKwzm3w4C117tnbAgaFFkN5pw1Ze1RNuhjASROqQ/q5Z0qllqgWErFByU21
 gHDd6wUu32nuro69Lt9ZSRIuKpi5JXtgOxZ4cmlbJhsxU3HnWL19X7esGZgfmxxcaG68
 tdcjz2NsCOJk9wwaNEydEYVZsjjAb44xSAYLmK5ThNy5CIQsBR65Dfzyfv+NjI8kURT4
 4ABQ==
X-Gm-Message-State: AOJu0YyjURRKc6yb20e9e+VnrkS4nzhyZdr+uJEJwl8RwLYUf5uj5BYS
 c9977oeWsl7RLbv/kbrpMzmgD9kWrkWpBQsjS8XGrW+Yi2yDO4qgQFiheU1PXs1rzOFGUqrILmB
 AOU0=
X-Gm-Gg: ATEYQzzqlgHlR1oyBFW5vBgcvWE+ekno8k2CnkhuK5g5XaR6Ni6pyBcPJoII3u4OPDR
 JebuQTVmXx0x9Z+QBbVTekUwrssVqdSFkR9u5F1xeH3ECdyKIrq4csoZKNyo2EUr+ubSYrs3oRW
 cvbTpMlWOMvEgIqNleliehYxMWv/bANM//U1xFoHT0yqQmDF8w8KQjFN4uXu5/0WyANKofZZ613
 9+z5czgF+wfQkNGdnHU3RvrpaROZ3Dy/XWv9vfkeVPiV5c284LVNEoYlExIeqFiGLMSVFAqpcOg
 ucZqh5Xj7lfBZDd7OpkYO3xc3xvcGYCJgqV5OeB44ZgBpdv6Ikce+TUNFTHucVk77ff3zTj3mvE
 MaUZKifxwvJJIE+LBinV0iWAB2CKZ13Zo2hqOp4ZbptD7H+1n+DmSi/oc1vkbAqLkqUIOqJP+fw
 YP8w49B8nvcwk=
X-Received: by 2002:a05:600c:64c3:b0:477:6d96:b3e5 with SMTP id
 5b1f17b1804b1-48727d59bb9mr41161325e9.7.1774614161289; 
 Fri, 27 Mar 2026 05:22:41 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-48722c95041sm87164505e9.6.2026.03.27.05.22.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 05:22:40 -0700 (PDT)
To: ltp@lists.linux.it
Date: Fri, 27 Mar 2026 12:22:37 +0000
Message-ID: <20260327122237.8071-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
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
Cc: Andrea Cervesato <andrea.cervesato@suse.com>
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
