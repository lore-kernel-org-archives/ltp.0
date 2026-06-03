Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5088CD6E55
	for <ltp@archiver.kernel.org>; Wed,  3 Jun 2026 11:59:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2CCC83E619E
	for <ltp@archiver.kernel.org>; Wed,  3 Jun 2026 13:59:25 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 53C9E3E659C
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 13:58:47 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E06711000743
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 13:58:46 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0E7E367568;
 Wed,  3 Jun 2026 11:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1780487921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ZUOV2GLbnwAyZQrj50bBLInGec4/dn+CBIKiKbThkPE=;
 b=ByLESupvcxSkoxelvfYzqg2UNvwy0NIgd69h/WWpgFQDjI7xJfs/nEnNbSDBvWgYlMhUKs
 PjbpanEVBcPChtPfMkbG0F+rMo1NF9rum6EPwEYGxFHi4lisOmUCTe8KRGb/OO7cp++BuZ
 ZdGljEwfRD5IWIaXBnsMjkLhia1F53E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1780487921;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ZUOV2GLbnwAyZQrj50bBLInGec4/dn+CBIKiKbThkPE=;
 b=vN2f3Pm34RBjq5YQHrRDh6HCtelZLrnJZcbo5sauq5NSjqwgFc/8AggXjkJwX31G1iGdXn
 r3NKcmdhxKatmfBw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ByLESupv;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=vN2f3Pm3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1780487921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ZUOV2GLbnwAyZQrj50bBLInGec4/dn+CBIKiKbThkPE=;
 b=ByLESupvcxSkoxelvfYzqg2UNvwy0NIgd69h/WWpgFQDjI7xJfs/nEnNbSDBvWgYlMhUKs
 PjbpanEVBcPChtPfMkbG0F+rMo1NF9rum6EPwEYGxFHi4lisOmUCTe8KRGb/OO7cp++BuZ
 ZdGljEwfRD5IWIaXBnsMjkLhia1F53E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1780487921;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ZUOV2GLbnwAyZQrj50bBLInGec4/dn+CBIKiKbThkPE=;
 b=vN2f3Pm34RBjq5YQHrRDh6HCtelZLrnJZcbo5sauq5NSjqwgFc/8AggXjkJwX31G1iGdXn
 r3NKcmdhxKatmfBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EB77D779A7;
 Wed,  3 Jun 2026 11:58:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id DWWtOPAWIGqLagAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 03 Jun 2026 11:58:40 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  3 Jun 2026 13:58:25 +0200
Message-ID: <20260603115828.587769-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 0E7E367568
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/3] renameat2 rewrite
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

this was triggered to get renameat2() fallback from renameat2.h to
lapi/ for fanotify13 [1]. In the end it's not needed as an alternative
solution without it got merged as 7fd307c37a [2], so at least we have 2
rewritten tests (+ 1 new).

Kind regards,
Petr

[1] https://lore.kernel.org/ltp/CAOQ4uxhR2CAKf0aALs7X2fLYMvgN5n8Hx3ADSDqdWXXnmdezQg@mail.gmail.com/
[2] https://github.com/linux-test-project/ltp/commit/7fd307c37a6b5b2dfffb280ef7e3f9f556fdcd34

Petr Vorel (3):
  renameat201.c: Rewrite into new API, split into renameat203.c
  renameat202.c: Rewrite into new API
  lapi: Move renameat2.h into lapi/stdio.h

 include/lapi/stdio.h                          |  25 +++
 .../kernel/syscalls/renameat2/renameat2.h     |  35 ----
 .../kernel/syscalls/renameat2/renameat201.c   | 174 +++++-------------
 .../kernel/syscalls/renameat2/renameat202.c   | 161 ++++++----------
 .../kernel/syscalls/renameat2/renameat203.c   |  99 ++++++++++
 5 files changed, 230 insertions(+), 264 deletions(-)
 create mode 100644 include/lapi/stdio.h
 delete mode 100644 testcases/kernel/syscalls/renameat2/renameat2.h
 create mode 100644 testcases/kernel/syscalls/renameat2/renameat203.c

-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
