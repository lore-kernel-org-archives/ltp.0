Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DBD0C021AA
	for <ltp@archiver.kernel.org>; Fri, 21 Feb 2025 10:45:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DB48D3C1DBA
	for <ltp@archiver.kernel.org>; Fri, 21 Feb 2025 11:45:45 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EA7D53C0430
 for <ltp@lists.linux.it>; Fri, 21 Feb 2025 11:45:28 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 22AA0215AC9
 for <ltp@lists.linux.it>; Fri, 21 Feb 2025 11:45:27 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7BF2021253;
 Fri, 21 Feb 2025 10:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740134726; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0veT1HLpzM+ge7GqDjD6LOiDaNLyCqvoLKjaJQ+jxGU=;
 b=qlb7ULHkMkJLNmy6Dyw/kbllHF0k8uBbOs8iABvVZDOarPlmfMwV1S1+LtwmOvZe8GKzRU
 TPnXgU050ju6qWYOdO4BaflyFYontKDgxNpqIkuaIPVUdblJtq/41xlNLyonl485gAokjq
 SuHFNlkB+CvZJD3Gn+sCDxIwxe/VgeI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740134726;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0veT1HLpzM+ge7GqDjD6LOiDaNLyCqvoLKjaJQ+jxGU=;
 b=8BnJPq+ylVhKfiq4/YCMCbtvtrvgrrNCBw0FxaQssjWi8C+kqolhy12fng5uRq3BRDm9Oe
 3aaYz4eK49HLqcAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740134726; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0veT1HLpzM+ge7GqDjD6LOiDaNLyCqvoLKjaJQ+jxGU=;
 b=qlb7ULHkMkJLNmy6Dyw/kbllHF0k8uBbOs8iABvVZDOarPlmfMwV1S1+LtwmOvZe8GKzRU
 TPnXgU050ju6qWYOdO4BaflyFYontKDgxNpqIkuaIPVUdblJtq/41xlNLyonl485gAokjq
 SuHFNlkB+CvZJD3Gn+sCDxIwxe/VgeI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740134726;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0veT1HLpzM+ge7GqDjD6LOiDaNLyCqvoLKjaJQ+jxGU=;
 b=8BnJPq+ylVhKfiq4/YCMCbtvtrvgrrNCBw0FxaQssjWi8C+kqolhy12fng5uRq3BRDm9Oe
 3aaYz4eK49HLqcAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4C11913806;
 Fri, 21 Feb 2025 10:45:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id NL/HEUZZuGd3PwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 21 Feb 2025 10:45:26 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 21 Feb 2025 11:45:15 +0100
Message-ID: <20250221104515.2767683-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC PATCH 1/1] lapi/fsmount.h: Update MOVE_MOUNT__MASK
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

Kernel commit 6ac392815628 which added MOVE_MOUNT_BENEATH also updated
MOVE_MOUNT__MASK. Although LTP don't use MOVE_MOUNT__MASK, it's probably
better to keep it sync. Other option would be to remove it.

Fixes: 606ca42e27 ("move_mount03: check allow to mount beneath top mount")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/lapi/fsmount.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/lapi/fsmount.h b/include/lapi/fsmount.h
index 3b9d7bdbf2..1783272a00 100644
--- a/include/lapi/fsmount.h
+++ b/include/lapi/fsmount.h
@@ -139,7 +139,7 @@ static inline int mount_setattr(int dirfd, const char *from_pathname, unsigned i
 #define MOVE_MOUNT_T_SYMLINKS		0x00000010 /* Follow symlinks on to path */
 #define MOVE_MOUNT_T_AUTOMOUNTS		0x00000020 /* Follow automounts on to path */
 #define MOVE_MOUNT_T_EMPTY_PATH		0x00000040 /* Empty to path permitted */
-#define MOVE_MOUNT__MASK		0x00000077
+#define MOVE_MOUNT__MASK		0x00000377
 
 /*
  * fsopen() flags.
-- 
2.47.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
