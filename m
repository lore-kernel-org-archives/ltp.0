Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CD25CCD199
	for <ltp@archiver.kernel.org>; Thu, 16 Oct 2025 14:07:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B31913CEE0F
	for <ltp@archiver.kernel.org>; Thu, 16 Oct 2025 16:07:44 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C19003C06EC
 for <ltp@lists.linux.it>; Thu, 16 Oct 2025 16:07:29 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 36F44600FC4
 for <ltp@lists.linux.it>; Thu, 16 Oct 2025 16:07:29 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E25921F456;
 Thu, 16 Oct 2025 14:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1760623648;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SgpnZNG/9XkH1ZiP/ailf0I7NYAwVKJQ0LsXH3jtTbo=;
 b=FcHysKmlIlcdFJg7OkRY94LZrMj7BDxtwI2JqYSdkRblXQL/W1xJNXNarpw3Azotucawkg
 CsIiy4WdcwpzsVrJCfWu0SWFZ+kX+RK7dTEE35j+816bO2EfN63Q1mFZ6S8pHcJTTPGKTG
 tmcfDWxvUfO/YMHDFELydK/WRQDsfs4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1760623648;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SgpnZNG/9XkH1ZiP/ailf0I7NYAwVKJQ0LsXH3jtTbo=;
 b=bXoKpjXulYz4D9SBK0DiNnhHA5TxP06X85yQyRC39wHR3J8myzdcLWlO0KvzepccfFKRZt
 jf83hudDyOmGpeBQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=vKXUZFx7;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=oRP1pWdO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1760623647;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SgpnZNG/9XkH1ZiP/ailf0I7NYAwVKJQ0LsXH3jtTbo=;
 b=vKXUZFx7e6TGLNZcwNUiLvCNlkRkRVIt8Spzp6tg5vpiDU87HYxp7HMvLPKH6s1zobhGT4
 JIINveaDrzWsUOD0Bhf3h2DNWr0vhMJMMIBYDuU/cgoKDauCfrdIZvB1OMV3FCfbM3yOzF
 6trRgZzotMatdgXV3nRNAbZyymMw6co=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1760623647;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SgpnZNG/9XkH1ZiP/ailf0I7NYAwVKJQ0LsXH3jtTbo=;
 b=oRP1pWdOnikFTKq5JP0uy/hKpL1jsD/1Hicd8E1H95d8k2XfG46RXRpJsS4FPu2LUA4sFI
 NfvIDbI/7jkotWDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 68D841340C;
 Thu, 16 Oct 2025 14:07:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2J9GFh/88GhWawAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 16 Oct 2025 14:07:27 +0000
Date: Thu, 16 Oct 2025 16:07:25 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20251016140725.GA286245@pevik>
References: <20250917102737.GA336745@pevik>
 <aa769509-d4b8-46eb-b02d-699a573b0080@suse.com>
 <20250929083156.GA199802@pevik> <aPDlzuox-54oxTtp@yuki.lan>
 <20251016130952.GA281409@pevik> <aPD0oQRSUqVATsZs@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aPD0oQRSUqVATsZs@yuki.lan>
X-Rspamd-Queue-Id: E25921F456
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:replyto,suse.cz:dkim];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC] 'nobody' user for testing
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

> Hi!
> > OK, I can write it unless Jan plans to work on it (Jan, please let me know).

> > I propose to have the usual LTP approach to have functionality used by C API
> > (e.g. lib/tst_sudo.c) and reused by thin wrapper available for shell API
> > (testcases/lib/tst_sudo.c).

> > Few C API tests would use it (prctl06 and other mentioned previously [1] as 3)),
> > in shell API only these 2 IMA tests.

> There are likely more nuances in the tests that use C, some set real
> uid/git some only uid etc. So I wouldn't bother adding helper for six
> tests or so and write directly just the shell helper.

OK. It will be just for these 2 IMA tests, but probably worth because the check
for the shell which is performed by su and sudo would be solved. And we avoid
adding a new user.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
