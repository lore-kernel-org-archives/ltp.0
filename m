Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39592C48297
	for <ltp@archiver.kernel.org>; Fri,  9 Feb 2024 23:02:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 974AA3CF4F1
	for <ltp@archiver.kernel.org>; Sat, 10 Feb 2024 00:02:49 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 074173CB1BF
 for <ltp@lists.linux.it>; Sat, 10 Feb 2024 00:02:32 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 855D4604854
 for <ltp@lists.linux.it>; Sat, 10 Feb 2024 00:02:30 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 44E511F837;
 Fri,  9 Feb 2024 23:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707519750;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nSKBMpWWtVHmMqYqb5OuhM9ZjI2E6eaPDMv6InGE0XE=;
 b=xcDYkzmqFJwjHTHboxswTnk83WjsjD0znkW1fDeCofejlva1NJD8OEJYGYQ3ZEyCrOQM8w
 pwB7IK51GynFMtWgxG7TPCgqKu3R4nrF9+XLQhFl84ptmz262l615Jw+dOoOVpva4btPZE
 FkclCMvYzyhb9jEs1EtouFZ4FEO8RFA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707519750;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nSKBMpWWtVHmMqYqb5OuhM9ZjI2E6eaPDMv6InGE0XE=;
 b=qesGHcI0QzEigSIdtd4wPwzsg1fJ3HSjpvmXv5tINw1ufk6oqKSSdk4jXW34Fh2a5dyA6r
 xramgz6KQrYbPhCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707519750;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nSKBMpWWtVHmMqYqb5OuhM9ZjI2E6eaPDMv6InGE0XE=;
 b=xcDYkzmqFJwjHTHboxswTnk83WjsjD0znkW1fDeCofejlva1NJD8OEJYGYQ3ZEyCrOQM8w
 pwB7IK51GynFMtWgxG7TPCgqKu3R4nrF9+XLQhFl84ptmz262l615Jw+dOoOVpva4btPZE
 FkclCMvYzyhb9jEs1EtouFZ4FEO8RFA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707519750;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nSKBMpWWtVHmMqYqb5OuhM9ZjI2E6eaPDMv6InGE0XE=;
 b=qesGHcI0QzEigSIdtd4wPwzsg1fJ3HSjpvmXv5tINw1ufk6oqKSSdk4jXW34Fh2a5dyA6r
 xramgz6KQrYbPhCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1FC4413353;
 Fri,  9 Feb 2024 23:02:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UmJFBQavxmX4fAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 09 Feb 2024 23:02:30 +0000
Date: Sat, 10 Feb 2024 00:02:28 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>, ltp@lists.linux.it
Message-ID: <20240209230228.GC371480@pevik>
References: <20240208100517.1974-1-xuyang2018.jy@fujitsu.com>
 <20240208100517.1974-6-xuyang2018.jy@fujitsu.com>
 <20240209224549.GB371480@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240209224549.GB371480@pevik>
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=xcDYkzmq;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=qesGHcI0
X-Spamd-Result: default: False [-6.01 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain];
 DWL_DNSWL_HI(-3.50)[suse.cz:dkim]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 44E511F837
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 6/7] syscalls/swapon03: Simply this case
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

Hi Yang Xu,

> Hi Yang Xu,

> This fails on TMPDIR on btrfs on all tested filesystems:
s/btrfs/tmpfs/ (I'm sorry for a confusion)

> ...
> swapon03.c:61: TFAIL: swapon(filename, 0) failed: EPERM (1)
> swapon03.c:70: TINFO: Successfully created 23 swapfiles
> swapon03.c:138: TPASS: swapon(mntpoint/testswap, 0) : EPERM (1)

I'm sorry, I was wrong. The failure is on master, your patchset actually fix
this on TMPDIR tmpfs:

tst_supported_fs_types.c:49: TINFO: mkfs is not needed for tmpfs
tst_test.c:1701: TINFO: === Testing on ext2 ===
tst_test.c:1117: TINFO: Formatting /dev/loop0 with ext2 opts='' extra opts=''
mke2fs 1.47.0 (5-Feb-2023)
tst_test.c:1131: TINFO: Mounting /dev/loop0 to /tmp/LTP_swaGbGeNL/mntpoint fstyp=ext2 flags=0
swapon03.c:147: TCONF: swap not supported on tmpfs
tst_test.c:1701: TINFO: === Testing on ext3 ===
tst_test.c:1117: TINFO: Formatting /dev/loop0 with ext3 opts='' extra opts=''
mke2fs 1.47.0 (5-Feb-2023)
tst_test.c:1131: TINFO: Mounting /dev/loop0 to /tmp/LTP_swaGbGeNL/mntpoint fstyp=ext3 flags=0
swapon03.c:147: TCONF: swap not supported on tmpfs
tst_test.c:1701: TINFO: === Testing on ext4 ===
tst_test.c:1117: TINFO: Formatting /dev/loop0 with ext4 opts='' extra opts=''
mke2fs 1.47.0 (5-Feb-2023)
tst_test.c:1131: TINFO: Mounting /dev/loop0 to /tmp/LTP_swaGbGeNL/mntpoint fstyp=ext4 flags=0
swapon03.c:147: TCONF: swap not supported on tmpfs
tst_test.c:1701: TINFO: === Testing on xfs ===
tst_test.c:1117: TINFO: Formatting /dev/loop0 with xfs opts='' extra opts=''
tst_test.c:1131: TINFO: Mounting /dev/loop0 to /tmp/LTP_swaGbGeNL/mntpoint fstyp=xfs flags=0
swapon03.c:147: TCONF: swap not supported on tmpfs
tst_test.c:1701: TINFO: === Testing on btrfs ===
tst_test.c:1117: TINFO: Formatting /dev/loop0 with btrfs opts='' extra opts=''
tst_test.c:1131: TINFO: Mounting /dev/loop0 to /tmp/LTP_swaGbGeNL/mntpoint fstyp=btrfs flags=0
swapon03.c:147: TCONF: swap not supported on tmpfs
tst_test.c:1701: TINFO: === Testing on bcachefs ===
tst_test.c:1117: TINFO: Formatting /dev/loop0 with bcachefs opts='' extra opts=''
tst_test.c:1131: TINFO: Mounting /dev/loop0 to /tmp/LTP_swaGbGeNL/mntpoint fstyp=bcachefs flags=0
swapon03.c:147: TCONF: swap not supported on tmpfs
tst_test.c:1701: TINFO: === Testing on vfat ===
tst_test.c:1117: TINFO: Formatting /dev/loop0 with vfat opts='' extra opts=''
tst_test.c:1131: TINFO: Mounting /dev/loop0 to /tmp/LTP_swaGbGeNL/mntpoint fstyp=vfat flags=0
swapon03.c:147: TCONF: swap not supported on tmpfs
tst_test.c:1701: TINFO: === Testing on exfat ===
tst_test.c:1117: TINFO: Formatting /dev/loop0 with exfat opts='' extra opts=''
tst_test.c:1131: TINFO: Mounting /dev/loop0 to /tmp/LTP_swaGbGeNL/mntpoint fstyp=exfat flags=0
swapon03.c:147: TCONF: swap not supported on tmpfs

Although it's a bit suspicious that it always TCONF on tmpfs - this is a
regression on "syscalls/swapon03: use tst_max_swapfiles() and
GET_USED_SWAPFILES() api", but I'll discuss it there.

But now TMPFS on btrfs:
swapon03.c:61: TFAIL: swapon(filename, 0) failed: EPERM (1)

Current master on tmpfs fails:
./swapon03
tst_test.c:1701: TINFO: === Testing on ext2 ===
tst_test.c:1117: TINFO: Formatting /dev/loop0 with ext2 opts='' extra opts=''
mke2fs 1.47.0 (5-Feb-2023)
tst_test.c:1131: TINFO: Mounting /dev/loop0 to /tmp/LTP_swa0jhXpO/mntpoint fstyp=ext2 flags=0
tst_ioctl.c:26: TINFO: FIBMAP ioctl is supported
Failed to create swapfile: swapfile02
swapon03.c:181: TFAIL: Failed to setup swaps

master on btrfs works.

Kind regards,
Petr

> ...
> Summary:
> passed   8
> failed   8
> broken   0
> skipped  2
> warnings 0

> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
