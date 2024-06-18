Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD9DC27C4F
	for <ltp@archiver.kernel.org>; Tue, 18 Jun 2024 10:31:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1F3CD3D0D5F
	for <ltp@archiver.kernel.org>; Tue, 18 Jun 2024 12:31:56 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 23E723CB74E
 for <ltp@lists.linux.it>; Tue, 18 Jun 2024 12:31:22 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 31E991A00CBE
 for <ltp@lists.linux.it>; Tue, 18 Jun 2024 12:31:21 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D60141F397;
 Tue, 18 Jun 2024 10:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718706680; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=qfC8K1EWk/sPKh1Hn76Kb9zXKIdvilrMoAbwgRwq8Fo=;
 b=HNkcYHF3pCl+picFGWAINS478icEPIZl5iPI/eOhgG4Bpfpta00VjuxmL+l/V1lxza+SBa
 PAGl/N6Qx2nSjpXpfnd/Iu0djzTOqzQ4p403UjHwSD7Y/YA4GXJENB4FGgc4JtXhWTwgqB
 UFPGygzyZGioI0X8bVneL8FDqes3Fek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718706680;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=qfC8K1EWk/sPKh1Hn76Kb9zXKIdvilrMoAbwgRwq8Fo=;
 b=D2Vp0v0XINYq088cMpJl0V4cOu+8fh2CIia+WtWnyftIzu3JFyHO+C/V5wc/bzqlDqyzEI
 UHigmf4pR/1CCTDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718706680; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=qfC8K1EWk/sPKh1Hn76Kb9zXKIdvilrMoAbwgRwq8Fo=;
 b=HNkcYHF3pCl+picFGWAINS478icEPIZl5iPI/eOhgG4Bpfpta00VjuxmL+l/V1lxza+SBa
 PAGl/N6Qx2nSjpXpfnd/Iu0djzTOqzQ4p403UjHwSD7Y/YA4GXJENB4FGgc4JtXhWTwgqB
 UFPGygzyZGioI0X8bVneL8FDqes3Fek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718706680;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=qfC8K1EWk/sPKh1Hn76Kb9zXKIdvilrMoAbwgRwq8Fo=;
 b=D2Vp0v0XINYq088cMpJl0V4cOu+8fh2CIia+WtWnyftIzu3JFyHO+C/V5wc/bzqlDqyzEI
 UHigmf4pR/1CCTDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B53F31369F;
 Tue, 18 Jun 2024 10:31:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id poNdK/hhcWY5LQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 18 Jun 2024 10:31:20 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 18 Jun 2024 12:31:15 +0200
Message-ID: <20240618103117.371469-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.78 / 50.00]; BAYES_HAM(-2.98)[99.91%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/2] Update taint
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

Petr Vorel (2):
  tst_taint: Add TST_TAINT_N
  tst_taint: Assume kernel > 4.0

 include/tst_taint.h |  1 +
 lib/tst_taint.c     | 43 ++++++-------------------------------------
 2 files changed, 7 insertions(+), 37 deletions(-)

-- 
2.45.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
