Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E170F8D753
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 14:35:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 477233E2A16
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 16:35:41 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E677B3E4ADE
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 16:33:50 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0E1766008EE
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 16:33:49 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 89C9C5BCF8;
 Thu, 16 Apr 2026 14:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776350017; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=JwXwv5R1awBUI2F/kfwo7NqKA8nNHjcVPkg95O9U1/o=;
 b=YyNvG740GfLryeq/+t5xzdbjeXv3kosZw5SFpntRid7wQ/dDNEYkuS7i/ywhCpA9fWdTx4
 ElQlt2L1ubRb8FN0sN/IDLvI6zKBP1YdssPxPjoT/KbABmhx6/xuDpeUkeeEWjq/AhiNrv
 h/aoJGFAba8wKLnsDEpqmIoawkRGPdg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776350017;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=JwXwv5R1awBUI2F/kfwo7NqKA8nNHjcVPkg95O9U1/o=;
 b=rfjk18ze4nq9+jGKBUr6na01x+jvC5Xl9eLS8qn4L+RQXjx2yIHfuHkH2rDNiuP6A1Idea
 MR15eIKCqCXKKZBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776350016; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=JwXwv5R1awBUI2F/kfwo7NqKA8nNHjcVPkg95O9U1/o=;
 b=CG1scczun48bf8uyghAF8daYyQZBTRgtJBPO8srq4Bq1LZP3d7KVdj7XJ0x0Eq+XISHOgD
 QhcQidUnlhm8pkwyG9GACxadHPdG89ZGJbC0Xg40ros+kzcEwKoeuGftixRbWu7K0hsFT2
 XNjpvSk7gAH2zoSS4NXwftOJT8ZuoPQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776350016;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=JwXwv5R1awBUI2F/kfwo7NqKA8nNHjcVPkg95O9U1/o=;
 b=eVoQiN/2JC20R69mXltzAtB5uBwDE7vvcJa+5TZ85f3DGzsbsflFloyrYKwOXpNOnxkfya
 F4N1hDEr1OCqMrBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 60933593A3;
 Thu, 16 Apr 2026 14:33:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id S9hvFUDz4GniGQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 16 Apr 2026 14:33:36 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 16 Apr 2026 16:33:34 +0200
Message-Id: <20260416-stream_refactoring-v2-0-8321b1ec6f68@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAD7z4GkC/22NQQ7CIBBFr9LMWgygxerKe5jGUJi2sygYphJN0
 7uLTdy5fH/+f7MAYyJkuFQLJMzEFEMBvavAjTYMKMgXBi21kUpLwXNCO90T9tbNMVEYxLGrrcG
 zl9afoAwf5UivTXprC4/EpfnefmT1TX+6wz9dVkIK3aiuqXtjO6mv/GTcuzhBu67rB/EI1JmzA
 AAA
X-Change-ID: 20260120-stream_refactoring-4b5a6e9d0ad7
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776350016; l=1962;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=PrOk5dk6uIUo6ZXnh56LLKAxB4aCke+1RgcwilfJCus=;
 b=WgMt60qexJ7PX2l+0EpJtCL7FpHgmePoiqyEeNlelnhpSgQB5IwdF4IkQJggMnz8eYxhd2zH0
 Vf7GUmaeGfuCcnm6b4Kp8UVrxWYmIqi+YN07tGKYrQsbWPzuvj2Vwqw
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email]; 
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:mid,
 suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/7] Rewrite fs stream testing suite
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

All tests are now using the new LTP API. The stream05 has been deleted
because I think it was a bit messy and it didn't have a proper testing
focus. I replaced it with a new test that is just verifying that fd
returned by `fileno()` can be used for basic operations on fd.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v3:
- fix stream01 buffer size
- add TST_EXP_PASS_PTR_NULL() macro

Changes in v2:
- add SAFE_FFLUSH() macro
- remove cleanup_fn from SAFE_* macros
- stream01: use a double buffer to write data inside file
- stream02: check if stream is NULL after fopen()
- stream05: use SAFE_FFLUSH()
- stream05: don't overengineer SAFE_FILENO() with TST_EXP_FD()
- Link to v1: https://lore.kernel.org/r/20260123-stream_refactoring-v1-0-281b85f6ab02@suse.com

---
Andrea Cervesato (7):
      lib: add safe macros for stream testing suite
      fs: rewrite stream01 test using new API
      lib: add TST_EXP_PASS_PTR_NULL() macro
      fs: rewrite stream02 test using new API
      fs: rewrite stream03 test using new API
      fs: rewrite stream04 test using new API
      fs: rewrite stream05 test using new API

 include/safe_stdio_fn.h               |  21 +++
 include/tst_safe_stdio.h              |  21 +++
 include/tst_test_macros.h             |  15 +-
 lib/safe_stdio.c                      | 101 +++++++++++
 testcases/kernel/fs/stream/stream01.c | 155 +++++-----------
 testcases/kernel/fs/stream/stream02.c | 134 ++++----------
 testcases/kernel/fs/stream/stream03.c | 326 ++++++----------------------------
 testcases/kernel/fs/stream/stream04.c | 147 +++++----------
 testcases/kernel/fs/stream/stream05.c | 258 +++++----------------------
 9 files changed, 373 insertions(+), 805 deletions(-)
---
base-commit: 620d596c79493af089ba6a1c4dc79efcc76a67c7
change-id: 20260120-stream_refactoring-4b5a6e9d0ad7

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
