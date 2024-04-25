Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57C3AC4345F
	for <ltp@archiver.kernel.org>; Thu, 25 Apr 2024 15:55:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6581E3CFE6E
	for <ltp@archiver.kernel.org>; Thu, 25 Apr 2024 17:55:55 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 61F763CE2B0
 for <ltp@lists.linux.it>; Thu, 25 Apr 2024 17:55:40 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1AA33200747
 for <ltp@lists.linux.it>; Thu, 25 Apr 2024 17:55:38 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F22C55BF16;
 Thu, 25 Apr 2024 15:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1714060538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=4pP2W8PNjphSP7wfTi7pXvmXgZbmc3/taUUkzCiE36c=;
 b=CVdHsbp+vaDVxZ2a1KEMnA2jLPFV1QtkuVn7JkTslD2nlc3YLRMnIY2QLqmwjG4jh3Zlxe
 oevTUkpaEnsMu0fuHJjekhDbMYqeGavwg1OyH8ISL//elR8fcTQiwDqD2QnPmIfe8D14Wk
 vUEZb8X+m/VfHbS+DS/L8vbTm5wRnm0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1714060538;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=4pP2W8PNjphSP7wfTi7pXvmXgZbmc3/taUUkzCiE36c=;
 b=UXX3mIL+69hvmelip1DEfbPSdDS9qKim3PLhWrma4kmJUny8kpZG43nWoyasOTkxx+xtvt
 VAp/wcDnY+W5hgBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1714060537; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=4pP2W8PNjphSP7wfTi7pXvmXgZbmc3/taUUkzCiE36c=;
 b=HDaYiVFCTC3jXspNzx6dqPRL35lEO84Gp9QXOAt9TsWGDtKyqtLPn3yAXxI/4VnbKAvIGw
 8W/Xjhzg44aJQaPygJL7MkUzS+ZUl+xXCtC5uGuOZvZx8KLKXEGeMnVcriN9LztPIba4kv
 QJoO85DxakZL4etWrGX7q7CGs/ZVenw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1714060537;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=4pP2W8PNjphSP7wfTi7pXvmXgZbmc3/taUUkzCiE36c=;
 b=0fNFUJUzmm1Sd1R7qYIKV2HQjaOoa/I2h3JKnp5zTcRV9QI5Q9FqeLLUULeGyTW3eriXrd
 q+YXjOPeP30A49DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C25051393C;
 Thu, 25 Apr 2024 15:55:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id dBO/Lvl8KmZoGgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 25 Apr 2024 15:55:37 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 25 Apr 2024 17:55:30 +0200
Message-ID: <20240425155533.295195-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,configure.ac:url];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/2] Build fixes
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

changes v2->v3
* Use just long long instead of define _GNU_SOURCE (Jan)

Tested:
https://github.com/pevik/ltp/actions/runs/8835557594

Ideally I'd like to merge tomorrow.

Kind regards,
Petr

Petr Vorel (2):
  lapi/fs: Replace loff_t with long long
  lapi: getrandom05: Add getrandom() fallback

 configure.ac                                      |  1 +
 include/lapi/fs.h                                 |  6 +++---
 include/lapi/getrandom.h                          | 15 +++++++++++++--
 testcases/kernel/syscalls/getrandom/getrandom05.c |  3 ++-
 4 files changed, 19 insertions(+), 6 deletions(-)

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
