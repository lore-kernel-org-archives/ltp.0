Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF9B2CD3427
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 08:35:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B06653E614C
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 10:35:10 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1F81B3E6148
 for <ltp@lists.linux.it>; Thu,  7 May 2026 10:34:48 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8F209200758
 for <ltp@lists.linux.it>; Thu,  7 May 2026 10:34:48 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5CFA75D67C;
 Thu,  7 May 2026 08:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1778142887; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S6LZZrbKgv0nHVJXJ/nN6PaU2TeRf8HPQxaKaMqVVFU=;
 b=pFsnOHmI5r/MKnVykPqjWPYJLbNFPXzNHyEsLvHg91PuBacoDizvj0w089zf+iT2AMwq+l
 p+qyAPqCODGqK+iqCbxUpvX2DtC38D4MsDVVVFUSSOz6uCyVI1xuKDZe07EK4gmZK0Br5U
 cTEHnYuQP5J6iMJSMNT0rUh9vzP8gWU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1778142887;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S6LZZrbKgv0nHVJXJ/nN6PaU2TeRf8HPQxaKaMqVVFU=;
 b=UElkIVBeEe7CLU32rLSLb8oTUwjeBBnJ0kYu4bvDgC/WQRJHSjehQFzlb166O947pfGf83
 b7AvoPgBC/TTjmBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1778142887; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S6LZZrbKgv0nHVJXJ/nN6PaU2TeRf8HPQxaKaMqVVFU=;
 b=pFsnOHmI5r/MKnVykPqjWPYJLbNFPXzNHyEsLvHg91PuBacoDizvj0w089zf+iT2AMwq+l
 p+qyAPqCODGqK+iqCbxUpvX2DtC38D4MsDVVVFUSSOz6uCyVI1xuKDZe07EK4gmZK0Br5U
 cTEHnYuQP5J6iMJSMNT0rUh9vzP8gWU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1778142887;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S6LZZrbKgv0nHVJXJ/nN6PaU2TeRf8HPQxaKaMqVVFU=;
 b=UElkIVBeEe7CLU32rLSLb8oTUwjeBBnJ0kYu4bvDgC/WQRJHSjehQFzlb166O947pfGf83
 b7AvoPgBC/TTjmBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 47F47593A7;
 Thu,  7 May 2026 08:34:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id nDZrEKdO/Gk5SwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 07 May 2026 08:34:47 +0000
Date: Thu, 7 May 2026 10:34:46 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Ricardo Branco <rbranco@suse.de>
Message-ID: <afxOpm_F4nevB2Gq@yuki.lan>
References: <20260507083131.28197-1-rbranco@suse.de>
 <20260507083131.28197-2-rbranco@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260507083131.28197-2-rbranco@suse.de>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_DN_SOME(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/2] userfaultfd: Use two-step handshake to
 probe features
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
>  static void run(void)
>  {
>  	pthread_t thr;
> -	struct uffdio_api uffdio_api;
> +	struct uffdio_api uffdio_api = {};
>  	struct uffdio_register uffdio_register;
>  	struct uffdio_writeprotect uffdio_writeprotect;
>  
> +	CHECK_UFFD_FEATURE(UFFD_FEATURE_PAGEFAULT_FLAG_WP);

Can we please move this into the test setup() so that it's executed only
once if the test is started with -i parameter?


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
