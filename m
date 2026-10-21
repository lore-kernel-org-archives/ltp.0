Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D03606A319
	for <ltp@archiver.kernel.org>; Wed, 21 Oct 2026 08:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=d43IKap2;
	dkim=fail reason="signature verification failed" header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ztBNFA/e;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=d43IKap2;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ztBNFA/e
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C65BC3CAA46
	for <ltp@archiver.kernel.org>; Wed, 21 Oct 2026 10:12:22 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9C5C23CA3ED
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 10:12:04 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BCFB96006E2
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 10:12:02 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 29E771F457;
 Wed, 21 Oct 2026 08:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792570322; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Lp7hqV1GNChdXHNCLXbUcHAlihtAOZn1bBUF8q7pmpk=;
 b=d43IKap2T2XZbEK1MzUBbLuak6pa3gEbht61boAYkqSJ6UU8CJvAKxme0gnvICOec39Amg
 YQvFsgDU1yoBHrpuNBjcbD3mDNm22DYjYFUDgYiqUmR+WrV5uhJv0Wo/wK1Wdix6bq70xb
 SPvV3ZPZ2XgeqZgNpqL91za9mS7OZrs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792570322;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Lp7hqV1GNChdXHNCLXbUcHAlihtAOZn1bBUF8q7pmpk=;
 b=ztBNFA/e9g4tN0CeMxfD8wxLpwieiStpTih1TrgyHlxCljyREBtCzgWh5oz+9+V/TUKh6B
 bKiG1iP+G/KPovDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792570322; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Lp7hqV1GNChdXHNCLXbUcHAlihtAOZn1bBUF8q7pmpk=;
 b=d43IKap2T2XZbEK1MzUBbLuak6pa3gEbht61boAYkqSJ6UU8CJvAKxme0gnvICOec39Amg
 YQvFsgDU1yoBHrpuNBjcbD3mDNm22DYjYFUDgYiqUmR+WrV5uhJv0Wo/wK1Wdix6bq70xb
 SPvV3ZPZ2XgeqZgNpqL91za9mS7OZrs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792570322;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Lp7hqV1GNChdXHNCLXbUcHAlihtAOZn1bBUF8q7pmpk=;
 b=ztBNFA/e9g4tN0CeMxfD8wxLpwieiStpTih1TrgyHlxCljyREBtCzgWh5oz+9+V/TUKh6B
 bKiG1iP+G/KPovDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D4DF0134FD;
 Wed, 21 Oct 2026 08:12:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ggQsKtFz2Go9QgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 21 Oct 2026 08:12:01 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 21 Oct 2026 10:11:27 +0200
Message-Id: <20261021-build_system_optimize-v3-0-71a3c4c6f937@suse.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAK9z2GoC/42Nyw6CMBBFf4V0bU1bXsWV/2EMgTKVMfIIA41I+
 Hcpbtzp8mTunLMwggGB2ClY2AAOCbt2g/AQMFMX7Q04VhszJVQihRK8nPBR5TTTCE3e9SM2+AK
 emEqEUWiFBsm2334Ai8/de7l+mKbyDmb0Mr+okcZumPewk373q+EklzyNIpvZQutM6DNNBEfTN
 cwnnPpLovh2ilVamNRYHcZfknVd3y2/N5sQAQAA
X-Change-ID: 20261020-build_system_optimize-6cd0343f08e1
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792570321; l=1579;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=wzslq7FWaylgBLxfj8lTir4UPSPnWGYORF63yprjjNA=;
 b=T36Cj2NE9W6i0/XnyKhyOd/g8xvA2ggj9+WhRnKzWZ7sXGY3tMRgDy9hobiB/lGM1KB2Nza6b
 BnsmSxpqGlvD0DtTaXWaGp0pEmAym00VSFPBoKHp3Y7oYyJaDiXzeI+
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[testcases.mk:url,suse.com:email]
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/3] Speedup LTP compile time by ~20% on
 multi-machine
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The following results show how this optimization moves compile times
really far from what we have now. With a single threaded build, LTP
would take approximately 12 minutes to compile. With a multi-threaded
build on 16 CPUs, this drops down to ~46 seconds.

time make -j16

Executed in   45.96 secs    fish           external
   usr time  519.11 secs    0.24 millis  519.11 secs
   sys time  167.13 secs    1.08 millis  167.13 secs

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v3:
- added libs-all ordering to avoid races
- Link to v2: https://lore.kernel.org/20261020-build_system_optimize-v2-0-b527ac7cf835@suse.com

Changes in v2:
- fix build race condition
- Link to v1: https://lore.kernel.org/20261020-build_system_optimize-v1-1-744f9fa88908@suse.com

---
Andrea Cervesato (3):
      build: Fix library prerequisites in testcases.mk
      build: Build shared libs once on subtree make
      build: Parallelize subdirectory recursion in generic_trunk_target

 Makefile                            |  2 ++
 include/mk/generic_trunk_target.inc | 58 ++++++++++++++++++++++++++++++++-----
 include/mk/testcases.mk             | 14 +++++----
 testcases/kernel/Makefile           |  3 ++
 testcases/kernel/include/lib.mk     |  4 +--
 testcases/network/rpc/Makefile      |  3 ++
 6 files changed, 69 insertions(+), 15 deletions(-)
---
base-commit: 121876b3da3ff59b0dd17b4798b2e4699ba431d1
change-id: 20261020-build_system_optimize-6cd0343f08e1

Best regards,
--  
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
