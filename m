Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF703C4451C
	for <ltp@archiver.kernel.org>; Fri, 17 Jul 2026 12:33:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C23CB3E24F5
	for <ltp@archiver.kernel.org>; Fri, 17 Jul 2026 14:33:37 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 92FBA3E1B94
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 14:33:20 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1B2CB2000A9
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 14:33:19 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 691DC783C4;
 Fri, 17 Jul 2026 12:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784291599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=iwwVxVdeC4wXAJboacrjV4YbH55XE5td+rQDlsWaTHk=;
 b=TNW9GkOtuu9GIEUECAk4JXha02VB7cFUFM3I0kUXkO6U/WmoL/2QMX8BKkce8Lf2Z2ssVz
 I96CvpMRzodUS7ZZbKJs9KrpWoZtuuHvLcOB4vhJC+OOggmLBGXN5swXcDZ9KMkFJd8zxY
 bk3w521Nayvx0UW71lfFfRQsYWshZu8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784291599;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=iwwVxVdeC4wXAJboacrjV4YbH55XE5td+rQDlsWaTHk=;
 b=BpEPkxK1V5tpswgb2QjZ59hMzI+kRd9pGbYmeTTE7tiJR+Ms8eawe7qbi5GDx1GON9t/Cn
 LRmWZcN221v8f/CA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784291599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=iwwVxVdeC4wXAJboacrjV4YbH55XE5td+rQDlsWaTHk=;
 b=TNW9GkOtuu9GIEUECAk4JXha02VB7cFUFM3I0kUXkO6U/WmoL/2QMX8BKkce8Lf2Z2ssVz
 I96CvpMRzodUS7ZZbKJs9KrpWoZtuuHvLcOB4vhJC+OOggmLBGXN5swXcDZ9KMkFJd8zxY
 bk3w521Nayvx0UW71lfFfRQsYWshZu8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784291599;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=iwwVxVdeC4wXAJboacrjV4YbH55XE5td+rQDlsWaTHk=;
 b=BpEPkxK1V5tpswgb2QjZ59hMzI+kRd9pGbYmeTTE7tiJR+Ms8eawe7qbi5GDx1GON9t/Cn
 LRmWZcN221v8f/CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D029779AA;
 Fri, 17 Jul 2026 12:33:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id p6cMEQ8hWmr7LgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 17 Jul 2026 12:33:19 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 17 Jul 2026 14:33:17 +0200
Message-Id: <20260717-fix_core_library-v1-0-c575fcbb2cb3@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAA0hWmoC/x2MWwqAIBAAryL7naB92OMqEWK61kJkrBBFePekz
 4GZeSEjE2YYxQuMF2VKRwXdCPCbO1aUFCpDq1qjOt3JSLf1idHutLDjR/ohYjRmCX2IULOTsTr
 /cppL+QCNdzUAYgAAAA==
X-Change-ID: 20260717-fix_core_library-c9fef66bd8df
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784291599; l=828;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=QX9zJ+U92+TNWeWhGq6ZbwNiVPKJWQ1y0JmOHDoHTjg=;
 b=P7dBbDj3d111PHHl9J2gRzZWyhO7SGxotnjCdWGImRjEgKgJokXAQ6r6hRcCALZGTfrELoHRB
 bQd7mB6wfljCILoDpVaUdYxibuOxWnCK+YVnl/Mdnl5N/CrVxNQmFkU
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/3] Fix bugs in LTP core library
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

These bugs were found by LLM long time ago, after asking to check for
errors in memory management and general usage. An in-depth analysis was
not done, because these were mostly cases where LTP might produce false
positives or crash the application. Keep it simple.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Andrea Cervesato (3):
      lib: Avoid loop_info.lo_name buffer overflow
      lib: Close directory fd on ENOSPC in tst_fill_fs
      lib: Fix wrong field in tst_iovec_alloc

 lib/tst_buffers.c | 2 +-
 lib/tst_device.c  | 2 +-
 lib/tst_fill_fs.c | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)
---
base-commit: a67fe5f7b20492ff6ee7f4b1776a7579d4b3859b
change-id: 20260717-fix_core_library-c9fef66bd8df

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
