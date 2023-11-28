Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE8F9C07E97
	for <ltp@archiver.kernel.org>; Tue, 28 Nov 2023 16:55:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DDE833CFA82
	for <ltp@archiver.kernel.org>; Tue, 28 Nov 2023 17:55:54 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6523F3CD9DD
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 17:55:42 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9B5F3140025F
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 17:55:41 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A080D219A1;
 Tue, 28 Nov 2023 16:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1701190540;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=idzQMjmslOKPDR1depUel+KzFKzhiqB54mW909uKewA=;
 b=NQsfs/XlJH9KOxc01Y6UaMPeX8jZvul+Sz660dZ7OKY7JPRO7CwFPJuyi1NX5Kexo9Kno7
 5EtziKGCAXXas0TCmEDJkHKnuUFgWbOhbLOQ8pSSViau0ERd3nmdZA6aKV7h0jSrJFaXBh
 RmhApSEF/kemX1q8SsCCh14/IGa3BqQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1701190540;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=idzQMjmslOKPDR1depUel+KzFKzhiqB54mW909uKewA=;
 b=nJ0LVtPTe++6y3+O9QNzdfZHTigi3dgSQ+W9qqnh4szZMuBjtdUvtsJXEdPdPxx8CgWdDU
 Ohyb8HTszLNtSfBg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 81DAF139FC;
 Tue, 28 Nov 2023 16:55:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id v5sbHowbZmWoYAAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Tue, 28 Nov 2023 16:55:40 +0000
Date: Tue, 28 Nov 2023 17:55:38 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Marius Kittler <mkittler@suse.de>
Message-ID: <20231128165538.GB406520@pevik>
References: <20231128150438.16691-1-mkittler@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231128150438.16691-1-mkittler@suse.de>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-4.50 / 50.00];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; REPLY(-4.00)[]; RCVD_COUNT_THREE(0.00)[3];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 BAYES_HAM(-0.00)[10.72%]; ARC_NA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] Port getxattr02.c to new test API
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

Hi Marius,

I'm sorry, the last thing is that test does not umount, thus it fails with -iN:

# ./getxattr02 -i2
tst_device.c:96: TINFO: Found free device 0 '/dev/loop0'
tst_test.c:1690: TINFO: LTP version: 20230929-156-ge94d16fe8
tst_test.c:1574: TINFO: Timeout per run is 0h 00m 30s
tst_supported_fs_types.c:90: TINFO: Kernel supports ext2
tst_supported_fs_types.c:55: TINFO: mkfs.ext2 does exist
tst_supported_fs_types.c:90: TINFO: Kernel supports ext3
tst_supported_fs_types.c:55: TINFO: mkfs.ext3 does exist
tst_supported_fs_types.c:90: TINFO: Kernel supports ext4
tst_supported_fs_types.c:55: TINFO: mkfs.ext4 does exist
tst_supported_fs_types.c:90: TINFO: Kernel supports xfs
tst_supported_fs_types.c:55: TINFO: mkfs.xfs does exist
tst_supported_fs_types.c:90: TINFO: Kernel supports btrfs
tst_supported_fs_types.c:55: TINFO: mkfs.btrfs does exist
tst_supported_fs_types.c:90: TINFO: Kernel supports vfat
tst_supported_fs_types.c:55: TINFO: mkfs.vfat does exist
tst_supported_fs_types.c:90: TINFO: Kernel supports exfat
tst_supported_fs_types.c:55: TINFO: mkfs.exfat does exist
tst_supported_fs_types.c:120: TINFO: FUSE does support ntfs
tst_supported_fs_types.c:55: TINFO: mkfs.ntfs does exist
tst_supported_fs_types.c:90: TINFO: Kernel supports tmpfs
tst_supported_fs_types.c:42: TINFO: mkfs is not needed for tmpfs
tst_test.c:1650: TINFO: === Testing on ext2 ===
tst_test.c:1105: TINFO: Formatting /dev/loop0 with ext2 opts='' extra opts=''
mke2fs 1.47.0 (5-Feb-2023)
tst_test.c:1119: TINFO: Mounting /dev/loop0 to /tmp/LTP_get6hhQ7M/mntpoint fstyp=ext2 flags=0
getxattr02.c:86: TPASS: get attr from fifo: expected return value: ENODATA (61)
getxattr02.c:86: TPASS: get attr from char special: expected return value: ENODATA (61)
getxattr02.c:86: TPASS: get attr from block special: expected return value: ENODATA (61)
getxattr02.c:86: TPASS: get attr from UNIX domain socket: expected return value: ENODATA (61)
getxattr02.c:81: TBROK: create mntpoint/getxattr02getxattr02fifo (mode 4096) failed (get attr from fifo): EEXIST (17)

Could you please fix it?

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
