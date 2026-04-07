Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83440FEEF33
	for <ltp@archiver.kernel.org>; Tue,  7 Apr 2026 12:57:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1AEB23E2E75
	for <ltp@archiver.kernel.org>; Tue,  7 Apr 2026 14:57:30 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3D9DB3E26B1
 for <ltp@lists.linux.it>; Tue,  7 Apr 2026 14:57:11 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 49514200748
 for <ltp@lists.linux.it>; Tue,  7 Apr 2026 14:57:10 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AEBBC5BD4F;
 Tue,  7 Apr 2026 12:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775566628;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u17YuDGBod3hbw81spFZdUjHkrUQG58ZqtYSVaGfnqQ=;
 b=RnRllMJbVpjVWf2zvulxNshlWhSqBChdCWq4rCp/qUgzIfwUS/SJjHijJgrBTplvq/Wddw
 FdtjQGueDMF2aBSJ7TKW84uK41tb13YnksxnRKqXRZKILfAT3fPm21jCALRqBUvxreOpyX
 pRtz9vxyBQFjtYori28z8d7yr9ozIpA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775566628;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u17YuDGBod3hbw81spFZdUjHkrUQG58ZqtYSVaGfnqQ=;
 b=DdRCUWHvjKBtjeDyS85M0yvcticJjfnJCc8AUrX9ZG8IxBGzjvMFt2YZv+DPqJG0LrvMQr
 Ey0y9CqgsbT+gZDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=RnRllMJb;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=DdRCUWHv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775566628;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u17YuDGBod3hbw81spFZdUjHkrUQG58ZqtYSVaGfnqQ=;
 b=RnRllMJbVpjVWf2zvulxNshlWhSqBChdCWq4rCp/qUgzIfwUS/SJjHijJgrBTplvq/Wddw
 FdtjQGueDMF2aBSJ7TKW84uK41tb13YnksxnRKqXRZKILfAT3fPm21jCALRqBUvxreOpyX
 pRtz9vxyBQFjtYori28z8d7yr9ozIpA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775566628;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u17YuDGBod3hbw81spFZdUjHkrUQG58ZqtYSVaGfnqQ=;
 b=DdRCUWHvjKBtjeDyS85M0yvcticJjfnJCc8AUrX9ZG8IxBGzjvMFt2YZv+DPqJG0LrvMQr
 Ey0y9CqgsbT+gZDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 961E14A0B0;
 Tue,  7 Apr 2026 12:57:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ymCXIyT/1GnmMQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 07 Apr 2026 12:57:08 +0000
Date: Tue, 7 Apr 2026 14:56:58 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20260407125658.GB25645@pevik>
References: <20260325-infiniband_rdma-v1-0-9c1bd3e69d29@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260325-infiniband_rdma-v1-0-9c1bd3e69d29@suse.com>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: AEBBC5BD4F
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/2] Add infiniband testing suite
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> This patch series introduces a test for infiniband testing, based on
> https://marc.info/?l=linux-kernel&m=152625244101970&w=2.
https://lore.kernel.org/lkml/20180513230237.GG677@sol.localdomain/

Thanks for pointing out the C source.  I was looking at the original syzkaller
reproducer [1] which IMHO did more things, simplified C source is quite similar
to what you do in LTP test.

Have you verified if it actually reproduce the bug on affected kernel? Does it
reproduce the bug?

I tried it only on too new kernel (6.12 based SLE16 kernel, required to install
rdma-core, rdma_cm kernel module, which creates /dev/infiniband/rdma_cm, was
loaded by default).

Kind regards,
Petr

[1] https://syzkaller.appspot.com/text?tag=ReproSyz&x=1686969e400000

> Consider this as a snapshot for a possible test. I sent it to the ML
> just to have some feedbacks.

> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
> Andrea Cervesato (2):
>       lapi: Add fallback rdma_user_cm.h definitions
>       device-drivers/rdma: Add ucma_uaf01 test

>  configure.ac                                      |   1 +
>  include/lapi/rdma_user_cm.h                       |  72 ++++++++
>  runtest/kernel_misc                               |   1 +
>  testcases/kernel/device-drivers/Makefile          |   1 +
>  testcases/kernel/device-drivers/rdma/.gitignore   |   1 +
>  testcases/kernel/device-drivers/rdma/Makefile     |   7 +
>  testcases/kernel/device-drivers/rdma/ucma_uaf01.c | 208 ++++++++++++++++++++++
>  7 files changed, 291 insertions(+)
> ---
> base-commit: b874b6a264cf4f343c17d543ebe4ff91fbb89042
> change-id: 20260325-infiniband_rdma-c94a1f4f7255

> Best regards,

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
