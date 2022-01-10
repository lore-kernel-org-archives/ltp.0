Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36DF1C433EF
	for <ltp@archiver.kernel.org>; Mon, 10 Jan 2022 15:17:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 211763C93A8
	for <ltp@archiver.kernel.org>; Mon, 10 Jan 2022 16:17:20 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CC8D13C0233
 for <ltp@lists.linux.it>; Mon, 10 Jan 2022 16:17:01 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 73BD8600712
 for <ltp@lists.linux.it>; Mon, 10 Jan 2022 16:17:01 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D31451F393;
 Mon, 10 Jan 2022 15:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1641827820; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0+nmA+Q+mS4MrT5h+/hQueUnJTlF0Fqrsfr4BiNx9UM=;
 b=MBSWJ3kXIV00a2Cn2vbLgAUG3jyJIeEz2Hlcy/Q8xhfIICkjPou4S4/CBMvQugOpCLy46o
 9IirpjdVTqe34zl2sbOEryevSTdOL1OFTWwHu0vjAd0lfEoeg4CgLRZjMcj4f9lioyhv1U
 cdWGR5rfNWTl/xkn+HOI+3++NxC/GfE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1641827820;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0+nmA+Q+mS4MrT5h+/hQueUnJTlF0Fqrsfr4BiNx9UM=;
 b=wUGdZ6Plytev0tMPjqoZoDffysHBE67kEs64i/rmLC6/ZicWKMJNPWdPcA7ExQfGM2zVZ5
 5jTTuZckfPY5haAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BC42213D9D;
 Mon, 10 Jan 2022 15:17:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id dMZ/LOxN3GE/dwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 10 Jan 2022 15:17:00 +0000
Date: Mon, 10 Jan 2022 16:18:35 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YdxOS6zEp3KwY63X@yuki>
References: <20211213132339.22770-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211213132339.22770-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] chdir01.c: Fix on enabled FIPS
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
> which causes 0 permission for user and group.

This could be a bit more verbose.

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/kernel/syscalls/chdir/chdir01.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/chdir/chdir01.c b/testcases/kernel/syscalls/chdir/chdir01.c
> index aa25adf6aa..5819998484 100644
> --- a/testcases/kernel/syscalls/chdir/chdir01.c
> +++ b/testcases/kernel/syscalls/chdir/chdir01.c
> @@ -27,7 +27,7 @@
>  #define LINK_NAME2 "symloop2"
>  
>  static char *workdir;
> -static int skip_symlinks, skip_blocked;
> +static int skip_symlinks, blocked_perm;
>  static struct passwd *ltpuser;
>  
>  static struct test_case {
> @@ -61,9 +61,9 @@ static void setup(void)
>  	SAFE_MKDIR(BLOCKED_NAME, 0644);
>  	umask(sys_umask);
>  
> -	/* FAT and NTFS override file and directory permissions */
>  	SAFE_STAT(BLOCKED_NAME, &statbuf);
> -	skip_blocked = statbuf.st_mode & 0111;
> +	blocked_perm = statbuf.st_mode;
> +
>  	skip_symlinks = 0;
>  	TEST(symlink(LINK_NAME1, LINK_NAME2));
>  
> @@ -117,7 +117,15 @@ static void run(unsigned int n)
>  	TEST(chdir(tc->name));
>  	check_result("root", tc->name, tc->root_ret, tc->root_err);
>  
> -	if (tc->nobody_err == EACCES && skip_blocked) {
> +	/* FIPS mode disables umask efect for group or other */
> +	if (!(blocked_perm & S_IRGRP) && strcmp(tc->name, "/") != 0) {

So on FIPS the directories we create have zeroed group and other flags
regardless of the umask? Or is this just a different default umask on
FIPS? If it's just different umask the easiest solution would be
changing the umask in the test setup.

And if it's regardless of umask settings shouldn't this rather be:

	if (tst_fips_enabled() && !strcmp(tc->name, "/"))


> +		tst_res(TCONF, "Skipping unprivileged permission test, "
> +			"no read permission for \"%s\"", tc->name);
> +		return;
> +	}
> +
> +	/* FAT and NTFS override file and directory permissions */
> +	if (blocked_perm & 0111 && tc->nobody_err == EACCES) {
>  		tst_res(TCONF, "Skipping unprivileged permission test, "
>  			"FS mangles dir mode");
>  		return;
> -- 
> 2.34.1
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
