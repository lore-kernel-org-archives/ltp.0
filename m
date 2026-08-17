Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10E9EC5DF66
	for <ltp@archiver.kernel.org>; Mon, 17 Aug 2026 15:41:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1DE773CB6FE
	for <ltp@archiver.kernel.org>; Mon, 17 Aug 2026 17:41:52 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8FAD33C9B32
 for <ltp@lists.linux.it>; Mon, 17 Aug 2026 17:41:24 +0200 (CEST)
Received: from mail-pj2-x02.google.com (mail-pj2-x02.google.com
 [IPv6:2607:f8b0:4864:39::2])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D7AAF60074B
 for <ltp@lists.linux.it>; Mon, 17 Aug 2026 17:41:23 +0200 (CEST)
Received: by mail-pj2-x02.google.com with SMTP id
 d9443c01a7336-2ccbff2e6a7so22284915ad.1
 for <ltp@lists.linux.it>; Mon, 17 Aug 2026 08:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786981281; x=1787586081; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=GN8+Ve2HlI6tOwPocXGM56dXaOi3JjAq8ysGlmMQB5Y=;
 b=bni6KWiinZycSUxx9EZjkbfELirtchilEfVJev9nPbxw91P8v8STSZUaK+jGKDmZqp
 wYRI4jRmCLcuNscTEaMUYxgZw18l4nqjnI+DPuHtPglN/Dt4ofOsjT807zeCLvfsWrLC
 k/zuu2rzPcI/m2YbR8YvpsJ7Gc/0Ud8Ge3hQ6q9vNdQYiuvxFuDzkkEJqCSlE0qFvBWU
 vtP+FJaLEf1ZnV6bR4A3wQCOkczVW+BoY8lClXqH2/yUdrPpROwADKzlCGdlSysiJ0Gu
 JyOTfn1s6KsOHpM722H//MgJqJM7KRVKd8Sa3DTIKbXQkNiT8cgG86e7YVIXr3Vts/TC
 eeMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786981281; x=1787586081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=GN8+Ve2HlI6tOwPocXGM56dXaOi3JjAq8ysGlmMQB5Y=;
 b=cGPgCTd19rbPFcvZLuwyi8IMjToHqi6cPGzXeyRyvqsaOcCoVUJrUlh/3wVpkdlo32
 46Rw8phAnH9cZE4YeMP1E4/72vxk0tgaKLDTrEWtOXpc5AgaKFaq+9IZI/i+tQ+woWJU
 kNJ7r/leSrVXZ3m8CzbkqdaTIIu4KuVwTVzwh/KSgBhpuCqMKaxniV5LQZEjgwG/4fF4
 4hdaC9NhcoDW72krWKyikpfbfq2f+OPG4ajZcS4z0TfDZDDoIJIeBDm1puhkcV961XbM
 PD27SADV7UeTc7qDix1kLrTuOYY0A0MLHjxrvnHQu93VZufS6od2hJaxqN04tQVQ+UjA
 tFLQ==
X-Gm-Message-State: AOJu0Yx/ro+aHvlLXDkNrZCKRraY74bLUJ/5YDTBwnNkoirSoh4FOrdJ
 LoT+mYkKvFCCUt9hJqGRu9C/tXZoB/OcpxtunfkjO+pBslF/rrYpBvYwuzA3nYCaVw==
X-Gm-Gg: AR+sD13CQz8KDc9wBjEGc3fgKApjPRJg62Hw1e9nKlMFdxeKLyN/5XN0/LLfNF/E+8D
 FOGD8L3pdmajt4l6dNeoL8cIXoPcU5NFDHftiqvcadKzsL7O0uRHZuGYJIVc4iT9MFA6sl2VXZx
 4omE3yfxsl4mRGBjGuQYNU5o5bqVVCXMrfzxRJ37RSupTH53MJYEDbZdPwW28G27Q2JQ60p2SMp
 OPlBtpGJZ1BmNubxSUUMZh766xaiGZqY0EXsS18TE4jV3t90FChb/YVCbt8LKFcJ1axKphnwTgn
 6/7FGhgFZERfaJzqNXfr3Q5o85ZrfdFd9uZH2xSRqo8G5Mqlm3+DoL1e5Z5KBVR6NDmq+LKK2bO
 cwVjgl89rsc4jT/47FWdcQsGnAF6SPs1E5g3ftyFDBFsrJGyH6XQjpiGvVsMzh+Gisyh7yO21Tf
 MkujtZ0TO/kE4SS6cKaXs/RoWRofngEAEP5BzOVWAsSOLzxTXx1m4XGFd9wodNJDI10l/6jmPEm
 4hfJ2S3bQ==
X-Received: by 2002:a17:902:e5cd:b0:2c9:bf82:dd11 with SMTP id
 d9443c01a7336-2d5c4f38113mr9785285ad.7.1786981280796; 
 Mon, 17 Aug 2026 08:41:20 -0700 (PDT)
Received: from localhost.localdomain ([211.196.223.197])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d5c1e54330sm5340455ad.44.2026.08.17.08.41.19
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 08:41:20 -0700 (PDT)
From: Jinseok Kim <always.starving0@gmail.com>
To: ltp@lists.linux.it
Date: Tue, 18 Aug 2026 00:40:45 +0900
Message-ID: <20260817154048.3854-2-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260817154048.3854-1-always.starving0@gmail.com>
References: <20260817154048.3854-1-always.starving0@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 2/2] fsx-linux: Fix op_max_size handling in
 op_file_position()
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

op_file_position() ignored op_max_size (-o option), causing operation
sizes to span up to the entire file size. Cap max_len with op_max_size
to honor the user option.

Signed-off-by: Jinseok Kim <always.starving0@gmail.com>
---
 testcases/kernel/fs/fsx-linux/fsx-linux.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/fs/fsx-linux/fsx-linux.c b/testcases/kernel/fs/fsx-linux/fsx-linux.c
index 21390c58c..81aca5dab 100644
--- a/testcases/kernel/fs/fsx-linux/fsx-linux.c
+++ b/testcases/kernel/fs/fsx-linux/fsx-linux.c
@@ -77,9 +77,15 @@ static void op_file_position(
 	struct file_pos_t *pos)
 {
 	long long diff;
+	long long max_len;

 	pos->offset = random() % fsize;
-	pos->size = random() % (fsize - pos->offset);
+
+	max_len = fsize - pos->offset;
+	if (max_len > op_max_size)
+		max_len = op_max_size;
+
+	pos->size = random() % max_len;

 	diff = pos->offset % align;

--
2.43.0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
