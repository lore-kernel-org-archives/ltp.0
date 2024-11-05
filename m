Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B805ED2C139
	for <ltp@archiver.kernel.org>; Tue,  5 Nov 2024 15:39:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2528D3D279A
	for <ltp@archiver.kernel.org>; Tue,  5 Nov 2024 16:39:30 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 740683D2796
 for <ltp@lists.linux.it>; Tue,  5 Nov 2024 16:39:13 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DB7562009A1
 for <ltp@lists.linux.it>; Tue,  5 Nov 2024 16:39:12 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AD7FF1FE73;
 Tue,  5 Nov 2024 15:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730821151; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Eu+gHjGMTEa4C6r4wEDtdPxR3bP5EpS/SD2VbtBTc0Q=;
 b=zTmh1FFq48/krc+tqbA7hDH8hL22qAmHTFqEV5MBCTvvkVdf9xz3woSU+bQiwYyVncHKdp
 ancnHoJsh7zRYbiYBEDM5n/UHSuA0/CcwTrNEOmJS8FxM1eAWCT7DBfI5v4MXTLZ9Lm1jF
 5+SOFEIAiX+F/oqIARYOkumQ/DxWamU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730821151;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Eu+gHjGMTEa4C6r4wEDtdPxR3bP5EpS/SD2VbtBTc0Q=;
 b=bI+y2WlOQ1WNLBwgoVMu/xJp8KNUfhkdwURY41BEQXj2a/ZwE16m+tlF919UM/Pjg957XY
 w2w68cMBQdi2w5Cw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=zTmh1FFq;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=bI+y2WlO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730821151; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Eu+gHjGMTEa4C6r4wEDtdPxR3bP5EpS/SD2VbtBTc0Q=;
 b=zTmh1FFq48/krc+tqbA7hDH8hL22qAmHTFqEV5MBCTvvkVdf9xz3woSU+bQiwYyVncHKdp
 ancnHoJsh7zRYbiYBEDM5n/UHSuA0/CcwTrNEOmJS8FxM1eAWCT7DBfI5v4MXTLZ9Lm1jF
 5+SOFEIAiX+F/oqIARYOkumQ/DxWamU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730821151;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Eu+gHjGMTEa4C6r4wEDtdPxR3bP5EpS/SD2VbtBTc0Q=;
 b=bI+y2WlOQ1WNLBwgoVMu/xJp8KNUfhkdwURY41BEQXj2a/ZwE16m+tlF919UM/Pjg957XY
 w2w68cMBQdi2w5Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 97C451394A;
 Tue,  5 Nov 2024 15:39:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0ga/JB88Kmd/OAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 05 Nov 2024 15:39:11 +0000
Date: Tue, 5 Nov 2024 16:39:15 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <Zyo8I-32MuJz_EFw@yuki.lan>
References: <20241105-landlock_network-v2-0-d58791487919@suse.com>
 <20241105-landlock_network-v2-4-d58791487919@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241105-landlock_network-v2-4-d58791487919@suse.com>
X-Rspamd-Queue-Id: AD7FF1FE73
X-Rspamd-Action: no action
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[yuki.lan:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 4/4] Add error coverage for landlock network
 support
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
> diff --git a/testcases/kernel/syscalls/landlock/landlock02.c b/testcases/kernel/syscalls/landlock/landlock02.c
> index 8566d407f6d17ab367695125f07d0a80cf4130e5..dbc405a8a01ac58e0d22f952f57bd603c62ab8be 100644
> --- a/testcases/kernel/syscalls/landlock/landlock02.c
> +++ b/testcases/kernel/syscalls/landlock/landlock02.c
> @@ -20,93 +20,146 @@
>  
>  #include "landlock_common.h"
>  
> -static struct tst_landlock_ruleset_attr_abi1 *ruleset_attr;
> +static struct tst_landlock_ruleset_attr_abi4 *ruleset_attr;
>  static struct landlock_path_beneath_attr *path_beneath_attr;
>  static struct landlock_path_beneath_attr *rule_null;
> +static struct landlock_net_port_attr *net_port_attr;
>  static int ruleset_fd;
>  static int invalid_fd = -1;
> +static int abi_current;
>  
>  static struct tcase {
>  	int *fd;
> -	enum landlock_rule_type rule_type;
> -	struct landlock_path_beneath_attr **attr;
> +	int rule_type;
> +	struct landlock_path_beneath_attr **path_attr;
> +	struct landlock_net_port_attr **net_attr;
>  	int access;
>  	int parent_fd;
> +	int net_port;
>  	uint32_t flags;
>  	int exp_errno;
> +	int abi_ver;
>  	char *msg;
>  } tcases[] = {
>  	{
>  		.fd = &ruleset_fd,
> -		.attr = &path_beneath_attr,
> +		.path_attr = &path_beneath_attr,
> +		.net_attr = NULL,

This is a static structure, so anything that is not initialized will be
zeroed anyways, so I would just omit the explicit NULL initializations.

>  		.access = LANDLOCK_ACCESS_FS_EXECUTE,
>  		.flags = 1,
>  		.exp_errno = EINVAL,
> +		.abi_ver = 1,
>  		.msg = "Invalid flags"
>  	},
>  	{
>  		.fd = &ruleset_fd,
> -		.attr = &path_beneath_attr,
> +		.path_attr = &path_beneath_attr,
> +		.net_attr = NULL,
>  		.access = LANDLOCK_ACCESS_FS_EXECUTE,
>  		.exp_errno = EINVAL,
> +		.abi_ver = 1,
>  		.msg = "Invalid rule type"
>  	},
>  	{
>  		.fd = &ruleset_fd,
>  		.rule_type = LANDLOCK_RULE_PATH_BENEATH,
> -		.attr = &path_beneath_attr,
> +		.path_attr = &path_beneath_attr,
> +		.net_attr = NULL,
>  		.exp_errno = ENOMSG,
> +		.abi_ver = 1,
>  		.msg = "Empty accesses"
>  	},
>  	{
>  		.fd = &invalid_fd,
> -		.attr = &path_beneath_attr,
> +		.path_attr = &path_beneath_attr,
> +		.net_attr = NULL,
>  		.access = LANDLOCK_ACCESS_FS_EXECUTE,
>  		.exp_errno = EBADF,
> +		.abi_ver = 1,
>  		.msg = "Invalid file descriptor"
>  	},
>  	{
>  		.fd = &ruleset_fd,
>  		.rule_type = LANDLOCK_RULE_PATH_BENEATH,
> -		.attr = &path_beneath_attr,
> +		.path_attr = &path_beneath_attr,
> +		.net_attr = NULL,
>  		.access = LANDLOCK_ACCESS_FS_EXECUTE,
>  		.parent_fd = -1,
>  		.exp_errno = EBADF,
> +		.abi_ver = 1,
>  		.msg = "Invalid parent fd"
>  	},
>  	{
>  		.fd = &ruleset_fd,
>  		.rule_type = LANDLOCK_RULE_PATH_BENEATH,
> -		.attr = &rule_null,
> +		.path_attr = &rule_null,
> +		.net_attr = NULL,
>  		.exp_errno = EFAULT,
> +		.abi_ver = 1,
>  		.msg = "Invalid rule attr"
>  	},
> +	{
> +		.fd = &ruleset_fd,
> +		.rule_type = LANDLOCK_RULE_NET_PORT,
> +		.path_attr = NULL,
> +		.net_attr = &net_port_attr,
> +		.access = LANDLOCK_ACCESS_FS_EXECUTE,
> +		.net_port = 448,
> +		.exp_errno = EINVAL,
> +		.abi_ver = 4,
> +		.msg = "Invalid access rule for network type"
> +	},
> +	{
> +		.fd = &ruleset_fd,
> +		.rule_type = LANDLOCK_RULE_NET_PORT,
> +		.path_attr = NULL,
> +		.net_attr = &net_port_attr,
> +		.access = LANDLOCK_ACCESS_NET_BIND_TCP,
> +		.net_port = INT16_MAX + 1,
> +		.exp_errno = EINVAL,
> +		.abi_ver = 4,
> +		.msg = "Socket port greater than 65535"
> +	},
>  };
>  
>  static void run(unsigned int n)
>  {
>  	struct tcase *tc = &tcases[n];
>  
> -	if (*tc->attr) {
> -		(*tc->attr)->allowed_access = tc->access;
> -		(*tc->attr)->parent_fd = tc->parent_fd;
> +	if (tc->abi_ver > abi_current) {
> +		tst_res(TCONF, "Minimum ABI required: %d", tc->abi_ver);
> +		return;
>  	}
>  
> -	TST_EXP_FAIL(tst_syscall(__NR_landlock_add_rule,
> -		*tc->fd, tc->rule_type, *tc->attr, tc->flags),
> -		tc->exp_errno,
> -		"%s",
> -		tc->msg);
> +	if (tc->path_attr) {
> +		if (*tc->path_attr) {
> +			(*tc->path_attr)->allowed_access = tc->access;
> +			(*tc->path_attr)->parent_fd = tc->parent_fd;
> +		}
> +
> +		TST_EXP_FAIL(tst_syscall(__NR_landlock_add_rule,
> +			*tc->fd, tc->rule_type, *tc->path_attr, tc->flags),
> +			tc->exp_errno, "%s", tc->msg);
> +	} else if (tc->net_attr) {
> +		if (*tc->net_attr) {
> +			(*tc->net_attr)->allowed_access = tc->access;
> +			(*tc->net_attr)->port = tc->net_port;
> +		}
> +
> +		TST_EXP_FAIL(tst_syscall(__NR_landlock_add_rule,
> +			*tc->fd, tc->rule_type, *tc->net_attr, tc->flags),
> +			tc->exp_errno, "%s", tc->msg);

if we assing the attr into a pointer this TST_EPX_FAIL() can be outside
of the if as:

	void *attr;

	if (path_attr) {
		...
		attr = *path_attr;
	} else {
		...
		attr = *net_attr;
	}

	TST_EXP_FAIL(..., attr, ...);

> +	}
>  }
>  
>  static void setup(void)
>  {
> -	verify_landlock_is_enabled();
> +	abi_current = verify_landlock_is_enabled();
>  
>  	ruleset_attr->handled_access_fs = LANDLOCK_ACCESS_FS_EXECUTE;
>  
>  	ruleset_fd = TST_EXP_FD_SILENT(tst_syscall(__NR_landlock_create_ruleset,
> -		ruleset_attr, sizeof(struct tst_landlock_ruleset_attr_abi1), 0));
> +		ruleset_attr, sizeof(struct tst_landlock_ruleset_attr_abi4), 0));
                               ^
			       This should be abi_current otherwise we
			       will fail on v1 only system.

>  }
>  
>  static void cleanup(void)
> @@ -122,8 +175,9 @@ static struct tst_test test = {
>  	.cleanup = cleanup,
>  	.needs_root = 1,
>  	.bufs = (struct tst_buffers []) {
> -		{&ruleset_attr, .size = sizeof(struct tst_landlock_ruleset_attr_abi1)},
> +		{&ruleset_attr, .size = sizeof(struct tst_landlock_ruleset_attr_abi4)},
>  		{&path_beneath_attr, .size = sizeof(struct landlock_path_beneath_attr)},
> +		{&net_port_attr, .size = sizeof(struct landlock_net_port_attr)},
>  		{},
>  	},
>  	.caps = (struct tst_cap []) {

The rest looks good to me, with the minor probles fixed:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
