Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C69FECDB46F
	for <ltp@archiver.kernel.org>; Tue, 23 Jun 2026 12:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782218917; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=O7n8iieQ/ZoHEIAi/PqgKqi+dity3W4b2LoysDm4Xvs=;
 b=m3dbFCew1WVjoT/MMrOPujsRjXo1DfVQajclgtR/2E9uZnNka3QLWxSfHCU2dbxcpGXQq
 Cz5Bme9RiydpwiHY78T9qr7cYWT6JtULUIOIvnQ/OaehSeca5Z+HVi7qFB8OhenGITG3cnF
 A5nG6qPKTQPCeU9Onp+hq3P7B+X7gm4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 20A993E6579
	for <ltp@archiver.kernel.org>; Tue, 23 Jun 2026 14:48:37 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 35D723E539B
 for <ltp@lists.linux.it>; Tue, 23 Jun 2026 14:48:14 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 05529200089
 for <ltp@lists.linux.it>; Tue, 23 Jun 2026 14:48:13 +0200 (CEST)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4924944fe6bso21654665e9.0
 for <ltp@lists.linux.it>; Tue, 23 Jun 2026 05:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1782218893; x=1782823693; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=qzHAz4OENzbegNsBZ8W4d48/NOXycIX+VDSen6KlTvA=;
 b=CMAxsSlUGuEH1qAX9D5QvgQ8pZydVScDOlEuw3sP/smOdBLAkxifl8wz9WV+WKjTF2
 U0VGyR69HKx9rDwMOhHzNx15bmFtFk0SNsd9wMKaLKu3ympxfikePWPTAN1vLheMVrLB
 3+5IE/dtAIDcfBtIiFtQPw1uQbx0K/wJ6MaY3ze0KQSZGT0TWtOKBrUyHTpQmxneqxbt
 /LaYKk5AOY+Nk8pE3Yubl800t2AdcdT3QRz/k4qg3KWqBIAN+iX58ZFTaTBu82GaGeCn
 IlL0EpHztdtyZvtCbtsuLGvHLjA4XjhgG4mu7aurm5RVABmEcr9PJveCwKKIJLOnB1ss
 5FVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782218893; x=1782823693;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qzHAz4OENzbegNsBZ8W4d48/NOXycIX+VDSen6KlTvA=;
 b=CBO6O2ofRFDNTEfDMLHmoWQCTdpq3xM8cCwgoVvJPR3qHG2EXLuqOmVm8p4UtWDrMJ
 OwPwJhwO3lK+3JRt1TikW/Ooh0RlTo+qzZUx37RVJEseGoBGw3jhLWXNf+Q6PKNc0HzJ
 xPgfT2fBZNHkbEAvShUZpgaPS6NyL89qEGivio7lZDyulau9y2HOJnU4DHyBooVHK3Bu
 T3yOz49GrwZhVMRZHIx5+smIDRjg0SbvZ/8NI5EmcwiwZFWy2NcEnjU3oUPJfQ4HLY1e
 7nXxGYCEPcGrcIrShWhUO8Vv/DLJKO2EJmCM5HYX8AKHz6bV15AHnWe57DmeHyyY2DZ1
 EFsA==
X-Gm-Message-State: AOJu0YwJLf3wOmgSXKxKmRY58x0lKzLYk+ChV+gp9imQA8+r7jPcONwM
 0mvTlUutsXnBeoaAJB/SmgQws8kanK749BWJiFM+XPcDZWTeZa5tSp6vUUt5Y0sslK2+4AK2r/j
 tmhfEg2I=
X-Gm-Gg: AfdE7ckUZg1SU9hO6K06LX+qNsDGp2xsxt8bVfrtaeng3wYkCXwpA2YKmdnTEHrOfue
 IlNJmd0h19E5PGUsNyiPcpSmmv2gCB2h3f6JN9BcjHGi0ISbpqY7DUj7OFnvlmD+vnaYanUdknJ
 VXP8GhT0gQipgPeDNuvIcwtMzdELp2nrhvRtRDIjP2ViLz/TpjCXzNyaNla4GhxZ/Oe37+2HabE
 7XmQkmjynJZ7ZH4YSnx/AheKl4rUQ8B1k2t+6Q2o5jlrEFlNC+c6r6l+biOJqXRHHZF2iUE55QJ
 dbal/lfd5loyiMGf/2Vc/Oa95deD2jK5QTPizmzz5QXq/POXaRoo42e8pAdXcbU9XVZXYR2/Evx
 zvWXif6AIpyVnPMPlDDrWnHZSAgHL3vmGJectqfjaZuHALNMzNdMVvkMaotsvUv7La3JONaYyl9
 I=
X-Received: by 2002:a05:600c:5493:b0:492:1ea2:6258 with SMTP id
 5b1f17b1804b1-49240e7b049mr286143135e9.33.1782218893219; 
 Tue, 23 Jun 2026 05:48:13 -0700 (PDT)
Received: from localhost ([2a07:b241:1004:8300::1000])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46666788282sm52370427f8f.17.2026.06.23.05.48.12
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 05:48:12 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue, 23 Jun 2026 14:48:10 +0200
Message-ID: <20260623124812.46022-1-avinesh.kumar@suse.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] set_mempolicy05: require CONFIG_NUMA
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

On kernels without CONFIG_NUMA=y set_mempolicy() returns ENOSYS,
which the test misreports as TFAIL.

set_mempolicy05.c:105: TFAIL: set_mempolicy should fail with EFAULT or EINVAL, instead returned 38

Add .needs_kconfigs with CONFIG_NUMA=y

Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
---
 testcases/kernel/syscalls/set_mempolicy/set_mempolicy05.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy05.c b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy05.c
index 65061bf3d..6c91beebc 100644
--- a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy05.c
+++ b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy05.c
@@ -115,6 +115,10 @@ static struct tst_test test = {
 		"ppc",
 		NULL
 	},
+	.needs_kconfigs = (const char *const[]){
+		"CONFIG_NUMA=y",
+		NULL
+	},
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "cf01fb9985e8"},
 		{"CVE", "CVE-2017-7616"},
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
