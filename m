Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F468C3DA4A
	for <ltp@archiver.kernel.org>; Mon, 29 Jul 2024 12:04:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7002A3D1D61
	for <ltp@archiver.kernel.org>; Mon, 29 Jul 2024 14:04:47 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 026393D0E76
 for <ltp@lists.linux.it>; Mon, 29 Jul 2024 14:04:31 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4D080601B09
 for <ltp@lists.linux.it>; Mon, 29 Jul 2024 14:04:30 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BD96821ABB;
 Mon, 29 Jul 2024 12:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722254669; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ngw3fmwyCBGRGh+nvno+haMhFhbmWnzlT4bmQsXAhzY=;
 b=ZV3W4zePG+pXOqihPAQOwlooLYneSCjuITd7RX6aGAt/9yMrZn8FWRWCJHHIC9Z7vWQK6g
 6/zDPdw9BEsJy6ifyQaluQN1HKAWEwHXfYTriYyx3eGDNj5adDzK5JRAuqbJliST5OKOVD
 sRELH2aPzlieEZgP0a7/YEFWce7D7OM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722254669;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ngw3fmwyCBGRGh+nvno+haMhFhbmWnzlT4bmQsXAhzY=;
 b=iwP5IPSLbahq5159ZqWQkpdZszOTo84vzv3f/ibGtn/csCJFXJkd6iY0LVczDeHE1Bew5+
 NvxNmGn0DYpMLwDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ZV3W4zeP;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=iwP5IPSL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722254669; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ngw3fmwyCBGRGh+nvno+haMhFhbmWnzlT4bmQsXAhzY=;
 b=ZV3W4zePG+pXOqihPAQOwlooLYneSCjuITd7RX6aGAt/9yMrZn8FWRWCJHHIC9Z7vWQK6g
 6/zDPdw9BEsJy6ifyQaluQN1HKAWEwHXfYTriYyx3eGDNj5adDzK5JRAuqbJliST5OKOVD
 sRELH2aPzlieEZgP0a7/YEFWce7D7OM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722254669;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ngw3fmwyCBGRGh+nvno+haMhFhbmWnzlT4bmQsXAhzY=;
 b=iwP5IPSLbahq5159ZqWQkpdZszOTo84vzv3f/ibGtn/csCJFXJkd6iY0LVczDeHE1Bew5+
 NvxNmGn0DYpMLwDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A155B138A7;
 Mon, 29 Jul 2024 12:04:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id I+NvJk2Fp2YoPAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 29 Jul 2024 12:04:29 +0000
Date: Mon, 29 Jul 2024 14:03:54 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZqeFKkUbhlikEfNS@yuki>
References: <20240723-ioctl_ficlone-v2-0-33075bbc117f@suse.com>
 <20240723-ioctl_ficlone-v2-3-33075bbc117f@suse.com>
 <20240729115335.GA1251624@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240729115335.GA1251624@pevik>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.81 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: BD96821ABB
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
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
Cc: linux-bcachefs@vger.kernel.org, Kent Overstreet <kent.overstreet@linux.dev>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> This test, merged as [1] fails on bcachefs:
> 
> $ cd testcases/kernel/syscalls/ioctl/
> # # LTP_SINGLE_FS_TYPE=bcachefs ./ioctl_ficlone02
> tst_buffers.c:57: TINFO: Test is using guarded buffers
> tst_tmpdir.c:316: TINFO: Using /tmp/LTP_iocu1xhKp as tmpdir (tmpfs filesystem)
> tst_device.c:96: TINFO: Found free device 0 '/dev/loop0'
> tst_test.c:1806: TINFO: LTP version: 20240524-131-gdfb293ee0
> tst_test.c:1650: TINFO: Timeout per run is 0h 00m 30s
> tst_supported_fs_types.c:161: TINFO: WARNING: testing only bcachefs
> tst_supported_fs_types.c:97: TINFO: Kernel supports bcachefs
> tst_supported_fs_types.c:62: TINFO: mkfs.bcachefs does exist
> tst_test.c:1746: TINFO: === Testing on bcachefs ===
> tst_test.c:1111: TINFO: Formatting /dev/loop0 with bcachefs opts='' extra opts=''
> tst_test.c:1123: TINFO: Mounting /dev/loop0 to /tmp/LTP_iocu1xhKp/mnt fstyp=bcachefs flags=0
> ioctl_ficlone02.c:33: TFAIL: ioctl(dst_fd, FICLONE, src_fd) succeeded
> ioctl_ficlone02.c:34: TFAIL: ioctl(dst_fd, FICLONERANGE, clone_range) expected EOPNOTSUPP: EINVAL (22)

This looks that FIOCLONE is supported on bcachefs and bcachefs should be
skipped in this test as well. And I suppose that we should enable
bcachefs in the rest of the FICLONE tests too.

BTW, the EINVAL in the second subtest is caused by the fact that we
attempt to clone a range that does not exist, this can be fixed by:

diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ficlone02.c b/testcases/kernel/syscalls/ioctl/ioctl_ficlone02.c
index be3b01c29..17452a1a3 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_ficlone02.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ficlone02.c
@@ -43,6 +43,8 @@ static void setup(void)

        SAFE_STAT(MNTPOINT, &sb);

+       tst_fill_file(SRCPATH, 0x00, sb.st_blksize, 1);
+
        clone_range->src_offset = 0;
        clone_range->src_length = sb.st_blksize;
        clone_range->dest_offset = 0;



-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
