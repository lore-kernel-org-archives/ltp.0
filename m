Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3501CA0ED1
	for <ltp@archiver.kernel.org>; Fri, 15 Aug 2025 08:20:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E1DFE3CBF45
	for <ltp@archiver.kernel.org>; Fri, 15 Aug 2025 10:20:18 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 36CAB3C2CC6
 for <ltp@lists.linux.it>; Fri, 15 Aug 2025 10:20:02 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id EFA421400458
 for <ltp@lists.linux.it>; Fri, 15 Aug 2025 10:20:00 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 783411F838;
 Fri, 15 Aug 2025 08:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1755245999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=/ZqOFLUDBQqvcFOdL/YKfu5BtEjxiT2wBDilmjU0JQ4=;
 b=pPnByMSh777TSgFQXl9V35O7VQr0kBEdWhwtS8ClyTH8kW64lCIyU/X/mvMiK4shfkoF/U
 vD8/uBLyvmG7RmbXVcCZdnMGouiXvWA798X3RGFtZL3cy2CL4+CQAY+7bqcEDHa2duGOOK
 vCvRVDVpW4OoRXeIPjtotWNEDyQl/0I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1755245999;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=/ZqOFLUDBQqvcFOdL/YKfu5BtEjxiT2wBDilmjU0JQ4=;
 b=gyvNEv7IU5pok3wVNuTL6tZc1h01lLj3o7De5hgx7A0FCo2qnGFgEKAd55FKqejQWeYJln
 T9iyobBHZeoIHtAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1755245999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=/ZqOFLUDBQqvcFOdL/YKfu5BtEjxiT2wBDilmjU0JQ4=;
 b=pPnByMSh777TSgFQXl9V35O7VQr0kBEdWhwtS8ClyTH8kW64lCIyU/X/mvMiK4shfkoF/U
 vD8/uBLyvmG7RmbXVcCZdnMGouiXvWA798X3RGFtZL3cy2CL4+CQAY+7bqcEDHa2duGOOK
 vCvRVDVpW4OoRXeIPjtotWNEDyQl/0I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1755245999;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=/ZqOFLUDBQqvcFOdL/YKfu5BtEjxiT2wBDilmjU0JQ4=;
 b=gyvNEv7IU5pok3wVNuTL6tZc1h01lLj3o7De5hgx7A0FCo2qnGFgEKAd55FKqejQWeYJln
 T9iyobBHZeoIHtAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 38AC613876;
 Fri, 15 Aug 2025 08:19:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id HlBgDK/tnmg/GAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 15 Aug 2025 08:19:59 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 15 Aug 2025 10:19:40 +0200
Message-ID: <20250815081942.584153-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,imap1.dmz-prg2.suse.org:helo];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 0/2] make: Add kernel modules targets,
 FORCE_MODULES=1
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
Cc: =?UTF-8?q?Ricardo=20B=20=2E=20Marli=C3=A8re?= <rbm@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Changes v4->v5:
Properly handle exit on error (Li).

Link to v4:
https://patchwork.ozlabs.org/project/ltp/list/?series=468222&state=*

Link to v3:
https://patchwork.ozlabs.org/project/ltp/list/?series=468187&state=*

Link to v2:
https://patchwork.ozlabs.org/project/ltp/patch/20250801100935.974351-1-pvorel@suse.cz/

Link to v1:
https://patchwork.ozlabs.org/project/ltp/patch/20250801094205.965645-1-pvorel@suse.cz/

Petr Vorel (2):
  Makefile: Add kernel modules related make targets
  modules.mk: Add FORCE_MODULES=1 to fail on error

 INSTALL              | 16 ++++++++++++++++
 Makefile             | 21 +++++++++++++++++++++
 include/mk/module.mk | 24 +++++++++++++++++++++++-
 3 files changed, 60 insertions(+), 1 deletion(-)

-- 
2.50.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
