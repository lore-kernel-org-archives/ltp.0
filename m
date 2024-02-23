Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A4EBC5478C
	for <ltp@archiver.kernel.org>; Fri, 23 Feb 2024 11:48:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 913373CF658
	for <ltp@archiver.kernel.org>; Fri, 23 Feb 2024 12:48:41 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F06A23CF110
 for <ltp@lists.linux.it>; Fri, 23 Feb 2024 12:48:25 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5A342200AE7
 for <ltp@lists.linux.it>; Fri, 23 Feb 2024 12:48:24 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8CCD11FBF1;
 Fri, 23 Feb 2024 11:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708688903;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GaDwjn4iS4+2vCLCLVU+BLHlKJOuoR8AuqGuB58mybQ=;
 b=bsY52p/TnEq75L93vCw0hjg7sHKGnhJB4no2ETvKzH5FIswgZrt36wG9XVCZouvvlqAjdK
 3BFIqZHPCu4pY8EyKzCed6vvc56YsgcAkLyK3EzJK4JuncM5QLu3Ellw5c/yPdauvqOb2c
 1jh54LLpAJCms8sMiihMHzkZC6VujeM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708688903;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GaDwjn4iS4+2vCLCLVU+BLHlKJOuoR8AuqGuB58mybQ=;
 b=TcYY7s+OA3RbziGJUc9710cWmxAJPRQQrcCejVPSlP+LN349k0cKUrS5iRSdMsjb+0tLc2
 gVRbvGfhjGKwvuAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708688903;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GaDwjn4iS4+2vCLCLVU+BLHlKJOuoR8AuqGuB58mybQ=;
 b=bsY52p/TnEq75L93vCw0hjg7sHKGnhJB4no2ETvKzH5FIswgZrt36wG9XVCZouvvlqAjdK
 3BFIqZHPCu4pY8EyKzCed6vvc56YsgcAkLyK3EzJK4JuncM5QLu3Ellw5c/yPdauvqOb2c
 1jh54LLpAJCms8sMiihMHzkZC6VujeM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708688903;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GaDwjn4iS4+2vCLCLVU+BLHlKJOuoR8AuqGuB58mybQ=;
 b=TcYY7s+OA3RbziGJUc9710cWmxAJPRQQrcCejVPSlP+LN349k0cKUrS5iRSdMsjb+0tLc2
 gVRbvGfhjGKwvuAQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 55DBE13776;
 Fri, 23 Feb 2024 11:48:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id n6SmDweG2GUAYwAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Fri, 23 Feb 2024 11:48:23 +0000
Date: Fri, 23 Feb 2024 12:48:17 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <20240223114817.GH1423688@pevik>
References: <20240220074218.13487-1-xuyang2018.jy@fujitsu.com>
 <20240220074218.13487-6-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240220074218.13487-6-xuyang2018.jy@fujitsu.com>
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="bsY52p/T";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=TcYY7s+O
X-Spamd-Result: default: False [-2.51 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 8CCD11FBF1
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 6/7] syscalls/swapon03: Simply this case
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

Hi Yang Xu,

> By moving swapfile create stage from verify_swaopon and
> test EPERM error more accurate. Also use glibc wrapper by

> using swapon/swapoff instead of call syscall number directly
> because glibc/musl/binoic also support them since long time ago.
+1 thanks for checking.

FYI uClibc-ng only support with UCLIBC_LINUX_SPECIFIC config enabled, but it's
by default enabled. And I guess nobody runs uClibc-ng on Linux without this
enabled => really safe to depend on libc wrapper.

...
> +			TST_EXP_PASS_SILENT(swapon(filename, 0));
+1

>  		}
>  		exit(0);
>  	} else
> @@ -145,13 +61,40 @@ static int setup_swap(void)
>  	if (WEXITSTATUS(status))
>  		tst_brk(TFAIL, "Failed to setup swaps");
nit: s/swaps/swap files/

> -	/* Create all needed extra swapfiles for testing */
> -	for (j = 0; j < testfiles; j++)
> -		make_swapfile(swap_testfiles[j].filename, 10, 0);
> +	tst_res(TINFO, "Successfully created %d swapfiles", swapfiles);
nit: s/swapfiles/swap files/

> +	make_swapfile(TEST_FILE, 10, 0);

>  	return 0;
>  }

> +/*
> + * Check if the file is at /proc/swaps and remove it giving swapoff
> + */
> +static int check_and_swapoff(const char *filename)
> +{
> +	char cmd_buffer[256];
> +	int rc = -1;
> +
> +	if (snprintf(cmd_buffer, sizeof(cmd_buffer),
> +		"grep -q '%s.*file' /proc/swaps", filename) < 0) {
> +		tst_res(TWARN, "sprintf() failed to create the command string");
nit: we don't have SAFE_SNPRINTF() and don't even check snprintf() / sprintf()
return value. Shouldn't we add SAFE_SNPRINTF() which TBROK?
This can be handled later, thus I would here either use plain snprintf() or
tst_brk(TBROK).

if you add return -1 here, the following block does not have to be in else
(=> fewer indentation => text can be longer fewer string splits).

> +	} else {
> +		rc = 0;
> +		if (system(cmd_buffer) == 0) {
> +			/* now we need to swapoff the file */
> +			if (swapoff(filename) != 0) {

Why not single if?
		if (system(cmd_buffer) == 0) && swapoff(filename) != 0) {

> +				tst_res(TWARN, "Failed to turn off swap "
> +					"file. system reboot after "
> +					"execution of LTP test suite "
> +					"is recommended");
Then this string would not need to be split several times (bad for searching
with 'git grep'). Maybe shorten just to
"Failed to swapoff %", filename"
=> more important than suggest to reboot (which is obvious) is to point out
problematic swap file, which was kept on.


> +				rc = -1;
> +			}
> +		}
> +	}
> +
> +	return rc;
> +}
> +
>  /*
>   * Turn off all swapfiles previously turned on
>   */
> @@ -169,49 +112,17 @@ static int clean_swap(void)
Return code of clean_swap() is not used. How about to make it void?
>  		}
>  	}

> -	for (j = 0; j < testfiles; j++) {
> -		if (check_and_swapoff(swap_testfiles[j].filename) != 0) {
> -			tst_res(TWARN, "Failed to turn off swap file %s.",
> -				 swap_testfiles[j].filename);
> -			return -1;
> -		}
> +	if (check_and_swapoff("testfile") != 0) {
> +		tst_res(TWARN, "Failed to turn off swap file testfile");
We have the warning in the function, why also here?
> +		return -1;
>  	}

>  	return 0;
>  }

...
> +static void verify_swapon(void)
>  {
> +	TST_EXP_FAIL(swapon(TEST_FILE, 0), EPERM, "swapon(%s, 0)", TEST_FILE);
+1

Kind regards,
Petr
>  }

>  static void setup(void)
> @@ -220,6 +131,11 @@ static void setup(void)
>  		tst_brk(TCONF, "swap not supported by kernel");

>  	is_swap_supported(TEST_FILE);
> +
> +	if (setup_swap() < 0) {
> +		clean_swap();
> +		tst_brk(TBROK, "Setup failed, quitting the test");
> +	}

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
