Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AD82C5AD49
	for <ltp@archiver.kernel.org>; Mon,  2 Jun 2025 14:38:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B22963C9D8E
	for <ltp@archiver.kernel.org>; Mon,  2 Jun 2025 16:38:27 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 992083C9CC6
 for <ltp@lists.linux.it>; Mon,  2 Jun 2025 16:38:10 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id AFFB1200AE8
 for <ltp@lists.linux.it>; Mon,  2 Jun 2025 16:38:09 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3F23A1F443;
 Mon,  2 Jun 2025 14:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1748875086; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2w4tLqfZNDy6VCLW9l9bzmWI32ha9wALb2nsvRW/fdQ=;
 b=fO17H1KcgdRy4SVMqeZ18g/cZ53BPKEwjlJnU+WzZJLWWzwc9GH7oi0NTou2tqnN5sm/WU
 +7UWCrfXTPM67AV5tATc8vNLFbJQVWJPmo9V9cx94tcIkdTdwZU6ojn8rAs14HWgHNgYA0
 HEZnDknE6RRKI75e5nICcaD54Lks2oM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1748875086;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2w4tLqfZNDy6VCLW9l9bzmWI32ha9wALb2nsvRW/fdQ=;
 b=IAkOA59yQfcNuyfDx09BObStBaQZ164e5+ICeKKawRtUWxWK8boj8DuAws4URvRFgyEDeZ
 rv4RQk7txyT+bDAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=fO17H1Kc;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=IAkOA59y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1748875086; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2w4tLqfZNDy6VCLW9l9bzmWI32ha9wALb2nsvRW/fdQ=;
 b=fO17H1KcgdRy4SVMqeZ18g/cZ53BPKEwjlJnU+WzZJLWWzwc9GH7oi0NTou2tqnN5sm/WU
 +7UWCrfXTPM67AV5tATc8vNLFbJQVWJPmo9V9cx94tcIkdTdwZU6ojn8rAs14HWgHNgYA0
 HEZnDknE6RRKI75e5nICcaD54Lks2oM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1748875086;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2w4tLqfZNDy6VCLW9l9bzmWI32ha9wALb2nsvRW/fdQ=;
 b=IAkOA59yQfcNuyfDx09BObStBaQZ164e5+ICeKKawRtUWxWK8boj8DuAws4URvRFgyEDeZ
 rv4RQk7txyT+bDAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2B9D9136C7;
 Mon,  2 Jun 2025 14:38:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4MKVCU63PWj0WgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 02 Jun 2025 14:38:06 +0000
Date: Mon, 2 Jun 2025 16:38:36 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <aD23bPyqhaAAkPXH@yuki.lan>
References: <20250429-lsm-v4-0-602b7097e722@suse.com>
 <20250429-lsm-v4-4-602b7097e722@suse.com>
 <aD2dDODCBai0Ee-s@yuki.lan>
 <79b6bf40-b4d5-4998-af0d-4f0ba3c6fd9f@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <79b6bf40-b4d5-4998-af0d-4f0ba3c6fd9f@suse.com>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 3F23A1F443
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,yuki.lan:mid];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 4/7] Add lsm_get_self_attr03 test
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
> > 				next_ctx(next)
> >
> > Otherwise we will fail the check below.
> Right.

Feel free to add my Reviewed-by: with that fixed.

> >> +	for (uint32_t i = 1; i < count; i++) {
> >> +		TST_EXP_EXPR(strcmp(attr, (char *)next->ctx) != 0,
> >> +			"Attribute and next LSM context must be different");
> >> +
> >> +		next = next_ctx(next);
> >> +	}
> > Have you actually tried this on a machine with more than one LSM active?
> Fixed, also I think I we to check if "/sys/kernel/security/lsm" exists. 
> I guess it doesn't exist if no LSM are present.

We do call verify_supported_attr_current(); in the setup, that should be
enough. What I was asking for was if you ever tested this code on a
mach9ine where the count > 1 so that the loop actually triggered.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
