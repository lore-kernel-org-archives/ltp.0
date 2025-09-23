Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A115DCAC5A7
	for <ltp@archiver.kernel.org>; Tue, 23 Sep 2025 08:41:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B8B803CDE96
	for <ltp@archiver.kernel.org>; Tue, 23 Sep 2025 10:41:20 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EC8653CDE00
 for <ltp@lists.linux.it>; Tue, 23 Sep 2025 10:41:03 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DA5CB14001EA
 for <ltp@lists.linux.it>; Tue, 23 Sep 2025 10:41:02 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A077F2229A;
 Tue, 23 Sep 2025 08:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1758616861; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uVnetohrjr2Mj0q5FgNN/YBkBa52ydWYM3fpTtRoJLQ=;
 b=iiUhlUQh17wbYYLD8rBul8I/KDFSC77FMOUSPjK/ZSZmzl7ixEnLBf9RpmAc82/L4JpuPv
 95tViOmR7N3DQ+6277VkGos5ejiYHKaWWDU5w21RXfjxwTw2AadNPo8bKE4cRUC1OfR14M
 0kOLCxMtRj1g4mRcSOxuJvDA26MP1LM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1758616861;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uVnetohrjr2Mj0q5FgNN/YBkBa52ydWYM3fpTtRoJLQ=;
 b=t74N21Wr9XBPOyegHW+vs8QE0DYwnhGfP/DcgMmujuduhmmv95/8HxGLO4v0QJ4abMEvrt
 v3dTrZ+Onmqi8hCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1758616861; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uVnetohrjr2Mj0q5FgNN/YBkBa52ydWYM3fpTtRoJLQ=;
 b=iiUhlUQh17wbYYLD8rBul8I/KDFSC77FMOUSPjK/ZSZmzl7ixEnLBf9RpmAc82/L4JpuPv
 95tViOmR7N3DQ+6277VkGos5ejiYHKaWWDU5w21RXfjxwTw2AadNPo8bKE4cRUC1OfR14M
 0kOLCxMtRj1g4mRcSOxuJvDA26MP1LM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1758616861;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uVnetohrjr2Mj0q5FgNN/YBkBa52ydWYM3fpTtRoJLQ=;
 b=t74N21Wr9XBPOyegHW+vs8QE0DYwnhGfP/DcgMmujuduhmmv95/8HxGLO4v0QJ4abMEvrt
 v3dTrZ+Onmqi8hCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 86AF6132C9;
 Tue, 23 Sep 2025 08:41:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id E2A4Hx1d0mgWRgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 23 Sep 2025 08:41:01 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 23 Sep 2025 10:40:58 +0200
Message-Id: <20250923-cve-2025-21756-v2-0-3bb1a6363123@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIABpd0mgC/3XMQQ6CMBCF4auQWTumMwGLrriHYVHbQbqQmlYbD
 endLexdfi95/wpJopcEl2aFKNknH5YKPjRgZ7PcBb2rBlbcqTMz2iy4AZl0d0IhM1ln9I1dC/X
 0jDL5zx68jtWzT68Qv3s/07b+TWVCQqVbZ5iI+94M6Z3kaMMDxlLKD2P69NWrAAAA
X-Change-ID: 20250922-cve-2025-21756-e1afcda7b2d4
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758616861; l=860;
 i=andrea.cervesato@suse.com; s=20250922; h=from:subject:message-id;
 bh=PyAR49WCLm+QQ1L0W0S1UAk3xaC8WLPE0sSKfAsDqeM=;
 b=DOvqCQkSGv/gHabGz1XXKbNpyw6kRiH4Pfh6EK02rQSkuUQnGLhJhcZqQiB2b5Fu7QnXk/jw9
 J/hXujXG4ItAw0nuBdbYXhlU2dvxZ47hvufX0rGXu1zLbeC4rSlsiAX
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=+8M3XgViLdcdNBM+Jdd90m3pV4jCw2tNsGCy5Rd+qHk=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email,configure.ac:url];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:mid,
 suse.com:email, configure.ac:url]
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/2] cve-2025-21756 reproducer
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
- fallback definition of sockaddr_vm
- check for tainted system if kernel survived after test
- Link to v1: https://lore.kernel.org/r/20250922-cve-2025-21756-v1-1-074da211288a@suse.com

---
Andrea Cervesato (2):
      lapi: add struct sockaddr_vm fallback
      cve: add test reproducer for cve-2025-21756

 configure.ac                   |  2 +
 include/lapi/vm_sockets.h      | 17 ++++++++
 runtest/cve                    |  1 +
 testcases/cve/.gitignore       |  1 +
 testcases/cve/cve-2025-21756.c | 95 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 116 insertions(+)
---
base-commit: 514dd3b48fdb024a18657b56fe30cea28541c0d0
change-id: 20250922-cve-2025-21756-e1afcda7b2d4

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
