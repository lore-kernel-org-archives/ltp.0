Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 514E2C87FD2
	for <ltp@archiver.kernel.org>; Fri,  8 Aug 2025 10:56:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9D58F3CA4CE
	for <ltp@archiver.kernel.org>; Fri,  8 Aug 2025 12:56:13 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0C2A93C7869
 for <ltp@lists.linux.it>; Fri,  8 Aug 2025 12:55:39 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7BD591400252
 for <ltp@lists.linux.it>; Fri,  8 Aug 2025 12:55:37 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 798F733E29;
 Fri,  8 Aug 2025 10:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1754650536; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=qZS6FP2DR/Q3hv9x1rY4mJi7KS2ut2CsJQ51lA+qlBA=;
 b=uZQTYqyWN7OLOWOIgGwJ2EM9CM4iDuNRwLhwT5c33+ljDXm3NYdg82iMZhzhXA4lobFPWw
 fx2sBjPf2VvaTPDXG1kFrmPWCX88vaL+XPRijxxCHKhDDnLjxfZRbvLFJ3Hfxkpj127f/2
 Q2PP2m5m8pP1W2G9KCigt3EPpvIBjmY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1754650536;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=qZS6FP2DR/Q3hv9x1rY4mJi7KS2ut2CsJQ51lA+qlBA=;
 b=06bf1R9CJjtBNC+OixeBXfH8qIn1jWZOurNVE5HLkHe/1rI6pLsPXS41njcK+j/64j1pt8
 gj0cOJrBCJqnKdBg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=uZQTYqyW;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=06bf1R9C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1754650536; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=qZS6FP2DR/Q3hv9x1rY4mJi7KS2ut2CsJQ51lA+qlBA=;
 b=uZQTYqyWN7OLOWOIgGwJ2EM9CM4iDuNRwLhwT5c33+ljDXm3NYdg82iMZhzhXA4lobFPWw
 fx2sBjPf2VvaTPDXG1kFrmPWCX88vaL+XPRijxxCHKhDDnLjxfZRbvLFJ3Hfxkpj127f/2
 Q2PP2m5m8pP1W2G9KCigt3EPpvIBjmY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1754650536;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=qZS6FP2DR/Q3hv9x1rY4mJi7KS2ut2CsJQ51lA+qlBA=;
 b=06bf1R9CJjtBNC+OixeBXfH8qIn1jWZOurNVE5HLkHe/1rI6pLsPXS41njcK+j/64j1pt8
 gj0cOJrBCJqnKdBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 546D213A7E;
 Fri,  8 Aug 2025 10:55:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id H3NzE6jXlWgmcQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 08 Aug 2025 10:55:36 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  8 Aug 2025 12:55:25 +0200
Message-ID: <20250808105528.451372-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.cz:mid, suse.cz:dkim]
X-Rspamd-Queue-Id: 798F733E29
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/3] autotools: Remove old checks
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

Remove few outdated check I have found. There are more.

Kind regards,
Petr

Petr Vorel (3):
  Remove m4/ltp-signalfd.m4
  m4: lapi: Drop check for old libcap-devel
  m4: fcntl31: Remove check for struct f_owner_ex

 configure.ac                              |  2 --
 include/lapi/capability.h                 |  9 ---------
 m4/ltp-cap.m4                             | 17 +----------------
 m4/ltp-fcntl.m4                           | 21 ---------------------
 m4/ltp-signalfd.m4                        | 17 -----------------
 testcases/kernel/syscalls/fcntl/fcntl31.c |  8 --------
 6 files changed, 1 insertion(+), 73 deletions(-)
 delete mode 100644 m4/ltp-fcntl.m4
 delete mode 100644 m4/ltp-signalfd.m4

-- 
2.50.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
