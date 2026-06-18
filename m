Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94B13CD98F2
	for <ltp@archiver.kernel.org>; Thu, 18 Jun 2026 11:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781783248; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=ERa5aBQDaanwldqEnGyK4fWwV8Xp6LlRaI3IHWSpq6A=;
 b=jp7UqIiKkpYoJAuwPwxHRSzCFFE2Zg+1T3nsSlL4VGm0GmwKaMox6FbMgA81iUS2lhX6Y
 MHZms9IB6s5JiAUgcfd9g9YdYoWac3SULbrIJz0hWZ8PJPo9sFkW/1ghjKjGJkYIw2ubYEL
 vj7056goLI615iQTj2xcWRS0Ys05EaM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 90D893E587D
	for <ltp@archiver.kernel.org>; Thu, 18 Jun 2026 13:47:28 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AA9AF3E4E10
 for <ltp@lists.linux.it>; Thu, 18 Jun 2026 13:47:08 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2BCE860066E
 for <ltp@lists.linux.it>; Thu, 18 Jun 2026 13:47:08 +0200 (CEST)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-49222b6e871so7303955e9.3
 for <ltp@lists.linux.it>; Thu, 18 Jun 2026 04:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781783227; x=1782388027; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6myAHU4Z37+CJD6clz4Q+TLXd3KH+2Z4j4Pz1zoe0ns=;
 b=fQ9vKBcsh6mJNpv0zPcEA64HTwaNnEePCOzPdK+2p+4avUEqpsAUskCugQrgSEu/Ee
 Orip5U1P2lS8b6BhH36B3I4R/zMYoB5sbobNrjvjtopmVrTZ6R0vAd2jUaNGHtYQ1CD3
 WG2rUzx0Fy3Z22cz3WfvN0V85RQ0An7k+hovmS2K5I67TcLcqLB3S6zkybOOfML8xbZI
 ZZhOjJfmZEqCedr+EqJFVUT6086ySvu6oYEl2Nr2A6wRenzAsX+QiFcyayhcF7xIyVTo
 aHZ8tEi7vqbzei604rllPevBQRyUAgiU2PXwAarv/Ft+ZwlvPgbRuGgxACq9i1uLuKVS
 2VPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781783227; x=1782388027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6myAHU4Z37+CJD6clz4Q+TLXd3KH+2Z4j4Pz1zoe0ns=;
 b=KHQ9ZZA/zu3bEGripNoToINOatnJrBzadNdNnOJmfBZpMIVXZDhKzq3GBYU7ORS+bX
 ZQu0dPT9C7U7CGSoJBYqb1YWN8/KsVz19zeHptRdtl8M1khQwOsFwRtjaF4hbxLEizQZ
 95qWaX3PLOyZ+qJn6fJpfd86gHrDdtDPxI5x3zMj9wVhxFyIkU9xPK+31pC0e+EshPdD
 tovZyLKB7rEj+2AEUSOU1ZgWqces+41HxOiWbK4OUcBtz/akrzVwhwUncEA7rMCZqLnm
 aBK/c+AqWqZ0/WuwScesPV6PnFS5zu0L500l11cjUEm5IgCKkUF6mfrrlPotLy4KXgXc
 kV8g==
X-Gm-Message-State: AOJu0Yy5hJqHBl07Cbk6QXJ6hHdaTEpLNZfsHlFsUTUYch1hybFDWxwN
 JJyGsWt82MTGVcqXXgOwDoPgk3pvU8vGcRU5K6nweXfRtjq90ihNK2w4Q7ZskeIb/sKimHeYuw5
 0QQPyWJs=
X-Gm-Gg: AfdE7cl0kWCW+Ee3b+CWyecoLKHQOq1yP8/R4T3zPZC4L1eI33u1Ke0m/O6kxX5FyUx
 ln77YFeTmnax4eKA+TZl9Cpw5mgQqwdYkyQ5YeiO3FwPEY8eTn4Zq1t9MzYZrfdlYrnoIKP9uah
 9eEQG0Urd6Grxzt9Y7aGHu5M9xpEO5yCD6e74c5G1/0Ys6F62mSOZvhdErqxTryZI4KHfOuWfo6
 NqAPorqMbupmcCNsp94n6zkSkAw1amYTY2s1/ZGkmiX/mMWLyhTRJuMl5l1BbIPBE2+EVbJL6TT
 UIr+WsUEspY+N6Uog0vBMdZBn1gIHltAb+ug/UN1XlPmZlcKaoI2kD+wEC/Vkz26llKzMtOErH9
 hwCIdhTPHmhzKQk6QggyRh1Y0mmUSQXbeuzLo78wfAIm4C4SdNdWtNoyw/aRDYf+e9ro2jgasP8
 k=
X-Received: by 2002:a05:600c:c178:b0:490:4b89:535d with SMTP id
 5b1f17b1804b1-49234100907mr129765655e9.1.1781783227498; 
 Thu, 18 Jun 2026 04:47:07 -0700 (PDT)
Received: from localhost ([2a07:b241:1004:8300::1000])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2b0d70sm62892247f8f.19.2026.06.18.04.47.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 04:47:07 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu, 18 Jun 2026 13:47:03 +0200
Message-ID: <20260618114706.105296-1-avinesh.kumar@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617210914.4021-1-linuxtestproject.agent@gmail.com>
References: <20260617210914.4021-1-linuxtestproject.agent@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] fw_load0[12]: Skip on Lockdown and Secure Boot
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

these checks were lost in the recent commit converting
these tests to new API.

tst_module.c:139: TINFO: module signature enforcement: off
insmod: ERROR: could not insert module ltp_fw_load.ko: Key was rejected by service
tst_cmd.c:112: TBROK: 'insmod' exited with a non-zero code 1 at tst_cmd.c:112

with checks added:

tst_security.c:104: TINFO: Kernel lockdown: on
tst_test.c:1467: TCONF: Kernel is locked down, skipping test

Fixes: fd2c4d2c25d3 ("fw_load: rewrite test using new LTP API")
Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
---
Changes in v2:
Use .skip_in_lockdown and .skip_in_secureboot fields in struct tst_test
instead of tst_lockdown_enabled()/tst_secureboot_enabled()
---
 testcases/kernel/firmware/fw_load/fw_load01.c | 2 ++
 testcases/kernel/firmware/fw_load/fw_load02.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/testcases/kernel/firmware/fw_load/fw_load01.c b/testcases/kernel/firmware/fw_load/fw_load01.c
index 4b30a3b40..cdf0d387b 100644
--- a/testcases/kernel/firmware/fw_load/fw_load01.c
+++ b/testcases/kernel/firmware/fw_load/fw_load01.c
@@ -108,4 +108,6 @@ static struct tst_test test = {
 		"CONFIG_FW_LOADER=y|CONFIG_FW_LOADER=m",
 		NULL,
 	},
+	.skip_in_lockdown = 1,
+	.skip_in_secureboot = 1,
 };
diff --git a/testcases/kernel/firmware/fw_load/fw_load02.c b/testcases/kernel/firmware/fw_load/fw_load02.c
index 8d2063772..fbcfd3faf 100644
--- a/testcases/kernel/firmware/fw_load/fw_load02.c
+++ b/testcases/kernel/firmware/fw_load/fw_load02.c
@@ -90,4 +90,6 @@ static struct tst_test test = {
 		{FW_PATH, NULL, TST_SR_TCONF},
 		{},
 	},
+	.skip_in_lockdown = 1,
+	.skip_in_secureboot = 1,
 };
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
