Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ED58CE7AB8
	for <ltp@archiver.kernel.org>; Fri,  6 Sep 2024 08:02:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B06F83C1D6E
	for <ltp@archiver.kernel.org>; Fri,  6 Sep 2024 10:02:21 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8A2273C07AE
 for <ltp@lists.linux.it>; Fri,  6 Sep 2024 10:02:05 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 492021006088
 for <ltp@lists.linux.it>; Fri,  6 Sep 2024 10:02:03 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 43B8821AAC;
 Fri,  6 Sep 2024 08:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725609723;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DVb3IiRm+FSHbq2sk7ThqBrhfqulb2BuynE5kXDXM5k=;
 b=COcpiAuKdkrmHuSI3evd7Ut36eY1WxAa76f+R5hfI1RKzSyPaPnClZOPOtTQ21kWWBgFoj
 GQVr1MFUTBdVpuySxHDB53bRJmU/1XYFk3ixMClLaukdzQ/H1bM0jDQ+N3djS7/N0A5TPI
 6pbYwVoVOWwj1u8NfkblKrq/2IF1lt4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725609723;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DVb3IiRm+FSHbq2sk7ThqBrhfqulb2BuynE5kXDXM5k=;
 b=CwXlPXPaEp89DQpsQmD5KEux/VdCztin5VvxxNrvTcZUpEiMlzmIrdRxlHjIisKwFtHxXZ
 D2yuXY7zNyvoGEDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725609722;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DVb3IiRm+FSHbq2sk7ThqBrhfqulb2BuynE5kXDXM5k=;
 b=gNqgrTUmYAcAkWKuYrwFmMkbzhlcZ5YGtOnbTtcYZipfDdpeznMj0ZFnX9mI2QY2MsFHZv
 3clI4/UxXbeH44MTP7mAhFkx9PEpj7l9ycNtpEWZzdXnXZPAAa5pH9oqTjc6LKVwwo4PO7
 t7kdgfctzUNle8TEzXy6tiIL4GGgZj0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725609722;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DVb3IiRm+FSHbq2sk7ThqBrhfqulb2BuynE5kXDXM5k=;
 b=yGpJXjv22qg4sImATIv8uHzWeZ0TB0ZbPGc2ufMkeQe8zI+8wC5bdbueOJO6P1esxdb6nc
 ra0GIXqppWUBpwAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 041E3136A8;
 Fri,  6 Sep 2024 08:02:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cR85Ovm22mZ2PwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 06 Sep 2024 08:02:01 +0000
Date: Fri, 6 Sep 2024 10:02:00 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20240906080200.GA985598@pevik>
References: <20240905134502.33759-1-mdoucha@suse.cz>
 <20240905134502.33759-2-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240905134502.33759-2-mdoucha@suse.cz>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,suse.cz:replyto,suse.cz:email];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] fallocate05: Deallocate whole file on bcachefs
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
Cc: linux-bcachefs@vger.kernel.org, Kent Overstreet <kent.overstreet@linux.dev>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Martin, all,

[ Cc Kent and Bcachefs ML ]

> The default deallocation size is likely too small for bcachefs
> to actually release the blocks. Since it is also a copy-on-write
> filesystem, deallocated the whole file like on Btrfs.

Make sense.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---

> AFAICT Bcachefs uses 512 byte data blocks by default but 256KB inode
> blocks. The whole file will be 128KB and 32KB gets deallocated which may
> be too small. However, I'm not entirely sure whether this is the best
> solution.

> See also https://bugzilla.suse.com/show_bug.cgi?id=1230155

>  testcases/kernel/syscalls/fallocate/fallocate05.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

> diff --git a/testcases/kernel/syscalls/fallocate/fallocate05.c b/testcases/kernel/syscalls/fallocate/fallocate05.c
> index 979c70d6e..732a2f15d 100644
> --- a/testcases/kernel/syscalls/fallocate/fallocate05.c
> +++ b/testcases/kernel/syscalls/fallocate/fallocate05.c
> @@ -114,7 +114,8 @@ static void run(void)
>  	tst_res(TPASS, "fallocate() on full FS");

>  	/* Btrfs deallocates only complete extents, not individual blocks */
> -	if (!strcmp(tst_device->fs_type, "btrfs"))
> +	if (!strcmp(tst_device->fs_type, "btrfs") ||
> +		!strcmp(tst_device->fs_type, "bcachefs"))
>  		holesize = bufsize + extsize;
>  	else
>  		holesize = DEALLOCATE_BLOCKS * blocksize;

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
