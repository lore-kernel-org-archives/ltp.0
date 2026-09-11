Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4293AC88E45
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 15:30:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7D0273E922F
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 17:30:22 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5DE743E5494
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 17:30:05 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D4C6D600B45
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 17:30:04 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1B4BD1FB5D;
 Fri, 11 Sep 2026 15:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789140600; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=JJf/Z8ff295EtgsJGEdadjHg30UQ9moE8IR7GD/Fpm0=;
 b=UZ+81GVGj4Me/xYRqr5Y4QSjSNAftNdWZFgELqGwvKEWybEsrI4UiQH42mr3UjY4IYeFl2
 FaeCD96HRLKuYw8mILS8Gm7q2zVmun5qFRBh/JbdjZDGDngspGIYAVDNXlsjemePeK+36S
 D1UYHk2PFiyZhIBfYwR1cYV+NoJXBRE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789140600;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=JJf/Z8ff295EtgsJGEdadjHg30UQ9moE8IR7GD/Fpm0=;
 b=n4zn/ziuLnJ7q9l6x7ZL7ugUYijSqZnDKwITAXzyj+rjFjDZ90dO4l/chgxT0bqxzQCYxW
 J2gSbzr5qeh9OIDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789140596; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=JJf/Z8ff295EtgsJGEdadjHg30UQ9moE8IR7GD/Fpm0=;
 b=o8n2GjfhoeZHB3XMuSmADUKRDb5h2LTlbLerz8tvOGafOOx4dD3Ia7RphIE/pfDrEd2wFT
 b3PewWcLD2JPFCkvaCcD6+P5HKetiDIsUqvW8nJUTWoHsinh4Q0AMlmBvPkyNMv8hZHCss
 bdmU8bA8V4sIOMcCOSFx6qR9qrGNYdU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789140596;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=JJf/Z8ff295EtgsJGEdadjHg30UQ9moE8IR7GD/Fpm0=;
 b=8+gAPHhjzTvnwHzoXYVj5LddvChrYzkgsRF7bAawWWqM6D9Kf8gSpWCgCcDYC2SdHaw+3w
 gWAi5ozQGS5VqaAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C47C5136ED;
 Fri, 11 Sep 2026 15:29:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 394xLnMepGoNOAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 11 Sep 2026 15:29:55 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 11 Sep 2026 17:29:52 +0200
Message-Id: <20260911-mmap_32bit_coverage-v3-0-b0608349556d@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAHAepGoC/22NwQ6CMBAFf8Xs2ZrSqi2e/A9DSFsXqQmUdKHRE
 P7dgvHmcZJ5b2YgjB4JLrsZIiZPPvQZ5H4HrjX9A5m/ZwbBxZlroVjXmaGWwvqxdiFhNFnhpRH
 iyJUxsoS8HCI2/rW93qov02Sf6Mb1ajVaT2OI7y2bitX7FfTfQioYZ6rhVtuTLpWSV5oIDy50U
 C3L8gHqNU0UxwAAAA==
X-Change-ID: 20260827-mmap_32bit_coverage-09a22407aa39
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789140595; l=1365;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=f2JTWWX9nin8i9OA4j8XuAcUXtVDcnsgjL0RDLIYK0M=;
 b=0SPIeJL56k4YQbUgR3Sl88quFVZm4agUAL9ldvQAC4EoeumW1rv2OQ56yhzN5TsYAD2tnauXT
 ez/D+y5zfK0A8qqXtYqcREUp3ov0849cJCC18Va+wgD9F3IqRt1+i8M
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.994]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/3] mmap testing suite to cover MAP_32BIT
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

Create two new tests to verify MAP_32BIT functionality:

- mmap23: verify if it fails with invalid parameters
- mmap24: verify bondaries of the allocation

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v3:
- switch to PROT_NONE and drop memory writes to avoid physical allocation and commit limits
- add unrestricted control mmap() on ENOMEM to detect generic memory exhaustion
- fix format warnings on 32-bit builds by replacing %zu with %lu
- use TESTPTR macro instead of bare mmap() calls

Changes in v2:
- fix description
- Link to v1: https://lore.kernel.org/20260828-mmap_32bit_coverage-v1-0-7f0b8b589773@suse.com

---
Andrea Cervesato (3):
      lapi/mmap: add MAP_32BIT fallback
      mmap23: add test for MAP_32BIT oversized mapping
      mmap24: add test for MAP_32BIT address limit

 include/lapi/mmap.h                       |   4 ++
 runtest/syscalls                          |   2 +
 testcases/kernel/syscalls/mmap/.gitignore |   2 +
 testcases/kernel/syscalls/mmap/mmap23.c   |  36 ++++++++++
 testcases/kernel/syscalls/mmap/mmap24.c   | 112 ++++++++++++++++++++++++++++++
 5 files changed, 156 insertions(+)
---
base-commit: f6933a16f304f36045ec39300c6496dae452933d
change-id: 20260827-mmap_32bit_coverage-09a22407aa39

Best regards,
--  
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
