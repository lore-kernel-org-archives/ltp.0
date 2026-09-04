Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAEA6C61DD6
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 11:04:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 684163E976A
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 13:04:46 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4B7F13E9754
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 13:04:04 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7B31B2010F2
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 13:04:02 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 378C522A06;
 Fri,  4 Sep 2026 11:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788519837; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ip/NxaV0Fbn3e31lNgu43DA8aRkwfj5G2fww/v2ssI8=;
 b=UyPU/T6x9e61xsCgHRQirOAHlMc70rI2gI3EaCgO8qeZ1l/mVR2uqQAx3JS7EAnEYqLDnO
 BLPdaw4ir7qR5tBVruj46sVDXLXEL9xDgYfvwxuc2igCxbo0/SI7m7VAD/Ybn+Lkg7yFCJ
 nqYDkIK9UOvLFKXx65ahc+79qUbdtME=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788519837;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ip/NxaV0Fbn3e31lNgu43DA8aRkwfj5G2fww/v2ssI8=;
 b=iG99h53cY6nRhe3E95SsZ+qPgFdVzryQ/j15iUEJIml5BDXD8jUikgCersdvinPHao5EGb
 EEIpFYjzFJdsUGBQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="ykNUES5/";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=wj1aRO3f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788519833; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ip/NxaV0Fbn3e31lNgu43DA8aRkwfj5G2fww/v2ssI8=;
 b=ykNUES5/9xVLAPcknW+82VIETzadqcyU2V9QZzGMgMSv6sj8jEO1yV61rY26KnrMCgIjp5
 0gvneM3Ee2k5a8gxItrPet1GiEnn3qE9xejlrEyCKx6+hwjMJRa94OYDl3iZQ0K/edMWxe
 voFo+cG97DfeQNuwVLTcxoY1zgB+rDU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788519833;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ip/NxaV0Fbn3e31lNgu43DA8aRkwfj5G2fww/v2ssI8=;
 b=wj1aRO3fqfjf5i1YMjQ/B/B02gK9wd9tQQjin/I7saUKuT11CYi+p76BIs0bnsdtdx4XBg
 sm4mk/JRPYRZacBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ED67A13726;
 Fri,  4 Sep 2026 11:03:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4eInN5ilmmokcgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 04 Sep 2026 11:03:52 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 04 Sep 2026 13:03:51 +0200
Message-Id: <20260904-coredump-v7-0-a32b7ca1acea@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAJelmmoC/3XPQW7DIBAF0KtErEvFDBhwVr1H1QUeDw2VEkcQW
 60i3704XRRZ7fJL//2BuyicExdxPNxF5iWVNF1qcE8HQadweWeZxpoFKrTKo5I0ZR7n81UiRnI
 ahpGVF7V+zRzT52Pq9e0nl3n4YLptfmucUrlN+etxa4Gt98fsAhKkI+7AKk0ch5cyF36m6Sy21
 QVbZxqH1Rk06APFDsHunP7P6eqswX4M1hkHfufMr+sVNs5Up2MHwAGot2HnutbpxnXVIQdvY8A
 elNs527r2nVYqOXjWvXFE1rT/W9f1G2EqD67JAQAA
X-Change-ID: 20260820-coredump-22fc731bde08
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788519832; l=2365;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=3m0g2AN9/GQN86ir7GCE4efNVrYH9RIKVOOUsS4jGlU=;
 b=S5babQEQ9OkcIT4Q44kftWrD0/VqAamkxWwzTY0x+m/NpU3kaW07IeAWULb8x/+R/+5qq9sDb
 M7NnICXLZiDDZj9a6s078WWoweeRdK/UZ5DzS89o6se+RRFRPRahK4F
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Queue-Id: 378C522A06
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:mid,suse.com:email,linux.it:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7 0/2] coredump testing suite
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

Add a simple coredump01 test that simulate a coredump and verify that it
actually works. This is a small coverage that is missing inside LTP
testing suite.

Add a coredump02 test that verifies ELF data after a coredump.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v7:
- define a common header for the testing suite
- update commit message for coredump02
- Link to v6: https://lore.kernel.org/20260904-coredump-v6-0-b8e3947cc646@suse.com

Changes in v6:
- coredump01 check Elf
- add coredump02 test for Elf validation
- Link to v5: https://lore.kernel.org/20260903-coredump-v5-1-2ea86fa29107@suse.com

Changes in v5:
- resolve path from root for helper
- Link to v4: https://lore.kernel.org/20260902-coredump-v4-1-3f511ea1c96a@suse.com

Changes in v4:
- read back core_pattern after writing and abort with TBROK on mismatch
- read CONFIG_STATIC_USERMODEHELPER once in setup() and cache the result
- remove namespace visibility scaffolding and skip logic from verify_pipe_pattern()
- resolve helper path with tst_get_path() instead of /proc/self/exe readlink
- Link to v3: https://lore.kernel.org/20260824-coredump-v3-1-6429da674718@suse.com

Changes in v3:
- check for CONFIG_COREDUMP=y
- Link to v2: https://lore.kernel.org/20260824-coredump-v2-1-42428acf5216@suse.com

Changes in v2:
- fix CI agent spotted errors
- Link to v1: https://lore.kernel.org/20260820-coredump-v1-1-7ce51603cefb@suse.com

To: Linux Test Project <ltp@lists.linux.it>

---
Andrea Cervesato (2):
      coredump01: New core_pattern specifiers test
      coredump02: Verify ELF structure and notes

 runtest/kernel_misc                           |   2 +
 testcases/kernel/Makefile                     |   1 +
 testcases/kernel/coredump/.gitignore          |   3 +
 testcases/kernel/coredump/Makefile            |   7 +
 testcases/kernel/coredump/coredump01.c        | 158 ++++++++++++++++++++
 testcases/kernel/coredump/coredump01_helper.c |  73 ++++++++++
 testcases/kernel/coredump/coredump02.c        | 198 ++++++++++++++++++++++++++
 testcases/kernel/coredump/coredump_common.h   |  69 +++++++++
 8 files changed, 511 insertions(+)
---
base-commit: 043bdc49af410f55ece6f61abcdaba7d9580f86a
change-id: 20260820-coredump-22fc731bde08

Best regards,
--  
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
