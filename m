Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AF89C02181
	for <ltp@archiver.kernel.org>; Wed, 22 Jan 2025 10:27:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E81633C2EF5
	for <ltp@archiver.kernel.org>; Wed, 22 Jan 2025 11:27:12 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 093803C2CD6
 for <ltp@lists.linux.it>; Wed, 22 Jan 2025 11:26:55 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9FC6B101AF02
 for <ltp@lists.linux.it>; Wed, 22 Jan 2025 11:26:54 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C6E051F79E;
 Wed, 22 Jan 2025 10:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737541613;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JSx3Bi3j8iguJgi/LpavO+n2SjE81XX/AuahIIydlc4=;
 b=fqLmouFOW4tcPwbqm9UjbuCddJBXcPTPwzbS1ikmeOsYqA8ZT1u+zm2wnpu/IDWHIa2Cl8
 7Z2qHP4/nbgVEG7YUq4ipjS8+NGFf+8MPr7DVtjD1pSAywDN9AyoCA7b5KR5FlJxXmIUeg
 A7kYDdSMQ5a0SfMEVoe/2CPrd+oi1Zc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737541613;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JSx3Bi3j8iguJgi/LpavO+n2SjE81XX/AuahIIydlc4=;
 b=V84dkoPInmDdKxmNZESqVCFwinYKGjj6myo1G/H3fC26P6/NNulwi8qCjO42AS/oDCiorV
 JPtWMNWdSyFManAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737541613;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JSx3Bi3j8iguJgi/LpavO+n2SjE81XX/AuahIIydlc4=;
 b=fqLmouFOW4tcPwbqm9UjbuCddJBXcPTPwzbS1ikmeOsYqA8ZT1u+zm2wnpu/IDWHIa2Cl8
 7Z2qHP4/nbgVEG7YUq4ipjS8+NGFf+8MPr7DVtjD1pSAywDN9AyoCA7b5KR5FlJxXmIUeg
 A7kYDdSMQ5a0SfMEVoe/2CPrd+oi1Zc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737541613;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JSx3Bi3j8iguJgi/LpavO+n2SjE81XX/AuahIIydlc4=;
 b=V84dkoPInmDdKxmNZESqVCFwinYKGjj6myo1G/H3fC26P6/NNulwi8qCjO42AS/oDCiorV
 JPtWMNWdSyFManAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9E9A7136A1;
 Wed, 22 Jan 2025 10:26:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id fRduJO3HkGdPeAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 22 Jan 2025 10:26:53 +0000
Date: Wed, 22 Jan 2025 11:26:48 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Sven Schnelle <svens@linux.ibm.com>
Message-ID: <20250122102648.GA29598@pevik>
References: <20250122100915.3126008-1-svens@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250122100915.3126008-1-svens@linux.ibm.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] mmap01: initialize buffer in check_file()
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

Hi Sven,

> mmap01 reported random test failures. Turns out the
> the temporary buffer in check_file() isn't initialized.
> The SAFE_READ reads less then sizeof(buf) bytes so the
> rest stays initialized and might contain bytes check_file()
> is looking for.

Looks reasonable to me.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

@Cyril a candidate for merge before the release.

Kind regards,
Petr

> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> ---
>  testcases/kernel/syscalls/mmap/mmap01.c | 1 +
>  1 file changed, 1 insertion(+)

> diff --git a/testcases/kernel/syscalls/mmap/mmap01.c b/testcases/kernel/syscalls/mmap/mmap01.c
> index c93c37ceda52..ff09bc635c74 100644
> --- a/testcases/kernel/syscalls/mmap/mmap01.c
> +++ b/testcases/kernel/syscalls/mmap/mmap01.c
> @@ -36,6 +36,7 @@ static void check_file(void)
>  	int i, fildes, buf_len = sizeof(STRING) + 3;
>  	char buf[buf_len];

> +	memset(buf, 0, sizeof(buf));
>  	fildes = SAFE_OPEN(TEMPFILE, O_RDONLY);
>  	SAFE_READ(0, fildes, buf, sizeof(buf));

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
