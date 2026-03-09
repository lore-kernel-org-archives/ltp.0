Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48DC3EF36FB
	for <ltp@archiver.kernel.org>; Mon,  9 Mar 2026 08:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1773043216; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=LTpavZGjwQ73ixRIjO+QAWsLWzZp/csBojDs0Ano2gA=;
 b=Vz+AgL4a/7jdCFqy6VdwXJvfs4NNQ9bmuEQjOe1cD4dfGDvC5snuwA92Zs0L32+eQNsNO
 D+G3vtt0K7LuKJhdkBWNyKTodQApRNs5F52tQP7VfUSJ9BGqjNLQb08LRTgndAWxJmxeNuU
 Op3sI8f9pwUbopHcsHqUocc2I+wU5Gs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A94F83DD469
	for <ltp@archiver.kernel.org>; Mon,  9 Mar 2026 09:00:16 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3EBCF3CC7DB
 for <ltp@lists.linux.it>; Mon,  9 Mar 2026 08:59:51 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 93897600493
 for <ltp@lists.linux.it>; Mon,  9 Mar 2026 08:59:50 +0100 (CET)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4852a9c6309so19036295e9.0
 for <ltp@lists.linux.it>; Mon, 09 Mar 2026 00:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1773043189; x=1773647989; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TaZm3GN3kngizvvBJiyWQBFGaZz8df+DBIfQr6aTskE=;
 b=RbQknjAPWunDoGGlITmO6OJ/Co8+OGPHb5Fp8v+ROeq9jqynvI5goaJ8FJdTs+BsxI
 74QIwEqKjlOEwH/jHFQpgBJ0OjWsTRVNe0tFeWUpRnA8PNUXggvRv9ZAS9PsGXm9czeK
 xRYjFXEKgS18pN3Gbi69p1LKonkaiK2RIUYIjP45yCJzHX3ZLRbSfaUwKjohIZRdCbc9
 ekLswWLYbt+XKOC/OzPK5UGKFDZniei4Jep+aLLr/QyKJqRhelHFeOxUyrkGYCUq4ujI
 xYHfM/zDPZolkrSUNYIsSP4gK72kka+pyZMD93J3CCISM7XnPdZD/MGzWri4FBzLNUvC
 lrfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773043189; x=1773647989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TaZm3GN3kngizvvBJiyWQBFGaZz8df+DBIfQr6aTskE=;
 b=eTZMha58WwRjGlMnX30FUCE4zItbEosNUwRdaiWyXj9X4C+5iO2EHNkW4u8HpZIyUE
 xOvg2RcOtQ6TqOm2osBpGlr9q+RT+UTA0npbCeGP44b0mNUX0hLFLbw54/R1KTaSlWWL
 B7aKz0RuUKJ3VZlx1e9a8TmnE708/Cwvw4GsOPfhnLP3UgXXgpz3XRWGS6lIqksUcIRj
 EZ8kll3ssRk90S0Sg47vZlzyPUVyx9l6b3KuaaaoKB2RGj5ESRKbrgBoLiv2IersLk9B
 AWj0JMiJW6nmzKSJShb8wcYhB3q+1HRlmQbiY6hxBJDcqweV4dal9SxcefM5zNqIo+bJ
 jsow==
X-Gm-Message-State: AOJu0YxhACVs/38qdIYumn/CEZ4W3TU5WftHI4lpiqRPLaB5fn5vIzJi
 E7uOvnag2+A2CjDF1xdzkf7ExaVo0XhJx8ziAqi2Jsa+DyZ6zk1np7T1Fu7mKqyPOb7iCXj7lV8
 tSRU=
X-Gm-Gg: ATEYQzyscTQhFIBU6Phkxvzs9qUu8GGbE9eG9p6gTR92GQCeymSPZbZImHHjpfmM27s
 XP9wIyor0eFv/841IDbE6Pyj8pDwmJ8BcIqI8Hv7a6xjYz1+Lmffp33+5oOVK6vDTz2uM+3QZeI
 NsN08Kd+fA24pmMNdBzlPwGCVE+bpO4xc5cQtNYPp8NAyfT+73xBrRvFHkjuAA9CJP86v5hNdx+
 wJUS2D/b8waeemzqj4NvWFjUEEs94KuuTz35aNjbvWjOa7pXAdDpnridtOJz/v6GxqRHuQV5vnz
 StuegyrR0vFlgCfjOY5bJZ5m6pA2Rl9yNPoos2Lpdg3iEm5KWv2bozXhPv4/Wa63CCDTRgyCYpH
 AqxXppL44UPJ160FJHo/L60Bz/kG/Y66DDU3opcsUoYiR/VGHh9afBC3jpSBfw9Dw7gijGimYbg
 29w1SvTtjVrho=
X-Received: by 2002:a05:600c:1381:b0:483:7020:864 with SMTP id
 5b1f17b1804b1-4852697a1d3mr169534655e9.25.1773043188798; 
 Mon, 09 Mar 2026 00:59:48 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-439dae49177sm23933530f8f.35.2026.03.09.00.59.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 00:59:48 -0700 (PDT)
To: ltp@lists.linux.it
Date: Mon,  9 Mar 2026 07:59:42 +0000
Message-ID: <20260309075946.28119-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260304133810.24585-1-wegao@suse.com>
References: <20260304133810.24585-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] fanotify22.c: handle multiple asynchronous error
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
   notification fd between two events. Adding a short delay
   (usleep) ensures all events are dispatched and ready before the
   read() call.

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
 .../kernel/syscalls/fanotify/fanotify22.c     | 37 ++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify22.c b/testcases/kernel/syscalls/fanotify/fanotify22.c
index 6578474a7..4c0fd31b1 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify22.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify22.c
@@ -88,7 +88,6 @@ static void trigger_bad_link_lookup(void)
 			ret, BAD_LINK, errno, EUCLEAN);
 }
 
-
 static void tcase3_trigger(void)
 {
 	trigger_bad_link_lookup();
@@ -138,6 +137,38 @@ static struct test_case {
 	}
 };
 
+static size_t consolidate_events(char *buf, size_t len)
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
@@ -255,7 +286,11 @@ static void do_test(unsigned int i)
 
 	tcase->trigger_error();
 
+	/* Wait for asynchronous kworker threads to dispatch events */
+	usleep(100000);
+
 	read_len = SAFE_READ(0, fd_notify, event_buf, BUF_SIZE);
+	read_len = consolidate_events(event_buf, read_len);
 
 	SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_REMOVE|FAN_MARK_FILESYSTEM,
 			   FAN_FS_ERROR, AT_FDCWD, MOUNT_PATH);
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
