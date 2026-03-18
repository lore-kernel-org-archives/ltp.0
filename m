Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82204FCD0BE
	for <ltp@archiver.kernel.org>; Wed, 18 Mar 2026 06:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1773816423; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=PlFC+Fq8VBu6HFiTnf/VDkLldb/oJ9gbWUZ/R1k42rU=;
 b=WzaYh1iCy30WPWVAB4dbrUnQYHXAyezI+bVgH2hDMUtvo/3WcUXZKBIsKna5hpfYyqQLX
 Zb2X0QMFuKvsB2G8zJSOwgmi0fjD90UHVl10RoPY8V6bn5fyLPZkuT1AzQAGVnCiGq0c64l
 ERdi/JL9H4opz7MRpJBM+MvP/547S6g=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8863C3CC8C5
	for <ltp@archiver.kernel.org>; Wed, 18 Mar 2026 07:47:03 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 904E83CAE38
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 07:46:39 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 04AC0200336
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 07:46:38 +0100 (CET)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48534237460so69707135e9.3
 for <ltp@lists.linux.it>; Tue, 17 Mar 2026 23:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1773816398; x=1774421198; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sdThUcpxQ3BBOqpZJ6fawyxHr9IABcnbz7GcKwj1is8=;
 b=Td9tXrjfTZvGuyrKgeud6bvdrKARe8fHD6qbP2QyKqZdT4nSobTN37V6HcWZAaOTQ5
 rLupp21IVK8yBfOYoUntXRM0EqwdohHCCgbZczUAgOlhntQlo6m5XzO03wj2LAgyACW0
 sfTJhL9CL6RGrDtA/TSukNB2Pq8AO0cxZLuC9DeyJUibNiE4oD6d/ZPad/iSuR9rpZ2L
 jAKgvRqC07Q4vyTnxvlAyZpz7OA1R6TOlYx79RCrkBtQalMTuYvReHJYneVZQg3jY1xA
 GCGg1oyYDCNJsXXdVewGLeugSqc97mPUCCHDVjxH+JZhR3lHApSekYwb+kTF9HLLZKHC
 C2SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773816398; x=1774421198;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sdThUcpxQ3BBOqpZJ6fawyxHr9IABcnbz7GcKwj1is8=;
 b=a4PoL3XKTnWEMhmMQaPnhboJmwWIEW8pmbfS2nYxcPsDz46LoJDwProjkBE4SWxGAH
 41CBcXNL/bYGnEFwCa6cg37lgxSEZQRg4er30TiANlXcHxCviJAPDjuiI2w9tvrbdVoQ
 8ob2itSUyhZL9iHqqbt40U/MykMzNESYyzCq6rr6CkvGYSUd4ceMJsKDBTcK2ucTWOyg
 32MrMLkKGh6ODzyKzEnGE4PbVo7mglBXTQLQUv5rlUzZLuJD+eB6TwCGB1wtmubuKTgS
 xT8OpvR0QyBNEXRkoM/h7m4WMgYhksF8giLUMbMS3p376ZwN+ZzK9f6nZodFaGkpyP2j
 DBFw==
X-Gm-Message-State: AOJu0YyKlbjz7QT2UzetQMITYy3WlRyNPfP7qSgLUc7DgjoOKpf86nPj
 r1jGi+zLYmWH4uoFChG9LthW2QyLUIsiOMImhX5Ah2awMdEmVS2DSgz3pfCMmvhKNOgzELXD5fR
 Tz2M=
X-Gm-Gg: ATEYQzwMp/NbycuAmVvKpgx+Sl3nwqg/ZbMAcNx7ar7vQY+DOLPpKZ1saHnAXuxsIoG
 mnhfO8UkgeZo7eGYPenU3cDLOXvT7v31Dg2yeNnT58RtBQlqbhUpluzQ05FqPrFKbKUH3uSoISE
 3tpgY0JH7AwhY2rKOtEyYGfmWZHC31kYc18Jdh5mr4zM/mmlSKATgCVzJC4fhJMTk+HxQ0B9qLT
 amVKcRTrHX/5ER8hetN4Bb/Elzlst+taG4WAf+6nC9AckzKgUY1SCBeRQ7Leeqs0nxi7DGtE7fT
 JS+CKJbS5cuRu8IDZCLMjFe2slonKeu8TOtaIp3lfkOskLJBh4wni+hjeGUzwKmNqBrMtSnR84y
 7DByNcRKjSh3SEK2+MI+Pq6v0B8m6d+sTfkqyeFqOjUjJKgsNFOhy5yCzCOyRN/h0sQ362fmYz3
 GVUamTZ/m+s+Y1xpBRHDWfUw==
X-Received: by 2002:a05:600d:8495:10b0:485:40c6:f51a with SMTP id
 5b1f17b1804b1-486f4465dfbmr25773145e9.31.1773816397737; 
 Tue, 17 Mar 2026 23:46:37 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-486f75f774fsm1217775e9.32.2026.03.17.23.46.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 23:46:37 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed, 18 Mar 2026 06:46:19 +0000
Message-ID: <20260318064630.1604-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309075946.28119-1-wegao@suse.com>
References: <20260309075946.28119-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] fanotify22.c: handle multiple asynchronous error
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

v2->v3:
- Replaced usleep() with poll() loop
- Added secondary error check support (error2)

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202602042124.87bd00e3-lkp@intel.com
Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Wei Gao <wegao@suse.com>
---
 .../kernel/syscalls/fanotify/fanotify22.c     | 87 ++++++++++++++++++-
 1 file changed, 83 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify22.c b/testcases/kernel/syscalls/fanotify/fanotify22.c
index e8002b160..c921cf2c0 100644
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
@@ -134,10 +135,54 @@ static struct test_case {
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
+		if (info) {
+			if (!first) {
+				first = metadata;
+				first_info = info;
+			}
+			total_count += info->error_count;
+
+			tst_res(TINFO, "Event [%d]: errno=%d, error_count=%d",
+					event_num, info->error, info->error_count);
+		}
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
@@ -248,19 +293,53 @@ static void check_event(char *buf, size_t len, const struct test_case *ex)
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
+			read_len += ret;
+			struct fanotify_event_info_error *e = get_event_info_error(m);
+
+			if (e)
+				accumulated_count += e->error_count;
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
