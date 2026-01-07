Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DAF9CFD65A
	for <ltp@archiver.kernel.org>; Wed,  7 Jan 2026 16:15:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BB0433C5399
	for <ltp@archiver.kernel.org>; Wed,  7 Jan 2026 17:15:34 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 16E813C4CA2
 for <ltp@lists.linux.it>; Wed,  7 Jan 2026 17:15:14 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 66B9C140033C
 for <ltp@lists.linux.it>; Wed,  7 Jan 2026 17:15:13 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6E6EE5C224;
 Wed,  7 Jan 2026 16:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1767802512; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A7+VkgSzZ6TBfg0J4u7Gs2+LepoOaSUx94TOJ8pFsq8=;
 b=c+sUSMlXUuKDvmfnuipu8yMJ2NfifNREbFOaAuEok8k/M1k5eTe7hlUCjl8zUjl399YQJ9
 HFTEEmq2N1pomcSm1YNzCp2WzJD+Z6D4Iwd1vKhq639m7Qkw1FOA7S2wtD80jLoL0EFKYj
 RAm+6a/ZgtH/RY9cIQWQ61OCzbgVXXk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1767802512;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A7+VkgSzZ6TBfg0J4u7Gs2+LepoOaSUx94TOJ8pFsq8=;
 b=f4MZhGiyoB9xY4MaLB0ns627QQcZN1CFbQmT3Ac6XYRuJ0oCq3+HiB7g/aRWOiR+UcOTCC
 zYC9VaQtsgbh9vAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=hJjZpOHR;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=4UJMztXw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1767802511; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A7+VkgSzZ6TBfg0J4u7Gs2+LepoOaSUx94TOJ8pFsq8=;
 b=hJjZpOHRoU4B7wyGzCO4ktepKgxZf4C7YA8OFV6RiSWOF+GisWp5K6zpQj/Ij0XPQW1oAp
 m/P9dr4wtneFFlfvntEH5NqNtevQTHA4XkARK9/A7TdASI7EQu14lIgs+kasOOw6H460u/
 EeHS1MUV6byGlMEfH1rsV27UDgOOvYw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1767802511;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A7+VkgSzZ6TBfg0J4u7Gs2+LepoOaSUx94TOJ8pFsq8=;
 b=4UJMztXwFtxG2Xf2L4cYUL4+O5y9VYFvUTuZrPyunewVdG4hQZYxQAuKJNncx7rZn7JG5H
 Fl65eDul5OfrD2Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5CDE83EA63;
 Wed,  7 Jan 2026 16:15:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ehw6FY+GXmnwLgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 07 Jan 2026 16:15:11 +0000
Date: Wed, 7 Jan 2026 17:16:18 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aV6G0gxYWHSFkls0@yuki.lan>
References: <20251209211629.95436-1-terry.tritton@linaro.org>
 <20251215155330.GC272695@pevik>
 <DEYWYH3VLMDA.R2SSTA8T80LU@suse.com>
 <20251215161353.GA282302@pevik>
 <DEYXGZU8IXPQ.2N0IS65HUZ0LI@suse.com>
 <20251215165247.GC282302@pevik>
 <DF171554SNRA.2CKR0Q3FLG2TU@suse.com>
 <CABeuJB2TJ4bQDX709-sLO0tb0acYH770kS6X5zXMh0V0M3Yt-w@mail.gmail.com>
 <aV6DCbns02E4BCTj@yuki.lan> <20260107160656.GB791855@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260107160656.GB791855@pevik>
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[7];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 6E6EE5C224
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ioctl_pidfd02-06: Add CONFIG_USER_NS and
 CONFIG_PID_NS to needs_kconfigs
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
Cc: ltp@lists.linux.it, Terry Tritton <terry.tritton@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Thanks for your input. I understand that you're for replacing in ioctl_ns06.c:
> 
> 	int exists = access("/proc/self/ns/user", F_OK);
> 
> 	if (exists < 0)
> 		tst_res(TCONF, "namespace not available");
> 
> with .needs_kconfigs:
> 
> 	.needs_kconfigs = (const char *[]) {
> 		"CONFIG_USER_NS",
> 		NULL
> 	}
> 
> Because that was my question - really always prefer kconfig even there is a
> simple runtime solution? I'd like to have some "rule" like conclusion we can
> point during review.

I think that from a long term view this is going to be simpler solution
than having many different types of checks. The less diverse these
checks are the easier they are to review and maintain. Hence I lean
towards kernel config checks even though they are slower (mostly
unmeasurable on today's harware) than the alternatives.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
