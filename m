Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F255CC4828D
	for <ltp@archiver.kernel.org>; Wed,  7 Feb 2024 16:18:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5C7253CF581
	for <ltp@archiver.kernel.org>; Wed,  7 Feb 2024 17:18:20 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E63DB3C12A7
 for <ltp@lists.linux.it>; Wed,  7 Feb 2024 17:18:05 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5ABF41B61FE6
 for <ltp@lists.linux.it>; Wed,  7 Feb 2024 17:18:04 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7D7F02231C;
 Wed,  7 Feb 2024 16:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707322683;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lBfzzyJU/sGt9o0Wl0cD62Herr3KDnz+nvrKJUDLmxo=;
 b=qPaK54JpTDv1gOu90I9fVyS4zPBKlmNG5qZl4dnphGZsNyGPHEmwmDK9UfTZwtiEK+fvbO
 LNkykG6j1TZaEJrkEP3e3rue5FHyi6zhYh2KKix7FE5jG6k9RThxhr0LZ2fJVzW9K1DPhS
 RoqTHEFKYkNhdhkBeb6oeCT0bcA3+QY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707322683;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lBfzzyJU/sGt9o0Wl0cD62Herr3KDnz+nvrKJUDLmxo=;
 b=Eh2UqH6vsZJihwO7b/NrN0HAOqDdeJK06bfsVTLueOGlwdR6/CrYonKQoWM2IyvH95Sn0X
 K355GWw1Nn8UI+Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707322683;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lBfzzyJU/sGt9o0Wl0cD62Herr3KDnz+nvrKJUDLmxo=;
 b=qPaK54JpTDv1gOu90I9fVyS4zPBKlmNG5qZl4dnphGZsNyGPHEmwmDK9UfTZwtiEK+fvbO
 LNkykG6j1TZaEJrkEP3e3rue5FHyi6zhYh2KKix7FE5jG6k9RThxhr0LZ2fJVzW9K1DPhS
 RoqTHEFKYkNhdhkBeb6oeCT0bcA3+QY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707322683;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lBfzzyJU/sGt9o0Wl0cD62Herr3KDnz+nvrKJUDLmxo=;
 b=Eh2UqH6vsZJihwO7b/NrN0HAOqDdeJK06bfsVTLueOGlwdR6/CrYonKQoWM2IyvH95Sn0X
 K355GWw1Nn8UI+Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0F82413931;
 Wed,  7 Feb 2024 16:18:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id is6kATutw2VfTAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 07 Feb 2024 16:18:03 +0000
Date: Wed, 7 Feb 2024 17:17:56 +0100
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <20240207161756.GA128563@pevik>
References: <20240207160628.125908-1-pvorel@suse.cz>
 <20240207160628.125908-2-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240207160628.125908-2-pvorel@suse.cz>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-0.50 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_SEVEN(0.00)[7];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/4] lib/tst_tmpdir: Normalize user defined TMPDIR
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

> Follow the changes to shell API 273c49793 ("tst_test.sh: Remove possible
> double/trailing slashes from TMPDIR") and remove: 1) trailing slash
> 2) double slashes.

> This is needed, because some tests compare file path of files which are
> in TMPDIR with strcmp() or and extra slashes break it (e.g. chdir01A,
> ioctl_loop0[12], mount0[67]).

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  lib/tst_tmpdir.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)

> diff --git a/lib/tst_tmpdir.c b/lib/tst_tmpdir.c
> index b73b5c66f..bc9351251 100644
> --- a/lib/tst_tmpdir.c
> +++ b/lib/tst_tmpdir.c
> @@ -124,7 +124,8 @@ char *tst_get_tmpdir(void)

>  const char *tst_get_tmpdir_root(void)
>  {
> -	const char *env_tmpdir = getenv("TMPDIR");
> +	char *p, *env_tmpdir = getenv("TMPDIR");
> +	int fixed = 0;

>  	if (!env_tmpdir)
>  		env_tmpdir = TEMPDIR;
> @@ -134,6 +135,23 @@ const char *tst_get_tmpdir_root(void)
>  				"pathname for environment variable TMPDIR");
>  		return NULL;
>  	}
> +
> +	if (env_tmpdir[strlen(env_tmpdir)-1] == '/') {
> +		env_tmpdir[strlen(env_tmpdir)-1] = '\0';
> +		fixed = 1;
> +	}
Actually, this above supposed to be after removing double slash (in case people
are crazy to put /// or more in the end, see patch bellow.

I'm sorry for the noise.

Kind regards,
Petr

> +
> +	while ((p = strstr(env_tmpdir, "//")) != NULL) {
> +		memmove(p, p + 1, strlen(env_tmpdir) - (p - env_tmpdir));
> +		fixed = 1;
> +	}
> +
> +	if (fixed) {
> +		tst_resm(TINFO, "WARNING: Remove double or trailing slashes from TMPDIR,"
> +			 " please fix your setup to: TMPDIR='%s'",
> +			 env_tmpdir);
> +	}
> +
>  	return env_tmpdir;
>  }

diff --git lib/newlib_tests/tst_tmpdir.c lib/newlib_tests/tst_tmpdir.c
index 008542808..c34430fa6 100644
--- lib/newlib_tests/tst_tmpdir.c
+++ lib/newlib_tests/tst_tmpdir.c
@@ -18,7 +18,8 @@ static struct tcase {
 } tcases[] = {
 	{NULL, TEMPDIR, "default value"},
 	{"/tmp/", "/tmp", "removing trailing slash"},
-	{"//var///tmp", "/var/tmp", "removing duplicate slashes"},
+	{"/var//tmp", "/var/tmp", "removing duplicate slashes"},
+	{"//var///tmp///", "/var/tmp", "removing too many slashes"},
 };
 
 static void do_test(unsigned int nr)

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
