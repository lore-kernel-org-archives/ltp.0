Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FDE5FF8875
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 13:30:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C900C3E6C98
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 15:30:39 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8F2BC3E1CB7
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 15:30:21 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 19FF3200CF8
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 15:30:20 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C528B6A835;
 Thu, 30 Apr 2026 13:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777555819; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+JfFfVUmX4akmVf81HccVLex4nn3CrbOHqkobrKwBzM=;
 b=r0RF2bC+kkwo2T5pou4lS92ZP+7SxGLHqx2qTZJYZFyhY8ByrrQI6LLNktWwXYXbGF9LG6
 MN2+MQhzoB1kyTGfPIIA5gv5WHEqXYcGSsYiNvn74wbXmZQ16NdBXo0BtbLWMXQDeUXHFp
 nSbNmTt4aii+EN4+yA0xMfGx1wayIoM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777555819;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+JfFfVUmX4akmVf81HccVLex4nn3CrbOHqkobrKwBzM=;
 b=6JvY04MNkK3yjuEeAirflR4kKqlB4Lw+nHy1MZdsUKk6E8GXAbWlei+ud4BGh8r2xdnnU0
 9vLI+klwkpp8PBBQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=r0RF2bC+;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=6JvY04MN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777555819; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+JfFfVUmX4akmVf81HccVLex4nn3CrbOHqkobrKwBzM=;
 b=r0RF2bC+kkwo2T5pou4lS92ZP+7SxGLHqx2qTZJYZFyhY8ByrrQI6LLNktWwXYXbGF9LG6
 MN2+MQhzoB1kyTGfPIIA5gv5WHEqXYcGSsYiNvn74wbXmZQ16NdBXo0BtbLWMXQDeUXHFp
 nSbNmTt4aii+EN4+yA0xMfGx1wayIoM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777555819;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+JfFfVUmX4akmVf81HccVLex4nn3CrbOHqkobrKwBzM=;
 b=6JvY04MNkK3yjuEeAirflR4kKqlB4Lw+nHy1MZdsUKk6E8GXAbWlei+ud4BGh8r2xdnnU0
 9vLI+klwkpp8PBBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A3F47593B0;
 Thu, 30 Apr 2026 13:30:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YUuKJmtZ82luOAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 30 Apr 2026 13:30:19 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 30 Apr 2026 15:30:15 +0200
Message-Id: <20260430-cve-2026-31431-v2-0-1136c09ca67b@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAGdZ82kC/3XMOw7CMBBF0a1EUzPIfwMV+0Apgj0hLogjGyxQ5
 L3jpKc8T3p3hUwpUIZLt0KiEnKIc4M4dOCmYX4QBt8MggnDlGToCuEGlFxJjuQHJc7Wa3N30E5
 LojF89uCtb55CfsX03fuFb+vfVOHI0Y7eceOEtid9ze9MRxef0Ndaf0qvINOrAAAA
X-Change-ID: 20260430-cve-2026-31431-eda4297d56bc
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777555819; l=1002;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=SNixLH5rftVBM+kWhPLMTAb4Zo3h97HsYp4k046vJVY=;
 b=NqDJIpwc8Jl6sbx+53Q3bEJe2el3eBDUKDwpwLJoU4qpSvO+0Bww/o1ZMNe99Z8oH6G1cCxTX
 41CaQNArVaEBYEBD8SlbepRWOTcKR93ZjdETkWQQVL81Km4NcIEbCSu
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: C528B6A835
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/2] cve-2026-31431 reproducer
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v2:
- tst_alg_sendmsg(): fix msg_flags to be send by sendmsg()
- cve-2026-31431 -> af_alg08
- use tst_alg_sendmsg()
- global fd cleanup
- mode 0444
- handle multiple -i iterations
- Link to v1: https://lore.kernel.org/r/20260430-cve-2026-31431-v1-1-7fdc16c25785@suse.com

---
Andrea Cervesato (2):
      tst_af_alg: fixed msg_flags to be the sendmsg() flags
      cve-2026-31431: Add page cache corruption reproducer

 include/tst_af_alg.h               |   2 +-
 lib/tst_af_alg.c                   |   3 +-
 runtest/cve                        |   1 +
 testcases/kernel/crypto/.gitignore |   1 +
 testcases/kernel/crypto/af_alg08.c | 164 +++++++++++++++++++++++++++++++++++++
 5 files changed, 168 insertions(+), 3 deletions(-)
---
base-commit: 69b8169310425b8c5abd01d3fdb46f6d939e8a66
change-id: 20260430-cve-2026-31431-eda4297d56bc

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
