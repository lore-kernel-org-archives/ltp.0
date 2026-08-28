Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9078C61DB9
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 09:05:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 587943E5D7A
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 11:05:30 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DBD2C3CE420
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 11:05:13 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 86A50200AEF
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 11:05:13 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B44F8211B3;
 Fri, 28 Aug 2026 09:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787907908; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/jfN8SFTxY0B4ERxhZbZH+H5A5efcKHKPfezITEHd7c=;
 b=mK2Q+Tp/zqbRLqpEyOxOf1FpmtrltIn4jmOinP8LUZe9QBFqe81cosyMIAncn1ck4D2MeI
 tRkPpywOvwrsMS1zCFkXCV3zSMF79xjfCr603pKp/t2wI/87uJcKptswUZnTbMMardwc9Z
 oBAlrVgJRPa5vhpdepAKVfxwgsZAm3w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787907908;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/jfN8SFTxY0B4ERxhZbZH+H5A5efcKHKPfezITEHd7c=;
 b=ZoxoMxbKt/iNZkvYJ5PeIjPGsYreA/TbheGy/auGNMc5GiLAfoSx8CJngUW6DO6lZi4vX1
 7HmDqZ/G+UrMSYBQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wNPN8ZhW;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=k3ry+bRy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787907904; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/jfN8SFTxY0B4ERxhZbZH+H5A5efcKHKPfezITEHd7c=;
 b=wNPN8ZhWfTTmWF0SHXlUGp4zzX0CMf8AAc0DKp+84grJF+FL+ki101aPcznB/0m0Y3mmr1
 nJo4k2MonIOS/BnQIBYF47aJXpewW7Pw0V6wepdnTotp8L/HdCPVG2hz0BgaDP7rQ3sjBR
 Z0hcJsqfDovMHVyoPIYlJmSTRqIYKGE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787907904;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/jfN8SFTxY0B4ERxhZbZH+H5A5efcKHKPfezITEHd7c=;
 b=k3ry+bRy6gaTiwpCMiVBqevPm+JwtASvLoQ/5qrnI78CskmPy6cgtmKhQfwns58TnSaNrp
 ZGc03//6js5QqUCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7942F13515;
 Fri, 28 Aug 2026 09:05:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xUbpG0BPkWrVYAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 28 Aug 2026 09:05:04 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 28 Aug 2026 11:05:02 +0200
Message-Id: <20260828-swapon_discard_coverage-v2-0-e55a86dad729@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAD5PkWoC/4WNQQ6CMBBFr0K6toa2Uokr72EIKdNBaiIlHaga0
 rtb8AAuX/L++ysjDA6JXYqVBYyOnB8zyEPBYDDjHbmzmZkspS5reeb0MpMfW+sITLAt+IjBZE2
 dai2sVj1UFcvrKWDv3nv51vyYlu6BMG+5zRgczT589usoNu//SxS85FqpDjohQNTiSgvhEfyTN
 SmlL4SwxHDPAAAA
X-Change-ID: 20260827-swapon_discard_coverage-34861d63fc55
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787907904; l=1143;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=AU1RSoRThjFurclGwoPjcKKt/8ZdE6h3wJS1hACR5/k=;
 b=2dw9yGYlnURaE1gU9HwrNWY2ucPkFd9l2WR9dTCAYPEH7lGNJAD/fLYg09zJyA3xiArA8zPKP
 J3GkIL1mUcHDRspCLnouQK8DX+EmMxVoRkwhmgoYQaMbKDZV3uiQY1V
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Queue-Id: B44F8211B3
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.com:mid,suse.com:email];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/3] Increase coverage for swapon syscall
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

Complete the EINVAL coverage on invalid input data and create a new test
to verify discarding pages functionalities.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v2:
- ensure buffer is flushed after discard using fsync()
- add messages to show what test cases we are running
- Link to v1: https://lore.kernel.org/20260827-swapon_discard_coverage-v1-0-633bcb11c181@suse.com

---
Andrea Cervesato (3):
      lapi: fallback definitions for swapon syscall
      swapon04: Add test for discard flags
      swapon02: Add test cases for invalid swapflags

 include/tse_swap.h                          |  16 +++
 runtest/syscalls                            |   1 +
 testcases/kernel/syscalls/swapon/.gitignore |   1 +
 testcases/kernel/syscalls/swapon/swapon02.c |  58 +++++---
 testcases/kernel/syscalls/swapon/swapon04.c | 204 ++++++++++++++++++++++++++++
 5 files changed, 264 insertions(+), 16 deletions(-)
---
base-commit: 9118a480cc68700f27944aab817e0202e9e6136c
change-id: 20260827-swapon_discard_coverage-34861d63fc55

Best regards,
--  
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
