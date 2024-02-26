Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6025BC48BF6
	for <ltp@archiver.kernel.org>; Mon, 26 Feb 2024 15:38:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BD2B63CEFFD
	for <ltp@archiver.kernel.org>; Mon, 26 Feb 2024 16:38:12 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DBE733CEFE5
 for <ltp@lists.linux.it>; Mon, 26 Feb 2024 16:37:56 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 486B76008AC
 for <ltp@lists.linux.it>; Mon, 26 Feb 2024 16:37:55 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4527C1FB5F;
 Mon, 26 Feb 2024 15:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708961875; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=zLVbX+eBey8vI0F+bbbUQ8PM/ezmdtnRWnDurE7ZnVQ=;
 b=qG3uOQ99P2L/djuOG+CDTypa555qaonHLGe8fsxPhrmCq5X58NOZb4SU2ENRPpsiqg3KdO
 9J9Es0JjJn2+zvZua1oP/Jo6gPvlT8bDd/FRRWFsW1ERM+8nDtzAAH9fwi6g68SIQ+ap7h
 niIsjMiJo8WTt53VT/LFL1upIajuEks=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708961875;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=zLVbX+eBey8vI0F+bbbUQ8PM/ezmdtnRWnDurE7ZnVQ=;
 b=wC+YGbicY2mPzLTIDpD7zTvX0RStWdugL/dCJ+2cYboAXxzydEjLv5P4hGsVhFUFv3Yhuf
 IE6x3SNOk51rceDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708961875; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=zLVbX+eBey8vI0F+bbbUQ8PM/ezmdtnRWnDurE7ZnVQ=;
 b=qG3uOQ99P2L/djuOG+CDTypa555qaonHLGe8fsxPhrmCq5X58NOZb4SU2ENRPpsiqg3KdO
 9J9Es0JjJn2+zvZua1oP/Jo6gPvlT8bDd/FRRWFsW1ERM+8nDtzAAH9fwi6g68SIQ+ap7h
 niIsjMiJo8WTt53VT/LFL1upIajuEks=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708961875;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=zLVbX+eBey8vI0F+bbbUQ8PM/ezmdtnRWnDurE7ZnVQ=;
 b=wC+YGbicY2mPzLTIDpD7zTvX0RStWdugL/dCJ+2cYboAXxzydEjLv5P4hGsVhFUFv3Yhuf
 IE6x3SNOk51rceDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0DA5313A3A;
 Mon, 26 Feb 2024 15:37:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4WBRAFOw3GVGAgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 26 Feb 2024 15:37:54 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Mon, 26 Feb 2024 16:37:52 +0100
Message-Id: <20240226153754.24998-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Spamd-Bar: +++
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=qG3uOQ99;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=wC+YGbic
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [3.49 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 BROKEN_CONTENT_TYPE(1.50)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_TRACE(0.00)[suse.de:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 BAYES_HAM(-0.00)[43.55%]; ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Queue-Id: 4527C1FB5F
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/2] SysV IPC bug reproducer
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

This patch series provides a bug reproducer for SysV IPC, which has been
written by Michal Hocko.
It also includes the SAFE_MPROTECT macro, useful for many other tests as well.

Andrea Cervesato (2):
  Add SAFE_MPROTECT() macro
  Add shmat04 SysV IPC bug reproducer

 include/tst_safe_macros.h                     |   5 +
 lib/safe_macros.c                             |  18 +++
 runtest/syscalls                              |   1 +
 runtest/syscalls-ipc                          |   1 +
 .../kernel/syscalls/ipc/shmat/.gitignore      |   1 +
 testcases/kernel/syscalls/ipc/shmat/shmat04.c | 115 ++++++++++++++++++
 6 files changed, 141 insertions(+)
 create mode 100644 testcases/kernel/syscalls/ipc/shmat/shmat04.c

-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
