Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13D27C3DA45
	for <ltp@archiver.kernel.org>; Thu, 11 Jul 2024 20:13:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 643BF3D0B0F
	for <ltp@archiver.kernel.org>; Thu, 11 Jul 2024 22:13:33 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 75BD03C2220
 for <ltp@lists.linux.it>; Thu, 11 Jul 2024 22:13:17 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 76C726067A7
 for <ltp@lists.linux.it>; Thu, 11 Jul 2024 22:13:15 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4E7EA21ABB;
 Thu, 11 Jul 2024 20:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1720728795; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=tIW5+h1Z9U0VHBT7rHRSX1AkOouTjroXdeXZAG6RrPo=;
 b=d9lS3wub1g1jn48pss0hXqnF7uzcQqfKTTjidlSTq1HhIuupot9k7wHhwfXVeEdBPwXtuo
 8Yr6Pn1Ni8DgUhKstcVELjoNL1QeODUBFUqjMoXw1BiOMpQ/SVr3pwSzZVl9QR014oMNNf
 cckueCk8J9fu1yFSWgkRl2ziSRDTVRA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1720728795;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=tIW5+h1Z9U0VHBT7rHRSX1AkOouTjroXdeXZAG6RrPo=;
 b=DQbtqemXYIQQ9RzADDPp+rIJFl9nafkCS3+tqlO2eCptyKB1y+NNuH/nZW1Z/wdP0uGhvx
 /22vjcY9xKb0t8DA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=d9lS3wub;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=DQbtqemX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1720728795; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=tIW5+h1Z9U0VHBT7rHRSX1AkOouTjroXdeXZAG6RrPo=;
 b=d9lS3wub1g1jn48pss0hXqnF7uzcQqfKTTjidlSTq1HhIuupot9k7wHhwfXVeEdBPwXtuo
 8Yr6Pn1Ni8DgUhKstcVELjoNL1QeODUBFUqjMoXw1BiOMpQ/SVr3pwSzZVl9QR014oMNNf
 cckueCk8J9fu1yFSWgkRl2ziSRDTVRA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1720728795;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=tIW5+h1Z9U0VHBT7rHRSX1AkOouTjroXdeXZAG6RrPo=;
 b=DQbtqemXYIQQ9RzADDPp+rIJFl9nafkCS3+tqlO2eCptyKB1y+NNuH/nZW1Z/wdP0uGhvx
 /22vjcY9xKb0t8DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 18B9B139E0;
 Thu, 11 Jul 2024 20:13:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xv8tA9s8kGbYbwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 11 Jul 2024 20:13:15 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 11 Jul 2024 22:13:05 +0200
Message-ID: <20240711201306.98519-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4E7EA21ABB
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.99 / 50.00]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Spamd-Bar: /
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] lib: Add missing checks for invalid return value
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

It's a common approach to test invalid return value in safe macros.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/lapi/landlock.h | 12 ++++++++++++
 lib/tst_safe_macros.c   |  4 ++++
 2 files changed, 16 insertions(+)

diff --git a/include/lapi/landlock.h b/include/lapi/landlock.h
index 6d85eb12e3..d3fa760e5b 100644
--- a/include/lapi/landlock.h
+++ b/include/lapi/landlock.h
@@ -133,6 +133,10 @@ static inline int safe_landlock_create_ruleset(const char *file, const int linen
 		tst_brk_(file, lineno, TBROK | TERRNO,
 			"landlock_create_ruleset(%p, %lu, %u)",
 			attr, size, flags);
+	} else if (rval < 0) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid landlock_create_ruleset(%p, %lu, %u) return value %d",
+			attr, size, flags, rval);
 	}
 
 	return rval;
@@ -151,6 +155,10 @@ static inline int safe_landlock_add_rule(const char *file, const int lineno,
 		tst_brk_(file, lineno, TBROK | TERRNO,
 			"landlock_add_rule(%d, %d, %p, %u)",
 			ruleset_fd, rule_type, rule_attr, flags);
+	} else if (rval < 0) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid landlock_add_rule(%d, %d, %p, %u) return value %d",
+			ruleset_fd, rule_type, rule_attr, flags, rval);
 	}
 
 	return rval;
@@ -166,6 +174,10 @@ static inline int safe_landlock_restrict_self(const char *file, const int lineno
 		tst_brk_(file, lineno, TBROK | TERRNO,
 			"landlock_restrict_self(%d, %u)",
 			ruleset_fd, flags);
+	} else if (rval < 0) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid landlock_restrict_self(%d, %u) return value %d",
+			ruleset_fd, flags, rval);
 	}
 
 	return rval;
diff --git a/lib/tst_safe_macros.c b/lib/tst_safe_macros.c
index 9301f3dd27..1bc5c92f58 100644
--- a/lib/tst_safe_macros.c
+++ b/lib/tst_safe_macros.c
@@ -723,6 +723,10 @@ int safe_prctl(const char *file, const int lineno,
 		tst_brk_(file, lineno, TBROK | TERRNO,
 			"prctl(%d, %lu, %lu, %lu, %lu)",
 			option, arg2, arg3, arg4, arg5);
+	} else if (rval < 0) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid prctl(%d, %lu, %lu, %lu, %lu) return value %d",
+			option, arg2, arg3, arg4, arg5, rval);
 	}
 
 	return rval;
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
