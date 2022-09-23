Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56955C6FA82
	for <ltp@archiver.kernel.org>; Fri, 23 Sep 2022 10:56:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9F1E53CAD9E
	for <ltp@archiver.kernel.org>; Fri, 23 Sep 2022 12:56:42 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 86A573CAD87
 for <ltp@lists.linux.it>; Fri, 23 Sep 2022 12:56:00 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 85A4F60275D
 for <ltp@lists.linux.it>; Fri, 23 Sep 2022 12:56:00 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 443A51FA45;
 Fri, 23 Sep 2022 10:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663930560; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XOUnbXKeP4YlHPDkPd9tOc6BcyPg/Be3DOkbMOKPcok=;
 b=Ty/mMrhIxkHGkI93/Nl+iXZRUefDecaxDdf1OrlMD2x0Aryxi9rRVbMB+iivCveWd3rDO7
 5OfInEcrKKK2vE1jbYmvc6tOpEdtK2WAcgJtPtQT1SVXTvcPSUoM/1JQBRSti3s/4dZFK3
 H77YEV6vKD6mqKMkG8KPo0H9rouNC4s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663930560;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XOUnbXKeP4YlHPDkPd9tOc6BcyPg/Be3DOkbMOKPcok=;
 b=ntFgOk9LIcw99E6XCYGZwYj4pGRogH0B0L/rWJMclv05fdwaxg02XQJoDuyZ1zMbIIKdbu
 yjvHjnP5GDqWRnAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 07D9113AA5;
 Fri, 23 Sep 2022 10:56:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id oDRiAMCQLWMBSwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 23 Sep 2022 10:56:00 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 23 Sep 2022 12:55:54 +0200
Message-Id: <20220923105554.28942-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220923105554.28942-1-pvorel@suse.cz>
References: <20220923105554.28942-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/3] ima_setup.sh: Use tst_supported_fs instead of df
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

LTP prefers it's helpers instead of external dependency
(be friendly for embedded or other minimal environments).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/security/integrity/ima/tests/ima_setup.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
index 055701aff..df3fc5603 100644
--- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -337,7 +337,7 @@ require_evmctl()
 
 # loop device is needed to use only for tmpfs
 TMPDIR="${TMPDIR:-/tmp}"
-if [ "$(df -T $TMPDIR | tail -1 | awk '{print $2}')" != "tmpfs" -a -n "$TST_MOUNT_DEVICE" ]; then
+if tst_supported_fs -d $TMPDIR -s "tmpfs"; then
 	unset TST_MOUNT_DEVICE
 fi
 
-- 
2.37.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
