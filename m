Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB5BCCD98E1
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 21:05:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 425DE3E5F83
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 23:05:54 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 260433E29B0
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 23:05:08 +0200 (CEST)
Received: from mail-dy1-x1344.google.com (mail-dy1-x1344.google.com
 [IPv6:2607:f8b0:4864:20::1344])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D954A6006ED
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 23:05:07 +0200 (CEST)
Received: by mail-dy1-x1344.google.com with SMTP id
 5a478bee46e88-30bc806fcf8so496370eec.1
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 14:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781643906; x=1782248706; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nNSTOJmJvk5UBCN6uwU/OkTOqvXi7RL+CID24ppwHmA=;
 b=LFGuBbn2nInE9hXeKRnoKEd2kb8VgSbfEqktPP8rHAluOPTz+TlZWmxFRDM9z+iX7B
 yU2DM0rIYTJsEGXxM+fobl1ZUUD71q2c/F6KggfikjqQu5tC1IvxBivVBHzCRb90HIoP
 bSQMcxYRljrdENAR1tS9BmgLbijY3AwAgcjlDOwTtJUy03d1nCs3+X36WJr3jTHlCHYJ
 kwohhS0Xe3rxWIEnBl3YJnn0mWI5b7b6yhwKn770LyPNXDHLgE/a8upogURLo0ujlc+8
 lzS0ylSINpPNEs8IOTCJmf+FE8Y0tKp+TpFakoOdB3zHwrpyRVZx/76AYZZchKBKFGix
 G0YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781643906; x=1782248706;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nNSTOJmJvk5UBCN6uwU/OkTOqvXi7RL+CID24ppwHmA=;
 b=pDYDYv1lRZ6pARIQSYysFMJfb5n50pMIVPS4F+s+ZWjFGHLvvS0ZaSmxug9g7xMRbo
 jGC/aaJ4e26IH+/GJD+nT7fWaI+wUG2b7nTL+Zxx4Q3D6pezh6YN0HBGwrlnvfUXUHLz
 1wREWEwfuTIoVvl79rB8nNH+INLrv1D/mrr7BwxIuWYuG6LmK+MfQT+WLXuoDU6YQgu3
 IUJ+pCkRFWuQep79oTey2bVLvKU15akgresvoe8MS/0neyHBH8s4EEK4lr+0F05I8EpS
 Df0sG2Gizagwe/6gLGw53vf7rriWw5xc43mu1Vj/galhs8ZwxBfeWimanAefKQCW54ls
 jUXw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/+4M1al68ZPr1L8HzaF3xt6NxqU0PLMtiFDRULIvUspZYGEsnP/ThpsUwFYOurhrK6ajo=@lists.linux.it
X-Gm-Message-State: AOJu0YzK70qB7f1fIsg4RjowA/YtHR4rAwV6sfvO/wIEtOZG+mvKAjtv
 UGJuoqTJGnqAr0sjYWOkbA9eAxD0hIEH45rGW2E/w6Cqzu3SpJJxpebO
X-Gm-Gg: Acq92OH/1fIAdR29z/RzT/H6tebhuubI8FY3DdWenaO0SOk44OX5Lss+LQdJQEig5qR
 Pwp6VyhRYVszPK6UVOUv3u57+mcm7H1d9H3dligtDHV8Ep0NVFycjnLkMWp4fLldDDlUfJda+9T
 xjsLYjMO9ejFfq96Ehz7atHCbGqtIwFKbaouMuiHDMydthfJbPIreHDO8XoAKfUB0ZQMDl2ta4F
 1cULAsJrVbAXnK5GkB311fqX102rRCMBsTgoKc/0Fh5IWbT0yYaGszzusc+SMwZNmFTMc/Pwg5O
 RfaWNuJZ5fTCQ0KrJw/VY4MQPjadQ3a/46c0GPpxtSfQ6Bcx4TngdQavqpKyNcSTnRJuizkc9w9
 kIq5TlWRoUME7hF7YHBXqXE08SO03YbBU/S7Xh66Ez+aZOUOEC3X6Qs0yIiHw8wI4iDc9Giur41
 znBjkqIOsIlfQgi04A
X-Received: by 2002:a05:693c:394c:b0:2fc:9aa8:83da with SMTP id
 5a478bee46e88-30bcae24d62mr487464eec.29.1781643905931; 
 Tue, 16 Jun 2026 14:05:05 -0700 (PDT)
Received: from cirno ([2605:52c0:2:2f27:be24:11ff:fe89:6f0f])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081e5d0828sm22231766eec.10.2026.06.16.14.05.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 14:05:05 -0700 (PDT)
From: AnonymeMeow <anonymemeow@gmail.com>
To: jack@suse.cz
Date: Wed, 17 Jun 2026 05:04:44 +0800
Message-ID: <20260616210448.12175-2-anonymemeow@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616210448.12175-1-anonymemeow@gmail.com>
References: <20260616210448.12175-1-anonymemeow@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/5] fanotify20: Skip FAN_REPORT_PIDFD |
 FAN_REPORT_TID test on v7.2+
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
Cc: amir73il@gmail.com, ltp@lists.linux.it, AnonymeMeow <anonymemeow@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

fanotify_init() used to reject FAN_REPORT_PIDFD combined with
FAN_REPORT_TID with EINVAL. Since Linux v7.2, fanotify supports
reporting pidfds for thread IDs, so this combination is expected to
succeed.

Signed-off-by: AnonymeMeow <anonymemeow@gmail.com>
---
 testcases/kernel/syscalls/fanotify/fanotify20.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify20.c b/testcases/kernel/syscalls/fanotify/fanotify20.c
index b32ecf6aa..f395d77ee 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify20.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify20.c
@@ -8,13 +8,15 @@
 
 /*\
  * This source file contains a test case which ensures that the
- * :manpage:`fanotify(7)` API returns an expected error code when provided an
- * invalid initialization flag alongside FAN_REPORT_PIDFD. Additionally, it
- * checks that the operability with existing FAN_REPORT_* flags is maintained
- * and functioning as intended.
+ * :manpage:`fanotify(7)` API returns an expected error code when provided
+ * unsupported initialization flags, e.g. FAN_REPORT_PIDFD combined with
+ * FAN_REPORT_TID. Additionally, it checks that the operability with
+ * supported FAN_REPORT_* flags is maintained and functioning as intended.
  *
  * NOTE: FAN_REPORT_PIDFD support was added in v5.15-rc1 in
  * af579beb666a ("fanotify: add pidfd support to the fanotify API").
+ * FAN_REPORT_PIDFD combined with FAN_REPORT_TID is supported since v7.2-rc1
+ * in 17171128513b ("fanotify: report thread pidfds for FAN_REPORT_TID").
  */
 
 #define _GNU_SOURCE
@@ -45,6 +47,10 @@ static struct test_case_t {
 
 static void do_setup(void)
 {
+	if (tst_kvercmp(7, 2, 0) >= 0)
+		tst_brk(TCONF, "FAN_REPORT_PIDFD | FAN_REPORT_TID is supported "
+			       "since v7.2, skipping test");
+
 	/*
 	 * An explicit check for FAN_REPORT_PIDFD is performed early on in the
 	 * test initialization as it's a prerequisite for all test cases.
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
