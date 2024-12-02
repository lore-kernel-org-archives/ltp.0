Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 628C9D78325
	for <ltp@archiver.kernel.org>; Mon,  2 Dec 2024 13:55:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EF6B03DD48C
	for <ltp@archiver.kernel.org>; Mon,  2 Dec 2024 14:55:30 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3D3513DD2F5
 for <ltp@lists.linux.it>; Mon,  2 Dec 2024 14:55:14 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B0FAC1B61629
 for <ltp@lists.linux.it>; Mon,  2 Dec 2024 14:55:13 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 035421F444;
 Mon,  2 Dec 2024 13:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733147713; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gY4Rh0VGSl4sLc4JxWXZkuj21kQYd5UEN0fkSIOsFRs=;
 b=hF65pDMlM16ZpzH0vxgcyqP5gBllHC0yvGNpAjbXc9+9yZnkl9LZpqAgw5YWfzZUiuiP6g
 Myk9hKPl590XRS/Qbzh36Ul1+Tqq7fjgpFBMINP2NE59IZLICmeSdP31dw+eB5rkOAA0a6
 GDK9LMXiOIUyS9eJm09/y0D7Msu5cI4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733147713;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gY4Rh0VGSl4sLc4JxWXZkuj21kQYd5UEN0fkSIOsFRs=;
 b=yg5qLYtXkw9L9m+mhl3cV432O590z9GPqDe6qiMz7TA0nDwpLc2Ekw4vnFJn7vmES92UX2
 qkT+TLjuT728NlCA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=hF65pDMl;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=yg5qLYtX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733147713; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gY4Rh0VGSl4sLc4JxWXZkuj21kQYd5UEN0fkSIOsFRs=;
 b=hF65pDMlM16ZpzH0vxgcyqP5gBllHC0yvGNpAjbXc9+9yZnkl9LZpqAgw5YWfzZUiuiP6g
 Myk9hKPl590XRS/Qbzh36Ul1+Tqq7fjgpFBMINP2NE59IZLICmeSdP31dw+eB5rkOAA0a6
 GDK9LMXiOIUyS9eJm09/y0D7Msu5cI4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733147713;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gY4Rh0VGSl4sLc4JxWXZkuj21kQYd5UEN0fkSIOsFRs=;
 b=yg5qLYtXkw9L9m+mhl3cV432O590z9GPqDe6qiMz7TA0nDwpLc2Ekw4vnFJn7vmES92UX2
 qkT+TLjuT728NlCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E72C5139C2;
 Mon,  2 Dec 2024 13:55:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hbGEN0C8TWfsEwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 02 Dec 2024 13:55:12 +0000
Date: Mon, 2 Dec 2024 14:55:19 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Zorro Lang <zlang@kernel.org>
Message-ID: <Z028RzZZQjF3pA4Q@yuki.lan>
References: <20241201093606.68993-1-zlang@kernel.org>
 <20241201093606.68993-4-zlang@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241201093606.68993-4-zlang@kernel.org>
X-Rspamd-Queue-Id: 035421F444
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] stat04+lstat03: skip test on btrfs
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
Cc: linux-btrfs@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> The "-b" option for mkfs.btrfs isn't a blocksize option, it does
> "specify the size of each device as seen by the filesystem" for
> btrfs. There's not an blocksize mkfs option for btrfs, so skip this
> test.
> 
> Signed-off-by: Zorro Lang <zlang@kernel.org>
> ---
>  testcases/kernel/syscalls/lstat/lstat03.c | 2 ++
>  testcases/kernel/syscalls/stat/stat04.c   | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/testcases/kernel/syscalls/lstat/lstat03.c b/testcases/kernel/syscalls/lstat/lstat03.c
> index 675fb56f4..f7346893d 100644
> --- a/testcases/kernel/syscalls/lstat/lstat03.c
> +++ b/testcases/kernel/syscalls/lstat/lstat03.c
> @@ -57,6 +57,8 @@ static void setup(void)
>  
>  	if (strcmp(tst_device->fs_type, "xfs") == 0)
>  		snprintf(opt_bsize, sizeof(opt_bsize), "size=%i", pagesize);
> +	else if (strcmp(tst_device->fs_type, "btrfs") == 0)
> +		tst_brk(TCONF, "btrfs is not supported");

This is overkill, all we need to skip on Btrfs is the st_blksize test.
We need to set a flag in the test setup and then skip the corresponding
TST_EXP_EXPR().

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
