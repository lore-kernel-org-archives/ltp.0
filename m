Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D34FCC5DF81
	for <ltp@archiver.kernel.org>; Tue, 18 Aug 2026 17:57:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3A2BE3CCDDF
	for <ltp@archiver.kernel.org>; Tue, 18 Aug 2026 19:57:12 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 99F903CC64A
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 19:56:56 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id EB3BF600A13
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 19:56:54 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A637D3E69;
 Tue, 18 Aug 2026 17:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787075809; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JFiqAjn+r0GhTDvbWSvj7gKUHY6laiwEnYp/GbXPQyw=;
 b=mAQRi9tYDrAof3ZBOY3SHcUv4ipBRqv7HJcSux985gMZOL4eWKjxjReUnlqBKTNbXwDwPn
 varq7kTd9UT+mvUVRopC2AaV1btl40DjbqLNdJD5R9wmeY8ja2xCC4wNoQP78jSM4NvfHc
 vDYl5zanwr+7mzDREmXX+X5sNMRBfIc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787075809;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JFiqAjn+r0GhTDvbWSvj7gKUHY6laiwEnYp/GbXPQyw=;
 b=UOMTV3N+iEMK+6/9NcbwWDP9E6pLtbeTtdH11dA8++6PSqFvVlX+VgpvGLW4TBRWxno6tW
 xSzfpli624H9FSCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787075805; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JFiqAjn+r0GhTDvbWSvj7gKUHY6laiwEnYp/GbXPQyw=;
 b=srn25lPd6QNAnxzTtAslq9YhR6Vp7cmSi4CvxuNEwj499XiWUMkiUO0jRjlLuxB+DB05xj
 a0Ph3vzd4FjcfALxWF4gbbmnleOvRAEH4E/aYXXBOQ/k4qLmMmLiobU2e/nqS+S4+xemMu
 o8x/tjSO5nDeAzVZaT4274qYnCbV25A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787075805;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JFiqAjn+r0GhTDvbWSvj7gKUHY6laiwEnYp/GbXPQyw=;
 b=0LIWHC1yoMeJ8UbxRWZXj7qBAhm72aLzwAd1ccKJrIFxUvFZJuQPIomeDxQbxqCrk6iHcK
 Yt7BB7C43SeBaQAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9274E22BA;
 Tue, 18 Aug 2026 17:56:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6P5vIt2chGofRwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 18 Aug 2026 17:56:45 +0000
Date: Tue, 18 Aug 2026 19:56:49 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Avinesh Kumar <avinesh.kumar@suse.com>
Message-ID: <aoSc4VGJ6PQc4DTd@yuki.lan>
References: <an3Y03mKBzue5w2s@yuki.lan>
 <6a846568.bf927062.274a72.c3f7@mx.google.com>
 <aoRo8tGffK4KkdaT@yuki.lan>
 <38b59d36-8853-4d7b-8ca4-5a6f72667d2a@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <38b59d36-8853-4d7b-8ca4-5a6f72667d2a@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.996]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] openposix: Remove timer_*/speculative tests for
 invalid timerid
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
> >> This is the problem with POSIX systems.. I would suggest to keep them
> >> and simply ignore them if running on Linux. Do we have a mechanism for that
> >> or we should do it at runner level?
> > 
> > I guess that we can simply #ifndef __linux__ these.
> >
> 
> If we agree on this, I can send revised patch as suggested for all the
> tests under conformance/interfaces/timer_[delete|getoverrun|gettime|
> settime]/speculative/

Looks good to me.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
