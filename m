Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BF4CCDB471
	for <ltp@archiver.kernel.org>; Tue, 23 Jun 2026 20:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782245039; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=xtLN4kMj7ZkxEgU4fMLvEbUBnwOfKTFO/Aq8wVEPVpc=;
 b=mef4ZBK366lPBonNjoZJA1LopTnsU7yRTBndtbwmbDQbh93xQliSjyB3/m2sQ07xO63R8
 S10AxktDD+2SOhvvGTSVV23oJZVLz4vDLQxzyZammqzrgNLPsKxBrY5RIxcjmDgW5qO7lfK
 G3WZzYH6qF1YRxymo0Lx31wg4/e4JOU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2B68E3E65F4
	for <ltp@archiver.kernel.org>; Tue, 23 Jun 2026 22:03:59 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6EC3B3E0E1D
 for <ltp@lists.linux.it>; Tue, 23 Jun 2026 22:03:38 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 41EA7200750
 for <ltp@lists.linux.it>; Tue, 23 Jun 2026 22:03:38 +0200 (CEST)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4908b92904fso3226905e9.0
 for <ltp@lists.linux.it>; Tue, 23 Jun 2026 13:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1782245018; x=1782849818; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OYWlH/DY46gUwiMNpdth+vA08XGyJaXk/q1RMxLv5cg=;
 b=WpbvxmFtCV1gBCet11OeG0MwFl2M1bNl1xOYGg7xdJpq3ex+/f9Qc0Apcw/O7z+jYE
 hyTgLqhyW0f5fCNXel9MEJVoBQ8Eq9bIY+o7qM88tDtAZt1+/Dnn/68M8e0eZ6yuObD8
 l5K6E+RklAdOtaPD1K4xotLXUqnazbqBv1pP8/BweOUJdgCbMlurVn297Ho9a6xooYeD
 coFUUh18ISj+z5SaVDoOqNnYXh/oxbnBwGW79SSNuPGaKmoMgoL6b4qKRG+4Nx3tNkyM
 UIyVYMvZi4KY3LPpYxykhmGW9WnA1MCPflXUnCqk+ffSx6qCF4vpInRXhymNs3Evrwm4
 bLww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782245018; x=1782849818;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OYWlH/DY46gUwiMNpdth+vA08XGyJaXk/q1RMxLv5cg=;
 b=Qm+KSekxylTXtUUSEvWTErJJeerJjFbS//NHEVddXbi0/fy9Wr+eyvTLvhUXK2lqKg
 f4VhW7eNCs1HH0jxYyXec1Y2eL+t+oKUDzjedpRIz4gzyGb+tRGBp76fWLqvV/9K01uQ
 RhNIQeWoHmfaRCYBtQnKxGoa6LVeQ8vr0YdgB39mlVHEf33absRYbsBzaJ3YarzxamOg
 ddCno+gRx3pTg2Us7a2nN/Rzihk27Y1HsGnz4bDHLj2MzWDUw3KHOzsgUdoyMbrjaEcI
 uwECcik7uKU/NNdctgFv+FtwX7v0bmvjn0cfgfkdoIZWOzJZZEuYU7S9FHvlcjnko9dn
 jO4Q==
X-Gm-Message-State: AOJu0YyzB/4UcSKzYahZiJlynIxqrp5mEMa9W5/MfdLbjMsXLryk4CHa
 h/PyTlP8TyofFvUV0SFhRiMtXe/vmXUD2ludSXWwl9Ph0lGsc3LIlQ57opjqs4wv8YDJpZXL1HG
 BQkL2Ma0=
X-Gm-Gg: AfdE7cmuM6tS45ipi2pD3HbC9Vz1tg5F4aCsgLx3RHR2G0O2Xgcsycu2+r90E9+VeRz
 dQ4TmyRzGSwRvI0uL/molpFpyUNjWcvpuudcYcSFym1oQRQ4swRFClferfRaOnKEMzbjEOujVpQ
 qp+31sQKDRfHbDz5QbxiU5c3GJ2CxzPzyTgHx3iFrgh0uVBMW1m86ydtjbzOXRcglX41E5sIZcA
 Spsuwnc2L5FVShv8W3GNhvyaVHLHfo2m55gtB+AEPGawsP0WY6nQnTpfCZvPf2TWDOU6d2790lX
 bb5eMuDxNQe1P16OaOq5KD+JUrm68IFAGjwF12OJh7ZdteNNJnT7ObSNekq9Lv/X/OMMzxPtBiy
 fcFhl7pmCAEZRPMaFD1uE9dYrVMvYFn/l9bsk/2+3Yn/xBszgF+lmm/kAKStrhgf3Kgue/wOCO7
 1A3yc4WUs0hQ==
X-Received: by 2002:a05:600c:3e88:b0:489:5022:39a4 with SMTP id
 5b1f17b1804b1-4925b3532ffmr63719985e9.9.1782245017664; 
 Tue, 23 Jun 2026 13:03:37 -0700 (PDT)
Received: from localhost ([2a07:b241:1004:8300::1000])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49240f1f330sm248147765e9.2.2026.06.23.13.03.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 13:03:37 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue, 23 Jun 2026 22:03:35 +0200
Message-ID: <20260623200336.116104-1-avinesh.kumar@suse.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] swapping01.c: use .needs_abi_bits = 64
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

As this test is not designed for 32-bit systems, so this follow
commit 6b7ccccbdaf8 ("swapping01: Use .skip_in_compat = 1")

.skip_in_compat misses native 32-bit; .needs_abi_bits = 64 covers both.

Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
---
 testcases/kernel/mem/swapping/swapping01.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/mem/swapping/swapping01.c b/testcases/kernel/mem/swapping/swapping01.c
index c773f2226..b1489b7cf 100644
--- a/testcases/kernel/mem/swapping/swapping01.c
+++ b/testcases/kernel/mem/swapping/swapping01.c
@@ -174,7 +174,7 @@ static struct tst_test test = {
 	.min_mem_avail = 10,
 	.runtime = 600,
 	.test_all = test_swapping,
-	.skip_in_compat = 1,
+	.needs_abi_bits = 64,
 	.needs_kconfigs = (const char *[]) {
 		"CONFIG_SWAP=y",
 		NULL
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
