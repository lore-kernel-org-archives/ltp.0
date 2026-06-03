Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93012CD6E55
	for <ltp@archiver.kernel.org>; Wed,  3 Jun 2026 13:34:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 950773E7210
	for <ltp@archiver.kernel.org>; Wed,  3 Jun 2026 15:34:03 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 72C243E619A
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 15:33:47 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C92B42001D4
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 15:33:46 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D6C4D6A7D8;
 Wed,  3 Jun 2026 13:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1780493626;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HCLOgo4IGO25zg5Mi+QaUQpG7NljLvbjZpviHrvaFPE=;
 b=fZUdyuKPbLuQkI/1QO99Y+89ia8fEy8p/BKhcWi8lE6dyy8ZaO1SAfMLWV3QcJMKgTcsZx
 si5yd6+ek0ecVqlzg/6KHDhNznjfxIquTiI1lysh0X8OpY0HfACJPaYdMZgdrecqS1kJ7c
 Vm91QXubvNkRx/nO/Rdkk/wOrXAn36E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1780493626;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HCLOgo4IGO25zg5Mi+QaUQpG7NljLvbjZpviHrvaFPE=;
 b=AJ4OoZC2jh28oHy1N5tr043YVU/mLxI7H26BYH1PgMiRfINLBq4kBE5j+UMESyZNgeVTA0
 sWz9iGCegeTYnAAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Tm9C6xWM;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=l1t2W0vD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1780493624;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HCLOgo4IGO25zg5Mi+QaUQpG7NljLvbjZpviHrvaFPE=;
 b=Tm9C6xWMl2ZIF4YglZCF6cZXOBYfK5+zKVdcJtlR+ygrP58nVPhwdCkglJd7yspFdz74Ax
 Pb1ckCViCMYX0sN5sQ6Xolv04dFoH3QWsgPdz+Vv0Xtt5/yw4ECTxjbZMpsbm+PMLbDkqI
 lnOhup9wmmgrW9bDDPRqkvPAmwsS7pc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1780493624;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HCLOgo4IGO25zg5Mi+QaUQpG7NljLvbjZpviHrvaFPE=;
 b=l1t2W0vDrFkVlGLucb/kS94esaAdDZSSm9JD59CadBQcVhJtMkyH+H3NnfC405yHiq+KK4
 a/4gKQxDsEzBFlDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 67CFA779A7;
 Wed,  3 Jun 2026 13:33:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id U1VpFzgtIGowSQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 03 Jun 2026 13:33:44 +0000
Date: Wed, 3 Jun 2026 15:33:42 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <20260603133342.GA592005@pevik>
References: <20260528162920.914321-1-amir73il@gmail.com>
 <20260528162920.914321-2-amir73il@gmail.com>
 <20260529163037.GB294659@pevik>
 <CAOQ4uxhR2CAKf0aALs7X2fLYMvgN5n8Hx3ADSDqdWXXnmdezQg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhR2CAKf0aALs7X2fLYMvgN5n8Hx3ADSDqdWXXnmdezQg@mail.gmail.com>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: D6C4D6A7D8
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[gmail.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[ozlabs.org:url,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:dkim];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] fanotify13: fix test failure when running
 iterations
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Amir,

...
> > We even have it in testcases/kernel/syscalls/renameat2/renameat2.h, this
> > function should be moved to include/lapi/renameat2.h or include/lapi/stdio.h
> > (header which includes it). If I have time on Monday, I can do the cleanup and
> > fix it.

> Sounds good. Please change the test to use the common header.

OK, alternative solution which does not need renameat2() was merged.
But FYI I prepared the solution in case renameat2() is needed in the future.

https://patchwork.ozlabs.org/project/ltp/list/?series=507298&state=*
https://lore.kernel.org/ltp/20260603115828.587769-1-pvorel@suse.cz/T/#t

And again, thank you (and Jan) for your work to keep fanotify tests in LTP updated.

Kind regards,
Petr

> Thanks,
> Amir.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
