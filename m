Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2786C30653
	for <ltp@archiver.kernel.org>; Thu,  4 Jul 2024 13:30:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A0DCB3D3D1C
	for <ltp@archiver.kernel.org>; Thu,  4 Jul 2024 15:30:01 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 26ABA3D3CDA
 for <ltp@lists.linux.it>; Thu,  4 Jul 2024 15:29:45 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id DF64F1001162
 for <ltp@lists.linux.it>; Thu,  4 Jul 2024 15:29:44 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3B0A61F7BC;
 Thu,  4 Jul 2024 13:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1720099783; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dGEJvK9dDNOKSmXKwO/y2HLcu/xTkpg3k1WDQZQTrpg=;
 b=n9Ci5K/HbRM1JKp6egQUcpdtYfBwCXcOf0jatkavPhdP5ys3+Np/YmfHTuSDlaV0QvEJee
 EH7gJbVj7jW6wuJB7w/SWMOrz+Ex0io63fAyPxphWeM/JbS0TEDoWCYnIqrLt7yTjVLabT
 SJFrzHnic6rV4F7Kaav/DrtWtR/MFwg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1720099783;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dGEJvK9dDNOKSmXKwO/y2HLcu/xTkpg3k1WDQZQTrpg=;
 b=uyFTsjKV2jx7YkgK8HTz4glMfes+wEC9tpI+Pc1ptjPTmcDPPAEiPN9hvSMyRGfk1mYgmO
 v8wU23y2lX6qCWAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1720099783; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dGEJvK9dDNOKSmXKwO/y2HLcu/xTkpg3k1WDQZQTrpg=;
 b=n9Ci5K/HbRM1JKp6egQUcpdtYfBwCXcOf0jatkavPhdP5ys3+Np/YmfHTuSDlaV0QvEJee
 EH7gJbVj7jW6wuJB7w/SWMOrz+Ex0io63fAyPxphWeM/JbS0TEDoWCYnIqrLt7yTjVLabT
 SJFrzHnic6rV4F7Kaav/DrtWtR/MFwg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1720099783;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dGEJvK9dDNOKSmXKwO/y2HLcu/xTkpg3k1WDQZQTrpg=;
 b=uyFTsjKV2jx7YkgK8HTz4glMfes+wEC9tpI+Pc1ptjPTmcDPPAEiPN9hvSMyRGfk1mYgmO
 v8wU23y2lX6qCWAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2B37C1369F;
 Thu,  4 Jul 2024 13:29:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EYe4CcejhmZ4IAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 04 Jul 2024 13:29:43 +0000
Date: Thu, 4 Jul 2024 15:29:35 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: lufei <lufei@uniontech.com>
Message-ID: <Zoajv8Y1HEbjvhmh@yuki>
References: <20240606065506.1686-1-lufei@uniontech.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240606065506.1686-1-lufei@uniontech.com>
X-Spamd-Result: default: False [-3.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] acct01: add EFAULT errno check
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
> 1. add EFAULT errno check.
> 2. fix make check errors and warnings.

Can you please split the functional changes and make chek fixes into
separate tests?

Ideally each type of change should be put into a separate patch.

> Signed-off-by: lufei <lufei@uniontech.com>
> ---
>  testcases/kernel/syscalls/acct/acct01.c | 31 +++++++++++++++++--------
>  testcases/kernel/syscalls/acct/acct02.c |  2 +-
>  2 files changed, 22 insertions(+), 11 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/acct/acct01.c b/testcases/kernel/syscalls/acct/acct01.c
> index a05ed2ea9..ed1817bc5 100644
> --- a/testcases/kernel/syscalls/acct/acct01.c
> +++ b/testcases/kernel/syscalls/acct/acct01.c
> @@ -25,8 +25,7 @@
>  
>  #include "tst_test.h"
>  
> -#define DIR_MODE	(S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP| \
> -			 S_IXGRP|S_IROTH|S_IXOTH)
> +#define DIR_MODE	0755
>  #define FILE_EISDIR		"."
>  #define FILE_EACCESS		"/dev/null"
>  #define FILE_ENOENT		"/tmp/does/not/exist"
> @@ -34,6 +33,7 @@
>  #define FILE_TMPFILE		"./tmpfile"
>  #define FILE_ELOOP		"test_file_eloop1"
>  #define FILE_EROFS		"ro_mntpoint/file"
> +#define FILE_EFAULT		"/tmp/invalid/file/name"
>  
>  static struct passwd *ltpuser;
>  
> @@ -46,6 +46,7 @@ static char *file_eloop;
>  static char *file_enametoolong;
>  static char *file_erofs;
>  static char *file_null;
> +static char *file_efault;
>  
>  static void setup_euid(void)
>  {
> @@ -57,12 +58,22 @@ static void cleanup_euid(void)
>  	SAFE_SETEUID(0);
>  }
>  
> +static void setup_emem(void)
> +{
> +	file_efault = SAFE_MMAP(NULL, 1, PROT_NONE,
> +			MAP_ANONYMOUS | MAP_PRIVATE, 0, 0);
> +}
> +static void cleanup_emem(void)
> +{
> +	SAFE_MUNMAP(file_efault, 1);
> +}
> +
>  static struct test_case {
>  	char **filename;
>  	char *desc;
>  	int exp_errno;
> -	void (*setupfunc) ();
> -	void (*cleanfunc) ();
> +	void (*setupfunc)();
> +	void (*cleanfunc)();
>  } tcases[] = {
>  	{&file_eisdir,  FILE_EISDIR,  EISDIR,  NULL,   NULL},
>  	{&file_eaccess, FILE_EACCESS, EACCES,  NULL,   NULL},
> @@ -73,16 +84,13 @@ static struct test_case {
>  	{&file_eloop,   FILE_ELOOP,   ELOOP,        NULL, NULL},
>  	{&file_enametoolong, "aaaa...", ENAMETOOLONG, NULL, NULL},
>  	{&file_erofs,   FILE_EROFS,   EROFS,        NULL, NULL},
> +	{&file_efault,	FILE_EFAULT,  EFAULT,  setup_emem, cleanup_emem},
                         ^
			 This should actually describe the testcase so
			 it should be something as "Invalid address"

>  };
>  
>  static void setup(void)
>  {
>  	int fd;
>  
> -	TEST(acct(NULL));
> -	if (TST_RET == -1 && TST_ERR == ENOSYS)
> -		tst_brk(TCONF, "acct() system call isn't configured in kernel");
> -
>  	ltpuser = SAFE_GETPWNAM("nobody");
>  
>  	fd = SAFE_CREAT(FILE_TMPFILE, 0777);
> @@ -113,7 +121,7 @@ static void verify_acct(unsigned int nr)
>  		tcase->setupfunc();
>  
>  	TST_EXP_FAIL(acct(*tcase->filename), tcase->exp_errno,
> -	             "acct(%s)", tcase->desc);
> +			"acct(%s)", tcase->desc);
>  
>  	if (tcase->cleanfunc)
>  		tcase->cleanfunc();
> @@ -136,5 +144,8 @@ static struct tst_test test = {
>  		{&file_enametoolong, .size = PATH_MAX+2},
>  		{&file_erofs, .str = FILE_EROFS},
>  		{}
> -	}
> +	},
> +	.needs_kconfigs = (const char *[]) {
> +		"CONFIG_BSD_PROCESS_ACCT=y",
> +	},
>  };

And this is a different change that is not described in the patch
description. So this patch should be actually split into three patches,
one that adds errno check, one that adds needs_kconfigs and one that
fixes make check errors.

> diff --git a/testcases/kernel/syscalls/acct/acct02.c b/testcases/kernel/syscalls/acct/acct02.c
> index d3f3d9d04..74019f430 100644
> --- a/testcases/kernel/syscalls/acct/acct02.c
> +++ b/testcases/kernel/syscalls/acct/acct02.c
> @@ -186,7 +186,7 @@ static void run(void)
>  
>  		if (read_bytes != acct_size) {
>  			tst_res(TFAIL, "incomplete read %i bytes, expected %i",
> -			        read_bytes, acct_size);
> +					read_bytes, acct_size);
>  			goto exit;
>  		}
>  
> -- 
> 2.39.3
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
