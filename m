Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 533DAC47258
	for <ltp@archiver.kernel.org>; Tue, 23 Jan 2024 07:58:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BA4B73CE208
	for <ltp@archiver.kernel.org>; Tue, 23 Jan 2024 08:58:03 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 858083C97A2
 for <ltp@lists.linux.it>; Tue, 23 Jan 2024 08:57:49 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id EABB4600C85
 for <ltp@lists.linux.it>; Tue, 23 Jan 2024 08:57:48 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C7C5E1F74B;
 Tue, 23 Jan 2024 07:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705996667;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Sv4OukUZ3VF1h40ldewp8GqVo3ySXKQ23eGX7l6alEY=;
 b=vJLHsZpQSF9P6WrR6KO2vWOHcddjd1VP3DyilyPaOtRVgZWAEw5k5LrTRFYDR9/dM+TH2g
 dGwUElq39Ep2rzwf7J+CT8R4BZfuZ+/3xG9Que2VI5j3TgRCsfX7T4gYyC+BaVxOx6qhc7
 xqiAqcyWYFt5kMwfWZQ1BWCA72MaJtI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705996667;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Sv4OukUZ3VF1h40ldewp8GqVo3ySXKQ23eGX7l6alEY=;
 b=8U9xxTX+dI8+DNg+cXWWnVD2l9Tb8CNc4krbUS5MYbW3X8Rr12lw1ktszVyLeGSqPu7yD4
 owi5vOyq2asq67AQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705996667;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Sv4OukUZ3VF1h40ldewp8GqVo3ySXKQ23eGX7l6alEY=;
 b=vJLHsZpQSF9P6WrR6KO2vWOHcddjd1VP3DyilyPaOtRVgZWAEw5k5LrTRFYDR9/dM+TH2g
 dGwUElq39Ep2rzwf7J+CT8R4BZfuZ+/3xG9Que2VI5j3TgRCsfX7T4gYyC+BaVxOx6qhc7
 xqiAqcyWYFt5kMwfWZQ1BWCA72MaJtI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705996667;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Sv4OukUZ3VF1h40ldewp8GqVo3ySXKQ23eGX7l6alEY=;
 b=8U9xxTX+dI8+DNg+cXWWnVD2l9Tb8CNc4krbUS5MYbW3X8Rr12lw1ktszVyLeGSqPu7yD4
 owi5vOyq2asq67AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 99BFD13786;
 Tue, 23 Jan 2024 07:57:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id u5EFJHtxr2VuZwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 23 Jan 2024 07:57:47 +0000
Date: Tue, 23 Jan 2024 08:57:38 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240123075738.GB144741@pevik>
References: <20231025083706.13767-1-wegao@suse.com>
 <20240109065904.18117-1-wegao@suse.com>
 <20240109065904.18117-2-wegao@suse.com> <Zaqegt-5Zkm0BJIY@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Zaqegt-5Zkm0BJIY@yuki>
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=vJLHsZpQ;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=8U9xxTX+
X-Spamd-Result: default: False [-3.01 / 50.00];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 DWL_DNSWL_HI(-3.50)[suse.cz:dkim]; ARC_NA(0.00)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MX_GOOD(-0.01)[]; DKIM_TRACE(0.00)[suse.cz:+];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[42.52%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: C7C5E1F74B
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/2] lib: Add .ulimit
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

Hi,

...
> > +++ b/lib/tst_test.c
> > @@ -1147,6 +1147,29 @@ static void do_cgroup_requires(void)
> >  	tst_cg_init();
> >  }

> > +#define tst_set_ulimit(conf) \
> > +	tst_set_ulimit_(__FILE__, __LINE__, (conf))

> If we want this to be part of the API, i.e. allow tests to call this
> function directly this should be in the tst_test.h header.

> If not, the function should be static and only used in the tst_test.c

Thanks! I tried to explain it in v2, but was not able to express it clearly.
https://lore.kernel.org/ltp/20240108114738.GC1565258@pevik/

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
