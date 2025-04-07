Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CADE1C36010
	for <ltp@archiver.kernel.org>; Mon,  7 Apr 2025 10:25:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 65CBA3CAEED
	for <ltp@archiver.kernel.org>; Mon,  7 Apr 2025 12:25:29 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 36D043C264A
 for <ltp@lists.linux.it>; Mon,  7 Apr 2025 12:24:55 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=gotplt.org (client-ip=23.83.222.30;
 helo=caracal.ash.relay.mailchannels.net; envelope-from=siddhesh@gotplt.org;
 receiver=lists.linux.it)
Received: from caracal.ash.relay.mailchannels.net
 (caracal.ash.relay.mailchannels.net [23.83.222.30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CD4AE1400049
 for <ltp@lists.linux.it>; Mon,  7 Apr 2025 12:24:53 +0200 (CEST)
X-Sender-Id: dreamhost|x-authsender|siddhesh@gotplt.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 4827C220FA;
 Mon,  7 Apr 2025 10:24:52 +0000 (UTC)
Received: from pdx1-sub0-mail-a245.dreamhost.com
 (100-102-53-226.trex-nlb.outbound.svc.cluster.local [100.102.53.226])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id E620C245C8;
 Mon,  7 Apr 2025 10:24:51 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1744021491; a=rsa-sha256;
 cv=none;
 b=nF+mvP8sdfE2ZdPZaHKDnhnj/NHKBTHFGKQFWLXx9toTuwX7FrbOzQHYHTpRI7odaZM3pr
 hhAxW+7KbczgaDvGkNKN2lyd2IIc5QL1yFchgBaK/QSfICQ0nzbYlL1hB7abmJYDx3/l8f
 NkU5ksmDYp4gCyVTDsGvQc86PuilRskBuZKmHlJeIuF2K7aRDselkBVekbqhUfxtXLOEAe
 3+NRp8Kr5fdVnUTtiosPCDDNPfHOWzzwnEGfmuSnTCBB3Vy4Ni2oiq2oLiLVzJIFpMTz3l
 iucZuDqi25JUSCsivnak3MalJp9UfpiukrlS7//8euQGHiJbsLXi2Lj2sf2U8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1744021491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=8NaMi9T3BQmJVlsEa3lbNgApBjJw3QW6L5GQXGvYxB0=;
 b=SSEaYeGMHQ0ONiI1AEtRLweu9yZeLpg5f+HMZ9SB4Dga+XCxorOr/cGCX7Lwa/prpXxDB7
 a2eJqPVkgZKiozoWnRvVCHRXKm7s90W2kZlDfqQ6JyfAfPx2J3y6URGn7l6VcPn56a9Zdx
 3nq87aJ8WV2ycYwKvFIB3wl97qmOpuDQyNjAuoqoKuttEloPWWlxe8DHzApioTsDhf3hWz
 5Z9FlPxsPuDpWAcayC/WV0KhuFRhYxQEM9FIrB41pzfFWP9gspMA0SWV/u2wf6O1SYkoo6
 Y/E6/nqJhbTsAaCiV7kB2+2eDxwBtYkur9xZMq32V3Q+OavW6GwAvkvYqsMVoQ==
ARC-Authentication-Results: i=1; rspamd-7dd6dcd7db-2wrq9;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=siddhesh@gotplt.org
X-Sender-Id: dreamhost|x-authsender|siddhesh@gotplt.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|siddhesh@gotplt.org
X-MailChannels-Auth-Id: dreamhost
X-Harmony-Society: 53060bff0aa97465_1744021492174_3424755728
X-MC-Loop-Signature: 1744021492174:917387490
X-MC-Ingress-Time: 1744021492174
Received: from pdx1-sub0-mail-a245.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.102.53.226 (trex/7.0.3); Mon, 07 Apr 2025 10:24:52 +0000
Received: from fedora.redhat.com (unknown [38.23.181.90])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: siddhesh@gotplt.org)
 by pdx1-sub0-mail-a245.dreamhost.com (Postfix) with ESMTPSA id 4ZWQLq3HS5z55; 
 Mon,  7 Apr 2025 03:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gotplt.org;
 s=dreamhost; t=1744021491;
 bh=8NaMi9T3BQmJVlsEa3lbNgApBjJw3QW6L5GQXGvYxB0=;
 h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
 b=mWXnLbgcTtQDrdb3aXGdg2oHOJ+q5oHp5DRaryot8RUgy1Q42bzDTunJlpzDUMzeh
 ywaJUrB1VoZqQIIDEnnjuItEvDpvAHLXUmveq5mi4ukJ20cod+eDls3Av+SBZxFzXe
 wEBqVceOee8KohXKVwXUm2BphHogwQrSesj2NtYKdyx9QWpBOXnYovjJ2VwlRo4bjX
 1aJgw/3wYeXVBXobb5R2Ddys85RZDmc8Rh0c+LqCRu/39O4knXNAPGJ6EtC4qdv+x4
 Lfixs7jgOkKzDF+MTxoHgQGFu0aDWOdc1ukDcbd4xiEPimMp16OcajWZv/IzdDmohg
 ZfXxuc8h/+2Ug==
From: Siddhesh Poyarekar <siddhesh@gotplt.org>
To: ltp@lists.linux.it
Date: Mon,  7 Apr 2025 06:24:47 -0400
Message-ID: <20250407102448.2605506-2-siddhesh@gotplt.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250407102448.2605506-1-siddhesh@gotplt.org>
References: <20250402170718.1710388-1-siddhesh@gotplt.org>
 <20250407102448.2605506-1-siddhesh@gotplt.org>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/2] cve-2015-3290: Disable AVX for x86_64
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
index 01b9b9ccb..98c38e908 100644
--- a/testcases/cve/Makefile
+++ b/testcases/cve/Makefile
@@ -22,6 +22,12 @@ ifneq (,$(filter $(HOST_CPU),x86 x86_64))
 meltdown: CFLAGS += -msse2
 endif
 
+# The test needs to clobber %rbp, which requires frame pointer omission.  Also
+# for x86_64, disable AVX since that could sometimes require a stack
+# realignment, which gets in the way of frame pointer omission.
 cve-2015-3290:	CFLAGS += -pthread -fomit-frame-pointer
+ifeq ($(HOST_CPU),x86_64)
+cve-2015-3290: CFLAGS += -mno-avx
+endif
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
