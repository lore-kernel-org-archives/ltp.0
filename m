Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D39DC5CFDB
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 11:46:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EE4E73E6C1D
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 13:46:42 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 224F03D9E8C
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 13:46:28 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 949BD60080D
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 13:46:27 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 19E613E83;
 Thu, 13 Aug 2026 11:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786621582; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A1yQ+63HyMR2lIScsAXWoQ1Bkc5FPg5poAbDNPsS0EM=;
 b=ESvZi95OkMZsDFu7EgNIJkPDnis1t9yAG8FjcSMf90ejWXTL0MPFAjeJZUyotJnn72f6lR
 8hc3513Xs6Fg3dHHgNZBZGnDpog120GneoC+9F6Yb8vNWKqlCr+ez5zt46rdELxcIXrpu9
 jAeXvtETmwD01jOQxFcFnJ76PGLHVSo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786621582;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A1yQ+63HyMR2lIScsAXWoQ1Bkc5FPg5poAbDNPsS0EM=;
 b=nMl1c1wz6WuAcKbmJK9ugYaxwtvKI4MTRQGDnx3om/bytDqHhOxJKE4ofz9z4UyW0xn+M6
 J205ohNBn+ox0gBQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=V1STqiG4;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=T+Bn++UE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786621578; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A1yQ+63HyMR2lIScsAXWoQ1Bkc5FPg5poAbDNPsS0EM=;
 b=V1STqiG4CRwk0hSzI7L/Zq+t74uptKSzUYjruuPspg2122u898SZ06roVA+fQL6Hypg2Nd
 licRtvvtuzXD/FGKiWQRCZ6vX6CyQ9ebWzy92JZTV6SkBO69RNbf9OyDTd6bqLdjUl9dhr
 FWml0vwapArMIBq2yDENByB0IyMAuMI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786621578;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A1yQ+63HyMR2lIScsAXWoQ1Bkc5FPg5poAbDNPsS0EM=;
 b=T+Bn++UEfPyapSfwlLZblETRpY/CzZ4gcoeuQe6+s08wa0NBXVUi0ZoRA3La9eWYyjJ4p9
 zVjrW7G/9ZQQDjBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0873277DD4;
 Thu, 13 Aug 2026 11:46:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id i/nZAIqufWofKQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 13 Aug 2026 11:46:18 +0000
Date: Thu, 13 Aug 2026 13:46:20 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <an2ujOLYL0g1WyEX@yuki.lan>
References: <an2Gs6ztBU20B2Ik@yuki.lan>
 <6a7da094.a02854e2.9191a.a277@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a7da094.a02854e2.9191a.a277@mx.google.com>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 19E613E83
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MISSING_XM_UA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 URIBL_BLOCKED(0.00)[suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] refluxfs: Check kernel reflink support before
 mount
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
> Something like this?
>
> diff --git a/lib/safe_macros.c b/lib/safe_macros.c
> index f95c5fdc5..34430d018 100644
> --- a/lib/safe_macros.c
> +++ b/lib/safe_macros.c
> @@ -993,9 +993,15 @@ int safe_mount(const char *file, const int lineno, void (*cleanup_fn)(void),
>  			"mount.%s failed with %i", filesystemtype, rval);
>  		return -1;
>  	} else if (rval == -1) {
> -		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
> -			"mount(%s, %s, %s, %lu, %p) failed", source, target,
> -			filesystemtype, mountflags, data);
> +		if (errno == EOPNOTSUPP) {
> +			tst_brkm_(file, lineno, TCONF | TERRNO, cleanup_fn,
> +				"mount(%s, %s, %s, %lu, %p) failed with EOPNOTSUPP", source, target,
> +				filesystemtype, mountflags, data);
> +		} else {
> +			tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
> +				"mount(%s, %s, %s, %lu, %p) failed", source, target,
> +				filesystemtype, mountflags, data);
> +		}
>  	} else {
>  		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
>  			"Invalid mount(%s, %s, %s, %lu, %p) return value %d",
> diff --git a/testcases/kernel/syscalls/file_attr/file_attr02.c b/testcases/kernel/syscalls/file_attr/file_attr02.c
> index f6625985a..28c1c7ca6 100644
> --- a/testcases/kernel/syscalls/file_attr/file_attr02.c
> +++ b/testcases/kernel/syscalls/file_attr/file_attr02.c
> @@ -45,13 +45,7 @@ static void setup(void)
>  	struct stat statbuf;
>  
>  	SAFE_MKDIR(MNTPOINT, 0755);
> -	TEST(mount(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, NULL));
> -
> -	if (TST_RET == -1 && TST_ERR == EOPNOTSUPP)
> -		tst_brk(TCONF, "Kernel does not support XFS reflinks");
> -
> -	if (TST_RET)
> -		tst_brk(TBROK | TTERRNO, "Mount failed");
> +	SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, NULL);
>  
>  	SAFE_STAT(MNTPOINT, &statbuf);

Yes. If we do not do this we are going to open code the check over and
over.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
