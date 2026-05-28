Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D700BCD6E44
	for <ltp@archiver.kernel.org>; Thu, 28 May 2026 10:28:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 03B5C3CED73
	for <ltp@archiver.kernel.org>; Thu, 28 May 2026 12:28:37 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6F9BE3CD53A
 for <ltp@lists.linux.it>; Thu, 28 May 2026 12:28:15 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 566062001AC
 for <ltp@lists.linux.it>; Thu, 28 May 2026 12:28:12 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BD80B67081;
 Thu, 28 May 2026 10:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1779964090; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=bNR1vptB+T3lQR+ET+UkimnbuKsydn0Vq9+P9NXsHts=;
 b=ElSly9QIcucrDwzCEissI76dA5OdDSwP9hFVbmCgTlyTpghPH6e/XxktVvBZPisb8kpxhG
 n95twpvvJU+LXQJglWYNWysVjlxLgtuvo+HXBax5NrFN7NOW7WQ8sY4a3wFn/oejmyFJhn
 FoLQK453eRLUQlhvv8QzGEVJXa3u7ZM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1779964090;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=bNR1vptB+T3lQR+ET+UkimnbuKsydn0Vq9+P9NXsHts=;
 b=rXw7jjd0jRhPHEg5hDAz5GFMqspdoSvWPdT7OwH0eZoJntigSk2krArx8/KLX8hUlGKKPd
 5AutzKi2jaS1a0Cw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ElSly9QI;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=rXw7jjd0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1779964090; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=bNR1vptB+T3lQR+ET+UkimnbuKsydn0Vq9+P9NXsHts=;
 b=ElSly9QIcucrDwzCEissI76dA5OdDSwP9hFVbmCgTlyTpghPH6e/XxktVvBZPisb8kpxhG
 n95twpvvJU+LXQJglWYNWysVjlxLgtuvo+HXBax5NrFN7NOW7WQ8sY4a3wFn/oejmyFJhn
 FoLQK453eRLUQlhvv8QzGEVJXa3u7ZM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1779964090;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=bNR1vptB+T3lQR+ET+UkimnbuKsydn0Vq9+P9NXsHts=;
 b=rXw7jjd0jRhPHEg5hDAz5GFMqspdoSvWPdT7OwH0eZoJntigSk2krArx8/KLX8hUlGKKPd
 5AutzKi2jaS1a0Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 82EA95AD35;
 Thu, 28 May 2026 10:28:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id m1J4HboYGGrHBAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 28 May 2026 10:28:10 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 28 May 2026 12:27:57 +0200
Message-ID: <20260528102757.398375-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: BD80B67081
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
 RCPT_COUNT_THREE(0.00)[4]; DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] checkpatch: Disable more kernel specific checks
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

Disable kernel specific checks:
* BIT_MACRO
mmapstress08.c:26: CHECK: Prefer using the BIT macro
=> reports against valid #define GRAN_NUMBER (1<<8)

* PREFER_DEFINED_ATTRIBUTE_MACRO
Kernel has various attribute macros, it does not make sense to check
without syncing the code
(https://github.com/linux-test-project/ltp/issues/1318).

Reported-by: Andrea Cervesato <andrea.cervesato@suse.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
IMHO safe to merge, but sure it can wait after the release.

 .checkpatch.conf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.checkpatch.conf b/.checkpatch.conf
index 4aa6f709b6..4ca32f333e 100644
--- a/.checkpatch.conf
+++ b/.checkpatch.conf
@@ -10,7 +10,7 @@
 --strict
 
 # kernel specific
---ignore PREFER_KERNEL_TYPES,STRCPY,STRLCPY,STRNCPY
+--ignore PREFER_KERNEL_TYPES,STRCPY,STRLCPY,STRNCPY,BIT_MACRO,PREFER_DEFINED_ATTRIBUTE_MACRO
 
 # TODO: document reason
 --ignore CONST_STRUCT,VOLATILE,FILE_PATH_CHANGES,LONG_LINE,MACRO_ARG_REUSE,MULTIPLE_ASSIGNMENTS
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
