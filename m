Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2C63CD1288
	for <ltp@archiver.kernel.org>; Wed,  3 Apr 2024 09:28:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 49D263C19EA
	for <ltp@archiver.kernel.org>; Wed,  3 Apr 2024 11:28:47 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0CB813C1009
 for <ltp@lists.linux.it>; Wed,  3 Apr 2024 11:28:31 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D75C8600189
 for <ltp@lists.linux.it>; Wed,  3 Apr 2024 11:28:30 +0200 (CEST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C99DD5CA8D;
 Wed,  3 Apr 2024 09:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712136508;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p/2mMBLNIrF8dlGEoY3t5K6vrsaeyoHmPWf9eC4rgSA=;
 b=qicHbxUOmMJ3vjIBMFlVCPLdk3amhnggREVAjLjJqhw4n8HxidSfMWDiDURbJiIRBbnD8k
 b/VfAS9HzZLFGrxk5wpcobghbNsE+iBt9Pry9MKLPM4MK7rD/OAsc5dA3HtrcGQbz8FpKO
 SAQkA+gtoFXhArkmHPK0W52zgAI06Lk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712136508;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p/2mMBLNIrF8dlGEoY3t5K6vrsaeyoHmPWf9eC4rgSA=;
 b=no5wocEtFXw5kXZEQt23oRdd0jTqUTddJ4aTGg7wMqHtnnHnTmF4i5shZlA6OF6LwJYms0
 xI4R/OsQtf2ZucDA==
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id B18E11331E;
 Wed,  3 Apr 2024 09:28:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap2.dmz-prg2.suse.org with ESMTPSA id py8XKjwhDWYReAAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Wed, 03 Apr 2024 09:28:28 +0000
Date: Wed, 3 Apr 2024 11:28:27 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20240403092827.GA419563@pevik>
References: <20240118073215.10026-1-wegao@suse.com>
 <20240331021720.9527-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240331021720.9527-1-wegao@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 NEURAL_HAM_SHORT(-0.20)[-0.995]; RCPT_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 BAYES_HAM(-3.00)[100.00%]; ARC_NA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[ozlabs.org:url];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] ioctl_fiemap01: New test for fiemap ioctl()
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

> +#define TMPDIR "mntdir"
very nit: We usually use MNTPOINT for .mntpoint
#define MNTPOINT   "mntpoint"

(I even tried to get rid of these defines:
https://patchwork.ozlabs.org/project/ltp/list/?series=393028 .)

> +#define TESTFILE "testfile"
> +#define NUM_EXTENT 3
> +
> +static void print_extens(struct fiemap *fiemap)
> +{
> +	tst_res(TDEBUG, "File extent count: %u", fiemap->fm_mapped_extents);
> +
> +	for (unsigned int i = 0; i < fiemap->fm_mapped_extents; ++i) {
> +		tst_res(TDEBUG, "Extent %u: Logical offset: %llu, Physical offset: %llu, flags: %u, Length: %llu",
> +				i + 1,
> +				fiemap->fm_extents[i].fe_logical,
> +				fiemap->fm_extents[i].fe_physical,
> +				fiemap->fm_extents[i].fe_flags,
> +				fiemap->fm_extents[i].fe_length);
> +	}
> +}
> +
> +static void check_extent(struct fiemap *fiemap, unsigned int fm_mapped_extents, int index_extents, int fe_flags, unsigned int min_fe_physical, unsigned int fe_length)
> +{
> +	TST_EXP_EXPR(fiemap->fm_mapped_extents == fm_mapped_extents,
> +		"Check extent fm_mapped_extents is %d", fm_mapped_extents);
nit: space here (and below) would be more readable for me.
> +	TST_EXP_EXPR(fiemap->fm_extents[index_extents].fe_flags & fe_flags,
> +		"Check fe_flags is %d", fe_flags);
> +	TST_EXP_EXPR(fiemap->fm_extents[index_extents].fe_physical >= min_fe_physical,
> +		"Check fe_physical > %d", min_fe_physical);
> +	TST_EXP_EXPR(fiemap->fm_extents[index_extents].fe_length == fe_length,
> +		"Check fe_length is %d", fe_length);
> +}
> +
> +static void verify_ioctl(void)
> +{
> +	int fd;
> +	struct fiemap *fiemap;
> +	struct statvfs fs_info;
> +	unsigned long blk_size;
> +
> +	SAFE_CHDIR(TMPDIR);
> +	fd = SAFE_OPEN(TESTFILE, O_RDWR | O_CREAT, 0644);
> +
> +	TST_EXP_PASS(statvfs(".", &fs_info));

I'd here jut use:
if (statvfs(".", &fs_info) != 0)
	tst_brk(TBROK, "statvfs failed");

Why? IMHO all TEST() and TST_EXP_PASS() should be used for the subject of
testing.

(We don't have safe_statvfs(), but it'd be needed just on 3 places.)

> +	blk_size = fs_info.f_bsize;
> +
> +	fiemap = SAFE_MALLOC(sizeof(struct fiemap) + sizeof(struct fiemap_extent) * NUM_EXTENT);
> +	fiemap->fm_start = 0;
> +	fiemap->fm_length = ~0ULL;
> +	fiemap->fm_extent_count = 1;
> +
> +	fiemap->fm_flags =  -1;
nit: fiemap->fm_flags = -1;

> +	TST_EXP_FAIL(ioctl(fd, FS_IOC_FIEMAP, fiemap), EBADR);
> +
> +	fiemap->fm_flags =  0;
> +	TST_EXP_PASS(ioctl(fd, FS_IOC_FIEMAP, fiemap));
> +	print_extens(fiemap);
> +	TST_EXP_EXPR(fiemap->fm_mapped_extents == 0,
> +		"Check extent fm_mapped_extents is 0");
> +
> +	char *buf = SAFE_MALLOC(blk_size);
> +
> +	SAFE_WRITE(SAFE_WRITE_ANY, fd, buf, blk_size);
> +	fiemap->fm_flags = FIEMAP_FLAG_SYNC;
> +	TST_EXP_PASS(ioctl(fd, FS_IOC_FIEMAP, fiemap));
> +	print_extens(fiemap);
> +	check_extent(fiemap, 1, 0, FIEMAP_EXTENT_LAST, 1, blk_size);
> +
> +	fiemap->fm_extent_count = NUM_EXTENT;
> +	SAFE_LSEEK(fd, 2 * blk_size, SEEK_SET);
> +	SAFE_WRITE(SAFE_WRITE_ALL, fd, buf, blk_size);
> +	SAFE_LSEEK(fd, 4 * blk_size, SEEK_SET);
> +	SAFE_WRITE(SAFE_WRITE_ALL, fd, buf, blk_size);
> +	TST_EXP_PASS(ioctl(fd, FS_IOC_FIEMAP, fiemap));
> +	print_extens(fiemap);
> +	check_extent(fiemap, NUM_EXTENT, NUM_EXTENT - 1, FIEMAP_EXTENT_LAST, 1, blk_size);
> +
> +	free(buf);
> +	free(fiemap);
> +	SAFE_CLOSE(fd);
> +	unlink(TESTFILE);

SAFE_UNLINK(TESTFILE);

> +}
> +
> +static struct tst_test test = {
> +	.mount_device = 1,
> +	.mntpoint = TMPDIR,
> +	.all_filesystems = 1,
> +	.skip_filesystems = (const char *const[]) {
> +		"exfat", "vfat", "fuse", "ntfs", "tmpfs", NULL

Why do you whitelist fuse? Which filesystem under fuse does not work?

> +	},
> +	.test_all = verify_ioctl,
> +	.needs_root = 1,
> +	.needs_tmpdir = 1,
needs_tmpdir is not needed (you use .all_filesystems). You would find that when
generating docparse.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
