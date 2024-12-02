Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E8D3D78325
	for <ltp@archiver.kernel.org>; Mon,  2 Dec 2024 13:57:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B8AC03DD48C
	for <ltp@archiver.kernel.org>; Mon,  2 Dec 2024 14:57:00 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D05493DD2F5
 for <ltp@lists.linux.it>; Mon,  2 Dec 2024 14:56:44 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BAFF220B9FE
 for <ltp@lists.linux.it>; Mon,  2 Dec 2024 14:56:43 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E1F8D210F3;
 Mon,  2 Dec 2024 13:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733147803; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l4WfR09OY8xmZ0o4t2VTtbF0smwjYpaMUDMHETZqydg=;
 b=wXpNckGY4IWQoerjUm0PoBaovV+jV6pfZuJNydRIwJrLs8cnVqCEhTTyFHKFRpgXzDCwDt
 2deHD/i2w/c9CCXn9zG9Jg8WIL84ZyHMb0JXuZ363/UnBC/kwqTO3QkIkz2Mzh7cG4RsXH
 tbBu0FyHe5Y4vOTYJCEwctA4aVZay2s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733147803;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l4WfR09OY8xmZ0o4t2VTtbF0smwjYpaMUDMHETZqydg=;
 b=s8G/QM0ay4m0WNbSa4eP56FiDQOPZxKqQJB3Now9tWQsXkHbcNPCfjrQYw4ac66sculyUI
 kMSPLAjlNg/2EXBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733147802; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l4WfR09OY8xmZ0o4t2VTtbF0smwjYpaMUDMHETZqydg=;
 b=aMm1J0dbQagT+jL037gEyVZ/4Uuso7d4Bk/+yCNopxiZrGkKq2xbDTNuztN1+0z4G6suOV
 HUiaGwonGgKoyCiW1Ga01brQWW7VOzZw3V7Oe54sL4c5TFG5LVF2An9SBEoWYj6I8Vsnzm
 gHNvIXZxU/xu1yhnGeQhtVQfFtPvlaI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733147802;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l4WfR09OY8xmZ0o4t2VTtbF0smwjYpaMUDMHETZqydg=;
 b=vpALBTSDlSehW6F2qrDD/8AZkj9O149rQnmqfix4UTgniLcImwI5HeUcOGy6aET3medKvT
 TDF/breNsQf3EuAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D2CF3139C2;
 Mon,  2 Dec 2024 13:56:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id fq1+Mpq8TWd/FAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 02 Dec 2024 13:56:42 +0000
Date: Mon, 2 Dec 2024 14:56:57 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Zorro Lang <zlang@kernel.org>
Message-ID: <Z028qctN4vFrfUzx@yuki.lan>
References: <20241201093606.68993-1-zlang@kernel.org>
 <20241201093606.68993-3-zlang@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241201093606.68993-3-zlang@kernel.org>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] stat04+lstat03: fix bad blocksize mkfs option
 for xfs
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
> Not all filesystems use "-b 1024" to set its blocksize. XFS uses
> "-b size=1024", so this test fails as "unknown option -b 1024" on
> xfs.
> 
> Signed-off-by: Zorro Lang <zlang@kernel.org>
> ---
>  testcases/kernel/syscalls/lstat/lstat03.c | 8 ++++++--
>  testcases/kernel/syscalls/stat/stat04.c   | 8 ++++++--
>  2 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/lstat/lstat03.c b/testcases/kernel/syscalls/lstat/lstat03.c
> index d48af180b..675fb56f4 100644
> --- a/testcases/kernel/syscalls/lstat/lstat03.c
> +++ b/testcases/kernel/syscalls/lstat/lstat03.c
> @@ -44,8 +44,9 @@ static void run(void)
>  
>  static void setup(void)
>  {
> +	char *opt_name="-b";
>  	char opt_bsize[32];
> -	const char *const fs_opts[] = {opt_bsize, NULL};
> +	const char *const fs_opts[] = {opt_name, opt_bsize, NULL};
                                       ^
				       You can just add "-b" here
				       instead of creating a variable.

>  	struct stat sb;
>  	int pagesize;
>  	int fd;
> @@ -54,7 +55,10 @@ static void setup(void)
>  	SAFE_STAT(".", &sb);
>  	pagesize = sb.st_blksize == 4096 ? 1024 : 4096;
>  
> -	snprintf(opt_bsize, sizeof(opt_bsize), "-b %i", pagesize);
> +	if (strcmp(tst_device->fs_type, "xfs") == 0)
          ^
	  The more common style is if (!strcmp(...))
> +		snprintf(opt_bsize, sizeof(opt_bsize), "size=%i", pagesize);
> +	else
> +		snprintf(opt_bsize, sizeof(opt_bsize), "%i", pagesize);

Otherwise it looks good.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
