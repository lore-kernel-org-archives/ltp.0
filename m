Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D093F01832
	for <ltp@archiver.kernel.org>; Fri,  6 Mar 2026 12:54:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 869493CFEF3
	for <ltp@archiver.kernel.org>; Fri,  6 Mar 2026 13:54:47 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7E0B03CE1F7
 for <ltp@lists.linux.it>; Fri,  6 Mar 2026 13:54:29 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C44A71000DF9
 for <ltp@lists.linux.it>; Fri,  6 Mar 2026 13:54:28 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 578B53E6C8;
 Fri,  6 Mar 2026 12:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1772801667;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AMgKvCs30fIS1Q7TdYrtSDRc8zm843dCbfoCJTjGBlc=;
 b=nCuYkuhELTEc9mF+r11Exw7RSaqDMXGtd/Q6no+ZBijogo5im0EKqA9UMfbSgEVMGYv8/y
 F3j1CHvL016qMMUc4/w6eeR4zfzBt8FdidjLUfHwI6JHE+nVRj6GNHYsGBrzYmIX6V4xQQ
 EcFtJSsPFUFCZma2IpDn+bt7g/HBjEI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1772801667;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AMgKvCs30fIS1Q7TdYrtSDRc8zm843dCbfoCJTjGBlc=;
 b=Jk9hfVgyJ3ZrhA4vbaoq1z0Rib2Fr497kIAcJiToyjgAvOA+OrcwOGTonY759DUhOF7ckL
 ZXD5c9V16BGjJsAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=nCuYkuhE;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Jk9hfVgy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1772801667;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AMgKvCs30fIS1Q7TdYrtSDRc8zm843dCbfoCJTjGBlc=;
 b=nCuYkuhELTEc9mF+r11Exw7RSaqDMXGtd/Q6no+ZBijogo5im0EKqA9UMfbSgEVMGYv8/y
 F3j1CHvL016qMMUc4/w6eeR4zfzBt8FdidjLUfHwI6JHE+nVRj6GNHYsGBrzYmIX6V4xQQ
 EcFtJSsPFUFCZma2IpDn+bt7g/HBjEI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1772801667;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AMgKvCs30fIS1Q7TdYrtSDRc8zm843dCbfoCJTjGBlc=;
 b=Jk9hfVgyJ3ZrhA4vbaoq1z0Rib2Fr497kIAcJiToyjgAvOA+OrcwOGTonY759DUhOF7ckL
 ZXD5c9V16BGjJsAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3A3F53EA75;
 Fri,  6 Mar 2026 12:54:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mLkrDYPOqmkhVAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 06 Mar 2026 12:54:27 +0000
Date: Fri, 6 Mar 2026 13:54:17 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260306125417.GA528953@pevik>
References: <20260304144424.10101-1-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260304144424.10101-1-chrubis@suse.cz>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:replyto,suse.cz:dkim,suse.cz:email];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 578B53E6C8
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls: ulimit01; Convert to the new library
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

Hi Cyril,

> Linux does not implement UL_GMEMLIM, UL_GDESLIM and UL_GSHMEMLIM so we
> keep only the UL_GETFSIZE and UL_SETFSIZE.
...

LGTM, thanks for the cleanup.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

> +/*\
> + * Tests the basic functionality of ulimit() with UL_GETFSIZE and UL_SETFSIZE.
nit: Could you please change before merge ulimit() to
:manpage:`ulimit(3)`
so that we get link to https://man7.org/linux/man-pages/man3/ulimit.3.html ?

FYI kernel uses automarkup to recognise various things e.g. git hash [1].
Maybe we could employ it for git kernel commits.
But for man page it can have false positives [2].

[1] https://lore.kernel.org/linux-doc/87a4ydo1hf.fsf@trenco.lwn.net/
[2] https://lore.kernel.org/linux-doc/aWqg5XwPRXlzq4FI@devuan/

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
