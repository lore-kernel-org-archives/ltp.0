Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90AC1CD1288
	for <ltp@archiver.kernel.org>; Wed,  3 Apr 2024 08:27:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A52923C19E8
	for <ltp@archiver.kernel.org>; Wed,  3 Apr 2024 10:27:34 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B6C903C0FDE
 for <ltp@lists.linux.it>; Wed,  3 Apr 2024 10:27:19 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 05DCA1401636
 for <ltp@lists.linux.it>; Wed,  3 Apr 2024 10:27:18 +0200 (CEST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 08A65350F1
 for <ltp@lists.linux.it>; Wed,  3 Apr 2024 08:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712132837; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=X5pJFf545ApshEVhuu5bKDkT98JMnMU6Av/K9CCeP6Q=;
 b=asKcvW2Tl5QeHe34fYRaFETwVlOuocLMpv2T6eJnc0/PjTPjSiMiiQqFn+w4MDGZFyYTzE
 UYiN4jA+VV2+HwixyX9111nZrnZsTHX7CHJSuxrPjat7AY1qRmD6KG02BegTzIHB4NOV+6
 W10abVVDNdbugxkx4oBsCa9l/wyNbV8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712132837;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=X5pJFf545ApshEVhuu5bKDkT98JMnMU6Av/K9CCeP6Q=;
 b=QcrW5Ae2Aw+YfdQdyNt3n75SIc+H0Wu6aaF560FvIHU/Y7/X9Hf5+IUMamICzrNyYsuKwQ
 4GXZH/ssVc/DAvBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id EA77B13357
 for <ltp@lists.linux.it>; Wed,  3 Apr 2024 08:27:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap2.dmz-prg2.suse.org with ESMTPSA id ja/lOOQSDWaSLwAAn2gu4w
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 03 Apr 2024 08:27:16 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  3 Apr 2024 10:26:16 +0200
Message-ID: <20240403082618.5829-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [1.18 / 50.00]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 BAYES_HAM(-0.01)[47.93%]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:rdns,imap2.dmz-prg2.suse.org:helo];
 RCPT_COUNT_ONE(0.00)[1]; R_DKIM_NA(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Spamd-Bar: +
X-Rspamd-Queue-Id: 08A65350F1
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/2] doc: Add generated API docs
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

This applies over the new doc patchset from Andrea and converts
documentation in headers into a linuxdoc format.

This is a v2 with spelling fixes hopefully all the easily caught
mistakes are fixed now.

If you have a bit of time please read the changes through and report any
problems.

V3: Removed the unused tst_compiler.h
V2: Spell checks

Cyril Hrubis (2):
  doc: Add more to spelling_wordlist
  include: doc: Convert comments into linuxdoc

 doc_new/developers/api_c_tests.rst |  26 ++
 doc_new/spelling_wordlist          |  40 +++
 include/tst_buffers.h              |  86 +++--
 include/tst_capability.h           |  80 ++++-
 include/tst_checkpoint.h           |  64 +++-
 include/tst_hugepage.h             |   2 +
 include/tst_parse.h                |  65 ++++
 include/tst_res_flags.h            |  72 +++-
 include/tst_test.h                 | 509 +++++++++++++++++++++--------
 9 files changed, 742 insertions(+), 202 deletions(-)
 create mode 100644 include/tst_parse.h

-- 
2.43.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
