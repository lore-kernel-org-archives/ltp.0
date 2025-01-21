Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 751D3C02185
	for <ltp@archiver.kernel.org>; Tue, 21 Jan 2025 09:26:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DA0973C2617
	for <ltp@archiver.kernel.org>; Tue, 21 Jan 2025 10:26:32 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 65E3E3C227F
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 10:26:14 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4EF48600157
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 10:26:13 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 570881FCF0;
 Tue, 21 Jan 2025 09:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737451573;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NWCzVd0MPaN+KJNYcfkVm6OGdmCLsY6xHXvQVh3Zusg=;
 b=Bmdl96mCoVc1MJM7/cVBog352ERAhOVdP1MNG78p0NStvWZXcf0wO1CJ4Z7FhvPJ+zAuCZ
 WFGN0I8DAI5W9U9udWYSnGM0dh0M5POu3YC04SifOf8men+vI1Am3sBGd+IXOARO5Fppt+
 I/LqpELBv2oV/AQ+Zpy4x7QvvYwQ3Mg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737451573;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NWCzVd0MPaN+KJNYcfkVm6OGdmCLsY6xHXvQVh3Zusg=;
 b=EfzH2CGwE/kL2YbNq6Kc6SNp1gnLZGAqco5H3DjmToQrp/CVlJmFMqLv4Sh5y97NTnZ1Va
 SSuz0CTYczXVPQDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Bmdl96mC;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=EfzH2CGw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737451573;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NWCzVd0MPaN+KJNYcfkVm6OGdmCLsY6xHXvQVh3Zusg=;
 b=Bmdl96mCoVc1MJM7/cVBog352ERAhOVdP1MNG78p0NStvWZXcf0wO1CJ4Z7FhvPJ+zAuCZ
 WFGN0I8DAI5W9U9udWYSnGM0dh0M5POu3YC04SifOf8men+vI1Am3sBGd+IXOARO5Fppt+
 I/LqpELBv2oV/AQ+Zpy4x7QvvYwQ3Mg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737451573;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NWCzVd0MPaN+KJNYcfkVm6OGdmCLsY6xHXvQVh3Zusg=;
 b=EfzH2CGwE/kL2YbNq6Kc6SNp1gnLZGAqco5H3DjmToQrp/CVlJmFMqLv4Sh5y97NTnZ1Va
 SSuz0CTYczXVPQDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2B8321387C;
 Tue, 21 Jan 2025 09:26:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id A/Q6BjVoj2cOcgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 21 Jan 2025 09:26:13 +0000
Date: Tue, 21 Jan 2025 10:26:11 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20250121092611.GB894129@pevik>
References: <20250121082236.5247-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250121082236.5247-1-liwang@redhat.com>
X-Rspamd-Queue-Id: 570881FCF0
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:replyto,suse.cz:dkim,suse.cz:email];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 DKIM_TRACE(0.00)[suse.cz:+]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] eventfd06: add AIO support check
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Just like what we did for io_setup01.c to avoid ENOSYS error:
>   eventfd06.c:140: TBROK: io_setup() failed: ENOSYS

> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>  testcases/kernel/syscalls/eventfd/eventfd06.c | 2 ++
>  1 file changed, 2 insertions(+)

> diff --git a/testcases/kernel/syscalls/eventfd/eventfd06.c b/testcases/kernel/syscalls/eventfd/eventfd06.c
> index 7339dd471..46d7f73d3 100644
> --- a/testcases/kernel/syscalls/eventfd/eventfd06.c
> +++ b/testcases/kernel/syscalls/eventfd/eventfd06.c
> @@ -136,6 +136,8 @@ static void test_poll(void)
>  static void setup(void)
>  {
>  	TEST(io_setup(MAXEVENTS, &ctx));
> +	if (TST_RET == -ENOSYS)

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Maybe to be safe to check also TST_RET?

if (TST_RET == -1 && TTERRNO == ENOSYS)

Maybe (after the release) we could add new macro to tst_test_macros.h
similar to TEST(), which would do test like this (variant of tst_syscall()
macro). We already have 10 tests which do this manually.

Kind regards,
Petr

> +		tst_brk(TCONF | TRERRNO, "io_setup(): AIO not supported by kernel");
>  	if (TST_RET < 0)
>  		tst_brk(TBROK, "io_setup() failed: %s", tst_strerrno(-TST_RET));

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
