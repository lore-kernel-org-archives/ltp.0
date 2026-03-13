Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2361105F7AF
	for <ltp@archiver.kernel.org>; Fri, 13 Mar 2026 14:26:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CEC053E52B2
	for <ltp@archiver.kernel.org>; Fri, 13 Mar 2026 15:26:25 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6F4073E12E9
 for <ltp@lists.linux.it>; Fri, 13 Mar 2026 15:26:07 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9AB2560094B
 for <ltp@lists.linux.it>; Fri, 13 Mar 2026 15:26:06 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 47BB25BCFE;
 Fri, 13 Mar 2026 14:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773411965; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=z+7q/X4yvElsqgIqHhDKZ4ckyhy/Rqbr4JsRxAK+AtU=;
 b=OovQdwkgZLLboQRwt+tFPCnIaI1Zi0tpzlOrea++VtmDDDK02ED5jpDLtFbBCm7+RyQGxc
 65HgMWyE0InkWWQYv3OTXlbSerNVfs0+7XxxlwwH/Zv00Kk2FNKxSla6v/YOu6bhzTdNfm
 7UsTB2zOpRpeNhnTW8MPN4aAbPLpNh8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773411965;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=z+7q/X4yvElsqgIqHhDKZ4ckyhy/Rqbr4JsRxAK+AtU=;
 b=viNbAxmqwAgULw/zlBTyIRIy0DjVj3PmGytHOVgfw1Mih72cz4j4jBdIbDm27vLa5Isa4N
 +hVC5GP6I7BuJ0Cw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773411965; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=z+7q/X4yvElsqgIqHhDKZ4ckyhy/Rqbr4JsRxAK+AtU=;
 b=OovQdwkgZLLboQRwt+tFPCnIaI1Zi0tpzlOrea++VtmDDDK02ED5jpDLtFbBCm7+RyQGxc
 65HgMWyE0InkWWQYv3OTXlbSerNVfs0+7XxxlwwH/Zv00Kk2FNKxSla6v/YOu6bhzTdNfm
 7UsTB2zOpRpeNhnTW8MPN4aAbPLpNh8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773411965;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=z+7q/X4yvElsqgIqHhDKZ4ckyhy/Rqbr4JsRxAK+AtU=;
 b=viNbAxmqwAgULw/zlBTyIRIy0DjVj3PmGytHOVgfw1Mih72cz4j4jBdIbDm27vLa5Isa4N
 +hVC5GP6I7BuJ0Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E3B3640584;
 Fri, 13 Mar 2026 14:26:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id LcRANXwetGlfQQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 13 Mar 2026 14:26:04 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 13 Mar 2026 15:25:54 +0100
Message-ID: <20260313142600.243939-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/6] [RFC,WIP] shell loader fixes + du01.sh rewrite
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
Cc: Sebastian Chlad <sebastian.chlad@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

TODO / to be decided:
Should be setup run only once like in C API and tst_test.sh? If yes, it
should probably be run only on first iteration => see commit
"[WIP,RFC] tst_run.sh: Run setup() only once"


Petr Vorel (6):
  tst_run.sh: Fix passing arguments
  tst_env.sh: Backport common functions from tst_test.sh
  shell_loader: Start test count from 1
  run_shell_tcnt: Add test count also for test_all
  [WIP,RFC] tst_run.sh: Run setup() only once
  du01.sh: Rewrite into shell loader

 testcases/commands/du/du01.sh | 88 +++++++++++++++++++++--------------
 testcases/lib/tst_env.sh      | 71 ++++++++++++++++++++++++++++
 testcases/lib/tst_run.sh      |  6 +--
 testcases/lib/tst_run_shell.c | 12 ++---
 4 files changed, 134 insertions(+), 43 deletions(-)

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
