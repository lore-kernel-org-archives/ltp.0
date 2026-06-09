Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C5E0CD6E79
	for <ltp@archiver.kernel.org>; Tue,  9 Jun 2026 09:19:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 650DC3E5EA7
	for <ltp@archiver.kernel.org>; Tue,  9 Jun 2026 11:19:38 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 904E73C1ACE
 for <ltp@lists.linux.it>; Tue,  9 Jun 2026 11:19:22 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 25E93600721
 for <ltp@lists.linux.it>; Tue,  9 Jun 2026 11:19:21 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7BFBD6A821;
 Tue,  9 Jun 2026 09:19:21 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A46E779A7;
 Tue,  9 Jun 2026 09:19:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id TSOgF5naJ2paFwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 09 Jun 2026 09:19:21 +0000
Date: Tue, 9 Jun 2026 11:19:19 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Jan Polensky <japo@linux.ibm.com>
Message-ID: <aifalyMdDVoFT3Tg@yuki.lan>
References: <20260608155241.270875-1-japo@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260608155241.270875-1-japo@linux.ibm.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 7BFBD6A821
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 1/1] swap: Add exfat to filesystems requiring
 tst_fill_file
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
> exfat, like XFS, requires actual data writes (not just fallocate) to
> fully allocate swap files. Without this, swapon(2) fails with EINVAL
> due to unallocated extents.
> 
> This matches the kernel's requirement that swap files must be fully
> allocated before activation.
> 
> Signed-off-by: Jan Polensky <japo@linux.ibm.com>
> ---
>  libs/swap/tse_swap.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/libs/swap/tse_swap.c b/libs/swap/tse_swap.c
> index ae3c193132e6..e321cb1dfe63 100644
> --- a/libs/swap/tse_swap.c
> +++ b/libs/swap/tse_swap.c
> @@ -177,8 +177,9 @@ int make_swapfile(const char *file, const int lineno,
>  	if (prealloc_contiguous_file(swapfile, blk_size, blocks) != 0)
>  		tst_brk_(file, lineno, TBROK, "Failed to create swapfile");
>  
> -	/* Fill the file if needed (specific to old xfs filesystems) */
> -	if (tst_fs_type(swapfile) == TST_XFS_MAGIC) {
> +	/* Fill the file if needed (specific to xfs and exfat filesystems) */
> +	long fs_type = tst_fs_type(swapfile);
> +	if (fs_type == TST_XFS_MAGIC || fs_type == TST_EXFAT_MAGIC) {
>  		if (tst_fill_file(swapfile, 0, blk_size, blocks) != 0)
>  			tst_brk_(file, lineno, TBROK, "Failed to fill swapfile");
>  	}

The swapon01 works for me for exfat without this change. Where does this
fail (arch, kernel, OS, is exfat in kernel or FUSE, etc.)?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
