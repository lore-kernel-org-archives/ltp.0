Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A299C28B20
	for <ltp@archiver.kernel.org>; Wed,  2 Apr 2025 17:07:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 31CDD3CB225
	for <ltp@archiver.kernel.org>; Wed,  2 Apr 2025 19:07:43 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 56D783CAE17
 for <ltp@lists.linux.it>; Wed,  2 Apr 2025 19:07:26 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=gotplt.org (client-ip=23.83.218.254;
 helo=toucan.tulip.relay.mailchannels.net; envelope-from=siddhesh@gotplt.org;
 receiver=lists.linux.it)
Received: from toucan.tulip.relay.mailchannels.net
 (toucan.tulip.relay.mailchannels.net [23.83.218.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3CB601A00F0D
 for <ltp@lists.linux.it>; Wed,  2 Apr 2025 19:07:24 +0200 (CEST)
X-Sender-Id: dreamhost|x-authsender|siddhesh@gotplt.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 3B5632C2C93
 for <ltp@lists.linux.it>; Wed,  2 Apr 2025 17:07:23 +0000 (UTC)
Received: from pdx1-sub0-mail-a226.dreamhost.com
 (trex-1.trex.outbound.svc.cluster.local [100.98.185.235])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id ABEDD2C3958
 for <ltp@lists.linux.it>; Wed,  2 Apr 2025 17:07:22 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1743613642; a=rsa-sha256;
 cv=none;
 b=pPsOENhnHWzStQtsu1FLFk9QotcAvmjeaW7TeM8cDm33wOLKg/h0TGpszLgbxtaNK+lDsY
 IdYIAypAgmdrDJQO4mxChMCxbr0Q28tZ8zky3L/IpI6YuDSxgZRWtY3J+rsry7YTYCgetp
 /kcp9gekgulFamIKpI9Jxx/NSDMhZKOkqCVe6MgpHGYHWR5jtDCcVU5lGU2PAQ0VaeAKTs
 XLBb6/ThQfOHZHKd2oxxEx4fjLFwPyyuIiPItsaB/XQ9ehOWEUwgb3cEl9EPqOBmXySO++
 dlDPDNun0Cw1qRRcdP7VcwqB77iSJzRgtiXxbtE4KGgGya2LKKrC62fEhpBTqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1743613642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:dkim-signature;
 bh=czFdtefyOHnPOIWuSakSMdPSN8oNi5utE6X7tDj9Sg8=;
 b=K5ltaUw3KO8p9dXc9YCb7AcrqGnyXgmX0CR2Ng37e/2Y6HboB4oCFRDxI1GFXEMC9rb6FO
 RES4jNRFGLuFMHNJzphM4nSw376vk25EhI/PWAd4aTO+T8uqb2+H3SjFgEyubRRzX1WELq
 Xoo9wzXMZAN1lDFqvPJJDj4lnXYKiiFQKrbgKBemX5SeZMmGFuyQEusCc69y/8Aqvqmcfw
 ZXK2ce1Xh2utgN3xR3dj3Ziy+QTYvRNk7BR+AYY7Ks+QYTQc8eGbUuhGTK+fTe47W4y2kn
 2vZuxhFdAvjI47VSpy3S9n0LPEnfGsNAeQh/j80s2q6Qctp733FIwgGwl7ZggQ==
ARC-Authentication-Results: i=1; rspamd-85757496c5-d6tch;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=siddhesh@gotplt.org
X-Sender-Id: dreamhost|x-authsender|siddhesh@gotplt.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|siddhesh@gotplt.org
X-MailChannels-Auth-Id: dreamhost
X-Illustrious-Invention: 5168679f5b312ce1_1743613642921_2355643433
X-MC-Loop-Signature: 1743613642921:2126495990
X-MC-Ingress-Time: 1743613642920
Received: from pdx1-sub0-mail-a226.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.98.185.235 (trex/7.0.3); Wed, 02 Apr 2025 17:07:22 +0000
Received: from fedora.redhat.com (unknown [38.23.181.90])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: siddhesh@gotplt.org)
 by pdx1-sub0-mail-a226.dreamhost.com (Postfix) with ESMTPSA id 4ZSWWZ1q9czJj
 for <ltp@lists.linux.it>; Wed,  2 Apr 2025 10:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gotplt.org;
 s=dreamhost; t=1743613642;
 bh=czFdtefyOHnPOIWuSakSMdPSN8oNi5utE6X7tDj9Sg8=;
 h=From:To:Subject:Date:Content-Transfer-Encoding;
 b=lsw7Ul6apckwBvE3v9PtnbamarrmfabIDjVYNKoEYqn390fmN1dhTNay8nyDLDNWM
 wImOHLQvBMUcUjIWq6j+7ARwzFEj8OJbf/cWnbhjAwybnSjyHqC0RVHZiAzBN3Hh38
 5qo6jo47FF4BFgPogRtP0zO6snRXs4iuuEceemurMstcc9nJsdi8L+Se8etyutqVbG
 NPKMbQaz/GTqhLEdh4QEzkCFXm9nwC3t3Gnpjtm2MFyeiJ19kzC2SaRgkrLCHduC3d
 AQOXkNQ63H03/qY9sZn6IcUqv+SwDNtrHfWw1GuEmrH0WIYBTzdU2KU+x5aDUCdYeF
 62mDIWQlzXHzg==
From: Siddhesh Poyarekar <siddhesh@gotplt.org>
To: ltp@lists.linux.it
Date: Wed,  2 Apr 2025 13:07:18 -0400
Message-ID: <20250402170718.1710388-1-siddhesh@gotplt.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] cve-2015-3290: Bump up stack boundary requirement
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

When the input compiler defaults to AVX enabled, stack realignment
requirements causes gcc to fail to omit %rbp use, due to which the test
fails to clobber %rbp in inline asm.  Bump up the preferred stack
boundary to avoid this stack realignment for AVX, so the frame pointer
omission goes through.

Signed-off-by: Siddhesh Poyarekar <siddhesh@gotplt.org>
---
 testcases/cve/Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/testcases/cve/Makefile b/testcases/cve/Makefile
index 01b9b9ccb..06bd1b3db 100644
--- a/testcases/cve/Makefile
+++ b/testcases/cve/Makefile
@@ -22,6 +22,9 @@ ifneq (,$(filter $(HOST_CPU),x86 x86_64))
 meltdown: CFLAGS += -msse2
 endif
 
-cve-2015-3290:	CFLAGS += -pthread -fomit-frame-pointer
+# The test needs to clobber %rbp, which requires frame pointer omission.  Also
+# bump up the preferred stack boundary to ensure that the compiler manages to
+# omit the frame pointer even with AVX enabled.
+cve-2015-3290:	CFLAGS += -pthread -fomit-frame-pointer -mpreferred-stack-boundary=5
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
