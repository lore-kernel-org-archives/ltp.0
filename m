Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A6A5E9D82E
	for <ltp@archiver.kernel.org>; Mon,  6 Apr 2026 02:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1775442966; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=/0W3uNpMbi0l66fktyYx7+nKtPsj97LCP++ulrb4DZE=;
 b=bqoPIcOA8b2TUQqzT/1I2CZfwg7S4wRfgiCyCgqWhV/zDLzojvmwpWwn4ALBcRnrrkZjl
 wEuBkbTPPkqR0m6xfzjOOfVJqf/nhOycLp9ofQjfc9Ys3/pJjyyFwaiApsd5euWcz65Nuzc
 Qy5T/W1Q3eqil6llzNCg9Gw/oD3f2Qg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C75E13E1FC6
	for <ltp@archiver.kernel.org>; Mon,  6 Apr 2026 04:36:06 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 52D843D9251
 for <ltp@lists.linux.it>; Mon,  6 Apr 2026 04:35:43 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7C2336002EB
 for <ltp@lists.linux.it>; Mon,  6 Apr 2026 04:35:42 +0200 (CEST)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4852a9c6309so31859685e9.0
 for <ltp@lists.linux.it>; Sun, 05 Apr 2026 19:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1775442941; x=1776047741; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/CY2DiXiOHL9/Dvkc2QK9TgZjkkjfwyFHYBeByxSDG8=;
 b=fiAzlq/j6RhGawACmKubBqa01E/W5/fqLFUsmVaiqYXDesqir+uN+V97IIwLQwWw1n
 Sxcgb2CcBYYwxIS/RHOx68XMktXeBxw7y3pMdmMfgjUlmChZ1XVInEPyusePFW4lIHIP
 HhTCfenHvDLLHaSNDT9HP6DAi36L3Um2/vId5DaJ1tj/XVQdA4jKrM6aUurKbVIBEH66
 5oPpqr3vzfEYgEQWvlMVxTN0X7bRkkW1n68ZsT/tUPXbRfNawzvNktrmzn/Zd66in32g
 tKtz8eu7lvJFXHP9qjOXWS+wquA3xjEEIVNwFaBtRy8XuuvTUWZegTLZSKXQ1mf3J0pl
 bWbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775442941; x=1776047741;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/CY2DiXiOHL9/Dvkc2QK9TgZjkkjfwyFHYBeByxSDG8=;
 b=XhDDbnOyogRknj8SUNfClPjGXORqW87nuBZUm/bjr88LiR9kl9m46SDNkOoyQwtg8n
 v/bnCfW/stkAZpr4xuziS61iz/NkjWVSbMe41Zd/mRSwrSM6fvNIHKpSkBLZrTQSkVB0
 ljsY6csF1F8sduZaq/gsW/u1ajGWZ6UllHQKzsGPZ5raxsrsAMXZG1zN6qP70oFnhZ6o
 wZBmSMp6MeI1EHt2aXCyq7+zdBhR4QT3VvFMLI9w3U5ybTH9mCxH17j8rU5ojZoREUGG
 u9K+ZfwUmy+9fKelr2k+gRwtdNxeUcWsgbJcpkqnsmh1MBwnunysaHIafs1xbl7HRIHI
 5noA==
X-Gm-Message-State: AOJu0Yzj367TLeavlU5hRaemWJ9ASPIDetL8MERQOJJZXGM6LgL3z6PB
 YCyyhc+6/nYiEYdSRJZfwTM4ZQQILcxOQYv7/x2HSRTqxIKTP00oD6zUEbqxakr4c6AHlwjh9eY
 Ejn4=
X-Gm-Gg: AeBDietOeu/xLzNapsqggco5WlgX8CHa0jZzBgpBCPhMHxdAt3M1ysK6kXhJpwkLEYm
 /vAJG8iJAMVLrUpFbptjzwKtrnABgMMDTNeXOmTj/jOJLREF9CrC0JhTXclPJI9VVVw9+cqMlec
 Ss/MsI9JkbV8Xzb+loFPWS+7k4HRqZXhcZGS3NRWKHTGXawXiWWX6QQpKfLfV1aIi3PE7z/RUIi
 G23yZw2OQfnjrZ+x3bc6xWvaF8RPVEodLKThWEu/rcNg5AsirwwkoG4lDWholOAPwzLgNljsEzC
 RrUtracNIEum4fq6rwPenoBl1w5WTlceKo+bwCqQi+e/Ib7KHqsTDvm4dhZdi7fympK3v+H5ck/
 AyOXaVre/DT5g4JKUToqrpZkiKCarZ7yPgLOsVPOAMveHoImS+jt8gu8Ma1vIBdjHLzC3xRcmtq
 32xc574alFRK/fJk1Xe91tlQ==
X-Received: by 2002:a05:600c:4443:b0:487:20ee:bef6 with SMTP id
 5b1f17b1804b1-48899724fb4mr156678855e9.11.1775442941541; 
 Sun, 05 Apr 2026 19:35:41 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-48899eb50cfsm80915645e9.32.2026.04.05.19.35.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Apr 2026 19:35:41 -0700 (PDT)
To: ltp@lists.linux.it
Date: Mon,  6 Apr 2026 02:35:34 +0000
Message-ID: <20260406023538.14739-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] ioctl_pidfd06: Accept both ESRCH and EREMOTE for
 PIDFD_GET_INFO
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

LTP commit f630471a6520 attempted to handle this using a kernel version
check (7.0.0). However, this is proving unreliable as the change is
appearing in earlier kernel versions (e.g., 6.19.x) due to different
release cycles or backports.

Fixes: f630471a6520 ("ioctl_pidfd06: Select expected errno for PIDFD_GET_INFO across pidns")
Signed-off-by: Wei Gao <wegao@suse.com>
---
 testcases/kernel/syscalls/ioctl/ioctl_pidfd06.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl_pidfd06.c b/testcases/kernel/syscalls/ioctl/ioctl_pidfd06.c
index 0f24d4741..fec85d680 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_pidfd06.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd06.c
@@ -14,7 +14,10 @@
 
 static struct tst_clone_args *args;
 static struct pidfd_info *info;
-static int err_nr = ESRCH;
+static int exp_errnos[] = {
+	ESRCH,
+	EREMOTE,
+};
 
 static void run(void)
 {
@@ -42,7 +45,10 @@ static void run(void)
 	args->exit_signal = SIGCHLD;
 
 	if (!SAFE_CLONE(args)) {
-		TST_EXP_FAIL(ioctl(pidfd, PIDFD_GET_INFO, info), err_nr);
+		TST_EXP_FAIL_ARR(
+				ioctl(pidfd, PIDFD_GET_INFO, info),
+				exp_errnos, ARRAY_SIZE(exp_errnos)
+				);
 		exit(0);
 	}
 
@@ -53,9 +59,6 @@ static void setup(void)
 {
 	if (!ioctl_pidfd_info_exit_supported())
 		tst_brk(TCONF, "PIDFD_INFO_EXIT is not supported by ioctl()");
-
-	if (tst_kvercmp(7, 0, 0) >= 0)
-		err_nr = EREMOTE;
 }
 
 static struct tst_test test = {
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
