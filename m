Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BFD8C36009
	for <ltp@archiver.kernel.org>; Tue, 17 Sep 2024 11:12:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9FAFC3C2E31
	for <ltp@archiver.kernel.org>; Tue, 17 Sep 2024 13:12:14 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 90FBB3C130D
 for <ltp@lists.linux.it>; Tue, 17 Sep 2024 13:11:58 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id AC37A60344E
 for <ltp@lists.linux.it>; Tue, 17 Sep 2024 13:11:55 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5F5061FB6B;
 Tue, 17 Sep 2024 11:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1726571514; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wvIxJWiKnXaEFcKco1/OXyP05uTjS8SDBKIImE+K8oA=;
 b=J+NhGGL6Orz8ioW4yJwmphA3a2l4AvLLGwDi0BT7YHsEGjNZ5RHIzslQQvcX7MVwDNEgtG
 4ENtEuebVzZP4/ch523l/XiTE+6cRuvcVonvy2s54TPTRoRBfW00YHio6Rt6FqkVgpGDj3
 P+Q2D0scvWM31TmqPeN1rlS91wlzso0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1726571514;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wvIxJWiKnXaEFcKco1/OXyP05uTjS8SDBKIImE+K8oA=;
 b=Ip5Oy8tVLkPs1MVLf2OCbaJKsx3i1dOMRr5a3isqeuwuFfWMzlv9I/lZCLzxlFfwyS417d
 EsFl0459StMk1KCA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=J+NhGGL6;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Ip5Oy8tV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1726571514; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wvIxJWiKnXaEFcKco1/OXyP05uTjS8SDBKIImE+K8oA=;
 b=J+NhGGL6Orz8ioW4yJwmphA3a2l4AvLLGwDi0BT7YHsEGjNZ5RHIzslQQvcX7MVwDNEgtG
 4ENtEuebVzZP4/ch523l/XiTE+6cRuvcVonvy2s54TPTRoRBfW00YHio6Rt6FqkVgpGDj3
 P+Q2D0scvWM31TmqPeN1rlS91wlzso0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1726571514;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wvIxJWiKnXaEFcKco1/OXyP05uTjS8SDBKIImE+K8oA=;
 b=Ip5Oy8tVLkPs1MVLf2OCbaJKsx3i1dOMRr5a3isqeuwuFfWMzlv9I/lZCLzxlFfwyS417d
 EsFl0459StMk1KCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4BE04139CE;
 Tue, 17 Sep 2024 11:11:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id BNAxEvpj6WaVBQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 17 Sep 2024 11:11:54 +0000
Date: Tue, 17 Sep 2024 13:10:39 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Xiao Yang <ice_yangxiao@163.com>
Message-ID: <ZuljrzDTzU3VtI5O@yuki.lan>
References: <20240809025825.4055-1-ice_yangxiao@163.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240809025825.4055-1-ice_yangxiao@163.com>
X-Rspamd-Queue-Id: 5F5061FB6B
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FREEMAIL_TO(0.00)[163.com];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; FREEMAIL_ENVRCPT(0.00)[163.com];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/{fanotify17,
 getxattr05}: simplify code by using save_restore
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
> -	/*
> -	 * The default value of max_user_namespaces is set to 0 on some distros,
> -	 * We need to change the default value to call unshare().
> -	 */
> -	if (access(SELF_USERNS, F_OK) != 0) {
> +	if (access(SELF_USERNS, F_OK) != 0)
>  		user_ns_supported = 0;
> -	} else if (!access(MAX_USERNS, F_OK)) {
> -		SAFE_FILE_SCANF(MAX_USERNS, "%d", &orig_max_userns);
> -		SAFE_FILE_PRINTF(MAX_USERNS, "%d", 10);

Here the original code writes 10 to the MAX_USERNS.

> -	}
>  
>  	/*
>  	 * In older kernels those limits were fixed in kernel and fanotify is
> @@ -244,21 +234,18 @@ static void setup(void)
>  	setup_rlimit(max_groups * 2);
>  }
>  
> -static void cleanup(void)
> -{
> -	if (orig_max_userns != -1)
> -		SAFE_FILE_PRINTF(MAX_USERNS, "%d", orig_max_userns);
> -}
> -
>  static struct tst_test test = {
>  	.test = test_fanotify,
>  	.tcnt = ARRAY_SIZE(tcases),
>  	.setup = setup,
> -	.cleanup = cleanup,
>  	.needs_root = 1,
>  	.forks_child = 1,
>  	.mount_device = 1,
>  	.mntpoint = MOUNT_PATH,
> +	.save_restore = (const struct tst_path_val[]) {
> +		{"/proc/sys/user/max_user_namespaces", "1024", TST_SR_SKIP},
> +		{}
> +	},

And here you are initializing it to 1024? Shouldn't the value here be 10
too?

>  };
>  #else
>  	TST_TEST_TCONF("system doesn't have required fanotify support");
> diff --git a/testcases/kernel/syscalls/getxattr/getxattr05.c b/testcases/kernel/syscalls/getxattr/getxattr05.c
> index d9717a695..3dff8e27f 100644
> --- a/testcases/kernel/syscalls/getxattr/getxattr05.c
> +++ b/testcases/kernel/syscalls/getxattr/getxattr05.c
> @@ -40,11 +40,9 @@
>  
>  #define TEST_FILE	"testfile"
>  #define SELF_USERNS	"/proc/self/ns/user"
> -#define MAX_USERNS	"/proc/sys/user/max_user_namespaces"
>  #define UID_MAP	"/proc/self/uid_map"
>  
>  static acl_t acl;
> -static int orig_max_userns = -1;
>  static int user_ns_supported = 1;
>  
>  static struct tcase {
> @@ -149,23 +147,13 @@ static void setup(void)
>  		tst_brk(TBROK | TERRNO, "acl_set_file(%s) failed", TEST_FILE);
>  	}
>  
> -	/* The default value of max_user_namespaces is set to 0 on some distros,
> -	 * We need to change the default value to call unshare().
> -	 */
> -	if (access(SELF_USERNS, F_OK) != 0) {
> +	if (access(SELF_USERNS, F_OK) != 0)
>  		user_ns_supported = 0;
> -	} else if (!access(MAX_USERNS, F_OK)) {
> -		SAFE_FILE_SCANF(MAX_USERNS, "%d", &orig_max_userns);
> -		SAFE_FILE_PRINTF(MAX_USERNS, "%d", 10);
> -	}
>  
>  }
>  
>  static void cleanup(void)
>  {
> -	if (orig_max_userns != -1)
> -		SAFE_FILE_PRINTF(MAX_USERNS, "%d", orig_max_userns);
> -
>  	if (acl)
>  		acl_free(acl);
>  }
> @@ -181,7 +169,11 @@ static struct tst_test test = {
>  	.tags = (const struct tst_tag[]) {
>  		{"linux-git", "82c9a927bc5d"},
>  		{}
> -},
> +	},
> +	.save_restore = (const struct tst_path_val[]) {
> +		{"/proc/sys/user/max_user_namespaces", "1024", TST_SR_SKIP},

And same here.

> +		{}
> +	},
>  };
>  
>  #else /* HAVE_SYS_XATTR_H && HAVE_LIBACL*/
> -- 
> 2.45.2
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
