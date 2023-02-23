Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 232B1C636D6
	for <ltp@archiver.kernel.org>; Thu, 23 Feb 2023 01:28:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7A2383CD029
	for <ltp@archiver.kernel.org>; Thu, 23 Feb 2023 02:28:56 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9FD753C1888
 for <ltp@lists.linux.it>; Thu, 23 Feb 2023 02:28:45 +0100 (CET)
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com
 [IPv6:2607:f8b0:4864:20::649])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0D50A20077D
 for <ltp@lists.linux.it>; Thu, 23 Feb 2023 02:28:44 +0100 (CET)
Received: by mail-pl1-x649.google.com with SMTP id
 s8-20020a170902b18800b0019c92f56a8aso3333698plr.22
 for <ltp@lists.linux.it>; Wed, 22 Feb 2023 17:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Cp4249TxeECwZvZz7DnnxDYtvi+RZPx3nNkjpREkBKQ=;
 b=IzvjWRgW5Te50VVktOhdJJ53QwIv/tbNC5MWn2hsBW1xkaU9sedbHy26+4osxxn6vC
 dO5l36m6etSQe1pYxkosn8mN+1jKo3JhBdhA9lEMECw6b8XFzJVuLNfYJuDttVBfV458
 8IrPrzfdZ4vIyM2JDnrtBb0eG1g2JUmWzosgx8+sTA/ybnKaw/9jSyfv0LCVTQf9OcA8
 VuctFYtVewmlLWR7NAhYd0cv2fDj9GIIgUseul0nIh56ehmnw2fUy3O7mxhdzh86UBXE
 4lve0X61sbrcfYyfkdCe89ejRquX2uWPp+8cHvq3d0bRz5jwlTjxu3wQ3vx+L5AaO/cE
 L3sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Cp4249TxeECwZvZz7DnnxDYtvi+RZPx3nNkjpREkBKQ=;
 b=hSwCosLXNoDA49++98iSI5PzvIJQmOux1Jj5Tb7LT83/B1tQXJoX6oBlsaiyLzSrpY
 zCtojD/BvcEzjVo2TbjvQptPzU01QuSwtPJfvwTCcIsp4i0/liBN87bkVIxWWuzKagzU
 3+i2jGaNgiIpeHc+Woo/WjeR0D+BnFCttf1kbgnL4TDOEiWAQJsFE+aRZ4sc2ZtAshsm
 S3t0aVYe62lQvK2nfI4NGV91tSpzJglxXpGIR5wVMed55Ffri0pwQi0tgjBDZGl8G5DT
 CKV/1J9OwQlBhDace68V8pxrzj4yJyAFE+pYPZZizFdYZeACn2U6lIGgL+KpEPRGa+hJ
 q1/w==
X-Gm-Message-State: AO0yUKU2a5qJaIsjBYg+KZi0raGbEw/V+FtqwPAMDPyCrSdE9zhRYcrd
 QfXR4++uB9TZLKare53SB7gVu43szSGkdpY9ZuLKhM+Bk5ahUXg5fxHgxA+4KW0iKeyGeGy+3dL
 +4kpB7+L7a8ivwo2kMm8kZlWyyhlPmPXpPk/b5z73qzkUa7f7lQdbJges
X-Google-Smtp-Source: AK7set8ZwIWIBPqSUBfpCU95liQCW0Bg0d2/scmRxdvSkmnpngAWdhJp3JpbuHMfa2/7cpOTihZldlRsUVU=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:ecce:b0:19c:be03:ce10 with SMTP id
 a14-20020a170902ecce00b0019cbe03ce10mr17321plh.9.1677115723077; Wed, 22 Feb
 2023 17:28:43 -0800 (PST)
Date: Thu, 23 Feb 2023 01:28:39 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230223012839.1857976-1-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] syscall01: use 32bit syscalls if available
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

For 32-bit applications, the getuid/getgid syscalls return 16-bit ids,
and the getuid32 and getgid32 syscalls return 32-bit ids.  When
CONFIG_UID16 is disabled in the kernel, getuid/getgid (16-bit UIDs) are
no longer available.  Thus this test will fail when compiled as 32-bit
and with CONFIG_UID16 disabled.  For 64-bit applications, this is not an
issue because getuid/getgid return 32-bit ids and getuid32/getgid32 are
not defined.

The fix for this is to use getuid32/getgid32 if they are available to
match the behavior of glibc.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 testcases/kernel/syscalls/syscall/syscall01.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/testcases/kernel/syscalls/syscall/syscall01.c b/testcases/kernel/syscalls/syscall/syscall01.c
index 167e6ee86..76e793221 100644
--- a/testcases/kernel/syscalls/syscall/syscall01.c
+++ b/testcases/kernel/syscalls/syscall/syscall01.c
@@ -37,7 +37,11 @@ static void verify_getuid(void)
 	uid_t u1, u2;
 
 	u1 = getuid();
+#ifdef SYS_getuid32
+	u2 = syscall(SYS_getuid32);
+#else
 	u2 = syscall(SYS_getuid);
+#endif
 
 	if (u1 == u2) {
 		tst_res(TPASS, "getuid() == syscall(SYS_getuid)");
@@ -52,7 +56,11 @@ static void verify_getgid(void)
 	gid_t g1, g2;
 
 	g1 = getgid();
+#ifdef SYS_getgid32
+	g2 = syscall(SYS_getgid32);
+#else
 	g2 = syscall(SYS_getgid);
+#endif
 
 	if (g1 == g2) {
 		tst_res(TPASS, "getgid() == syscall(SYS_getgid)");
-- 
2.39.2.637.g21b0678d19-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
