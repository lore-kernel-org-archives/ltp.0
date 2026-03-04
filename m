Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB9AEF8FE1
	for <ltp@archiver.kernel.org>; Wed,  4 Mar 2026 13:26:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 49C813DB2CD
	for <ltp@archiver.kernel.org>; Wed,  4 Mar 2026 14:26:17 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AED2B3C61C5
 for <ltp@lists.linux.it>; Wed,  4 Mar 2026 14:25:55 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0E5671000A0B
 for <ltp@lists.linux.it>; Wed,  4 Mar 2026 14:25:54 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 505E25BDF8;
 Wed,  4 Mar 2026 13:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1772630754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ivDTVPejXN3q0dzLBe/9H6e6BXhyxDnXRhYfXV2nMgk=;
 b=mb83tk6dqc6clR12MiJLPQ/1as6nmET0El+pJuequ7oBZnvdHg76uMtShaFTiKjIdl4low
 VXSWK4gdCVvomtUYQe6hLInSJhZZo0JBDJ5OJMI9d4tBg446NWhfmkWHS1wpvQkWywOGQ9
 CDPog5C5EG46Nb/ra6VIydI1kZSASF8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1772630754;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ivDTVPejXN3q0dzLBe/9H6e6BXhyxDnXRhYfXV2nMgk=;
 b=sw34ZHkCJRoIjtTE3//jQtxdsSMWibz2gol/xRfzuS8KqwaMIvU6cSMfvTjW94jxRXmERp
 +qeZHqc1VfKLwJAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=mb83tk6d;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=sw34ZHkC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1772630754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ivDTVPejXN3q0dzLBe/9H6e6BXhyxDnXRhYfXV2nMgk=;
 b=mb83tk6dqc6clR12MiJLPQ/1as6nmET0El+pJuequ7oBZnvdHg76uMtShaFTiKjIdl4low
 VXSWK4gdCVvomtUYQe6hLInSJhZZo0JBDJ5OJMI9d4tBg446NWhfmkWHS1wpvQkWywOGQ9
 CDPog5C5EG46Nb/ra6VIydI1kZSASF8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1772630754;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ivDTVPejXN3q0dzLBe/9H6e6BXhyxDnXRhYfXV2nMgk=;
 b=sw34ZHkCJRoIjtTE3//jQtxdsSMWibz2gol/xRfzuS8KqwaMIvU6cSMfvTjW94jxRXmERp
 +qeZHqc1VfKLwJAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 271A43EA69;
 Wed,  4 Mar 2026 13:25:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KEh1B+IyqGlBTgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 04 Mar 2026 13:25:54 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 04 Mar 2026 14:25:38 +0100
Message-Id: <20260304-stream_refactoring-v2-0-3e48ada8ff1a@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIANIyqGkC/22NQQ7CIBBFr9LMWgygxerKe5jGUJi2sygYphJN0
 7uLTdy5fH/+f7MAYyJkuFQLJMzEFEMBvavAjTYMKMgXBi21kUpLwXNCO90T9tbNMVEYxLGrrcG
 zl9afoAwf5UivTXprC4/EpfnefmT1TX+6wz9dVkIK3aiuqXtjO6mv/GTcuzhBu67rB/EI1JmzA
 AAA
X-Change-ID: 20260120-stream_refactoring-4b5a6e9d0ad7
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772630754; l=1779;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=OZYo5YdFVywImlmRJfrs8cgLn+G8AVyapjxcf8/r/p0=;
 b=6M+E+oQVzL6I5p1zf0t3NUoDnuMN1iHJ4QblCO6/SagZBzeWmazBC7v2L4lWySrg0BX3vxKDu
 5i6qSPWp6XgApBXRLYkcwmvOlgBmKDD9qtRHJmhQDlfezpyyj5+pCjQ
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 505E25BDF8
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/6] Rewrite fs stream testing suite
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
Changes in v2:
- add SAFE_FFLUSH() macro
- remove cleanup_fn from SAFE_* macros
- stream01: use a double buffer to write data inside file
- stream02: check if stream is NULL after fopen()
- stream05: use SAFE_FFLUSH()
- stream05: don't overengineer SAFE_FILENO() with TST_EXP_FD()
- Link to v1: https://lore.kernel.org/r/20260123-stream_refactoring-v1-0-281b85f6ab02@suse.com

---
Andrea Cervesato (6):
      Add safe macros for stream testing suite
      fs: rewrite stream01 test using new API
      fs: rewrite stream02 test using new API
      fs: rewrite stream03 test using new API
      fs: rewrite stream04 test using new API
      fs: rewrite stream05 test using new API

 include/safe_stdio_fn.h               |  21 +++
 include/tst_safe_stdio.h              |  21 +++
 lib/safe_stdio.c                      | 101 +++++++++++
 testcases/kernel/fs/stream/stream01.c | 155 +++++-----------
 testcases/kernel/fs/stream/stream02.c | 136 ++++----------
 testcases/kernel/fs/stream/stream03.c | 326 ++++++----------------------------
 testcases/kernel/fs/stream/stream04.c | 147 +++++----------
 testcases/kernel/fs/stream/stream05.c | 258 +++++----------------------
 8 files changed, 362 insertions(+), 803 deletions(-)
---
base-commit: 23ea0f0f8064f68bbf4d5c5f4f037ef18a5848d8
change-id: 20260120-stream_refactoring-4b5a6e9d0ad7

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
