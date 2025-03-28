Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 421E7C28B20
	for <ltp@archiver.kernel.org>; Fri, 28 Mar 2025 09:58:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9F8963CA305
	for <ltp@archiver.kernel.org>; Fri, 28 Mar 2025 10:58:10 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E77A63C9A39
 for <ltp@lists.linux.it>; Fri, 28 Mar 2025 10:57:52 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 116471A0066F
 for <ltp@lists.linux.it>; Fri, 28 Mar 2025 10:57:50 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 079C4210F4;
 Fri, 28 Mar 2025 09:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743155870; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=944lYExBmL/Mzw/fjyqPUJWCHR922OTE80rhuwmuHSk=;
 b=FuSkhd5GcwWxOiQJuU/XwwfvO6z67pjwoXQdXzEyq6HKr4TAB6ccL+q7GgjED8BxjgonOw
 pCeEMSX5zkkd3ZtIuj8fgcm+966Yg4up8fhdgPXIQOp9THGh8PT2RuKfCl23AObHsUUKSg
 5RcMQwVMidniBLxrWfpomdKfAY9rBUg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743155870;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=944lYExBmL/Mzw/fjyqPUJWCHR922OTE80rhuwmuHSk=;
 b=V4/cJ8TNGm8ew67OycxnwgiLsa07Fr7qnxa9usv0fnrLcur9HVu+itDO8vgdBQPXDOrmzv
 MWSuVmvJne/AZsBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743155870; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=944lYExBmL/Mzw/fjyqPUJWCHR922OTE80rhuwmuHSk=;
 b=FuSkhd5GcwWxOiQJuU/XwwfvO6z67pjwoXQdXzEyq6HKr4TAB6ccL+q7GgjED8BxjgonOw
 pCeEMSX5zkkd3ZtIuj8fgcm+966Yg4up8fhdgPXIQOp9THGh8PT2RuKfCl23AObHsUUKSg
 5RcMQwVMidniBLxrWfpomdKfAY9rBUg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743155870;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=944lYExBmL/Mzw/fjyqPUJWCHR922OTE80rhuwmuHSk=;
 b=V4/cJ8TNGm8ew67OycxnwgiLsa07Fr7qnxa9usv0fnrLcur9HVu+itDO8vgdBQPXDOrmzv
 MWSuVmvJne/AZsBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DC43D13998;
 Fri, 28 Mar 2025 09:57:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MDLKNJ1y5mcWHwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 28 Mar 2025 09:57:49 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 28 Mar 2025 10:57:42 +0100
Message-ID: <20250328095747.169011-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 0/5] Update doc related Makefile
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
Cc: =?UTF-8?q?Ricardo=20B=20=2E=20Marli=C3=A8re?= <rbm@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Changes from v3 (all by Andrea):

* Add setup (alias to .venv)
* Move sphinx to requirements.txt (therefore remove handling in Makefile)
* Add support also for fish (csh/tcsh ignored, supporting: fish, bash/zsh)
* Use 'setup' instead of '.venv' in the top level doc target

NOTE: 'distclean' of doc/ directory is not in the top level directory
(IMHO not needed).

Are we there yet?

Kind regards,
Petr

Link to v3:
https://patchwork.ozlabs.org/project/ltp/list/?series=449828&state=*
https://lore.kernel.org/ltp/20250324234016.367228-1-pvorel@suse.cz/T/#t

Link to v2:
https://patchwork.ozlabs.org/project/ltp/list/?series=443894&state=*
https://lore.kernel.org/ltp/20250211233552.1990618-1-pvorel@suse.cz/#r

Link to v1:
https://patchwork.ozlabs.org/project/ltp/patch/20250206143421.1571918-4-pvorel@suse.cz/
https://lore.kernel.org/ltp/20250206143421.1571918-4-pvorel@suse.cz/

Petr Vorel (5):
  doc/Makefile: Remove also metadata/ltp.json
  doc: Add sphinx to requirements.txt
  doc/Makefile: Allow to create and use .venv
  Makefile: Update 'doc' target, add 'doc-clean'
  doc: Note 'make doc' in the building doc

 Makefile                         |  8 +++++++-
 doc/Makefile                     | 25 ++++++++++++++++++++++---
 doc/developers/documentation.rst |  4 ++--
 doc/requirements.txt             |  1 +
 4 files changed, 32 insertions(+), 6 deletions(-)

-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
