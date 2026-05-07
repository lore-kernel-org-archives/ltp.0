Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12826CD3436
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 02:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778122456; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=EvyFFm8IowQ2FHxYCpdRRsxpqZ6yQE9PK4zMS1GMoJQ=;
 b=CQzp6gLqGrQOQINd5oJiFx94egY1EGLvGsNC68oj3X1SHcQ3uPVwyiqSCB3Y34tPJaSgn
 RhAlvNikwb9hVoS6Dlt2m98BjOx1124/Oi7KJEHXizXDKPD+DMP0ngk9WSpCzkw0pWjHC2L
 myyHERgrVxTX5dfHMfr8PCSIhWky94A=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9DDD93E6AB1
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 04:54:16 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BE5213CF512
 for <ltp@lists.linux.it>; Thu,  7 May 2026 04:53:51 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 22A7714002B4
 for <ltp@lists.linux.it>; Thu,  7 May 2026 04:53:50 +0200 (CEST)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-43d7645adbdso194320f8f.1
 for <ltp@lists.linux.it>; Wed, 06 May 2026 19:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1778122429; x=1778727229; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yv58+dAlq3FRMu/4ebuy4pszUcHMeSmdsBAZqNtWECM=;
 b=fnqCV5QVueapD3YX7TFoDjIDALXBobcDVHQP8cDu/8LA2Y+OzN3gx3+Rp0biMhwjxb
 nGUKhJ1ZQGnqagbuyGh4imaRp2xV6bydiz2amERjeozV5jItLpzRwcm4XjW143Id8BMf
 Touh608b1UM3ErWalJriMRZCtiiH6EaUgY4RlT/bevYywlexgkP1CBMf8qvyaEf/hyu/
 4AgvVv+ciURiEIn3tIPCGzw/QxQ6mLIXVOzX9zndMfY8hrKzzQXesele6YYGBtQrPfGZ
 3mwqLhhxFI3pRJOcvunDns4z8TeN7XJ1q6pcpEbdqrC+0ACDgn1FsANWXh/u+TmWiP49
 Y5dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778122429; x=1778727229;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Yv58+dAlq3FRMu/4ebuy4pszUcHMeSmdsBAZqNtWECM=;
 b=JtneCz1D2HFsxxtWg+odyAXjPRTFSOUuLX62gnTgZElVmAMFUxmTGpwZ0OTHG7wjUz
 QcHdrroJz7YzngX5YOAnbef4BoCKudCWnyqOO6KU10C9nSB0r7jQ8o2XjQS5+eNUjSoU
 HkXrtPIaqRP+pOhnZNTrbwc8vvHxYWHdPiBDj3UmTrTCZzeO5OABOkeVq4n0SSrWEzft
 OoAAD/8f7PlYEgsR1iBC6YIQupEQrpX7SJdCO4sTBWehgtzZeU1x7PFF/1tooMx6Tl74
 fJWDvSNLZkoO/CN3VZGzQsep7dIKgSIZpuVNDucjl0UEOiIk0EH6VMWL2zwEJeAGMnMj
 quJQ==
X-Gm-Message-State: AOJu0YzlfoSLeGB4F9kDFvHKeKGyM4brGg/reT0z7k/rYgxPmrDMSEOi
 HQagb67qC9C7uCtHkvvP3iS1Gy7RpEnl5HeQMrMHP2EkPN5gDBsxoJ5hTBC4U9YNqiIF7NLEpBc
 c1bs=
X-Gm-Gg: AeBDieufMWYXy6plndakeZkYAuFOAKFOB7m4q8wkj7aES10XetWxRqlykbg/D5iBSiN
 hnGz2ABy8KCX7lNF6vSXku6r4OsrtooBPecRDml65IY51Y04lQgdrJNbkUqhiylXikBL6FPoPH0
 h5ikYXr4TWOjq+HVwv0Rzrnr9UprGMdoeXAV7IVDhiF3ISGxifS6aIAILLzfQarEpPu+C7GY3VJ
 LEAx/S8qvPEAmwJnWl9lnoUMbLyFLYKo4YNKlbYugOYiu8nCIeCy28ImBelbttENdvPI62kr5wi
 wvY+mxedhe5Lf7M6HQx0zdGjNOFjNw5nLiMF3yH/t/5iLf0XRYZ3vLMHsb11Itlu/ODMVT9gBTc
 TnKuNP5rOooZSrBN6uCZaRaTxqlcUKBsac0gIoXXfGiWgbi0xGq6smm6uMPhQQ4dP8u6okgD9VA
 p/b4sOfY4mBerHAEPR6pa2BQ==
X-Received: by 2002:a05:6000:3107:b0:43d:2be:e54 with SMTP id
 ffacd0b85a97d-4515dc8095fmr8799539f8f.39.1778122429273; 
 Wed, 06 May 2026 19:53:49 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-45055960973sm16762209f8f.30.2026.05.06.19.53.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 19:53:48 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu,  7 May 2026 02:53:33 +0000
Message-ID: <20260507025345.6722-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260331111857.10995-1-wegao@suse.com>
References: <20260331111857.10995-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v8] fanotify22.c: handle multiple asynchronous error
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
Cc: kernel test robot <oliver.sang@intel.com>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Since the introduction of the asynchronous fserror reporting framework
(kernel commit 81d2e13a57c9), fanotify22 has encountered sporadic failures
due to the non-deterministic nature of event delivery and merging:

1) tcase3 failure: A race condition occurs when the test reads the
   notification fd between two events. Use a poll() and read() loop to wait
   until the expected events are delivered.

2) tcase4 failure: The kernel may deliver errors as independent events
   instead of a single merged event, as different worker kthreads can
   end up generating each event. As suggested by Jan Kara, this patch
   introduces a consolidate_events() helper. It iterates through the
   event buffer, identifies the primary event matching the expected error,
   accumulates the error_count from all independent events, and updates
   the primary event's count in-place for validation.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202602042124.87bd00e3-lkp@intel.com
Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Wei Gao <wegao@suse.com>
---
v7->v8:
- Fix a logic bug where the test would fail if a secondary error (like ESHUTDOWN) was the first event in the buffer
- Move variable declarations to the top of blocks to follow the preferred LTP coding style
 .../kernel/syscalls/fanotify/fanotify22.c     | 119 +++++++++++++++---
 1 file changed, 102 insertions(+), 17 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify22.c b/testcases/kernel/syscalls/fanotify/fanotify22.c
index e8002b160..c124e1904 100644
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
 
+static struct fanotify_event_metadata *consolidate_events(char *buf, size_t len, const struct test_case *ex)
+{
+	struct fanotify_event_metadata *metadata, *primary = NULL;
+	struct fanotify_event_info_error *info, *primary_info = NULL;
+	unsigned int total_count = 0;
+	int event_num = 0;
+
+	for (metadata = (struct fanotify_event_metadata *)buf;
+			FAN_EVENT_OK(metadata, len);
+			metadata = FAN_EVENT_NEXT(metadata, len)) {
+
+		event_num++;
+		info = get_event_info_error(metadata);
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
+		if (!primary && info->error == ex->error) {
+			primary = metadata;
+			primary_info = info;
+		}
+		total_count += info->error_count;
+
+		tst_res(TINFO, "Event [%d]: errno=%d, error_count=%d",
+				event_num, info->error, info->error_count);
+	}
+
+	if (primary_info)
+		primary_info->error_count = total_count;
+
+	return primary;
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
 
@@ -248,19 +292,60 @@ static void check_event(char *buf, size_t len, const struct test_case *ex)
 static void do_test(unsigned int i)
 {
 	const struct test_case *tcase = &testcases[i];
-	size_t read_len;
+	struct fanotify_event_metadata *m, *primary;
+	struct fanotify_event_info_error *e;
+	char *current_pos;
+	ssize_t ret;
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
+		current_pos = event_buf + read_len;
+		ret = SAFE_READ(0, fd_notify, current_pos, BUF_SIZE - read_len);
+
+		m = (struct fanotify_event_metadata *)current_pos;
+		while (FAN_EVENT_OK(m, ret)) {
+			e = get_event_info_error(m);
+
+			if (e)
+				accumulated_count += e->error_count;
+
+			read_len += m->event_len;
+			m = FAN_EVENT_NEXT(m, ret);
+		}
+	}
+
+	primary = consolidate_events(event_buf, read_len, tcase);
+
+	if (primary)
+		check_event((char *)primary, primary->event_len, tcase);
+	else
+		tst_res(TFAIL, "No primary error event found");
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
