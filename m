Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2A6FC27C53
	for <ltp@archiver.kernel.org>; Fri,  7 Jun 2024 10:29:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3D0543D0A97
	for <ltp@archiver.kernel.org>; Fri,  7 Jun 2024 12:29:41 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 62F9D3CB942
 for <ltp@lists.linux.it>; Fri,  7 Jun 2024 12:29:26 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 991841BC5806
 for <ltp@lists.linux.it>; Fri,  7 Jun 2024 12:29:25 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 834641FB96;
 Fri,  7 Jun 2024 10:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1717756164;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=87bOjwcF8YZgwoqo/zVn4vxqQ7DrCPCzqVk3DDduYQ8=;
 b=hzl/H7DogivuKcaXX8zn+RVi/6VxX/p27SdBrhCH+agbRhGOVstFR5w108NrBtQtKBDpaS
 MlXqy4ButZGdNfc1mCDQAbSmAQJN6g+osUIbRzSERJ5nR/jPWuorU0azDyvkgmsv9H/HJv
 236CDBAJVMhfRF7Ykjr3LOIn78DNZWs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1717756164;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=87bOjwcF8YZgwoqo/zVn4vxqQ7DrCPCzqVk3DDduYQ8=;
 b=X/BbJQxiQ2vTOwA0tkxU72NB2oOFuvcpdNxY2DmzFSoVxpIMLnhaP39xAR/UuwNneVWadg
 GWfohEmWC3T5snCA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="hzl/H7Do";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="X/BbJQxi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1717756164;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=87bOjwcF8YZgwoqo/zVn4vxqQ7DrCPCzqVk3DDduYQ8=;
 b=hzl/H7DogivuKcaXX8zn+RVi/6VxX/p27SdBrhCH+agbRhGOVstFR5w108NrBtQtKBDpaS
 MlXqy4ButZGdNfc1mCDQAbSmAQJN6g+osUIbRzSERJ5nR/jPWuorU0azDyvkgmsv9H/HJv
 236CDBAJVMhfRF7Ykjr3LOIn78DNZWs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1717756164;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=87bOjwcF8YZgwoqo/zVn4vxqQ7DrCPCzqVk3DDduYQ8=;
 b=X/BbJQxiQ2vTOwA0tkxU72NB2oOFuvcpdNxY2DmzFSoVxpIMLnhaP39xAR/UuwNneVWadg
 GWfohEmWC3T5snCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 64AF0133F3;
 Fri,  7 Jun 2024 10:29:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /RW0FwThYmZFNQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 07 Jun 2024 10:29:24 +0000
Date: Fri, 7 Jun 2024 12:29:23 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240607102923.GB55162@pevik>
References: <20240603123455.7968-1-chrubis@suse.cz>
 <20240603123455.7968-2-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240603123455.7968-2-chrubis@suse.cz>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; REPLYTO_EQ_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 834641FB96
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] lib: tst_test: Add per filesystem mkfs and
 mount opts
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

Hi Cyril,

> This commit does:

> * Group the filesystem type, mkfs and mount options into a separate
>   structure

> * Add an array of these structures to be able to define per filesystem
>   mkfs and mount options

> The details on the usage should be hopefully clear from the
> documentation comments for the struct tst_test.

Nice cleanup!

Reviewed-by: Petr Vorel <pvorel@suse.cz>

BTW is this effort somehow related to Martin's suggestion to "combine
.all_filesystems + .needs_rofs together"? [1] Or you're still not convinced it'd
be useful?

Also, this reminds me our goal to implement minimal filesystem size required per
filesystem.

[1] https://lore.kernel.org/ltp/ad6558e0-e834-4b35-923a-7b519384f436@suse.cz/

...
> +/**
> + * struct tst_fs - A file system type, mkfs and mount options
> + *
> + * @fs_type A filesystem type to use.
nit: @type.

Unfortunately sphinx does not complain when building docs, but you can see
"undescribed" in the resulted html.

> + *
> + * @mkfs_opts: A NULL terminated array of options passed to mkfs in the case
> + *             of 'tst_test.format_device'. These options are passed to mkfs
> + *             before the device path.
> + *
> + * @mkfs_size_opt: An option passed to mkfs in the case of
> + *                 'tst_test.format_device'. The device size in blocks is
> + *                 passed to mkfs after the device path and can be used to
> + *                 limit the file system not to use the whole block device.
> + *
> + * @mnt_flags: MS_* flags passed to mount(2) when the test library mounts a
> + *             device in the case of 'tst_test.mount_device'.
> + *
> + * @mnt_data: The data passed to mount(2) when the test library mounts a device
> + *            in the case of 'tst_test.mount_device'.
> + */
> +struct tst_fs {
> +	const char *type;
> +
> +	const char *const *mkfs_opts;
> +	const char *mkfs_size_opt;
> +
> +	const unsigned int mnt_flags;
> +	const void *mnt_data;
> +};
...

> - * @dev_fs_type: If set overrides the default file system type for the device and
> - *               sets the tst_device.fs_type.
> + * @fs: If fs.type is set it overrides the default file system type for the
> + *      device. The rest of the parameters describe default parameters for
> + *      mkfs and mount.
>   *
> - * @dev_fs_opts: A NULL terminated array of options passed to mkfs in the case
> - *               of 'tst_test.format_device'. These options are passed to mkfs
> - *               before the device path.
> - *
> - * @dev_extra_opts: A NULL terminated array of extra options passed to mkfs in
> - *                  the case of 'tst_test.format_device'. Extra options are
> - *                  passed to mkfs after the device path. Commonly the option
> - *                  after mkfs is the number of blocks and can be used to limit
> - *                  the file system not to use the whole block device.
> + * @fss: A NULL type terminated array of per file system type options. If

Could this be fs_all (although it can be used also without all_filesystems just to describe more fs)?
Because fss looks confusing a bit (it looks as some abbreviation, thus I would
not match it to fs member).

> + *       tst_test.all_filesystems is not set the array describes a list of
> + *       file systems to test along with parameters to pass to mkfs and mount.

So that one can decide if use .fss instead of .all_filesystems and
.skip_filesystems? I like the flexibility, but it can leads to confusion.

Also it'd be like to 1) use fss in some test 2) have at least trivial library
test.

Also nit: writing it as @all_filesystems formats it red (I'd prefer to be a HTML
link to the member in docs, but no idea how to do it. @Andrea, any idea?)
> + *       If tst_test.all_filesystems is set the mkfs and mount options are
> + *       taken from tst_test.fs unless there is an override for a given
> + *       file system type defined in this array.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
