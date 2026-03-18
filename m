Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50C0B103E195
	for <ltp@archiver.kernel.org>; Wed, 18 Mar 2026 15:18:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E50DE3E6132
	for <ltp@archiver.kernel.org>; Wed, 18 Mar 2026 16:18:40 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B72713C940A
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 16:18:20 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3FDE01A007F6
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 16:18:19 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 38E4D5BEB4;
 Wed, 18 Mar 2026 15:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773847099;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kCoPGdoK/BJ6afLFdojIl/kxM3rlrdPSVbczVsLh1Sg=;
 b=MPNwIn/zwFWkY7Vhod0H837FNCuVZ6BMmWXxHKKqBUNKUIKpw/2mIF/Jv5RaRrnf5hPmxT
 UCXIwuGuf4cK3R+BCpU8ngTHJZhM46IwDyJY2+hJPmmZrgEK0AzIMYWjQUr6JCuNwSSplu
 GS9mhSPaVHocSGKkDNaeaJx9rvNAAqw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773847099;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kCoPGdoK/BJ6afLFdojIl/kxM3rlrdPSVbczVsLh1Sg=;
 b=j3Nvm7Hie9Hvhv3Cer1DBOeIu77DVJVY7kwu2YHesEiulXdCSQ5BnwhulznR/j8vf09ovL
 rTgPAa5NDLJQpFAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773847099;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kCoPGdoK/BJ6afLFdojIl/kxM3rlrdPSVbczVsLh1Sg=;
 b=MPNwIn/zwFWkY7Vhod0H837FNCuVZ6BMmWXxHKKqBUNKUIKpw/2mIF/Jv5RaRrnf5hPmxT
 UCXIwuGuf4cK3R+BCpU8ngTHJZhM46IwDyJY2+hJPmmZrgEK0AzIMYWjQUr6JCuNwSSplu
 GS9mhSPaVHocSGKkDNaeaJx9rvNAAqw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773847099;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kCoPGdoK/BJ6afLFdojIl/kxM3rlrdPSVbczVsLh1Sg=;
 b=j3Nvm7Hie9Hvhv3Cer1DBOeIu77DVJVY7kwu2YHesEiulXdCSQ5BnwhulznR/j8vf09ovL
 rTgPAa5NDLJQpFAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0234D4273B;
 Wed, 18 Mar 2026 15:18:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 94p/OTrCumkSGAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 18 Mar 2026 15:18:18 +0000
Date: Wed, 18 Mar 2026 16:18:17 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Jan Polensky <japo@linux.ibm.com>
Message-ID: <20260318151817.GC31214@pevik>
References: <20260318111306.98139-1-japo@linux.ibm.com>
 <20260318111306.98139-3-japo@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260318111306.98139-3-japo@linux.ibm.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 2/2] setxattr02: Adapt test for kernel 7.1.0+
 socket xattr support
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Jan,

> +static bool socket_xattr_supported;
> +
>  struct test_case {
>  	char *fname;
>  	char *key;
> @@ -57,7 +60,9 @@ struct test_case {
>  	int flags;
>  	int exp_err;
>  	int needskeyset;
> +	bool check_xattr;

Maybe more readable would be 'check_kver' (I can change it before merge).

>  };
> +
>  static struct test_case tc[] = {
>  	{			/* case 00, set attr to reg */
>  	 .fname = FILENAME,
> @@ -115,6 +120,7 @@ static struct test_case tc[] = {
>  	 .size = XATTR_TEST_VALUE_SIZE,
>  	 .flags = XATTR_CREATE,
>  	 .exp_err = EPERM,
> +	 .check_xattr = true,
>  	 },
>  };

> @@ -126,6 +132,9 @@ static void verify_setxattr(unsigned int i)
>  				XATTR_CREATE);
>  	}

> +	if (tc[i].check_xattr && socket_xattr_supported)
> +		tc[i].exp_err = 0;
> +
>  	TEST(setxattr(tc[i].fname, tc[i].key, tc[i].value, tc[i].size,
>  			tc[i].flags));

> @@ -185,6 +194,8 @@ static void setup(void)
>  	SAFE_MKNOD(CHR, S_IFCHR | 0777, dev);
>  	SAFE_MKNOD(BLK, S_IFBLK | 0777, 0);
>  	SAFE_MKNOD(SOCK, S_IFSOCK | 0777, 0);
> +
> +	socket_xattr_supported = (tst_kvercmp(7, 1, 0) >= 0);

Brackets are not needed (not a mistake, but I'll remove it before merge).

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
