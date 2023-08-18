Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A76A0C05052
	for <ltp@archiver.kernel.org>; Fri, 18 Aug 2023 07:13:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E090E3CCB20
	for <ltp@archiver.kernel.org>; Fri, 18 Aug 2023 09:13:38 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EAA5A3CCA77
 for <ltp@lists.linux.it>; Fri, 18 Aug 2023 09:13:28 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 163D61A01001
 for <ltp@lists.linux.it>; Fri, 18 Aug 2023 09:13:27 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 502CA2186E;
 Fri, 18 Aug 2023 07:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1692342807; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=plzMVeTqiBnXVEorLCZjl9TbaadASqd/mx6rwJslqE0=;
 b=1SzJ6u2f/SgK74lIeuxHq8J35n0qkaoPuj8jMUjBkp/7Q3bLJOvWo002ylNHttXWD1Yvkv
 WHmC35klIqCZHDtTzTc7+lxr0WVFllF8J7U6FmNwzWkecYo6b+lY2hkinoBgNAH0B7DdSw
 80Vjp6/x/LwDSxeD7sMzz6Wkw0i/2BI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1692342807;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=plzMVeTqiBnXVEorLCZjl9TbaadASqd/mx6rwJslqE0=;
 b=J0AUWPYn8uKHlHsHTOGSsIfL0o9KR7j8pw8onFw4Pi3483TytSdClXDQoe1vo23Ig4/ArL
 +C+Ap3SM3bQ0JEAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 30B8913441;
 Fri, 18 Aug 2023 07:13:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id tqWeChca32SSZQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 18 Aug 2023 07:13:27 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 18 Aug 2023 09:13:23 +0200
Message-Id: <20230818071323.89606-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] sched_rr_get_interval01: Add another kernel tag
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

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
NOTE: git commit is still only in next tree [1], although hash will be
very likely the same, we should wait until it get to mainline (likely in
6.6-rc1).

I suppose we could write a test for another Cyril's fix [2].

Kind regards,
Petr

[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20230817&id=c7fcb99877f9f542c918509b2801065adcaf46fa
[2] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20230817&id=c1fc6484e1fb7cc2481d169bfef129a1b0676abe

 .../syscalls/sched_rr_get_interval/sched_rr_get_interval01.c     | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c
index 5ef3541ca..597de4665 100644
--- a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c
+++ b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c
@@ -79,6 +79,7 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "975e155ed873"},
+		{"linux-git", "c7fcb99877f9"},
 		{}
 	}
 };
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
