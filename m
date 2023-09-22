Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85D13CD4F30
	for <ltp@archiver.kernel.org>; Fri, 22 Sep 2023 07:42:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B71E53CBDF8
	for <ltp@archiver.kernel.org>; Fri, 22 Sep 2023 09:42:57 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AB5CF3CA0FF
 for <ltp@lists.linux.it>; Fri, 22 Sep 2023 09:42:23 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0693914010F8
 for <ltp@lists.linux.it>; Fri, 22 Sep 2023 09:42:22 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DD4541F390
 for <ltp@lists.linux.it>; Fri, 22 Sep 2023 07:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695368541; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AlNR/OYkQA7jIcM4peEbCVfDd86DB/uE76nFTQ8i3h8=;
 b=2eUnJ86n51HjhfwH2V0sY1Ub39SC0L9EA8aYySUcD5WV40NQy6rfbUWk5gU3fzqGz8OK2q
 FdsyJWLJrag0ga4ByjvSS4JHNs7VmFN7RQWdqQesZddbWN+0MAjDBW5s+7QCRFpQTxQ00C
 E4PFtHAMZ4sm/IEWoqthlVoZ/r7j38c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695368541;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AlNR/OYkQA7jIcM4peEbCVfDd86DB/uE76nFTQ8i3h8=;
 b=QFpv+mTeTkVdrVR9+IIHCcijx7XFZSIHSp3GInTM203M4MaPsnl0KyTYeAL/aYZ6Ygmanv
 WI0HNZ7dy/w8PWBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CACA813A64
 for <ltp@lists.linux.it>; Fri, 22 Sep 2023 07:42:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id KBWDMF1FDWWHJQAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Fri, 22 Sep 2023 07:42:21 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 22 Sep 2023 09:42:15 +0200
Message-ID: <20230922074220.12913-2-mdoucha@suse.cz>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230922074220.12913-1-mdoucha@suse.cz>
References: <20230922074220.12913-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/3] madvise11: Fix lockdown check
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

Negative return value from the helper functions means no check could be
performend. Only positive return value indicates that secureboot/lockdown
is active.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/kernel/syscalls/madvise/madvise11.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/madvise/madvise11.c b/testcases/kernel/syscalls/madvise/madvise11.c
index 4c960dd35..3cde85ef5 100644
--- a/testcases/kernel/syscalls/madvise/madvise11.c
+++ b/testcases/kernel/syscalls/madvise/madvise11.c
@@ -325,7 +325,7 @@ static int open_unpoison_pfn(void)
 
 	TEST(open(debugfs_fp, O_WRONLY));
 
-	if (TST_RET == -1 && TST_ERR == EPERM && tst_lockdown_enabled()) {
+	if (TST_RET == -1 && TST_ERR == EPERM && tst_lockdown_enabled() > 0) {
 		tst_res(TINFO,
 			"Cannot restore soft-offlined memory due to lockdown");
 		return TST_RET;
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
