Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90F03C25B48
	for <ltp@archiver.kernel.org>; Fri, 27 Oct 2023 19:00:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8DC1F3CEBD0
	for <ltp@archiver.kernel.org>; Fri, 27 Oct 2023 21:00:46 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A8D4A3CEB92
 for <ltp@lists.linux.it>; Fri, 27 Oct 2023 21:00:35 +0200 (CEST)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com
 [IPv6:2607:f8b0:4864:20::b4a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id ECBB314052EA
 for <ltp@lists.linux.it>; Fri, 27 Oct 2023 21:00:34 +0200 (CEST)
Received: by mail-yb1-xb4a.google.com with SMTP id
 3f1490d57ef6-da03ef6fc30so1953152276.0
 for <ltp@lists.linux.it>; Fri, 27 Oct 2023 12:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1698433233; x=1699038033; darn=lists.linux.it;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Dkel4jZSQrDdLpbKeuMoJIMf8FcRGVYxfYcDMYt6U5k=;
 b=d7eyyyDB29H7Bhlwpb2Jp46NIVoRLoM6UeLsgr3So3OCdc8dsHpRp8ygd/PI9BkeqN
 125UzLaL6l+6YRJOqjs4nMqNFlSJz/rFjTYfVEKpIOZJ6Qfkxg6sLwAVqzDl+tWqwCGm
 OfQ9k4XU2ggebkNCifMWUu0dUHMaE7E5lN3nS6S+ySksazgnd85YlL9yP4ueLibSTcKe
 scz7pyDSmqVZXjMQI1VeNClShVMwmefAoCCEFyfmkXCmoR5x3CWp6oWMmPuLpCq6OxIR
 F364/PPUBBYw38jHwN8pY92QeMVraG2q0Q2J0uVQz2DNdR8W9OZ+dVvEnkfTPAuEqVEb
 f1EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698433233; x=1699038033;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Dkel4jZSQrDdLpbKeuMoJIMf8FcRGVYxfYcDMYt6U5k=;
 b=P/mQDJBy1YyydJbn7GOq71NWAXI9kxK5UAdvoNDmh3gM7qSOpxToRiTzusj7BAt0uY
 PHPD1CtuGzuYIYF1FKAJnz3mxkaVrDomm/Uky+9ZI55LPutdyxr8BIKu8TBH4eO1aZwx
 UVISCMXcRpexVC4miQGscAPXk0aZjczCpz1ItT3ogTNISalZfeadah8ilRsSVQb5QS00
 4aJatF7Fxr6v51sURl9xAgEphln/da4P1kqneFXJ93xHfUVRD1ZVi/3KmnkjmrILF/FN
 sxxjfQ2oMvSlad3yYqMQYx7x5JP+PYMv5Y025qUP9zOm9dvZkPj4J25eVmrQGAgL0Kwr
 tBbA==
X-Gm-Message-State: AOJu0YwGvWHHEjePqKoGBzNd5cjI7jkOMiofjFgfUekaR3ZkdKa5rokr
 tnD4BPU/t2O7H5PEUjz/IpQovwwBLgUcqqZgau07V+sGBfgzXig+VvmqPVIbsIGFCv6xXtkmTpz
 aU5ZBbncKo2wAnghwm95GFV259zrEWuw/Tvd6f70C69aKJUEdq/FgCWoc
X-Google-Smtp-Source: AGHT+IEdfZXP1NjfYeFlLxgZopqFCTz6O4H9qt5nc56CSiUwWYZiqfDVIqewhSaXBMl+NlI/XDHpzhUpN6I=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6902:a93:b0:d9a:e6ae:ddb7 with SMTP id
 cd19-20020a0569020a9300b00d9ae6aeddb7mr64625ybb.7.1698433233341; Fri, 27 Oct
 2023 12:00:33 -0700 (PDT)
Date: Fri, 27 Oct 2023 19:00:29 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Message-ID: <20231027190029.3820505-1-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] getpgid01: On Android, pgid(1) is 0 instead of 1
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
From: Edward Liaw via ltp <ltp@lists.linux.it>
Reply-To: Edward Liaw <edliaw@google.com>
Cc: kernel-team@android.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Android's init does not call setpgid(0, 0) so it does not have pgid=1.

In either case, the pgid should match /proc/1/stat, so compare
getpgid(1) against that.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 testcases/kernel/syscalls/getpgid/getpgid01.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/getpgid/getpgid01.c b/testcases/kernel/syscalls/getpgid/getpgid01.c
index 479fe5dcb..de05a434b 100644
--- a/testcases/kernel/syscalls/getpgid/getpgid01.c
+++ b/testcases/kernel/syscalls/getpgid/getpgid01.c
@@ -13,6 +13,14 @@
 
 #include "tst_test.h"
 
+static int get_init_pgid()
+{
+	int pgid;
+
+	SAFE_FILE_SCANF("/proc/1/stat", "%*d %*s %*c %*d %d", &pgid);
+	return pgid;
+}
+
 static void run(void)
 {
 	pid_t pid_1, child_pid, pgid;
@@ -37,7 +45,7 @@ static void run(void)
 		TST_EXP_EQ_LI(TST_RET, pgid);
 
 		TST_EXP_PID(getpgid(1));
-		TST_EXP_EQ_LI(TST_RET, 1);
+		TST_EXP_EQ_LI(TST_RET, get_init_pgid());
 	}
 
 	tst_reap_children();
-- 
2.42.0.820.g83a721a137-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
