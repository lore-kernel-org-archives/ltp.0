Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0946CEDB7DF
	for <ltp@archiver.kernel.org>; Tue,  7 Apr 2026 10:05:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A82613E2148
	for <ltp@archiver.kernel.org>; Tue,  7 Apr 2026 12:05:21 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3511E3D0EA6
 for <ltp@lists.linux.it>; Tue,  7 Apr 2026 12:05:03 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id AF143100079A
 for <ltp@lists.linux.it>; Tue,  7 Apr 2026 12:05:02 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1719F4E3CF;
 Tue,  7 Apr 2026 10:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775556302; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SwYiVRSCIrnHEuXcgzajMRpjrZAdf6gTJtzlmf7qSEE=;
 b=nLcUt7jcoqj1qU+e26z3QT7a7VayGZ09Zoj0M7ZXnjR8Ho9aKypktm5ItPAeJWB+avPfcI
 0lX7PEH3303eM2G4flskPwXg4uKYD8YTfmP/TQloL0dVnjKJjzuUkQCkFVADSBYcwdxpkn
 Nqm/cr3EaR8ux9Z8NTKQxPdgdUqbWX0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775556302;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SwYiVRSCIrnHEuXcgzajMRpjrZAdf6gTJtzlmf7qSEE=;
 b=/7f1kHCN4r8Fxcs+maEm6CR095+vzCREGwdAiONfj1vCPkEK7CzWklMYjzFuL+wQz4KtsM
 N9TCQBE/2nUiPYAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=nLcUt7jc;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="/7f1kHCN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775556302; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SwYiVRSCIrnHEuXcgzajMRpjrZAdf6gTJtzlmf7qSEE=;
 b=nLcUt7jcoqj1qU+e26z3QT7a7VayGZ09Zoj0M7ZXnjR8Ho9aKypktm5ItPAeJWB+avPfcI
 0lX7PEH3303eM2G4flskPwXg4uKYD8YTfmP/TQloL0dVnjKJjzuUkQCkFVADSBYcwdxpkn
 Nqm/cr3EaR8ux9Z8NTKQxPdgdUqbWX0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775556302;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SwYiVRSCIrnHEuXcgzajMRpjrZAdf6gTJtzlmf7qSEE=;
 b=/7f1kHCN4r8Fxcs+maEm6CR095+vzCREGwdAiONfj1vCPkEK7CzWklMYjzFuL+wQz4KtsM
 N9TCQBE/2nUiPYAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 079294A0B0;
 Tue,  7 Apr 2026 10:05:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oI0NAc7W1GlEAQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 07 Apr 2026 10:05:02 +0000
Date: Tue, 7 Apr 2026 12:05:08 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <adTW1Jmq3vfkTWSO@yuki.lan>
References: <20260402121356.31266-1-chrubis@suse.cz>
 <20260402121356.31266-5-chrubis@suse.cz>
 <ac8vdjEM0awKPmHE@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ac8vdjEM0awKPmHE@redhat.com>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: 1719F4E3CF
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 04/17] lib: tst_kconfig: Add module presence checks
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
> Maybe rename the struct to:
> 
> 	static struct config_module_map {
> 		const char *config;
> 		const char *module_name;
> 	} config_module_maps[] = {
> 		...
> 	}
> 
> And rename 'struct runtime_check' to:
> 
> 	static struct config_runtime_map {
> 		const char *config;
> 		bool (*runtime_check)(void);
> 	} config_runtime_maps[] = {
> 		...
> 	};
> 
> This is a tiny nit; I don't have strong opinions.
> 
> >  static inline int kconfig_parse_line(const char *line,
> >                                       struct tst_kconfig_var *vars,
> >                                       unsigned int vars_len)
> > @@ -222,6 +262,7 @@ out:
> >  			case 'm':
> >  				vars[i].choice = 'm';
> >  				runtime_check(&vars[i]);
> > +				module_check(&vars[i]);
> 
> Then rename the two functions to:
> 
>     kconfig_runtime_check()
>     kconfig_module_check()
> 
> Because in tst_kconfig.c most function contains "kconfig_" string.

I do not have strong opition, if you agree that these names are better
we can rename them.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
