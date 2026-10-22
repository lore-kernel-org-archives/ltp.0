Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BFA606A31A
	for <ltp@archiver.kernel.org>; Thu, 22 Oct 2026 15:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=chXpIbyU;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=D1aQidOM;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=chXpIbyU;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=D1aQidOM
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CEE0B3E21D0
	for <ltp@archiver.kernel.org>; Thu, 22 Oct 2026 17:26:02 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8E4873D266C
 for <ltp@lists.linux.it>; Thu, 22 Oct 2026 17:25:45 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 52B49140122A
 for <ltp@lists.linux.it>; Thu, 22 Oct 2026 17:25:44 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 115861F769;
 Thu, 22 Oct 2026 15:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1792682744;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AkTUgWxly/D17UkJi5aiHSpsgfSOl8UJCkEE/rBv7nY=;
 b=chXpIbyU50vXJo3uObtx9ZEKnEH8YqJ70oO0CjNZM7pF9Q6BySUpmIjSJ3BmXCQ+ZHMtM4
 znGIace6dckh41m3H0P/efz/MJhSnekV3c8FIDY9EqiilFBH8nohv1q9nQaKEP9Aof9Z1x
 chlSOh0VB35pCvPc3zNnNNv+h+eD3kY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1792682744;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AkTUgWxly/D17UkJi5aiHSpsgfSOl8UJCkEE/rBv7nY=;
 b=D1aQidOMXytw+mTDrNPbxBBCs1HDdisr4dgZ7DWsyJbRcmV/khBnwy7Z5/jz8cQHkTDbPl
 ECJ3LfNo0VIZWVDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1792682744;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AkTUgWxly/D17UkJi5aiHSpsgfSOl8UJCkEE/rBv7nY=;
 b=chXpIbyU50vXJo3uObtx9ZEKnEH8YqJ70oO0CjNZM7pF9Q6BySUpmIjSJ3BmXCQ+ZHMtM4
 znGIace6dckh41m3H0P/efz/MJhSnekV3c8FIDY9EqiilFBH8nohv1q9nQaKEP9Aof9Z1x
 chlSOh0VB35pCvPc3zNnNNv+h+eD3kY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1792682744;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AkTUgWxly/D17UkJi5aiHSpsgfSOl8UJCkEE/rBv7nY=;
 b=D1aQidOMXytw+mTDrNPbxBBCs1HDdisr4dgZ7DWsyJbRcmV/khBnwy7Z5/jz8cQHkTDbPl
 ECJ3LfNo0VIZWVDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9B8DE134E6;
 Thu, 22 Oct 2026 15:25:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id pw0mGPcq2mqeZQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 22 Oct 2026 15:25:43 +0000
Date: Thu, 22 Oct 2026 17:25:42 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20261022152542.GA405225@pevik>
References: <20261022022824.19735-1-wegao@suse.com>
 <20261022022824.19735-2-wegao@suse.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261022022824.19735-2-wegao@suse.com>
X-Spamd-Result: default: False [-16.50 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 REPLY(-4.00)[]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Spam-Score: -16.50
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v16 1/2] lib: New library function tst_get_free_uid
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: Martin Doucha <martin.doucha@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei,

> +uid_t tst_get_free_uid_(const char *file, const int lineno, uid_t skip);
> +
> +/**
> + * tst_get_free_uid() - Find a UID not assigned to any user.
> + * @skip: UID value to skip (pass 0 to skip none).
> + *
> + * Scans the password database for the first unused UID starting
> + * from 1, skipping @skip. Calls tst_brk(TBROK) if no free UID
> + * is found or a lookup error occurs.
> + *
> + * Return: An unused uid_t value.
> + */
> +#define tst_get_free_uid(skip) tst_get_free_uid_(__FILE__, __LINE__, (skip))
> +
>  /*
>   * Find unassigned gid. The skip argument can be used to ignore e.g. the main
>   * group of a specific user in case it's not listed in the group file. If you
> diff --git a/lib/tst_uid.c b/lib/tst_uid.c
> index b0b087362..47c267bc4 100644
> --- a/lib/tst_uid.c
> +++ b/lib/tst_uid.c
> @@ -5,6 +5,7 @@

>  #include <sys/types.h>
>  #include <grp.h>
> +#include <pwd.h>
>  #include <errno.h>

>  #define TST_NO_DEFAULT_MAIN
> @@ -12,6 +13,33 @@
>  #include "tst_uid.h"

>  #define MAX_GID 32767
> +#define MAX_UID 32767
> +
> +uid_t tst_get_free_uid_(const char *file, const int lineno, uid_t skip)
> +{
> +	uid_t ret;
> +
> +	for (ret = 1; ret < MAX_UID; ret++) {
> +		if (ret == skip)
> +			continue;
> +
> +		errno = 0;
> +		if (getpwuid(ret))
> +			continue;


If you don't mind I'd prefer to use the same approach which is on
tst_get_free_gid_(), e.g. set errno first:

	errno = 0;

	for (ret = 1; ret < MAX_UID; ret++) {
		if (ret == skip || getpwuid(ret))
			continue;

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Other than that LGTM.

Cc Martin in case he wants to add his ack before I merge.

Kind regards,
Petr

> +
> +		if (errno == 0 || errno == ENOENT || errno == ESRCH) {
> +			tst_res_(file, lineno, TINFO,
> +				"Found unused UID %d", (int)ret);
> +			return ret;
> +		}
> +
> +		tst_brk_(file, lineno, TBROK | TERRNO, "User ID lookup failed");
> +		return (uid_t)-1;
> +	}
> +
> +	tst_brk_(file, lineno, TBROK, "No free user ID found");
> +	return (uid_t)-1;
> +}

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
