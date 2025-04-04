Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0686AC3601A
	for <ltp@archiver.kernel.org>; Fri,  4 Apr 2025 18:15:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 61E4C3CB33B
	for <ltp@archiver.kernel.org>; Fri,  4 Apr 2025 20:15:02 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5C7823CAF0B
 for <ltp@lists.linux.it>; Fri,  4 Apr 2025 20:14:27 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=gotplt.org (client-ip=23.83.209.82;
 helo=heron.birch.relay.mailchannels.net; envelope-from=siddhesh@gotplt.org;
 receiver=lists.linux.it)
Received: from heron.birch.relay.mailchannels.net
 (heron.birch.relay.mailchannels.net [23.83.209.82])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CC0AA600A12
 for <ltp@lists.linux.it>; Fri,  4 Apr 2025 20:14:26 +0200 (CEST)
X-Sender-Id: dreamhost|x-authsender|siddhesh@gotplt.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 95B0B9027C5;
 Fri,  4 Apr 2025 18:14:24 +0000 (UTC)
Received: from pdx1-sub0-mail-a298.dreamhost.com
 (trex-3.trex.outbound.svc.cluster.local [100.97.35.35])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id 43987901E29;
 Fri,  4 Apr 2025 18:14:24 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1743790464; a=rsa-sha256;
 cv=none;
 b=ugjORicQ73Xp06Fg4YaTVaSFfjxqzgGOTNmnjWcvREeF5demqn7WXyBNDLqXi0fIpsSb4Q
 NfoGRixy+4NU/uWlsrTGECi7B2XjZjkZ8ELvwtDQUkMqqF3ieZhBjG3kgEwxWpUAK+BQOR
 eHauTuy/bToU0bm1pa+0KO4LrtvKW4XYiE3RIpr+PjQLc0zNLm3NraKpXTCORi1kE0SUhx
 WhO7W/hfnBvtBR7O/pbJnQ6G75qRQFxndUSaRKeVWv05WzzonoIOEeHjlEXfzFK5JRTy5D
 Nxb0GWnHwIUEXRf8beOFYIC7iffM4g98gt9nJ5lS480DMNUmEjIbxNScJ4Ppqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1743790464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=6sgilhf7uY4R4wdB6qs3qkfW1CnLEIjqNkbJ1ggTGmY=;
 b=EQ5ub+RYXOEAJ3a9ltzZG0fF+Q55brNdchuD1lm0WHcXTepYo+87H35h8pAyj3e2tF9j52
 zMlFPpjWnS4xEBTSUg6AHz18Vb9hOa6v7nZlKsI8fLrzeLgUVRdpvXsZ88x80Npv4i8y9L
 eY1GSbUhs7/j1Sylc58b7V5iKsvAcZnFmDEUEmmwVmk3g1BRlmhbQ3AYOUytofojpetQU2
 /4iRbwUjNNOgR46Gmo9NZG4cUFzD/Uku/b+7+CRzbgbddRB7AMFdN6HR3duyuz4Xv6l3Qf
 xtqZAQx9mSiJ6snijvVdGEqZIT83WOo0FkLugwvpnVRPekAKt6mOcN4wTL+XtA==
ARC-Authentication-Results: i=1; rspamd-6c88b8f79f-2p85h;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=siddhesh@gotplt.org
X-Sender-Id: dreamhost|x-authsender|siddhesh@gotplt.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|siddhesh@gotplt.org
X-MailChannels-Auth-Id: dreamhost
X-Chemical-Fumbling: 701775283c305133_1743790464489_868102920
X-MC-Loop-Signature: 1743790464489:4087978526
X-MC-Ingress-Time: 1743790464489
Received: from pdx1-sub0-mail-a298.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.97.35.35 (trex/7.0.3); Fri, 04 Apr 2025 18:14:24 +0000
Received: from fedora.redhat.com (unknown [38.23.181.90])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: siddhesh@gotplt.org)
 by pdx1-sub0-mail-a298.dreamhost.com (Postfix) with ESMTPSA id 4ZTmvz5YRzz8m; 
 Fri,  4 Apr 2025 11:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gotplt.org;
 s=dreamhost; t=1743790464;
 bh=6sgilhf7uY4R4wdB6qs3qkfW1CnLEIjqNkbJ1ggTGmY=;
 h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
 b=xVlA0SIRT7L3iBzNjk+1uIuED4UQb0fAQgXt8EsHSkB0SdqS0eDpL5ktg94H5kSdb
 NZVhs//uXjlw9246ozMTJbBbwFrbR9c0HbCVH2gE9tWDCQYGtAWpRGNGy35C7blvZz
 FxYvrXmMg1R/8UArlPGwHleIk1HYD9ff2b8kYQiK5TABVV2ODj5KPt0lKLeXUN/y0L
 vyR36QWhQkvhsgr1zTO6rdVU/xTbJGwG0Lwjz6fLdRaorkVq9P1yoc4Py+5TR1+kxg
 z8Ml/5LViQyw+cYliKiXzp9GbVWI6Y64wbiv8FDUowa621KsvBqJ00VKprwkYpezt0
 WkxGqAk9k5tAQ==
From: Siddhesh Poyarekar <siddhesh@gotplt.org>
To: ltp@lists.linux.it
Date: Fri,  4 Apr 2025 14:14:05 -0400
Message-ID: <20250404181406.2385612-2-siddhesh@gotplt.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250404181406.2385612-1-siddhesh@gotplt.org>
References: <20250402170718.1710388-1-siddhesh@gotplt.org>
 <20250404181406.2385612-1-siddhesh@gotplt.org>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] cve-2015-3290: Disable AVX for x86_64
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

When the input compiler enables AVX, stack realignment requirements
causes gcc to fail to omit %rbp use, due to which the test fails to
clobber %rbp in inline asm.  Disable AVX to build the test on x86_64 so
that the test continues working.

Signed-off-by: Siddhesh Poyarekar <siddhesh@gotplt.org>
Reviewed-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/cve/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/testcases/cve/Makefile b/testcases/cve/Makefile
index 01b9b9ccb..d545a7f93 100644
--- a/testcases/cve/Makefile
+++ b/testcases/cve/Makefile
@@ -22,6 +22,12 @@ ifneq (,$(filter $(HOST_CPU),x86 x86_64))
 meltdown: CFLAGS += -msse2
 endif
 
+# The test needs to clobber %rbp, which requires frame pointer omission.  Also
+# for x86_64, disable AVX since that could sometimes require a stack
+# realignment, which gets in the way of frame pointer omission.
 cve-2015-3290:	CFLAGS += -pthread -fomit-frame-pointer
+ifneq (,$(filter $(HOST_CPU),x86_64))
+cve-2015-3290: CFLAGS += -mno-avx
+endif
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
