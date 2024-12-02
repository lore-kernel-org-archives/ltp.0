Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A433D78326
	for <ltp@archiver.kernel.org>; Mon,  2 Dec 2024 14:42:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A94AD3DD505
	for <ltp@archiver.kernel.org>; Mon,  2 Dec 2024 15:42:35 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AD8343DD4F0
 for <ltp@lists.linux.it>; Mon,  2 Dec 2024 15:42:19 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id BF9F11415333
 for <ltp@lists.linux.it>; Mon,  2 Dec 2024 15:42:18 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 164241F396;
 Mon,  2 Dec 2024 14:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733150538;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yjBxfqO/ySVLd4QZxyp/PzwWoLWjLSKlZI5j2GSBajo=;
 b=KpFaafg+kPqnvpVh3YHkQdmaQlw+XGNIBssAslzy3A8aEHqrIISlTF1ehOUUwRU1aN+t9H
 h/jKCwRJyAHmgpCp4eCq9qNN1HL9ZUW0NlF7NLFMaIpkWxPHktfTjR2cFfC3b37qkpvaMe
 dqxFqsA5QKmD23bZwoX63bX5K1bCPHk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733150538;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yjBxfqO/ySVLd4QZxyp/PzwWoLWjLSKlZI5j2GSBajo=;
 b=5kpP1mo6qR13rjIEpR1gz8Hba6B7PYLeVBnFz5D6C0ORfoKQJulp6MsFe2XwoRvQbFEx/m
 2ZJHvhqrLKcrkoCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733150538;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yjBxfqO/ySVLd4QZxyp/PzwWoLWjLSKlZI5j2GSBajo=;
 b=KpFaafg+kPqnvpVh3YHkQdmaQlw+XGNIBssAslzy3A8aEHqrIISlTF1ehOUUwRU1aN+t9H
 h/jKCwRJyAHmgpCp4eCq9qNN1HL9ZUW0NlF7NLFMaIpkWxPHktfTjR2cFfC3b37qkpvaMe
 dqxFqsA5QKmD23bZwoX63bX5K1bCPHk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733150538;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yjBxfqO/ySVLd4QZxyp/PzwWoLWjLSKlZI5j2GSBajo=;
 b=5kpP1mo6qR13rjIEpR1gz8Hba6B7PYLeVBnFz5D6C0ORfoKQJulp6MsFe2XwoRvQbFEx/m
 2ZJHvhqrLKcrkoCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E217313A31;
 Mon,  2 Dec 2024 14:42:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 50TsNUnHTWdKIwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 02 Dec 2024 14:42:17 +0000
Date: Mon, 2 Dec 2024 15:42:08 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20241202144208.GB321427@pevik>
References: <20241201093606.68993-1-zlang@kernel.org>
 <20241201093606.68993-2-zlang@kernel.org>
 <Z02337yqxrfeZxIn@yuki.lan> <Z029S0wgjrsv9qHL@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z029S0wgjrsv9qHL@yuki.lan>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] ioctl_ficlone02.c: set all_filesystems to zero
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
Cc: linux-btrfs@vger.kernel.org, Zorro Lang <zlang@kernel.org>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > The code to skip filesystems in the case of all filesystems is in the
> > run_tcase_per_fs() function:

> > static int run_tcases_per_fs(void)
> > {
> >         int ret = 0;
> >         unsigned int i;
> >         const char *const *filesystems = tst_get_supported_fs_types(tst_test->skip_filesystems);

> > The skip_filesystems array is passed to the tst_get_supporte_fs_types()
> > function which filters out them.

> Perhaps you mean that the skiplist does not work with .all_filesystems
> _and_ the LTP_SINGLE_FS_TYPE environment variable?

> I guess that we need:

> diff --git a/lib/tst_supported_fs_types.c b/lib/tst_supported_fs_types.c
> index bbbb8df19..49b1d7205 100644
> --- a/lib/tst_supported_fs_types.c
> +++ b/lib/tst_supported_fs_types.c
> @@ -159,6 +159,10 @@ const char **tst_get_supported_fs_types(const char *const *skiplist)

>         if (only_fs) {
>                 tst_res(TINFO, "WARNING: testing only %s", only_fs);
> +
> +               if (tst_fs_in_skiplist(only_fs, skiplist))
> +                       tst_brk(TCONF, "Requested filesystems is in test skiplist");
> +

It's a nice feature to be able to force testing on filesystem even it's set to
be skipped without need to manually enable the filesystem and recompile.
(It helps testing with LTP compiled as a package without need to compile LTP.)
Therefore I would avoid this.

@Zorro Lang or are you testing whole syscalls on particular filesystem via
LTP_SINGLE_FS_TYPE=xfs ?

Kind regards,
Petr

>                 if (tst_fs_is_supported(only_fs))
>                         fs_types[0] = only_fs;
>                 return fs_types;

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
