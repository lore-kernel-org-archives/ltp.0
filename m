Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45366CCFA05
	for <ltp@archiver.kernel.org>; Fri,  7 Nov 2025 10:30:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7A7F83CD4E4
	for <ltp@archiver.kernel.org>; Fri,  7 Nov 2025 11:30:00 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6D2B83C0EFB
 for <ltp@lists.linux.it>; Fri,  7 Nov 2025 11:29:44 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D049D1000D85
 for <ltp@lists.linux.it>; Fri,  7 Nov 2025 11:29:43 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 011772117F;
 Fri,  7 Nov 2025 10:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762511383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=AmOmQcgWJQWcC7fU5sDQ6Ki8ZXyxTThfj9lmkiCS7IQ=;
 b=23fSWa4mFM5Ud9JGO/+FbO5wG3fNHYK9OQzG+P3BLRQWqvOF589pCSi4YoQdTZb08bIeqV
 PZY2mZzboE83GHUGbrBlVGm9/brefhf2xsZGE1/FsEbmEQlXZuqqdtPsul6373pyDqh3pb
 NFmlrcNw79H1/1Y+adllbKf/eHHhdb8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762511383;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=AmOmQcgWJQWcC7fU5sDQ6Ki8ZXyxTThfj9lmkiCS7IQ=;
 b=Z8eKK/bmAjJI+IthcmZ0QIxrE+q3AoEPMHC2pmZVe5480wttMP+OZBpg3jLmoZICgsF2Dr
 t8pGU3NyqFAKqzAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762511383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=AmOmQcgWJQWcC7fU5sDQ6Ki8ZXyxTThfj9lmkiCS7IQ=;
 b=23fSWa4mFM5Ud9JGO/+FbO5wG3fNHYK9OQzG+P3BLRQWqvOF589pCSi4YoQdTZb08bIeqV
 PZY2mZzboE83GHUGbrBlVGm9/brefhf2xsZGE1/FsEbmEQlXZuqqdtPsul6373pyDqh3pb
 NFmlrcNw79H1/1Y+adllbKf/eHHhdb8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762511383;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=AmOmQcgWJQWcC7fU5sDQ6Ki8ZXyxTThfj9lmkiCS7IQ=;
 b=Z8eKK/bmAjJI+IthcmZ0QIxrE+q3AoEPMHC2pmZVe5480wttMP+OZBpg3jLmoZICgsF2Dr
 t8pGU3NyqFAKqzAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A5C3C132DD;
 Fri,  7 Nov 2025 10:29:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hSddIxbKDWlKQQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 07 Nov 2025 10:29:42 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  7 Nov 2025 11:29:31 +0100
Message-ID: <20251107102939.1111074-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.986];
 MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/8] tst_test.c: Minor return code cleanup
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

Hi,

the only important change is the first commit.

Kind regards,
Petr

Petr Vorel (7):
  tst_test.c: Fix tst_check_cmd() use
  tst_test.c: Change check_kver() return type to bool
  tst_test.c: Change results_equal() return type to bool
  tst_test.c: Change needs_tmpdir() return type to bool
  tst_test.c: Change run_tcases_per_fs() return type to void
  tst_test.c: Change run_tcase_on_fs() return type to void
  tst_test.c: Change fork_testrun() return type to void

Wei Gao (1):
  tst_cmd.c: Check brk_nosupp when tst_get_path failed

 include/tst_private.h |  5 ++++
 lib/tst_cmd.c         | 10 +++++--
 lib/tst_test.c        | 61 +++++++++++++++++++++++--------------------
 3 files changed, 45 insertions(+), 31 deletions(-)

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
