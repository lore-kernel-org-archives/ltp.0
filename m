Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FABEC10DC3
	for <ltp@archiver.kernel.org>; Thu,  7 Dec 2023 17:55:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 90B093CD8A8
	for <ltp@archiver.kernel.org>; Thu,  7 Dec 2023 18:55:54 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9245C3CBABB
 for <ltp@lists.linux.it>; Thu,  7 Dec 2023 18:55:44 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B609514011B5
 for <ltp@lists.linux.it>; Thu,  7 Dec 2023 18:55:43 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A840221DA9;
 Thu,  7 Dec 2023 17:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1701971742;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gNnU+TSS/qfLmITURuC6kWZHVs4AC2ymKQhfiuMGq4o=;
 b=3aTN0icnt8Mz09oVjEOwYkA/GPu0S+GJOII9MAJd4A8qt0q/ZLMBIdS6USmR1U6cWef+MV
 C0L+Y/Mo5MZY5JP6IpSAy0D7Pjy2lWrzcSEowF3wgXykCHZnOBv+gvDJxqwafJFfJa6TuV
 rtk8KpZgzNCzmTMP4RBM++y1D1DYq8M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1701971742;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gNnU+TSS/qfLmITURuC6kWZHVs4AC2ymKQhfiuMGq4o=;
 b=k9dVbOKTdp8VXj37AxPCtBv32nokrbADaYXYJ7cA7gf4pz8KfuAQeBIfPl+GY0OZRicj4b
 oUb8p569RTphMiBA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 7AA7713907;
 Thu,  7 Dec 2023 17:55:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id cDCSGR0HcmUTZwAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Thu, 07 Dec 2023 17:55:41 +0000
Date: Thu, 7 Dec 2023 18:55:38 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20231207175538.GA248849@pevik>
References: <20231116135546.2599273-1-pvorel@suse.cz>
 <ZXHXxCRa31xO-Lo_@rei>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZXHXxCRa31xO-Lo_@rei>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-4.50 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; REPLY(-4.00)[];
 RCVD_COUNT_THREE(0.00)[3]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_SEVEN(0.00)[11];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,lwn.net:url];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[21.67%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] lib: Add support bcachefs filesystem
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
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
 Brian Foster <bfoster@redhat.com>, fstests@vger.kernel.org,
 linux-bcachefs@vger.kernel.org, Richard Palethorpe <rpalethorpe@suse.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > bcachefs has been merged into v6.7-rc1 [1]. Let's add it's support to
> > LTP .all_filesystems = 1 and TST_ALL_FILESYSTEMS=1.

> > [1] https://lwn.net/Articles/934692/

> > Suggested-by: Cyril Hrubis <chrubis@suse.cz>
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> > Hi,

> > this should be merged after v6.7 is released.

> Agreed, although it's unlikey that they will pull bcachefs off from the
> tree now. Any way I think that we should add the support to the next
> release.

Yep, now it's 6.7-rc4. I'll prepare v2

> > So far I haven't tested all LTP tests on bcachefs temporary directory.
> > I have only tested tests which use .all_filesystems = 1 or TST_ALL_FILESYSTEMS=1.
> > So far it looks like there are only a few tests failing:

> > statvfs01.c:44: TFAIL: creat(valid_fname, 0444) failed: ENAMETOOLONG (36)

> That strange, that would mean that statvfs() reports possibly wrong
> f_namemax. Looking at the code the f_namemax is initialized to
> BCH_NAME_MAX in bch2_statfs().

> And the dirent_create_key() does:

>         if (name->len > BCH_NAME_MAX)
>                 return ERR_PTR(-ENAMETOOLONG);

> That does not look like there is any room for a failure. Maybe we can
> print the buf.f_namemax value in the test and check if it's 512 since
> that is the value of BCH_NAME_MAX.

> > statx04.c:122: TFAIL: STATX_ATTR_COMPRESSED not supported

> This probably just needs:

> diff --git a/testcases/kernel/syscalls/statx/statx04.c b/testcases/kernel/syscalls/statx/statx04.c
> index 58296bd24..8d14cef8c 100644
> --- a/testcases/kernel/syscalls/statx/statx04.c
> +++ b/testcases/kernel/syscalls/statx/statx04.c
> @@ -97,7 +97,8 @@ static void setup(void)
>                 expected_mask |= attr_list[i].attr;

>         /* STATX_ATTR_COMPRESSED not supported on XFS, TMPFS */
> -       if (!strcmp(tst_device->fs_type, "xfs") || !strcmp(tst_device->fs_type, "tmpfs"))
> +       if (!strcmp(tst_device->fs_type, "xfs") || !strcmp(tst_device->fs_type, "tmpfs") ||
> +           !strcmp(tst_device->fs_type, "bcachefs")
>                 expected_mask &= ~STATX_ATTR_COMPRESSED;

Obviously skipping works. STATX_ATTR_COMPRESSED is not in fs/bcachefs/ directory in stat->attributes,
unlike on the other fs, so it looks like it's not supported.

>         /* Attribute support was added to Btrfs statx() in kernel v4.13 */

> > fanotify13.c, fanotify15.c and fanotify16.c produce many errors.

> That is probably something for Jan Kara or Amir Goldstein.

Yep, I'll Cc them on v2 and ask for help.

Kind regards,
Petr

> > I haven't tested on machine with more NUMA nodes, thus
> > set_mempolicy03.c, set_mempolicy04.c has not been tested.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
