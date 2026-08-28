Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6746C61DB9
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 11:11:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 802A23DFDB3
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 13:11:20 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CC9613C6EBE
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 13:11:04 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 59552600B39
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 13:11:04 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7F2EC1FE52;
 Fri, 28 Aug 2026 11:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787915459; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=oQphIxezoUndnL4Qkc/X3uKqicBiQ2+sVLGOSEdJlRY=;
 b=pStHlKI14XcGw8lckglyfYhklFExEg6r/wgii9qyCuSVq3o/2WAU+kP3y9qVZ1yDH46uaF
 tY69Kxu8lfpzgyKi8tMfVyZ0aVXs/mtA1nSbtnuFuQmZXQNM9yFadrYVs9cnwaahd2V9ne
 uhZV+bN/K2vP8CexQEZJMMXmQacverI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787915459;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=oQphIxezoUndnL4Qkc/X3uKqicBiQ2+sVLGOSEdJlRY=;
 b=dA+P4VxgcCa+MdDXhJ3Ht8PX51y9m9WRM0LDLLUputDDqHi40MmkCRtIlKBq1k3gG7rhyp
 8xleSWrLuuu4SYCA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=HX4VsZik;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=54UPn82g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787915455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=oQphIxezoUndnL4Qkc/X3uKqicBiQ2+sVLGOSEdJlRY=;
 b=HX4VsZikUO3QMIrLCNzz0N8HXfcT1vHkXFNa8vy7r3chBgH/4KR9rweIDGc2OFPzX43kmF
 6m4+LtN/0nnj0S66x+CYETyOsHfSdrhy85JK30jyGFPGeU+3PGU9VS7WYnQE7jX0qs6qsj
 nfO4WfrzYTK4LX0d9cqJ0i1dzMsJaPM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787915455;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=oQphIxezoUndnL4Qkc/X3uKqicBiQ2+sVLGOSEdJlRY=;
 b=54UPn82giTXu2au8jnyOf294temx53J/1/oM0X3STfHl1CweaNsWdFaAZFPa1ZbJ4yTXKH
 XVYExPxGxaEb8yCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2187D13515;
 Fri, 28 Aug 2026 11:10:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Z2aqBr9skWriYAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 28 Aug 2026 11:10:55 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 28 Aug 2026 13:10:51 +0200
Message-Id: <20260828-swapon_discard_coverage-v3-0-136924a1a730@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIALtskWoC/4WNQQ6CMBQFr0K6FkNbW6or72EMKe1HaiIl/VA1h
 LtbcMPGuJxk3ryJIAQHSE7ZRAJEh853CfguI6bV3Q1yZxMTVjBZKFbm+NS97yrr0OhgK+MjBJ0
 0flCSWskbIwRJ6z5A415r+XL9Mo71Hcyw5BajdTj48F6vI128/y+R5kUuOa9NTamhip5xRNgb/
 yDLSWTbjPqdYSkDQmglrbYlO24y8zx/ALqZWj4WAQAA
X-Change-ID: 20260827-swapon_discard_coverage-34861d63fc55
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787915455; l=1362;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=vlQ0rGgil1/bIJ3GCG6qqvCpUElBUN0UF6vFdwcQd0s=;
 b=ne6o1db2EbhcOkoISsWt+yPoPn8ieuZSQa3AlwliWGNi6ddzCQqzU3wXyNST61PR1rcW7uzDO
 z0OJGpBuv9fAdIoGfY+viZEs0PNHENXa+DKh5mzccKw6petbQLEgV7A
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 7F2EC1FE52
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid,suse.de:dkim];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/3] Increase coverage for swapon syscall
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
Changes in v3:
- better description for fallbacks
- swapon02: make sure we swapoff() if swapon() accidentally pass
- Link to v2: https://lore.kernel.org/20260828-swapon_discard_coverage-v2-0-e55a86dad729@suse.com

Changes in v2:
- ensure buffer is flushed after discard using fsync()
- add messages to show what test cases we are running
- Link to v1: https://lore.kernel.org/20260827-swapon_discard_coverage-v1-0-633bcb11c181@suse.com

---
Andrea Cervesato (3):
      tse_swap: Add fallback definitions for swapon
      swapon04: Add test for discard flags
      swapon02: Add test cases for invalid swapflags

 include/tse_swap.h                          |  16 +++
 runtest/syscalls                            |   1 +
 testcases/kernel/syscalls/swapon/.gitignore |   1 +
 testcases/kernel/syscalls/swapon/swapon02.c |  60 ++++++--
 testcases/kernel/syscalls/swapon/swapon04.c | 204 ++++++++++++++++++++++++++++
 5 files changed, 267 insertions(+), 15 deletions(-)
---
base-commit: 8e6b93c2832ff4940091abafefd8b8f97539ff5b
change-id: 20260827-swapon_discard_coverage-34861d63fc55

Best regards,
--  
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
