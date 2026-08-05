Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90438C55174
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 09:45:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 876403E29A8
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 11:45:34 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 45DF63E1C4E
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 11:45:17 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A8BD11A00EF4
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 11:45:15 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9D3BC7FD3F;
 Wed,  5 Aug 2026 09:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1785923105; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4INua10Iaq/dMP6EGrH5TkHVNnNqsJrdZD9ZzihqAec=;
 b=kPbGXwBAFsC03do37SikIR6tm+xGetTzm0EvYFeZ+ZDtBu3WzmpfAT9d8z1Q0gjw2y165X
 y3a2/px8X822nIAt0/4LdD21yfrWU2ycIqKjkoUMbn2zF6HASPr235/vSBsytIUDUiX4ua
 /QXXqQ2AObgAuZwJ4JxnM0idfyzh7TY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1785923105;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4INua10Iaq/dMP6EGrH5TkHVNnNqsJrdZD9ZzihqAec=;
 b=CNoGwK6zatEEOXD7hk2h0RUx6ugEtei//BwYrAu4CB98J8PJ7i+hbr8Og2C1xZVqtllXnY
 /URVDOjQ9rY0NHAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Qr8Swm1C;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=bX71ir1D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1785923101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4INua10Iaq/dMP6EGrH5TkHVNnNqsJrdZD9ZzihqAec=;
 b=Qr8Swm1C4FeIDJ+aYx7crdReMtFwKTZBnHn4PflGeeg6AP+2G/SA+zEdWDbC3SwUCZJTzi
 43WzgU0aDJ19tKyOOmUyr45/qw1xwoX3uhQgocS2FN3593aOS5neAirn1JnnNlFL/ZDsIK
 Wd1hxfntBdiA33UxBGBwmYEwro+LZPg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1785923101;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4INua10Iaq/dMP6EGrH5TkHVNnNqsJrdZD9ZzihqAec=;
 b=bX71ir1DDGCtGu10sHbmcSsXp+cViSm8wkT8AGJ9hWPzMdoeE73KZQtY7uSk4yke6+wDWg
 avlrlQCLOvK+V6BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6F444779C2;
 Wed,  5 Aug 2026 09:45:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id nOkEGR0Gc2pzRAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 05 Aug 2026 09:45:01 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 05 Aug 2026 11:44:56 +0200
Message-Id: <20260805-tpci_refactoring-v1-0-4ca8d84f8a95@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIABgGc2oC/x2MQQqAIBAAvyJ7TlCxqL4SEbZttRcVjQjCvycdh
 2HmhUyJKcMoXkh0c+bgK+hGAJ7OHyR5qwxGmU71ysorIi+JdodXSOwP2dm1HYzRjlqEmsUq+fm
 X01zKB4WbHAJiAAAA
X-Change-ID: 20260804-tpci_refactoring-64b59221ae5c
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785923101; l=1288;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=F1haUwhuhah6TDz7De9wAQVqbOR38BH5IVckekhj0hI=;
 b=F/0SEHlbSZP3v57/GeBEGLv7Oh1gneMSn0TMs7iRZcBII0bOqQShcrI13tgfP6oeEgTFFrQ9D
 z78uvSsp4b2BaKznwz6sY3/mcn8BHebPAf5GmQT6LsNz81fI9D/zvor
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 9D3BC7FD3F
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/2] tcpi refactoring
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

Rewrite the tcpi test so we use the new LTP API.

- rewrite kernel module
- rewrite LTP test
- merge kernel module and LTP test in the same folder

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Andrea Cervesato (2):
      tpci: refactor kernel module
      tcpi: refactor test using new API

 .../pci/{tpci_kernel => tpci}/.gitignore           |   3 +-
 testcases/kernel/device-drivers/pci/tpci/Makefile  |  22 ++
 .../pci/{tpci_kernel => tpci}/ltp_tpci.c           | 230 +++++++++++----------
 testcases/kernel/device-drivers/pci/tpci/tpci.c    | 156 ++++++++++++++
 testcases/kernel/device-drivers/pci/tpci/tpci.h    |  36 ++++
 .../kernel/device-drivers/pci/tpci_kernel/Makefile |  35 ----
 .../pci/tpci_kernel/pci-exp-tests-HOWTO            |  58 ------
 .../kernel/device-drivers/pci/tpci_kernel/tpci.h   |  43 ----
 .../kernel/device-drivers/pci/tpci_user/.gitignore |   1 -
 .../kernel/device-drivers/pci/tpci_user/Makefile   |  20 --
 .../kernel/device-drivers/pci/tpci_user/tpci.c     | 115 -----------
 11 files changed, 332 insertions(+), 387 deletions(-)
---
base-commit: 55df2975679d15d566d02b677c326eaedb4dc2b6
change-id: 20260804-tpci_refactoring-64b59221ae5c

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
