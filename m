Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C545C47073
	for <ltp@archiver.kernel.org>; Wed,  3 Jan 2024 12:17:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DE6793CE782
	for <ltp@archiver.kernel.org>; Wed,  3 Jan 2024 13:17:46 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1858B3CB297
 for <ltp@lists.linux.it>; Wed,  3 Jan 2024 13:17:36 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8829F1A01101
 for <ltp@lists.linux.it>; Wed,  3 Jan 2024 13:17:36 +0100 (CET)
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1d4c3393f99so12361445ad.0
 for <ltp@lists.linux.it>; Wed, 03 Jan 2024 04:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704284255; x=1704889055; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OOJsfOtShnIOlRKdDKZHxJ4JrW9dbA0WXPkwjDlBC3c=;
 b=aTQkE85NU5k8qRdvSx5ETJ8eq+g2YTEBKtoyQZ6hcmw1+xwO2DIVNr4cOZLND7/H5k
 Gdy4UsLThEzlFXhgFrtzXTxYA5ELIWT3VBuy8ozjSzdz+OkT0FnhDC4vyBCgk8SO71R5
 o3U1W9s5znyBFVlMeLWh/Z7K8NKon6KsYFF/WU32GSo6sxVEs0f00zbcSCLncX5tcqtf
 tMxZAYyBvrfNjR7+bmownd2SXGpWihAirj5r1XDBkfEzmPDR5U+QscqP87FigaQMqgkk
 SR3nhPVKDyL93rRkSHZ989Oay5j74Mv6B1FPD7Kj+FdPRash5lR9iwS0sz1NIFfhkEuz
 1J0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704284255; x=1704889055;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OOJsfOtShnIOlRKdDKZHxJ4JrW9dbA0WXPkwjDlBC3c=;
 b=wW8lbXy8TqZPmRtcjbjHtGmgdSWzmoJgSoSTzH30/S63aJzxSizvMK9hrSpXtpsd4p
 xumOZnRNN4HUDWz+x2d0ubsp5D/J1NDtQ9fgpQwu3bWO8SLfq/almNOElOvNrbOYYq4X
 /wP+8d2FqeRoUGOkAgkGnyym7ayD2dWWaRqTu0ivg3IHZ3OCSv9X95dEWMFa7gwX3OtM
 IUVHbxf/xw48rm0jyjk/ob/ZvY9SbwrNqDXHPTkjmLqruNlA3DD8fuOBizn419yUGGN8
 3shYqs0Dym+0lOu4PTMGZ13Kz3CCfQyGCKKmBtUqWSmsYUkwaKbfcLLhGrQKt0zKaV9R
 LX4g==
X-Gm-Message-State: AOJu0YyEiZovLHEVyidg7lyBcnCntT1Qh5iVtWfFSk5f4aKtMPVqjxwi
 GpEYP+t831tN4rwq51Lz3bUpbWbK0RA=
X-Google-Smtp-Source: AGHT+IFPkcodSj8O7PSS+RP6F9Bja25hL1fylUrxG5T8VjwpOsUWr8IkaFk7l1NMwMdC0164mlBimw==
X-Received: by 2002:a17:902:e845:b0:1d4:be62:f1d3 with SMTP id
 t5-20020a170902e84500b001d4be62f1d3mr4237903plg.108.1704284254688; 
 Wed, 03 Jan 2024 04:17:34 -0800 (PST)
Received: from localhost.localdomain ([106.51.190.199])
 by smtp.gmail.com with ESMTPSA id
 y8-20020a17090264c800b001d1cd7e4ad2sm24158070pli.125.2024.01.03.04.17.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jan 2024 04:17:34 -0800 (PST)
From: Subramanya Swamy <subramanya.swamy.linux@gmail.com>
To: ltp@lists.linux.it
Date: Wed,  3 Jan 2024 07:17:26 -0500
Message-Id: <20240103121726.1854-1-subramanya.swamy.linux@gmail.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] read_all :catch alignment faults while reading sys
 entries seen in commit :bc21785b7336619fb6a67f1fff5afdaf229acc
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
 testcases/kernel/fs/read_all/read_all.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/fs/read_all/read_all.c b/testcases/kernel/fs/read_all/read_all.c
index 266678ea7..95e3ca275 100644
--- a/testcases/kernel/fs/read_all/read_all.c
+++ b/testcases/kernel/fs/read_all/read_all.c
@@ -249,6 +249,20 @@ static void read_test(const int worker, const char *const path)
 	}
 
 	worker_heartbeat(worker);
+	/*
+	 * This could catch any alignment faults while reading sys entries
+	 * seen in commit :bc21785b7336619fb6a67f1fff5afdaf229acc so reading 1024 bytes
+	 * in chunks of 8 bytes 128 times
+	 */
+	char check_buf[7];
+	unsigned int i;
+
+	for (i = 0; i < 128; i++) {
+		count = read(fd, check_buf, sizeof(check_buf));
+		if (count == 0 || count < 0)
+			break;
+	}
+
 	count = read(fd, buf, sizeof(buf) - 1);
 	elapsed = worker_elapsed(worker);
 
@@ -713,5 +727,5 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.test_all = run,
 	.forks_child = 1,
-	.max_runtime = 100,
+	.max_runtime = 200,
 };
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
