Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09F2FE7717D
	for <ltp@archiver.kernel.org>; Wed, 11 Dec 2024 12:21:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 78F293E7D06
	for <ltp@archiver.kernel.org>; Wed, 11 Dec 2024 13:21:44 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 182D33E88F3
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 13:20:28 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DA00E142D4F9
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 13:20:27 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B395F1F38C
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 12:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733919626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ynDvNnUEW112bTDxxpmRB6kNznuxUPwWj41q9984QV0=;
 b=xAZQlgB6yJB+TpjyaXx0j0zcKnWe/v+AH0g8qOrCWNeFkybJDpY7Z30fBZ4jKisCLyuLGb
 UFyQttxiU87+xRrylDEdArR5IlbcGgMG4uqMLw7dvYMKGaT66Bi3iCOBWt7QznAorbOKZa
 /o7sipa2sGbSouD6vqCRPeppYKjr3NY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733919626;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ynDvNnUEW112bTDxxpmRB6kNznuxUPwWj41q9984QV0=;
 b=o89XNLSEDhR2IWol567174N/QGh9fNPGM/zx8h6bUT1m1o1NUrQsXF8cPm/wCjB7G+QJ/+
 MvFTMzKFOXGzFnCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xAZQlgB6;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=o89XNLSE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733919626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ynDvNnUEW112bTDxxpmRB6kNznuxUPwWj41q9984QV0=;
 b=xAZQlgB6yJB+TpjyaXx0j0zcKnWe/v+AH0g8qOrCWNeFkybJDpY7Z30fBZ4jKisCLyuLGb
 UFyQttxiU87+xRrylDEdArR5IlbcGgMG4uqMLw7dvYMKGaT66Bi3iCOBWt7QznAorbOKZa
 /o7sipa2sGbSouD6vqCRPeppYKjr3NY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733919626;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ynDvNnUEW112bTDxxpmRB6kNznuxUPwWj41q9984QV0=;
 b=o89XNLSEDhR2IWol567174N/QGh9fNPGM/zx8h6bUT1m1o1NUrQsXF8cPm/wCjB7G+QJ/+
 MvFTMzKFOXGzFnCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AA7481344A
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 12:20:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ACQ0KYqDWWdNAwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 12:20:26 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 11 Dec 2024 13:20:23 +0100
Message-Id: <20241211-fix_setsid_tests-v1-0-e103f36c6462@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAIeDWWcC/x2MQQqAIBAAvxJ7TtDFTPpKhEhttZcKVyII/550H
 JiZF4QSk8DQvJDoZuHzqGDaBuY9HhspXioDarQGtVUrP0EoCy8hk2RRvnfROnQ9+g5qdiWqzr8
 cp1I+7VatR2IAAAA=
X-Change-ID: 20241204-fix_setsid_tests-876a46267285
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733919626; l=1664;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=S9vNcBnjr3z/3In2Bujo6TSwFIje6xEn9e6adTr+n5U=;
 b=Au3TaCcyo5QbG2D62htnqnLVj9h/l3HRcIU8l7yG98fw9eYMuQZvX2/iwXMnUDDyjqWrZ16Z/
 qASKGoI2s/TAMD9oSwEw1yU3KIYNJKIhwByTyJ/f0fl013HXe2v2Nac
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: B395F1F38C
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid];
 RCPT_COUNT_ONE(0.00)[1]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 00/10] Fix tests failing with setsid
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

Following tests are failing when running on a new session started with
setsid command/syscall: pty01, ptem01, setpgid01.

Tihs patch-set refactor them in order to fix this issue. Some tests like
pty01 and ptem01 have been split into multiple files due to their
complexity.

Fixes: https://github.com/linux-test-project/kirk/issues/28
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Andrea Cervesato (10):
      Refactor setpgid01 test
      Refactor ptem01 test
      Add ptem02 test
      Add ptem03 test
      Add ptem04 test
      Add ptem05 test
      Add ptem06 test
      Refactor pty01 test
      Add pty08 test
      Add pty09 test

 runtest/pty                                   |   7 +
 testcases/kernel/pty/.gitignore               |   7 +
 testcases/kernel/pty/ptem01.c                 | 463 +++-----------------------
 testcases/kernel/pty/ptem02.c                 |  78 +++++
 testcases/kernel/pty/ptem03.c                 |  56 ++++
 testcases/kernel/pty/ptem04.c                 |  57 ++++
 testcases/kernel/pty/ptem05.c                 |  58 ++++
 testcases/kernel/pty/ptem06.c                 |  59 ++++
 testcases/kernel/pty/pty01.c                  | 417 +++--------------------
 testcases/kernel/pty/pty08.c                  |  60 ++++
 testcases/kernel/pty/pty09.c                  |  89 +++++
 testcases/kernel/syscalls/setpgid/setpgid01.c | 152 ++-------
 12 files changed, 592 insertions(+), 911 deletions(-)
---
base-commit: 8f2292af050fd64c447dd462880d0b0a19d79448
change-id: 20241204-fix_setsid_tests-876a46267285

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
