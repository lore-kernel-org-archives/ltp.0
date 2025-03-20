Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B0CAC28B30
	for <ltp@archiver.kernel.org>; Thu, 20 Mar 2025 17:32:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 46D2C3CACE3
	for <ltp@archiver.kernel.org>; Thu, 20 Mar 2025 18:32:02 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 508CC3CAC1E
 for <ltp@lists.linux.it>; Thu, 20 Mar 2025 18:31:45 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5BAA12003B5
 for <ltp@lists.linux.it>; Thu, 20 Mar 2025 18:31:43 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1235921D6F;
 Thu, 20 Mar 2025 17:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1742491903;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UodoN5jsp9iY/LJaL26IGz+WuQOPzFp9kI/ZNIunul4=;
 b=jSY4oBflVYbp+AF0SpcJ773oRTqjhFfVpH0a+fHoLYRdFHulRpLbf6vaGe6ohFWT5XPbOv
 2Y1KTXbwzOc2TLBaPP6/iavF+nMgygCD93LBXWaDpOC+p5zCFAGsvA9/sYDovYqgyb108v
 QoFR6S5tvTFC1TY5EqTi3r69CsCJ5Os=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1742491903;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UodoN5jsp9iY/LJaL26IGz+WuQOPzFp9kI/ZNIunul4=;
 b=xGk3fUMSCAOiwMeDIVArr6GjR5O031c6RZ8G0Kel90WT3tNtwUzerBopXn5d4IovuQDt2N
 ooFYjYGCBkqGTGCg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=jSY4oBfl;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=xGk3fUMS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1742491903;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UodoN5jsp9iY/LJaL26IGz+WuQOPzFp9kI/ZNIunul4=;
 b=jSY4oBflVYbp+AF0SpcJ773oRTqjhFfVpH0a+fHoLYRdFHulRpLbf6vaGe6ohFWT5XPbOv
 2Y1KTXbwzOc2TLBaPP6/iavF+nMgygCD93LBXWaDpOC+p5zCFAGsvA9/sYDovYqgyb108v
 QoFR6S5tvTFC1TY5EqTi3r69CsCJ5Os=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1742491903;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UodoN5jsp9iY/LJaL26IGz+WuQOPzFp9kI/ZNIunul4=;
 b=xGk3fUMSCAOiwMeDIVArr6GjR5O031c6RZ8G0Kel90WT3tNtwUzerBopXn5d4IovuQDt2N
 ooFYjYGCBkqGTGCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 88E0613757;
 Thu, 20 Mar 2025 17:31:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +ZEkHv5Q3GffHAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 20 Mar 2025 17:31:42 +0000
Date: Thu, 20 Mar 2025 18:31:41 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250320173141.GA114876@pevik>
References: <20240612121106.11127-1-chrubis@suse.cz>
 <20240612121106.11127-2-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240612121106.11127-2-chrubis@suse.cz>
X-Rspamd-Queue-Id: 1235921D6F
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] lib: tst_test: Add per filesystem mkfs and
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

Hi Cyril, all,

> This commit does:

> * Group the filesystem type, mkfs and mount options into a separate
>   structure

> * Add an array of these structures to be able to define per filesystem
>   mkfs and mount options

> The details on the usage should be hopefully clear from the
> documentation comments for the struct tst_test.

FYI, this merged as cce6188916 ("lib: tst_test: Add per filesystem mkfs and
mount opts") causes this behavior of none testing run when there is no suitable
filesystem. I found it when trying to bisect something with rapido-linux and
compile kernel without Btrfs and XFS. Don't we want to add some TCONF?

Kind regards,
Petr

ioctl_ficlone03.c:
	.filesystems = (struct tst_fs []) {
		{.type = "btrfs"},
		{.type = "bcachefs"},
		{
			.type = "xfs",
			.min_kver = "4.16",
			.mkfs_ver = "mkfs.xfs >= 1.5.0",
			.mkfs_opts = (const char *const []) {"-m", "reflink=1", NULL},
		},
		{}
	},

rapido1:/opt/ltp/testcases/bin# ./ioctl_ficlone03; echo $?
tst_buffers.c:57: TINFO: Test is using guarded buffers
tst_tmpdir.c:317: TINFO: Using /tmp/LTP_iocSKLS9l as tmpdir (tmpfs filesystem)
tst_device.c:99: TINFO: Found free device 0 '/dev/loop0'
tst_test.c:1900: TINFO: LTP version: 20250130-166-g17960d952
tst_test.c:1904: TINFO: Tested kernel: 4.5.0-00002-g22bd332f11d4 #162 SMP Thu Mar 20 18:00:10 CET 2025 x86_64
tst_kconfig.c:88: TINFO: Parsing kernel config '/.config'
tst_test.c:1724: TINFO: Overall timeout per run is 0h 00m 31s
tst_supported_fs_types.c:97: TINFO: Kernel supports ext2
tst_supported_fs_types.c:62: TINFO: mkfs.ext2 does exist
tst_supported_fs_types.c:97: TINFO: Kernel supports ext3
tst_supported_fs_types.c:62: TINFO: mkfs.ext3 does exist
tst_supported_fs_types.c:97: TINFO: Kernel supports ext4
tst_supported_fs_types.c:62: TINFO: mkfs.ext4 does exist
tst_supported_fs_types.c:105: TINFO: Skipping bcachefs because of FUSE blacklist
tst_supported_fs_types.c:97: TINFO: Kernel supports vfat
tst_supported_fs_types.c:62: TINFO: mkfs.vfat does exist
tst_supported_fs_types.c:97: TINFO: Kernel supports tmpfs
tst_supported_fs_types.c:49: TINFO: mkfs is not needed for tmpfs

Summary:
passed   0
failed   0
broken   0
skipped  0
warnings 0
0

rapido1:/opt/ltp/testcases/bin# grep -e CONFIG_BTRFS_FS -e CONFIG_XFS_FS /.config
+ grep -e CONFIG_BTRFS_FS -e CONFIG_XFS_FS /.config
# CONFIG_XFS_FS is not set
# CONFIG_BTRFS_FS is not set

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
