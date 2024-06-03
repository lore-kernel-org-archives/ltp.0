Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 126D0C25B75
	for <ltp@archiver.kernel.org>; Mon,  3 Jun 2024 07:38:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EE1D93D08A4
	for <ltp@archiver.kernel.org>; Mon,  3 Jun 2024 09:38:49 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2B8253CE1C6
 for <ltp@lists.linux.it>; Mon,  3 Jun 2024 09:38:35 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0A9CC601571
 for <ltp@lists.linux.it>; Mon,  3 Jun 2024 09:38:31 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0547D219EE;
 Mon,  3 Jun 2024 07:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1717400310;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=avGR8FFFC1Fy/fRlJeVhwquOs2aG8n3RGvlLVBPTic8=;
 b=rQQqrxf39cyLQyQKR8UAuXj0mT1nfTwBvfzNB6cLHBa4fhxallmUsM7GKrd4lP3aSbDJPT
 VEeSXs7Ziy4k574SnDrwnvO23XkmqB5V/vc0MvGyUOe+wHnkKtoYWB119VnxJ28ChhMTNV
 Kxg0NDuSyhHUupYMAhhGJF8VVewHdnI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1717400310;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=avGR8FFFC1Fy/fRlJeVhwquOs2aG8n3RGvlLVBPTic8=;
 b=4KgG0u8W7I8b4ypgKYpA5VMzVdwFVO5xFX8k4tctIyIVzAuxr8bz4k0P13R0y+ljOFx49U
 zup8NzW8+cLf4uBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1717400309;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=avGR8FFFC1Fy/fRlJeVhwquOs2aG8n3RGvlLVBPTic8=;
 b=dF3bHgRYY+YUXreI0tqNHW5Sv1+RxaQGWBT+TLnvdX0w30ghaFwzsqr7g6W7gD/xXIdcAt
 hC50G3k8DCGNgjRC11D3r6Cz7fY/HphB5GV5WCqbCOy4Rj/zJ5j5oqf2NGdLe1NyILGDXL
 aDtbS/rfQ5yvkeqwr3xpMb8heNV5Ylg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1717400309;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=avGR8FFFC1Fy/fRlJeVhwquOs2aG8n3RGvlLVBPTic8=;
 b=rPhLb3NNuck8mT+4cqb3G1Sn6J3s7S1DEWBvOF02NfFjDlBbMudP8K7nG/+k8fCywrXUet
 Xdx2NV1Ju6dYlCAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D76F4139CB;
 Mon,  3 Jun 2024 07:38:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id igm1M/RyXWZiXAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 03 Jun 2024 07:38:28 +0000
Date: Mon, 3 Jun 2024 09:38:27 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20240603073827.GA48886@pevik>
References: <20231228025537.28807-1-wegao@suse.com>
 <20240322112031.20939-1-wegao@suse.com>
 <ee920e44-272f-4e76-9b08-a40f86d51fef@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ee920e44-272f-4e76-9b08-a40f86d51fef@suse.cz>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,lwn.net:url,suse.cz:replyto,suse.cz:email];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] move_mount03: check allow to mount beneath top
 mount
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

Hi Wei, Marting,

> Hi,
> one note below but this can be merged as is.

> Reviewed-by: Martin Doucha <mdoucha@suse.cz>
Thanks!

...
> > diff --git a/testcases/kernel/syscalls/move_mount/move_mount03.c b/testcases/kernel/syscalls/move_mount/move_mount03.c
> > new file mode 100644

...
> +/*\
> + * [Description]
> + *
> + * Test allow to mount beneath top mount feature
very nit: missing dot.
But more important the docparse docs are very sparse now, when everything is in
the documentation visible only when looking into source code.

I would also mention the commit and the original test in docparse, e.g.
something like:

/*\
 * [Description]
 *
 * Test allow to mount beneath top mount feature added in kernel 6.5:
 * 6ac392815628 ("fs: allow to mount beneath top mount")
 *
 * Test based on:
 * https://github.com/brauner/move-mount-beneath
 *
 * See also:
 * https://lore.kernel.org/all/20230202-fs-move-mount-replace-v4-0-98f3d80d7eaa@kernel.org/
 */

> + */
...
> + * See also:
> + * https://lwn.net/Articles/930591/
I would move these two into docparse as in example above.

This cover letter of v3. Wouldn't it be better to link the final version (v4)
and from lwn.net (as in example above)?
https://lore.kernel.org/all/20230202-fs-move-mount-replace-v4-0-98f3d80d7eaa@kernel.org/

> + * https://github.com/brauner/move-mount-beneath
...
> > +static void run(void)
> > +{
> > +	SAFE_MOUNT("none", DIRA, "tmpfs", 0, 0);
> > +	SAFE_MOUNT("none", DIRB, "tmpfs", 0, 0);
> > +	SAFE_TOUCH(DIRA "/A", 0, NULL);
> > +	SAFE_TOUCH(DIRB "/B", 0, NULL);
> > +
> > +	fda = open_tree(AT_FDCWD, DIRA, OPEN_TREE_CLOEXEC | OPEN_TREE_CLONE);
> > +	if (fda == -1)
> > +		tst_brk(TBROK | TERRNO, "open_tree() failed");
> > +
> > +	fdb = SAFE_OPEN(DIRB, O_PATH | O_NOFOLLOW, 0666);
> > +	TST_EXP_PASS(move_mount(fda, "", fdb, "",
> > +				MOVE_MOUNT_BENEATH | MOVE_MOUNT_F_EMPTY_PATH |
> > +				MOVE_MOUNT_T_EMPTY_PATH));
> > +	SAFE_CLOSE(fda);
> > +	SAFE_CLOSE(fdb);
> > +
> > +	TST_EXP_PASS(access(DIRB "/B", F_OK));

> That extra check I've asked for in v3 would still be nice here.

Would you mind to send v5 with checks Martin suggested?

https://lore.kernel.org/ltp/8798c323-8298-49b1-9950-09f2a7c309cb@suse.cz/

> > +	SAFE_UMOUNT(DIRB);
> > +	TST_EXP_PASS(access(DIRB "/A", F_OK));
> > +
> > +	SAFE_UMOUNT(DIRB);
> > +	SAFE_UMOUNT(DIRA);
> > +}
...
> +static void cleanup(void)
> +{
very nit: remove extra space here:
> +
> +	if (fda >= 0)
> +		SAFE_CLOSE(fda);
> +
> +	if (fdb >= 0)
> +		SAFE_CLOSE(fdb);
....

> +static struct tst_test test = {
> +	.test_all = run,
> +	.needs_root = 1,
> +	.min_kver = "6.5.0",
nit: .min_kver = "6.5", would be enough

Otherwise LGTM.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

BTW briefly looking into the Christian's testing source code, these flags are
not yet covered by LTP:
MOVE_MOUNT_SET_GROUP, MOUNT_ATTR_RDONLY, AT_RECURSIVE

Kind regards,
Petr

> +	.needs_tmpdir = 1,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
