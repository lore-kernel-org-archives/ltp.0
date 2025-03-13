Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CBB4C282DE
	for <ltp@archiver.kernel.org>; Thu, 13 Mar 2025 13:06:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EE8283CA4FC
	for <ltp@archiver.kernel.org>; Thu, 13 Mar 2025 14:06:34 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E84893CA50C
 for <ltp@lists.linux.it>; Thu, 13 Mar 2025 14:04:35 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 613611A0089C
 for <ltp@lists.linux.it>; Thu, 13 Mar 2025 14:04:35 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BD79221197;
 Thu, 13 Mar 2025 13:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1741871053; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5RFiswfoOR0ldoRl5ycc3yZYvUTEstLDkT+w8A9MhCs=;
 b=cUI0xD/nBtS9p5qEHO/3+TvEUuveBI25eWZfySnWTHnN+O5gR+5dal1yDFjJgir/rR2ZsT
 a5FfPK61xrizp1E93vVwbXurz+1zt1KrF4PNETrZSnKz4WuD8l4S34JZpgexNd2aN3dujs
 +AvuQ0hmqSgph+1ITEyj3fwyoXPz6ko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1741871053;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5RFiswfoOR0ldoRl5ycc3yZYvUTEstLDkT+w8A9MhCs=;
 b=3WFsuauiODz2XQbfEwuSo/kkaik+hnJfkiAeLkg1zndJcc6Cdb4SuLX72HBQzUfI9mameF
 IMI+dB+bUpRnR9BA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1741871053; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5RFiswfoOR0ldoRl5ycc3yZYvUTEstLDkT+w8A9MhCs=;
 b=cUI0xD/nBtS9p5qEHO/3+TvEUuveBI25eWZfySnWTHnN+O5gR+5dal1yDFjJgir/rR2ZsT
 a5FfPK61xrizp1E93vVwbXurz+1zt1KrF4PNETrZSnKz4WuD8l4S34JZpgexNd2aN3dujs
 +AvuQ0hmqSgph+1ITEyj3fwyoXPz6ko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1741871053;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5RFiswfoOR0ldoRl5ycc3yZYvUTEstLDkT+w8A9MhCs=;
 b=3WFsuauiODz2XQbfEwuSo/kkaik+hnJfkiAeLkg1zndJcc6Cdb4SuLX72HBQzUfI9mameF
 IMI+dB+bUpRnR9BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A6F9C13A2C;
 Thu, 13 Mar 2025 13:04:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OML2J83X0mcncwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 13 Mar 2025 13:04:13 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 13 Mar 2025 14:04:01 +0100
MIME-Version: 1.0
Message-Id: <20250313-mmap_suite_refactoring-v4-6-efd682ece39a@suse.com>
References: <20250313-mmap_suite_refactoring-v4-0-efd682ece39a@suse.com>
In-Reply-To: <20250313-mmap_suite_refactoring-v4-0-efd682ece39a@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741871052; l=735;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=Gf3UVAV+ckg3LPq9eUI+UXHSOUMKx3lgKY09SaMm78E=;
 b=xbcpQK/d9m3IsCq61KQRtTHlRYn0Ikw6SOOqJjmOWdNzdBri54NSiiLbe49mVHs2D2uyKpERt
 kNSGxL0XQ5nB/01TFVzUYgOKhYFMEHl/UTGqaapyaBwt4ct7K5wnJTV
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.com:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 6/8] Cleanup mmap19 test
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/syscalls/mmap/mmap19.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/mmap/mmap19.c b/testcases/kernel/syscalls/mmap/mmap19.c
index e622539c32c704bfa557d1d6b93366fea502acb5..77ff771ae20d0dba4e8c17664b52201c5f99e664 100644
--- a/testcases/kernel/syscalls/mmap/mmap19.c
+++ b/testcases/kernel/syscalls/mmap/mmap19.c
@@ -22,7 +22,7 @@
 #define LEN 64
 
 static int f1 = -1, f2 = -1;
-static char *mm1 = NULL, *mm2 = NULL;
+static char *mm1, *mm2;
 
 static const char tmp1[] = "testfile1";
 static const char tmp2[] = "testfile2";

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
