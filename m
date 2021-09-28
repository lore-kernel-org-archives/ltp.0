Return-Path: <SRS0=NQiP=OS=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A22CC433EF
	for <ltp@archiver.kernel.org>; Tue, 28 Sep 2021 13:45:46 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33FCF60FE8
	for <ltp@archiver.kernel.org>; Tue, 28 Sep 2021 13:45:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 33FCF60FE8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A7E213CA0A5
	for <ltp@archiver.kernel.org>; Tue, 28 Sep 2021 15:45:42 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 510903C8B74
 for <ltp@lists.linux.it>; Tue, 28 Sep 2021 15:45:33 +0200 (CEST)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id ABEC91001171
 for <ltp@lists.linux.it>; Tue, 28 Sep 2021 15:45:32 +0200 (CEST)
Received: by mail-qt1-x830.google.com with SMTP id l13so19902528qtv.3
 for <ltp@lists.linux.it>; Tue, 28 Sep 2021 06:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CPEuF45pZ1QyhwtyoNRs3fBGMeXDecBNbNV53jSHvEk=;
 b=RMwMKuXP9kpg+xDgXiWKIeyRwYvrmWfaNhuh/4dZONc70oPywU2Z4iioMicpOIjCeh
 nN8AA6TSBaDkUGxVm7cJ4YSAl9pL3gMtHSHx+42IH+O5DCuYdss0tOHRuaf77Smek2qo
 50XCMCKBP4nOow0CC1O4a08fcmjTcpmQwDe0ZmhOOOdNlMfZzKpUqS82eglc+BaoQp6T
 RNKtZMFvxOb0LpmALksvtZLGqe1G6XJJQ6ZC/jNWvtJfd0V9NX8VrSNQaQ0lrRvv3sSh
 1z1a07mMSfLXBR4vw0T8wrAisFurGhFR9hIBEunjDKzm4/JpKQnoIypcYKmU7dThhJfA
 RNYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CPEuF45pZ1QyhwtyoNRs3fBGMeXDecBNbNV53jSHvEk=;
 b=FLBHTHmEomIOyUHdmkmVrd91ZI9pGzsoZ4f9NGn9L/CbAexijzHzMrFHq/6CFXHbr2
 OjvML1gvyDvU6VMQGV4Dd8/JlsB+r3L9e4uxWtfVP8p5qZ2n6V2gA6pRBVcghFaEOCCc
 wqOBm55eIKJ8TiTfdGN5B4cgvKeFKZ8uW1LdQuO/Fn4earwESMYaKezrcnQdM0Ts/OVF
 lSQ1HJfbgagdpEjFrB5B5+par5HwJjy8zV2EzxTfu0n1kyo83XtE/pu56BqkF+O0FdgI
 jt8blLnmzo/ijifJHZccYRQwXcaOynDFPF5UihpWsUu7lmpyT66E1AOWBWMhQAW1EN5/
 42aQ==
X-Gm-Message-State: AOAM533QRafAsUVl+Ptsi4PPO4q9T7rONl/gbmPXup3aDFXmSDVv35dn
 VLiHTAo6IRq/R3dFTxjqZOrjv4IKC4nNKQ==
X-Google-Smtp-Source: ABdhPJzMwQ7630NE0aDytDHePCzbYRfoZ06UkdMzMiaWQ3af4joEljU5spMoXMhBUjvRXZ3HQ1zbBA==
X-Received: by 2002:ac8:4446:: with SMTP id m6mr5676486qtn.330.1632836731445; 
 Tue, 28 Sep 2021 06:45:31 -0700 (PDT)
Received: from maple.netwinder.org (rfs.netwinder.org. [206.248.184.2])
 by smtp.gmail.com with ESMTPSA id 14sm12767646qty.93.2021.09.28.06.45.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Sep 2021 06:45:31 -0700 (PDT)
From: Ralph Siemsen <ralph.siemsen@linaro.org>
To: ltp@lists.linux.it
Date: Tue, 28 Sep 2021 09:45:28 -0400
Message-Id: <20210928134528.2397293-1-ralph.siemsen@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] fallocate06: drop explicit tmpfs size
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

The test does not require 512MB, so drop this specification. Instead
rely on earlier commit 21c8759f4 ("lib: adjust the tmpfs size according
to .dev_min_size and MemAvailable") to set the size.

Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
---
 testcases/kernel/syscalls/fallocate/fallocate06.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/testcases/kernel/syscalls/fallocate/fallocate06.c b/testcases/kernel/syscalls/fallocate/fallocate06.c
index 49ddba4a2..bf0d24328 100644
--- a/testcases/kernel/syscalls/fallocate/fallocate06.c
+++ b/testcases/kernel/syscalls/fallocate/fallocate06.c
@@ -261,7 +261,6 @@ static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(testcase_list),
 	.needs_root = 1,
 	.mount_device = 1,
-	.dev_min_size = 512,
 	.mntpoint = MNTPOINT,
 	.all_filesystems = 1,
 	.setup = setup,
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
