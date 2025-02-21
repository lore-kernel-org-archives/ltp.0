Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC3C0C021AA
	for <ltp@archiver.kernel.org>; Fri, 21 Feb 2025 12:58:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 54C043C90DA
	for <ltp@archiver.kernel.org>; Fri, 21 Feb 2025 13:58:14 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A64243C8139
 for <ltp@lists.linux.it>; Fri, 21 Feb 2025 13:57:57 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3EB3322C722
 for <ltp@lists.linux.it>; Fri, 21 Feb 2025 13:57:56 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DECEA1FB94;
 Fri, 21 Feb 2025 12:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740142675;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fNejM1fYLGYvvU4C7Q+jd7dHcIa9S7gZtn3peseJyl0=;
 b=H7oji2D3DFsDerZTvJzgxMkRCywl3EZwpS6yfUGoNf/fmK0wYAXSVFjaqby9oN/LQzgxFX
 BdQMhZgtDU1QAfZhuceVivmFU/Bt+cxnSZ7B6nV3jpRmMfXfRq6SRwVSoK9wW7gaZwtrTO
 0SdbHk7RRAni3SoReD8KoQbtTf/sEnQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740142675;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fNejM1fYLGYvvU4C7Q+jd7dHcIa9S7gZtn3peseJyl0=;
 b=jryS+O28scLVt9UHSOSIiLsO7Cw2pLobGfjxez1JYWuaTci60nh18DeNp+WOVykhPK2c0J
 KRdC1lFS0I33y/Ag==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740142675;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fNejM1fYLGYvvU4C7Q+jd7dHcIa9S7gZtn3peseJyl0=;
 b=H7oji2D3DFsDerZTvJzgxMkRCywl3EZwpS6yfUGoNf/fmK0wYAXSVFjaqby9oN/LQzgxFX
 BdQMhZgtDU1QAfZhuceVivmFU/Bt+cxnSZ7B6nV3jpRmMfXfRq6SRwVSoK9wW7gaZwtrTO
 0SdbHk7RRAni3SoReD8KoQbtTf/sEnQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740142675;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fNejM1fYLGYvvU4C7Q+jd7dHcIa9S7gZtn3peseJyl0=;
 b=jryS+O28scLVt9UHSOSIiLsO7Cw2pLobGfjxez1JYWuaTci60nh18DeNp+WOVykhPK2c0J
 KRdC1lFS0I33y/Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9AE6513806;
 Fri, 21 Feb 2025 12:57:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id vIfUIFN4uGc1aQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 21 Feb 2025 12:57:55 +0000
Date: Fri, 21 Feb 2025 13:57:54 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20250221125754.GA2785648@pevik>
References: <20250219160143.2589026-1-pvorel@suse.cz>
 <f2a0be74-94c4-480f-b53c-7ba4673014f1@suse.com>
 <20250220230000.GB2726725@pevik>
 <8240dcd3-fc9f-4c52-bf16-8c7a940cb470@suse.com>
 <20250221092330.GA2745682@pevik>
 <8d5519ef-3255-428e-bb4d-4ece3b310c9e@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8d5519ef-3255-428e-bb4d-4ece3b310c9e@suse.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] doc: Link struct tst_test and tst_tag
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

> On 2/21/25 10:23, Petr Vorel wrote:
> > Well, I disagree it's an overkill. It help people to quickly see the related
> > structure. Also, structure members are just pretty close to the section of the
> > link.

> > Kind regards,
> > Petr

> I guess we don't have much other options with the current tools, so feel
> free to merge.

+1, I don't expect we both have enough time to dive into linuxdoc / sphinx
internals unless something more important forces us :(.

> Acked-by: Andrea Cervesato <andrea.cervesato@suse.com>

Thanks, merged!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
