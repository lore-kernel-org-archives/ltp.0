Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEB1606A327
	for <ltp@archiver.kernel.org>; Tue, 20 Oct 2026 16:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=dY0yF66r;
	dkim=fail reason="signature verification failed" header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=/Cn4kf7F;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=dY0yF66r;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=/Cn4kf7F
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9CC9B3E61AB
	for <ltp@archiver.kernel.org>; Tue, 20 Oct 2026 18:43:04 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 53E7E3E28E7
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 18:42:48 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3E9871A0064F
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 18:42:46 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5CFE921DA0;
 Tue, 20 Oct 2026 16:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792514566; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uc6hjTWYsgoVMRdfGAFyjLNbWCRTSV5a5be/bOymkGM=;
 b=dY0yF66rVhFWOdIHo0e9Bc8u38woenQa81bICkVXjtcIuokjMWRwa9En3cVcLql1+IVKF6
 2P5wOKugAEmhc63XsHfObJWC2tReeL3lRidXxbibDXZOSDsSV9c6j3jzOS79cFkXwB+1XR
 TTAiW2MtOF8doHPLqRqLq76yewMTLdU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792514566;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uc6hjTWYsgoVMRdfGAFyjLNbWCRTSV5a5be/bOymkGM=;
 b=/Cn4kf7FIbHI5Mo9CeG7PQ0yOXuozEUVnxzJQUBiSVzUKaLxHTggPFyKOQ6fEmdJGnkqCr
 lZW51zVrfjpNRMBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792514566; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uc6hjTWYsgoVMRdfGAFyjLNbWCRTSV5a5be/bOymkGM=;
 b=dY0yF66rVhFWOdIHo0e9Bc8u38woenQa81bICkVXjtcIuokjMWRwa9En3cVcLql1+IVKF6
 2P5wOKugAEmhc63XsHfObJWC2tReeL3lRidXxbibDXZOSDsSV9c6j3jzOS79cFkXwB+1XR
 TTAiW2MtOF8doHPLqRqLq76yewMTLdU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792514566;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uc6hjTWYsgoVMRdfGAFyjLNbWCRTSV5a5be/bOymkGM=;
 b=/Cn4kf7FIbHI5Mo9CeG7PQ0yOXuozEUVnxzJQUBiSVzUKaLxHTggPFyKOQ6fEmdJGnkqCr
 lZW51zVrfjpNRMBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C08CB136CC;
 Tue, 20 Oct 2026 16:42:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id fMmFGwWa12r7TgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 20 Oct 2026 16:42:45 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 20 Oct 2026 18:42:43 +0200
Message-Id: <20261020-build_system_optimize-v2-0-b527ac7cf835@suse.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAAOa12oC/4WNQQ6CMBBFr0K6tqYtBIsr72EIgTKVMUJJpyUi4
 e4CHsDlS95/f2EEHoHYNVmYhwkJ3bCBOiXMdPXwAI7txkwJlUuhBG8ivtqKZgrQV24M2OMHeG5
 akWapFRok27ajB4vvo3svf0yxeYIJe2w3OqTg/HwcT3L3/n1Mkkt+yTJb2FrrQugbRYKzcT0r1
 3X9AvGDdXLLAAAA
X-Change-ID: 20261020-build_system_optimize-6cd0343f08e1
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792514565; l=1422;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=iBnQnJiJnxwWHcN1SBCZxfK5NiXE4NVMy/iDaFZsFPU=;
 b=h7kTutsq3/M5uTJ03xe3qhZQD2Y7/YRcrusYsqsnSF2YleBC7SZq9Z1Dx/BUBOYrqbj2shzsi
 4WM0CeprFFkDx0nxQ/uhdqwk9fgMI9lsXv22xek6kpnEmuqOSXtvzAn
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/3] Speedup LTP compile time by ~20% on
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
