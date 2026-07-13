Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D95F7C43458
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 14:02:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1E7573E9691
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 16:02:04 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F2B3D3E21F7
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 16:01:44 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D4C7A20090D
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 16:01:41 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 116CE778FF;
 Mon, 13 Jul 2026 14:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783951300; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=p9XJ1OtVYF9UIsKwvFhzpGG071IXfbXytJxaiaH5YeE=;
 b=c/nVu47q8OVMSygpcRbIVdytvcJtmU/Ut1c/4nqCA7p4nOIfO5b2Kj9oPwl22C2biQ7/gI
 BcRBGgyGtkRmxwFd7klyT2ecfiZYUdUK527xcV24Ec63ZCY1ZYNeaSvl9ElYPqZWIiPqKr
 dx8s5AmUC8TbkK+Ob/8cbKQcvoAFP2Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783951300;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=p9XJ1OtVYF9UIsKwvFhzpGG071IXfbXytJxaiaH5YeE=;
 b=WWCIM7HAmmY5e2AHS55C9mJ8XjAJ3xhLHSYBSt+5T4yQ9V0hnL3/scNZ+cuRnRVlIfLRFo
 ESDctgUg6e2eXJCw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=qmJA+9N2;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=NRVKiKYF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783951298; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=p9XJ1OtVYF9UIsKwvFhzpGG071IXfbXytJxaiaH5YeE=;
 b=qmJA+9N2L5/Ft06fJAFoQ/a3Gj9q9Awpir5qCvwpj9tJl/PZZMTNyTeYEdVUOmsHei3+G8
 w34oWPEYa6bFocBR8JTVV8bzBzj1WG3RJPXVt5AVlDSZtAX605QoGkvqD8h454TuG7jled
 Dc28Jgt4/B16Edxn7untB2kBOrWy6Y8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783951298;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=p9XJ1OtVYF9UIsKwvFhzpGG071IXfbXytJxaiaH5YeE=;
 b=NRVKiKYFYTtRqBH3Bpacv56z8DdlQxoCJr7ZcaT2aS1zjCJVFBuORl42mZs2/na31ofa7g
 oXwoRRNtlZ+au8DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EAAA6779AE;
 Mon, 13 Jul 2026 14:01:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id pdYdN8HvVGpaEQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 13 Jul 2026 14:01:37 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 13 Jul 2026 16:01:28 +0200
Message-Id: <20260713-shell_oom_protection-v1-0-b732e8647894@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIALjvVGoC/x3MSQqAMAxA0atI1hbaiANeRUQcogZqK00RQby7x
 eVfvP+AUGASaLMHAl0s7F0Kk2cw76PbSPGSGlBjpWtTKNnJ2sH7YziDjzTHBFSFaMapwRJRQ6J
 noJXvf9v17/sBTK1+TWYAAAA=
X-Change-ID: 20260713-shell_oom_protection-6221ab825220
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783951297; l=823;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=gAK9RxSJRtCuRUkVNEio9aSod/AFhat6w5bTtVgoO9M=;
 b=avGU1MLmNl136LslxOFzsjoxllofhQSDRW1ryzQhHqyc8fD19IowmvMV9O+LIRpqWmgd7Yp/R
 q6QrqdvVh2dDKRrMv/+D3A9C8Qdz62bE+CepLlP5RFcLzepouha4UB3
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCPT_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.de:dkim, suse.com:email, suse.com:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 116CE778FF
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/2] OOM protection for shell tests
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

Under Li's idea, implement a OOM protection mechanism for the shell
tests so we can avoid OOM for memcg stress tests.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Andrea Cervesato (2):
      shell: add optional OOM protection
      memcg_stress: survive OOM by targeting the stressors

 doc/developers/writing_tests.rst                   |  3 ++
 .../controllers/memcg/stress/memcg_stress_test.sh  |  1 +
 testcases/lib/tests/shell_oom_protection.sh        | 34 +++++++++++++
 testcases/lib/tst_test.sh                          | 57 +++++++++++++++++++++-
 4 files changed, 94 insertions(+), 1 deletion(-)
---
base-commit: ed2758122173ffd8d1e8dff6c5efc1231073ee4a
change-id: 20260713-shell_oom_protection-6221ab825220

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
