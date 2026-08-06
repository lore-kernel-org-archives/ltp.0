Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B55C55ABF
	for <ltp@archiver.kernel.org>; Thu,  6 Aug 2026 08:11:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A62873E5AB9
	for <ltp@archiver.kernel.org>; Thu,  6 Aug 2026 10:11:03 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BE8243C2BE6
 for <ltp@lists.linux.it>; Thu,  6 Aug 2026 10:10:46 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 24ECE2001D8
 for <ltp@lists.linux.it>; Thu,  6 Aug 2026 10:10:45 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3088E7FF26;
 Thu,  6 Aug 2026 08:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1786003841; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=UtNpUaEHAmePFxj0uiHOF3PIfiH/eVTpYcX6UPErb6M=;
 b=d0f1/E85aUtsS34l2iIX+eLtaH8AgzEz12T/0BO2ylNrIWRFDuJgvXbnXQQbEX/P8Q390s
 o+pw+wib/aK3N5Vp1uofeeggWeTLt5DEN93htUsJWwIk35wzZydh/Z4JBeYgohGww9R3oo
 9l8GKr1x+ubaIct/mGDxqsct5GYzzyo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1786003841;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=UtNpUaEHAmePFxj0uiHOF3PIfiH/eVTpYcX6UPErb6M=;
 b=7Fgktiw7Lt7yPoC8+n9mdEsvC2TdFoMGFOZEON/94yee1Na72OpP7WE2cxcKQztYa811zo
 TNQuHYmwiTIjFhAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=fMaQ7yxE;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=kRnsuhHx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1786003837; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=UtNpUaEHAmePFxj0uiHOF3PIfiH/eVTpYcX6UPErb6M=;
 b=fMaQ7yxE+KqvgpdywczmgWlEiYb0Z6au0kYrJS15+sFbNZSqfITnnWr5slf9n/uhjSzxp3
 t3wVzsYtCFZSsfdBy9av26ZYEzn2PCrWplCHP6Dt9bU1hfX7q9vzHxktzHLHUl/MiBkJp7
 oDznUH5xgtnbKz0lc2V0Cs3lqqRBnlA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1786003837;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=UtNpUaEHAmePFxj0uiHOF3PIfiH/eVTpYcX6UPErb6M=;
 b=kRnsuhHxbxs0LTxb62dynVN1ctU15zaVhOmCjCYBuuI3mJ2FiCN9VP4yOB4cUXpKekcv91
 7ZhGMCNKjbCIAaAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 102AF779C0;
 Thu,  6 Aug 2026 08:10:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id BJM8An1BdGrZWwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 06 Aug 2026 08:10:37 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 06 Aug 2026 10:10:35 +0200
Message-Id: <20260806-tpci_refactoring-v2-0-bdc3a749ca02@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAHtBdGoC/2WNQQ7CIBBFr9LMWgwQaKgr79E0Bum0nYXQQCWah
 ruLTVy5fH/+f7NDwkiY4NLsEDFTouAryFMDbrF+RkZjZZBcttxwxbbV0S3iZN0WIvmZtequOym
 FRe2gztZ6pNeh7IfKC6XafB8fsvimP5n+l2XBOFPOmtGoydhOX9Mz4dmFBwyllA96DkJhrwAAA
 A==
X-Change-ID: 20260804-tpci_refactoring-64b59221ae5c
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786003837; l=1502;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=I05OSK5lTp8SkQoVM+2wFaBs2EInIAdqUYvzEiJnrP8=;
 b=9JzXLi3BTjW100cZd0mNzPr5puQM4ENTLUt2inybrMiZ/fO15BH9mfIGjNJxpe2Q2wpSOzjNN
 BNv7U8nmjJpD9hMreTiHVI1SNnfcDlbac2fVP9ygCLUR42vccJ1SVLj
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 3088E7FF26
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/2] tcpi refactoring
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
Changes in v2:
- fix commit tag
- check that device exists
- skip PCI_DISABLE because it's an unreliable test
- Link to v1: https://lore.kernel.org/20260805-tpci_refactoring-v1-0-4ca8d84f8a95@suse.com

---
Andrea Cervesato (2):
      tpci: refactor kernel module
      tpci: refactor test using new API

 .../pci/{tpci_kernel => tpci}/.gitignore           |   3 +-
 testcases/kernel/device-drivers/pci/tpci/Makefile  |  22 ++
 .../pci/{tpci_kernel => tpci}/ltp_tpci.c           | 230 +++++++++++----------
 testcases/kernel/device-drivers/pci/tpci/tpci.c    | 166 +++++++++++++++
 testcases/kernel/device-drivers/pci/tpci/tpci.h    |  36 ++++
 .../kernel/device-drivers/pci/tpci_kernel/Makefile |  35 ----
 .../pci/tpci_kernel/pci-exp-tests-HOWTO            |  58 ------
 .../kernel/device-drivers/pci/tpci_kernel/tpci.h   |  43 ----
 .../kernel/device-drivers/pci/tpci_user/.gitignore |   1 -
 .../kernel/device-drivers/pci/tpci_user/Makefile   |  20 --
 .../kernel/device-drivers/pci/tpci_user/tpci.c     | 115 -----------
 11 files changed, 342 insertions(+), 387 deletions(-)
---
base-commit: 12fcadf63a99fc4bec76f9b4715cda626256562f
change-id: 20260804-tpci_refactoring-64b59221ae5c

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
