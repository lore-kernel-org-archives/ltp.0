Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29058C4450A
	for <ltp@archiver.kernel.org>; Thu, 16 Jul 2026 11:04:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D42E73E5645
	for <ltp@archiver.kernel.org>; Thu, 16 Jul 2026 13:04:38 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 56BE23E2539
 for <ltp@lists.linux.it>; Thu, 16 Jul 2026 13:04:24 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B189E1A00891
 for <ltp@lists.linux.it>; Thu, 16 Jul 2026 13:04:23 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0EE453E2F;
 Thu, 16 Jul 2026 11:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1784199863;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YShJEN+CaeyHE4zJwLz1/87QeIs0gI2fSwJ33SAJlqc=;
 b=oOkkKJogyb6ByrlAimdp1/Ykoy8Q/LliWNWX2byXqjOaVxtLC/2baybk1cMZsBXanxSOsB
 9n2oVp8orda67M28Ux9quCYw0F8sGwKoQb2zSx+6Tp2bckIlO/kLC3A69NWt3hQjuI7/nl
 y7FEJ1MR2UJFq1LkYYRJU1T8ZIVq+j4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1784199863;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YShJEN+CaeyHE4zJwLz1/87QeIs0gI2fSwJ33SAJlqc=;
 b=tl3tgt33dKhynw6cNt8zc9WkWXtUD+BaCoH6hyqcq3F6XZt9GqNA86JzkMj0MoFsOsVbwG
 ZZiftHQmRyi1dMDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1784199863;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YShJEN+CaeyHE4zJwLz1/87QeIs0gI2fSwJ33SAJlqc=;
 b=oOkkKJogyb6ByrlAimdp1/Ykoy8Q/LliWNWX2byXqjOaVxtLC/2baybk1cMZsBXanxSOsB
 9n2oVp8orda67M28Ux9quCYw0F8sGwKoQb2zSx+6Tp2bckIlO/kLC3A69NWt3hQjuI7/nl
 y7FEJ1MR2UJFq1LkYYRJU1T8ZIVq+j4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1784199863;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YShJEN+CaeyHE4zJwLz1/87QeIs0gI2fSwJ33SAJlqc=;
 b=tl3tgt33dKhynw6cNt8zc9WkWXtUD+BaCoH6hyqcq3F6XZt9GqNA86JzkMj0MoFsOsVbwG
 ZZiftHQmRyi1dMDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 98A51779AD;
 Thu, 16 Jul 2026 11:04:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EQb9H7a6WGpQdQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 16 Jul 2026 11:04:22 +0000
Date: Thu, 16 Jul 2026 13:04:20 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20260716110420.GB263840@pevik>
References: <20260716105344.263649-1-pvorel@suse.cz>
 <6a58b977.359f6b3d.1dc26e.28f9@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a58b977.359f6b3d.1dc26e.28f9@mx.google.com>
X-Spamd-Result: default: False [-6.00 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; SUSPICIOUS_RECIPS(1.50)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[lists.linux.it,suse.cz,gmail.com,suse.com];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]; SINGLE_SHORT_PART(0.00)[];
 TAGGED_RCPT(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] submodules: Move from git:// to https://
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

Hi Andrea,

thanks, merged!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
