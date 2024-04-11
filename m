Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDBDAC4345F
	for <ltp@archiver.kernel.org>; Thu, 11 Apr 2024 18:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1712859546; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=KoJXdTjS86vxQL1gaenET8PAMftUotrmrk3WxgbMVbo=;
 b=AXg1y4at0ZfWwW+Z/41GXSj+OikHzeV3keqLrn9NhhBFKwV3XYQApHUt9VO7fnPfTXh6v
 hnJsQph7fj1N9hvA+KK2s/xl/bYdjM/f9SV9hzOTzT4m2HAv/oCGLaCuDAviLik+Ym9dEM4
 a+J9RfTRkODEkvL8QASI0XltjnYg3MI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 122463CF866
	for <ltp@archiver.kernel.org>; Thu, 11 Apr 2024 20:19:06 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9D35E3CAB64
 for <ltp@lists.linux.it>; Thu, 11 Apr 2024 20:18:43 +0200 (CEST)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com
 [IPv6:2607:f8b0:4864:20::114a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E4008200C63
 for <ltp@lists.linux.it>; Thu, 11 Apr 2024 20:18:42 +0200 (CEST)
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-61807bac417so589247b3.3
 for <ltp@lists.linux.it>; Thu, 11 Apr 2024 11:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1712859521; x=1713464321; darn=lists.linux.it;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Xo6LzM0FG1avLH3im9nNmpveOG1ygT5D71uX+1H4mqY=;
 b=kE4rIgva6l/xLIa7FgUfchexScURUC4UASGh196mIvxTOeVXE3HwHDgDm7VsEzxEsc
 9L7ZtUndsWWWZ1+LM0tz8ssiQMkcHJU9maf42C2ZPS8RkLuvMHYZmHq4P7uVsYAN2uIj
 2P1hxIUnYDU2a5qicWMg7QLR6mmP0IKJackS9qMWepVhhJsHD6rcsvF5ifrrG5CxZIZr
 IUSharxhEmw06ZQx7rwwGdsqDe5BP+LaJrR+W5IyngfxnLOlKSvEAA0Wwx15PsR+L/rP
 7JQ+ievLSgbqDwR3qZGfCzzc9DcC8kCLL2ZuDat6h4Vyc6r/IcsN3g6ma0E61vWqChJP
 +0+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712859521; x=1713464321;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Xo6LzM0FG1avLH3im9nNmpveOG1ygT5D71uX+1H4mqY=;
 b=R2/SKZ8+NRkCYEfcDkah5q9tWF1+2lMi7fHgzGnQcqorWVKU/e8L8a4Sw20gktKMf7
 +6z2X2NKT1KhJccf3XIQYPf0zUYBTCFK42oEaJZSV4gpZ3G7Nfa/aQN2/SDe7UUsrWs4
 a4wpfNG4ODW9mX9Rg8CMZV/t9gEyouxjwH+6Ps8NEncOJSYInADFogbFpDHL6LKpcf4e
 DkYYq18ABbjljC2fADcmJ6olKuQYzxpOAVnLRYQxvl3Drsq1A0/XAcWm80/uQSt3tFDQ
 1iAJ1brNWz8hBDcezEIh9gNTZsZm7JUUKI/zT8ytCC30hcfXYMmhU4VWI7YVeFgswTT3
 VCBg==
X-Gm-Message-State: AOJu0YysLvtMIqpgzhoBwXgW1U9Hr3DQsz5GfEDINlwffHyT3sxq7PIz
 Nh3dPINkl23ZlubIYWqgnlViRU0lmtlVpBvyMLQm/5DM4CuqTPjSV4hJ9nLR1gfkyx4ZO+nTjio
 ChVJJkUXOIq4wkhHIxca0izTX9trnjn4VgESI7LQleyUGTpn2BB5x5PW85DBmRK52ttRWg13CAp
 Tf0QjbtyN8I7RJsrGuosoKY8DiM6Q=
X-Google-Smtp-Source: AGHT+IEldJwMISWsbsCicP9eSlt4R6veDTFfnGTGYisz1jLiYj6LJK2fpJWhwlSHXkKkc0OxY8lAlOVwVPI=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a0d:cbd4:0:b0:618:1202:3220 with SMTP id
 n203-20020a0dcbd4000000b0061812023220mr48924ywd.7.1712859521581; Thu, 11 Apr
 2024 11:18:41 -0700 (PDT)
Date: Thu, 11 Apr 2024 18:18:38 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240411181838.4157368-1-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] controllers: remove use of LINE_MAX
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

LINE_MAX is not defined in Android's bionic and seems to be a leftover
of POSIX standards.  In this case, replace the use of fgets with
getline, which will resize the line buffer if needed.  Also, drop some
unnecessarily exported variables.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 .../kernel/controllers/libcontrollers/libcontrollers.c    | 8 +++++---
 .../kernel/controllers/libcontrollers/libcontrollers.h    | 2 --
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/controllers/libcontrollers/libcontrollers.c b/testcases/kernel/controllers/libcontrollers/libcontrollers.c
index e9917271c..18f7257cc 100644
--- a/testcases/kernel/controllers/libcontrollers/libcontrollers.c
+++ b/testcases/kernel/controllers/libcontrollers/libcontrollers.c
@@ -39,11 +39,9 @@ char fullpath[PATH_MAX];
 int FLAG;
 volatile int timer_expired = 0;
 int retval;
-unsigned int num_line;
 unsigned int current_shares;
 unsigned int total_shares;
 unsigned int *shares_pointer;
-char target[LINE_MAX];
 struct dirent *dir_pointer;
 
 /*
@@ -133,6 +131,9 @@ int read_file(char *filepath, int action, unsigned int *value)
 	int num_line = 0;
 	FILE *fp;
 	int tmp;
+	size_t len;
+	char *target = NULL;
+
 	switch (action) {
 	case GET_SHARES:
 		tmp = read_shares_file(filepath);
@@ -147,8 +148,9 @@ int read_file(char *filepath, int action, unsigned int *value)
 			error_function("Could not open file", filepath);
 			return -1;
 		}
-		while (fgets(target, LINE_MAX, fp) != NULL)
+		while (getline(&target, &len, fp) != -1)
 			num_line++;
+		free(target);
 		*value = (unsigned int)num_line;
 		if (fclose(fp)) {
 			error_function("Could not close file", filepath);
diff --git a/testcases/kernel/controllers/libcontrollers/libcontrollers.h b/testcases/kernel/controllers/libcontrollers/libcontrollers.h
index 7d7b8324b..548743225 100644
--- a/testcases/kernel/controllers/libcontrollers/libcontrollers.h
+++ b/testcases/kernel/controllers/libcontrollers/libcontrollers.h
@@ -46,11 +46,9 @@ extern char fullpath[PATH_MAX];
 extern int FLAG;
 extern volatile int timer_expired;
 extern int retval;
-extern unsigned int num_line;
 extern unsigned int current_shares;
 extern unsigned int total_shares;
 extern unsigned int *shares_pointer;
-extern char target[LINE_MAX];
 extern struct dirent *dir_pointer;
 
 enum{
-- 
2.44.0.683.g7961c838ac-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
