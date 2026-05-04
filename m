Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5876FF885A
	for <ltp@archiver.kernel.org>; Mon,  4 May 2026 15:50:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 189083E620F
	for <ltp@archiver.kernel.org>; Mon,  4 May 2026 17:50:38 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7DFD53E1C3E
 for <ltp@lists.linux.it>; Mon,  4 May 2026 17:50:17 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8C2231400244
 for <ltp@lists.linux.it>; Mon,  4 May 2026 17:50:16 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BB6145C49A;
 Mon,  4 May 2026 15:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777909814; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SXldp8Cv4MbHxDR4a4fN60ZMKFIPrFr73m8w/jpEyio=;
 b=c2UAqZcjqbacpAJjEOFBCfYtW4YcYgjE4VbLaaImfDHMslsg/mJl6/4CXG1NdrIHfH+QxX
 kWAmmQIIgNSN0QKmt2A5D5ZlYoki2HdcQW9518ELtrKtvcxvvl1aMo9N6NgxcjGoAw78vr
 JNwe6BCZxIaUFxVKDcKsBcSaM5cYGG8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777909814;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SXldp8Cv4MbHxDR4a4fN60ZMKFIPrFr73m8w/jpEyio=;
 b=55UDT3/GpbBt+wQITEBiZ1KqHb1PNZNSBFGROv3dNyxOn1ESqC2Eu8OAPhlMvCNbLyoxJN
 hA/vAjw5pGp8qWAg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=c2UAqZcj;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="55UDT3/G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777909814; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SXldp8Cv4MbHxDR4a4fN60ZMKFIPrFr73m8w/jpEyio=;
 b=c2UAqZcjqbacpAJjEOFBCfYtW4YcYgjE4VbLaaImfDHMslsg/mJl6/4CXG1NdrIHfH+QxX
 kWAmmQIIgNSN0QKmt2A5D5ZlYoki2HdcQW9518ELtrKtvcxvvl1aMo9N6NgxcjGoAw78vr
 JNwe6BCZxIaUFxVKDcKsBcSaM5cYGG8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777909814;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SXldp8Cv4MbHxDR4a4fN60ZMKFIPrFr73m8w/jpEyio=;
 b=55UDT3/GpbBt+wQITEBiZ1KqHb1PNZNSBFGROv3dNyxOn1ESqC2Eu8OAPhlMvCNbLyoxJN
 hA/vAjw5pGp8qWAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AA54F593A3;
 Mon,  4 May 2026 15:50:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id w1U2JzbA+GkXLAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 04 May 2026 15:50:14 +0000
Date: Mon, 4 May 2026 17:50:12 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Ricardo Branco <rbranco@suse.de>
Message-ID: <afjANI7jr23hP4IJ@yuki.lan>
References: <20260411092452.211540-1-rbranco@suse.de>
 <20260415080623.164440-1-rbranco@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260415080623.164440-1-rbranco@suse.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: BB6145C49A
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] userfaultfd: Use two-step handshake to probe
 features
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
> +	/*
> +	 * Two-step handshake to check if feature is available
> +	 */

Please no obvious comments like this.

> +	uffd = SAFE_USERFAULTFD(O_CLOEXEC | O_NONBLOCK, false);
> +	uffdio_api.api = UFFD_API;
> +	SAFE_IOCTL(uffd, UFFDIO_API, &uffdio_api);
> +	if (!(uffdio_api.features & UFFD_FEATURE_PAGEFAULT_FLAG_WP))
> +		tst_brk(TCONF, "UFFD_FEATURE_PAGEFAULT_FLAG_WP not supported");
> +	SAFE_CLOSE(uffd);

I do not get why are we adding this code when we do the same just a few
lines below. Shouldn't just this suffice?

diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd05.c b/testcases/kernel/syscalls/userfaultfd/userfaultfd05.c
index e25a227cf..b19132d0c 100644
--- a/testcases/kernel/syscalls/userfaultfd/userfaultfd05.c
+++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd05.c
@@ -95,6 +95,9 @@ static void run(void)
 
        SAFE_IOCTL(uffd, UFFDIO_API, &uffdio_api);
 
+       if (!(uffdio_api.features & UFFD_FEATURE_PAGEFAULT_FLAG_WP))
+               tst_brk(TCONF, "UFFD_FEATURE_PAGEFAULT_FLAG_WP not supported");
+
        uffdio_register.range.start = (unsigned long) page;
        uffdio_register.range.len = page_size;
        uffdio_register.mode = UFFDIO_REGISTER_MODE_WP;


> index 5b1252c35..e1b3c2f6f 100644
> --- a/testcases/kernel/syscalls/userfaultfd/userfaultfd06.c
> +++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd06.c
> @@ -97,18 +97,25 @@ static void run(void)
>  
>  	poison_fault_seen = 0;
>  	sigbus_seen = 0;
> -	set_pages();
>  
> +	/*
> +	 * Two-step handshake to check if feature is available
> +	 */
>  	uffd = SAFE_USERFAULTFD(O_CLOEXEC | O_NONBLOCK, false);
> +	uffdio_api.api = UFFD_API;
> +	SAFE_IOCTL(uffd, UFFDIO_API, &uffdio_api);
> +	if (!(uffdio_api.features & UFFD_FEATURE_POISON))
> +		tst_brk(TCONF, "UFFD_FEATURE_POISON not supported");
> +	SAFE_CLOSE(uffd);
>  
> +	set_pages();
> +
> +	uffd = SAFE_USERFAULTFD(O_CLOEXEC | O_NONBLOCK, false);
>  	uffdio_api.api = UFFD_API;
>  	uffdio_api.features = UFFD_FEATURE_POISON;
>
>  	SAFE_IOCTL(uffd, UFFDIO_API, &uffdio_api);
>  
> -	if (!(uffdio_api.features & UFFD_FEATURE_POISON))
> -		tst_brk(TCONF, "UFFD_FEATURE_POISON not supported");
> -

This does not seem to make any sense. The code already checks for the
feature, or do I miss something?

>  	uffdio_register.range.start = (unsigned long) page;
>  	uffdio_register.range.len = page_size;
>  	uffdio_register.mode = UFFDIO_REGISTER_MODE_MISSING;
> -- 
> 2.53.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
