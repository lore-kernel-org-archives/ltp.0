Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C939CD3442
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 09:06:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5377C3E2C38
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 11:06:30 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6032A3E28A2
 for <ltp@lists.linux.it>; Thu,  7 May 2026 11:06:08 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B023A6009D8
 for <ltp@lists.linux.it>; Thu,  7 May 2026 11:06:07 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 160B35D8E9;
 Thu,  7 May 2026 09:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1778144766; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OcwVmTCsCVJGvLzU5j2ZgpAJ//UEOhrF0EBW9HQCAes=;
 b=HJXhTKq1VH2SprURAOnf9fTuLav77AAJBNjmLygF6NykXXkAWKUFb8hde5v4AaZNeeBx1m
 FhnRfxD5wTjZsJ00IIy5NYCyQjKYOeCYVyOxHI6sLEbVPgD9JQREg6lQhD125x2jeam2EH
 /CwQX3ErzyhDL1LRDQ2eWiR9Ctt5R6k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1778144766;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OcwVmTCsCVJGvLzU5j2ZgpAJ//UEOhrF0EBW9HQCAes=;
 b=jYdba+AQBV82FxEaCRelqA4ztwLSYP7IgaSSRNDU7kN7jqN+ulx2JTT9xdwN9JJcx1jbrG
 KMekzQ0j5ji3fSAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1778144766; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OcwVmTCsCVJGvLzU5j2ZgpAJ//UEOhrF0EBW9HQCAes=;
 b=HJXhTKq1VH2SprURAOnf9fTuLav77AAJBNjmLygF6NykXXkAWKUFb8hde5v4AaZNeeBx1m
 FhnRfxD5wTjZsJ00IIy5NYCyQjKYOeCYVyOxHI6sLEbVPgD9JQREg6lQhD125x2jeam2EH
 /CwQX3ErzyhDL1LRDQ2eWiR9Ctt5R6k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1778144766;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OcwVmTCsCVJGvLzU5j2ZgpAJ//UEOhrF0EBW9HQCAes=;
 b=jYdba+AQBV82FxEaCRelqA4ztwLSYP7IgaSSRNDU7kN7jqN+ulx2JTT9xdwN9JJcx1jbrG
 KMekzQ0j5ji3fSAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0108B593A7;
 Thu,  7 May 2026 09:06:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id a7xKOv1V/GkwagAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 07 May 2026 09:06:05 +0000
Date: Thu, 7 May 2026 11:06:04 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <afxV_HUH7q3toVr6@yuki.lan>
References: <afxBKVidvR96iTTP@yuki.lan>
 <69fc42c8.050a0220.275b3.f9b1@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <69fc42c8.050a0220.275b3.f9b1@mx.google.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, yuki.lan:mid,
 suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/2] Fix proc parsing in newuname01
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
> > Do we stil follow the C89 in this regard? We already force gnu99 in
> > the config.mk.
> 
> It doesn't make any sense indeed. I added the c99 agent rule, but we told
> it to follow kernel linux conventions, which are specific, including this
> one.

I do not think that they enforce that rule these days. AFAIK kernel
forces even newer c11 standard for some time.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
