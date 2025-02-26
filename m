Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89267C021B8
	for <ltp@archiver.kernel.org>; Wed, 26 Feb 2025 16:07:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 083EC3C9D2C
	for <ltp@archiver.kernel.org>; Wed, 26 Feb 2025 17:07:31 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 128AF3C2472
 for <ltp@lists.linux.it>; Wed, 26 Feb 2025 17:07:15 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9AEC61020999
 for <ltp@lists.linux.it>; Wed, 26 Feb 2025 17:07:14 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id ACFF31F387;
 Wed, 26 Feb 2025 16:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740586033; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6Yk4RETpz8i4KY1hXYHJ62WwB/pQvUGGRflU343oaAg=;
 b=iVPoIPA9TiCvNgZaUCdX9QabCbJ/tF+JkizJuMsXumVsMxMzFVxBKoXutnDzmm4+x94tsb
 I5Zl93x9BXK/5iGhslClVxEYXO9eCJQx2Wm1Ym2nL+GCFsnypmw83gz/SQVTvlaQpDnMwp
 e0YyTpU/Me0rjX9Xo7eNbH4slfWwZf4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740586033;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6Yk4RETpz8i4KY1hXYHJ62WwB/pQvUGGRflU343oaAg=;
 b=o22FlLvpSEK7YBaYsWSxo9xgO+ZL/INcFET6C57tnRordglTxqKpu4OmpXugy5o8vwiLRg
 SvrnDG8webY0eYAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740586033; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6Yk4RETpz8i4KY1hXYHJ62WwB/pQvUGGRflU343oaAg=;
 b=iVPoIPA9TiCvNgZaUCdX9QabCbJ/tF+JkizJuMsXumVsMxMzFVxBKoXutnDzmm4+x94tsb
 I5Zl93x9BXK/5iGhslClVxEYXO9eCJQx2Wm1Ym2nL+GCFsnypmw83gz/SQVTvlaQpDnMwp
 e0YyTpU/Me0rjX9Xo7eNbH4slfWwZf4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740586033;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6Yk4RETpz8i4KY1hXYHJ62WwB/pQvUGGRflU343oaAg=;
 b=o22FlLvpSEK7YBaYsWSxo9xgO+ZL/INcFET6C57tnRordglTxqKpu4OmpXugy5o8vwiLRg
 SvrnDG8webY0eYAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9433F13A53;
 Wed, 26 Feb 2025 16:07:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8jVaIzE8v2eTZwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 26 Feb 2025 16:07:13 +0000
Date: Wed, 26 Feb 2025 17:07:21 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Ricardo =?iso-8859-1?Q?B=2E_Marli=E8re?= <rbm@suse.com>
Message-ID: <Z788OcCPwPz17CDM@yuki.lan>
References: <20250224-conversions-pause-v3-0-5e3989d37f1d@suse.com>
 <20250224-conversions-pause-v3-3-5e3989d37f1d@suse.com>
 <D80X6ZHMZ1SX.1KAXYMYMDCHKO@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <D80X6ZHMZ1SX.1KAXYMYMDCHKO@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.993]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_DN_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 3/5] syscalls/pause02: Delete duplicated test
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
I've fixed the .gitignore changes and pushed the patchset, thanks.

Will you also look into increasing the coverage for pause01.c as I
described (make it loop over different signals)?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
