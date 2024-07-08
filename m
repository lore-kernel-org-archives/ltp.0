Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E22A2C3271E
	for <ltp@archiver.kernel.org>; Mon,  8 Jul 2024 04:23:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2BFB93D3ACB
	for <ltp@archiver.kernel.org>; Mon,  8 Jul 2024 06:23:40 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1188C3D3AC0
 for <ltp@lists.linux.it>; Mon,  8 Jul 2024 06:23:24 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D61651A00CDE
 for <ltp@lists.linux.it>; Mon,  8 Jul 2024 06:23:23 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8DCB41FBBE;
 Mon,  8 Jul 2024 04:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1720412600;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zaUgMdeoPEk9RkapuntmGhvYXK35bF8eetS3Dr8Xg0A=;
 b=LBsGGzzPa3OqJo1Odxjzfw6RDxyQQmTn6RIN/uKwZ1G5zgpyLIwu2I0oYja9kzwHBSLC7w
 NmGxr0jIO2NmZJ0i//ibZ5PN78OeCq5Q0+9fOIhMCwt0kwfzKBhY3yB2rltVbEaOKs8Nbi
 FjdlYztpxuIKJGZAq0fAtwi65/fFXGM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1720412600;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zaUgMdeoPEk9RkapuntmGhvYXK35bF8eetS3Dr8Xg0A=;
 b=LFXuxLmQlRTaBr+/PtDbwv6YecFFpPCyulo5a71czo11A9tELv3/KismO1CrUQdANuuYAS
 8BHdGAqA0MeABfCA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=LBsGGzzP;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=LFXuxLmQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1720412600;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zaUgMdeoPEk9RkapuntmGhvYXK35bF8eetS3Dr8Xg0A=;
 b=LBsGGzzPa3OqJo1Odxjzfw6RDxyQQmTn6RIN/uKwZ1G5zgpyLIwu2I0oYja9kzwHBSLC7w
 NmGxr0jIO2NmZJ0i//ibZ5PN78OeCq5Q0+9fOIhMCwt0kwfzKBhY3yB2rltVbEaOKs8Nbi
 FjdlYztpxuIKJGZAq0fAtwi65/fFXGM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1720412600;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zaUgMdeoPEk9RkapuntmGhvYXK35bF8eetS3Dr8Xg0A=;
 b=LFXuxLmQlRTaBr+/PtDbwv6YecFFpPCyulo5a71czo11A9tELv3/KismO1CrUQdANuuYAS
 8BHdGAqA0MeABfCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EF9F71396E;
 Mon,  8 Jul 2024 04:23:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IJz0Mbdpi2Y/WgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 08 Jul 2024 04:23:19 +0000
Date: Mon, 8 Jul 2024 06:23:18 +0200
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it, lufei <lufei@uniontech.com>
Message-ID: <20240708042318.GA119348@pevik>
References: <20240606065506.1686-1-lufei@uniontech.com>
 <20240624015245.54968-1-lufei@uniontech.com>
 <20240624015245.54968-2-lufei@uniontech.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240624015245.54968-2-lufei@uniontech.com>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; REPLYTO_EQ_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 URIBL_BLOCKED(0.00)[suse.cz:email,suse.cz:replyto,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,ozlabs.org:url,suse.cz:email,suse.cz:replyto,suse.cz:dkim];
 RCPT_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 8DCB41FBBE
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] acct01: add EFAULT errno check.
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

Hi 
> Add EFAULT errno check in acct01 testcase.

> Signed-off-by: lufei <lufei@uniontech.com>

I guess you don't mind if I change this to following before merge:
Signed-off-by: Lu Fei <lufei@uniontech.com>

> ---
>  testcases/kernel/syscalls/acct/acct01.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

> diff --git a/testcases/kernel/syscalls/acct/acct01.c b/testcases/kernel/syscalls/acct/acct01.c
> index 1b53a32f2..ed1817bc5 100644
> --- a/testcases/kernel/syscalls/acct/acct01.c
> +++ b/testcases/kernel/syscalls/acct/acct01.c
> @@ -33,6 +33,7 @@
>  #define FILE_TMPFILE		"./tmpfile"
>  #define FILE_ELOOP		"test_file_eloop1"
>  #define FILE_EROFS		"ro_mntpoint/file"
> +#define FILE_EFAULT		"/tmp/invalid/file/name"

And here I just amend to:
#define FILE_EFAULT            "invalid/file/name"

(although it's very unlikely, the full patch *could* be existing, but not the
relative one, because LTP is creating unique temporary directory for each run,
e.g. /tmp/LTP_accTJpYqc.

>  static struct passwd *ltpuser;

> @@ -45,6 +46,7 @@ static char *file_eloop;
>  static char *file_enametoolong;
>  static char *file_erofs;
>  static char *file_null;
> +static char *file_efault;

>  static void setup_euid(void)
>  {
> @@ -56,6 +58,16 @@ static void cleanup_euid(void)
>  	SAFE_SETEUID(0);
>  }

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
> @@ -72,6 +84,7 @@ static struct test_case {
>  	{&file_eloop,   FILE_ELOOP,   ELOOP,        NULL, NULL},
>  	{&file_enametoolong, "aaaa...", ENAMETOOLONG, NULL, NULL},
>  	{&file_erofs,   FILE_EROFS,   EROFS,        NULL, NULL},
> +	{&file_efault,	FILE_EFAULT,  EFAULT,  setup_emem, cleanup_emem},
    {&file_efault,  "Invalid address",  EFAULT,  setup_emem, cleanup_emem},
(as Cyril suggested)

Actually this second version does only single thing (unlike the previous version
[1]), thus I suggest to merge it:
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Therefore I reopen it in patchwork [2].

And you can send warning cleanup after merging this?

Could you, please, next time put version to your patchset (e.g. -v2 for second
version), this help to avoid confusions?

Kind regards,
Petr

[1] https://lore.kernel.org/ltp/20240606065506.1686-1-lufei@uniontech.com/
[2] https://patchwork.ozlabs.org/project/ltp/patch/20240624015245.54968-2-lufei@uniontech.com/

>  };

>  static void setup(void)

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
