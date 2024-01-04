Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F6F5C47074
	for <ltp@archiver.kernel.org>; Thu,  4 Jan 2024 12:23:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D6E553CE709
	for <ltp@archiver.kernel.org>; Thu,  4 Jan 2024 13:23:46 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4EC933CE6DE
 for <ltp@lists.linux.it>; Thu,  4 Jan 2024 13:23:16 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C4A961000958
 for <ltp@lists.linux.it>; Thu,  4 Jan 2024 13:23:15 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2624E1F807;
 Thu,  4 Jan 2024 12:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704370995; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RP0AosVLTnUqVXFX4kE2o5Uror/9pZI0SsliRKUNOQU=;
 b=E3nM4NPZx80tNtvVVb6x10OZRc1cCqODkFMfu59GJ5qgSBCB3pput40i6MHjCYYQLIIyDU
 Mde7LiF7uPDNnnlYBjaoh11LkHA7YfUTw/oArk7XxsjyjtNeSSqEFEXP/QAYDaSVn/AgPU
 B/7U14uJ30aiuUZIR4WEAi57LkW/2Os=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704370995;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RP0AosVLTnUqVXFX4kE2o5Uror/9pZI0SsliRKUNOQU=;
 b=sSgZfIQi3wT57j5wWH6DLSkiYtX6J7EmpuXmAa/QJQi6tQg7KKep3GT9PkwEIAWk9kltE7
 dBzw+brpQXfoTuCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704370995; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RP0AosVLTnUqVXFX4kE2o5Uror/9pZI0SsliRKUNOQU=;
 b=E3nM4NPZx80tNtvVVb6x10OZRc1cCqODkFMfu59GJ5qgSBCB3pput40i6MHjCYYQLIIyDU
 Mde7LiF7uPDNnnlYBjaoh11LkHA7YfUTw/oArk7XxsjyjtNeSSqEFEXP/QAYDaSVn/AgPU
 B/7U14uJ30aiuUZIR4WEAi57LkW/2Os=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704370995;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RP0AosVLTnUqVXFX4kE2o5Uror/9pZI0SsliRKUNOQU=;
 b=sSgZfIQi3wT57j5wWH6DLSkiYtX6J7EmpuXmAa/QJQi6tQg7KKep3GT9PkwEIAWk9kltE7
 dBzw+brpQXfoTuCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B5EBE13C96;
 Thu,  4 Jan 2024 12:23:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IJMxKjKjlmUVFgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 04 Jan 2024 12:23:14 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  4 Jan 2024 13:23:08 +0100
Message-ID: <20240104122308.1158487-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240104122308.1158487-1-pvorel@suse.cz>
References: <20240104122308.1158487-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Bar: +++
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=E3nM4NPZ;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=sSgZfIQi
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [3.49 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BROKEN_CONTENT_TYPE(1.50)[];
 RCPT_COUNT_FIVE(0.00)[5]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.00)[25.48%]
X-Rspamd-Queue-Id: 2624E1F807
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/3] doc: Add info about 'LTP_' and 'TST_' variable
 prefixes
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
 doc/User-Guidelines.asciidoc | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/doc/User-Guidelines.asciidoc b/doc/User-Guidelines.asciidoc
index 63081fdea..9ff9a59e7 100644
--- a/doc/User-Guidelines.asciidoc
+++ b/doc/User-Guidelines.asciidoc
@@ -7,6 +7,10 @@ For running LTP network tests see `testcases/network/README.md`.
 1. Library environment variables
 --------------------------------
 
+Following environment variables are expected to be set by LTP users. Therefore,
+with some exceptions, they have 'LTP_' prefix. Environment variables with 'TST_'
+prefix are used inside LTP shell API and should *not* be set by users.
+
 |==============================================================================
 | 'KCONFIG_PATH'        | The path to the kernel config file, (if not set, it tries
                           the usual paths '/boot/config-RELEASE' or '/proc/config.gz').
@@ -45,7 +49,6 @@ For running LTP network tests see `testcases/network/README.md`.
 | 'LTP_ENABLE_DEBUG'    | Enable debug info (value '1' or 'y').
 |==============================================================================
 
-
 2. Test execution time and timeout
 ----------------------------------
 
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
