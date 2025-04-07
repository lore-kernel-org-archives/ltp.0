Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C5DEC36010
	for <ltp@archiver.kernel.org>; Mon,  7 Apr 2025 15:02:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CD27B3CB2CC
	for <ltp@archiver.kernel.org>; Mon,  7 Apr 2025 17:02:00 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 945C13C071D
 for <ltp@lists.linux.it>; Mon,  7 Apr 2025 17:01:43 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CE5CE2009F5
 for <ltp@lists.linux.it>; Mon,  7 Apr 2025 17:01:41 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 08EAD21179;
 Mon,  7 Apr 2025 15:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744038101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=TW/g5r2Eck/K3Oh93+VONxUY1jf9PGguYniQdTzbu8g=;
 b=SqH6qKersPc2tQYviVE5BJLnpIj4flAVpUG57NiuiqpT06tbIcArXOVzjEBt9uACGARCPQ
 yZ0kya6MfE3365tElcgUGZz9Mvc4X3h4gtFAUh6Spxuun21TKrAVNtvXn4crOntAmUUKPc
 DHqOpzsdjkWw87+2zoT+GJ8ay4HMVto=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744038101;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=TW/g5r2Eck/K3Oh93+VONxUY1jf9PGguYniQdTzbu8g=;
 b=WxeGL8Di0Ci5i0MPnctTtm87LZP/GuFVrUlrNX+U1ZjqGhPZumK9b1+2Z9byKL2kpgxH0V
 Y2iNAhqfq8jSsTDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744038101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=TW/g5r2Eck/K3Oh93+VONxUY1jf9PGguYniQdTzbu8g=;
 b=SqH6qKersPc2tQYviVE5BJLnpIj4flAVpUG57NiuiqpT06tbIcArXOVzjEBt9uACGARCPQ
 yZ0kya6MfE3365tElcgUGZz9Mvc4X3h4gtFAUh6Spxuun21TKrAVNtvXn4crOntAmUUKPc
 DHqOpzsdjkWw87+2zoT+GJ8ay4HMVto=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744038101;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=TW/g5r2Eck/K3Oh93+VONxUY1jf9PGguYniQdTzbu8g=;
 b=WxeGL8Di0Ci5i0MPnctTtm87LZP/GuFVrUlrNX+U1ZjqGhPZumK9b1+2Z9byKL2kpgxH0V
 Y2iNAhqfq8jSsTDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BDEDC13691;
 Mon,  7 Apr 2025 15:01:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qTB0LNTo82dhNQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 07 Apr 2025 15:01:40 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon,  7 Apr 2025 17:01:29 +0200
Message-ID: <20250407150133.115790-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 0/3] Update doc related Makefile
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

Changes from v4:
* Use sphinx version used on readthedocs.org (to really test in devel
  and github CI what will be deployed).
* Don't install sphinx in github CI (python3-sphinx package)
* Drop last 2 patches ("Makefile: Update 'doc' target, add 'doc-clean'"
  and "doc: Note 'make doc' in the building doc" => doc/Makefile should
  be rewritten to use generic_leaf_target.mk, then integration to the
  top level Makefile will not be a hack).

Tested:
https://app.readthedocs.org/projects/linux-test-project/builds/27705957/

Link to v4
https://patchwork.ozlabs.org/project/ltp/list/?series=450372&state=*
https://lore.kernel.org/ltp/20250328095747.169011-1-pvorel@suse.cz/#r

Link to v3:
https://patchwork.ozlabs.org/project/ltp/list/?series=449828&state=*
https://lore.kernel.org/ltp/20250324234016.367228-1-pvorel@suse.cz/T/#t

Link to v2:
https://patchwork.ozlabs.org/project/ltp/list/?series=443894&state=*
https://lore.kernel.org/ltp/20250211233552.1990618-1-pvorel@suse.cz/#r

Link to v1:
https://patchwork.ozlabs.org/project/ltp/patch/20250206143421.1571918-4-pvorel@suse.cz/
https://lore.kernel.org/ltp/20250206143421.1571918-4-pvorel@suse.cz/



Petr Vorel (3):
  doc/Makefile: Remove also metadata/ltp.json
  doc: Add sphinx to requirements.txt
  doc/Makefile: Allow to create and use .venv

 .github/workflows/ci-sphinx-doc.yml |  2 +-
 doc/Makefile                        | 25 ++++++++++++++++++++++---
 doc/developers/documentation.rst    |  2 --
 doc/requirements.txt                |  4 ++++
 4 files changed, 27 insertions(+), 6 deletions(-)

-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
