Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDE76C4167B
	for <ltp@archiver.kernel.org>; Thu, 30 Nov 2023 09:29:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 345E13CD9A2
	for <ltp@archiver.kernel.org>; Thu, 30 Nov 2023 10:29:24 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A54653CD549
 for <ltp@lists.linux.it>; Thu, 30 Nov 2023 10:29:14 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E00CB14016EE
 for <ltp@lists.linux.it>; Thu, 30 Nov 2023 10:29:13 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 10EFD1FC83;
 Thu, 30 Nov 2023 09:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1701336551; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yZGGYtWgEFczexVR2S6EYfgm/YgwEUxtzfDRyR262sE=;
 b=cnSZ5e1OzKJDKZ08VIbrcAE+G+Y7t8eRTDBjLPkkOkshBp76x6QqboEGIGjoCHn4/bfEiz
 6oJBH/Z6oPPE8rANLW7WCOn3dkb+g7wl1qtDiMtDNGk975PVMgVMZvRv09bWcgZPb9WZUV
 qGL9vYd8q1nq+HfCgGXuozKUYsB/b5M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1701336551;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yZGGYtWgEFczexVR2S6EYfgm/YgwEUxtzfDRyR262sE=;
 b=p3kRAA4r7IxVpngCae2IytZuyga7LY32cRdcE4IfMve35I+uCuPpN+zwOnYc2+jrVcWNY2
 gQwaUPQThtOrfFCA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id F3D10138E5;
 Thu, 30 Nov 2023 09:29:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id 8UBIO+ZVaGU6JgAAn2gu4w
 (envelope-from <jack@suse.cz>); Thu, 30 Nov 2023 09:29:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 84E55A07DC; Thu, 30 Nov 2023 10:29:06 +0100 (CET)
Date: Thu, 30 Nov 2023 10:29:06 +0100
From: Jan Kara <jack@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <20231130092906.espzcsg24vilt2l7@quack3>
References: <20231129114617.12660-1-jack@suse.cz>
 <20231129115440.19100-3-jack@suse.cz>
 <20231129134639.GA1426618@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231129134639.GA1426618@pevik>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-3.28 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 FREEMAIL_CC(0.00)[suse.cz,lists.linux.it,gmail.com];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-2.68)[98.61%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/6] fanotify: Switch event and mark tests to
 *_on_fs() variant
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed 29-11-23 14:46:39, Petr Vorel wrote:
> Hi Jan, Amir,
> 
> > Switch event availability and mark type availability tests to be
> > performed on the filesystem actually used for testing instead of on the
> > current directory. This is more reliable as not all filesystems support
> > the same set of features.
> 
> Jan, unfortunately this commit breaks fanotify09 and fanotify10 on SLES15 based kernels:
> 
> # ./fanotify09
> tst_device.c:97: TINFO: Found free device 0 '/dev/loop0'
> tst_test.c:1106: TINFO: Formatting /dev/loop0 with ext2 opts='' extra opts=''
> mke2fs 1.46.4 (18-Aug-2021)
> tst_test.c:1120: TINFO: Mounting /dev/loop0 to /tmp/LTP_fanRt2Q1k/fs_mnt fstyp=ext2 flags=0
> tst_test.c:1690: TINFO: LTP version: 20230929-156-gf7f69b7ef
> tst_test.c:1576: TINFO: Timeout per run is 0h 00m 30s
> fanotify.h:210: TBROK: fanotify_mark (3, FAN_MARK_ADD, ..., AT_FDCWD, fs_mnt) failed: EINVAL (22)
> ...

Thanks for testing! Indeed this was a bug in Amir's original test function
which I didn't notice. I've fixed it up.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
