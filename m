Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EED48C53200
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 14:33:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F17BC3E4EE4
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 16:33:30 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F0D1D3E138C
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 16:33:13 +0200 (CEST)
Received: from mail-pz2-x01.google.com (mail-pz2-x01.google.com
 [IPv6:2607:f8b0:4864:3b::1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 466A71400BF9
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 16:33:13 +0200 (CEST)
Received: by mail-pz2-x01.google.com with SMTP id
 41be03b00d2f7-ca7a25cd87dso779857a12.1
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 07:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785335591; x=1785940391; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=P4HewBbnFwm5bCvUnwtChybiE5XL2WeKxcZfQfU7Rhk=;
 b=ZYeWdZslXd3hzZ5/Wezow9V1+GxORBWntk2wB9SgAf4i7e8RFi9lfbpom0ApCUsrI0
 zLv8V55wEuw9QssGpKfgFihUZHEpwjhvon/qZhjnQfYObWdgm1EUX3IaBdn03O01ahRI
 fSnJ4q+btyMZcK7ASfdQGP6oXajRR8X4dkPlZH84FRi5zuCp2bOeiIB/lKh+Hh7aaq7C
 loQmdpwNWMh4SnHk89NZfVqgYv8CF68lWmT86mzQxL3Lbt0d/FLGBmztgK5+Emvk6KlL
 O2TMSxaKZseRvgAOxlO6q73IUgbrCcitaKmuVmlra+FzG1knXHmzQOhMGngS+9Ac9rCm
 Evvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785335591; x=1785940391;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=P4HewBbnFwm5bCvUnwtChybiE5XL2WeKxcZfQfU7Rhk=;
 b=bcT8ElZGVnRwuH0aw+gmIU1WdQMTgmWgqt1UIo8swOXcYmQd2ewXuWng93vCOItN0x
 lFkFXzafHy/HMdXakqlbdRIqaJ5mHql+0GeL87wpUvX0FE1+XofTb9TBN1a92gyzmiyB
 FDqa+hSsBnUM+2C7ifCignpiPbtG4EIzvauTpujLuGyl61QZEJTCOfdmRhbZza7Y6AgY
 3PIPw3syAETqwK7ZIHnjFMFDZTIBgz28qY4EeMpl6wl5RY+FtVHqBekjqSzCNVGPIhNA
 jNVbAteRaEQhq7lqzt2F64ACjJkToUgy+T1nMotbvIq+GYCuN/QWvF/zaXbMMgBX82VJ
 sYsA==
X-Gm-Message-State: AOJu0YzisCjlmTZc9y5pPSatdFKYRpUVYGxcRMmLFVnxPOefaYXo3tMH
 sGP4u1+ri1P/BvkhhQ9bFY2mMgvhM/0z3ZcC5Jfm32q9HvF9cd6HPlNfHR/pq+MvbJW6
X-Gm-Gg: AR+sD112KwFBH7OEzW5OTNqRc+NOQFP1ZNIxtL5Rd0rJ3CTEviiasPBwRShtedSz/mJ
 ip7Y+TQ0UasKW9ay81Ysc+FBx2AbwfacBtI1/l5TmITV24wn0Nr+fmdJtv1CsAKK6AsTkH8n45b
 DEJ792Kc/Z05KfGAjRWq1GGiujtX7LMQjFXbdEzI61N2BD9bhPC1POWEf8BNqsiGtSR6g9qdplo
 b6ouBny8TWJTOSP5ZxwLEcvXdHUCqa0ft/OXV/mJKw7+3ONnT+A8Ok0NBrxiYjOXdcn4t+WA4vf
 Nx8Y/NShqScgshSvxPpvkBrdWNQaiTk+sg3WDwpNI0VEkLbB2R5NOaCbWUmqdY6ajz4+Dz83HRN
 /ZuoPPN7ajhcutPC1vLVQKRKO7kXp//ruDWxgsjNBjjojCu8XjHheCGaeQeta4FLD3m8+Ht9zOV
 v5AtrgMmUlSP8EPWh89iVm3t0q/PVKGFRCWxRpw3pa10/1818ZbRRweMJQeJJVMVvV0Mgwyvnnu
 y9lZXU=
X-Received: by 2002:a05:6a21:6e91:b0:3c3:859b:9178 with SMTP id
 adf61e73a8af0-3c8ba4dc894mr8451489637.34.1785335591552; 
 Wed, 29 Jul 2026 07:33:11 -0700 (PDT)
Received: from localhost.localdomain ([59.16.109.172])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbdba63c743sm1008323a12.26.2026.07.29.07.33.09
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 07:33:10 -0700 (PDT)
From: Jinseok Kim <always.starving0@gmail.com>
To: ltp@lists.linux.it
Date: Wed, 29 Jul 2026 23:32:01 +0900
Message-ID: <20260729143243.8433-1-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v10 1/3] open01: fix cleanup file descriptor check
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

Initialize fd to -1 and check it against -1 in cleanup().

File descriptor 0 is valid, so checking fd > 0 may skip closing an
successfully opened file.

Signed-off-by: Jinseok Kim <always.starving0@gmail.com>
---
 testcases/kernel/syscalls/open/open01.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/open/open01.c b/testcases/kernel/syscalls/open/open01.c
index 1cefb4790..f1a3720aa 100644
--- a/testcases/kernel/syscalls/open/open01.c
+++ b/testcases/kernel/syscalls/open/open01.c
@@ -24,7 +24,7 @@
 #define TEST_FILE	"testfile"
 #define TEST_DIR	"testdir"

-static int fd;
+static int fd = -1;

 static struct tcase {
 	char *filename;
@@ -67,7 +67,7 @@ static void setup(void)

 static void cleanup(void)
 {
-	if (fd > 0)
+	if (fd != -1)
 		SAFE_CLOSE(fd);
 }

--
2.43.0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
