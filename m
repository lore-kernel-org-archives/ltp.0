Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDEC2C4167B
	for <ltp@archiver.kernel.org>; Fri, 15 Dec 2023 18:58:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EB1FC3CD840
	for <ltp@archiver.kernel.org>; Fri, 15 Dec 2023 19:58:07 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AF82C3CB1CB
 for <ltp@lists.linux.it>; Fri, 15 Dec 2023 19:57:57 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 75CFC10007CD
 for <ltp@lists.linux.it>; Fri, 15 Dec 2023 19:57:55 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3FFA61F849;
 Fri, 15 Dec 2023 18:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702666675;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Zg9dxhrPn0T63Cl8xN8jMaXmUB9lFbiTPivOV0t9hd4=;
 b=MR8w9Fd8ZaoQXxjrcFYn2uNucfa555xV6g5eqaHSIBzqoOfeszIFp3Pa/V57wdXaImCwC8
 LHakHCogyQTe6JxpSMiCoOXu9V8VLXliDAxzdmNKrfJvol/0M8ZLCQJBwehvdHAe5c3l+d
 C3akw6UDPST1diMP+VegLnWjex+rbnQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702666675;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Zg9dxhrPn0T63Cl8xN8jMaXmUB9lFbiTPivOV0t9hd4=;
 b=2TET36kZSFUVTheNJbP3ZOu/q5DI1bSgoqKpJYQdcoSV8megoww+/2lyK88j6ZF1KXDLWl
 V7E6JwACgG4j8+AA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702666675;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Zg9dxhrPn0T63Cl8xN8jMaXmUB9lFbiTPivOV0t9hd4=;
 b=MR8w9Fd8ZaoQXxjrcFYn2uNucfa555xV6g5eqaHSIBzqoOfeszIFp3Pa/V57wdXaImCwC8
 LHakHCogyQTe6JxpSMiCoOXu9V8VLXliDAxzdmNKrfJvol/0M8ZLCQJBwehvdHAe5c3l+d
 C3akw6UDPST1diMP+VegLnWjex+rbnQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702666675;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Zg9dxhrPn0T63Cl8xN8jMaXmUB9lFbiTPivOV0t9hd4=;
 b=2TET36kZSFUVTheNJbP3ZOu/q5DI1bSgoqKpJYQdcoSV8megoww+/2lyK88j6ZF1KXDLWl
 V7E6JwACgG4j8+AA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 14C7913912;
 Fri, 15 Dec 2023 18:57:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id 9lEsA7OhfGViNQAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Fri, 15 Dec 2023 18:57:55 +0000
Date: Fri, 15 Dec 2023 19:57:49 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20231215185749.GA58273@pevik>
References: <20231214063311.2325-1-wegao@suse.com>
 <20231214071321.9863-1-wegao@suse.com>
 <20231214071321.9863-2-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231214071321.9863-2-wegao@suse.com>
X-Spamd-Result: default: False [0.70 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]
Authentication-Results: smtp-out2.suse.de;
	none
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/2] tst_memutils.c: Add tst_print_meminfo
 function
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

Hi Wei,

...
> +++ b/include/tst_memutils.h
> @@ -58,4 +58,10 @@ void tst_enable_oom_protection(pid_t pid);
>   */
>  void tst_disable_oom_protection(pid_t pid);

> +void tst_print_meminfo(void);
> +
> +void tst_print_meminfo_(const char *file, const int lineno);
> +
> +#define tst_print_meminfo() tst_print_meminfo_(__FILE__, __LINE__)
Most of the macros we have upper case, can it be please TST_PRINT_MEMINFO() ?
I guess it does not have to be SAFE_PRINT_MEMINFO().

And because it's just one liner, could it be:

#define TST_PRINT_MEMINFO() safe_print_file(__FILE__, __LINE__, "/proc/meminfo")

...

> +++ b/lib/safe_macros.c

We don't want to add anything to the legacy API (otherwise it would go to
lib/safe_file_ops.c), please add this to lib/tst_safe_macros.c.

BTW I'm slightly confused, what would be the best place for this,
lib/tst_safe_macros.c is being used nowadays for everything. But there is also
include/tst_safe_file_ops.h, which does not have C file
(lib/tst_safe_file_ops.c) because it internally use lib/tst_safe_macros.c.
I guess creating lib/tst_safe_macros.c was postponed until we rewrite all tests,
maybe it's a time to create it.

@Li @Cyril: Also include/tst_safe_file_ops.h has SAFE_READ_MEMINFO() and
SAFE_READ_PROC_STATUS(), IMHO these should be in include/tst_memutils.h.
Or, we shouldn't have 2 headers for similar thing, it would be good to merge
these two.

> @@ -1352,3 +1352,19 @@ int safe_sysinfo(const char *file, const int lineno, struct sysinfo *info)

>  	return ret;
>  }
> +
> +int safe_print_file(const char *file, const int lineno, char *path)
> +{
> +	int ret;
> +	FILE *pfile;
> +	char line[PATH_MAX];
> +
> +	pfile = safe_fopen(file, lineno, NULL, path, "r");
> +
> +	while (fgets(line, sizeof(line), pfile))
> +		tst_resm_(file, lineno, TINFO, "%s", line);
> +
> +	ret = safe_fclose(file, lineno, NULL, pfile);
> +
> +	return ret;
> +}
> diff --git a/lib/tst_memutils.c b/lib/tst_memutils.c
> index c5382ff10..6c1e7c29e 100644
> --- a/lib/tst_memutils.c
> +++ b/lib/tst_memutils.c
> @@ -182,3 +182,8 @@ void tst_disable_oom_protection(pid_t pid)
>  {
>  	set_oom_score_adj(pid, 0);
>  }
> +
> +void tst_print_meminfo_(const char *file, const int lineno)
> +{
> +	safe_print_file(file, lineno, "/proc/meminfo");
As I mentioned above, we try to avoid function wrappers.
> +}

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
