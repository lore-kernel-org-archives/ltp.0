Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 719A9C10DC2
	for <ltp@archiver.kernel.org>; Tue, 28 Nov 2023 11:31:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ADF363CF66F
	for <ltp@archiver.kernel.org>; Tue, 28 Nov 2023 12:31:14 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D31903CDA1D
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 12:31:04 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5F1A76008A2
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 12:30:26 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 49A6C1F6E6;
 Tue, 28 Nov 2023 11:30:26 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 14371139FC;
 Tue, 28 Nov 2023 11:30:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id zPO7A1LPZWVreAAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Tue, 28 Nov 2023 11:30:26 +0000
Date: Tue, 28 Nov 2023 12:30:24 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <20231128113024.GA369141@pevik>
References: <20231127154013.2625-1-jack@suse.cz>
 <CAOQ4uxhtz2rCn70roeof0Bt8CbAi0vK4CMNiuoFq9M85FUpgGQ@mail.gmail.com>
 <20231127182602.p5tx5hvinsobw3xb@quack3>
 <20231127220713.GA292630@pevik>
 <CAOQ4uxgbHEpLz+pNONOMun5KFUrKnGZX=KbHPkx7LjN3Z4RuRg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgbHEpLz+pNONOMun5KFUrKnGZX=KbHPkx7LjN3Z4RuRg@mail.gmail.com>
X-Spamd-Bar: +++++++++++
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out2.suse.de; dkim=none;
 spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither
 permitted nor denied by domain of pvorel@suse.cz)
 smtp.mailfrom=pvorel@suse.cz; dmarc=none
X-Rspamd-Queue-Id: 49A6C1F6E6
X-Spamd-Result: default: False [11.99 / 50.00];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; RCVD_VIA_SMTP_AUTH(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 MID_RHS_NOT_FQDN(0.50)[]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 R_SPF_SOFTFAIL(4.60)[~all];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
 RCVD_COUNT_THREE(0.00)[3]; DMARC_NA(1.20)[suse.cz];
 MX_GOOD(-0.01)[]; NEURAL_HAM_SHORT(-0.20)[-0.997];
 NEURAL_SPAM_LONG(3.50)[1.000]; FREEMAIL_TO(0.00)[gmail.com];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 R_DKIM_NA(2.20)[]; MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.00)[12.30%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fanotify: Fix broken tests due to
 fanotify_events_supported_by_kernel()
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Amir,

...
> > > > FYI, in this branch:
> > > > https://github.com/amir73il/ltp/commits/fanotify_fsid

> > FYI the first commit breaks at least vfat on fanotify13
> > # LTP_SINGLE_FS_TYPE=vfat ./fanotify13
> > ...
> > tst_test.c:1650: TINFO: === Testing on vfat ===
> > tst_test.c:1105: TINFO: Formatting /dev/loop1 with vfat opts='' extra opts=''
> > tst_test.c:1119: TINFO: Mounting /dev/loop1 to /tmp/LTP_fanM9wLom/mntpoint fstyp=vfat flags=0
> > fanotify13.c:152: TINFO: Test #0.1: FAN_REPORT_FID with mark flag: FAN_MARK_INODE
> > fanotify13.c:157: TCONF: overlayfs not supported on vfat
> > fanotify13.c:152: TINFO: Test #1.1: FAN_REPORT_FID with mark flag: FAN_MARK_INODE
> > fanotify13.c:157: TCONF: overlayfs not supported on vfat
> > fanotify13.c:152: TINFO: Test #2.1: FAN_REPORT_FID with mark flag: FAN_MARK_MOUNT
> > fanotify13.c:157: TCONF: overlayfs not supported on vfat
> > fanotify13.c:152: TINFO: Test #3.1: FAN_REPORT_FID with mark flag: FAN_MARK_MOUNT
> > fanotify13.c:157: TCONF: overlayfs not supported on vfat
> > fanotify13.c:152: TINFO: Test #4.1: FAN_REPORT_FID with mark flag: FAN_MARK_FILESYSTEM
> > fanotify13.c:157: TCONF: overlayfs not supported on vfat
> > fanotify13.c:152: TINFO: Test #5.1: FAN_REPORT_FID with mark flag: FAN_MARK_FILESYSTEM
> > fanotify13.c:157: TCONF: overlayfs not supported on vfat
> > tst_device.c:408: TINFO: umount('mntpoint') failed with EBUSY, try  1...
> > tst_device.c:412: TINFO: Likely gvfsd-trash is probing newly mounted fs, kill it to speed up tests.
> > tst_device.c:408: TINFO: umount('mntpoint') failed with EBUSY, try  2...
> > tst_device.c:408: TINFO: umount('mntpoint') failed with EBUSY, try  3...
> > ...
> > tst_device.c:408: TINFO: umount('mntpoint') failed with EBUSY, try 50...
> > tst_device.c:419: TWARN: Failed to umount('mntpoint') after 50 retries
> > tst_test.c:1650: TINFO: === Testing on exfat ===
> > tst_test.c:1105: TINFO: Formatting /dev/loop1 with exfat opts='' extra opts=''
> > tst_test.c:1119: TINFO: Mounting /dev/loop1 to /tmp/LTP_fanM9wLom/mntpoint fstyp=exfat flags=0
> > tst_test.c:1119: TINFO: Trying FUSE...
> > FUSE exfat 1.4.0 (libfuse2)
> > fuse: mount failed: Device or resource busy
> > tst_test.c:1119: TBROK: mount.exfat failed with 256


> I believe this breakage is a regression due to overlayfs bug in v6.7-rc1
> that was fixed by commit
> 37f32f526438 ("ovl: fix memory leak in ovl_parse_param()") in v6.7-rc2.

Indeed, it works on openSUSE 6.7.0-rc3-3.ge7296f9-default.

Thanks for info.

Kind regards,
Petr

> Thanks,
> Amir.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
