Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 732B7CF5395
	for <ltp@archiver.kernel.org>; Wed, 23 Oct 2024 14:38:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F22553C706B
	for <ltp@archiver.kernel.org>; Wed, 23 Oct 2024 16:38:12 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D96073C703F
 for <ltp@lists.linux.it>; Wed, 23 Oct 2024 16:37:56 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id AC3721425B54
 for <ltp@lists.linux.it>; Wed, 23 Oct 2024 16:37:55 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B819C21FD7;
 Wed, 23 Oct 2024 14:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1729694273; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TCoB3lDSrcu+u1C+MGP98zyCY7AFtvpOvu0wrRaQwXY=;
 b=qKBgRkEzmmo5rTciTTVoyBcp2nbNHljE02QNpEr/FtOcAa2v5UuOgIzVLDr7WfLaJr7yC4
 BlF64P1Q0r5eGZC3lcFiFr6YbSzgqBE2V2V+X8vHYK+WkklQFj9jDGdhXpBCbrpFftWm3U
 8SaK+KNPox29l/JRk1J5JyxIhGTq+Cw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1729694273;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TCoB3lDSrcu+u1C+MGP98zyCY7AFtvpOvu0wrRaQwXY=;
 b=u96kd/PBnjwh0agbB24ljFx+QxlB57VejxeH5S/+eK29/1w0DQYul8y6ZzRoT4cKpDjYmm
 CQ3HEJ0zP4N7zDCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1729694273; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TCoB3lDSrcu+u1C+MGP98zyCY7AFtvpOvu0wrRaQwXY=;
 b=qKBgRkEzmmo5rTciTTVoyBcp2nbNHljE02QNpEr/FtOcAa2v5UuOgIzVLDr7WfLaJr7yC4
 BlF64P1Q0r5eGZC3lcFiFr6YbSzgqBE2V2V+X8vHYK+WkklQFj9jDGdhXpBCbrpFftWm3U
 8SaK+KNPox29l/JRk1J5JyxIhGTq+Cw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1729694273;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TCoB3lDSrcu+u1C+MGP98zyCY7AFtvpOvu0wrRaQwXY=;
 b=u96kd/PBnjwh0agbB24ljFx+QxlB57VejxeH5S/+eK29/1w0DQYul8y6ZzRoT4cKpDjYmm
 CQ3HEJ0zP4N7zDCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A833B13AD3;
 Wed, 23 Oct 2024 14:37:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WZEtKEEKGWdoGAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 23 Oct 2024 14:37:53 +0000
Date: Wed, 23 Oct 2024 16:37:50 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ZxkKPkEKNB-BmWZQ@yuki.lan>
References: <20240919-landlock_network-v1-0-9c997f03bd0a@suse.com>
 <20240919-landlock_network-v1-1-9c997f03bd0a@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240919-landlock_network-v1-1-9c997f03bd0a@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/5] Fallback landlock network support
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
> -#ifndef HAVE_ENUM_LANDLOCK_RULE_TYPE
> -enum landlock_rule_type
> -{
> -	LANDLOCK_RULE_PATH_BENEATH = 1,
> -	LANDLOCK_RULE_NET_PORT,
> -};
> +#ifndef LANDLOCK_RULE_PATH_BENEATH
> +# define LANDLOCK_RULE_PATH_BENEATH 1
> +#endif
> +
> +#ifndef LANDLOCK_RULE_NET_PORT
> +# define LANDLOCK_RULE_NET_PORT 2
>  #endif

Does this really work?

Because unlike the glibc that does additionally define enum mebers the
Linux kernel headers does not do that.

I.e. in glibc you have:

enum foo {
	FOO_AAA,
#define FOO_AAA FOO_AAA
	...
};

So that you can do #ifdef FOO_AAA, but there is no such thing in
linux/landlock.h so unfortunatelly we really have to check for each
individual enum member in configure.

> diff --git a/testcases/kernel/syscalls/landlock/landlock01.c b/testcases/kernel/syscalls/landlock/landlock01.c
> index 083685c64..7f767c007 100644
> --- a/testcases/kernel/syscalls/landlock/landlock01.c
> +++ b/testcases/kernel/syscalls/landlock/landlock01.c
> @@ -17,14 +17,14 @@
>  
>  #include "landlock_common.h"
>  
> -static struct landlock_ruleset_attr *ruleset_attr;
> -static struct landlock_ruleset_attr *null_attr;
> +static struct tst_landlock_ruleset_attr *ruleset_attr;
> +static struct tst_landlock_ruleset_attr *null_attr;
>  static size_t rule_size;
>  static size_t rule_small_size;
>  static size_t rule_big_size;
>  
>  static struct tcase {
> -	struct landlock_ruleset_attr **attr;
> +	struct tst_landlock_ruleset_attr **attr;
>  	uint64_t access_fs;
>  	size_t *size;
>  	uint32_t flags;
> @@ -44,10 +44,10 @@ static void run(unsigned int n)
>  	struct tcase *tc = &tcases[n];
>  
>  	if (*tc->attr)
> -		(*tc->attr)->handled_access_fs = tc->access_fs;
> +		(*tc->attr)->base.handled_access_fs = tc->access_fs;
>  
>  	TST_EXP_FAIL(tst_syscall(__NR_landlock_create_ruleset,
> -			*tc->attr, *tc->size, tc->flags),
> +			&(*tc->attr)->base, *tc->size, tc->flags),
>  		tc->exp_errno,
>  		"%s",
>  		tc->msg);
> @@ -60,12 +60,12 @@ static void setup(void)
>  {
>  	verify_landlock_is_enabled();
>  
> -	rule_size = sizeof(struct landlock_ruleset_attr);
> +	rule_size = sizeof(struct tst_landlock_ruleset_attr);
>  
>  #ifdef HAVE_STRUCT_LANDLOCK_RULESET_ATTR_HANDLED_ACCESS_NET
> -	rule_small_size = rule_size - sizeof(uint64_t) - 1;
> +	rule_small_size = rule_size - 2*sizeof(uint64_t) - 1;
>  #else
> -	rule_small_size = rule_size - 1;
> +	rule_small_size = rule_size - sizeof(uint64_t) - 1;
>  #endif

This is also completely wrong. You cannot check the system headers and
deduce anything about the currently running kernel from them. There is
no coupling between the system the tests are compiled on and the system
the test are executed later on.

Which ABI is supported by the kernel has to be deduced at runtime from
the kernel.

Also you have changed the rule_size = sizeof() to the fallback
structure which size is always constant. Which makes the rule_small_size
even more wrong.

What are you trying to do here? It looks to me like the rule_small_size
ends up being set to -1 anyways, because the size of the ruleset_attr
structure is equal to the sizeof() of the uint64_t or two uint64_t.

>  	rule_big_size = SAFE_SYSCONF(_SC_PAGESIZE) + 1;
> @@ -77,7 +77,7 @@ static struct tst_test test = {
>  	.setup = setup,
>  	.needs_root = 1,
>  	.bufs = (struct tst_buffers []) {
> -		{&ruleset_attr, .size = sizeof(struct landlock_ruleset_attr)},
> +		{&ruleset_attr, .size = sizeof(struct tst_landlock_ruleset_attr)},
>  		{},
>  	},
>  	.caps = (struct tst_cap []) {
> diff --git a/testcases/kernel/syscalls/landlock/landlock02.c b/testcases/kernel/syscalls/landlock/landlock02.c
> index 1a3df69c9..bdef57b55 100644
> --- a/testcases/kernel/syscalls/landlock/landlock02.c
> +++ b/testcases/kernel/syscalls/landlock/landlock02.c
> @@ -20,7 +20,7 @@
>  
>  #include "landlock_common.h"
>  
> -static struct landlock_ruleset_attr *ruleset_attr;
> +static struct tst_landlock_ruleset_attr *ruleset_attr;
>  static struct landlock_path_beneath_attr *path_beneath_attr;
>  static struct landlock_path_beneath_attr *rule_null;
>  static int ruleset_fd;
> @@ -28,7 +28,7 @@ static int invalid_fd = -1;
>  
>  static struct tcase {
>  	int *fd;
> -	enum landlock_rule_type rule_type;
> +	int rule_type;
>  	struct landlock_path_beneath_attr **attr;
>  	int access;
>  	int parent_fd;
> @@ -103,10 +103,10 @@ static void setup(void)
>  {
>  	verify_landlock_is_enabled();
>  
> -	ruleset_attr->handled_access_fs = LANDLOCK_ACCESS_FS_EXECUTE;
> +	ruleset_attr->base.handled_access_fs = LANDLOCK_ACCESS_FS_EXECUTE;
>  
>  	ruleset_fd = TST_EXP_FD_SILENT(tst_syscall(__NR_landlock_create_ruleset,
> -		ruleset_attr, sizeof(struct landlock_ruleset_attr), 0));
> +		&ruleset_attr->base, sizeof(struct tst_landlock_ruleset_attr), 0));

And this does not work either as this would disable these tests on older
kernels because it would pass size that is not supported.

So I supose that this is getting out of hand and we should ingore the
structure in the system headers and instead create two different
structures:

struct tst_landlock_ruleset_attr_1 {
	uint64_t handled_access_fs;
};

struct tst_landlock_ruleset_attr_2 {
	uint64_t handled_access_fs;
	uint64_t handled_access_net;
};

And use the tst_landlock_ruleset_attr_1 in the tests where the network
part is not needed.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
