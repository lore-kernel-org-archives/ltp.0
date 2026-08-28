Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E4B2C61DCB
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 15:36:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8B2603E9A69
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 17:36:45 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0F9443E5E02
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 17:36:29 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8BF55600755
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 17:36:28 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 222311FB86;
 Fri, 28 Aug 2026 15:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787931383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bo2qqwJzZBphjz9W9Mvv+vu3gMf5i0hcpfNdUlydALc=;
 b=e/kD2gMsyn+HJEf2Y1sBQP58X0HtKfhhRSLzQVEaqPddCcwUOuMZsoKZbAaQKCARDd1eNv
 Zh8ouc+pVGSNnukFRlPTbtMLkda2R73XRexoJvLZyd7rcg1Lx+3XDkCjEVCx3tS780CTpD
 3fomIc3bEkxEOsgeqCOwQErg7ccyBZ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787931383;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bo2qqwJzZBphjz9W9Mvv+vu3gMf5i0hcpfNdUlydALc=;
 b=52qtmZWxnNQ36dwjedH01gt4sf/Kflr075Pjdh9QhZm4ZUZxXcshDvjVomBhTRSZWQ7O1e
 B79rbtdrrC5QQYAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Q23mWkkB;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=tNFw+cTw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787931379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bo2qqwJzZBphjz9W9Mvv+vu3gMf5i0hcpfNdUlydALc=;
 b=Q23mWkkB3aO2FUts4d+Xp7xrz0FsSu3i01nFW0/woo2OB/ENWMCHU9pPvUR4WZ6W3wsaiB
 HOEMeS9u5NLpsT/yZOZLnG0reFqSZLGkU0sbdZ+B16DPEwiq8WSCTUy6gN445EYf/QjymN
 0nWUP9lNpre2gvaz5anRUHQgINp/Dqw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787931379;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bo2qqwJzZBphjz9W9Mvv+vu3gMf5i0hcpfNdUlydALc=;
 b=tNFw+cTwy6QQ66+ebiwP4aSx1KcECEUZq8kFLleZI++9bNq2heDc8T0gAK/tYS0pepmtat
 TblIpBFgiR4E7qAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E74601352D;
 Fri, 28 Aug 2026 15:36:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SILqNvKqkWrebQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 28 Aug 2026 15:36:18 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 28 Aug 2026 17:36:02 +0200
Message-Id: <20260828-mmap_32bit_coverage-v1-0-7f0b8b589773@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAOKqkWoC/yXM6wpAQBCG4VvR/KbWkNOtSBprMMqhXaTk3i1+P
 vV97wWWjbCFwrvA8CFWltkh9D3QA809B9I6AypMVIZpME201hE2stV6OdiQm6icEGOVEkU5uOd
 quJPzq5bVb7s3I+vtTcF9P+Ly0zd3AAAA
X-Change-ID: 20260827-mmap_32bit_coverage-09a22407aa39
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787931378; l=918;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=OOhcqvEfGdlsfME7q0A0KUKGvQ+d+R4iQSAOgpNLZY8=;
 b=Fa/lEpylazCsE/KHxxhkkAV5K8pmSHBuKQvRqaW3Y0JRELzccg9ohagcOcHb++CYTAQBn//r6
 v7GJ4KTntmZDyUfBGxyG78ASshEvdcagO9DaDin6h0rqx7SMWVLWcBx
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 222311FB86
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/3] mmap testing suite to cover MAP_32BIT
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
Andrea Cervesato (3):
      lapi/mmap: add MAP_32BIT fallback
      mmap23: add test for MAP_32BIT oversized mapping
      mmap24: add test for MAP_32BIT address limit

 include/lapi/mmap.h                       |  4 ++
 runtest/syscalls                          |  2 +
 testcases/kernel/syscalls/mmap/.gitignore |  2 +
 testcases/kernel/syscalls/mmap/mmap23.c   | 36 ++++++++++++
 testcases/kernel/syscalls/mmap/mmap24.c   | 96 +++++++++++++++++++++++++++++++
 5 files changed, 140 insertions(+)
---
base-commit: 3c0271a307bd765c2fd652c325762a90ddf5d46f
change-id: 20260827-mmap_32bit_coverage-09a22407aa39

Best regards,
--  
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
