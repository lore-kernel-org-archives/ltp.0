Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3E8EC4345F
	for <ltp@archiver.kernel.org>; Thu, 11 Apr 2024 15:38:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1080B3CF85A
	for <ltp@archiver.kernel.org>; Thu, 11 Apr 2024 17:38:15 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 93D263C6DA3
 for <ltp@lists.linux.it>; Thu, 11 Apr 2024 17:37:58 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A9EE461337F
 for <ltp@lists.linux.it>; Thu, 11 Apr 2024 17:37:57 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D27605D145;
 Thu, 11 Apr 2024 15:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712849876; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KWnYZUKZC/xHPQO+sKVgLbiujXGtXaioBJ87BtJiRAc=;
 b=GxpDt2VJ79xkdbtqBnM72ReGu+iGtbRPDMn+fXBP1nKKbpLjC7HcaKOZm5W5WlGq/3wUzR
 ScolZ6MRR+mwa67HHQ+fg2+4G8CzQK3SSW/36dHhDKKSfWq1SwWCfAx5itWgXCopSju0U5
 +ga62zpj3IBUXRtOO3v2AQnTz93nXPI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712849876;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KWnYZUKZC/xHPQO+sKVgLbiujXGtXaioBJ87BtJiRAc=;
 b=FoPVgKOme1tqsbbeYHsf6Zs908aa44a//O1tZntTgQtFV3KRlhI+bg5EAQUh4bkli9zgk6
 itIPXUtKkMU6i6Cg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712849875; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KWnYZUKZC/xHPQO+sKVgLbiujXGtXaioBJ87BtJiRAc=;
 b=AIU9kobX0fvyq0gqsMCvhjY0uismbHIv84LlnIzS8uR//sX3KzRoM1C4WZZaFY64zSROCj
 2pDBpUpJdwxokNlisOr2vJ5THQLDywmZ/DdPIMvvrh0Wid06SkR+oI3Z+mvGbdvCptqB4K
 DTWBqqtCfdlnmKHj8AI+1o855x9ucM4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712849875;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KWnYZUKZC/xHPQO+sKVgLbiujXGtXaioBJ87BtJiRAc=;
 b=eNUbzgQTQ1L40MBCzRr5AOcu59QDarVm2sttTX+XWX+1ShZ4Xic0Yo2H/5G5xtWVlnWeEX
 HQEYRgzeOfps4qDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C3D0B1368B;
 Thu, 11 Apr 2024 15:37:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id fPC5LdMDGGb0XgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 11 Apr 2024 15:37:55 +0000
Date: Thu, 11 Apr 2024 17:37:01 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZhgDnR6A9oMjOr0w@yuki>
References: <20240411143025.352507-1-pvorel@suse.cz>
 <20240411143025.352507-15-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240411143025.352507-15-pvorel@suse.cz>
X-Spamd-Result: default: False [-7.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 14/31] madvise02: Remove UCLINUX
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
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/kernel/syscalls/madvise/madvise02.c | 25 ++++++++-----------
>  1 file changed, 11 insertions(+), 14 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/madvise/madvise02.c b/testcases/kernel/syscalls/madvise/madvise02.c
> index 90c0431c5..793bda98d 100644
> --- a/testcases/kernel/syscalls/madvise/madvise02.c
> +++ b/testcases/kernel/syscalls/madvise/madvise02.c
> @@ -65,17 +65,17 @@ static struct tcase {
>  	int exp_errno;
>  	int skip;
>  } tcases[] = {
> -	{MADV_NORMAL,      "MADV_NORMAL",      &nonalign, EINVAL, 0},
> -	{1212,             "MADV_NORMAL",      &file1,    EINVAL, 0},
> -	{MADV_REMOVE,      "MADV_REMOVE",      &file1,    EINVAL, 0},
> -	{MADV_DONTNEED,    "MADV_DONTNEED",    &file1,    EINVAL, 1},
> -	{MADV_MERGEABLE,   "MADV_MERGEABLE",   &file1,    EINVAL, 0},
> -	{MADV_UNMERGEABLE, "MADV_UNMERGEABLE", &file1,    EINVAL, 0},
> -	{MADV_NORMAL,      "MADV_NORMAL",      &file2,    ENOMEM, 0},
> -	{MADV_WILLNEED,    "MADV_WILLNEED",    &file2,    ENOMEM, 0},
> -	{MADV_WILLNEED,    "MADV_WILLNEED",    &tmp_addr,  EBADF, 0},
> -	{MADV_FREE,        "MADV_FREE",        &file1,    EINVAL, 0},
> -	{MADV_WIPEONFORK,  "MADV_WIPEONFORK",  &file1,    EINVAL, 0},
> +	{MADV_NORMAL,      "MADV_NORMAL",      &nonalign, EINVAL},
> +	{1212,             "MADV_NORMAL",      &file1,    EINVAL},
> +	{MADV_REMOVE,      "MADV_REMOVE",      &file1,    EINVAL},
> +	{MADV_DONTNEED,    "MADV_DONTNEED",    &file1,    EINVAL},
> +	{MADV_MERGEABLE,   "MADV_MERGEABLE",   &file1,    EINVAL},
> +	{MADV_UNMERGEABLE, "MADV_UNMERGEABLE", &file1,    EINVAL},
> +	{MADV_NORMAL,      "MADV_NORMAL",      &file2,    ENOMEM},
> +	{MADV_WILLNEED,    "MADV_WILLNEED",    &file2,    ENOMEM},
> +	{MADV_WILLNEED,    "MADV_WILLNEED",    &tmp_addr,  EBADF},
> +	{MADV_FREE,        "MADV_FREE",        &file1,    EINVAL},
> +	{MADV_WIPEONFORK,  "MADV_WIPEONFORK",  &file1,    EINVAL},
>  	{MADV_WIPEONFORK,  "MADV_WIPEONFORK shared_anon", &shared_anon, EINVAL, 0},
>  	{MADV_WIPEONFORK,  "MADV_WIPEONFORK private file backed", &file3, EINVAL, 0},

You should have removed these two zeroes as well, it's a bit confusing
that they stayed in there.

>  };
> @@ -89,11 +89,8 @@ static void tcases_filter(void)
>  
>  		switch (tc->advice) {
>  		case MADV_DONTNEED:
> -#if !defined(UCLINUX)
>  			if (mlock(file1, st.st_size) < 0)
>  				tst_brk(TBROK | TERRNO, "mlock failed");
> -			tc->skip = 0;
> -#endif /* if !defined(UCLINUX) */
>  		break;
>  		case MADV_MERGEABLE:
>  		case MADV_UNMERGEABLE:
> -- 
> 2.43.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
