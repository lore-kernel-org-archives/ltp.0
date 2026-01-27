Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A8BAD2F00D
	for <ltp@archiver.kernel.org>; Tue, 27 Jan 2026 12:50:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0860B3CA239
	for <ltp@archiver.kernel.org>; Tue, 27 Jan 2026 13:50:31 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 99CFF3C93D2
 for <ltp@lists.linux.it>; Tue, 27 Jan 2026 13:50:12 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 151BA6008C6
 for <ltp@lists.linux.it>; Tue, 27 Jan 2026 13:50:11 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8DAB15BCFA;
 Tue, 27 Jan 2026 12:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769518210; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=g9t2H33VuecZlnz7CZ0mQa3+ZTD94ZhGcAZ271GQSkY=;
 b=1Jn0p2aknMyp//a9GnzYgNRvJ+6YE2DCl2Hd+ewt3YUrUz4i28Cm0uuJIPQDiO7IN+KydG
 GPeyIDj4OOPOSkADGWFdec+nkL9sGtLxVrKW/3wq3I13QoAGFcdaOGmOCPgt8eHDggFX7K
 0I54dzyZDQGcSC76ITU63Pjy3Gz+yyE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769518210;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=g9t2H33VuecZlnz7CZ0mQa3+ZTD94ZhGcAZ271GQSkY=;
 b=4bXyRU0kUSDlATQpaV0Y1Ts7ss00gjXNdHwSVmhv9dZ+tBvMY+woMYCtoRps1YRvgL+mfl
 p9BTAYmY7pJUSpBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=1Jn0p2ak;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4bXyRU0k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769518210; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=g9t2H33VuecZlnz7CZ0mQa3+ZTD94ZhGcAZ271GQSkY=;
 b=1Jn0p2aknMyp//a9GnzYgNRvJ+6YE2DCl2Hd+ewt3YUrUz4i28Cm0uuJIPQDiO7IN+KydG
 GPeyIDj4OOPOSkADGWFdec+nkL9sGtLxVrKW/3wq3I13QoAGFcdaOGmOCPgt8eHDggFX7K
 0I54dzyZDQGcSC76ITU63Pjy3Gz+yyE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769518210;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=g9t2H33VuecZlnz7CZ0mQa3+ZTD94ZhGcAZ271GQSkY=;
 b=4bXyRU0kUSDlATQpaV0Y1Ts7ss00gjXNdHwSVmhv9dZ+tBvMY+woMYCtoRps1YRvgL+mfl
 p9BTAYmY7pJUSpBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 615EA3EA62;
 Tue, 27 Jan 2026 12:50:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AugpFoK0eGmaYwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 27 Jan 2026 12:50:10 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 27 Jan 2026 13:50:08 +0100
Message-Id: <20260127-fork_refactoring-v1-0-e3e21ff1a4f7@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAIC0eGkC/x2MQQqAIBAAvyJ7TjARk74SEVZrLYHGGhGEf086D
 sPMCxmZMEMvXmC8KVOKFdpGwLL7uKGktTJopa1qtZUh8TExBr9ciSlu0inbBWdMcLOFmp1V0vM
 vh7GUD1AyGpZiAAAA
X-Change-ID: 20260126-fork_refactoring-8067f844f8b6
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769518210; l=687;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=/ILOS7OWzOrg6/YXweNJjqo78pusSBcfYr7HojLgbwc=;
 b=YHoUQsSQ61zbv8SkxY0oB52cAF6Thd44931TvX6SkBXeT4Xl4BsaoLB1T7OzXkVY3yGbho2JS
 +kMWiMqt5cEAK2BvZf0oADqJvTXQMmFclVQF9b1KkPMvsnuZmAsAKzP
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,suse.de:dkim];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 8DAB15BCFA
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/3] Refactor tests which are verifying fork/vfork
 functionalities
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Andrea Cervesato (3):
      syscalls:  refactor fork09 using new API
      syscalls: refactor vfork01 using new API
      syscalls: refactor vfork02 using new API

 testcases/kernel/syscalls/fork/fork09.c   | 218 ++++++-----------
 testcases/kernel/syscalls/vfork/vfork01.c | 374 ++++--------------------------
 testcases/kernel/syscalls/vfork/vfork02.c | 230 ++----------------
 3 files changed, 137 insertions(+), 685 deletions(-)
---
base-commit: c47ab95d5fe077133e598ac7762387450a87cb2b
change-id: 20260126-fork_refactoring-8067f844f8b6

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
