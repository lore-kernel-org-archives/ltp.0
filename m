Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C565C4345F
	for <ltp@archiver.kernel.org>; Wed, 17 Apr 2024 09:19:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 833853CFB7E
	for <ltp@archiver.kernel.org>; Wed, 17 Apr 2024 11:19:32 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 47E4D3CFB17
 for <ltp@lists.linux.it>; Wed, 17 Apr 2024 11:19:17 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5E5A6209087
 for <ltp@lists.linux.it>; Wed, 17 Apr 2024 11:19:16 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2505B2062F;
 Wed, 17 Apr 2024 09:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713345556;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FxxpnzRx8kQ8/WLc6LcQEAxOXby6bRNjM1FD2pwKQSQ=;
 b=sM91IlJjrc8o4wKF0hFDH8IpKt78TAgPu/sRkEkX0e2nusgs7TrrKVXJEqLYVsRTkT2XWc
 udV+IvVMbw2N9fVsk/z00N+m+6Joi95crICOcQGSVq3UCBrY5tCbJFEg6jRbe5DaP5WagT
 Ac8wLAeZpcvLhj7jjGEJY1WGBKJoWFA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713345556;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FxxpnzRx8kQ8/WLc6LcQEAxOXby6bRNjM1FD2pwKQSQ=;
 b=LanLAqRnXftBQk03bxsh8g24f7i24fzVe33h2xae/TuSovsGH7KUnW5NJDdLWrxAV0Bnss
 uXwGzrTKrvebyjBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=sM91IlJj;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=LanLAqRn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713345556;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FxxpnzRx8kQ8/WLc6LcQEAxOXby6bRNjM1FD2pwKQSQ=;
 b=sM91IlJjrc8o4wKF0hFDH8IpKt78TAgPu/sRkEkX0e2nusgs7TrrKVXJEqLYVsRTkT2XWc
 udV+IvVMbw2N9fVsk/z00N+m+6Joi95crICOcQGSVq3UCBrY5tCbJFEg6jRbe5DaP5WagT
 Ac8wLAeZpcvLhj7jjGEJY1WGBKJoWFA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713345556;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FxxpnzRx8kQ8/WLc6LcQEAxOXby6bRNjM1FD2pwKQSQ=;
 b=LanLAqRnXftBQk03bxsh8g24f7i24fzVe33h2xae/TuSovsGH7KUnW5NJDdLWrxAV0Bnss
 uXwGzrTKrvebyjBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0723B13957;
 Wed, 17 Apr 2024 09:19:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +MspABSUH2YQVQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 17 Apr 2024 09:19:16 +0000
Date: Wed, 17 Apr 2024 11:19:14 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240417091914.GB708026@pevik>
References: <20240415091806.18556-1-andrea.cervesato@suse.de>
 <Zh502b2hn9K8S4PQ@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Zh502b2hn9K8S4PQ@yuki>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 2505B2062F
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; REPLYTO_EQ_FROM(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linux.it:url,suse.cz:dkim,suse.cz:email,suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] doc: Add section for C API documentation
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

> Hi!
> > +The C API documentation is written using

> Maybe to be a bit more clear:

> "The C API documentation is generated from headers using" ?

+1

with that change:
Reviewed-by: Petr Vorel <pvorel@suse.cz>

If you both agree, I'll merge it with this change.

Kind regards,
Petr

> > +`kernel-doc <https://return42.github.io/linuxdoc/linuxdoc-howto/kernel-doc-syntax.html>`_
> > +syntax which is supported by Sphinx via
> > +`linuxdoc <https://pypi.org/project/linuxdoc/>`_ extension.
> > -- 
> > 2.35.3


> > -- 
> > Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
