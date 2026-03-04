Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82049EF8FE7
	for <ltp@archiver.kernel.org>; Wed,  4 Mar 2026 13:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1772631535; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=LP9O+HDEMIWH2F18GBEXXt92ltNNJlm3A16yEKM6GYo=;
 b=LJafcZryqLsDdo6zppjgeyrSIL7cW7hsyks/IBU2YMZ+hjDf8gptJzwy+SoUg58tsIDhJ
 Ue3qS03uNqTXS/n9ScfwMJ8OJjDL/rSTATOmVj7qzVaRNm10FXUiEuHgGJvz+CI1P6/O33Z
 4sXhJ/J9MUAFGWJ1AYqk7BGeTVjwOOM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 197DD3C2A89
	for <ltp@archiver.kernel.org>; Wed,  4 Mar 2026 14:38:55 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E28053C61C5
 for <ltp@lists.linux.it>; Wed,  4 Mar 2026 14:38:30 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2B82E60005C
 for <ltp@lists.linux.it>; Wed,  4 Mar 2026 14:38:30 +0100 (CET)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-48372efa020so60623655e9.2
 for <ltp@lists.linux.it>; Wed, 04 Mar 2026 05:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1772631509; x=1773236309; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nCBQHutnoQwDJwkfhAWoRgci1VzlMW5Apw4RfIIrAmM=;
 b=XkrEHPCVXTOrgRrB57dtsIis4+jKlR/XkCMJtKNpwoZX1VQHOdM2boJXmYE7laqlME
 9CeP2PqPQhvLdJF5c6RhXUaAd4e9oD1OpnHjZUKVDe7HS0RsMRaJqR7aXdEcIk6NPzsm
 hnNZAPJrXRpJIjMa+aUgfy7mHnvR6wNGv7mu2S3SIwfU2NBPhBtKHn+WsUJl8hUnfdZQ
 8nLPE78n63GqwJ+tL0YBrrfrAgBF9QQj3RNI4faK/lQ84TQAmWE8Rt7NdxF/ujp7i22X
 gmfM4qiRs8X08JfL6QFLz8XGuHJmk83eYeNw9ah/vUFxE3iLqii3lRH2yMHzFhu8zjPB
 sG2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772631509; x=1773236309;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nCBQHutnoQwDJwkfhAWoRgci1VzlMW5Apw4RfIIrAmM=;
 b=a/nwzql75iRfJrG+bOMtvBBSyHFfdaey6SeBdW4sMnoGPmyG7FYEhHM1xD6VXuYhXR
 ooCGlHnEK10z0koiGMhH0dJ3A6fVh8WeO5DuV9reEJ5O1bCpuqwXz6NkL7PWleIpWJu3
 0EeWFFItTUuqWaxiVy2pVGENRPvBF8tyqShA8JHBTxjqVeCdUF9PJDzCdi+qZKWKzMjZ
 Hei/boc3Sior7oMO1MN3XpJDbKJUZNZLLIIhiMJXYRs18bx4OHRNmdIVT25sfp2nNEEQ
 iHdsQplbCdSscduMOL/aO/DWeRfEZ0w0fFJWvbVv6QmlJQQEfI16SdzeiV0XmJcS9pit
 olLA==
X-Gm-Message-State: AOJu0YwF1BBOQUpVGPXE97vy9nWp5j8IN5pGQt+rZazFHYSseq2rfx8N
 6ld/XURwe/9agffr8V6KfZXd84MiI5gFCxzYE8ZBSYaHEsm1roXReBPGURxgFjn1lDmMzIBpatR
 fI0Y=
X-Gm-Gg: ATEYQzzOMOIXrtdcLAjt738fBMNX7NZwepJISqJw65/Bien82LgduK3liG073+uePT/
 +N7HiPOYYxb3V0FvHopMVOG7BCaThQI4uadtfs/7fFp/vOYNJ89ONqloIDSgtVeqhWgjDYIFX64
 /c2TywKc+orkr3rA43GEsMMTkN+zz7HGqEZdOGw4juA1fhFjf5FsihlmUpcKYM3HuLT3xlnNt1n
 fEdHiiECPT6lahJOHaDJHj8tkQw00dIk0Y7cqi4TyRzBTbxyJxvDFq8V4afvnGyriEkIavI9lnL
 5TCaYh/30H2gopQDcDpEdlGbYCE3HJisudcS5eOyPeHtGt83XJ8hLTTX0+r/hxsSJN+CuewibU/
 Q0/cSQ1Zkkx8IcJYcBW+qUngZAy8OtzqP0AWgrZB30Ok3opfeEgaGbSsLV5wM8hdj54MhnKx9sN
 5p5e76bbGHofw=
X-Received: by 2002:a05:600c:a087:b0:483:7907:ea02 with SMTP id
 5b1f17b1804b1-48519884058mr35275835e9.16.1772631509270; 
 Wed, 04 Mar 2026 05:38:29 -0800 (PST)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-439b4175fd2sm27469055f8f.14.2026.03.04.05.38.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 05:38:28 -0800 (PST)
To: ltp@lists.linux.it
Date: Wed,  4 Mar 2026 13:38:07 +0000
Message-ID: <20260304133810.24585-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] fanotify22.c: handle multiple asynchronous error
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
   notification fd between two events. Adding a short delay
   (usleep) ensures all events are dispatched and ready before the
   read() call.

2) tcase4 failure: The kernel may deliver errors as independent events
   instead of a single merged event, The test logic is updated to
   validate the expected error_count by either a single merged event
   or the accumulation of multiple independent events in the buffer.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202602042124.87bd00e3-lkp@intel.com
Signed-off-by: Wei Gao <wegao@suse.com>
---
 .../kernel/syscalls/fanotify/fanotify22.c     | 32 ++++++++++++++++---
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify22.c b/testcases/kernel/syscalls/fanotify/fanotify22.c
index 6578474a7..82eed7ba9 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify22.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify22.c
@@ -53,6 +53,8 @@ static struct fanotify_fid_t null_fid;
 static struct fanotify_fid_t bad_file_fid;
 static struct fanotify_fid_t bad_link_fid;
 
+static int event_count;
+
 static void trigger_fs_abort(void)
 {
 	SAFE_MOUNT(tst_device->dev, MOUNT_PATH, tst_device->fs_type,
@@ -88,7 +90,6 @@ static void trigger_bad_link_lookup(void)
 			ret, BAD_LINK, errno, EUCLEAN);
 }
 
-
 static void tcase3_trigger(void)
 {
 	trigger_bad_link_lookup();
@@ -176,9 +177,10 @@ static int check_error_event_info_error(struct fanotify_event_info_error *info_e
 {
 	int fail = 0;
 
-	if (info_error->error_count != ex->error_count) {
-		tst_res(TFAIL, "%s: Unexpected error_count (%d!=%d)",
-			ex->name, info_error->error_count, ex->error_count);
+	if (info_error->error_count != ex->error_count && event_count != ex->error_count) {
+		tst_res(TFAIL, "%s: Unexpected error_count (%d!=%d && %d!=%d)",
+			ex->name, info_error->error_count, ex->error_count,
+			event_count, ex->error_count);
 		fail++;
 	}
 
@@ -255,8 +257,30 @@ static void do_test(unsigned int i)
 
 	tcase->trigger_error();
 
+	usleep(100000);
+
 	read_len = SAFE_READ(0, fd_notify, event_buf, BUF_SIZE);
 
+	struct fanotify_event_metadata *metadata;
+	size_t len = read_len;
+
+	event_count = 0;
+
+	for (metadata = (struct fanotify_event_metadata *)event_buf;
+			FAN_EVENT_OK(metadata, len);
+			metadata = FAN_EVENT_NEXT(metadata, len)) {
+		event_count++;
+		struct fanotify_event_info_error *info_error = get_event_info_error(metadata);
+
+		if (info_error) {
+			tst_res(TINFO, "Event [%d]: errno=%d (expected %d), error_count=%d (expected total %d)",
+					event_count, info_error->error, tcase->error,
+					info_error->error_count, tcase->error_count);
+		} else {
+			tst_res(TINFO, "Event [%d]: No error info record found", event_count);
+		}
+	}
+
 	SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_REMOVE|FAN_MARK_FILESYSTEM,
 			   FAN_FS_ERROR, AT_FDCWD, MOUNT_PATH);
 
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
