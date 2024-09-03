Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E915BCD13CF
	for <ltp@archiver.kernel.org>; Tue,  3 Sep 2024 10:17:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4DB803C4E08
	for <ltp@archiver.kernel.org>; Tue,  3 Sep 2024 12:17:37 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 53E1D3C2F29
 for <ltp@lists.linux.it>; Tue,  3 Sep 2024 12:17:20 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5E68D601549
 for <ltp@lists.linux.it>; Tue,  3 Sep 2024 12:17:18 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 418C221B5C;
 Tue,  3 Sep 2024 10:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725358636; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UiJ0DFfvJneJyOjKUFaKQ7/BHkNlpF1KmKkglSVvVb0=;
 b=j+BVuFE4VG4K5BhQbTAo2KKFFg0bAAcJsi6Q/2f23Vh+5wBigPmoc6OipO+hlJ+xpDH2jO
 ePABbSotjU7lKq9v59v5m5lOmL9gTNQIUbDIV4hbeL1niu+2YRAI+ITZWXfwobChYxX8ia
 B8YHznm0gxiR14cAKSOniWx1VU2Bg8E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725358636;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UiJ0DFfvJneJyOjKUFaKQ7/BHkNlpF1KmKkglSVvVb0=;
 b=FIw1nKK5tBXjVY9E35ui3CcYS6izw7nI18pjg7us3TGuxCxaYzkvwcEGSckU7sClPucTeq
 atgxCo7UbafphvCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725358636; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UiJ0DFfvJneJyOjKUFaKQ7/BHkNlpF1KmKkglSVvVb0=;
 b=j+BVuFE4VG4K5BhQbTAo2KKFFg0bAAcJsi6Q/2f23Vh+5wBigPmoc6OipO+hlJ+xpDH2jO
 ePABbSotjU7lKq9v59v5m5lOmL9gTNQIUbDIV4hbeL1niu+2YRAI+ITZWXfwobChYxX8ia
 B8YHznm0gxiR14cAKSOniWx1VU2Bg8E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725358636;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UiJ0DFfvJneJyOjKUFaKQ7/BHkNlpF1KmKkglSVvVb0=;
 b=FIw1nKK5tBXjVY9E35ui3CcYS6izw7nI18pjg7us3TGuxCxaYzkvwcEGSckU7sClPucTeq
 atgxCo7UbafphvCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3185913A80;
 Tue,  3 Sep 2024 10:17:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id FkoXCyzi1mZZCgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 03 Sep 2024 10:17:16 +0000
Date: Tue, 3 Sep 2024 12:16:06 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <Ztbh5qyDln_t5C18@yuki.lan>
References: <20240902024017.6404-1-wegao@suse.com>
 <20240903081916.27033-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240903081916.27033-1-wegao@suse.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, yuki.lan:mid,
 imap1.dmz-prg2.suse.org:helo, suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] mpls01.sh: Add --allow-unsupported for modprobe
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
> Signed-off-by: Wei Gao <wegao@suse.com>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/network/mpls/mpls01.sh | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/network/mpls/mpls01.sh b/testcases/network/mpls/mpls01.sh
> index 196b5b2f9..892b5bd85 100755
> --- a/testcases/network/mpls/mpls01.sh
> +++ b/testcases/network/mpls/mpls01.sh
> @@ -21,7 +21,11 @@ cleanup()
>  
>  setup()
>  {
> -	ROD modprobe mpls_router
> +	if grep -q 'sl-micro' /etc/os-release; then

I do not like how specific is this check. The --allow-unsupported should
be at best no-op for SLE and openSUSE, right? So I would go for the
check of ID=suse rather than specifying just single variant.

> +		ROD modprobe --allow-unsupported mpls_router
> +	else
> +		ROD modprobe mpls_router
> +	fi
>  }
>  
>  test1()
> -- 
> 2.35.3
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
