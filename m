Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40672C10F1A
	for <ltp@archiver.kernel.org>; Tue,  7 May 2024 16:53:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C41E53CDDEE
	for <ltp@archiver.kernel.org>; Tue,  7 May 2024 18:53:20 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 90BBD3CDC8C
 for <ltp@lists.linux.it>; Tue,  7 May 2024 18:53:05 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 580F8215F19
 for <ltp@lists.linux.it>; Tue,  7 May 2024 18:53:03 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 86A333423D;
 Tue,  7 May 2024 16:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715100782;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ow/D9sT9ux8Dml9QVvVhC3uiAuy6FWZ8tmFqUAuI92E=;
 b=qEII1syDrLhm8V7zgbRxLgYyPlGYEHZQEVu8EOnPGxwSjmixc51wDMPO89qTUas5mWtP21
 h54UdYXHj1/37LzWUvjZDUiLhZuKlL7UmM0RnAue0nXqVns39GzeKWH2ulHgpUuqfDjJ43
 1lkVYJ+ch1Wq24dIJEjLXZ+jbe/cyO8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715100782;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ow/D9sT9ux8Dml9QVvVhC3uiAuy6FWZ8tmFqUAuI92E=;
 b=O5Antk7ePvNUhwHANuUm4E99lAZ3ZXpxQ3NhwF/EOUCusjH4p4xqnBRK9Cw4Z5A09cOAOT
 HTOdN00/KxLKBsCQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=qEII1syD;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=O5Antk7e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715100782;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ow/D9sT9ux8Dml9QVvVhC3uiAuy6FWZ8tmFqUAuI92E=;
 b=qEII1syDrLhm8V7zgbRxLgYyPlGYEHZQEVu8EOnPGxwSjmixc51wDMPO89qTUas5mWtP21
 h54UdYXHj1/37LzWUvjZDUiLhZuKlL7UmM0RnAue0nXqVns39GzeKWH2ulHgpUuqfDjJ43
 1lkVYJ+ch1Wq24dIJEjLXZ+jbe/cyO8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715100782;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ow/D9sT9ux8Dml9QVvVhC3uiAuy6FWZ8tmFqUAuI92E=;
 b=O5Antk7ePvNUhwHANuUm4E99lAZ3ZXpxQ3NhwF/EOUCusjH4p4xqnBRK9Cw4Z5A09cOAOT
 HTOdN00/KxLKBsCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 70855139CB;
 Tue,  7 May 2024 16:53:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id nhTXGW5cOmaZcQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 07 May 2024 16:53:02 +0000
Date: Tue, 7 May 2024 18:53:00 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <20240507165300.GA157588@pevik>
References: <20240429194821.9112-1-akumar@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240429194821.9112-1-akumar@suse.de>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 86A333423D
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCPT_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto];
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/mmap08: Use macro TST_EXP_FAIL_PTR_VOID()
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

Hi Avinesh,

> Signed-off-by: Avinesh Kumar <akumar@suse.de>
> ---
>  testcases/kernel/syscalls/mmap/mmap08.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)

> diff --git a/testcases/kernel/syscalls/mmap/mmap08.c b/testcases/kernel/syscalls/mmap/mmap08.c
> index 5c9fd782c..befd73e14 100644
> --- a/testcases/kernel/syscalls/mmap/mmap08.c
> +++ b/testcases/kernel/syscalls/mmap/mmap08.c
> @@ -27,16 +27,7 @@ static void setup(void)

>  static void run(void)
>  {
> -	TESTPTR(mmap(NULL, page_sz, PROT_WRITE, MAP_FILE | MAP_SHARED, fd, 0));
> -
> -	if (TST_RET_PTR != MAP_FAILED) {
> -		tst_res(TFAIL, "mmap() passed unexpectedly");
> -		SAFE_MUNMAP(TST_RET_PTR, page_sz);
> -	} else if (TST_ERR == EBADF) {
> -		tst_res(TPASS, "mmap() failed with EBADF");
> -	} else {
> -		tst_res(TFAIL | TERRNO, "mmap() failed with an invalid errno");
> -	}
> +	TST_EXP_FAIL_PTR_VOID(mmap(NULL, page_sz, PROT_WRITE, MAP_FILE | MAP_SHARED, fd, 0), EBADF);

Don't we need to add:
	if (TST_RET_PTR != MAP_FAILED) {
		SAFE_MUNMAP(TST_RET_PTR, page_sz);

Also, while at it, could you please change docs: "verify that" => "Verify that" ?

Kind regards,
Petr

>  }

>  static void cleanup(void)

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
