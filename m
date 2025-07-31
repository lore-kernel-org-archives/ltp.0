Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCA5FC87FCC
	for <ltp@archiver.kernel.org>; Thu, 31 Jul 2025 10:55:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1951B3CBE98
	for <ltp@archiver.kernel.org>; Thu, 31 Jul 2025 12:55:49 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BC24C3C9F6C
 for <ltp@lists.linux.it>; Thu, 31 Jul 2025 12:55:32 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A5BA9600435
 for <ltp@lists.linux.it>; Thu, 31 Jul 2025 12:55:31 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6F82E210EF;
 Thu, 31 Jul 2025 10:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1753959330;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qy67CRiLjd5Vm/c+iHVFtp4TC1F1+Am4FXW6X2ZKAx8=;
 b=GrsoX3YOcGAmLGhwgKIHCI5FEWr91rRHAJT71Ja0FFZ3Aq1+uv0vIh9bZeo2PBzn064v6E
 UCwL8yDxQKfEHQVkOyf2xg+XJszfprDDR9ovMI4wpZwXaaY4LcPzrB9G+tDiL8Mf6r1zze
 Pb1foEfdg1XriVFCzjxrXkQ/48TCXw0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1753959330;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qy67CRiLjd5Vm/c+iHVFtp4TC1F1+Am4FXW6X2ZKAx8=;
 b=Iic8fntJl72QumZevT/Y5M/F9Ee31Iqt9+ZCCBoOmEkf1suWzorWogXARk6+KpMsrasr/2
 +2vZGCBhx7w0vDBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=GrsoX3YO;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Iic8fntJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1753959330;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qy67CRiLjd5Vm/c+iHVFtp4TC1F1+Am4FXW6X2ZKAx8=;
 b=GrsoX3YOcGAmLGhwgKIHCI5FEWr91rRHAJT71Ja0FFZ3Aq1+uv0vIh9bZeo2PBzn064v6E
 UCwL8yDxQKfEHQVkOyf2xg+XJszfprDDR9ovMI4wpZwXaaY4LcPzrB9G+tDiL8Mf6r1zze
 Pb1foEfdg1XriVFCzjxrXkQ/48TCXw0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1753959330;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qy67CRiLjd5Vm/c+iHVFtp4TC1F1+Am4FXW6X2ZKAx8=;
 b=Iic8fntJl72QumZevT/Y5M/F9Ee31Iqt9+ZCCBoOmEkf1suWzorWogXARk6+KpMsrasr/2
 +2vZGCBhx7w0vDBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D91113876;
 Thu, 31 Jul 2025 10:55:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id T6lgEaJLi2jZOAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 31 Jul 2025 10:55:30 +0000
Date: Thu, 31 Jul 2025 12:54:56 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20250731105456.GA36365@pevik>
References: <20250728212752.774436-1-wegao@suse.com>
 <20250731143358.1035685-1-wegao@suse.com>
 <31e3752c-e500-48b5-8e22-7ba581162fc8@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <31e3752c-e500-48b5-8e22-7ba581162fc8@suse.com>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 6F82E210EF
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] mount08.c: Check EACCES error when test under
 selinux enabled in enforce mode
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

Hi Andrea, Wei,

> We are not 100% sure that SELinux will be configured to block the access to
> mount. We should probably consider both of them only when SELinux is
> enabled, otherwise ENOENT only.

Good point. Lets' use TST_EXP_FAIL_ARR with ENOENT or ENOENT and EACCES.
Wei, please make a comment in source code, why EACCES is not enough for SELinux.
Thanks!

Kind regards,
Petr

> - Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
