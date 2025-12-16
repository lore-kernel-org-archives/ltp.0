Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C398D5E125
	for <ltp@archiver.kernel.org>; Tue, 16 Dec 2025 11:02:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 88B3C3D035C
	for <ltp@archiver.kernel.org>; Tue, 16 Dec 2025 12:02:17 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 688B73D034D
 for <ltp@lists.linux.it>; Tue, 16 Dec 2025 12:01:58 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7D02F6001AC
 for <ltp@lists.linux.it>; Tue, 16 Dec 2025 12:01:54 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A080C5BCC3;
 Tue, 16 Dec 2025 11:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765882913;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XzNHV/U+SOcHeYpXTzXp8H1qJ7vBAJipvUkNC2BnOUo=;
 b=h+vHch+jyRN5kTcdWDQz4gv5DH/CSHnpxsdEhuHcyZvJkpKlshd3OPtMcNgu3kBsA7nAQT
 /Dug4Gbj57H5lnNv01R9pthBf1QMCbO0wgWYBQN6FKUrIvFuvVc62vhYoG5PNPuJAjpo1t
 qpIpGXDv6tp5v8kBjsgTTmxWHRunZZE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765882913;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XzNHV/U+SOcHeYpXTzXp8H1qJ7vBAJipvUkNC2BnOUo=;
 b=5QFCC77rfv5mL5NooVbgWmJLJcXVHKfKY1llyF/K/FxFXJ1p5Cayw2V0b/L4PJQkd/rGrf
 cteWyK0IW2s1A2Bw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765882912;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XzNHV/U+SOcHeYpXTzXp8H1qJ7vBAJipvUkNC2BnOUo=;
 b=srGkRLbGGCA9MYieT/KOrfPRNMmFikPNu8SJlAyt693KIoeclnwYS4Usjn8W8AYCGibRIm
 Bkr61EtFki2L8ZNcNFWs6EJjPnsTNxmTnP/ui+fCkH9GnzZb5M4NrcCArAayJm+VrcA7Vv
 VqrYJH8lN9JNATdS5/qk3SqnmQYXUpg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765882912;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XzNHV/U+SOcHeYpXTzXp8H1qJ7vBAJipvUkNC2BnOUo=;
 b=USwyKjUEmYPHyHr+48jKxAaM4lAk8oxM8U7EinMzW4EGVuMItTTCzKbPhhN89KFHs+7CZf
 0ZsPAF4yIzC8wdAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 800C63EA63;
 Tue, 16 Dec 2025 11:01:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UYtvHSA8QWmCDgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 16 Dec 2025 11:01:52 +0000
Date: Tue, 16 Dec 2025 12:01:51 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20251216110151.GB307257@pevik>
References: <20251215124404.16395-1-chrubis@suse.cz>
 <20251215124404.16395-2-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251215124404.16395-2-chrubis@suse.cz>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.989]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] doc: Add ground rules page
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

Few more notes.
...
> +Use runtime checks for kernel features
> +======================================
> +
> +What is and what isn't supported by kernel is determined by the version
> +and configuration of the kernel the systems is currently running on.
> +That especially means that any checks done during the compilation cannot
> +be used to assume features supported by the kernel the tests end up
> +running on. The compile time checks, done by configure script, are only

Also please use link to the script:

-running on. The compile time checks, done by configure script, are only
+running on. The compile time checks, done by :master:`configure.ac`, are only

> +useful for enabling fallback kernel API definitions when missing, as we
> +do in lapi/ directory.

And to the lapi directory:

-do in lapi/ directory.
+do in headers in :master:`include/lapi/`.

(I'm not sure whether you just overlooked it or you don't see it useful.)

> +Kernel features and RCs
> +=======================
> +
> +LTP tests or fixes for kernel changes that were not released yet can be posted
> +to the LTP list for a review but will not be be accepted until respective
> +kernel changes are released. Review of such changes is also considered to be
> +lower priority than rest of the changes. This is because kernel changes
> +especially in the early RC phase are volatile and could be changed or reverted.

I would personally mention staging runtest file, but maybe I overlook your

:master:`runtest/staging`

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
