Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EA22C98302
	for <ltp@archiver.kernel.org>; Tue, 22 Sep 2026 16:09:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D4B863E6CEB
	for <ltp@archiver.kernel.org>; Tue, 22 Sep 2026 18:09:55 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 844F33E295D
 for <ltp@lists.linux.it>; Tue, 22 Sep 2026 18:09:26 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 97C531000A16
 for <ltp@lists.linux.it>; Tue, 22 Sep 2026 18:09:25 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 489C51F833;
 Tue, 22 Sep 2026 16:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790093360; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=L/S0uHNOVeYN5GoH/ii7UMYSGPffzZfpiLjZmnEHjqc=;
 b=dh+oNHX6YBbYeohmvSEtsq6ObfpixgmYjlyms6x+LFJaz2rES0fnCRZs48DGeq3eNhI/z6
 8xXJX5VnqMV/HkWAoDAAm1daMt1UcPkDCNVYF1GGfyoCDK1abnRIj5idY/Mg7oVlmljnaq
 QdJi+6FL6DdtVJ8qLg+i4GlYFh1bjvc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790093360;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=L/S0uHNOVeYN5GoH/ii7UMYSGPffzZfpiLjZmnEHjqc=;
 b=12QQD6f/kUa2Mo5oSH0HFGoU215GV9nOlxA1UX7z7iPwrEVyotxEaR8j5UziJZTDMh3H8w
 LT1gNKOwW6efyvDA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=HReZPmoY;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=8ICkYfHJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790093356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=L/S0uHNOVeYN5GoH/ii7UMYSGPffzZfpiLjZmnEHjqc=;
 b=HReZPmoYo8NQOzReq3/RHRdA1LPoT5UNW0PARJSrw9nFclalBf56TksAQAPLZTbyZTF1oA
 3DurEAqhk9tvbqbQQSlIb24S46EDWKpmoj9ZvlR+icEvfT9M0Juq8uhW9hnA0mgGz50+RA
 bvCuxcmR5Hfr8gSAmEv1+ApYAZOgmXE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790093356;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=L/S0uHNOVeYN5GoH/ii7UMYSGPffzZfpiLjZmnEHjqc=;
 b=8ICkYfHJ1MyJrwTz7dDdMXHJimHe6SxVoFXSskqu2mv+LGRhvqb+pIr53Hn0/DQcgr925B
 Ww4bSDJuCVCYm5AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EC400132D3;
 Tue, 22 Sep 2026 16:09:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id u3mALCuosmouJgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 22 Sep 2026 16:09:15 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 22 Sep 2026 18:09:07 +0200
Message-ID: <20260922160911.2271754-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 489C51F833
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_SEVEN(0.00)[9];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,configure.ac:url,suse.cz:dkim,suse.cz:mid];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/4] keyctl: SLE12-SP5 build fix + libkeyutils cleanup
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

Hi,

first 2 commits are build fixes for SLE12-SP5 which should be merged
before release (we don't have this 4.12 in LTP CI).

3rd commit is simple cleanup.

And 4th commit the big libkeyutils removal can be postponed before release.

CI (to speedup):
* whole patchset
https://github.com/pevik/ltp/actions/runs/35749797392

* 1st, 2nd and 3rd commit
https://github.com/pevik/ltp/actions/runs/35749853642

* 1st and 2nd commit
https://github.com/pevik/ltp/actions/runs/35749868601

AFTER RELEASE:
And even further cleanup could be done after the release:
include/lapi/keyctl.h contains not only fallback structs and
definitions, but also functions, which should be moved into newly
created lib/tst_keyctl.c and include/tst_keyctl.h. We did not do it in
the past due libkeyutils dependency, which we did not want to have as
hard dependency (problem solved by 4th commit).

Kind regards,
Petr

Cyril Hrubis (1):
  lapi/keyctl.h: Remove <keyutils.h>

Petr Vorel (3):
  keyctl: Use struct keyctl_dh_params 'private' instead of 'priv'
  m4/ltp-keyutils.m4: Remove struct keyctl_dh_params.priv check
  Remove libkeyutils use

 configure.ac                                  |  5 ++++-
 include/lapi/keyctl.h                         | 22 +++++++++----------
 include/mk/config.mk.in                       |  1 -
 m4/ltp-keyutils.m4                            | 17 --------------
 testcases/cve/Makefile                        |  2 --
 testcases/kernel/syscalls/add_key/Makefile    |  2 --
 testcases/kernel/syscalls/keyctl/Makefile     |  1 -
 testcases/kernel/syscalls/keyctl/keyctl25.c   |  2 +-
 testcases/kernel/syscalls/keyctl/keyctl26.c   |  2 +-
 testcases/kernel/syscalls/keyctl/keyctl27.c   |  2 +-
 testcases/kernel/syscalls/keyctl/keyctl28.c   |  2 +-
 testcases/kernel/syscalls/landlock/Makefile   |  2 --
 .../kernel/syscalls/request_key/Makefile      |  2 --
 testcases/kernel/watchqueue/Makefile          |  2 --
 14 files changed, 18 insertions(+), 46 deletions(-)
 delete mode 100644 m4/ltp-keyutils.m4

-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
