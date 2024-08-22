Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83E71C3DA4A
	for <ltp@archiver.kernel.org>; Thu, 22 Aug 2024 10:17:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A0A9F3D228E
	for <ltp@archiver.kernel.org>; Thu, 22 Aug 2024 12:17:41 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 452083CDECA
 for <ltp@lists.linux.it>; Thu, 22 Aug 2024 12:17:26 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 497C7600F0C
 for <ltp@lists.linux.it>; Thu, 22 Aug 2024 12:17:24 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3568A201A8;
 Thu, 22 Aug 2024 10:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724321844; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=H4oqhabO/q1elHxXeurUpRW8b/8huQ4XHKnYMhMgr1w=;
 b=r2GpIkKhQIy+GhqNp2b63o35qfq9jRXfky4ilvdmfDFoW2vitmZOpeU1gjgoJJIxLCIP6U
 rUA0rFBofdNSAg0+VYOB8RA0fGUiWwwPnVo2hB66UaSJV8x4dEbw08oJ+N1OvcKaCbR5qt
 pieSgVZghM7G5CUCYlqOUj9DWafv8gk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724321844;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=H4oqhabO/q1elHxXeurUpRW8b/8huQ4XHKnYMhMgr1w=;
 b=SeA7QEbFPAQhkcD4C86SJFG9O3WsCMBPIx+87pb7bJOhooDbNqf7sSlGenS4WdvLdZerBB
 IMk5NM4oi5sOSeAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=r2GpIkKh;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=SeA7QEbF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724321844; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=H4oqhabO/q1elHxXeurUpRW8b/8huQ4XHKnYMhMgr1w=;
 b=r2GpIkKhQIy+GhqNp2b63o35qfq9jRXfky4ilvdmfDFoW2vitmZOpeU1gjgoJJIxLCIP6U
 rUA0rFBofdNSAg0+VYOB8RA0fGUiWwwPnVo2hB66UaSJV8x4dEbw08oJ+N1OvcKaCbR5qt
 pieSgVZghM7G5CUCYlqOUj9DWafv8gk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724321844;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=H4oqhabO/q1elHxXeurUpRW8b/8huQ4XHKnYMhMgr1w=;
 b=SeA7QEbFPAQhkcD4C86SJFG9O3WsCMBPIx+87pb7bJOhooDbNqf7sSlGenS4WdvLdZerBB
 IMk5NM4oi5sOSeAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1F7E5139D3;
 Thu, 22 Aug 2024 10:17:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id VydVBjQQx2bNDwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 22 Aug 2024 10:17:24 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 22 Aug 2024 12:17:13 +0200
Message-Id: <20240822-landlock_houdini-v4-0-9ca736afae30@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIACkQx2YC/x3MQQqAIBBA0avIrBPELKOrRIToWEOhoRSBdPek5
 Vv8XyBjIswwsgIJb8oUQ4VqGNjNhBU5uWqQQioxSMkPE9wR7b5s8XIUiGvnO90PQmProWZnQk/
 Pv5zm9/0AATLzzmIAAAA=
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724321844; l=1318;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=cAZJN8SlWfnnMksdRnQXEnKcgKwpXjcaEc8DzDo1SKQ=;
 b=r2ib3yTL8Mv9ceOaOCqsuDewj8kcBHBmlmkALxMcIUNSjzY4jynhfXYWKU+14D+MUwzWZzU1L
 oJw2V5MmtR8CKDhfdNSHgRwFwVpw2D2DWCw2p7l23hO60rB75LFnYBU
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: 3568A201A8
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 0/2] Reproducer for the landlock houdini bug
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

More information at:
https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2024-42318

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v4:
- fix compilation errors
- Link to v3: https://patchwork.ozlabs.org/project/ltp/list/?series=420318

Changes in v3:
- verify return value of keyctl() according with manual
- Link to v2: https://lore.kernel.org/r/20240821-landlock_houdini-v2-0-b46211ca64f9@suse.com

Changes in v2:
- add SAFE_KEYCTL macro
- verify in setup that landlock is activated
- Link to v1: https://lore.kernel.org/r/20240820-landlock_houdini-v1-1-ff3bffc93eaa@suse.com

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>

---
Andrea Cervesato (2):
      Add SAFE_KEYCTL macro
      Add landlock07 test

 include/lapi/keyctl.h                           |  73 ++++++++++++++++
 runtest/syscalls                                |   1 +
 testcases/kernel/syscalls/landlock/.gitignore   |   1 +
 testcases/kernel/syscalls/landlock/Makefile     |   3 +
 testcases/kernel/syscalls/landlock/landlock07.c | 108 ++++++++++++++++++++++++
 5 files changed, 186 insertions(+)
---
base-commit: 3e8fd5de333bb437b35a00d7557bbf367f5da344
change-id: 20240822-landlock_houdini-7df576807e3f

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
