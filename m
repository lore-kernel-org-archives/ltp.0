Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D74EC3DA4A
	for <ltp@archiver.kernel.org>; Mon, 29 Jul 2024 11:54:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5FA0B3D1D65
	for <ltp@archiver.kernel.org>; Mon, 29 Jul 2024 13:54:02 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2AE2A3D1D43
 for <ltp@lists.linux.it>; Mon, 29 Jul 2024 13:53:45 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id F3E8160110A
 for <ltp@lists.linux.it>; Mon, 29 Jul 2024 13:53:44 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0A75A1F793;
 Mon, 29 Jul 2024 11:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722254024;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y8DIbUraKoClAx4NSeSz1Ixn6mYPUc7MmPw43MLn+Ko=;
 b=TidKj90rA8kkeUQd3zKQIf6QlouDBGJo/eyMkZm6lczKsbmRU33N256bJdc17GLtOl+ufS
 onl3SLOxfhzomnkX50stZ6cAT+qDj1z4uhIsYP8dfHLSx2xmQ2zVc7E6l9a1yVpJiL2v7F
 H7cp1ZhYtBuN3VUciCYWtdhz11qsb2Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722254024;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y8DIbUraKoClAx4NSeSz1Ixn6mYPUc7MmPw43MLn+Ko=;
 b=1wzAQu6zezT3ycMO0a0YI2Vaj1tKB6YG5NFKotKVDv0bZvQ6LufRBFMuYnGj5gJ/VqRyvP
 ZnbMhjvxeOeZ5JAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=TidKj90r;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=1wzAQu6z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722254024;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y8DIbUraKoClAx4NSeSz1Ixn6mYPUc7MmPw43MLn+Ko=;
 b=TidKj90rA8kkeUQd3zKQIf6QlouDBGJo/eyMkZm6lczKsbmRU33N256bJdc17GLtOl+ufS
 onl3SLOxfhzomnkX50stZ6cAT+qDj1z4uhIsYP8dfHLSx2xmQ2zVc7E6l9a1yVpJiL2v7F
 H7cp1ZhYtBuN3VUciCYWtdhz11qsb2Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722254024;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y8DIbUraKoClAx4NSeSz1Ixn6mYPUc7MmPw43MLn+Ko=;
 b=1wzAQu6zezT3ycMO0a0YI2Vaj1tKB6YG5NFKotKVDv0bZvQ6LufRBFMuYnGj5gJ/VqRyvP
 ZnbMhjvxeOeZ5JAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D6EAC138A7;
 Mon, 29 Jul 2024 11:53:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zljEMseCp2apOAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 29 Jul 2024 11:53:43 +0000
Date: Mon, 29 Jul 2024 13:53:35 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20240729115335.GA1251624@pevik>
References: <20240723-ioctl_ficlone-v2-0-33075bbc117f@suse.com>
 <20240723-ioctl_ficlone-v2-3-33075bbc117f@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240723-ioctl_ficlone-v2-3-33075bbc117f@suse.com>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 0A75A1F793
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:dkim];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.cz:+]; MISSING_XM_UA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
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

Hi all,

> This test verifies that ioctl() FICLONE/FICLONERANGE feature
> correctly raises EOPNOTSUPP when unsupported filesystem is used.
> In particular, filesystems which don't support copy-on-write.

This test, merged as [1] fails on bcachefs:

$ cd testcases/kernel/syscalls/ioctl/
# # LTP_SINGLE_FS_TYPE=bcachefs ./ioctl_ficlone02
tst_buffers.c:57: TINFO: Test is using guarded buffers
tst_tmpdir.c:316: TINFO: Using /tmp/LTP_iocu1xhKp as tmpdir (tmpfs filesystem)
tst_device.c:96: TINFO: Found free device 0 '/dev/loop0'
tst_test.c:1806: TINFO: LTP version: 20240524-131-gdfb293ee0
tst_test.c:1650: TINFO: Timeout per run is 0h 00m 30s
tst_supported_fs_types.c:161: TINFO: WARNING: testing only bcachefs
tst_supported_fs_types.c:97: TINFO: Kernel supports bcachefs
tst_supported_fs_types.c:62: TINFO: mkfs.bcachefs does exist
tst_test.c:1746: TINFO: === Testing on bcachefs ===
tst_test.c:1111: TINFO: Formatting /dev/loop0 with bcachefs opts='' extra opts=''
tst_test.c:1123: TINFO: Mounting /dev/loop0 to /tmp/LTP_iocu1xhKp/mnt fstyp=bcachefs flags=0
ioctl_ficlone02.c:33: TFAIL: ioctl(dst_fd, FICLONE, src_fd) succeeded
ioctl_ficlone02.c:34: TFAIL: ioctl(dst_fd, FICLONERANGE, clone_range) expected EOPNOTSUPP: EINVAL (22)

I tested only kernel 6.10 and 6.9, fails on both. Maybe it's just a different
errno set...

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/commit/d70bfb185c9aa52aeab9b9893055eec7fc969a4f


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
