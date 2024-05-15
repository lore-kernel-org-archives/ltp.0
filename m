Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57637C25B79
	for <ltp@archiver.kernel.org>; Wed, 15 May 2024 14:26:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DB27F3CF8D0
	for <ltp@archiver.kernel.org>; Wed, 15 May 2024 16:26:32 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 93E433CF8D6
 for <ltp@lists.linux.it>; Wed, 15 May 2024 16:26:15 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4E6751B60EFF
 for <ltp@lists.linux.it>; Wed, 15 May 2024 16:26:14 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D9AE6207A9;
 Wed, 15 May 2024 14:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715783173; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KPIULDz/RjI/Ie81Xn4YDp8M3pVT7QQ2oddxouOKSn8=;
 b=rSV75Yc/GqT94HXc03MOEaw2LOd82iT9BPWBOA2dY4px6f43l2Vn9oKHpGgAF5MDG5tl67
 Ir7/jK+nNRXZnAB5saPzT6/CiQGyo6aegvEGyI1HoFbgXcD8IZ01nlaXfOdd8w63CpuFwy
 d71n4K2VVELXfjznOmbVfufXvJu7f/o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715783173;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KPIULDz/RjI/Ie81Xn4YDp8M3pVT7QQ2oddxouOKSn8=;
 b=WP1QcDw9jzUEDhtjGetaOuXnl9xTa2ioMEtG+BEi+BQeGXia9Zlcs9nq1pJ4XvAYyEgbFk
 UxnzjGoLBUeClCCg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=H1YWRga3;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=0SCjnuG3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715783172; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KPIULDz/RjI/Ie81Xn4YDp8M3pVT7QQ2oddxouOKSn8=;
 b=H1YWRga3ygA3lkUtsknneU9dgvov5G8DRw88u9AHNalrZT9nMnL0j4JDUu+4vBPfHlGFex
 CdP69oZOYIL+1jyXlAWY3eA42pmNpO0q4Ib31BLMtKKPxi2st/TVuH/oe9qwqqhpsp5SHJ
 W7K61hvZ+IoQRwTtha9QC2dUnox6/4o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715783172;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KPIULDz/RjI/Ie81Xn4YDp8M3pVT7QQ2oddxouOKSn8=;
 b=0SCjnuG3+/zM34FKJwPYRbwm368jq0ISYDIu9qe79aIUJwYpZ4/57LpVWfbd05s3CPwJXs
 YLqx9otrLnFZFIDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C90A61372E;
 Wed, 15 May 2024 14:26:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id LNjlLwTGRGYKfwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 15 May 2024 14:26:12 +0000
Date: Wed, 15 May 2024 16:25:29 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZkTF2a0-z3Ok_PYO@yuki>
References: <bbcfed6d-caff-43f8-96ce-77e6cb6afd2a@suse.com>
 <20240515142234.GA227672@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240515142234.GA227672@pevik>
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: D9AE6207A9
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6] Refactor fork14 using new LTP API
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> +#ifndef TST_ABI32
> +
>  #define LARGE		(16 * 1024)
>  #define EXTENT		(16 * 1024 + 10)
>  
> @@ -48,7 +52,7 @@ static void run(void)
>  			if (failures > 10) {
>  				tst_brk(TCONF, "mmap() fails too many "
>  					"times, so it's almost impossible to "
> -					"get a vm_area_struct sized 16TB.");
> +					"get a vm_area_struct sized 16TB");
>  			}
>  
>  			continue;
> @@ -115,9 +119,11 @@ static struct tst_test test = {
>  	.setup = setup,
>  	.cleanup = cleanup,
>  	.forks_child = 1,
> -	.skip_in_compat = 1,
>  	.tags = (const struct tst_tag[]) {
>  		{"linux-git", "7edc8b0ac16c"},
>  		{}
>  	}
>  };
> +#else
> +TST_TEST_TCONF("Not supported on x86 in 32-bit");
> +#endif

I think that adding ifdefs and removing metadata is actually a step
back. I suppose that we need .skip_on_32bit or something similar.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
