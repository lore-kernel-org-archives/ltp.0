Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1665FEE0214
	for <ltp@archiver.kernel.org>; Wed, 11 Sep 2024 08:06:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9F1FB3C1C3D
	for <ltp@archiver.kernel.org>; Wed, 11 Sep 2024 10:06:42 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 649483C05E0
 for <ltp@lists.linux.it>; Wed, 11 Sep 2024 10:06:09 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0DB3C1010408
 for <ltp@lists.linux.it>; Wed, 11 Sep 2024 10:06:07 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CE97A1F88D;
 Wed, 11 Sep 2024 08:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726041965; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7C/jyPKAwq4JqrvloMb2dTIZkhuRrwNk7BmRPuV2w4M=;
 b=ImFNhSlXy9irLs/BpEFeY38jEzIi7ojZkilw1YJowxbZ7VJ41Fg8lgMFHhxsUiRChLivkh
 K31TfCESXhtHixOjZHwn0DpE6eXfs1rWA7tDCKY+xRgFU8xVwPnD8l0zAqydyzZun8j0fK
 D/irmBiU5KOY+pnyY1jOajVyhsmkA5U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726041965;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7C/jyPKAwq4JqrvloMb2dTIZkhuRrwNk7BmRPuV2w4M=;
 b=AEfIoaGjvZsxG0OAT4tu1ZUPhfmVeiNjhEnJfv7mDsbRiJwm3ousrnrYN//FqngSIb3osJ
 LHG3gwUFXntszCCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ImFNhSlX;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=AEfIoaGj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726041965; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7C/jyPKAwq4JqrvloMb2dTIZkhuRrwNk7BmRPuV2w4M=;
 b=ImFNhSlXy9irLs/BpEFeY38jEzIi7ojZkilw1YJowxbZ7VJ41Fg8lgMFHhxsUiRChLivkh
 K31TfCESXhtHixOjZHwn0DpE6eXfs1rWA7tDCKY+xRgFU8xVwPnD8l0zAqydyzZun8j0fK
 D/irmBiU5KOY+pnyY1jOajVyhsmkA5U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726041965;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7C/jyPKAwq4JqrvloMb2dTIZkhuRrwNk7BmRPuV2w4M=;
 b=AEfIoaGjvZsxG0OAT4tu1ZUPhfmVeiNjhEnJfv7mDsbRiJwm3ousrnrYN//FqngSIb3osJ
 LHG3gwUFXntszCCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ACFC013A7C;
 Wed, 11 Sep 2024 08:06:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id VvPoKG1P4Wb3VgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 11 Sep 2024 08:06:05 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 11 Sep 2024 10:05:59 +0200
Message-Id: <20240911-fcntl4_refactoring-v5-0-948401e7131c@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAGdP4WYC/32NSw7CIBCGr9LMWgySoagr72EaQ+nQTqLUQCWah
 ruLPYDL73+ukCgyJTg3K0TKnHgOFfSuATfZMJLgoTIoqVCepBLeheWOt0jeumWOHEZhj62Xpne
 9JgW1+Kwmv7fRa1d54lSTn+0j40/9O5dRSIGIrT6YwaIyl/RKtHfzA7pSyhf0etYUswAAAA==
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726041965; l=1077;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=kRorCoMwbXzN5yX/8Z61VQZPQlKM7jOArNBTEB3YIEw=;
 b=CkzuqT6ghnY2jxgLV971DZpNlEvLsUDM+0NTDMW9fWM6uVQy+oomrBhARQBf+mIZ/3ReH1hIa
 kBW5sDbTwehDZvoCoj71W+6/PIEScYStk11xw8opxAtxc+4BwUVtOVF
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: CE97A1F88D
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:mid];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 0/2] fcntl14 refactoring
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

This patch-set simplify the fcntl14 test and add some new silent macros
to the TST_EXP_EQ_* series.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v5:
- remove *_01 suffix to fcntl14 in syscalls runtest file
- handle TST_PASS in a better way inside tst_safe_macros.h
- Link to v4: https://lore.kernel.org/r/20240902-fcntl4_refactoring-v4-0-4446517da427@suse.com

Changes in v4:
- add test variants
- add TST_EXP_EQ_*_SILENT macros
- simplify testcases configuration
- changes overlapping algorithm
- don't exit each time we fail
- don't unlock on file close

---
Andrea Cervesato (2):
      Add silent macros for TST_EXP_EQ_*
      Rewrite fcnt14 test

 include/tst_test_macros.h                 |   81 +-
 testcases/kernel/syscalls/fcntl/fcntl14.c | 1253 +++++------------------------
 2 files changed, 271 insertions(+), 1063 deletions(-)
---
base-commit: 0bd4e66a7ccfb2951148fae65cfa02076ee8f4de
change-id: 20240902-fcntl4_refactoring-a86f07bcb5e2

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
