Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01117C47422
	for <ltp@archiver.kernel.org>; Mon, 29 Jan 2024 08:03:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8CBAB3CC6C1
	for <ltp@archiver.kernel.org>; Mon, 29 Jan 2024 09:03:20 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 68B523CC020
 for <ltp@lists.linux.it>; Mon, 29 Jan 2024 09:03:05 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id BA72E1401642
 for <ltp@lists.linux.it>; Mon, 29 Jan 2024 09:03:04 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9913C2207E;
 Mon, 29 Jan 2024 08:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706515381;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3GvRkti6uaGj+3BHMuOIBJ/r8NXagM8fIesGa3giYho=;
 b=hyxveYgiGMy/hcFDgk2mmxQwp23ciQ2O0zkTtn/uoLRqJ+RQXmHvQQpYt8mlG462AYUqPQ
 baJ22vts54FgF+pkeBgCd+N9/1SwO1XbuVxilD7KAmr9FJoAhgGAfwUPHoQlD53S75J8/1
 oWxTMNKnGgyA8DcNn4eRau+LImGpWhg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706515381;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3GvRkti6uaGj+3BHMuOIBJ/r8NXagM8fIesGa3giYho=;
 b=31E7NoDjydJBWk5tVbK+mxwYgRUXLP7ePwyYWQH92s9B0SNF6SmtX5qp06SeUuugYrPmvh
 3rrsL9NrZ2QptbAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706515381;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3GvRkti6uaGj+3BHMuOIBJ/r8NXagM8fIesGa3giYho=;
 b=hyxveYgiGMy/hcFDgk2mmxQwp23ciQ2O0zkTtn/uoLRqJ+RQXmHvQQpYt8mlG462AYUqPQ
 baJ22vts54FgF+pkeBgCd+N9/1SwO1XbuVxilD7KAmr9FJoAhgGAfwUPHoQlD53S75J8/1
 oWxTMNKnGgyA8DcNn4eRau+LImGpWhg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706515381;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3GvRkti6uaGj+3BHMuOIBJ/r8NXagM8fIesGa3giYho=;
 b=31E7NoDjydJBWk5tVbK+mxwYgRUXLP7ePwyYWQH92s9B0SNF6SmtX5qp06SeUuugYrPmvh
 3rrsL9NrZ2QptbAw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 7EE0D132FA;
 Mon, 29 Jan 2024 08:03:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id QOvIHbVbt2WHLwAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Mon, 29 Jan 2024 08:03:01 +0000
Date: Mon, 29 Jan 2024 09:03:00 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240129080300.GA584389@pevik>
References: <20240128024838.2699248-1-liwang@redhat.com>
 <20240128024838.2699248-8-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240128024838.2699248-8-liwang@redhat.com>
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=hyxveYgi;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=31E7NoDj
X-Spamd-Result: default: False [-4.01 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[]; DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:98:from];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 9913C2207E
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 7/8] swapon/off: enable all_filesystem in swap
 test
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

Hi Li,

> +++ b/testcases/kernel/syscalls/swapoff/swapoff02.c
> @@ -18,6 +18,8 @@
>  #include "lapi/syscalls.h"
>  #include "libswap.h"

> +#define MNTPOINT	"mntpoint"
> +
>  static int setup01(void);
>  static void cleanup01(void);

> @@ -84,14 +86,13 @@ static void setup(void)

>  	is_swap_supported("./tstswap");
This needs to be run on MNTPOINT, see swapon01.c (change from second commit I
made: "swapon01: Test on all filesystems").

The same problem is in other tests. Otherwise we check always on TMPDIR
(which TCONF when /tmp is tmpfs).

Kind regards,
Petr

# ./swapoff02
tst_device.c:96: TINFO: Found free device 0 '/dev/loop0'
tst_test.c:1709: TINFO: LTP version: 20230929-307-g5485ddaaf
tst_test.c:1593: TINFO: Timeout per run is 0h 00m 30s
tst_supported_fs_types.c:97: TINFO: Kernel supports ext2
tst_supported_fs_types.c:62: TINFO: mkfs.ext2 does exist
tst_supported_fs_types.c:97: TINFO: Kernel supports ext3
tst_supported_fs_types.c:62: TINFO: mkfs.ext3 does exist
tst_supported_fs_types.c:97: TINFO: Kernel supports ext4
tst_supported_fs_types.c:62: TINFO: mkfs.ext4 does exist
tst_supported_fs_types.c:97: TINFO: Kernel supports xfs
tst_supported_fs_types.c:62: TINFO: mkfs.xfs does exist
tst_supported_fs_types.c:97: TINFO: Kernel supports btrfs
tst_supported_fs_types.c:62: TINFO: mkfs.btrfs does exist
tst_supported_fs_types.c:97: TINFO: Kernel supports bcachefs
tst_supported_fs_types.c:62: TINFO: mkfs.bcachefs does exist
tst_supported_fs_types.c:97: TINFO: Kernel supports vfat
tst_supported_fs_types.c:62: TINFO: mkfs.vfat does exist
tst_supported_fs_types.c:97: TINFO: Kernel supports exfat
tst_supported_fs_types.c:62: TINFO: mkfs.exfat does exist
tst_supported_fs_types.c:132: TINFO: FUSE does support ntfs
tst_supported_fs_types.c:62: TINFO: mkfs.ntfs does exist
tst_supported_fs_types.c:97: TINFO: Kernel supports tmpfs
tst_supported_fs_types.c:49: TINFO: mkfs is not needed for tmpfs
tst_test.c:1669: TINFO: === Testing on ext2 ===
tst_ioctl.c:21: TINFO: FIBMAP ioctl is NOT supported: EINVAL (22)
libswap.c:202: TCONF: Swapfile on tmpfs not implemented
tst_test.c:1669: TINFO: === Testing on ext3 ===
tst_ioctl.c:21: TINFO: FIBMAP ioctl is NOT supported: EINVAL (22)
libswap.c:202: TCONF: Swapfile on tmpfs not implemented
tst_test.c:1669: TINFO: === Testing on ext4 ===
tst_ioctl.c:21: TINFO: FIBMAP ioctl is NOT supported: EINVAL (22)
libswap.c:202: TCONF: Swapfile on tmpfs not implemented
tst_test.c:1669: TINFO: === Testing on xfs ===
tst_ioctl.c:21: TINFO: FIBMAP ioctl is NOT supported: EINVAL (22)
libswap.c:202: TCONF: Swapfile on tmpfs not implemented
tst_test.c:1669: TINFO: === Testing on btrfs ===
tst_ioctl.c:21: TINFO: FIBMAP ioctl is NOT supported: EINVAL (22)
libswap.c:202: TCONF: Swapfile on tmpfs not implemented
tst_test.c:1669: TINFO: === Testing on bcachefs ===
tst_ioctl.c:21: TINFO: FIBMAP ioctl is NOT supported: EINVAL (22)
libswap.c:202: TCONF: Swapfile on tmpfs not implemented
tst_test.c:1669: TINFO: === Testing on vfat ===
tst_ioctl.c:21: TINFO: FIBMAP ioctl is NOT supported: EINVAL (22)
libswap.c:202: TCONF: Swapfile on tmpfs not implemented
tst_test.c:1669: TINFO: === Testing on exfat ===
tst_ioctl.c:21: TINFO: FIBMAP ioctl is NOT supported: EINVAL (22)
libswap.c:202: TCONF: Swapfile on tmpfs not implemented
tst_test.c:1669: TINFO: === Testing on ntfs ===
tst_ioctl.c:21: TINFO: FIBMAP ioctl is NOT supported: EINVAL (22)
libswap.c:202: TCONF: Swapfile on tmpfs not implemented
tst_test.c:1669: TINFO: === Testing on tmpfs ===
tst_ioctl.c:21: TINFO: FIBMAP ioctl is NOT supported: EINVAL (22)
libswap.c:202: TCONF: Swapfile on tmpfs not implemented

Summary:
passed   0
failed   0
broken   0
skipped  10
warnings 0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
