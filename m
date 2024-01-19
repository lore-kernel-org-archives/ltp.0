Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6242C47DD3
	for <ltp@archiver.kernel.org>; Fri, 19 Jan 2024 16:08:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D398A3CE2CF
	for <ltp@archiver.kernel.org>; Fri, 19 Jan 2024 17:08:41 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 576F73CC85D
 for <ltp@lists.linux.it>; Fri, 19 Jan 2024 17:08:26 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A5617600F3F
 for <ltp@lists.linux.it>; Fri, 19 Jan 2024 17:08:25 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 72A5021FDD;
 Fri, 19 Jan 2024 16:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705680504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K0aqAFGHgZcm/GMzF6VV9UaD44c22VUmHfxaMYzqP3I=;
 b=OvLygIVme2dSjsxKiz7LzjT4Fp59PM7gZ+jjT624jfPuIMJtlVNMPYtRQ4U6YnbwCJoyQ6
 Ddsoep6d7y1RJeNE048io/7y/yf1Arzq7u8M+9zHLBXNg03GeKDrmtQEeaxZ5iBrz+ER2F
 xZyJyjKzOL23drIV5GF52VKywWRKTyI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705680504;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K0aqAFGHgZcm/GMzF6VV9UaD44c22VUmHfxaMYzqP3I=;
 b=0UHAtuoa7vOyOeSK+7hvWLfGjxWKVBckmX81zWRwPvVbKyoT7UfuuWxOFnQF4xczzRHRCd
 sI+wgt2elCbNdGBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705680504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K0aqAFGHgZcm/GMzF6VV9UaD44c22VUmHfxaMYzqP3I=;
 b=OvLygIVme2dSjsxKiz7LzjT4Fp59PM7gZ+jjT624jfPuIMJtlVNMPYtRQ4U6YnbwCJoyQ6
 Ddsoep6d7y1RJeNE048io/7y/yf1Arzq7u8M+9zHLBXNg03GeKDrmtQEeaxZ5iBrz+ER2F
 xZyJyjKzOL23drIV5GF52VKywWRKTyI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705680504;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K0aqAFGHgZcm/GMzF6VV9UaD44c22VUmHfxaMYzqP3I=;
 b=0UHAtuoa7vOyOeSK+7hvWLfGjxWKVBckmX81zWRwPvVbKyoT7UfuuWxOFnQF4xczzRHRCd
 sI+wgt2elCbNdGBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 581531388C;
 Fri, 19 Jan 2024 16:08:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WsCDFHieqmWmUgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 19 Jan 2024 16:08:24 +0000
Date: Fri, 19 Jan 2024 17:08:34 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <Zaqegt-5Zkm0BJIY@yuki>
References: <20231025083706.13767-1-wegao@suse.com>
 <20240109065904.18117-1-wegao@suse.com>
 <20240109065904.18117-2-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240109065904.18117-2-wegao@suse.com>
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=OvLygIVm;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=0UHAtuoa
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.01 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.00)[13.38%]
X-Rspamd-Queue-Id: 72A5021FDD
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/2] lib: Add .ulimit
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
> +1.43 Set resource limits
> +~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +'.ulimit' allows to set resource limits on particular resource. NOTE: It sets 'rlim_cur'
                                                                                    ^
										    rlim_max?
> +only if it's higher than 'rlim_cur'.
> +
> +[source,c]
> +-------------------------------------------------------------------------------
> +#include "tst_test.h"
> +
> +static struct tst_test test = {
> +	...
> +	.ulimit = (const struct tst_ulimit_val[]) {
> +		{RLIMIT_STACK, RLIM_INFINITY},
> +		{}
> +	},
> +};
> +
>  2. Common problems
>  ------------------
>  
> diff --git a/include/tst_test.h b/include/tst_test.h
> index 0c3171e5b..374a8615c 100644
> --- a/include/tst_test.h
> +++ b/include/tst_test.h
> @@ -15,6 +15,7 @@
>  #include <limits.h>
>  #include <string.h>
>  #include <errno.h>
> +#include <sys/resource.h>
>  
>  #include "tst_common.h"
>  #include "tst_res_flags.h"
> @@ -149,6 +150,11 @@ extern unsigned int tst_variant;
>  
>  #define TST_UNLIMITED_RUNTIME (-1)
>  
> +struct tst_ulimit_val {
> +	int resource;
> +	rlim_t rlim_cur;
> +};
> +
>  struct tst_test {
>  	/* number of tests available in test() function */
>  	unsigned int tcnt;
> @@ -307,6 +313,11 @@ struct tst_test {
>  	 */
>  	const struct tst_path_val *save_restore;
>  
> +	/*
> +	 * {} terminated array of ulimit resource type and value.
> +	 */
> +	const struct tst_ulimit_val *ulimit;
> +
>  	/*
>  	 * NULL terminated array of kernel config options required for the
>  	 * test.
> @@ -393,6 +404,11 @@ int tst_validate_children_(const char *file, const int lineno,
>  #define tst_validate_children(child_count) \
>  	tst_validate_children_(__FILE__, __LINE__, (child_count))
>  
> +/*
> + * Set system resource limits
> + */
> +void tst_set_ulimit_(const char *file, const int lineno, const struct tst_ulimit_val *conf);
> +
>  #ifndef TST_NO_DEFAULT_MAIN
>  
>  static struct tst_test test;
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index bcf2c4555..f5037330a 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -1147,6 +1147,29 @@ static void do_cgroup_requires(void)
>  	tst_cg_init();
>  }
>  
> +#define tst_set_ulimit(conf) \
> +	tst_set_ulimit_(__FILE__, __LINE__, (conf))

If we want this to be part of the API, i.e. allow tests to call this
function directly this should be in the tst_test.h header.

If not, the function should be static and only used in the tst_test.c

> +/*
> + * Set resource limits.
> + */
> +void tst_set_ulimit_(const char *file, const int lineno, const struct tst_ulimit_val *conf)
> +{
> +	struct rlimit rlim;
> +
> +	safe_getrlimit(file, lineno, conf->resource, &rlim);
> +
> +	rlim.rlim_cur = conf->rlim_cur;
> +
> +	if (conf->rlim_cur > rlim.rlim_max)
> +		rlim.rlim_max = conf->rlim_cur;
> +
> +	tst_res_(file, lineno, TINFO, "Set ulimit resource: %d rlim_cur: %lu rlim_max: %lu",
> +		conf->resource, rlim.rlim_cur, rlim.rlim_max);
> +
> +	safe_setrlimit(file, lineno, conf->resource, &rlim);
> +}
> +
>  static void do_setup(int argc, char *argv[])
>  {
>  	char *tdebug_env = getenv("LTP_ENABLE_DEBUG");
> @@ -1252,6 +1275,15 @@ static void do_setup(int argc, char *argv[])
>  		}
>  	}
>  
> +	if (tst_test->ulimit) {
> +		const struct tst_ulimit_val *pvl = tst_test->ulimit;
> +
> +		while (pvl->resource) {
> +			tst_set_ulimit(pvl);
> +			pvl++;
> +		}
> +	}
> +
>  	if (tst_test->mntpoint)
>  		SAFE_MKDIR(tst_test->mntpoint, 0777);

The rest looks good.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
