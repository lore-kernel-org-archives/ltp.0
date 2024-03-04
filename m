Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ACD1C5478C
	for <ltp@archiver.kernel.org>; Mon,  4 Mar 2024 15:22:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AE8FD3CEB92
	for <ltp@archiver.kernel.org>; Mon,  4 Mar 2024 16:22:10 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 18A9C3CE0C2
 for <ltp@lists.linux.it>; Mon,  4 Mar 2024 16:21:24 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id EB6A41405165
 for <ltp@lists.linux.it>; Mon,  4 Mar 2024 16:21:21 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3B7C54EB14;
 Mon,  4 Mar 2024 15:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709565681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=M0Fve+MWZP4jOC28y7YAju+7yOezrDGxSeGbWdm+qW4=;
 b=SZSY+KvRQckFiK7slYLImWc/9oLBhmjWQP8iBWoatL89TmpV9AWFiUT4p7XOxE+m1IXwcT
 fwwBgjOsckVxT/VqTquO8IYAE9dm254HGSeFB9h4BYMuTvmY+5dfRoAxQBDMpAgpyapcj4
 oDoz7aDlqVX1+utj5qbxBgnSU65wqOo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709565681;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=M0Fve+MWZP4jOC28y7YAju+7yOezrDGxSeGbWdm+qW4=;
 b=I9CTFb4SqNwrRWhd210fqXBI7uPgCX+Ifb00Gy61U+Rn8vV6ecu6yOKEkXo31fgEdDre/6
 UuupNWjO4zOMU7BQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709565681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=M0Fve+MWZP4jOC28y7YAju+7yOezrDGxSeGbWdm+qW4=;
 b=SZSY+KvRQckFiK7slYLImWc/9oLBhmjWQP8iBWoatL89TmpV9AWFiUT4p7XOxE+m1IXwcT
 fwwBgjOsckVxT/VqTquO8IYAE9dm254HGSeFB9h4BYMuTvmY+5dfRoAxQBDMpAgpyapcj4
 oDoz7aDlqVX1+utj5qbxBgnSU65wqOo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709565681;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=M0Fve+MWZP4jOC28y7YAju+7yOezrDGxSeGbWdm+qW4=;
 b=I9CTFb4SqNwrRWhd210fqXBI7uPgCX+Ifb00Gy61U+Rn8vV6ecu6yOKEkXo31fgEdDre/6
 UuupNWjO4zOMU7BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 03AFB13A5B;
 Mon,  4 Mar 2024 15:21:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id JRNTOfDm5WVHaAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 04 Mar 2024 15:21:20 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Mon,  4 Mar 2024 16:21:17 +0100
Message-Id: <20240304152119.31688-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [3.70 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.00)[42.55%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 0/2] SysV IPC bug reproducer
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

 include/tst_safe_macros.h                     |  5 +
 lib/safe_macros.c                             | 40 ++++++++
 runtest/syscalls                              |  1 +
 runtest/syscalls-ipc                          |  1 +
 .../kernel/syscalls/ipc/shmat/.gitignore      |  1 +
 testcases/kernel/syscalls/ipc/shmat/shmat04.c | 92 +++++++++++++++++++
 6 files changed, 140 insertions(+)
 create mode 100644 testcases/kernel/syscalls/ipc/shmat/shmat04.c

-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
