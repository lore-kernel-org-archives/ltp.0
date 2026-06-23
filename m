Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE86FCDB471
	for <ltp@archiver.kernel.org>; Tue, 23 Jun 2026 16:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782232330; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=BpDG0l9CTRMEYLw8uEvqnqDpQrNcF/Z0iaiTXdgWbLo=;
 b=ZhWXreDKP+E9R0Uo/3RS878YvpJO/HOpr5L2KdqkTYnvfouRyy9D0HVRRWsRV1SF1Y0db
 l2Cebm8nAsinRVP3M2S9gNhSdcMEzNxSHu5dJ9Ua5MuWNaE0Z+0uwwEQcngd/0AW4nXNaEm
 XTQE63W8/OYtFcUOEU/JpW538EP2tZE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D2C2E3E65A2
	for <ltp@archiver.kernel.org>; Tue, 23 Jun 2026 18:32:10 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 79D473E2CA7
 for <ltp@lists.linux.it>; Tue, 23 Jun 2026 18:31:47 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D0A061A008A9
 for <ltp@lists.linux.it>; Tue, 23 Jun 2026 18:31:46 +0200 (CEST)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-4645995069bso74649f8f.1
 for <ltp@lists.linux.it>; Tue, 23 Jun 2026 09:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1782232306; x=1782837106; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=FdepdOUcDDDOgi5hqntlkswOTAkU94iJJicwtzGQwsE=;
 b=VxwAtG2aRBj1503tS/7zuhman8g0Gg60s7tcDF+KK/Gp6vB333ai1+3c9yRRKE7dSk
 WetiX/Gj2aw2tyS0D/xZW773qEsujXHHj4eR8OvDymaOjMc1NQyJzZDJSYPtrqcWKXat
 GCDmE8EU7RTl7v6hDX16JK3bNsQJ6A/hrE7G6CyoyLxypFsPkNhrNkJduw4njxjj+vsS
 V1Z5kPIz5cRRlmaNHs7/20PrFy/8rZ6ctsB+8cGWM/K554gB1FRtrPKNbCAKK8c0WDJ3
 qSGbs+pSaWqFjl3RZDdOEbt1eKtHXSL616bOrTI4T5zsIki0BQstY2z0ErF1iCs+KEUc
 59TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782232306; x=1782837106;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FdepdOUcDDDOgi5hqntlkswOTAkU94iJJicwtzGQwsE=;
 b=kCgGtBHlXg8TfFAMQuK2k77yYDxI6SvyzTzbvrJKIPstp8PgtNdx8gKFCNNPzaakK3
 Kc9O4uHkbyvTCOY37NnqqkJf8monpgy/mnHkt+1m6hxZZGCtOqFtZo+GyheTymtCAX6G
 Iw5IRORH7KNKkBqF8Lk+cnE6bMy7jiLg0O2/lvemV9dWJh0pxHvQeEp5R11/dYh1etII
 Xpw9ZMnX7q+vx+xIlwo21TiEV04iA1IZr+nZDFxmGTvzzWyQ8IAAZ67/hHZF49lEzhkx
 MKcKscCSTi10eAST8FtRczxrEbwWGKzNUczFpbmNTd03MwMJ/BEnPtUuZ8ZoioOdySc4
 Jrqw==
X-Gm-Message-State: AOJu0YznJBgQdCMoQ0LakbGbxIih+logRdZynkvCAaokj3eHIyNzLZ4L
 kTXaXS+C7kR/mIHavldQaCfAhsR2jdM/Md6Gagh7XyNnWwLdTUQiaBqHUfPYIhXN66EC4K6NfTp
 iSEKNhso=
X-Gm-Gg: AfdE7cnBX1D+Qi9xOkqztHryr85tfSfvdY119UEbaJbt9ttwdn/nB0LLLbmBtYr70n/
 foJle5pxGEQ71rLmTVSBovypmTWGaaJOHoTjS8C3h7J8V9d2BMKHxDCuDb7EeBSnhpC6aBlcBe1
 mXrisgXdY/qb+wE8mBCrkktt4N9EObrK2JlFn6n+NekdUYgOpB1UW+s3wCaZ4+I2adiCkMtzmQJ
 gxPRd5W1GnkIBRql4Vf8jJrWWa33XWus1ZNoqRsZfQCX+Nely/uEQqapnI1EenGr5ZVIbVpvEu0
 K5Vpn6OykdLe8mzHdBse1ZCgunyDxOetFR+qBWGsFKgDWuRDET7wmzRJyDb7f9Hnw2vr+osZK2T
 Vz50CE7DofbCj0kc2064kJIeEkyVQKtAhW5h+2bOF2BjOFJlIxAUdlOcIkHiklJibD4pnsB7R6X
 o=
X-Received: by 2002:a5d:58e4:0:b0:460:2ee5:67b8 with SMTP id
 ffacd0b85a97d-46add184506mr4416637f8f.36.1782232305995; 
 Tue, 23 Jun 2026 09:31:45 -0700 (PDT)
Received: from localhost ([2a07:b241:1004:8300::1000])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46666c579dfsm37881007f8f.31.2026.06.23.09.31.45
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 09:31:45 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue, 23 Jun 2026 18:31:43 +0200
Message-ID: <20260623163144.83028-1-avinesh.kumar@suse.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] sendfile09: skip on native 32-bit kernels
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
From: Avinesh Kumar via ltp <ltp@lists.linux.it>
Reply-To: Avinesh Kumar <avinesh.kumar@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

this test is already documented as 64-bit only, but
.skip_in_compat only covers 32-bit-on-64-bit. On a native 32-bit
kernel (e.g. i586) it still runs and setup's write() past 2GB fails
with EFBIG (TBROK).

sendfile09.c:49: TBROK: write(3,0x4a8011,1) failed: EFBIG (27)

TCONF on 32-bit kernels via tst_kernel_bits().

Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
---
 testcases/kernel/syscalls/sendfile/sendfile09.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testcases/kernel/syscalls/sendfile/sendfile09.c b/testcases/kernel/syscalls/sendfile/sendfile09.c
index 82feaeba0..50b9c1ca7 100644
--- a/testcases/kernel/syscalls/sendfile/sendfile09.c
+++ b/testcases/kernel/syscalls/sendfile/sendfile09.c
@@ -40,6 +40,9 @@ static void setup(void)
 {
 	int i, fd;
 
+	if (tst_kernel_bits() == 32)
+		tst_brk(TCONF, "Test is only supported on 64-bit kernels");
+
 	if (!tst_fs_has_free(".", 5, TST_GB))
 		tst_brk(TCONF, "Test on large file needs 5G free space");
 
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
