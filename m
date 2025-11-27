Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6FE8D11183
	for <ltp@archiver.kernel.org>; Thu, 27 Nov 2025 08:27:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2157E3CBCFD
	for <ltp@archiver.kernel.org>; Thu, 27 Nov 2025 09:27:20 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 80E7F3CB099
 for <ltp@lists.linux.it>; Thu, 27 Nov 2025 09:26:47 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A71866008A0
 for <ltp@lists.linux.it>; Thu, 27 Nov 2025 09:26:46 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 65A1433696;
 Thu, 27 Nov 2025 08:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1764232005; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=MRh597Uvyolcc0CW0Pb2hTRUtRPoMsb7Tfu6bhz2sTI=;
 b=UBnDinFFoYpVtYBgFpjzZB8guv496xZeByWyiI9xpZjzhpaarayDmqkdxlA/Hd/NnoV+lf
 vcSeUAfQg/HnPogHu5C/ZRFp1W9hKitijGiFj/S3wBvfeo7mxPrncuT6e2TCyLWrzK5tBQ
 rTn8Jy2V2xZffVDTK/t7jOgecQwN8lw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1764232005;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=MRh597Uvyolcc0CW0Pb2hTRUtRPoMsb7Tfu6bhz2sTI=;
 b=YwyXzHWGkBVosxl/ArJSWiyoL3gLZgOYwjQyjN/xPkK7X6pKm512y3T0bWLsyGKC9Vv2LB
 S5gY8LBMTsPuc7Bg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=t7DlTfMe;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=my395Ul5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1764232004; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=MRh597Uvyolcc0CW0Pb2hTRUtRPoMsb7Tfu6bhz2sTI=;
 b=t7DlTfMeDnMJZkiROV8Z4PdvRosUSxJ06QUhFt5Uv1Gdxx5D092koY56G7UElAzl7cNv+9
 5B2eiGu0F2rxEqb3uwZYNbWIKYS4OyCxrpI1ByMYmIVPxe/5rtyi9moTLp2HqUSj/HTU0y
 VaVl7IBaq5tFe6z508fZhSEqKWl4TIo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1764232004;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=MRh597Uvyolcc0CW0Pb2hTRUtRPoMsb7Tfu6bhz2sTI=;
 b=my395Ul5BgZ5csAL3Ibctavzazk5TOMTCY1IJ6aGmFGPrk0zWmgswYx60pQ1eK6SSXLxLS
 LodR1J4bhKIqY5Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D32BA3EA63;
 Thu, 27 Nov 2025 08:26:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UiO/MkMLKGmNJgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 27 Nov 2025 08:26:43 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 27 Nov 2025 09:26:34 +0100
Message-ID: <20251127082638.224110-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-1.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FREEMAIL_CC(0.00)[gmail.com,linux.ibm.com,vger.kernel.org,suse.cz,redhat.com]; 
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:mid,suse.cz:dkim];
 TAGGED_RCPT(0.00)[]; RCPT_COUNT_SEVEN(0.00)[8];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 65A1433696
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/4] tst_sudo.c, ima_{conditionals,
 measurements}.sh enhancements
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
Cc: selinux@vger.kernel.org, linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Petr Vorel <petr.vorel@gmail.com>

Changes v2->v3:
Rebased due conflict when 69b28f1f78 ("shell: Add support for runtime")
was merged.

Links to v2:
https://lore.kernel.org/ltp/20251121152111.10419-1-pvorel@suse.cz/
https://patchwork.ozlabs.org/project/ltp/list/?series=483104&state=*

Changes v1->v2:
Main change is implementing LTP binary tst_sudo.c as suggested by Jan
Stancek [1] instead of creating new user.

Links to v1:
https://lore.kernel.org/ltp/20251002083701.315334-1-pvorel@suse.cz/
https://patchwork.ozlabs.org/project/ltp/list/?series=476004&state=*

[1] https://lore.kernel.org/ltp/CAASaF6yjdrLLVnehESx1TjsrB_z48nmN_2i585GPfkG3Vvg15Q@mail.gmail.com/

Petr Vorel (4):
  shell: Add tst_sudo.c helper
  tst_test.sh: Add TST_USR_{G,U}ID variables
  ima_{conditionals,measurements}.sh: Use tst_sudo
  ima_conditionals.sh: Split test by request

 doc/users/setup_tests.rst                     |  4 +
 runtest/ima                                   |  5 +-
 .../integrity/ima/tests/ima_conditionals.sh   | 78 +++++++++++--------
 .../integrity/ima/tests/ima_measurements.sh   | 11 +--
 testcases/lib/.gitignore                      |  1 +
 testcases/lib/Makefile                        |  2 +-
 testcases/lib/tst_sudo.c                      | 51 ++++++++++++
 testcases/lib/tst_test.sh                     |  6 +-
 8 files changed, 115 insertions(+), 43 deletions(-)
 create mode 100644 testcases/lib/tst_sudo.c

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
