Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5595AC02198
	for <ltp@archiver.kernel.org>; Fri, 14 Feb 2025 11:21:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9D6823C9AF0
	for <ltp@archiver.kernel.org>; Fri, 14 Feb 2025 12:21:49 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 387703C90F9
 for <ltp@lists.linux.it>; Fri, 14 Feb 2025 12:21:32 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ipv4:195.135.223.131/32) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 96F3A1029638
 for <ltp@lists.linux.it>; Fri, 14 Feb 2025 12:21:31 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C6E2F211F8
 for <ltp@lists.linux.it>; Fri, 14 Feb 2025 11:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739532089; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=iIVL5T5R+qhTdBeW6ROlgBmIGwuAhjgCRsgTTA3UeMo=;
 b=QYOz122zrY764FRW5DbRHZVjOx13ksgrJkTOtsJuywHx8raNKDOu29TNq0RXK/dVdetqmY
 8e25SbsM+isa0vfpXhUwcojGm5W3lwCDOLLEw5Xfz2jD94DPkewSIIuwNSfSJPNJb6JS+Z
 fxgv+ZlvXt9Xb3iEHERzbX2kjRZL1yw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739532089;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=iIVL5T5R+qhTdBeW6ROlgBmIGwuAhjgCRsgTTA3UeMo=;
 b=FwbtLXYy7DZss0Gue7Qt0D1ggbI8mTACQZfy0/3iB9behrHW1bxVBjt9BRsV/vTnJEfi8F
 G+nDkbghU33JQRCg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=QYOz122z;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=FwbtLXYy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739532089; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=iIVL5T5R+qhTdBeW6ROlgBmIGwuAhjgCRsgTTA3UeMo=;
 b=QYOz122zrY764FRW5DbRHZVjOx13ksgrJkTOtsJuywHx8raNKDOu29TNq0RXK/dVdetqmY
 8e25SbsM+isa0vfpXhUwcojGm5W3lwCDOLLEw5Xfz2jD94DPkewSIIuwNSfSJPNJb6JS+Z
 fxgv+ZlvXt9Xb3iEHERzbX2kjRZL1yw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739532089;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=iIVL5T5R+qhTdBeW6ROlgBmIGwuAhjgCRsgTTA3UeMo=;
 b=FwbtLXYy7DZss0Gue7Qt0D1ggbI8mTACQZfy0/3iB9behrHW1bxVBjt9BRsV/vTnJEfi8F
 G+nDkbghU33JQRCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B8375137DB
 for <ltp@lists.linux.it>; Fri, 14 Feb 2025 11:21:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WsP7Kzknr2flXwAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Fri, 14 Feb 2025 11:21:29 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 14 Feb 2025 12:21:33 +0100
Message-ID: <20250214112135.18947-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.45.3
MIME-Version: 1.0
X-Rspamd-Queue-Id: C6E2F211F8
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 RCPT_COUNT_ONE(0.00)[1]; FUZZY_BLOCKED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+]; TO_DN_NONE(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/2] shell lib: Add very simple cleanup support
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

This implements a simple shell library cleanup support by utilizing the
shell trap buildin. With that the cleanup is executed when the shell
script is about to exit.

Alternative we do not have to add the TST_CLEANUP variable at all and
use the trap directly in the shell tests instead. In that case we can
drop the change from tst_env.sh and change the two tests to use trap
directly instead.

Cyril Hrubis (2):
  testcases/lib/run_tests.sh
  shell lib: Add support for test cleanup

 testcases/lib/run_tests.sh                    |  5 ++++-
 .../lib/tests/shell_loader_brk_cleanup.sh     | 20 ++++++++++++++++++
 testcases/lib/tests/shell_loader_cleanup.sh   | 21 +++++++++++++++++++
 testcases/lib/tst_env.sh                      |  4 ++++
 4 files changed, 49 insertions(+), 1 deletion(-)
 create mode 100755 testcases/lib/tests/shell_loader_brk_cleanup.sh
 create mode 100755 testcases/lib/tests/shell_loader_cleanup.sh

-- 
2.45.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
