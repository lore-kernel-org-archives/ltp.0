Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E9F4C27C53
	for <ltp@archiver.kernel.org>; Fri,  7 Jun 2024 08:14:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2DAA23D0A89
	for <ltp@archiver.kernel.org>; Fri,  7 Jun 2024 10:14:02 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7DB1B3D0A74
 for <ltp@lists.linux.it>; Fri,  7 Jun 2024 10:13:45 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id CB5691A0BC5E
 for <ltp@lists.linux.it>; Fri,  7 Jun 2024 10:13:44 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9E41721A5D;
 Fri,  7 Jun 2024 08:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1717748023; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=yyifi6IrHif9m5+14poVfBuaPsPoAs5c6ofkFvEB1Uc=;
 b=Z/mXmj1R1k2oG2nnYHoLBBj6Wsmr3ZA3azPgJmvo3f23R1MY8Sok7Fzbanh1ABf7p082Za
 A2NhsrSGb424vwsYbhPaQTT6w3GWSkdz8169cg60BtRYjdsuW6jWR/KGyWIwNMK17rTPCl
 0XFlnKKPEN8EVCgeYYbS0AGo+B7WHX0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1717748023;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=yyifi6IrHif9m5+14poVfBuaPsPoAs5c6ofkFvEB1Uc=;
 b=jWu+OIpfxwyPfYUwCC5wjsMN0O+KBx+yLmaJofffD2botS/AlHZVuef10fsIEl2sbVrEzJ
 6+l/u4cmA2+EYxBQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="Z/mXmj1R";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=jWu+OIpf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1717748023; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=yyifi6IrHif9m5+14poVfBuaPsPoAs5c6ofkFvEB1Uc=;
 b=Z/mXmj1R1k2oG2nnYHoLBBj6Wsmr3ZA3azPgJmvo3f23R1MY8Sok7Fzbanh1ABf7p082Za
 A2NhsrSGb424vwsYbhPaQTT6w3GWSkdz8169cg60BtRYjdsuW6jWR/KGyWIwNMK17rTPCl
 0XFlnKKPEN8EVCgeYYbS0AGo+B7WHX0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1717748023;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=yyifi6IrHif9m5+14poVfBuaPsPoAs5c6ofkFvEB1Uc=;
 b=jWu+OIpfxwyPfYUwCC5wjsMN0O+KBx+yLmaJofffD2botS/AlHZVuef10fsIEl2sbVrEzJ
 6+l/u4cmA2+EYxBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7C5ED133F3;
 Fri,  7 Jun 2024 08:13:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id rT0eHDfBYmbkBwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 07 Jun 2024 08:13:43 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 07 Jun 2024 10:13:13 +0200
Message-Id: <20240607-shutdown-v2-0-a09ce3290ee1@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIABnBYmYC/0XMQQ7CIBCF4as0sxYDWGx15T1MFwQGYSEYpkVNw
 93FJsbl//LyrUCYAxKcuxUylkAhxRZy14HxOt6QBdsaJJc9V7Jn5JfZpmdkZrSDGjmexFFDuz8
 yuvDaqOvU2geaU35vchHf9YcMf6QIxplw6JzRCg/WXWgh3Jt0h6nW+gGNzb2PnwAAAA==
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1256;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=VF9HbhrTuangPVteesuVdOpHJy/eSQMeY+VPaYV2a9Q=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmYsEc+8y6DZhwE34gZ+f59DJcFXZnS2I9zPbzY
 dlc7mSOKveJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZmLBHAAKCRDLzBqyILPm
 RmcFDACXciQ1RuX14PWw3lZ4rfYZDmmCNR2qfwgeAaVbmpI8ng5+SCNI3VpF4wny1bM1STQj5fc
 yigQO+J+sLzGXkerq9gM78AWZjbGL7aDtrWP1r2ygnPvsd2DxzM/QaUpvzRLY28gJmkbMMbSBO3
 MDB6Fe1JgXD+GJvdWdvBSDUTzUutAr2l9pUiycar4iLp8ORHt/Za7On/T4JI/XtJGSuBRC2aRY2
 Bnj8D4EADqeT29/mc2Qqcw8ClH2W8Bp6QfSpX97NwbudUYl05EZ/7IOPMp+oEtdnDJLDnzvTPqp
 TZEgODA9fSnCwl57wtX10EmpdnSJ49/jvo7gnMiDz3josfbO3vyuoZsyj4zeWDx0KxEwIb7xG+C
 1oKxHfyEyeb9rSvqqvgDKmbBNF7rlcAKtFenSIGr/Kq8M0Zbc8lupggl4lnDNBwqiyevEF6Ig9E
 h5uObSjXXBVL6j0LVEtJ8V55M90ySQP5oQwSv+ROg8h4HIdFV34nsuQjthFeCxtEJvMuY=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 9E41721A5D
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/2] shutdown testing suite
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

This testing suite is meant to test shutdown() syscall functionalities.
The current LTP version uses shutdown() inside many tests, but none of
them is specifically running unit tests for it.

This suite comes with both unit tests for shutdown() flags and error
codes.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v2:
- shutdown01: move test cases inside .test / .tcnt
- shutdown01: usage of SAFE_RECV / SAFE_SEND
- shutdown01: fixed documentation formatting
- shutdown02: fixed documentation formatting
- Link to v1: https://lore.kernel.org/r/20240527-shutdown-v1-0-1feffca5e3df@suse.com

---
Andrea Cervesato (2):
      Add shutdown01 test
      Add shutdown02 test

 runtest/syscalls                                |   3 +
 testcases/kernel/syscalls/shutdown/.gitignore   |   2 +
 testcases/kernel/syscalls/shutdown/Makefile     |   7 ++
 testcases/kernel/syscalls/shutdown/shutdown01.c | 121 ++++++++++++++++++++++++
 testcases/kernel/syscalls/shutdown/shutdown02.c |  76 +++++++++++++++
 5 files changed, 209 insertions(+)
---
base-commit: 0358f7a2788eed0cbff7f8519b1a0f7f89d36c13
change-id: 20240524-shutdown-c8d7580e916a

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
