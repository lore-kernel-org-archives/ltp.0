Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87AEEC25B78
	for <ltp@archiver.kernel.org>; Tue, 28 May 2024 12:06:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1C3453D053C
	for <ltp@archiver.kernel.org>; Tue, 28 May 2024 14:06:41 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D21773C67E5
 for <ltp@lists.linux.it>; Tue, 28 May 2024 14:06:02 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id EAD681002884
 for <ltp@lists.linux.it>; Tue, 28 May 2024 14:06:01 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D2B93227F7;
 Tue, 28 May 2024 12:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716897961; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=5jKzxMn0xhxlUue9wfDhF/8gcTTPx2m7LCwQB07QevU=;
 b=YBfCveB0TWkDIJi2CJ+TWVbnS4DN0NyyLXv60HhWalAu+hg1gPzIwsZ4YFFLfJljR7QVSb
 CFzkRwBLtXVUBbij2koH7QVgi2TpkyC82guvc71NRAoax+UJgmIjSoTqRNObfWL5qgYixv
 KejNHtmA1Qc/CKhYWr7F2sjrHRCfrvg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716897961;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=5jKzxMn0xhxlUue9wfDhF/8gcTTPx2m7LCwQB07QevU=;
 b=quLDvwejxi1jQrHhb39RR5aXi1uP+ziRr+DvdcI2qqypUNfFSmrwuikF3gcSH63WkUN+JV
 JaAByIKn/U3fD7CQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=tTempyWD;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=KFyJ6uWX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716897960; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=5jKzxMn0xhxlUue9wfDhF/8gcTTPx2m7LCwQB07QevU=;
 b=tTempyWDn7DdU0v46j+ZciFfpoOPS/Gmn7LK76NtBLxldCs47DOjDsNfYr2M4sYJp0QV4C
 6SHyq6f7rm5E5xepD3lVsAO9OduhASPdDoFEce9GYiHgCUV6mPOeeHEm5Vb7ZMhCijH14U
 pMrMKF2E2rdE3IFOskzw0cxOzbEcq8c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716897960;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=5jKzxMn0xhxlUue9wfDhF/8gcTTPx2m7LCwQB07QevU=;
 b=KFyJ6uWX4sv5qpK/B9MB302W/19qtYglsBsrI36KWv48Wuzo2sHCfUr3Hd2gI8Q8jX1xkI
 6iqwsUajYKj2XgAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A229E13A5D;
 Tue, 28 May 2024 12:06:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id dXceJajIVWYjTQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 28 May 2024 12:06:00 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 28 May 2024 14:05:52 +0200
Message-ID: <20240528120554.433874-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: D2B93227F7
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/2] lib: Add TINFO_WARN
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

if we found this useful, is it worth to implement it also in the shell
API?

Regardless the result, should it be TDEBUG backported to the shell API?

Kind regards,
Petr

Petr Vorel (2):
  lib: Add TINFO_WARN
  tree: Use TINFO_WARN

 include/tst_res_flags.h                         |  6 +++++-
 include/tst_test.h                              |  2 +-
 lib/newlib_tests/tst_res_flags.c                |  1 +
 lib/tst_ansi_color.c                            |  1 +
 lib/tst_res.c                                   | 12 ++++++++----
 lib/tst_supported_fs_types.c                    |  2 +-
 lib/tst_test.c                                  |  3 +++
 testcases/kernel/mem/hugetlb/lib/hugetlb.c      |  4 ++--
 testcases/kernel/syscalls/ipc/semctl/semctl08.c |  2 +-
 9 files changed, 23 insertions(+), 10 deletions(-)

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
