Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8F69C25B74
	for <ltp@archiver.kernel.org>; Thu, 30 May 2024 07:16:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F0F903D06F3
	for <ltp@archiver.kernel.org>; Thu, 30 May 2024 09:16:10 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E24863C279D
 for <ltp@lists.linux.it>; Thu, 30 May 2024 09:15:53 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 33874609A5F
 for <ltp@lists.linux.it>; Thu, 30 May 2024 09:15:53 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AA46D20718;
 Thu, 30 May 2024 07:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1717053350; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fBLfUE6+lSkUxfaGB49xuVGUMLH839Vgnz/sZLtLa8M=;
 b=dB7YIWMoptccZlEmnoe8AOrgGm1SBFK7myThDC+uGqIhZyZzYny5Al8J1VhE51h9oRDefQ
 /hW1rqHB6UkDnBS/ibmJXGAIxfLHrullWqglT/DMomTib75fYfFh/uSROXNy16J5mXmUtE
 ZRExPkTo8YZoeIWK6trYz9RsDco8Haw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1717053350;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fBLfUE6+lSkUxfaGB49xuVGUMLH839Vgnz/sZLtLa8M=;
 b=sUZid2cwpFEW7ghi4qPTuB3Y919o4C4Nc2WNUxjOwECdxaXm6GQrBQPe40P/dSOzSNc0fF
 ESF7y0LHfpjg1PBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=dB7YIWMo;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=sUZid2cw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1717053350; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fBLfUE6+lSkUxfaGB49xuVGUMLH839Vgnz/sZLtLa8M=;
 b=dB7YIWMoptccZlEmnoe8AOrgGm1SBFK7myThDC+uGqIhZyZzYny5Al8J1VhE51h9oRDefQ
 /hW1rqHB6UkDnBS/ibmJXGAIxfLHrullWqglT/DMomTib75fYfFh/uSROXNy16J5mXmUtE
 ZRExPkTo8YZoeIWK6trYz9RsDco8Haw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1717053350;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fBLfUE6+lSkUxfaGB49xuVGUMLH839Vgnz/sZLtLa8M=;
 b=sUZid2cwpFEW7ghi4qPTuB3Y919o4C4Nc2WNUxjOwECdxaXm6GQrBQPe40P/dSOzSNc0fF
 ESF7y0LHfpjg1PBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9105713A83;
 Thu, 30 May 2024 07:15:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id PFG+IaYnWGYfdwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 30 May 2024 07:15:50 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 30 May 2024 09:15:19 +0200
Message-Id: <20240530-ioctl_ficlone-v1-0-fa96f07d0fca@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAIcnWGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDUyNL3cz85JKc+LTM5Jz8vFRdS9NkMwPjNHPDFFNjJaCegqLUtMwKsHn
 RsbW1AH7N6KNfAAAA
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=916;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=8rcKbF86k4rfJaI61p9cO1kDas5q3ZgnJbQlrVjUW9c=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmWCegHdlxdvHnfgCRsskI3P3amiBL3pA4I34Xs
 Pzd93bp2DqJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZlgnoAAKCRDLzBqyILPm
 RhjyC/0babnTthetI//2vq9Nsd6dGTMTCzfsG7X1L8HVBRf33PzNwz32NbeVi53yqMslUnJGAN0
 qEFAM/c5MiYtJXlQBeHuFnnwjY+TxI16/OQXpbGcc6PZd93TFsSGBwcFVi4JtqIdP98c/srOR0L
 6/E6p9fd+eFOJJJUmucReqRFeh64wJOz2+VCkjIUJP4k1frFsk2nU4LIDUWpzoXEfOJXQaHU59+
 Zhi9IVAhKATWP0ZghVfFQ+AJe6WOwd1TyPxJyZoSxnr4k6dileDmpUJ59DXzQg0e6cgfGyP+VOj
 cIJrAUCcuKSRxuRUuDXa5WgrHwNdGnwae/R710Xfsdey9kaBQ5xoQT2JYPjkEVWfjlG4lNPSAQl
 KdrFj2pK3E4JOQ/oux5HbmBhdDwPFIvki1xg+C1b0PkjUjVhUEB80C3OfhIPgaQnn090G895t4d
 PJ1oNQ9tCv/aq1MomG45rJP7JAvBIsOiFU00fCGr65JICh/AnEPS3XWxmKCEe+maIpkVQ=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: AA46D20718
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:email];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/3] Add ioctl_ficlone testing suite
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

This testing suite is testing ioctl() FICLONE functionalities.
In particular, file clone and error codes.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Andrea Cervesato (3):
      Add ioctl_ficlone01 test
      Add ioctl_ficlone02 test
      Add ioctl_ficlone03 test

 include/lapi/fs.h                                 |   4 +
 runtest/syscalls                                  |   4 +
 testcases/kernel/syscalls/ioctl/.gitignore        |   3 +
 testcases/kernel/syscalls/ioctl/ioctl_ficlone01.c | 116 ++++++++++++++++++++++
 testcases/kernel/syscalls/ioctl/ioctl_ficlone02.c |  49 +++++++++
 testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c |  96 ++++++++++++++++++
 6 files changed, 272 insertions(+)
---
base-commit: 66517b89141fc455ed807f3b95e5260dcf9fb90f
change-id: 20240529-ioctl_ficlone-95c603f71d53

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
