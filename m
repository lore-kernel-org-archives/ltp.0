Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4A3CC76195
	for <ltp@archiver.kernel.org>; Mon, 27 Mar 2023 16:12:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2B2BA3CCBCB
	for <ltp@archiver.kernel.org>; Mon, 27 Mar 2023 18:12:29 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F0DF03CCCF4
 for <ltp@lists.linux.it>; Mon, 27 Mar 2023 18:11:53 +0200 (CEST)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com
 [IPv6:2607:f8b0:4864:20::b4a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A1D3160009E
 for <ltp@lists.linux.it>; Mon, 27 Mar 2023 18:11:53 +0200 (CEST)
Received: by mail-yb1-xb4a.google.com with SMTP id
 i11-20020a256d0b000000b0086349255277so9181055ybc.8
 for <ltp@lists.linux.it>; Mon, 27 Mar 2023 09:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20210112; t=1679933512;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=FkLtaHCwb4+H4c96s1kPfDfzicrJaxUvZt9EyVW2Phs=;
 b=qUw9KZvIGqwDbNV9hFD1uwTursTQF0+TdDJplH2bRIUW643AyQBzi2XtpvvpPwzueP
 krTrOztlCpFTvc+hnhv1Oh03bLJ3f8bSPh0KzKOsPVk9ZhzKVXkjAMEQQKuhE4oBMzHz
 TO/CIXkmU68J2c+znitCj+FBgklgSsk2FqwJ3PlmyeSIVenHoiifB8NoFMNb9RrtL3B9
 qcv4WAfneUHjj+843vVOOYYw0COdo/ombDoM/axiStrSjZSJUgLD2pfZEamFpnRACRBK
 mBJDavMvVU05d38c2NfZN/45X+0f+LDaojhLU/pZKe+t6r8cXlBHB1rQGfmCoYA80+by
 u8tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679933512;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FkLtaHCwb4+H4c96s1kPfDfzicrJaxUvZt9EyVW2Phs=;
 b=RARz7NMUO7Gt1dlaLVWmUbjCM8YYwKcJoJfB90UXjpJ0Ku9sLOoEbT2N2kGRuuyJIN
 Df8ZCx/fbUcdIuEvhLL33YYyiCRcoYB9A0sXIj/gi6307+Dk5fztYIXRXNJ6v1vkhji7
 /cFqU3AuES0CU/OZvhkTUlOKQC5W+lxGYSQu79n9OG+eLSq7ZyIpxPeJ1sS5/NsXdMFr
 Qnta43hIqBtKc7EjcHruRyVKIWfgendGVpkpSJLjwf/rVn0g5PeLBp0D2vQFnQ0OUk90
 dOU5UbP0MJDySn+bo6JFbrvwm26zikSR5Iv53HBqNVW0PYeByKvay06SXBNtCnjIks9i
 6PsQ==
X-Gm-Message-State: AAQBX9frjGC5PdmwpXAjDDBgTEDSV29JXZIKO0v0QRs1HW7Li5C5wf5v
 O3Ls0p5NTvUnjfqXU7Dc8iskfhp0JwF0ESKWqYVIwodTMSccG/Xehn1/maoON3kYDobZh3Wp8ib
 bhX8+H2agtaxH7vbWD2bFev0gMcWPOICZdSiMmDVcXKC92URaBKcxIj5a
X-Google-Smtp-Source: AKy350Y0sQymwKuA15Sr5JqMgIy6MVkne5ECkVZtvP/4hKkR0S2QkJfjCEmNyAt4waGFCnI5C2IhvRYo3/Q=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a81:a805:0:b0:546:6ef:8baf with SMTP id
 f5-20020a81a805000000b0054606ef8bafmr341610ywh.2.1679933512380; Mon, 27 Mar
 2023 09:11:52 -0700 (PDT)
Date: Mon, 27 Mar 2023 16:11:43 +0000
In-Reply-To: <20230327161145.1702680-1-edliaw@google.com>
Mime-Version: 1.0
References: <20230327161145.1702680-1-edliaw@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230327161145.1702680-3-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 2/4] set_dev_loop_path: Change return value to zero
 on success
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

set_dev_loop_path was returning 1 on success and 0 on error, which is
inconsistent with the other functions in this file.  Change it to 0 on
success and 1 on error.

Signed-off-by: Edward Liaw <edliaw@google.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---
 lib/tst_device.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/tst_device.c b/lib/tst_device.c
index 82550dbcd..381b91554 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -69,10 +69,10 @@ static int set_dev_loop_path(int dev, char *path, size_t path_len)
 		snprintf(path, path_len, dev_loop_variants[i], dev);
 
 		if (stat(path, &st) == 0 && S_ISBLK(st.st_mode))
-			return 1;
+			return 0;
 	}
 
-	return 0;
+	return 1;
 }
 
 int tst_find_free_loopdev(char *path, size_t path_len)
@@ -116,7 +116,7 @@ int tst_find_free_loopdev(char *path, size_t path_len)
 	 */
 	for (i = 0; i < 256; i++) {
 
-		if (!set_dev_loop_path(i, buf, sizeof(buf)))
+		if (set_dev_loop_path(i, buf, sizeof(buf)))
 			continue;
 
 		dev_fd = open(buf, O_RDONLY);
-- 
2.40.0.348.gf938b09366-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
