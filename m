Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CEB5E9A03B
	for <ltp@archiver.kernel.org>; Thu, 19 Feb 2026 10:31:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 640813D072E
	for <ltp@archiver.kernel.org>; Thu, 19 Feb 2026 11:31:47 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 94A683D0680
 for <ltp@lists.linux.it>; Thu, 19 Feb 2026 11:31:27 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id EF068600565
 for <ltp@lists.linux.it>; Thu, 19 Feb 2026 11:31:26 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1C9DC5BCC2;
 Thu, 19 Feb 2026 10:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1771497086; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kFfBfrloghamYef1DhH53R4nVJRR+zwC6wiN9j9tyIM=;
 b=YHm0D1Xxti1MWs9JzL9AqwUjrkNB0SZ5BtUG5rOt2DTpzpYg1+723neWdr3NBpR0UemrpY
 ItiDQ+/+hCroHSDxTOjv0qR5SlCvWwrcFEu4i4G82dWqUNZA0umUTwudyKgDWdUPlwSPg9
 qh010qeIJm7XFctuNo7Wijh1v6q4etY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1771497086;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kFfBfrloghamYef1DhH53R4nVJRR+zwC6wiN9j9tyIM=;
 b=cEVfaA7ZDN8/pUDE5gQJF6eQ2HUx9IuJ0wY++nDzIfvRYoexxNEC99gRCfGDLHy0RzaRIG
 dwzwWF1jKpBMv9Bw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=YHm0D1Xx;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=cEVfaA7Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1771497086; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kFfBfrloghamYef1DhH53R4nVJRR+zwC6wiN9j9tyIM=;
 b=YHm0D1Xxti1MWs9JzL9AqwUjrkNB0SZ5BtUG5rOt2DTpzpYg1+723neWdr3NBpR0UemrpY
 ItiDQ+/+hCroHSDxTOjv0qR5SlCvWwrcFEu4i4G82dWqUNZA0umUTwudyKgDWdUPlwSPg9
 qh010qeIJm7XFctuNo7Wijh1v6q4etY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1771497086;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kFfBfrloghamYef1DhH53R4nVJRR+zwC6wiN9j9tyIM=;
 b=cEVfaA7ZDN8/pUDE5gQJF6eQ2HUx9IuJ0wY++nDzIfvRYoexxNEC99gRCfGDLHy0RzaRIG
 dwzwWF1jKpBMv9Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ED5E43EA65;
 Thu, 19 Feb 2026 10:31:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id k48WOX3mlmlhcAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 19 Feb 2026 10:31:25 +0000
Date: Thu, 19 Feb 2026 11:31:27 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Jinseok Kim <always.starving0@gmail.com>
Message-ID: <aZbmf5tEKC75gH7T@yuki.lan>
References: <20260211171627.11410-1-always.starving0@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260211171627.11410-1-always.starving0@gmail.com>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; FREEMAIL_TO(0.00)[gmail.com];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TAGGED_RCPT(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.cz:dkim, suse.cz:email, yuki.lan:mid]
X-Rspamd-Queue-Id: 1C9DC5BCC2
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] open: fix directory verification and misleading
 test description
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
> diff --git a/testcases/kernel/syscalls/open/open01.c b/testcases/kernel/syscalls/open/open01.c
> index baf73ab11..1355592e1 100644
> --- a/testcases/kernel/syscalls/open/open01.c
> +++ b/testcases/kernel/syscalls/open/open01.c
> @@ -37,7 +37,7 @@ static struct tcase {
>  	char *desc;
>  } tcases[] = {
>  	{TEST_FILE, O_RDWR | O_CREAT, 01444, S_ISVTX, "sticky bit"},
> -	{TEST_DIR, O_DIRECTORY, 0, S_IFDIR, "sirectory bit"}
> +	{TEST_DIR, O_DIRECTORY, 0, S_IFDIR, "directory"}
>  };
> 
>  static void verify_open(unsigned int n)
> @@ -53,11 +53,17 @@ static void verify_open(unsigned int n)
>  	fd = TST_RET;
> 
>  	SAFE_FSTAT(fd, &buf);
> -	if (!(buf.st_mode & tc->tst_bit))
> -		tst_res(TFAIL, "%s is cleared unexpectedly", tc->desc);
> -	else
> -		tst_res(TPASS, "%s is set as expected", tc->desc);
> -
> +	if (tc->tst_bit == S_ISVTX) {
> +		if (!(buf.st_mode & S_ISVTX))
> +			tst_res(TFAIL, "%s is cleared unexpectedly", tc->desc);
> +		else
> +			tst_res(TPASS, "%s is set as expected", tc->desc);
> +	} else if (tc->tst_bit == S_IFDIR) {
> +		if (!S_ISDIR(buf.st_mode))
> +			tst_res(TFAIL, "%s is not a directory", tc->desc);
> +		else
> +			tst_res(TPASS, "%s is a directory", tc->desc);
> +	}

Hmm, I guess that the check for S_ISDIR() is technically testing fstat()
since unlike the sticky bit case the directory is created in the test
setup.

I guess the cleaniest solutiont may be to add fstat test that would
check all kinds of modes. Looking at the headers there are at least:

- S_ISDIR
- S_ISCHR
- S_ISBLK
- S_ISREG
- S_ISFIFO
- S_ISLNK

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
