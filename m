Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1BC606A326
	for <ltp@archiver.kernel.org>; Fri, 20 Nov 2026 15:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=NBu/Uno0;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=mWQGqMzZ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=aopMg/TY;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=oR3fN6Ej
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C6E903EACAA
	for <ltp@archiver.kernel.org>; Fri, 20 Nov 2026 16:23:57 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A6EDA3E9FCB
 for <ltp@lists.linux.it>; Fri, 20 Nov 2026 16:23:40 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 840891A00164
 for <ltp@lists.linux.it>; Fri, 20 Nov 2026 16:23:39 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B528D2255F;
 Fri, 20 Nov 2026 15:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1795188213; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VXMXVC1I5+QEpSK4m2MiSIE3C08J9wZiLA53VGd3Reo=;
 b=NBu/Uno05gamqI1a3kxxADFzgJHoz4YA5NZd7kaWsFkT28S5W7LQLVtKx6pe72jXysh62w
 Knj0pVSIYlOx8KY7JDjq7wpbJdGhCrkJhJs2HqZATNDexv4gIh7/aaHv4Qth8aZY5+/Gbo
 QJbY3NXyrJMGtcnTVERWuJGQQnzXLzc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1795188213;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VXMXVC1I5+QEpSK4m2MiSIE3C08J9wZiLA53VGd3Reo=;
 b=mWQGqMzZaj3RpNwdrgU4v4Q4+0oRd0k51t2arqBxQXugkai79Z59WFpJmyOjcGzb9BX+KY
 Ztjl2Mo4BPy3QeAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1795188211; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VXMXVC1I5+QEpSK4m2MiSIE3C08J9wZiLA53VGd3Reo=;
 b=aopMg/TYjVZevl5KqFLJwmBB1Cfz0V2/rk+++nLqi7plL+PINlFRlUk6sflNLh2oTDThP2
 o2vFsNHbPd8bkdmBQTmN21td85les8Izh3+9nge29WqcTm5fUijdLh1ZIZvi/bUfycjb2r
 E301kCWKb8rEpibTsATZ62pr33gxOOU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1795188211;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VXMXVC1I5+QEpSK4m2MiSIE3C08J9wZiLA53VGd3Reo=;
 b=oR3fN6EjsaivxgL+nzLkeZ/a4UfajLCgV3e8P3hslNyMwSvChOfK1a+5PatE9SaOfRM55X
 BgstNbf63ddz2dAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7F3521342D;
 Fri, 20 Nov 2026 15:23:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id BwgmF/NlAGukZAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 20 Nov 2026 15:23:31 +0000
Date: Fri, 20 Nov 2026 16:24:00 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Gaurav Pathak <gpathak@suse.de>
Message-ID: <awBmECbdo7iUCXPv@yuki.lan>
References: <20261027073318.4440-1-linuxtestproject.agent@gmail.com>
 <20261027-statx-atomic-write-v11-1-e9aeb50e56ce@suse.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261027-statx-atomic-write-v11-1-e9aeb50e56ce@suse.com>
X-Spamd-Result: default: False [-13.30 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, linux.it:url,
 suse.cz:email, suse.com:email]
X-Spam-Score: -13.30
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v11] syscalls/statx13: Add test for
 STATX_WRITE_ATOMIC on regular file
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: gaurav.pathak@suse.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> +/*\
> + * Test :manpage:`statx(2)` support for the ``STATX_WRITE_ATOMIC`` mask on a
> + * regular file.
> + *
> + * STATX_WRITE_ATOMIC was added in Linux v6.11, initially for block
> + * devices. Regular-file reporting of atomic write limits on XFS and ext4
> + * was added later, in Linux v6.13, which is what this test exercises.
> + *
> + * There are two independent ways a filesystem can end up reporting atomic
> + * write support on a regular file, and this test exercises both:
> + *
> + * - Hardware-backed: the underlying block device itself advertises atomic
> + *   write support (queried via statx(2) on the raw device before
> + *   formatting). Both XFS and ext4 propagate the device's limits in this
> + *   case. Loop devices never advertise this (the loop driver doesn't wire
> + *   up atomic-write queue limits at all), so this path requires LTP_DEV to
> + *   point at a real NVMe/SCSI device (or a scsi_debug-emulated one).
> + *
> + * - Software-backed (XFS only, Linux v6.16+): xfs_inode_can_sw_atomic_write()
> + *   lets XFS complete an atomic write via CoW-based out-of-place writes
> + *   instead of hardware support, gated purely by xfs_has_reflink() -- a
> + *   filesystem feature, not a device capability. reflink is on by default
> + *   for v5 (CRC-enabled) XFS filesystems, so a plain mkfs.xfs on top of a
> + *   loop device will report working atomic write limits on a v6.16+
> + *   kernel, with no special device needed. ext4 has no equivalent
> + *   software fallback, so it always needs the hardware-backed path.
> + *
> + * When the test device does support hardware atomic writes, the
> + * filesystem block size is derived at runtime from the device's own
> + * atomic write unit limits, capped to 64KiB -- the hard block size
> + * ceiling enforced by both mkfs.xfs and mkfs.ext4 regardless of kernel
> + * capability -- and otherwise handled differently per filesystem:
> + *
> + * - XFS: without CONFIG_TRANSPARENT_HUGEPAGE, the block size is capped to
> + *   the page size, since mkfs.xfs has no page-size pre-check and the
> + *   kernel would otherwise reject a larger block size with ENOSYS at
> + *   mount (mapping_max_folio_size_supported()). With THP available, the
> + *   device's own atomic write max is used directly, except that a
> + *   device reporting at least 64KiB is capped to exactly 16KiB rather
> + *   than its full max, to exercise a non-default block size without
> + *   nearing the 64KiB mkfs ceiling.
> + *
> + * - ext4: Since the kernel is able to mount only file systems with
> + *   block-size smaller or equal to the system page size the block-size
> + *   always stays at or below the page size and the cluster size never
> + *   exceeds stx_atomic_write_unit_max and is strictly bounded by a max of
> + *   16 times the block size.
> + *
> + * When the test device does not support hardware atomic writes (e.g. the
> + * default loop-backed image LTP creates when LTP_DEV isn't set), ext4
> + * TCONFs immediately, while XFS is still formatted (with reflink forced
> + * on) and mounted, relying on verify_statx() to TCONF on its own if the
> + * running kernel predates the v6.16 software atomic write support.
> + *
> + * The test needs to run as root because it formats and mounts its own
> + * XFS and ext4 test filesystems.
> + */
> +
> +#define _GNU_SOURCE
> +#include <sys/mount.h>
> +#include "tst_test.h"
> +#include "lapi/stat.h"
> +
> +#define MNTPOINT "mnt_point"
> +#define TESTFILE MNTPOINT "/testfile"
> +#define MODE 0644
> +
> +/*
> + * Both xfsprogs (XFS_MAX_BLOCKSIZE) and e2fsprogs (EXT2_MAX_BLOCK_SIZE) cap
> + * the mkfs block size at 64KiB regardless of kernel/THP capability; mkfs
> + * rejects anything larger with "invalid block size" before the kernel is
> + * even involved.
> + */
> +#define MKFS_MAX_BLOCK_SIZE 65536
> +
> +static int file_fd = -1;
> +static int mount_flag;
> +static char *data_buff;
> +static struct ltp_statx *buff;
> +
> +static void verify_statx(void)
> +{
> +	TST_EXP_PASS(statx(AT_FDCWD, TESTFILE, 0, STATX_BASIC_STATS | STATX_WRITE_ATOMIC, &buff->buff),
> +			"statx(AT_FDCWD, %s, 0, STATX_BASIC_STATS | STATX_WRITE_ATOMIC, &buf)", TESTFILE);
> +
> +	if (!TST_PASS)
> +		return;
> +
> +	/* Check if the kernel populated the atomic limit struct members */
> +	if (!(buff->data.stx_mask & STATX_WRITE_ATOMIC))
> +		tst_brk(TCONF, "Kernel may be too old to report atomic limits: STATX_WRITE_ATOMIC missing from stx_mask");

First of all can we keep the messages shorter an to the point? The
second part of the message "STATX_WRITE_ATOMIC missing from stx_mask"
does not add any useful information, only adds to the message lenght.
And it's the same for the rest of the messages produced by the test.


> +	/* Check if the filesystem supports reporting the atomic write attribute */
> +	if (!(buff->data.stx_attributes_mask & STATX_ATTR_WRITE_ATOMIC)) {
> +		tst_res(TFAIL, "Inconsistent: stx_mask has STATX_WRITE_ATOMIC but stx_attributes_mask lacks STATX_ATTR_WRITE_ATOMIC");
> +		return;
> +	}
> +
> +	/* Check if the file/device actively supports atomic writes */
> +	if (!(buff->data.stx_attributes & STATX_ATTR_WRITE_ATOMIC)) {
> +		if (buff->data.stx_atomic_write_unit_min || buff->data.stx_atomic_write_unit_max ||
> +				buff->data.stx_atomic_write_unit_max_opt || buff->data.stx_atomic_write_segments_max) {
> +			tst_res(TFAIL,
> +				"Inconsistent: STATX_ATTR_WRITE_ATOMIC unset but limits nonzero (min=%u max=%u opt=%u segs=%u)",
> +				buff->data.stx_atomic_write_unit_min, buff->data.stx_atomic_write_unit_max,
> +				buff->data.stx_atomic_write_unit_max_opt, buff->data.stx_atomic_write_segments_max);
> +			return;
> +		}
> +
> +		tst_brk(TCONF, "STATX_WRITE_ATOMIC unsupported by block dev or filesystem: STATX_ATTR_WRITE_ATOMIC missing from stx_attributes");
> +	}
> +
> +	TST_EXP_EXPR(buff->data.stx_atomic_write_unit_min <= buff->data.stx_atomic_write_unit_max,
> +			"stx_atomic_write_unit_min(%u) <= stx_atomic_write_unit_max(%u)",
> +			buff->data.stx_atomic_write_unit_min, buff->data.stx_atomic_write_unit_max);

We have macros for comparsions TST_EXP_LE_*.

> +	TST_EXP_EXPR(buff->data.stx_atomic_write_segments_max > 0,
> +			"stx_atomic_write_segments_max(%u) > 0", buff->data.stx_atomic_write_segments_max);
> +
> +	TST_EXP_EXPR(buff->data.stx_atomic_write_unit_min > 0 &&
> +			!(buff->data.stx_atomic_write_unit_min & (buff->data.stx_atomic_write_unit_min - 1)),

This is really ugly, I guess that we should add TST_EXP_POW2() that
would check that the number is a power of two.

> +			"stx_atomic_write_unit_min(%u) is a power of 2",
> +			buff->data.stx_atomic_write_unit_min);
> +
> +	TST_EXP_EXPR(buff->data.stx_atomic_write_unit_max > 0 &&
> +			!(buff->data.stx_atomic_write_unit_max & (buff->data.stx_atomic_write_unit_max - 1)),
> +			"stx_atomic_write_unit_max(%u) is a power of 2",
> +			buff->data.stx_atomic_write_unit_max);
> +
> +	if (buff->data.stx_atomic_write_unit_max_opt == 0) {
> +		tst_res(TPASS, "stx_atomic_write_unit_max_opt is 0 (no optimized max reported)");
> +	} else {
> +		if (buff->data.stx_atomic_write_unit_max_opt > buff->data.stx_atomic_write_unit_max) {
> +			tst_res(TFAIL, "stx_atomic_write_unit_max_opt (%u) exceeds max (%u)",
> +					buff->data.stx_atomic_write_unit_max_opt,
> +					buff->data.stx_atomic_write_unit_max);
> +		} else if (buff->data.stx_atomic_write_unit_max_opt < buff->data.stx_atomic_write_unit_min) {
> +			tst_res(TFAIL, "stx_atomic_write_unit_max_opt (%u) is less than min (%u)",
> +					buff->data.stx_atomic_write_unit_max_opt,
> +					buff->data.stx_atomic_write_unit_min);
> +		} else {
> +			tst_res(TPASS, "stx_atomic_write_unit_max_opt (%u) is within valid range [%u, %u]",
> +					buff->data.stx_atomic_write_unit_max_opt,
> +					buff->data.stx_atomic_write_unit_min,
> +					buff->data.stx_atomic_write_unit_max);
> +		}

This is very ugly as well. If we need strict less than we should add
TST_EXP_LT_* macros and make use of these here.

> +		TST_EXP_EXPR(!(buff->data.stx_atomic_write_unit_max_opt & (buff->data.stx_atomic_write_unit_max_opt - 1)),
> +				"stx_atomic_write_unit_max_opt(%u) is a power of 2",
> +				buff->data.stx_atomic_write_unit_max_opt);
> +	}
> +}
> +
> +static int has_thp(void)
> +{
> +	return access(PATH_MM_THP, F_OK) == 0;
> +}
> +
> +static void setup(void)
> +{
> +	struct ltp_statx dev_stx;
> +	struct stat sb;
> +	char opt_bsize[32];
> +	char opt_cluster[32];
> +	const char *fs_opts[8];
> +	unsigned int min, max, bsize = 0;
> +	int dev_has_atomic;
> +
> +	SAFE_STATX(AT_FDCWD, tst_device->dev, 0, STATX_WRITE_ATOMIC, &dev_stx);
> +
> +	/*
> +	 * stx_mask only gains STATX_WRITE_ATOMIC when bdev_can_atomic_write()
> +	 * is true (see block/bdev.c:bdev_statx()), i.e. this is a device
> +	 * capability signal, not a kernel version one: .min_kver = "6.13"
> +	 * above already guarantees the kernel is new enough for the field to
> +	 * exist at all. So any of these three being unset simply means this
> +	 * particular device (most commonly a loop device) has no atomic
> +	 * write support to report.
> +	 */
> +	dev_has_atomic = (dev_stx.data.stx_mask & STATX_WRITE_ATOMIC) &&
> +		(dev_stx.data.stx_attributes_mask & STATX_ATTR_WRITE_ATOMIC) &&
> +		(dev_stx.data.stx_attributes & STATX_ATTR_WRITE_ATOMIC);
> +
> +	if (!dev_has_atomic && strcmp(tst_device->fs_type, "xfs")) {
> +		/*
> +		 * Unlike XFS, ext4 has no device-independent (software)
> +		 * atomic write mechanism: ext4_atomic_write_init() always
> +		 * requires bdev_can_atomic_write() to be true. So without
> +		 * device support there is nothing for ext4 to exercise here.
> +		 */
> +		tst_brk(TCONF,
> +			"%s does not support atomic writes (loop devices never do) and ext4 has no software atomic write fallback; set LTP_DEV to a real NVMe/SCSI device, or load scsi_debug",
> +			tst_device->dev);
> +
> +	}
> +
> +	if (!dev_has_atomic) {
> +		/*
> +		 * No hardware atomic write support, but XFS can still
> +		 * complete atomic writes via CoW-based out-of-place writes
> +		 * (xfs_inode_can_sw_atomic_write()) as long as reflink is
> +		 * enabled, independently of the backing device -- this
> +		 * works even on a plain loop device, but only since Linux
> +		 * v6.16. Force reflink on explicitly rather than relying on
> +		 * mkfs.xfs defaults, and skip the device-limit-based block
> +		 * size selection below entirely since it doesn't apply here.
> +		 * If the running kernel predates v6.16, verify_statx() will
> +		 * TCONF on its own once it sees STATX_WRITE_ATOMIC missing.
> +		 */

These long comments only copy information from the top level doc
comment. Since we already have them there we shouldn't add them here for
a second time.

> +		tst_res(TINFO,
> +			"%s has no atomic write support; relying on XFS's software (CoW-based, reflink) atomic writes instead (requires Linux v6.16+)",
> +			tst_device->dev);
> +
> +		fs_opts[0] = "-f";
> +		fs_opts[1] = "-m";
> +		fs_opts[2] = "reflink=1";
> +		fs_opts[3] = NULL;
> +
> +		SAFE_MKFS(tst_device->dev, tst_device->fs_type, fs_opts, NULL);
> +		goto mount_fs;
> +	}
> +
> +	min = dev_stx.data.stx_atomic_write_unit_min;
> +	max = dev_stx.data.stx_atomic_write_unit_max;
> +
> +	if (!min || !max)
> +		tst_brk(TCONF, "%s reports zero atomic write unit limits", tst_device->dev);
> +
> +	if (!strcmp(tst_device->fs_type, "xfs")) {
> +		if (max >= 65536 && has_thp())
> +			bsize = 16384;
> +		else if (has_thp())
> +			bsize = max;
> +		else
> +			bsize = MIN(max, (unsigned int)getpagesize());
> +	} else {
> +		bsize = MIN(max, (unsigned int)getpagesize());
> +	}
> +
> +	bsize = MIN(bsize, (unsigned int)MKFS_MAX_BLOCK_SIZE);
> +
> +	if (bsize < min) {
> +		tst_brk(TCONF,
> +			"Device's minimum atomic write unit (%u) exceeds the largest block size this test can configure (%u)",
> +			min, bsize);
> +	}
> +
> +	if (!strcmp(tst_device->fs_type, "xfs")) {
> +		tst_res(TINFO, "Device atomic write unit: [%u, %u], THP %s, using xfs block size %u",
> +				min, max, has_thp() ? "available" : "unavailable", bsize);
> +
> +		snprintf(opt_bsize, sizeof(opt_bsize), "-bsize=%u", bsize);
> +		fs_opts[0] = "-f";
> +		fs_opts[1] = opt_bsize;
> +		fs_opts[2] = NULL;
> +	} else {
> +		unsigned int cluster = MIN(max, 16 * bsize);
> +
> +		if (cluster < bsize)
> +			cluster = bsize;
> +
> +		tst_res(TINFO, "Device atomic write unit: [%u, %u], using ext4 block size %u, cluster size %u",
> +				min, max, bsize, cluster);
> +
> +		snprintf(opt_bsize, sizeof(opt_bsize), "%u", bsize);
> +		snprintf(opt_cluster, sizeof(opt_cluster), "%u", cluster);
> +		fs_opts[0] = "-O";
> +		fs_opts[1] = "bigalloc";
> +		fs_opts[2] = "-b";
> +		fs_opts[3] = opt_bsize;
> +		fs_opts[4] = "-C";
> +		fs_opts[5] = opt_cluster;
> +		fs_opts[6] = NULL;
> +	}
> +
> +	SAFE_MKFS(tst_device->dev, tst_device->fs_type, fs_opts, NULL);
> +
> +mount_fs:
> +
> +	TEST(mount(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, NULL));
> +	if (TST_RET) {
> +		if (TST_ERR == EINVAL || TST_ERR == ENOSYS || TST_ERR == EOPNOTSUPP) {
> +			if (bsize)
> +				tst_brk(TCONF | TERRNO, "mount() of %s with block size %u not supported",
> +						tst_device->fs_type, bsize);
> +			tst_brk(TCONF | TERRNO, "mount() of %s not supported",
> +					tst_device->fs_type);
> +		}
> +		tst_brk(TBROK | TERRNO, "mount(%s, %s, %s, 0, NULL) failed",
> +				tst_device->dev, MNTPOINT, tst_device->fs_type);
> +	}
> +	mount_flag = 1;
> +
> +	SAFE_STAT(MNTPOINT, &sb);
> +
> +	data_buff = SAFE_MEMALIGN(sb.st_blksize, sb.st_blksize);
> +	memset(data_buff, '@', sb.st_blksize);
> +
> +	file_fd = SAFE_OPEN(TESTFILE, O_RDWR | O_CREAT | O_DIRECT, MODE);
> +	SAFE_WRITE(SAFE_WRITE_ALL, file_fd, data_buff, sb.st_blksize);
> +}
> +
> +static void cleanup(void)
> +{
> +	free(data_buff);
> +
> +	if (file_fd != -1)
> +		SAFE_CLOSE(file_fd);
> +
> +	if (mount_flag)
> +		tst_umount(MNTPOINT);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = verify_statx,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.min_kver = "6.13",
> +	.needs_root = 1,
> +	.needs_device = 1,
> +	.needs_tmpdir = 1,
> +	.mntpoint = MNTPOINT,
> +	.bufs = (struct tst_buffers []) {
> +		{&buff, .size = sizeof(*buff)},
> +		{}
> +	},
> +	.filesystems = (struct tst_fs[]) {
> +		{.type = "xfs"},
> +		{.type = "ext4"},
> +		{}
> +	},
> +};
> 
> ---
> base-commit: af1ad307f998b7f381bab065225df17390b91f77
> change-id: 20261027-statx-atomic-write-db54af9ef297
> 
> Best regards,
> -- 
> Gaurav Pathak <gaurav.pathak@suse.com>
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
