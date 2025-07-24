Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 014F8C83F26
	for <ltp@archiver.kernel.org>; Thu, 24 Jul 2025 10:14:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4B8DC3CCDC8
	for <ltp@archiver.kernel.org>; Thu, 24 Jul 2025 12:14:10 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E099D3C91B5
 for <ltp@lists.linux.it>; Thu, 24 Jul 2025 12:13:53 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0726E10009B8
 for <ltp@lists.linux.it>; Thu, 24 Jul 2025 12:13:52 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BBE911F394;
 Thu, 24 Jul 2025 10:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1753352031; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=67e76PWtJ9YGBsznBZsIFw2gkd4xjeiNSwQB3kDO4cE=;
 b=IdHa4Ass7Fxp4HvGYXO4o/N9uml74AsX/NTbPqHCmFOtkAh+wcg1pdNhhxVeZNZJ0T8zwh
 HmPUZZu63G8JXm9eRT5EwnkrjiZjSMVAXAMbUO3+RLVOLTMY5vw4FiZCOU+/IkLQzcuUKl
 1HNy/NXRDxSIB/0l9UajaJiK0/II9b8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1753352031;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=67e76PWtJ9YGBsznBZsIFw2gkd4xjeiNSwQB3kDO4cE=;
 b=P3I0/Nn1pELXfqyC68TuTdiM3MViCdl9m1tpDqPC7BkjQEwD5wDPp+dYiyWd6RYnsgiAJo
 KhSmOk3G7U74QOCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1753352031; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=67e76PWtJ9YGBsznBZsIFw2gkd4xjeiNSwQB3kDO4cE=;
 b=IdHa4Ass7Fxp4HvGYXO4o/N9uml74AsX/NTbPqHCmFOtkAh+wcg1pdNhhxVeZNZJ0T8zwh
 HmPUZZu63G8JXm9eRT5EwnkrjiZjSMVAXAMbUO3+RLVOLTMY5vw4FiZCOU+/IkLQzcuUKl
 1HNy/NXRDxSIB/0l9UajaJiK0/II9b8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1753352031;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=67e76PWtJ9YGBsznBZsIFw2gkd4xjeiNSwQB3kDO4cE=;
 b=P3I0/Nn1pELXfqyC68TuTdiM3MViCdl9m1tpDqPC7BkjQEwD5wDPp+dYiyWd6RYnsgiAJo
 KhSmOk3G7U74QOCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A8EA3136DC;
 Thu, 24 Jul 2025 10:13:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 9UzzKF8HgmhRYgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 24 Jul 2025 10:13:51 +0000
Date: Thu, 24 Jul 2025 12:14:31 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aIIHh2CYcraAJHqG@yuki.lan>
References: <20250722125916.74967-1-pvorel@suse.cz>
 <20250722125916.74967-5-pvorel@suse.cz> <aIC1A9yNXKX6QN2N@yuki.lan>
 <20250723193820.GC162896@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250723193820.GC162896@pevik>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 4/6] tst_res_: Print error to stderr,
 with filename and lineno
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
> Or is it just too complicated and we can use argv[1] and argv[2] if argc > 2
> and fallback to __FILE__ and __LINE__ otherwise?

I would just print both in case that argc > 2.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
