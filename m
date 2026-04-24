Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3557CFE51F5
	for <ltp@archiver.kernel.org>; Fri, 24 Apr 2026 09:40:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AB60F3E4A73
	for <ltp@archiver.kernel.org>; Fri, 24 Apr 2026 11:40:32 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A58103E5345
 for <ltp@lists.linux.it>; Fri, 24 Apr 2026 11:39:38 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id EEF2510005F5
 for <ltp@lists.linux.it>; Fri, 24 Apr 2026 11:39:37 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 91F0A5BCC5;
 Fri, 24 Apr 2026 09:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777023571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=la5WxhJ6WDQ9iOkK61Num41FEBdBJYzdvSHW49RZ5fo=;
 b=bO1jJhRulFGSgxtPNdc1nv0fJXwEtB2udwNgaaYmrLYtbfu1P9rPFyAcr0JNM4ov9O0kiC
 +kwOBl5PVvY0e21Glz9wOsa7oaZDLH8+8W/jj0CSoRatSMJOFpdaijP3k2QUxvz3ClXeGI
 XSzmXs2FpRm2zYqnBF34pUi7UONsGiE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777023571;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=la5WxhJ6WDQ9iOkK61Num41FEBdBJYzdvSHW49RZ5fo=;
 b=6ScXPpeQTxHdbcpfkO84elh3eS8TQoLI73VBSgWDsw+cjJOfUYYUY6w0TIDfsCbyRaFmDp
 Ph0IADro3YAMW1AQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=KTk3RCYT;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="/gKduetm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777023570; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=la5WxhJ6WDQ9iOkK61Num41FEBdBJYzdvSHW49RZ5fo=;
 b=KTk3RCYTKpc3/K9uL7F7VMxHQRzVgoF9kwwzTX06ahur3U6rZwLSgGmU7mR2vp6ngiAYm6
 +xE1Ono8bEKrR6wTCd+nFidHaSz+NS7xwTJsiT1sz2itj4DgDXpQSfw7XQqEvKKweFFnCW
 0gYxdgwCzjxrEMWeflp39SRvk19kMGU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777023570;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=la5WxhJ6WDQ9iOkK61Num41FEBdBJYzdvSHW49RZ5fo=;
 b=/gKduetmf03ucUNi6QZrUaW1htZGAVsMCFQl8T9RapeU0gwofChMytwsEcXO07VyPs6GbW
 uo8UQuuk9suXLdAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5F75E593A5;
 Fri, 24 Apr 2026 09:39:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id NTKSFVI662l0TQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 24 Apr 2026 09:39:30 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 24 Apr 2026 11:39:15 +0200
Message-ID: <20260424093919.500059-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,checkpatch.pl:url];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: 91F0A5BCC5
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/4] checkpatch: Add .checkpatch.conf
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

Enhancement to reduce duplicity + add more checks.

Petr Vorel (4):
  Update spellings to next-20260423
  checkpatch: Update to use new features
  Add .checkpatch.conf for checkpatch.pl
  checkpatch: Enable more checks, disable ENOSYS

 .b4-config             |   5 +-
 .checkpatch.conf       |  19 +++
 .gitignore             |   3 +
 include/mk/env_post.mk |   2 +-
 scripts/checkpatch.pl  | 133 ++++++++++++++---
 scripts/spelling.txt   | 331 +++++++++++++++++++++--------------------
 6 files changed, 303 insertions(+), 190 deletions(-)
 create mode 100644 .checkpatch.conf

-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
