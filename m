Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64F17C25B67
	for <ltp@archiver.kernel.org>; Fri, 27 Oct 2023 11:23:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BAC5A3CEBBD
	for <ltp@archiver.kernel.org>; Fri, 27 Oct 2023 13:23:14 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AD82A3C98E7
 for <ltp@lists.linux.it>; Fri, 27 Oct 2023 13:23:03 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 13183603478
 for <ltp@lists.linux.it>; Fri, 27 Oct 2023 13:23:02 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5583A21C4A;
 Fri, 27 Oct 2023 11:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698405781; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0hhV//BTvNYcve/F1OwGhx0cZWEzmF7uxLkjKOH4vaY=;
 b=nCQGHaFZ4gKXseY673zpf1ZdNdlu7Gaip5p6Xi5oNBh13T8P07uLxp1nc8tMGhavpTQWYC
 jfyytiCPEZCgRYUyNw8xk4PVBZgCrUwtMlCOzb0eGGnEi48+XwdMRv+jsXw2RVowYTXHMx
 qlv0j3dvV2eUpn4kgZT8IhelEda4fzw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698405781;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0hhV//BTvNYcve/F1OwGhx0cZWEzmF7uxLkjKOH4vaY=;
 b=ud7p7xviDIhcNAfwni8Sce06brGMRTx2w5beuELeHvrY2PLtszrH2PsFCrG55gsAM93dc0
 NEt5atddPNmY3JBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0113213524;
 Fri, 27 Oct 2023 11:23:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 5HtTOZSdO2XcGgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 27 Oct 2023 11:23:00 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 27 Oct 2023 13:22:56 +0200
Message-ID: <20231027112256.654426-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-2.03 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 R_MISSING_CHARSET(2.50)[]; BROKEN_CONTENT_TYPE(1.50)[];
 NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.99)[-0.986]; MID_CONTAINS_FROM(1.00)[];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-2.95)[99.78%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] tcindex01: Require dummy module
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
Cc: Jozef Pupava <jpupava@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This fixes TBROK on openSUSE JeOS, which does not install dummy module
by default.

Reported-by: Jozef Pupava <jpupava@suse.com>
Suggested-by: Martin Doucha <mdoucha@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/cve/tcindex01.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/testcases/cve/tcindex01.c b/testcases/cve/tcindex01.c
index 91bfafb53..001056820 100644
--- a/testcases/cve/tcindex01.c
+++ b/testcases/cve/tcindex01.c
@@ -128,6 +128,10 @@ static struct tst_test test = {
 		{"/proc/sys/user/max_user_namespaces", "1024", TST_SR_SKIP},
 		{}
 	},
+	.needs_drivers = (const char *const []) {
+		"dummy",
+		NULL
+	},
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "8c710f75256b"},
 		{"CVE", "2023-1829"},
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
