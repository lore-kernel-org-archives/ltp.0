Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 383A0C282EC
	for <ltp@archiver.kernel.org>; Thu,  6 Mar 2025 12:46:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 954CD3C9FA8
	for <ltp@archiver.kernel.org>; Thu,  6 Mar 2025 13:46:15 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 65B723C9FA8
 for <ltp@lists.linux.it>; Thu,  6 Mar 2025 13:45:57 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7F921600567
 for <ltp@lists.linux.it>; Thu,  6 Mar 2025 13:45:55 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9E14C211AD;
 Thu,  6 Mar 2025 12:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1741265154; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XLzRpHX1WvIQo3+3pmVVIyC1+UezwSaDQjLfZxLiP2I=;
 b=CbHMB3kkSdUJa5z5aUVfWu4MIXQcROt+HpT0yt0C9TiEov5dmT98sOElgI9Z2OHi/aqXiy
 xU9YLqQK/FXucq+59onqhf+nyQhQdj+nqBNdrCM9I1BuusV3JBHBhzI12SWUESR6hc1jcb
 wz/WQPdMEN0MozuIjFrmo9WGmBM+zVY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1741265154;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XLzRpHX1WvIQo3+3pmVVIyC1+UezwSaDQjLfZxLiP2I=;
 b=/8lrJ4RCfxLgtHRTcH7fa0JW2KGlGc2DWu6LeHI0iqfcXesNhYQyccQ0p8McZ6eqVb/TV+
 VUvODlCMu4KCrRDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1741265154; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XLzRpHX1WvIQo3+3pmVVIyC1+UezwSaDQjLfZxLiP2I=;
 b=CbHMB3kkSdUJa5z5aUVfWu4MIXQcROt+HpT0yt0C9TiEov5dmT98sOElgI9Z2OHi/aqXiy
 xU9YLqQK/FXucq+59onqhf+nyQhQdj+nqBNdrCM9I1BuusV3JBHBhzI12SWUESR6hc1jcb
 wz/WQPdMEN0MozuIjFrmo9WGmBM+zVY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1741265154;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XLzRpHX1WvIQo3+3pmVVIyC1+UezwSaDQjLfZxLiP2I=;
 b=/8lrJ4RCfxLgtHRTcH7fa0JW2KGlGc2DWu6LeHI0iqfcXesNhYQyccQ0p8McZ6eqVb/TV+
 VUvODlCMu4KCrRDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8ABD513676;
 Thu,  6 Mar 2025 12:45:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Y+DWIAKZyWfuWAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 06 Mar 2025 12:45:54 +0000
Date: Thu, 6 Mar 2025 13:46:10 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <Z8mZEusCgpf6JTKz@yuki.lan>
References: <20250127-xattrat-v1-0-c3ee31e2543b@suse.com>
 <20250127-xattrat-v1-3-c3ee31e2543b@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250127-xattrat-v1-3-c3ee31e2543b@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.978]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/8] setxattr01: add setxattrat variant
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
> diff --git a/testcases/kernel/syscalls/setxattr/setxattr01.c b/testcases/kernel/syscalls/setxattr/setxattr01.c
> index de3ea67ec4000905651f20e2684a6b0aef493da7..67b053c4a2593df6cd2800c5450b5951ff78ae0d 100644
> --- a/testcases/kernel/syscalls/setxattr/setxattr01.c
> +++ b/testcases/kernel/syscalls/setxattr/setxattr01.c
> @@ -36,6 +36,8 @@
>  # include <sys/xattr.h>
>  #endif
>  #include "tst_test.h"
> +#include "lapi/syscalls.h"
> +#include "lapi/xattr.h"
>  
>  #ifdef HAVE_SYS_XATTR_H
>  #define XATTR_NAME_MAX 255
> @@ -45,11 +47,13 @@
>  #define XATTR_TEST_VALUE "this is a test value"
>  #define XATTR_TEST_VALUE_SIZE 20
>  #define MNTPOINT "mntpoint"
> -#define FNAME MNTPOINT"/setxattr01testfile"
> +#define FNAME_REL "setxattr01testfile"
> +#define FNAME MNTPOINT"/"FNAME_REL
>  
>  static char long_key[XATTR_NAME_LEN];
>  static char *long_value;
>  static char *xattr_value = XATTR_TEST_VALUE;
> +static int mnt_fd = -1;
>  
>  struct test_case {
>  	char *key;
> @@ -128,44 +132,65 @@ struct test_case tc[] = {
>  
>  static void verify_setxattr(unsigned int i)
>  {
> +	char *sysname;
> +
>  	/* some tests might require existing keys for each iteration */
>  	if (tc[i].keyneeded) {
>  		SAFE_SETXATTR(FNAME, tc[i].key, *tc[i].value, tc[i].size,
>  				XATTR_CREATE);
>  	}
>  
> -	TEST(setxattr(FNAME, tc[i].key, *tc[i].value, tc[i].size, tc[i].flags));
> +	if (tst_variant) {
> +		sysname = "setxattrat";
> +
> +		struct xattr_args args = {
> +			.value = tc[i].value,
> +			.size = tc[i].size,
> +			.flags = tc[i].flags,
> +		};
> +
> +		TEST(tst_syscall(__NR_setxattrat,
> +			mnt_fd, FNAME_REL, AT_SYMLINK_NOFOLLOW,
> +			tc[i].key, &args, sizeof(args)));

The setxattrat() function should be put into the lapi/setxattr.h and
enabled only if configure script didn't find setxattrat() in the
sys/setxattr.h. That way we will switch to the system definition of the
function once it's available.

Any time we are adding tests for syscalls that are not in the libc now
but will end up there in the future we have to do this:

* Add AC_CHECK_FUNC() into configure
* Add syscall wrapper inside ifndef HAVE_FUNC block into respective lapi header
* Include the lapi header in the test
* Call the function as func() and not by tst_syscall(__NR_func, ...)

> +	} else {
> +		sysname = "setxattr";
> +
> +		TEST(setxattr(
> +			FNAME,
> +			tc[i].key, *tc[i].value, tc[i].size,
> +			tc[i].flags));
> +	}

This pattern repeats in several tests, so it would make more sense to
write a wrapper that would call the respective syscall based on
tst_variant and put it into a common header. i.e.

static inline int call_setxattr(const char *fname, const char *name,
                                const void *value, size_t line, int flags)
{
	if (tst_variant) {
		struct xattr_args args = {
			.value = tc[i].value,
			.size = tc[i].size,
			.flags = tc[i].flags,
		};

		return setxattrat(...);
	} else {
		return setxattr(...);
	}
}

>  	if (TST_RET == -1 && TST_ERR == EOPNOTSUPP)
> -		tst_brk(TCONF, "setxattr(2) not supported");
> +		tst_brk(TCONF, "%s(2) not supported", sysname);
>  
>  	/* success */
>  
>  	if (!tc[i].exp_err) {
>  		if (TST_RET) {
>  			tst_res(TFAIL | TTERRNO,
> -				"setxattr(2) failed with %li", TST_RET);
> +				"%s(2) failed with %li", sysname, TST_RET);
>  			return;
>  		}
>  
>  		/* this is needed for subsequent iterations */
>  		SAFE_REMOVEXATTR(FNAME, tc[i].key);
>  
> -		tst_res(TPASS, "setxattr(2) passed");
> +		tst_res(TPASS, "%s(2) passed", sysname);
>  
>  		return;
>  	}
>  
>  	if (TST_RET == 0) {
> -		tst_res(TFAIL, "setxattr(2) passed unexpectedly");
> +		tst_res(TFAIL, "%s(2) passed unexpectedly", sysname);
>  		return;
>  	}
>  
>  	/* error */
>  
>  	if (tc[i].exp_err != TST_ERR) {
> -		tst_res(TFAIL | TTERRNO, "setxattr(2) should fail with %s",
> -			tst_strerrno(tc[i].exp_err));
> +		tst_res(TFAIL | TTERRNO, "%s(2) should fail with %s",
> +			sysname, tst_strerrno(tc[i].exp_err));
>  		return;
>  	}
>  
> @@ -173,7 +198,7 @@ static void verify_setxattr(unsigned int i)
>  	if (tc[i].keyneeded)
>  		SAFE_REMOVEXATTR(FNAME, tc[i].key);
>  
> -	tst_res(TPASS | TTERRNO, "setxattr(2) failed");
> +	tst_res(TPASS | TTERRNO, "%s(2) failed", sysname);
>  }
>  
>  static void setup(void)
> @@ -194,12 +219,22 @@ static void setup(void)
>  		if (!tc[i].key)
>  			tc[i].key = tst_get_bad_addr(NULL);
>  	}
> +
> +	mnt_fd = SAFE_OPEN(MNTPOINT, O_DIRECTORY);
> +}
> +
> +static void cleanup(void)
> +{
> +	if (mnt_fd != -1)
> +		SAFE_CLOSE(mnt_fd);
>  }
>  
>  static struct tst_test test = {
>  	.setup = setup,
> +	.cleanup = cleanup,
>  	.test = verify_setxattr,
>  	.tcnt = ARRAY_SIZE(tc),
> +	.test_variants = 2,
>  	.mntpoint = MNTPOINT,
>  	.mount_device = 1,
>  	.all_filesystems = 1,
> 
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
