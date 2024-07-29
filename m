Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA2FC3DA61
	for <ltp@archiver.kernel.org>; Mon, 29 Jul 2024 21:29:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 51A233D1D7A
	for <ltp@archiver.kernel.org>; Mon, 29 Jul 2024 23:29:48 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 012AF3D0CBC
 for <ltp@lists.linux.it>; Mon, 29 Jul 2024 23:29:32 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3BFF42000EC
 for <ltp@lists.linux.it>; Mon, 29 Jul 2024 23:29:31 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EB5B121A0A;
 Mon, 29 Jul 2024 21:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722288571;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Sn5jI/SsClEYCfkoN7sjZPYSbm9DBemxSkSdF+lIVvg=;
 b=U/Nv86066Q0mnzuXY+pJjjDVFXehK92+2xv+vLwIC+Ys9TISLP0voR3ZSNW9m/1EMtBuNZ
 8EcoHZ6KB+3qBEufOmo5MTk2WMb6oLuy5LAcDT8+ZqHd6jj+MaH4ZXVlRIFaJHLP0nfb4G
 NxRdPqWEFOOgSoOzj4XIOMGQXiU9SEY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722288571;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Sn5jI/SsClEYCfkoN7sjZPYSbm9DBemxSkSdF+lIVvg=;
 b=hqf2KKxESLuT3/3+byfvM85pZXdecLSbXxvc/UwUQMIjfMspVIj9FcCtSIsgab9ZT/Ox6r
 Pw1DPcVTQg4UZrDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=OBv2ax54;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="/vmAtPsS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722288570;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Sn5jI/SsClEYCfkoN7sjZPYSbm9DBemxSkSdF+lIVvg=;
 b=OBv2ax54KHy4Ku8FQ+1JiRbwgoAgmMp1xkOpNjaFBmqTPRzrHbBRPvTTcCGk6n8JZZqo5k
 4WGnXqtid1SEx0dcDPSEgFdn7kbOmJ/s42n/UqwUiBUThAcGDb+6LJXCaDYF8T4h6Tpqq1
 B7OxoDf7rZrUJP55KpbTQOx2Urcwmkg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722288570;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Sn5jI/SsClEYCfkoN7sjZPYSbm9DBemxSkSdF+lIVvg=;
 b=/vmAtPsSe4o52ENFDa8hIxPAompTnxTrO4xWbuNQvYR1MPPrKaI0tPnT8kBikwI9pBtK3E
 4SxvOk3bLr+rV3AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 384B6138A7;
 Mon, 29 Jul 2024 21:29:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id PLkpBLoJqGZYWQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 29 Jul 2024 21:29:30 +0000
Date: Mon, 29 Jul 2024 23:29:28 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240729212928.GA1299602@pevik>
References: <20240723-ioctl_ficlone-v2-0-33075bbc117f@suse.com>
 <20240723-ioctl_ficlone-v2-3-33075bbc117f@suse.com>
 <20240729115335.GA1251624@pevik> <ZqeFKkUbhlikEfNS@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZqeFKkUbhlikEfNS@yuki>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: EB5B121A0A
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/7] Add ioctl_ficlone02 test
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
Cc: linux-bcachefs@vger.kernel.org, Kent Overstreet <kent.overstreet@linux.dev>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril, all,

> Hi!
> > This test, merged as [1] fails on bcachefs:

> > $ cd testcases/kernel/syscalls/ioctl/
> > # # LTP_SINGLE_FS_TYPE=bcachefs ./ioctl_ficlone02
> > tst_buffers.c:57: TINFO: Test is using guarded buffers
> > tst_tmpdir.c:316: TINFO: Using /tmp/LTP_iocu1xhKp as tmpdir (tmpfs filesystem)
> > tst_device.c:96: TINFO: Found free device 0 '/dev/loop0'
> > tst_test.c:1806: TINFO: LTP version: 20240524-131-gdfb293ee0
> > tst_test.c:1650: TINFO: Timeout per run is 0h 00m 30s
> > tst_supported_fs_types.c:161: TINFO: WARNING: testing only bcachefs
> > tst_supported_fs_types.c:97: TINFO: Kernel supports bcachefs
> > tst_supported_fs_types.c:62: TINFO: mkfs.bcachefs does exist
> > tst_test.c:1746: TINFO: === Testing on bcachefs ===
> > tst_test.c:1111: TINFO: Formatting /dev/loop0 with bcachefs opts='' extra opts=''
> > tst_test.c:1123: TINFO: Mounting /dev/loop0 to /tmp/LTP_iocu1xhKp/mnt fstyp=bcachefs flags=0
> > ioctl_ficlone02.c:33: TFAIL: ioctl(dst_fd, FICLONE, src_fd) succeeded
> > ioctl_ficlone02.c:34: TFAIL: ioctl(dst_fd, FICLONERANGE, clone_range) expected EOPNOTSUPP: EINVAL (22)

> This looks that FIOCLONE is supported on bcachefs and bcachefs should be
> skipped in this test as well. And I suppose that we should enable
> bcachefs in the rest of the FICLONE tests too.

Thanks! (I should have read the test description).
I dared to enable it + skip on ioctl_ficlone02.c and merge with your SBT

https://github.com/linux-test-project/ltp/commit/b3d9561793657239548269378d02f65580917e7c

> BTW, the EINVAL in the second subtest is caused by the fact that we
> attempt to clone a range that does not exist, this can be fixed by:

> diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ficlone02.c b/testcases/kernel/syscalls/ioctl/ioctl_ficlone02.c
> index be3b01c29..17452a1a3 100644
> --- a/testcases/kernel/syscalls/ioctl/ioctl_ficlone02.c
> +++ b/testcases/kernel/syscalls/ioctl/ioctl_ficlone02.c
> @@ -43,6 +43,8 @@ static void setup(void)

>         SAFE_STAT(MNTPOINT, &sb);

> +       tst_fill_file(SRCPATH, 0x00, sb.st_blksize, 1);
> +
>         clone_range->src_offset = 0;
>         clone_range->src_length = sb.st_blksize;
>         clone_range->dest_offset = 0;

Thanks, again! This is less confusing. I again dared to merge with your SBT:
https://github.com/linux-test-project/ltp/commit/9c6390812831f5c36e531be5a25bd8d7862e79fb

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
