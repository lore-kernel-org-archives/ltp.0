Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07B50C3ABC9
	for <ltp@archiver.kernel.org>; Thu, 15 May 2025 14:00:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 96AEE3CC527
	for <ltp@archiver.kernel.org>; Thu, 15 May 2025 16:00:01 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9851D3CC32D
 for <ltp@lists.linux.it>; Thu, 15 May 2025 15:59:44 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C9F2F608A93
 for <ltp@lists.linux.it>; Thu, 15 May 2025 15:59:43 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D356F21134;
 Thu, 15 May 2025 13:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1747317583; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=nl4J19ggSEhW+KEWnVbyClvg+Nw+HAYS3sPk1ZZc44U=;
 b=PdAxjP0/bE3dIMhtzenwPcnQuMVvqfD5oiCVhXxxeBIXX7kv16wJmqrC1dfy0TOPThCp9t
 yASerrPA8emBIfjoW0Uq8097+pORKIsEIZHDyZ+IoG+MjDfmSR/NBX24qA5iDR5rHjxEhJ
 QAkk1W5bdkKp3365OczaNeZAl2cBKyY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1747317583;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=nl4J19ggSEhW+KEWnVbyClvg+Nw+HAYS3sPk1ZZc44U=;
 b=mE53RVydvOIHzSAG/lEf2+BETIIaE3mh8Qh7dtGX0HeKV/DpNA2ErKT4FBn6SYow7xQT4f
 YzMukcvkbj+fdBBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1747317582; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=nl4J19ggSEhW+KEWnVbyClvg+Nw+HAYS3sPk1ZZc44U=;
 b=vo+5DeMVkwGi4TljWdjx0hOasDNg0hz+0tpHwXmfvDN3L2iwdqAzWrJVJ7VkvOYw/chlwX
 ECxAhzg/dM6WVKFUHxpJTMPwkzDBzx/s0XXs1uyQn4nyyUbVb6DqjiViEz5oIyhiN7QDc6
 TeZ6d2fZdGup7Jog7rbAvNQYnQsG/v0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1747317582;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=nl4J19ggSEhW+KEWnVbyClvg+Nw+HAYS3sPk1ZZc44U=;
 b=e5RiXchTKXkKdTp9DcA3rOd266qviHc2auHLhCGlHr1mvqJXc7oJabw8DOJwZQat8OiLLf
 ljSzcWQYXAe6t9CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0FADA137E8;
 Thu, 15 May 2025 13:59:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id NtlhAU7zJWhLKAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 15 May 2025 13:59:42 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 15 May 2025 15:59:34 +0200
Message-ID: <20250515135934.498583-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] lib: Add LTP_ENABLE_DEBUG to doc
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
Based on Cyril's patch:
https://patchwork.ozlabs.org/project/ltp/patch/20250515103146.14950-1-chrubis@suse.cz/
https://lore.kernel.org/ltp/20250515103146.14950-1-chrubis@suse.cz/

 lib/tst_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 297c376da1..fbaf34acff 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -614,6 +614,7 @@ static void print_help(void)
 	fprintf(stderr, "KCONFIG_PATH            Specify kernel config file\n");
 	fprintf(stderr, "KCONFIG_SKIP_CHECK      Skip kernel config check if variable set (not set by default)\n");
 	fprintf(stderr, "LTPROOT                 Prefix for installed LTP (default: /opt/ltp)\n");
+	fprintf(stderr, "LTP_ENABLE_DEBUG        When set to 1 or y enables debug info\n");
 	fprintf(stderr, "LTP_COLORIZE_OUTPUT     Force colorized output behaviour (y/1 always, n/0: never)\n");
 	fprintf(stderr, "LTP_DEV                 Path to the block device to be used (for .needs_device)\n");
 	fprintf(stderr, "LTP_DEV_FS_TYPE         Filesystem used for testing (default: %s)\n", DEFAULT_FS_TYPE);
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
