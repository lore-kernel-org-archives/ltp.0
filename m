Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F08C109E530
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 01:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774488577; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=vWKCe2n4eunPBH/oeWLd2YJkCE9UYH+ACKeOOED6Lic=;
 b=Cd5cixYde5FhjIfN+Z/YCe/8UQ/XsHF8fvmjrW0QkN0rQQ8Lx1CFXeArXp17PMIvCVdUc
 NSLen6owg/ZLcJu04AW0GMKjuuU1YNRlnKO/jHQD5TnHVlCReP3T9/0NET42eSE7j8c5RwD
 96RfEUSg5LwtX5QcOchjedKbkBrhHro=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 709723E5EED
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 02:29:37 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B33B43C21C4
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 02:29:13 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CB7FB140055C
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 02:29:12 +0100 (CET)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4853c1ca73aso4563545e9.2
 for <ltp@lists.linux.it>; Wed, 25 Mar 2026 18:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774488552; x=1775093352; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EXqXFMGYZvnzo0vFB1EERp3REShnP32eiMPmT5REn/I=;
 b=HGp+0fPCL7lV2hLnPW9ibnxvrxLj74yCb5xY2Ajuf3tO/MeEaBHGl8zIBN9HRG2o7n
 OI5TLMVy5VU7ynLbSh8cf39dreCDQ7Pdi24K+kBTJg8bxnQfNtefFOScfifLu2r8Yawq
 u18k55gqnrgsIwZXpyCsCXJkoj23hcGSAfydU933I8B+vZs/5uFWlEiXy09v1fgT2X60
 O6m3V3kKOsS53+n1/fjx7gPULSbZyiRTGyzbCeMlFN3Tky5XddatT9Ng7ulRuyfZHQnt
 nBS3S1IBOS7H+p9SBWzh3J75lOv1W5LXmMbK2o/LytYdv+n0tpzNQTM/GYBq9mlP1GcB
 +3oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774488552; x=1775093352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EXqXFMGYZvnzo0vFB1EERp3REShnP32eiMPmT5REn/I=;
 b=bBoEYkEBhR8XoeY4cxJgiM4PZJ3I0n40dCGCR6FjX3UFghFQibZwEIWww25JA+GyFd
 t1zL8SMFXSs1CEc19u5sJEeO/7k5PrMhEwbpncVjHUgvJLY5FIMLFr07O1ESiw4y4zZR
 A/HnjZwpGYxWUgNx115VF8v/tYhlI3xFe2rO0eRk4jEEvQNVZpvcUx7FhGnjqUzygJ0p
 iCy0gvs8djDeORFmksI4yEhZZxxUii+tFanEalNIYEIMskuD0WjTV/OrWmEchAlpd7XJ
 iEi9Q2Reece+KGuXgJ+Cqz51ZcDJAwkOqz19k9ySUE9eNbH5IE+5VOh3ofq8ICBM1HRv
 nKuA==
X-Gm-Message-State: AOJu0YyJl4k+ebFhtJ1ug1LQYXF3wgXo2HjxYIjUITz057DgxK2UImht
 cPSfuqCSVYgAJnllfg5X2W3+jG4YEMKWyc+qUdWYTlrbrX+j7ZdHjDkZOBnU7fvyh6W9yDqLjAQ
 Pp34d5w==
X-Gm-Gg: ATEYQzx8pSs4opjyKmRr++kLtMhxwAzgCyMLYH2p3TcjMVkzE43LrhlD4WKPHiE+qju
 F0DexGvlCB0zaQSmpz3qmgkAOth+qKB/yXiG/4AexMjZoVzx4w7EyCyieIrdRShhG8EcjVr+Fi2
 ChYad1abRQdC7Fhtv+i+AckRw1odex4uwE4+n2seUWj5klXXqCWYaDwjaVB6x3I5HmFv1aKtSGT
 NDVFT8+F6orTSgkkWeQN35BwYbUhidDWkf3zvQpXB6WeffZ9QWYanuunJ6JHzMvNHQGvkDKEI7d
 4MNNttNvw3cDxeA6zr/l9TgUcnZATwxB8AF4S3WuGN/DW7O8KcxHoYEuzJtxljZy5GttTsUBkyI
 cvIH8pDI+76Mph4xAik6ZToz08lXOdHw/5cSi/OgxOTpBOPdWWXCDxBaqY/wiGlMQnI5MPp8W8z
 CH99XFDvJ7MWI=
X-Received: by 2002:a05:600c:c0db:b0:480:690e:f14a with SMTP id
 5b1f17b1804b1-48715ff7b2fmr66966885e9.14.1774488551692; 
 Wed, 25 Mar 2026 18:29:11 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-48711764625sm174991435e9.14.2026.03.25.18.29.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 18:29:11 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu, 26 Mar 2026 01:28:58 +0000
Message-ID: <20260326012908.6885-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260325124428.6497-1-wegao@suse.com>
References: <20260325124428.6497-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5] fanotify22.c: handle multiple asynchronous error
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
v4->v5:
Added a continue after an unexpected errno2 is detected

 .../kernel/syscalls/fanotify/fanotify22.c     | 87 ++++++++++++++++++-
 1 file changed, 83 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify22.c b/testcases/kernel/syscalls/fanotify/fanotify22.c
index e8002b160..2e5e6a3fa 100644
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
@@ -248,19 +292,54 @@ static void check_event(char *buf, size_t len, const struct test_case *ex)
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
