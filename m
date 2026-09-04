Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5C10C79F80
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 08:56:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A9A883E9701
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 10:56:32 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D962A3E570A
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 10:56:17 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 077086012AD
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 10:56:15 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 49E6B1F7AB;
 Fri,  4 Sep 2026 08:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1788512171; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=bbe/Vc6OWwjIHU8I8hWOZScj/Z6f8LJWmAXjjDZgUWc=;
 b=w5Iskutl9qKKEUbGY2hpSyFqgiLmdVBagd4x/kx0SlxA0wOUXGZSWZbmy1nUqq+WEY69E/
 ebeJOFhtjSmCCu+5jL480Mvg2iEN46+GkILV8othD+N2gxou+l94EhtOocZM+ytt3Izo6a
 ymmd0VcPF+cD2ZvZZFxUBtpeo6IWU24=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1788512171;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=bbe/Vc6OWwjIHU8I8hWOZScj/Z6f8LJWmAXjjDZgUWc=;
 b=xeksQBv1LkAs2SczhHBNEOYEaI0ZJvYPXjkwEku5/6ZUjTC0K+/kXYc7prJR/nxpD0TZh+
 op2b+PmdGWfiaLAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="ruHayN/V";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="BnkypdD/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1788512167; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=bbe/Vc6OWwjIHU8I8hWOZScj/Z6f8LJWmAXjjDZgUWc=;
 b=ruHayN/Vwm7q+goXclHU6Q4MEioZ3WTnEteVyDgOqD1P70Pup+XqGa058/HieK1nPtzgl6
 6ab0fqFuez4CIZ8z33H1563W0vydPfgDJOwndlvIWOxe8935N+8lEoj53tZcYcgRmNParR
 f2yG73kKTadgrbhksARKZzivQtCcFFE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1788512167;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=bbe/Vc6OWwjIHU8I8hWOZScj/Z6f8LJWmAXjjDZgUWc=;
 b=BnkypdD/cqPRXt8ycUIpSjmr9S2cuhLiH61LxkKJd1X4RqD8l5q+WXo+RP5qaWLbjZ1aqX
 8bA8hjyORMdWwqDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DC1BF13726;
 Fri,  4 Sep 2026 08:56:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id rpKOL6WHmmqraAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 04 Sep 2026 08:56:05 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  4 Sep 2026 10:55:51 +0200
Message-ID: <20260904085555.1202288-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-Rspamd-Queue-Id: 49E6B1F7AB
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; RCPT_COUNT_SEVEN(0.00)[11];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim, suse.cz:mid,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/4] testscripts: Remove outdated scripts (ltp-pan)
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
Cc: Tim Bird <tim.bird@sony.com>, automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Changes v1->v2:
* Address 3x valid complains by agent
https://lore.kernel.org/ltp/20260903155921.3989-1-linuxtestproject.agent@gmail.com/
Partly by already merged commits doing cleanup in network doc, partly in
this patchset.

Link to v1:
https://lore.kernel.org/ltp/20260903124631.1100746-1-pvorel@suse.cz/
https://patchwork.kernel.org/project/ltp/list/?series=1157101&state=*

Kind regards,
Petr

Petr Vorel (4):
  Remove testscripts/network.sh
  Remove testscripts/tpm_tools.sh
  Remove testscripts/ltp-aiodio.sh
  controllers: Remove obsolete references to ltp-pan

 .../cpuctl/run_cpuctl_stress_test.sh          |   4 +-
 .../controllers/cpuctl/run_cpuctl_test.sh     |   4 +-
 .../controllers/memctl/run_memctl_test.sh     |   2 +-
 testcases/kernel/io/ltp-aiodio/README         |   8 -
 testcases/network/README.md                   |  12 +-
 testscripts/ltp-aiodio.sh                     | 327 ------------------
 testscripts/network.sh                        | 118 -------
 testscripts/tpm_tools.sh                      | 173 ---------
 testscripts/yesenter.txt                      |   2 -
 9 files changed, 12 insertions(+), 638 deletions(-)
 delete mode 100755 testscripts/ltp-aiodio.sh
 delete mode 100755 testscripts/network.sh
 delete mode 100755 testscripts/tpm_tools.sh
 delete mode 100644 testscripts/yesenter.txt

-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
