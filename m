Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1795C3DA79
	for <ltp@archiver.kernel.org>; Mon, 15 Jan 2024 13:34:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0395B3CE36B
	for <ltp@archiver.kernel.org>; Mon, 15 Jan 2024 14:34:27 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 92CAF3CCB38
 for <ltp@lists.linux.it>; Mon, 15 Jan 2024 14:34:08 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id F23CF1001120
 for <ltp@lists.linux.it>; Mon, 15 Jan 2024 14:34:07 +0100 (CET)
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1d542701796so44363135ad.1
 for <ltp@lists.linux.it>; Mon, 15 Jan 2024 05:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705325646; x=1705930446; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZDfOjucIAVZj+2eocaWPQAAzptoNtGFIpHNTyBSwXTA=;
 b=b+ir3iFCJPlZ4YhsRHMV2hjhd0+A9u6HuC09lY67Xw49+Ex8GisrtmX4UdZKlf9gvG
 +dezlFVAnYwJoLvaqj7tNfXRSCirKKM3B4NC28+4GHh+x3tFzakqzN87YMcBCuFajFJy
 NKAtGA7LVk1N+Xad52CxS9PUDjTE3uZUmac5NSRdrCYUo/FxteOA07N7O+7V/VTjWc/I
 ZRDWPPpFpowfLQdV3oKCJzmSBXL/SclDzZtjwPROl/L5qwReBYPIYTQU5DyQ4DZlnEI1
 EPZXnsWEvP+rkMmwPEdLidCAljafX0V8YGS369UcQWopofxqNKIasiUCxtQPs2OXVQJk
 7knA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705325646; x=1705930446;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZDfOjucIAVZj+2eocaWPQAAzptoNtGFIpHNTyBSwXTA=;
 b=LT1nF7Sf9L4McDh0tlF1ebYA2EcJnufqdTlqYHmdYSBNGKXvKwjlIJQmgnpc7mQvlC
 XoI0tuyqnZZ8253mQP4Sg7j82qNx7SiGs4m/IN8eBzrqKKIVW/dEV2PSH4rXBp8cWKaJ
 NjC3IJmdnKQ/saoT8FF6gyH6t7BiAMfgayn74WzW0KNHSYc8v9OkYMKqNQLL2m8eAhyc
 pwrm12Vb8ibXavhcd5eVUt/YOtF/diKj/llKJYKvN0xOqDrMEIN0MtRGumOWj2UsjF4q
 viA1O5mYqcQVIu020O78kPiBRRKdGmgslm+3IAxj8/xgqy3CqKzYF6xIildTC37+bWIR
 twdQ==
X-Gm-Message-State: AOJu0YwPY6Dhg/3Onu14jbW+Kfz2tSFQ9+Z24hMqv4mMPM9tCQzmgPxe
 lqek8qR8FScJI782Ay0PAHFblU1VEuY=
X-Google-Smtp-Source: AGHT+IGVL72vPwxLUUpU89fWD4cVokb4xcN4BV0Gl1c4Rqwc5RQ+zbLwLKU1znrAeUAsZbC6BF0QQA==
X-Received: by 2002:a17:902:e881:b0:1d4:868b:830a with SMTP id
 w1-20020a170902e88100b001d4868b830amr2937223plg.101.1705325646137; 
 Mon, 15 Jan 2024 05:34:06 -0800 (PST)
Received: from localhost.localdomain ([106.51.187.155])
 by smtp.gmail.com with ESMTPSA id
 kr16-20020a170903081000b001d4e05828a9sm7643553plb.260.2024.01.15.05.34.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jan 2024 05:34:05 -0800 (PST)
From: Subramanya Swamy <subramanya.swamy.linux@gmail.com>
To: ltp@lists.linux.it
Date: Mon, 15 Jan 2024 08:34:00 -0500
Message-Id: <20240115133400.2431-1-subramanya.swamy.linux@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <70e4ec51-fc24-4e56-a7b3-58aec44643de@gmail.com>
References: <70e4ec51-fc24-4e56-a7b3-58aec44643de@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] read_all :catch alignment faults while reading sys
 entries seen in commit :1bbc21785b7336619fb6a67f1fff5afdaf229acc
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
Cc: Subramanya Swamy <subramanya.swamy.linux@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Subramanya Swamy <subramanya.swamy.linux@gmail.com>
---
 testcases/kernel/fs/read_all/read_all.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/fs/read_all/read_all.c b/testcases/kernel/fs/read_all/read_all.c
index ddc48edd8..e87f47979 100644
--- a/testcases/kernel/fs/read_all/read_all.c
+++ b/testcases/kernel/fs/read_all/read_all.c
@@ -251,17 +251,11 @@ static void read_test(const int worker, const char *const path)
 	worker_heartbeat(worker);
 	/*
 	 * This could catch any alignment faults while reading sys entries
-	 * seen in commit :1bbc21785b7336619fb6a67f1fff5afdaf229acc so reading 1024 bytes
-	 * in chunks of 8 bytes 128 times
+	 * seen in commit :1bbc21785b7336619fb6a67f1fff5afdaf229acc
 	 */
 	char check_buf[7];
-	unsigned int i;
 
-	for (i = 0; i < 128; i++) {
-		count = read(fd, check_buf, sizeof(check_buf));
-		if (count == 0 || count < 0)
-			break;
-	}
+	count = pread(fd, check_buf, sizeof(check_buf), 1);
 
 	count = pread(fd, buf, sizeof(buf) - 1, 0);
 	elapsed = worker_elapsed(worker);
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
