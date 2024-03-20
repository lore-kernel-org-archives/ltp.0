Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65665C54E58
	for <ltp@archiver.kernel.org>; Wed, 20 Mar 2024 16:34:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 881183D003E
	for <ltp@archiver.kernel.org>; Wed, 20 Mar 2024 17:34:33 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 43E1A3CFBF2
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 17:34:18 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8EA2861338C
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 17:34:17 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 019A6347AE;
 Wed, 20 Mar 2024 16:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710952456;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ys9vtMTMIOGrQ+Xwr5Grn4jQcyUClM7F+OJqX+A8PzM=;
 b=ZgWiflzZ1m4kcwfcQp5cNUxFNQkDTMt4CSJvCVtWmd3N5DNkrl3aG+yP9qfyWuRVx689kX
 CdGz8ev+6IAXECGI/Gz7fUqRQPapa1q6Nn+s2bJacbl2xb5oio1KIG4Q6cGp4IZCExyZb3
 AFFzD48rYB94t346MsNkYMc2/8wDtlU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710952456;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ys9vtMTMIOGrQ+Xwr5Grn4jQcyUClM7F+OJqX+A8PzM=;
 b=x7DzDWeBDUa96rpIk+EimtOyullnUbGvmJ4Fp3CnYySf9sEKYgqucbkd6p72X9etE8qRXQ
 8YKbgvEgZlW5YBBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710952456;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ys9vtMTMIOGrQ+Xwr5Grn4jQcyUClM7F+OJqX+A8PzM=;
 b=ZgWiflzZ1m4kcwfcQp5cNUxFNQkDTMt4CSJvCVtWmd3N5DNkrl3aG+yP9qfyWuRVx689kX
 CdGz8ev+6IAXECGI/Gz7fUqRQPapa1q6Nn+s2bJacbl2xb5oio1KIG4Q6cGp4IZCExyZb3
 AFFzD48rYB94t346MsNkYMc2/8wDtlU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710952456;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ys9vtMTMIOGrQ+Xwr5Grn4jQcyUClM7F+OJqX+A8PzM=;
 b=x7DzDWeBDUa96rpIk+EimtOyullnUbGvmJ4Fp3CnYySf9sEKYgqucbkd6p72X9etE8qRXQ
 8YKbgvEgZlW5YBBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C82A4136D6;
 Wed, 20 Mar 2024 16:34:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id nzBzLgcQ+2WiagAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 20 Mar 2024 16:34:15 +0000
Date: Wed, 20 Mar 2024 17:34:14 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Message-ID: <20240320163414.GA496781@pevik>
References: <20240121161159.4106646-2-ruansy.fnst@fujitsu.com>
 <20240314101344.4000544-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240314101344.4000544-1-ruansy.fnst@fujitsu.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-3.50 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] getxattr01: Convert to new API
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> ---
> Changes since v1:
> 1. removed comments above tcases;
> 2. simplified check logic;
> 3. replaced close() with SAFE_CLOSE();
> 4. Description: merged the 4th point into the 3rd one according to
>    the check logic;

...

#ifdef HAVE_SYS_XATTR_H
Please remove this check, we always have <sys/xattr.h>.

> +#define XATTR_TEST_NOKEY	"user.nosuchkey"
> +#define XATTR_TEST_KEY		"user.testkey"
> +#define XATTR_TEST_VALUE	"this is a test value"
> +#define XATTR_TEST_VALUE_SIZE	20
> +#define BUFFSIZE		64

> -char filename[BUFSIZ];
> +static char filename[BUFSIZ];

> -struct test_case {
> +static struct tcase {
>  	char *fname;
>  	char *key;
>  	char *value;
>  	size_t size;
>  	int exp_err;
> +} tcases[] = {
> +	{ filename, XATTR_TEST_NOKEY, NULL, BUFFSIZE - 1, ENODATA },
> +	{ filename, XATTR_TEST_KEY, NULL, 1, ERANGE },
> +	{ filename, XATTR_TEST_KEY, NULL, BUFFSIZE - 1, 0 },

If .fname is always filename, why to pass it via test struct?
The same applies for .value (always NULL).

NOTE, this is ok, but if there were a lot of more struct members and some of
them would be 0 or NULL, we'd prefer to initialize it as:

{ .key = XATTR_TEST_NOKEY, .size = BUFFSIZE - 1, .exp_err = ENODATA },
{ .key = XATTR_TEST_KEY, .size = 1, .exp_err = ERANGE },
{ .key = XATTR_TEST_KEY, .size = BUFFSIZE - 1 }

This way it would be possible to avoid many NULL or 0.

...
> +	struct tcase *tc = &tcases[n];
> +
> +	if (tc->exp_err == 0) {
> +		TST_EXP_VAL(getxattr(tc->fname, tc->key, tc->value, tc->size),
> +			    XATTR_TEST_VALUE_SIZE);

> +		if (memcmp(tc->value, XATTR_TEST_VALUE, XATTR_TEST_VALUE_SIZE))
> +			tst_res(TFAIL, "Wrong value, expect \"%s\" got \"%s\"",
instead of \", more readable is to use '.

> +				XATTR_TEST_VALUE, tc->value);
>  		else
> -			tst_resm(TPASS, "Got the right value");
> +			tst_res(TPASS, "getxattr() retrieved expected value");
> +	} else {
> +		TST_EXP_FAIL(getxattr(tc->fname, tc->key, tc->value, tc->size),
> +			     tc->exp_err);
>  	}

>  static void setup(void)
> @@ -144,41 +69,36 @@ static void setup(void)
>  	int fd;
>  	unsigned int i;

> -	tst_require_root();
> -
> -	tst_tmpdir();
> -
>  	/* Create test file and setup initial xattr */
>  	snprintf(filename, BUFSIZ, "getxattr01testfile");
> -	fd = SAFE_CREAT(cleanup, filename, 0644);
> -	close(fd);
> -	if (setxattr(filename, XATTR_TEST_KEY, XATTR_TEST_VALUE,
> -		     strlen(XATTR_TEST_VALUE), XATTR_CREATE) == -1) {
> -		if (errno == ENOTSUP) {
> -			tst_brkm(TCONF, cleanup, "No xattr support in fs or "
> -				 "mount without user_xattr option");
> -		}
> -	}
> +	fd = SAFE_CREAT(filename, 0644);
> +	SAFE_CLOSE(fd);

...
> +	for (i = 0; i < ARRAY_SIZE(tcases); i++)
> +		tcases[i].value = SAFE_MALLOC(BUFFSIZE);
>  }

>  static void cleanup(void)
>  {
> -	tst_rmdir();
> +	unsigned int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(tcases); i++)
> +		if (tcases[i].value != NULL)
Shouldn't be free() unconditional (always)?

> +			free(tcases[i].value);
>  }
> +
> +static struct tst_test test = {
> +	.needs_tmpdir = 1,
> +	.needs_root = 1,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.test = run,
> +};
> +
>  #else /* HAVE_SYS_XATTR_H */
> -int main(int argc, char *argv[])
> -{
> -	tst_brkm(TCONF, NULL, "<sys/xattr.h> does not exist.");
> -}
> +	TST_TEST_TCONF("<sys/xattr.h> does not exist.");
This is to be removed (as noted up).
>  #endif

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
