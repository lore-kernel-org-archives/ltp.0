Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6401FC7619A
	for <ltp@archiver.kernel.org>; Fri, 31 Mar 2023 00:08:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DEFED3CC9CD
	for <ltp@archiver.kernel.org>; Fri, 31 Mar 2023 02:08:07 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1BE503CB84D
 for <ltp@lists.linux.it>; Fri, 31 Mar 2023 02:07:56 +0200 (CEST)
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com
 [IPv6:2607:f8b0:4864:20::64a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 36680601156
 for <ltp@lists.linux.it>; Fri, 31 Mar 2023 02:07:56 +0200 (CEST)
Received: by mail-pl1-x64a.google.com with SMTP id
 q9-20020a170902dac900b001a18ceff5ebso11947598plx.4
 for <ltp@lists.linux.it>; Thu, 30 Mar 2023 17:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20210112; t=1680221274;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=uV/lAHwLGT1u16fGtAjyq6UK5hdbf3tCdb6wLYjz1vA=;
 b=PNAx/+XGK6+0mWWd9bZj91v9SGJhvbVcSWCpN78pv0Vp2jxC8BIcqsEN8e4gzmRHpu
 s1P6Jp+lGQMubaQghbG+tTSos2z0TRgC41BgEPwqwGDBmGs/z1uqoKeKRsSApqkI/aE2
 t+Ygiyge1kIwD9Jg7pHPwjkap65FTmjoeqzCbAPMc41cgIPu28YrCrGcJAyDkqfDfoue
 mA/xllzpCLr+9Jk+zR5JzDwnr0M6m1t3H8BK8sUFWZ95+/O6jg9BtBCdsfzuTEIZ4OzL
 TbYzJXNpher394Hb6QBDsP3Btnc1/xG/9CIXyGfhBRiViVdgvkRU2Man7OXLKDwz1exD
 RVpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680221274;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uV/lAHwLGT1u16fGtAjyq6UK5hdbf3tCdb6wLYjz1vA=;
 b=hWrRImY6qCQMZFkp31pxmmcwluMBfpBalOnER+ylTHT81fuJw0f47jX6xoR30YN6vV
 1m+IaX5kReE2TGzpR6CssPgBV4kFAxSZ1mt77vFfS38X3MtFg4dX/7PAvZ5EW4dLBtUh
 YYyzoQnBgXBnUfU/bsGJLimBGLUCD8BB8Si36ydfaej+c/Spw3t2/fP4wkivQNiK4H/S
 pGsnL6V7ETjwceUW+SLv+xGbnhHwd/xo9QYG7hy6ZHCXwl1HSMI+SEiiAGKxQ1MDp3SG
 VP5PiwglhImD1+lciN6wabNr34IU1M/OnKCU7y/qZGZnnSeJ1FqmYW3DWZKlpozaY+sh
 cxyA==
X-Gm-Message-State: AAQBX9cwUvt5539YpG7AlQsRbrkAkpgu9Xb5E8kJ9kQCl+LsIrGpFJ9w
 NaJI0yguvj2UGWqHo+P+I+d+tQFft0MOl2vjezAzuEK22eQT8ezxbXumXrtO3FJ9GxBEuLMZxgW
 DJQaTcgZeem9QcNQVGkcuO/9eIEI4p+wi8JNI/jSfiX9Da54gaB+iqWhk
X-Google-Smtp-Source: AKy350ZIN3WVbxwzfaB7XgL54iQ58Nwh5Yd0YdWi9wdZCUTDeUA0CG3cUYbXyRn0VZqxRFRlktanN37IU6Q=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:1344:b0:625:a545:3292 with SMTP id
 k4-20020a056a00134400b00625a5453292mr12836864pfu.0.1680221274256; Thu, 30 Mar
 2023 17:07:54 -0700 (PDT)
Date: Fri, 31 Mar 2023 00:07:47 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230331000747.2294390-1-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] setpgid02: use 1 instead of getpgid(1)
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

On Android, init does not setpgid, so getpgid(1) returns 0 and the third
case of setting pgid to a different session's process group does not
behave as expected: setpgid treats 0 as setting the pgid to the pid.

Instead, replace SAFE_GETPGID(1) with the expected value of 1.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 testcases/kernel/syscalls/setpgid/setpgid02.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/setpgid/setpgid02.c b/testcases/kernel/syscalls/setpgid/setpgid02.c
index 4b63afee8..bf7b3176b 100644
--- a/testcases/kernel/syscalls/setpgid/setpgid02.c
+++ b/testcases/kernel/syscalls/setpgid/setpgid02.c
@@ -44,7 +44,7 @@ static void setup(void)
 	 * Getting pgid of init/systemd process to use it as a
 	 * process group from a different session for EPERM test
 	 */
-	init_pgid = SAFE_GETPGID(1);
+	init_pgid = 1;
 }
 
 static void run(unsigned int n)
-- 
2.40.0.348.gf938b09366-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
