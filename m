Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AFFFC25B74
	for <ltp@archiver.kernel.org>; Tue, 21 May 2024 10:54:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 650523D0091
	for <ltp@archiver.kernel.org>; Tue, 21 May 2024 12:54:25 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2C3FA3C0562
 for <ltp@lists.linux.it>; Tue, 21 May 2024 12:53:53 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4DFD860103B
 for <ltp@lists.linux.it>; Tue, 21 May 2024 12:53:52 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2D4F95C07E;
 Tue, 21 May 2024 10:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716288832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=c+DfkuTG+h/AngWQ9ZAZCY5jyAGhR1nhZe0cxY3/+/M=;
 b=TT0ni5uHqrhluNX+N7mxs+gbGzSqVsrRkWlH7MLGPDhIpM6cVVqsQNLUxP5Pge+XOYfid9
 X0yA9vNLWwKzTeVkDdzAzXezayfW7xQqVm+LFj7eH9yJaH7LK5onVc3Jy2/Z7rLC0gbp6K
 FkfjX+LvOKJDKxpbWHovKvwEtgX7zlw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716288832;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=c+DfkuTG+h/AngWQ9ZAZCY5jyAGhR1nhZe0cxY3/+/M=;
 b=nxwKXNFAqlkfR/zCFpkgdEuA079PTdqfGGX35IInzfnMbgMrdJJXgHgT3tEqyxo5supmb/
 V8BY/+dwM8VZ43Ag==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=nuugEuoC;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=qj7N4B3E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716288831; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=c+DfkuTG+h/AngWQ9ZAZCY5jyAGhR1nhZe0cxY3/+/M=;
 b=nuugEuoCnFlL2wXpHzAaoOQqzfuZeVVQMKwp0cDNeDbgX/X7FM1piZDlwXW4j36QHl7e58
 aV/eqrfErGDLtrGV3v6LVbK8ZIiWGRa/RZf/qprKDqNtWSKgsagDUTueIz4Fw1BmQt0qYn
 SRXpdndBTwGhfE7Lto5sm00D+q6idYw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716288831;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=c+DfkuTG+h/AngWQ9ZAZCY5jyAGhR1nhZe0cxY3/+/M=;
 b=qj7N4B3EmfUsG47BGOkog9tjA9ZyIEgLOTgD4BjW2FOO+ZdxRy8w0Wbdiq5l2i6/4rAuUx
 Buye0Ca/209G/0AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0891213A1E;
 Tue, 21 May 2024 10:53:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6+QnAT99TGYMPwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 21 May 2024 10:53:51 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 21 May 2024 12:53:43 +0200
Message-ID: <20240521105348.126316-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 2D4F95C07E
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_FIVE(0.00)[6];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim, imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/5] .needs_abi_bits + rewrite fork14 to new API
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

Changes v1->v2:
* Change from .skip_in_32bit to .needs_abi_bits
* update fork14 to use .needs_abi_bits
* convert sbrk03.c to use .needs_abi_bits and .supported_archs
  (NOTE: it'd be nice if .supported_archs also printed supported archs
  in TCONF, so far it only states that the current arch is not
  supported)
* Convert setsockopt0[38].c to use tst_is_compat_mode()

Andrea Cervesato (1):
  Refactor fork14 using new LTP API

Petr Vorel (4):
  tst_kernel.h: Convert docs to sphinx
  lib: Add .needs_abi_bits
  sbrk03: Convert to detect support with flags
  setsockopt0[38]: Use tst_is_compat_mode()

 doc/developers/api_c_tests.rst                |   2 +
 include/tst_kernel.h                          |  55 +++--
 include/tst_test.h                            |   7 +-
 lib/tst_kernel.c                              |  10 +
 lib/tst_test.c                                |   5 +-
 testcases/kernel/syscalls/fork/fork14.c       | 209 ++++++++----------
 testcases/kernel/syscalls/sbrk/sbrk03.c       |   9 +-
 .../kernel/syscalls/setsockopt/setsockopt03.c |   5 +-
 .../kernel/syscalls/setsockopt/setsockopt08.c |   6 +-
 9 files changed, 165 insertions(+), 143 deletions(-)

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
