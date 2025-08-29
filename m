Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5BA4CA0FF9
	for <ltp@archiver.kernel.org>; Fri, 29 Aug 2025 12:58:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 56D5B3CD182
	for <ltp@archiver.kernel.org>; Fri, 29 Aug 2025 14:58:47 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5BE4E3CCD37
 for <ltp@lists.linux.it>; Fri, 29 Aug 2025 14:58:30 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 632371A00708
 for <ltp@lists.linux.it>; Fri, 29 Aug 2025 14:58:27 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D96AF33E3B;
 Fri, 29 Aug 2025 12:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1756472307; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FdFxOMoqlrJysIYNIrzH/gDTys9cPu6DsNkzIOBrPB0=;
 b=qTnVybYH5ICMN4T1OYGY7Vp4YcQyfbANYK/TWBLY83AEU/HTASv6nGK7HuOqLNqxaMNUbC
 AEnBEzKACXbjWw8hkLrRGexLekE5cZOoeUD8BCg8X8pfRbtgDZf1pvAX7unN7Ky2H0/lWW
 LuYVD6/uw59GQVOzD0Z6K2dDcRv7bpg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1756472307;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FdFxOMoqlrJysIYNIrzH/gDTys9cPu6DsNkzIOBrPB0=;
 b=+3UptHdEcsovefWpLW/imun0nDDFZ6wH6HM6OyUoDpdsgV1ObKP6sb90dtqwtkC2DhPAQV
 q3VzSMle1Yoz5uAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1756472306; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FdFxOMoqlrJysIYNIrzH/gDTys9cPu6DsNkzIOBrPB0=;
 b=lpDmrIbPJq5vjTDDQ0jisKWacV7wtOzMcxGFgXEWC8LlVEqYpPdENwcS3F/aFb7Wz5UdEY
 hdgxxeVrntp+bKrlsyKHrH/JBFVV6SdFbIVkCruLpSy3tVj5a5TypcmT6WSrhnfQ72iuaq
 wGj/QeIGECagZyxv5e9SbeawkniYEVE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1756472306;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FdFxOMoqlrJysIYNIrzH/gDTys9cPu6DsNkzIOBrPB0=;
 b=vJtVrc2NZtSRen1yWasXwYQuFQEpgExL67LJZ9WcorDztbiWVCBSRcqWxIvOeelkNQJcHi
 Hf2n0o29jVZwA9DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C946913326;
 Fri, 29 Aug 2025 12:58:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7WRfMPKjsWiUdQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 29 Aug 2025 12:58:26 +0000
Date: Fri, 29 Aug 2025 14:58:25 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <aLGj8cPaTPFiUQQE@rei.lan>
References: <20250828-open_tree_attr-v1-0-f339a0e51e22@suse.com>
 <20250828-open_tree_attr-v1-2-f339a0e51e22@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250828-open_tree_attr-v1-2-f339a0e51e22@suse.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[rei.lan:mid,linux.it:url,imap1.dmz-prg2.suse.org:helo,suse.cz:email];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, imap1.dmz-prg2.suse.org:helo,
 linux.it:url]
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] mount_setattr01: add open_tree_attr variant
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
>  /*\
> - * Basic mount_setattr() test.
> + * Basic mount_setattr()/open_tree_attr() test.
>   * Test whether the basic mount attributes are set correctly.
>   *
>   * Verify some MOUNT_SETATTR(2) attributes:
> @@ -22,7 +23,8 @@
>   * - MOUNT_ATTR_NODIRATIME - prevents updating access time for
>   *   directories on this mount
>   *
> - * The functionality was added in v5.12.
> + * The mount_setattr functionality was added in v5.12, while the open_tree_attr
> + * functionality was added in v6.15.
>   */
>  
>  #define _GNU_SOURCE
> @@ -41,6 +43,7 @@
>  	}
>  
>  static int mount_flag, otfd = -1;
> +struct mount_attr *attr;
>  
>  static struct tcase {
>  	char *name;
> @@ -66,35 +69,59 @@ static void cleanup(void)
>  static void setup(void)
>  {
>  	fsopen_supported_by_kernel();
> -	struct stat st = {0};
>  
> -	if (stat(OT_MNTPOINT, &st) == -1)
> +	if (access(OT_MNTPOINT, F_OK) != 0)
>  		SAFE_MKDIR(OT_MNTPOINT, 0777);
>  }
>  
> +static int open_tree_variant1(struct mount_attr *attr)
> +{
> +	tst_res(TINFO, "Variant using open_tree() + mount_setattr()");
> +
> +	otfd = TST_EXP_FD(open_tree(AT_FDCWD, MNTPOINT,
> +			AT_EMPTY_PATH | OPEN_TREE_CLONE));
> +	if (otfd == -1)
> +		return -1;
> +
> +	TST_EXP_PASS(mount_setattr(otfd, "", AT_EMPTY_PATH,
> +			attr, sizeof(*attr)));
> +	if (TST_RET == -1)
> +		return -1;

close the otfd here?

> +	return otfd;
> +}
> +
> +static int open_tree_variant2(struct mount_attr *attr)
> +{
> +	tst_res(TINFO, "Variant using open_tree_attr()");
> +
> +	otfd = TST_EXP_FD(open_tree_attr(AT_FDCWD, MNTPOINT,
> +			AT_EMPTY_PATH | OPEN_TREE_CLONE,
> +			attr, sizeof(*attr)));
> +
> +	return otfd;
> +}

In the original test the TST_EXP_* were _SILENT variants

>  static void run(unsigned int n)
>  {
>  	struct tcase *tc = &tcases[n];
> -	struct mount_attr attr = {
> -		.attr_set = tc->mount_attrs,
> -	};
>  	struct statvfs buf;
>  
> -	TST_EXP_FD_SILENT(open_tree(AT_FDCWD, MNTPOINT, AT_EMPTY_PATH |
> -		AT_SYMLINK_NOFOLLOW | OPEN_TREE_CLOEXEC | OPEN_TREE_CLONE));
> -	if (!TST_PASS)
> -		return;
> +	memset(attr, 0, sizeof(*attr));
> +	attr->attr_set = tc->mount_attrs;
>  
> -	otfd = (int)TST_RET;
> +	if (tst_variant)
> +		otfd = open_tree_variant1(attr);
> +	else
> +		otfd = open_tree_variant2(attr);
>  
> -	TST_EXP_PASS_SILENT(mount_setattr(otfd, "", AT_EMPTY_PATH, &attr, sizeof(attr)),
> -		"%s set", tc->name);
> -	if (!TST_PASS)
> -		goto out1;
> +	if (otfd == -1)
> +		goto out2;
>  
>  	TST_EXP_PASS_SILENT(move_mount(otfd, "", AT_FDCWD, OT_MNTPOINT, MOVE_MOUNT_F_EMPTY_PATH));
>  	if (!TST_PASS)
>  		goto out1;
> +
>  	mount_flag = 1;
>  	SAFE_CLOSE(otfd);
>  
> @@ -123,9 +150,17 @@ static struct tst_test test = {
>  	.test = run,
>  	.setup = setup,
>  	.cleanup = cleanup,
> +	.test_variants = 2,
>  	.needs_root = 1,
>  	.mount_device = 1,
>  	.mntpoint = MNTPOINT,
>  	.all_filesystems = 1,
> -	.skip_filesystems = (const char *const []){"fuse", NULL},
> +	.skip_filesystems = (const char *const []) {
> +		"fuse",
> +		NULL
> +	},

Such cleanups should ideally be done in a separate patch.

> +	.bufs = (struct tst_buffers []) {
> +		{&attr, .size = sizeof(struct mount_attr)},
> +		{}
> +	}
>  };
> 
> -- 
> 2.51.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
