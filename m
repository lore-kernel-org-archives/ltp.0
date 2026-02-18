Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97044E9A047
	for <ltp@archiver.kernel.org>; Wed, 18 Feb 2026 14:48:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1F2C13D0703
	for <ltp@archiver.kernel.org>; Wed, 18 Feb 2026 15:48:37 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 338CD3C60F2
 for <ltp@lists.linux.it>; Wed, 18 Feb 2026 15:48:19 +0100 (CET)
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 96F201A00926
 for <ltp@lists.linux.it>; Wed, 18 Feb 2026 15:48:18 +0100 (CET)
Received: by mail-pl1-x644.google.com with SMTP id
 d9443c01a7336-2aae146b604so39004695ad.3
 for <ltp@lists.linux.it>; Wed, 18 Feb 2026 06:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771426097; x=1772030897; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dqmwXDxqZBwJf3/+hKYNdf7gxwWjRhppj+S2hVOlOP8=;
 b=Gj8yOzv3+3ij8fK/juFKvY5u3bo1ajkDZI8ncO6rHnQpmGxYUJV6a1hZMIyKggQQc4
 VZi/PoX8Rf4qr51ZzJlfL4MyMnmYN1K/ZFIBjdsbvuly5QA9XLL0dKlOIV1pxb0Apw6f
 SfrjqpHRC3+pBg0/p8Gm9rApHaEi6jv+jg9WHvvpegKQSvcDLTXlMOWyDRfK1ZOAaVGO
 1pBxa1ZuxVCF7qmXFNcrRvj+U855/2zc6ie9djEWAq386ywGWDCZoucaasSjA7HCE/Wu
 jivz+PPjAkpYeZuVNpBrjW9pGKAkX74sOaAHXY0yOs+jkQWprmIXtIuNNQTe8t+NUIw9
 olRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771426097; x=1772030897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dqmwXDxqZBwJf3/+hKYNdf7gxwWjRhppj+S2hVOlOP8=;
 b=wMip0oFc+e8f1ebMaxWiM+jLdz2orpYMiG9null9Z6lEAqTEUoDrAElivqJyFsSWOB
 dUdC3owwTfnJh8He0br8TFqa0pIqxHGLKKHpOLijC+FcoHzYFM3OJE67DnyCScYhTJ5m
 I9x1ih07Cbso6kss7wZDSo4PiB5M+5f69KmYi3qy+PvrY3Rh9Xf297EvNoJxLoohoTOs
 c8VPvzHExXer3KFJ6f8nhkaSu4tJYje/kVN7txtcw4qVvOQvO4G9KL0bve1vbfWoyrQg
 RlDliJTR+kQ0e/5dWWWMm9mhgkCAQ3n7GGwmXapJzAX8fXeo0YIb5FEwP/4xbumvOSGV
 JIJQ==
X-Gm-Message-State: AOJu0YytWVvl64K/h0seYEvUGMksinb1w5rc2cU33GGi4dM0hUKoc2G1
 V7DhsX4MFa2w/M5fW6w2JTKOX7rDaMdveXW1ufCe80C7n6wNP3/5kcYh4+X7ZzbReg==
X-Gm-Gg: AZuq6aJ9KxiOj+wTAL2YXkrNHFDJ2X77MkcCfTot/VyNhyR2fYNMF7s8TvLISpEJ8L/
 iDtFVvt+rnvOhI/Nk4tCoxYlLxUuHpRvbHlSDTYhj/eHs6iwX3oOJdNm1gwRusiKoA15hViJ9Tz
 6WbDUPsNq8XPCyOtgOIjCREEhx0isfFsNga1MZckuYNNz0+o6kkAkoo39qakhekSQM6aMCd0iEo
 xxpAAQvihynHgm2I+wQAbP9n91NGis/e8KmkBjEFb9WN7KU9fkB9RVIp91vls2M97WMagDf+AaC
 mukXuKa+Zy5aOJguzOjkVgTe2Zr0wZJvzkHvQsRSZixsThZrsKPkAaK5hK7Y1SBmIml8o/JpQhH
 X0snFkvwT9ul6sSCf9AQct3xqtlwPkEGzMGPsfFOPyRayfHZ06QRx5NqZEwW2m4nEpN8e6WM1Vl
 sRXeKwHlrPCKwAgMdjVd7wbm2lWnJ9LbfH+RCJyxgWNBzYT6xvPyIt
X-Received: by 2002:a17:902:ce0e:b0:2aa:d802:a010 with SMTP id
 d9443c01a7336-2ab4cf4f5f7mr189291885ad.10.1771426096761; 
 Wed, 18 Feb 2026 06:48:16 -0800 (PST)
Received: from localhost.localdomain ([59.16.109.172])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad1a7145cbsm188539455ad.30.2026.02.18.06.48.15
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 06:48:16 -0800 (PST)
From: Jinseok Kim <always.starving0@gmail.com>
To: ltp@lists.linux.it
Date: Wed, 18 Feb 2026 23:47:27 +0900
Message-ID: <20260218144747.2771-2-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260218144747.2771-1-always.starving0@gmail.com>
References: <20260218144747.2771-1-always.starving0@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] open: replace getdtablesize with getrlimit
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

Signed-off-by: Jinseok Kim <always.starving0@gmail.com>
---
 testcases/kernel/syscalls/open/open04.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/open/open04.c b/testcases/kernel/syscalls/open/open04.c
index 5d39c1569..166787518 100644
--- a/testcases/kernel/syscalls/open/open04.c
+++ b/testcases/kernel/syscalls/open/open04.c
@@ -11,6 +11,7 @@

 #include <stdio.h>
 #include <stdlib.h>
+#include <sys/resource.h>
 #include "tst_test.h"

 #define FNAME "open04"
@@ -22,8 +23,10 @@ static char fname[20];
 static void setup(void)
 {
 	int fd;
+	struct rlimit rlim;

-	fds_limit = getdtablesize();
+	SAFE_GETRLIMIT(RLIMIT_NOFILE, &rlim);
+	fds_limit = rlim.rlim_cur;
 	first = SAFE_OPEN(FNAME, O_RDWR | O_CREAT, 0777);

 	fds = SAFE_MALLOC(sizeof(int) * (fds_limit - first));
--
2.43.0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
