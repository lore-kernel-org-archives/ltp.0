Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70F9AC3DA6E
	for <ltp@archiver.kernel.org>; Wed,  3 Jan 2024 12:49:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4C0223CB4B6
	for <ltp@archiver.kernel.org>; Wed,  3 Jan 2024 13:49:15 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E508B3C8BA4
 for <ltp@lists.linux.it>; Wed,  3 Jan 2024 13:49:06 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4BC6D1400547
 for <ltp@lists.linux.it>; Wed,  3 Jan 2024 13:49:04 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 18BFB22041;
 Wed,  3 Jan 2024 12:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704286144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+09fTSC+AfiONv2Yyb09OGrgkUW0pTgCeFP7pDtXJog=;
 b=cFCeY62ZoxbSbyH1uueOdsu8HazbRkWaNFgmYyBTHhbVe6t9tHByy2Xj33+BT051unJwF5
 L2GT1X3Pe5Uzb5e5AhCqNfqSTyrOzCfPayjcvfvZX0dE0oKrHn68RvkCFopwuRdUxEse7g
 db4UeLMbXVHz4PsWKQvsKowSdfT0+w0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704286144;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+09fTSC+AfiONv2Yyb09OGrgkUW0pTgCeFP7pDtXJog=;
 b=/i4ujFS/o6pqyD0LUp1z6cOR5BcK7Rarj87KQEIxQ4WVgM/+oi2e6zx2vGBoSmZZZXiXi8
 UAxUfwmLoxxOErAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704286144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+09fTSC+AfiONv2Yyb09OGrgkUW0pTgCeFP7pDtXJog=;
 b=cFCeY62ZoxbSbyH1uueOdsu8HazbRkWaNFgmYyBTHhbVe6t9tHByy2Xj33+BT051unJwF5
 L2GT1X3Pe5Uzb5e5AhCqNfqSTyrOzCfPayjcvfvZX0dE0oKrHn68RvkCFopwuRdUxEse7g
 db4UeLMbXVHz4PsWKQvsKowSdfT0+w0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704286144;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+09fTSC+AfiONv2Yyb09OGrgkUW0pTgCeFP7pDtXJog=;
 b=/i4ujFS/o6pqyD0LUp1z6cOR5BcK7Rarj87KQEIxQ4WVgM/+oi2e6zx2vGBoSmZZZXiXi8
 UAxUfwmLoxxOErAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 056911340C;
 Wed,  3 Jan 2024 12:49:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 9DUIAcBXlWUEKwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 03 Jan 2024 12:49:04 +0000
Date: Wed, 3 Jan 2024 13:49:24 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Subramanya Swamy <subramanya.swamy.linux@gmail.com>
Message-ID: <ZZVX1LUDuJGOxEXu@yuki>
References: <20240103121726.1854-1-subramanya.swamy.linux@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240103121726.1854-1-subramanya.swamy.linux@gmail.com>
X-Spamd-Result: default: False [0.40 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TAGGED_RCPT(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linux.it:url,suse.cz:email];
 FREEMAIL_TO(0.00)[gmail.com]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.00)[17.43%]
Authentication-Results: smtp-out1.suse.de;
	none
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] read_all :catch alignment faults while reading
 sys entries seen in commit :bc21785b7336619fb6a67f1fff5afdaf229acc
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
> +	 * This could catch any alignment faults while reading sys entries
> +	 * seen in commit :bc21785b7336619fb6a67f1fff5afdaf229acc so reading 1024 bytes
                                 ^
				 This does not seem to match any kernel upstream commit.
> +	 * in chunks of 8 bytes 128 times
> +	 */
> +	char check_buf[7];
                       ^
		       This isn't 8 bytes at all as it's written in
		       description.
> +	unsigned int i;
> +
> +	for (i = 0; i < 128; i++) {
> +		count = read(fd, check_buf, sizeof(check_buf));
> +		if (count == 0 || count < 0)
> +			break;
> +	}

So the intention is to read the buffer in smaller chunks? I guess that
it's hard to tell without having seen the kernel bugfix.

>  	count = read(fd, buf, sizeof(buf) - 1);

I wonder should we seek back in the fd, or do pread() with zero offset here?

>  	elapsed = worker_elapsed(worker);
>  
> @@ -713,5 +727,5 @@ static struct tst_test test = {
>  	.cleanup = cleanup,
>  	.test_all = run,
>  	.forks_child = 1,
> -	.max_runtime = 100,
> +	.max_runtime = 200,
>  };
> -- 
> 2.39.3
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
