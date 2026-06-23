Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C530CDB470
	for <ltp@archiver.kernel.org>; Tue, 23 Jun 2026 19:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782244222; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=YjR10kPrOp+gt4y/ZOBkWTeRGyg2Xipv+8Q3YUUf7Qc=;
 b=R8Mqp3gRiULMmoD4/FfWvqCQbwbe5ipOqIeaiz87HOsoFFOh/9I1O4wBW4134yh/xllq+
 URyvbQQuqYRtuhXcxIDKooYY633RjhMDP51NEmebWnjF0q0caw6aqdDja2cD5zXlMOmBL+3
 uJebdWVXnFHHDHv9Z61UiOp2efLW9F4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 373743E5937
	for <ltp@archiver.kernel.org>; Tue, 23 Jun 2026 21:50:22 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1310D3E2AA8
 for <ltp@lists.linux.it>; Tue, 23 Jun 2026 21:50:02 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 3789C140074A
 for <ltp@lists.linux.it>; Tue, 23 Jun 2026 21:50:02 +0200 (CEST)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-490b1bbcf3aso1495975e9.1
 for <ltp@lists.linux.it>; Tue, 23 Jun 2026 12:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1782244201; x=1782849001; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+LdagwOxftbq9EwzhIgWWaSDnIdDAm4ohj3xTjYgx2I=;
 b=dXiBh/RCae8fxVDhDbrn/XO1jKoD7TuOpjLgblpN8We1ajIVnY01ScY/24Ey4yHw3q
 glOUrWQagH2GY567neDEz85GghwI+2VmH7mk78iahAVdqsK37iiTAQqt3XTI9C9/JeMB
 lQC51m8XD5joSyrM5GK5vNEdiEtRs2mfGY7eEHhwzQkgSgdz+h/ykgGWjxmNbEukTtAY
 8BMHjQLgceLCEisheqUUe51coS150szFAZTvqcOD9/hF+VQO/YBsW/fR3hTDom3TN6zb
 QM9XzEdBSTs5vX0BEOsvOA2NqPLbi6ULbikU1aiSbCECApJdLQiYca9rTQh6/l7Vkh8E
 tWTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782244201; x=1782849001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+LdagwOxftbq9EwzhIgWWaSDnIdDAm4ohj3xTjYgx2I=;
 b=n2eW9qrGKHlZ+cvGDC82k7BJfFjrkzOEIV6dXjQP7S13W7G5Iey3C99p0q/NhShyVw
 yE9bb6cAKvOnOI2Zk0v0dluQQ6urtyVm/dMYsuZjx+QwB/FzK6HiWajMRSB4/NmvZ/12
 dWdA+ZtZXg26yQvJNq1zaz8rFWNoNZTKizfb+turPWUjx9KqkCSa1dcNr2kgHYMAp8eq
 oRotZS+rfyz/Eu/ecFBHW6/2U7Fv4GCeQ1VgDQRJiYLOsqqn/EP/s0NgsQ+bSZHFu6Ub
 ZzbTrR2P066OxtvF73cShcqyHaovG8qBFQllMJBL/a2LBXqWrtVVuGGS6nutrQDMzJHd
 4gYA==
X-Gm-Message-State: AOJu0YwkywI3X3cuVmjzhs/kkrlPIcF0F4cohNcQN9HrwXwdI5ht15Ve
 s/TKuiBK+Itqe1ti27I6OpAULihV5q/py+o/a32YD5aLAkcXtKsKjaJtK79PcjAZErWYN5ch0U/
 Yel/Kn/Y=
X-Gm-Gg: AfdE7clm2cD9TGMlxm1/qwoSCR3blw0+OZ3C6anEgbfHi6i9ViuMQABOuS04GC8ILcj
 dS4kZ8/jQX1n9DUE9+0WTfB9dutYlw5VgPR+Iz2oi1tjQVRExyD0oQvClToKZwNhEHBamSAnAsj
 7ygkqahtz3fvyXHZnfujLo5M1WJrrBI5NtuUweI71zjP/HHfRQvcciGLKh3zMhxdWfF4g0baCnz
 08lstm+yde5Asv0BB9NYZ0wZT/LIdcjtbXlmYInvELIgA/1mcAfQnGE1usPcJqrUSxqqAPISjn7
 EYr1mU3cN4LBAmtzF4BDfwr4T4k32lnbyO0kbiGCXle/CrFfSRP63V0KHftP4wqzlOCz/qCbve1
 9JqUQlvPcE4irF82hxtK9agzxC8fFed1Un5GYe2VOAdDpM7j/y+H3qTiHwmbABP68C0ES9rshYw
 A=
X-Received: by 2002:a05:600c:a318:b0:492:4c2e:9613 with SMTP id
 5b1f17b1804b1-4924c2e97d2mr184736465e9.18.1782244201367; 
 Tue, 23 Jun 2026 12:50:01 -0700 (PDT)
Received: from localhost ([2a07:b241:1004:8300::1000])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4926064e948sm4961655e9.0.2026.06.23.12.50.00
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 12:50:00 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue, 23 Jun 2026 21:46:09 +0200
Message-ID: <20260623195000.110648-1-avinesh.kumar@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623163144.83028-1-avinesh.kumar@suse.com>
References: <20260623163144.83028-1-avinesh.kumar@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] sendfile09: skip on native 32-bit kernels
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

switch to ".needs_abi_bits = 64" to cover both scenarios.

Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
---
Changes in v2:
- Use .needs_abi_bits field
---
 testcases/kernel/syscalls/sendfile/sendfile09.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/sendfile/sendfile09.c b/testcases/kernel/syscalls/sendfile/sendfile09.c
index 82feaeba0..7e030db4a 100644
--- a/testcases/kernel/syscalls/sendfile/sendfile09.c
+++ b/testcases/kernel/syscalls/sendfile/sendfile09.c
@@ -92,7 +92,7 @@ static struct tst_test test = {
 	.test = run,
 	.tcnt = ARRAY_SIZE(tc),
 	.timeout = 120,
-	.skip_in_compat = 1,
+	.needs_abi_bits = 64,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "5d73320a96fcc"},
 		{}
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
