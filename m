Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FBFBC54E71
	for <ltp@archiver.kernel.org>; Fri, 22 Mar 2024 12:08:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5AF043CFB9B
	for <ltp@archiver.kernel.org>; Fri, 22 Mar 2024 13:08:11 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7C1703C997B
 for <ltp@lists.linux.it>; Fri, 22 Mar 2024 13:07:56 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 708D21A010A8
 for <ltp@lists.linux.it>; Fri, 22 Mar 2024 13:07:54 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DD80938507
 for <ltp@lists.linux.it>; Fri, 22 Mar 2024 12:07:53 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CED0B13688
 for <ltp@lists.linux.it>; Fri, 22 Mar 2024 12:07:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id pXKBMZl0/WXPeAAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Fri, 22 Mar 2024 12:07:53 +0000
From: Cyril Hrubis <metan@ucw.cz>
To: ltp@lists.linux.it
Date: Fri, 22 Mar 2024 13:06:59 +0100
Message-ID: <20240322120700.3072-1-metan@ucw.cz>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [4.02 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-0.08)[63.32%];
 FROM_HAS_DN(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 BROKEN_CONTENT_TYPE(1.50)[]; RCPT_COUNT_ONE(0.00)[1];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 TO_DN_NONE(0.00)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MID_CONTAINS_FROM(1.00)[];
 FORGED_SENDER(0.30)[metan@ucw.cz,chrubis@suse.cz];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 FROM_NEQ_ENVFROM(0.10)[metan@ucw.cz,chrubis@suse.cz];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/1] doc: Add generated API docs
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

I'm sending this early to get feedback, there is likely many typos, I
will read it again on Monday fix as many typos as possible and send v2.

Cyril Hrubis (1):
  include: doc: Convert comments into linuxdoc

 doc_new/developers/api_c_tests.rst |  26 ++
 include/tst_buffers.h              |  86 +++--
 include/tst_capability.h           |  80 ++++-
 include/tst_checkpoint.h           |  64 +++-
 include/tst_compiler.h             |  20 ++
 include/tst_hugepage.h             |   2 +
 include/tst_parse.h                |  65 ++++
 include/tst_res_flags.h            |  72 +++-
 include/tst_test.h                 | 505 +++++++++++++++++++++--------
 9 files changed, 720 insertions(+), 200 deletions(-)
 create mode 100644 include/tst_compiler.h
 create mode 100644 include/tst_parse.h

-- 
2.43.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
