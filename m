Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F04FFE51FB
	for <ltp@archiver.kernel.org>; Fri, 24 Apr 2026 10:03:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F3C3B3E2E02
	for <ltp@archiver.kernel.org>; Fri, 24 Apr 2026 12:03:00 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B207B3CBC10
 for <ltp@lists.linux.it>; Fri, 24 Apr 2026 12:02:41 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 539E46002C7
 for <ltp@lists.linux.it>; Fri, 24 Apr 2026 12:02:41 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DE15E6A8A3;
 Fri, 24 Apr 2026 10:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777024960;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Jb3WJs9hsf2L/3KKUaMvCl+JuscUCwTR4pbalJMfb2s=;
 b=y+JEzW4ghtruGCOYRLfI9VgMOAiktRAJJxAogyoBHS9B7JGF9yUcAa0QoHjRuidKHZSd5y
 cFcv9ZCl09ohqHTRAkqV/eDJcxxIkv1dB2RekruXZNz6LmlLLkzkyWCnLYYgrTxVqlnPY7
 vn1+vwyShrT5i/gQXavuCYQrSM1vBhM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777024960;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Jb3WJs9hsf2L/3KKUaMvCl+JuscUCwTR4pbalJMfb2s=;
 b=HyOFgs1ote9uJaIiv4b4OMU2wnunv9OcDgBrwWxc/feP2EALsNCPmFcYC6Vod5p8x1VZZx
 /wG8yviBV0oS3sCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777024960;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Jb3WJs9hsf2L/3KKUaMvCl+JuscUCwTR4pbalJMfb2s=;
 b=y+JEzW4ghtruGCOYRLfI9VgMOAiktRAJJxAogyoBHS9B7JGF9yUcAa0QoHjRuidKHZSd5y
 cFcv9ZCl09ohqHTRAkqV/eDJcxxIkv1dB2RekruXZNz6LmlLLkzkyWCnLYYgrTxVqlnPY7
 vn1+vwyShrT5i/gQXavuCYQrSM1vBhM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777024960;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Jb3WJs9hsf2L/3KKUaMvCl+JuscUCwTR4pbalJMfb2s=;
 b=HyOFgs1ote9uJaIiv4b4OMU2wnunv9OcDgBrwWxc/feP2EALsNCPmFcYC6Vod5p8x1VZZx
 /wG8yviBV0oS3sCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B368A593A5;
 Fri, 24 Apr 2026 10:02:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iA0JKcA/62m9ZAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 24 Apr 2026 10:02:40 +0000
Date: Fri, 24 Apr 2026 12:02:34 +0200
From: Petr Vorel <pvorel@suse.cz>
To: linuxtestproject.agent@gmail.com, ltp@lists.linux.it
Message-ID: <20260424100234.GC500158@pevik>
References: <20260424060543.462475-1-pvorel@suse.cz>
 <20260424080912.4039-1-linuxtestproject.agent@gmail.com>
 <20260424100133.GB500158@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260424100133.GB500158@pevik>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_TO(0.00)[gmail.com,lists.linux.it];
 TAGGED_RCPT(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] ioctl_pidfd06: Update kernel version
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

...
> > Also, since this corrects a bug (TFAIL on kernels with the backport),
> > please add a Fixes: tag referencing the commit that introduced the
> > original tst_kvercmp(7, 0, 0) check.

> Do we want to add Fixes when original commit was correct?

Shouldn't be Follow-up: used?

Kind regards,
Petr

> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
