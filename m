Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20922CD98CE
	for <ltp@archiver.kernel.org>; Thu, 11 Jun 2026 16:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781195423; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=+vB48N5z1Cc4zVuksaDSG8KTpyMKF2Lob2S5kD7KD5w=;
 b=cfGDj8yUvy3uvjaARZbQL7Fljdd0UOXXSp2INOqAD+df7QSZj/waD16/B9Vwo6Qy5bWT1
 sw00HO7Mkbz2UURtFsIvS/QtjBqoavneJZDbzo4YoL8cI+qqZzFZaIkm1vQ9omr7GqFJ92y
 dsBW0x/sOtWZtTxUit0bVF/FeESF5wo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2733D3CF807
	for <ltp@archiver.kernel.org>; Thu, 11 Jun 2026 18:30:23 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3679E3C52FE
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 18:30:01 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B910020075A
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 18:30:00 +0200 (CEST)
Received: from Nerpa.tailf9f4a3.ts.net (2.general.phlin.uk.vpn [10.172.194.39])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 053AD3F1AA
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 16:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1781195399;
 bh=jUJD/4nVrDRJYc3sx65tFAK919recfl3Zc9jkvs1mpw=;
 h=From:To:Subject:Date:Message-ID:MIME-Version;
 b=MrEH07f7zIXYC/8UgRisz9JZjPxhiYntiOtWuJRroghtwjBYkOwt2hZEyEsNtOp4H
 iT++1LIYD/e4szzRkeE2oLabEgiCCnfD5yzGWNtanIcR2DtFaeyupGPHtL/MAUebFB
 bRf8t0SalXeiPVFFzpDDxlITtm3IWWLaAxDSvLSeJ5HERfh8e/F3VjoeRXbNNxIF8a
 g2N6aEnUTAPQ8x+Pi6Lt3iMFdO11GJ4dygjTSzFgRa32mt/MtkPJNypixiRlsjsHRL
 KzBQObSlMrq3fL1PqCjmfU8OygZWgXMicY8syPuyAKWWW03LMhGAB9k4JIZrVT5Mrf
 rVLrLqnJvQFJzxM9J6QO+pgn9v10rNpcgPPfkufsGOHyZ2ueaxTjz+dj4boT4/i/N2
 nl70rafTEhCEVsIn4EdV4uMMe/EKznpTWb1PW1coiH0HP8iXtMFj3uBkGZs4iOt4fZ
 b6mA2Hlfp0DYgOKRdFXVdD2/7u5BjDJLalE80QToW/BAhCb0jzciOdHkOtDdQCoqVE
 CPzwaHYui/aJ7EIR5my5qeTkWcLeoPZFDtmzvE+d9lVZ/p8hzrwU0R4sbwrAnzBu6j
 0+cJlmNk2z7EGaWHAtyj4Q1FVMTFKMMc5Xdebq6GWvSYBRcs9SPrBsHdFhR5x5gJKy
 jKCp18XEq0c1d8LTwhTRZltQ=
To: ltp@lists.linux.it
Date: Fri, 12 Jun 2026 00:29:32 +0800
Message-ID: <20260611162932.756328-1-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] pipe15: add min kver v4.4.281
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
From: Po-Hsu Lin via ltp <ltp@lists.linux.it>
Reply-To: Po-Hsu Lin <po-hsu.lin@canonical.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This patch 46c4c9d1beb7 has been backported to stable v4.4 with
commit 7392701d8615 on linux-4.4.y starting from tag v4.4.281 [1]

[1] https://www.kernel.org/pub/linux/kernel/v4.x/ChangeLog-4.4.281

Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 testcases/kernel/syscalls/pipe/pipe15.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/syscalls/pipe/pipe15.c b/testcases/kernel/syscalls/pipe/pipe15.c
index 94b0cb101..2a63ff567 100644
--- a/testcases/kernel/syscalls/pipe/pipe15.c
+++ b/testcases/kernel/syscalls/pipe/pipe15.c
@@ -91,6 +91,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.test_all = run,
 	.cleanup = cleanup,
+	.min_kver = "4.4.281",
 	.tags = (const struct tst_tag[]){
 		{"linux-git", "46c4c9d1beb7"},
 	},
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
