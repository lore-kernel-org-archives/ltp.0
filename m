Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EAECCD6E7E
	for <ltp@archiver.kernel.org>; Wed, 11 Oct 2023 15:29:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EEB513CFFFF
	for <ltp@archiver.kernel.org>; Wed, 11 Oct 2023 17:29:14 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6DC153C8B01
 for <ltp@lists.linux.it>; Wed, 11 Oct 2023 17:29:04 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C298F1000D06
 for <ltp@lists.linux.it>; Wed, 11 Oct 2023 17:29:03 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8CFA21FEE9;
 Wed, 11 Oct 2023 15:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1697038142; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8byMzWtXGnYA5cKmjri/1VsBC2M1FEzMFM2gqzs5x0M=;
 b=ct+vtCxORWOuCuDacR/Dw+vtACe5RZixH6le8VKwXjQyhvHcYHATuYpnMt/IT9/Td/jR05
 qN0G5yOQ8vCM36QBndB6hVwCCRmzNHqPAYiKD82tsYVlPbz9f1VvGqYmaC/5/5J0LeyOVq
 O/zjhVkAhN+vOL+eh6mS9n+YtbwSSBI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1697038142;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8byMzWtXGnYA5cKmjri/1VsBC2M1FEzMFM2gqzs5x0M=;
 b=LtdRk7I295oO/8HeyTRPJ++BHBVFWDg22A8M0dTGiAnlejpDCby/MU8qlZhhrXP0uei+7r
 jZu6GkKYlAKk1wBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 71561138EF;
 Wed, 11 Oct 2023 15:29:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Une5Gj6/JmVUDgAAMHmgww
 (envelope-from <mkittler@suse.de>); Wed, 11 Oct 2023 15:29:02 +0000
From: Marius Kittler <mkittler@suse.de>
To: ltp@lists.linux.it
Date: Wed, 11 Oct 2023 17:29:00 +0200
Message-ID: <20231011152900.4274-1-mkittler@suse.de>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Avoid swapon01 failing with EPERM
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

* Simply require root permissions like the other swapon tests do
* Fixes #1091

Signed-off-by: Marius Kittler <mkittler@suse.de>
---
 testcases/kernel/syscalls/swapon/swapon01.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/syscalls/swapon/swapon01.c b/testcases/kernel/syscalls/swapon/swapon01.c
index c334ae246..b5c3f359c 100644
--- a/testcases/kernel/syscalls/swapon/swapon01.c
+++ b/testcases/kernel/syscalls/swapon/swapon01.c
@@ -40,6 +40,7 @@ static void setup(void)
 }
 
 static struct tst_test test = {
+	.needs_root = 1,
 	.needs_tmpdir = 1,
 	.test_all = verify_swapon,
 	.setup = setup
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
