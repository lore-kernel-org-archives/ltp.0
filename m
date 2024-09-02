Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD437CA0ED3
	for <ltp@archiver.kernel.org>; Mon,  2 Sep 2024 12:45:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 133DE3C4C0D
	for <ltp@archiver.kernel.org>; Mon,  2 Sep 2024 14:45:30 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3134A3C29B2
 for <ltp@lists.linux.it>; Mon,  2 Sep 2024 14:45:14 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 440C61400B8D
 for <ltp@lists.linux.it>; Mon,  2 Sep 2024 14:45:13 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6CDA71FBAD;
 Mon,  2 Sep 2024 12:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725281113; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=63UuFMyKqN70WjtDy3xhYOR6f7FiJO8J1J3VOdKZOA0=;
 b=bKApPuFA/zVQBY0Wpe4XW5jXgXte12Zdm7TE9giiqqo7N2HvfiNOqqX8J+ZDj9q+oBlv3Q
 jCnoTq0A+KzFNW/r5JPg9S43xGvvSlv+w8SvIUN43E2I/IwFh+mPUp4lV8536YKvg6jPGT
 I3JqTsckmFX+tvFsBJx+pgS6MVAPom8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725281113;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=63UuFMyKqN70WjtDy3xhYOR6f7FiJO8J1J3VOdKZOA0=;
 b=cmeLBZUfKWC7i2jOKgY28/NdOj8klZkhYrTtlmHYV9KZ9kfOLarPedQfc5+cibdcmMiBCB
 FXYfJTPQc+wFGJAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725281113; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=63UuFMyKqN70WjtDy3xhYOR6f7FiJO8J1J3VOdKZOA0=;
 b=bKApPuFA/zVQBY0Wpe4XW5jXgXte12Zdm7TE9giiqqo7N2HvfiNOqqX8J+ZDj9q+oBlv3Q
 jCnoTq0A+KzFNW/r5JPg9S43xGvvSlv+w8SvIUN43E2I/IwFh+mPUp4lV8536YKvg6jPGT
 I3JqTsckmFX+tvFsBJx+pgS6MVAPom8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725281113;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=63UuFMyKqN70WjtDy3xhYOR6f7FiJO8J1J3VOdKZOA0=;
 b=cmeLBZUfKWC7i2jOKgY28/NdOj8klZkhYrTtlmHYV9KZ9kfOLarPedQfc5+cibdcmMiBCB
 FXYfJTPQc+wFGJAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C25A113AE0;
 Mon,  2 Sep 2024 12:45:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id h9OIJFiz1WbqFAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 02 Sep 2024 12:45:12 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 02 Sep 2024 14:45:00 +0200
Message-Id: <20240902-fcntl4_refactoring-v4-0-4446517da427@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAEyz1WYC/x2MWwqAIBAArxL7nSBiz6tEhNpqC6GhEoF096TPY
 ZgpkDASJpibAhFvShR8Bdk2YA7lHTLaK4PgQvKJC2aNz6fcIlplcojkHVNjb/mgje5QQA2vKun
 5p8v6vh/M6KlBZAAAAA==
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725281112; l=899;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=fMbxcF+Evyo+jxZ3JOV6Z2x6LZDA9Ze9ue6Qdv4iU5U=;
 b=lpho1W4FkY/VwFM1cxO60NG64nLEblX8n7WT2ux9m/EEwxh+7IjnU0wfLpRNwrvcFC0ZGOm3I
 r5Yy3+Sb5DLBcp9yfyMRiLB/uLCoqUApDWUtMeWjdCcTWzD5zNPwgd1
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.com:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 0/2] fcntl14 refactoring
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

This patch-set simplify the fcntl14 test and add some new silent macros
to the TST_EXP_EQ_* series.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v4:
- add test variants
- add TST_EXP_EQ_*_SILENT macros
- simplify testcases configuration
- changes overlapping algorithm
- don't exit each time we fail
- don't unlock on file close

---
Andrea Cervesato (2):
      Add silent macros for TST_EXP_EQ_*
      Rewrite fcnt14 test

 include/tst_test_macros.h                 |   81 +-
 runtest/syscalls                          |    4 +-
 testcases/kernel/syscalls/fcntl/fcntl14.c | 1253 +++++------------------------
 3 files changed, 273 insertions(+), 1065 deletions(-)
---
base-commit: 9a6f3896ffe5c5bfd36c5a2c303a884faa3cb18e
change-id: 20240902-fcntl4_refactoring-a86f07bcb5e2

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
