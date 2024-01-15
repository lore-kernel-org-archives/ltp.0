Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48042C3DA79
	for <ltp@archiver.kernel.org>; Mon, 15 Jan 2024 15:23:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 937003CE36E
	for <ltp@archiver.kernel.org>; Mon, 15 Jan 2024 16:23:44 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8D7AC3CCAE1
 for <ltp@lists.linux.it>; Mon, 15 Jan 2024 16:23:29 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DCECB200AEE
 for <ltp@lists.linux.it>; Mon, 15 Jan 2024 16:23:28 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D75161F8BD;
 Mon, 15 Jan 2024 15:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705332208; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=91G1znfvCiNNijPupH8fepUCeY6ogO94v8PB0zCfDZ0=;
 b=K1HArdv16JASQtLEQJ+Z4mwpCoULftEY5U5e+3w18B6v6dahzSYgSqq6hdpX3RO1+AJcVY
 etoMZHTcJ2JiirJATYUZ+poAWL/nZ/4Qsd1RckngDiczc202VF/ITCwijHbr33L4wmwIAw
 5knEG2CFNZypeThAUf6x18hwSrNkCb4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705332208;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=91G1znfvCiNNijPupH8fepUCeY6ogO94v8PB0zCfDZ0=;
 b=+dyfaNvIXvs6T4ifM0M77U01/FaXirv0QWX4G4lnvkyvupPdUnzcWU9TeipThp6ptodckf
 pO8jwuYa28ld9BAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705332207; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=91G1znfvCiNNijPupH8fepUCeY6ogO94v8PB0zCfDZ0=;
 b=1l0XfPfAVmnH0SgCF0bVNG6Te8uzoXnNdhPIzoRJEHl3KfdJN29NNtCqX6MxgHnVev2wFI
 P+IqSv+aVbLb3rmlIxbNpS4M5dPGnIrkAPudKDmaROfRaE/le1uzScHtbWHPEyVphSQ4B4
 l7A89PME6uRPx7/d6qlD2mTEov1oBBI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705332207;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=91G1znfvCiNNijPupH8fepUCeY6ogO94v8PB0zCfDZ0=;
 b=QsQNeo0tnk148XeLMNNMVdlQy5guk0x31hw1kjGZiK/gueRuONjtwdHwceJJS2MjC+SHmk
 hi6Xwv6EcN9ggLBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C673F136F5;
 Mon, 15 Jan 2024 15:23:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ufrkLu9NpWWuBQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 15 Jan 2024 15:23:27 +0000
Date: Mon, 15 Jan 2024 16:23:35 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <ZaVN90UDAhOKlCSP@yuki>
References: <20231018054357.29035-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231018054357.29035-1-wegao@suse.com>
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=1l0XfPfA;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=QsQNeo0t
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
 RCVD_COUNT_THREE(0.00)[3]; MX_GOOD(-0.01)[];
 RCPT_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.cz:+];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; BAYES_HAM(-3.00)[100.00%];
 ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Queue-Id: D75161F8BD
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] ioctl_fiemap01: New test for fiemap ioctl()
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
> +static void print_extens(struct fiemap *fiemap)
> +{
> +
> +	tst_res(TINFO, "File extent count: %u", fiemap->fm_mapped_extents);
> +	for (unsigned int i = 0; i < fiemap->fm_mapped_extents; ++i) {
> +		tst_res(TINFO, "Extent %u: Logical offset: %llu, Physical offset: %llu, flags: %u, Length: %llu",
                          ^
			  This would probably be better TDEBUG that has
			  been recently introduced.
> +				i + 1,
> +				fiemap->fm_extents[i].fe_logical,
> +				fiemap->fm_extents[i].fe_physical,
> +				fiemap->fm_extents[i].fe_flags,
> +				fiemap->fm_extents[i].fe_length);
> +	}
> +}
> +
> +static void verify_ioctl(void)
> +{
> +	int fd;
> +	struct fiemap *fiemap;
> +
> +	fd = SAFE_OPEN(TESTFILE, O_RDWR | O_CREAT, 0644);
> +
> +	fiemap = SAFE_MALLOC(sizeof(struct fiemap) + sizeof(struct fiemap_extent) * NUM_EXTENT);
> +	fiemap->fm_start = 0;
> +	fiemap->fm_length = ~0ULL;
> +	fiemap->fm_extent_count = 1;
> +
> +	fiemap->fm_flags =  -1;
> +	TST_EXP_FAIL(ioctl(fd, FS_IOC_FIEMAP, fiemap), EBADR);
> +
> +	fiemap->fm_flags =  0;
> +	SAFE_IOCTL(fd, FS_IOC_FIEMAP, fiemap);
> +	print_extens(fiemap);
> +	if (fiemap->fm_mapped_extents == 0)
> +		tst_res(TPASS, "Check fiemap iotct step1 pass");

This is missing the TFAIL branch, also "step1 pass" is not good enough
description of the test, we should really describe what we were testing
for.

> +	SAFE_WRITE(SAFE_WRITE_ANY, fd, buf, getpagesize());
> +	SAFE_IOCTL(fd, FS_IOC_FIEMAP, fiemap);
> +	print_extens(fiemap);
> +	if ((fiemap->fm_mapped_extents == 1) && (fiemap->fm_extents[0].fe_physical == 0))
> +		tst_res(TPASS, "Check fiemap iotct step2 pass");

Here as well.

> +	fiemap->fm_flags = FIEMAP_FLAG_SYNC;
> +	SAFE_IOCTL(fd, FS_IOC_FIEMAP, fiemap);
> +	print_extens(fiemap);
> +	if ((fiemap->fm_extent_count == 1) &&
> +		(fiemap->fm_extents[0].fe_flags == FIEMAP_EXTENT_LAST) &&
> +		(fiemap->fm_extents[0].fe_physical > 0) &&
> +		(fiemap->fm_extents[0].fe_length == (__u64)getpagesize()))
> +		tst_res(TPASS, "Check fiemap iotct step3 pass");

And here as well.

> +	fiemap->fm_extent_count = NUM_EXTENT;
> +	srand(time(NULL));
> +	SAFE_LSEEK(fd, FILE_OFFSET, SEEK_SET);
> +	SAFE_WRITE(SAFE_WRITE_ALL, fd, buf, getpagesize());
> +	SAFE_IOCTL(fd, FS_IOC_FIEMAP, fiemap);
> +	print_extens(fiemap);
> +	if ((fiemap->fm_extent_count == NUM_EXTENT) &&
> +		(fiemap->fm_extents[NUM_EXTENT - 1].fe_flags == FIEMAP_EXTENT_LAST) &&
> +		(fiemap->fm_extents[NUM_EXTENT - 1].fe_physical > 0) &&
> +		(fiemap->fm_extents[NUM_EXTENT - 1].fe_length == (__u64)getpagesize()))
> +		tst_res(TPASS, "Check fiemap iotct step4 pass");

And here as well.

> +	free(fiemap);
> +	close(fd);

SAFE_CLOSE() plase.

I suppose that we have to unlink the file so that the test work with -i
2.

> +}
> +
> +static void setup(void)
> +{
> +	buf = SAFE_MALLOC(getpagesize());
> +}
> +
> +static void cleanup(void)
> +{
> +	free(buf);
> +}
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = verify_ioctl,
> +	.needs_root = 1,
> +	.needs_tmpdir = 1,
> +};
> -- 
> 2.35.3
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
