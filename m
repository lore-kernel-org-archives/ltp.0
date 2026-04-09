Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03A78E98FB7
	for <ltp@archiver.kernel.org>; Thu,  9 Apr 2026 13:35:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 86FB03E4F18
	for <ltp@archiver.kernel.org>; Thu,  9 Apr 2026 15:35:39 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 211EC3E4CFE
 for <ltp@lists.linux.it>; Thu,  9 Apr 2026 15:35:18 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6C789602F50
 for <ltp@lists.linux.it>; Thu,  9 Apr 2026 15:35:18 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EB0F66A7C2
 for <ltp@lists.linux.it>; Thu,  9 Apr 2026 13:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775741717; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oVh3t0ToxB9X+HaMr7pxy7FjIsMjaARVJzDjQFF1UsE=;
 b=vPQC11eNSrwaNNNE5fM6MvFIWi6YPd6IuCQcwQNbaBOl6KxkVBum3NE8IRASHSaQTWLRrQ
 WkGLAwXp+WR6BfEprmNkKSIncINWK9OFHJ+cQjIX/2tRXdLvsZQLE37ETJB3GaIpLsoCSZ
 bTPpxp0wZQ01ZNujuTiAypwMi/51q2w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775741717;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oVh3t0ToxB9X+HaMr7pxy7FjIsMjaARVJzDjQFF1UsE=;
 b=F4UWmlFptj/40W1xRQoh3ncxOGELY/x1PpejN//ZgMRtgo5ValjLWkOTC7ap91wTybruCo
 12MMzQ98qJlHTZCA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=T8W2rZc+;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=AShJiQrx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775741716; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oVh3t0ToxB9X+HaMr7pxy7FjIsMjaARVJzDjQFF1UsE=;
 b=T8W2rZc+BSA1wa20W+sXKKLNEKW5avG6afA7yoP6xzLW2tuXRRmcHPzT3idMwYmDtYDN+P
 bro03Eazc/DXV9YSPIPOuFdcP9SWut0VcsKnUNS7SMWwA0fo82F0mFhAUYmrCiCOv7Trnm
 KFeFKOdCq2sLS/t1la+V26O5b86z7WU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775741716;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oVh3t0ToxB9X+HaMr7pxy7FjIsMjaARVJzDjQFF1UsE=;
 b=AShJiQrx/R0jEgzQaqow3KXqyEWubjDGcVMOsv46Ls45bNoYNOG2CMkpR+IaPoyR6KvFfP
 VVzeTPynJRudb7DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DBD494A0B3
 for <ltp@lists.linux.it>; Thu,  9 Apr 2026 13:35:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id BZHBNBSr12m8RwAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 09 Apr 2026 13:35:16 +0000
Date: Thu, 9 Apr 2026 15:35:28 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Message-ID: <aderIKSVgzrb_hFR@yuki.lan>
References: <20260409103041.8253-1-chrubis@suse.cz>
 <20260409103041.8253-2-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260409103041.8253-2-chrubis@suse.cz>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; RCPT_COUNT_ONE(0.00)[1]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 TO_DN_NONE(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim, suse.cz:email,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Queue-Id: EB0F66A7C2
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] lib: safe_file_ops: Add SAFE_FILE_READ_STR()
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> diff --git a/lib/safe_file_ops.c b/lib/safe_file_ops.c
> index 8314c4b1b..2d163c0af 100644
> --- a/lib/safe_file_ops.c
> +++ b/lib/safe_file_ops.c
> @@ -160,6 +160,30 @@ void safe_file_scanf(const char *file, const int lineno,
>  	}
>  }
>  
> +void safe_file_read_str(const char *file, const int lineno,
> +                        const char *path, char *buf, size_t buf_size)
> +{
> +	FILE *f;
> +
> +	f = fopen(path, "r");
> +	if (!f) {
> +		tst_brkm_(file, lineno, TBROK | TERRNO, NULL,
> +		          "Failed to open FILE '%s' for reading", path);

We need a return; here in an unlikely case that someone would call this
from a test cleanup() callback.

> +	}
> +
> +	if (!fgets(buf, buf_size, f))
> +		buf[0] = 0;
> +
> +	size_t len = strlen(buf);
> +
> +	if (len && buf[len-1] == '\n')
> +		buf[len-1] = 0;
> +
> +	if (fclose(f)) {
> +		tst_brkm_(file, lineno, TBROK | TERRNO, NULL,
> +			"Failed to close FILE '%s'", path);
> +	}
> +}
>  
>  /*
>   * Try to parse each line from file specified by 'path' according
> -- 
> 2.52.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
