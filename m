Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A751C83F27
	for <ltp@archiver.kernel.org>; Wed, 16 Jul 2025 06:00:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 858733CB926
	for <ltp@archiver.kernel.org>; Wed, 16 Jul 2025 08:00:57 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 960203C651D
 for <ltp@lists.linux.it>; Wed, 16 Jul 2025 08:00:40 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1BAE26008CE
 for <ltp@lists.linux.it>; Wed, 16 Jul 2025 08:00:39 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 060362123B;
 Wed, 16 Jul 2025 06:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1752645639;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rZ4QyPTSGsZJOWPBnw83Z5Oe7XiygwklRjXjuwOAsR0=;
 b=cWw8hWGoxeapx3s/+g0tYrClexKbFg70T9a8jA8PaJFLN/MeLTc4F1LrfHGDnrwUSP5wlj
 2vZbO1zfE1lP9Z7i9RcxcRhWuDmEYrPAgX81VWfLrA02Y8y5tL+R4hVa9GVh3FMGjkfXtb
 8X7Pm9KdbgUYv4Uc1hjBDPwX7weYtb8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1752645639;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rZ4QyPTSGsZJOWPBnw83Z5Oe7XiygwklRjXjuwOAsR0=;
 b=IgxlJbaQPGxAbCeq0RTGC4SbBNhX7KPrw5pgw5KCJVjTxbNM/bG9tns+1xAaTgqKfuOnR3
 1XpJCMKocGmmvDBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1752645639;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rZ4QyPTSGsZJOWPBnw83Z5Oe7XiygwklRjXjuwOAsR0=;
 b=cWw8hWGoxeapx3s/+g0tYrClexKbFg70T9a8jA8PaJFLN/MeLTc4F1LrfHGDnrwUSP5wlj
 2vZbO1zfE1lP9Z7i9RcxcRhWuDmEYrPAgX81VWfLrA02Y8y5tL+R4hVa9GVh3FMGjkfXtb
 8X7Pm9KdbgUYv4Uc1hjBDPwX7weYtb8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1752645639;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rZ4QyPTSGsZJOWPBnw83Z5Oe7XiygwklRjXjuwOAsR0=;
 b=IgxlJbaQPGxAbCeq0RTGC4SbBNhX7KPrw5pgw5KCJVjTxbNM/bG9tns+1xAaTgqKfuOnR3
 1XpJCMKocGmmvDBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DF005138D2;
 Wed, 16 Jul 2025 06:00:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id PKUCNQZAd2gzYwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 16 Jul 2025 06:00:38 +0000
Date: Wed, 16 Jul 2025 08:00:37 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250716060037.GA17458@pevik>
References: <20250710123455.20199-1-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250710123455.20199-1-chrubis@suse.cz>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] macros: Add basic docs
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

> Describe all "public" macros.
> Move variables to the top.
> Add header to the sphinx doc.

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
> I've took the changes from Peter and:

> - added more verbose description that would hopefully explain the macros
>   better

> - added documentation for a few macros that was missing previously

> - moved the macros into its own menu category since the Core LTP API is
>   long enough already

Thanks a lot for greatly improving and finishing the work. This will help not
only to the newcomers to understand the test code.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
