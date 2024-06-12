Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0FEBC27C53
	for <ltp@archiver.kernel.org>; Wed, 12 Jun 2024 18:22:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8C3613D0BF3
	for <ltp@archiver.kernel.org>; Wed, 12 Jun 2024 20:22:49 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 73F663D0B5A
 for <ltp@lists.linux.it>; Wed, 12 Jun 2024 20:22:33 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D04732009A2
 for <ltp@lists.linux.it>; Wed, 12 Jun 2024 20:22:32 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 887E43475B;
 Wed, 12 Jun 2024 18:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718216551; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WxUb+TtSSkMUxnZrISIxRSzvP4DKlIOEIUfbZpR/zfU=;
 b=W4tbY6M5FtnljU88RsGhZVy89/70KihSowjMN41MnTahCqeqjVr1xPmQ5kWF5CvTAlPaOj
 rkhZ1DoJg/XXQ2z7Gr5p+rLUVKc8Tc5Yv2iGh/JHP6zw9pyccxvRRCeHKUiUy7koP+0Vor
 ck1I4jzQn+Pb2Ac1ig48AAcb2yl7yjs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718216551;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WxUb+TtSSkMUxnZrISIxRSzvP4DKlIOEIUfbZpR/zfU=;
 b=pioSOjU9rGBMLEnR0+atEEWCapodsiQ2kcmOd1DcDmVinubHKGGEgOUQ/l1hdgkt8VIfsj
 rijfyQiZlGbX/HAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=W4tbY6M5;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=pioSOjU9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718216551; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WxUb+TtSSkMUxnZrISIxRSzvP4DKlIOEIUfbZpR/zfU=;
 b=W4tbY6M5FtnljU88RsGhZVy89/70KihSowjMN41MnTahCqeqjVr1xPmQ5kWF5CvTAlPaOj
 rkhZ1DoJg/XXQ2z7Gr5p+rLUVKc8Tc5Yv2iGh/JHP6zw9pyccxvRRCeHKUiUy7koP+0Vor
 ck1I4jzQn+Pb2Ac1ig48AAcb2yl7yjs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718216551;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WxUb+TtSSkMUxnZrISIxRSzvP4DKlIOEIUfbZpR/zfU=;
 b=pioSOjU9rGBMLEnR0+atEEWCapodsiQ2kcmOd1DcDmVinubHKGGEgOUQ/l1hdgkt8VIfsj
 rijfyQiZlGbX/HAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7925B1372E;
 Wed, 12 Jun 2024 18:22:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iWaGHGfnaWayDAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 12 Jun 2024 18:22:31 +0000
Date: Wed, 12 Jun 2024 20:22:15 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZmnnVxaGh8GnFuKu@yuki>
References: <20240612112311.10334-1-chrubis@suse.cz>
 <20240612122120.GA118569@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240612122120.GA118569@pevik>
X-Rspamd-Queue-Id: 887E43475B
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] sched: starvation: Autocallibrate the timeout
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
Cc: Steve <xufeifei1@oppo.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > Instead of hardcoding the values we attempt to measure the CPU speed and
> > set the timeout accordingly. Given that the difference in the duration
> > of the test when the kernel is buggy is about 30x we do not have to have
> > a precise callibration, just very rough estimate if we are running on a
> > server or small ARM board would suffice.
> 
> > So we attempt to measure how long does a bussy loop take and base the
> s/bussy/busy/
> 
> > default timeout on that. On x86_64 CPUs the resulting timeout is about
> > double of the value of the actual test runtime and works fine, but we
> > need to make sure that the coeficient we divide the result from
> > callibrate works for small boards too. So please run the test on as many
> > machines as you can and report if we need to make the dividor smaller or
> > not.
> 
> This looks much better: ppc64le has Timeout per run is 0h 00m 30s (1m 10s
> runtime), others (x68_64, s390x, aarch64) have ~ 1 min or less.
> 
> Tested-by: Petr Vorel <pvorel@suse.cz>

And I've realized that we also have to check if we had exhausted our
runtime in the testcase, because if someone overrides the timeout the
test will stil pass even when it shouldn't. I will send a separate patch
for that.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
