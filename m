Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A15A7C71157
	for <ltp@archiver.kernel.org>; Tue, 17 Jun 2025 07:47:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1375D3CC201
	for <ltp@archiver.kernel.org>; Tue, 17 Jun 2025 09:47:45 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 99CCF3CC186
 for <ltp@lists.linux.it>; Tue, 17 Jun 2025 09:47:11 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5AFA0600082
 for <ltp@lists.linux.it>; Tue, 17 Jun 2025 09:47:09 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3A3081F38A;
 Tue, 17 Jun 2025 07:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1750146429; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ftLtjKpVdASFri5eR+mw5YL43aZPNeqDypXrSK+g9IE=;
 b=MOpgPWP3f+n15bPZq7UasmWh1Klrz0T7s7n8LJGIVftxZ9hPVHGXN8O/gWwGNPdC+w/dkC
 Oy5vlc/0S7ZW1pVvh9gHMDBT08MQt0KGhJQaS46B2HYU1JSp8zsTGD5mMpC+tV/o1MIlSH
 GB2z+IQj/PnclmQruzQlMTd1v8+6HCA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1750146429;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ftLtjKpVdASFri5eR+mw5YL43aZPNeqDypXrSK+g9IE=;
 b=BFLxFTQ4ZudaxHOi+aofig1oJNu85OeMeA8xGIsG3+5yDTj22F7TyfQ5hgAsiSpqQfF/Dh
 EU48XULzY2/+3aBQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=MOpgPWP3;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=BFLxFTQ4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1750146429; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ftLtjKpVdASFri5eR+mw5YL43aZPNeqDypXrSK+g9IE=;
 b=MOpgPWP3f+n15bPZq7UasmWh1Klrz0T7s7n8LJGIVftxZ9hPVHGXN8O/gWwGNPdC+w/dkC
 Oy5vlc/0S7ZW1pVvh9gHMDBT08MQt0KGhJQaS46B2HYU1JSp8zsTGD5mMpC+tV/o1MIlSH
 GB2z+IQj/PnclmQruzQlMTd1v8+6HCA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1750146429;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ftLtjKpVdASFri5eR+mw5YL43aZPNeqDypXrSK+g9IE=;
 b=BFLxFTQ4ZudaxHOi+aofig1oJNu85OeMeA8xGIsG3+5yDTj22F7TyfQ5hgAsiSpqQfF/Dh
 EU48XULzY2/+3aBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ED56B13A69;
 Tue, 17 Jun 2025 07:47:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ZJYlN3wdUWioaAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 17 Jun 2025 07:47:08 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 17 Jun 2025 09:47:02 +0200
Message-Id: <20250617-doc_fix_table_generate-v1-0-e96beeb2bdf7@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAHYdUWgC/x2MWwqAIBQFtxL3O8GKnluJENNTXQgLjQikvSd9D
 sxMpADPCDRkkTxuDny4BEWekdm0WyHYJqZSlrVsilbYw6iFH3XpeYda4eD1BdFZALJZ+qrVlOL
 TI1n/eJze9wMp7CWRaAAAAA==
X-Change-ID: 20250617-doc_fix_table_generate-8deee06f937a
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750146428; l=982;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=4yU5thCUkeKQAwmg6DDb7aGgQc2pmwiq3SkKBi4PsZo=;
 b=1G7LKBOekoeDGQ/oWQgsmKMcgcasqR5QdyWhTj16cXVwQ+ne0Vigjcy2qMsZ7G2gQl9cNGTyS
 l+xLinutCfaDDVEAnIQ5wVC7Xxf/KZv++/e4y8EbJcVfWEYCWgzZ9e7
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 3A3081F38A
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.com:mid,suse.com:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/2] docs: cleanup and fix
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

We currently faced a modification of open12 test, that was causing a
failure in the documentation build, due to the wrong definition of .type
as `.type = NULL`. The test was fixed, but everytime we have an empty
filesystem type, such as it is now in the open12 test, we end up having
a documentation build failure. This series of patches are checking if
one of the metadata attributes is having empty values and it eventually
skips that parameter in the attributes test list.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Andrea Cervesato (2):
      docs: make sure docs are built if filesystems is empty
      docs: make sphinx verbose so it's easier to debug in CI

 doc/Makefile | 2 +-
 doc/conf.py  | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)
---
base-commit: 080ced081cfff577991c9b71ddb850bdbb9355a0
change-id: 20250617-doc_fix_table_generate-8deee06f937a

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
