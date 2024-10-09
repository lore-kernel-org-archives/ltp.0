Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2428CCEDD89
	for <ltp@archiver.kernel.org>; Wed,  9 Oct 2024 12:13:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A825C3C2E96
	for <ltp@archiver.kernel.org>; Wed,  9 Oct 2024 14:13:49 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 150E63C1C20
 for <ltp@lists.linux.it>; Wed,  9 Oct 2024 14:13:34 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8B3591410516
 for <ltp@lists.linux.it>; Wed,  9 Oct 2024 14:13:33 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AC5171FE92;
 Wed,  9 Oct 2024 12:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1728476012; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kVwQ2B6oqN6R1cjKj7a48z9CCDJ1+OXnhlZDoZqnq5c=;
 b=VxwzswzcNL+zTgdRarw0YYggegO5S6ky1LwOewcfTD9eS7MZ4k37w33cWNecUuYc/T7ql0
 0GX4OwFCtFy9JTrYiK3FkPEW4d0Yv9ZE2qqn2ZrWmdozlipAmRs8RGeaFnb5oSEIdW04H6
 Tdd5QGvQOoznLnjpemTIJxRT6PTPFwY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1728476012;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kVwQ2B6oqN6R1cjKj7a48z9CCDJ1+OXnhlZDoZqnq5c=;
 b=7Wuc/lXUbJ5GhIOkXsL/YFclW9YSBFY+btM6KTmol7FT+Ipz+eFurUDHNmRzm3TQihXWtH
 IJTPTaenFFj2xSDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Vxwzswzc;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="7Wuc/lXU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1728476012; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kVwQ2B6oqN6R1cjKj7a48z9CCDJ1+OXnhlZDoZqnq5c=;
 b=VxwzswzcNL+zTgdRarw0YYggegO5S6ky1LwOewcfTD9eS7MZ4k37w33cWNecUuYc/T7ql0
 0GX4OwFCtFy9JTrYiK3FkPEW4d0Yv9ZE2qqn2ZrWmdozlipAmRs8RGeaFnb5oSEIdW04H6
 Tdd5QGvQOoznLnjpemTIJxRT6PTPFwY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1728476012;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kVwQ2B6oqN6R1cjKj7a48z9CCDJ1+OXnhlZDoZqnq5c=;
 b=7Wuc/lXUbJ5GhIOkXsL/YFclW9YSBFY+btM6KTmol7FT+Ipz+eFurUDHNmRzm3TQihXWtH
 IJTPTaenFFj2xSDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 936C9136BA;
 Wed,  9 Oct 2024 12:13:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id TJexI2xzBmdxFgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 09 Oct 2024 12:13:32 +0000
Date: Wed, 9 Oct 2024 14:12:31 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ZwZzL9g8iqIweUW6@yuki.lan>
References: <20241008-ioctl_ficlone01_fix-v4-0-eae3adac33c9@suse.com>
 <20241008-ioctl_ficlone01_fix-v4-1-eae3adac33c9@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241008-ioctl_ficlone01_fix-v4-1-eae3adac33c9@suse.com>
X-Rspamd-Queue-Id: AC5171FE92
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/3] Filter mkfs version in tst_fs
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
>  	if (!op_token)
> -		return;
> +		goto error;

This is not an error case, when we get NULL token it means that there is
no version embedded in the string and that we should return 0 here. This
does not cause any problems for us because we do not use the return
value in the case that we pass commands without version, but we should
stil be consistent here.

That also means that in all the rest of the cases the op_token will be
defined and we can use that directly instead of the op_msg.

> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index d226157e0..4f4a53080 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -1250,6 +1250,7 @@ static const char *default_fs_type(void)
>  static void do_setup(int argc, char *argv[])
>  {
>  	char *tdebug_env = getenv("LTP_ENABLE_DEBUG");
> +	int ret = 0;

This is now unused.

>  	if (!tst_test)
>  		tst_brk(TBROK, "No tests to run");
> @@ -1310,7 +1311,7 @@ static void do_setup(int argc, char *argv[])
>  		int i;
>  
>  		for (i = 0; (cmd = tst_test->needs_cmds[i]); ++i)
> -			tst_check_cmd(cmd);
> +			tst_check_cmd(cmd, 1);
>  	}
>  
>  	if (tst_test->needs_drivers) {
> @@ -1415,8 +1416,12 @@ static void do_setup(int argc, char *argv[])
>  
>  		tdev.fs_type = default_fs_type();
>  
> -		if (!tst_test->all_filesystems && count_fs_descs() <= 1)
> +		if (!tst_test->all_filesystems && count_fs_descs() <= 1) {
> +			if (tst_test->filesystems->mkfs_ver)
> +				tst_check_cmd(tst_test->filesystems->mkfs_ver, 1);
> +
>  			prepare_device(tst_test->filesystems);
> +		}
>  	}
>  
>  	if (tst_test->needs_overlay && !tst_test->mount_device)
> @@ -1805,6 +1810,9 @@ static int run_tcase_on_fs(struct tst_fs *fs, const char *fs_type)
>  	tst_res(TINFO, "=== Testing on %s ===", fs_type);
>  	tdev.fs_type = fs_type;
>  
> +	if (fs->mkfs_ver && tst_check_cmd(fs->mkfs_ver, 0))
> +		return TCONF;
> +
>  	prepare_device(fs);
>  
>  	ret = fork_testrun();
> @@ -1832,7 +1840,7 @@ static int run_tcases_per_fs(void)
>  		if (!fs)
>  			continue;
>  
> -		run_tcase_on_fs(fs, filesystems[i]);
> +		ret = run_tcase_on_fs(fs, filesystems[i]);

I've send a patch that fixes this separately with a proper Fixes: tag,
it would make more sense if you added your reviewed by and I would apply
that patch separately...


Other than that:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
