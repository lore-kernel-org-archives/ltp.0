Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4A72C02194
	for <ltp@archiver.kernel.org>; Fri,  7 Feb 2025 17:00:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C80FF3C93C4
	for <ltp@archiver.kernel.org>; Fri,  7 Feb 2025 18:00:45 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 02E643C016A
 for <ltp@lists.linux.it>; Fri,  7 Feb 2025 18:00:26 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1F449102C3B6
 for <ltp@lists.linux.it>; Fri,  7 Feb 2025 18:00:23 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EC04E210F5;
 Fri,  7 Feb 2025 17:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1738947623; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3ItBf3u4RahcmdCzORKfiWJZ/Dov9aSLGOpsD3R6jQI=;
 b=vpa6qpHDSw7ANU/C0oDWCirSjB17hZf1xu1aUgoOK9qOIocZcJ4SxSG+0Z5l1jnTa8Mc3T
 YOPzma93w4SJSEOpJ2wsmCQnNdFmM04ZvjRU5IlC5nAI9pUegySezVZZe1NThSmYBwdB3G
 1ullC3rU32qBtbUrVs6eEf9awUjDsCo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1738947623;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3ItBf3u4RahcmdCzORKfiWJZ/Dov9aSLGOpsD3R6jQI=;
 b=R2a4GmECBnJBrovCnBrg/DFDptOsNuWkxG8nR65Yqzsqwq3gT69Pi4TL4Z05UBSrh7V2Hi
 BDJW5pztKh1r36Cw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=MtgYmsHg;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=i1qspIWG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1738947622; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3ItBf3u4RahcmdCzORKfiWJZ/Dov9aSLGOpsD3R6jQI=;
 b=MtgYmsHg+ARXSF8u+IiFLLcJIc2VtPffCbn7FhK2icNXxkykai52g67ekwmXAieSEJnOWZ
 gAnLcg81slxz5lf+v0qqXHNLIOFeCuR0ZjSvIjhknn/iWR3eYQ652FJEk7QtsteaU5iPdY
 /Jogi4CfL9DHMPu7+J7xcnK6ynhUWVQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1738947622;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3ItBf3u4RahcmdCzORKfiWJZ/Dov9aSLGOpsD3R6jQI=;
 b=i1qspIWGm8Sk3S8wGyldiHr55JwczXB7YI32ImNY6bS+qhGy0OSeRe44S0sNE1O/KIMAVz
 IiZEmCao9xQSXZDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DBF99139CB;
 Fri,  7 Feb 2025 17:00:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gpKvNSY8pmdXaAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 07 Feb 2025 17:00:22 +0000
Date: Fri, 7 Feb 2025 18:00:24 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Z6Y8KLsXDWnttBL6@yuki.lan>
References: <20241218184518.16190-1-chrubis@suse.cz>
 <20241218184518.16190-7-chrubis@suse.cz>
 <20241227104805.GD317565@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241227104805.GD317565@pevik>
X-Rspamd-Queue-Id: EC04E210F5
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 06/13] testcases/kernel/mem: Move check_hugepage()
 + PATH_THP
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
> > +#define PATH_THP "/sys/kernel/mm/transparent_hugepage/"
> > +
> > +static inline void check_hugepage(void)
> > +{
> > +        if (access(PATH_HUGEPAGES, F_OK))
> > +                tst_brk(TCONF, "Huge page is not supported.");
> > +}
> 
> I guess we don't want to move this into static inline function (used only in 2
> tests.
> 
> 	if (access(PATH_THP, F_OK) == -1)
> 		tst_brk(TCONF, "THP not enabled in kernel?");
> 
> I also wonder if we should add to the library struct tst_test test something
> like .requires_proc_sys which would check for files in /sys or /proc. There
> could be an optional parameter for TCONF message. Advantage would be to have
> this in docparse docs (or isn't it useful to see this)?
> 
> We have .save_restore, but that's only for files and it reads the value.
> But it could share the flags (TST_SR_TCONF, TST_SR_TBROK, TST_SR_SKIP, ...).

Logically save_restore is not a good candidate since we are checking a
directory existence here. So maybe we need to add .needs_paths array of
strings into tst_test later on...

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
