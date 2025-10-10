Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1EF9CCA476
	for <ltp@archiver.kernel.org>; Fri, 10 Oct 2025 09:46:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B7ED73CE9AA
	for <ltp@archiver.kernel.org>; Fri, 10 Oct 2025 11:46:19 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 99D7B3CD420
 for <ltp@lists.linux.it>; Fri, 10 Oct 2025 11:46:04 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CC57F2009A9
 for <ltp@lists.linux.it>; Fri, 10 Oct 2025 11:46:03 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 308921F393;
 Fri, 10 Oct 2025 09:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1760089563;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wYAeQiqZxUWSdiW6lIOVDkBRlmPh0UF4wG/u5eimLHI=;
 b=cRCOZJHrYsYN83BScUZrcxOrXfsrxkr3JoycwKWJ8KlsjNePmSNenfQ2xQzdxYuqtbTk0I
 RUe1ej3neYtkJef/C37AqpWxn8q8jd5IQNbKqCe28m7gwGLhd4NDoe0ku5LuJ9NhzhPdLm
 QkfkRSvZ6MZYGA23DyZ9vE3Zj4wSl6I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1760089563;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wYAeQiqZxUWSdiW6lIOVDkBRlmPh0UF4wG/u5eimLHI=;
 b=/AR+ugEZNwG2h3FWZrxm9cscKySYCqV8ZyEgGwhBo06h+q/tdfMrCCo8yIdag+hXhsjJWk
 eszsZ0zsDq9MH0BQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1760089562;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wYAeQiqZxUWSdiW6lIOVDkBRlmPh0UF4wG/u5eimLHI=;
 b=CKSx3xfoKy2lnUQVZEvtSN+EUnGZo/9z0uYX5FZ5GsvKIdepwp8PRqS5ZIZAZnOjezaVno
 dKMY0re0oULkbhe88xSYDXzN2fEDMdB/LGNj45TGCIAfVvaz1mXDO2OZlerU/HN4igs1yf
 cBccVMKDd8XnzZlOPAUbeJx3oVTTJXM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1760089562;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wYAeQiqZxUWSdiW6lIOVDkBRlmPh0UF4wG/u5eimLHI=;
 b=fBXhFIL7cbTtjWZme7UEuNTD3mf0r79kA+W/cFUpc2kIebq+kprVZ5Uso09XCJoytgfMXV
 ZcT8t+SPivQjI/AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BBB731375D;
 Fri, 10 Oct 2025 09:46:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1YtKLNnV6GhJBQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 10 Oct 2025 09:46:01 +0000
Date: Fri, 10 Oct 2025 11:45:55 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>, ltp@lists.linux.it,
 Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20251010094555.GC4281@pevik>
References: <20250928232708.24007-2-wegao@suse.com>
 <20251010064745.31361-1-wegao@suse.com>
 <20251010064745.31361-2-wegao@suse.com>
 <20251010091305.GB4281@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251010091305.GB4281@pevik>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/4] lib: Add support option for .needs_cmds
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

> Hi Wei,

> > + * with each entry in the array and returns the 'present' flag for the matching command.
> > + *
> > + * Return: `true` if the command is present, `false` otherwise.
> This needs to be Returns: (missing s)
> https://docs.kernel.org/doc-guide/kernel-doc.html

I'm sorry, I was wrong, it should be 'Return:', kerneldoc is wrong.

Kind regards,
Petr

> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
