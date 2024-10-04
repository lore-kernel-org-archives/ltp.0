Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D92CCCFA775
	for <ltp@archiver.kernel.org>; Fri,  4 Oct 2024 14:10:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 518163C6353
	for <ltp@archiver.kernel.org>; Fri,  4 Oct 2024 16:10:17 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 831703C61DE
 for <ltp@lists.linux.it>; Fri,  4 Oct 2024 16:10:00 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 669F860DBCE
 for <ltp@lists.linux.it>; Fri,  4 Oct 2024 16:09:58 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8468C1FD8C;
 Fri,  4 Oct 2024 14:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1728050968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F4yjtKZxR8hoDy4CbyuhCfXq+PuHGz2lGsIfCGNvo50=;
 b=gGjdd1ihhwRdfWAvQn6lUSkcajbkjD8ezXG0pmVun1jl8LxwCfHjfTzLJiRCjuohiaq8XJ
 ScV/1pKcpZG1fUFL2Q2FLSl6wAxEbgQ6DQNH61Y7bMy09mcF5wpxgbUuoTPVKNQ8mEClea
 XcXDQnFw+qscvtHuM+4ynea/4z4LmDk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1728050968;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F4yjtKZxR8hoDy4CbyuhCfXq+PuHGz2lGsIfCGNvo50=;
 b=nxjRXMavAtINF9YFIBoxghDXEWrLiBODAObFFd2+O6qcb5oy3poY+7YalD9RBtGQ1DY1n0
 e1O/Kj2uSLeKSmBw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=i3bcqbC9;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=gFZpzkfK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1728050967; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F4yjtKZxR8hoDy4CbyuhCfXq+PuHGz2lGsIfCGNvo50=;
 b=i3bcqbC9BFe7TygpXCqM+Djf81lKAlzK6uF91hTGe1OPpADimZwKANDBDis3z9OwhMG4y0
 KnJU8BU2mqVNzC54DHNWsrGx4P6/6oTcHeAfsDAt+xxOKNlk3zYabY9tOTcPpBqCcMPE4U
 BQoaK808glf2WvbBEK4qpZkVgqp0ZK0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1728050967;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F4yjtKZxR8hoDy4CbyuhCfXq+PuHGz2lGsIfCGNvo50=;
 b=gFZpzkfKanT4U0iK95EAWWJ16XQK5HXQl54a7AT4S5PvVVdNy7hw1+BpPrY19Q1iAZr/Pm
 XBjTGTaILcBwHpBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 725E413A6E;
 Fri,  4 Oct 2024 14:09:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Ju1yGhf3/2akYgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 04 Oct 2024 14:09:27 +0000
Date: Fri, 4 Oct 2024 16:08:21 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <Zv_21V0x0Kv-ViJo@yuki.lan>
References: <20241002-ioctl_ficlone01_fix-v3-0-7e077918dfd4@suse.com>
 <20241002-ioctl_ficlone01_fix-v3-2-7e077918dfd4@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241002-ioctl_ficlone01_fix-v3-2-7e077918dfd4@suse.com>
X-Rspamd-Queue-Id: 8468C1FD8C
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email,suse.com:email];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/3] Add minimum kernel requirement for FS setup
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
> In some cases, a filesystem that is going to be created and mounted
> by LTP can't be supported by certain kernel versions. This is the case
> of the CoW support: mkfs creates a CoW filesystem, while underlying
> kernel can't mount it.
> 
> To cover this scenario, a new flag called .min_kver has been
> introduced in the tst_fs structure, giving the user a possibility to
> filter out certain kernels not supporting certain FS features.
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  include/tst_test.h            |  5 +++++
>  lib/tst_test.c                | 27 +++++++++++++++++++++------
>  testcases/lib/tst_run_shell.c |  5 +++++
>  3 files changed, 31 insertions(+), 6 deletions(-)
> 
> diff --git a/include/tst_test.h b/include/tst_test.h
> index 38d24f48c..8d1819f74 100644
> --- a/include/tst_test.h
> +++ b/include/tst_test.h
> @@ -270,6 +270,9 @@ struct tst_ulimit_val {
>   *
>   * @mnt_data: The data passed to mount(2) when the test library mounts a device
>   *            in the case of 'tst_test.mount_device'.
> + *
> + * @min_kver: A minimum kernel version supporting the filesystem which has been
> + *            created with mkfs.
>   */
>  struct tst_fs {
>  	const char *type;
> @@ -280,6 +283,8 @@ struct tst_fs {
>  
>  	unsigned int mnt_flags;
>  	const void *mnt_data;
> +
> +	const char *min_kver;
>  };
>  
>  /**
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 192fee309..fe07c4d98 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -950,20 +950,29 @@ static void do_exit(int ret)
>  	exit(ret);
>  }
>  
> -void check_kver(void)
> +int check_kver(const char *min_kver, const int brk_nosupp)
>  {
> +	char *msg;
>  	int v1, v2, v3;
>  
> -	if (tst_parse_kver(tst_test->min_kver, &v1, &v2, &v3)) {
> +	if (tst_parse_kver(min_kver, &v1, &v2, &v3)) {
>  		tst_res(TWARN,
>  			"Invalid kernel version %s, expected %%d.%%d.%%d",
> -			tst_test->min_kver);
> +			min_kver);
>  	}
>  
>  	if (tst_kvercmp(v1, v2, v3) < 0) {
> -		tst_brk(TCONF, "The test requires kernel %s or newer",
> -			tst_test->min_kver);
> +		msg = "The test requires kernel %s or newer";
> +
> +		if (brk_nosupp)
> +			tst_brk(TCONF, msg, min_kver);
> +		else
> +			tst_res(TCONF, msg, min_kver);
> +
> +		return 1;
>  	}
> +
> +	return 0;
>  }
>  
>  static int results_equal(struct results *a, struct results *b)
> @@ -1289,7 +1298,7 @@ static void do_setup(int argc, char *argv[])
>  		tst_brk(TCONF, "Test needs to be run as root");
>  
>  	if (tst_test->min_kver)
> -		check_kver();
> +		check_kver(tst_test->min_kver, 1);
>  
>  	if (tst_test->supported_archs && !tst_is_on_arch(tst_test->supported_archs))
>  		tst_brk(TCONF, "This arch '%s' is not supported for test!", tst_arch.name);
> @@ -1420,6 +1429,9 @@ static void do_setup(int argc, char *argv[])
>  			if (tst_test->filesystems->mkfs_ver)
>  				ret = tst_check_cmd(tst_test->filesystems->mkfs_ver, 0);
>  
> +			if (tst_test->filesystems->min_kver)
> +				ret = check_kver(tst_test->filesystems->min_kver, 0);

Here as well, we should pass 1 as the last argument.

>  			if (ret)
>  				return;
>  
> @@ -1816,6 +1828,9 @@ static int run_tcase_on_fs(struct tst_fs *fs, const char *fs_type)
>  	if (fs->mkfs_ver && tst_check_cmd(fs->mkfs_ver, 0))
>  		return TCONF;
>  
> +	if (fs->min_kver && check_kver(fs->min_kver, 0))
> +		return TCONF;
> +
>  	prepare_device(fs);
>  
>  	ret = fork_testrun();
> diff --git a/testcases/lib/tst_run_shell.c b/testcases/lib/tst_run_shell.c
> index ee029b666..6b714c51c 100644
> --- a/testcases/lib/tst_run_shell.c
> +++ b/testcases/lib/tst_run_shell.c
> @@ -156,6 +156,7 @@ enum fs_ids {
>  	MKFS_VER,
>  	MNT_FLAGS,
>  	TYPE,
> +	FS_MIN_KVER,
>  };
>  
>  static ujson_obj_attr fs_attrs[] = {
> @@ -164,6 +165,7 @@ static ujson_obj_attr fs_attrs[] = {
>  	UJSON_OBJ_ATTR_IDX(MKFS_VER, "mkfs_ver", UJSON_STR),
>  	UJSON_OBJ_ATTR_IDX(MNT_FLAGS, "mnt_flags", UJSON_ARR),
>  	UJSON_OBJ_ATTR_IDX(TYPE, "type", UJSON_STR),
> +	UJSON_OBJ_ATTR_IDX(FS_MIN_KVER, "min_kver", UJSON_STR),

This is stil not sorted properly, the min_kver should go before the
mkfs_ver.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
