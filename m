Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE242C54E58
	for <ltp@archiver.kernel.org>; Wed, 13 Mar 2024 11:55:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2C5573CFD1F
	for <ltp@archiver.kernel.org>; Wed, 13 Mar 2024 12:55:29 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C7B6B3C02E6
 for <ltp@lists.linux.it>; Wed, 13 Mar 2024 12:54:55 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D9FED209F59
 for <ltp@lists.linux.it>; Wed, 13 Mar 2024 12:54:54 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AE7C3210FB;
 Wed, 13 Mar 2024 11:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710330893; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=NEieU5vU3SE1CRFHp+SZYaR1kEC8tpAzzgfzzXXuOHI=;
 b=RPpWp7RP3m9inhMo7CuKjm8a6EoFIYaYsxWZFb2YNmJGtObhCI+ls/ki8j+AEosCkqwo4Q
 8SIGFcEDoanYUk5cQfwaQNZd6o6pilyhW5xcprIgsPd8OOyx5DLHW3op7rLrJF84+g9YQW
 hnrxyNofKDCOXzSxo2anufy3QIIfShk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710330893;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=NEieU5vU3SE1CRFHp+SZYaR1kEC8tpAzzgfzzXXuOHI=;
 b=bUibJLw5MfeaYTvx5ZQzEy+VJrYyWDga88CYP4BtB+/prqrrxGIdYd+BUNoR5MV/SRI+HN
 OCKbIev5Rb3lsnDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710330893; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=NEieU5vU3SE1CRFHp+SZYaR1kEC8tpAzzgfzzXXuOHI=;
 b=RPpWp7RP3m9inhMo7CuKjm8a6EoFIYaYsxWZFb2YNmJGtObhCI+ls/ki8j+AEosCkqwo4Q
 8SIGFcEDoanYUk5cQfwaQNZd6o6pilyhW5xcprIgsPd8OOyx5DLHW3op7rLrJF84+g9YQW
 hnrxyNofKDCOXzSxo2anufy3QIIfShk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710330893;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=NEieU5vU3SE1CRFHp+SZYaR1kEC8tpAzzgfzzXXuOHI=;
 b=bUibJLw5MfeaYTvx5ZQzEy+VJrYyWDga88CYP4BtB+/prqrrxGIdYd+BUNoR5MV/SRI+HN
 OCKbIev5Rb3lsnDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 77A411397F;
 Wed, 13 Mar 2024 11:54:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id D4k5Gg2U8WWxKAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 13 Mar 2024 11:54:53 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Wed, 13 Mar 2024 12:54:45 +0100
Message-Id: <20240313115448.7755-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [3.58 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.12)[66.59%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 0/3] SysV IPC bug reproducer
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

Andrea Cervesato (3):
  Add SAFE_MPROTECT() macro
  Print prot flag when SAFE_MMAP() fails
  Add shmat04 SysV IPC bug reproducer

 include/tst_safe_macros.h                     | 69 +++++++++++++-
 runtest/syscalls                              |  1 +
 runtest/syscalls-ipc                          |  1 +
 .../kernel/syscalls/ipc/shmat/.gitignore      |  1 +
 testcases/kernel/syscalls/ipc/shmat/shmat04.c | 92 +++++++++++++++++++
 5 files changed, 162 insertions(+), 2 deletions(-)
 create mode 100644 testcases/kernel/syscalls/ipc/shmat/shmat04.c

-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
