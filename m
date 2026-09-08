Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C7D0C79F82
	for <ltp@archiver.kernel.org>; Tue,  8 Sep 2026 09:13:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 416653E73A0
	for <ltp@archiver.kernel.org>; Tue,  8 Sep 2026 11:13:22 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B2CDD3C70EA
 for <ltp@lists.linux.it>; Tue,  8 Sep 2026 11:13:05 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3FCBA2009FC
 for <ltp@lists.linux.it>; Tue,  8 Sep 2026 11:13:04 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B383121A3E;
 Tue,  8 Sep 2026 09:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788858778; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=u8U4qcYBemlBMocnGwHp2BMPV/A9Ox1XDTrXrmZZATM=;
 b=CTK90JExBjywmvDaYOzyzAfoBSz53IF+qkpcU0kbh0EAnKgk7wDTHe47M451UsTCWojqBj
 BF8m23OYi3Y8o48dlks8vMuL6wtau4z2gK20uvt43Au1t5Na0M5iuOq0AfbaWnRrapBLPD
 yEJyPa1Kame/UxZzozWtb1lGUC+mf7E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788858778;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=u8U4qcYBemlBMocnGwHp2BMPV/A9Ox1XDTrXrmZZATM=;
 b=sM9WmXIe+Rq4qyzBAPujNvYJEt+AvuAtsFmuQirTQdXt6FV4yDpy7lIk0dww8f7BybFsTH
 nzDa88wgSNWo0iBg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=WS9jRdgn;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=RvGxqvp6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788858774; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=u8U4qcYBemlBMocnGwHp2BMPV/A9Ox1XDTrXrmZZATM=;
 b=WS9jRdgnR07SI+SdrGiLD+lM+J0xysUN37Yj6V/0xELDX/KnKw10n5KOOU1GmaKoGw72ZQ
 SqKUlr1XXZiq4AbBHBWM7+NgUc1B5sNNYlPlacsMWZ+KmiQBfE0cPZzN/g/J/8yPrpPY+M
 jtsNzilpVWKNaKWIfDk2tnne7y/4LQc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788858774;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=u8U4qcYBemlBMocnGwHp2BMPV/A9Ox1XDTrXrmZZATM=;
 b=RvGxqvp6pby+GLj2eACAdtyo3f7Pid7cU/X/RNHeGfsVbDyq+wLz2IzKToRAz3O4+VdLJg
 Ac0sXVfszZhqsSCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 808101364A;
 Tue,  8 Sep 2026 09:12:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mKuaHZbRn2oNSwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 08 Sep 2026 09:12:54 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 08 Sep 2026 11:12:54 +0200
MIME-Version: 1.0
Message-Id: <20260908-kirk_4-2-0-v1-1-cb51dde0f5f6@suse.com>
X-B4-Tracking: v=1; b=H4sIAJXRn2oC/yXMyw5AMBBA0V+RWZukWvH6FRHxmDIkSItIGv+uW
 J7FvQ4sGSYLReDA0MmW18UjCgPoxmYZCLn3BilkInKR4cxmrmOUKFCpJIsjqZXuU/DBZkjz9c3
 K6rc92om6/T3AfT/2ukgXbgAAAA==
X-Change-ID: 20260908-kirk_4-2-0-3368412f3fd7
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788858774; l=1356;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=uX1m+8AsnZaIyFpIFfUD28tZlze3nhpw5LpongqJ3fY=;
 b=v44RGn1EvnRJrk8VRzTgoxRXkWhqhN+E8PlkkXKzlpkk6E5sy4XLdsKuhlKcdbsiApMds4n1l
 IA+JvGY2yLFCaShmvPuboV2weFkB10/Putbe/avvAxl68Jg3i19DSOU
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Queue-Id: B383121A3E
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 TO_DN_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:mid,suse.com:email,suse.de:dkim];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] kirk: upgrade version to 4.2.0
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

- Add --dry-run option to preview tests before execution
- Add configurable fault injection interval option
- Persist and export partial results when a session is aborted mid-suite
- Fix --exec-timeout not killing tests in the shell channel
- Fix JSON report file being opened in read/write instead of write-only
  mode
- Fix incorrect log message when test parameters are missing in LTP
  metadata
- Fix exception handling in the event subsystem
- Fix --randomize command-line description
- Major documentation update (quickstart, SSH, LTX, QEMU, and plugins)
- Move IOBuffer implementations inside the sut module
- Improve test suite coverage and fix flaky test cases

Link: https://github.com/linux-test-project/kirk/releases/tag/v4.2.0
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 tools/kirk/kirk-src | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/kirk/kirk-src b/tools/kirk/kirk-src
index 7d4234c43..e65b84ba0 160000
--- a/tools/kirk/kirk-src
+++ b/tools/kirk/kirk-src
@@ -1 +1 @@
-Subproject commit 7d4234c4305ab8b7b4ec27e911798b5e7f65ef88
+Subproject commit e65b84ba00de6e5b6bdb63d5259490d7f9d460b8

---
base-commit: 352f9134942933efcfa608b87ae814db603b3228
change-id: 20260908-kirk_4-2-0-3368412f3fd7

Best regards,
--  
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
