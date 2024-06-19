Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27406C27C53
	for <ltp@archiver.kernel.org>; Wed, 19 Jun 2024 15:51:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3DA793D0DD6
	for <ltp@archiver.kernel.org>; Wed, 19 Jun 2024 17:50:58 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D6A953D0B3E
 for <ltp@lists.linux.it>; Wed, 19 Jun 2024 17:50:22 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6FC721A01974
 for <ltp@lists.linux.it>; Wed, 19 Jun 2024 17:50:20 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5A4351F7EC;
 Wed, 19 Jun 2024 15:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718812219;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SZKBFedPvJhPidEzutclgVZOBAZHVvlZ3/8+0xt/Huc=;
 b=rYbuSt6RBwkYfncMaHK2CoXKF85CAzJE0XVE68LoVVT56jO9VZK6ZTHGh4bblT0Zt7ycxE
 Xfz8wgRP1npm+qKwAfkJ20Ogy8byy23/G8MTx7/q4HIGdBZnBwcYiJoJc5lNcAORQi/CpL
 j3M++Y0iTuBgdAWu1q3FgepzuwOyvJE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718812219;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SZKBFedPvJhPidEzutclgVZOBAZHVvlZ3/8+0xt/Huc=;
 b=roO3+y4uuFpa0lop5Yo4NNOp5GT6JjY84HS63JZWso0YHskBXz0fhe3pgPNw/HI0mUvTv8
 SlIsxzmtHN89j1BQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=rYbuSt6R;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=roO3+y4u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718812219;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SZKBFedPvJhPidEzutclgVZOBAZHVvlZ3/8+0xt/Huc=;
 b=rYbuSt6RBwkYfncMaHK2CoXKF85CAzJE0XVE68LoVVT56jO9VZK6ZTHGh4bblT0Zt7ycxE
 Xfz8wgRP1npm+qKwAfkJ20Ogy8byy23/G8MTx7/q4HIGdBZnBwcYiJoJc5lNcAORQi/CpL
 j3M++Y0iTuBgdAWu1q3FgepzuwOyvJE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718812219;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SZKBFedPvJhPidEzutclgVZOBAZHVvlZ3/8+0xt/Huc=;
 b=roO3+y4uuFpa0lop5Yo4NNOp5GT6JjY84HS63JZWso0YHskBXz0fhe3pgPNw/HI0mUvTv8
 SlIsxzmtHN89j1BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7245B13AAA;
 Wed, 19 Jun 2024 15:50:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id JM2fGjr+cmYwKwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 19 Jun 2024 15:50:18 +0000
Date: Wed, 19 Jun 2024 17:50:13 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20240619155013.GA474490@pevik>
References: <20240605-unlink09-v2-0-bfa0bbdc8753@suse.com>
 <20240605-unlink09-v2-1-bfa0bbdc8753@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240605-unlink09-v2-1-bfa0bbdc8753@suse.com>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_BLOCKED(0.00)[rspamd.com];
 ARC_NA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:replyto,suse.cz:dkim];
 DKIM_TRACE(0.00)[suse.cz:+]; MISSING_XM_UA(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
 RCVD_VIA_SMTP_AUTH(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 5A4351F7EC
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] Fix unlink09 test
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
Cc: Sebastian Chlad <schlad@suse.de>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

> This patch will fix unlink09 test by checking for filesystems which
> are not supporting inode attributes. At the same time, it removes the
> read-only filesystem unlink() check in order to add .all_filesystems
> support.

...
> -	TST_EXP_FAIL(unlink(tc->filename), tc->expected_errno, "%s", tc->desc);
> +	TST_EXP_FAIL(unlink(tc->filename), EPERM, "%s", tc->desc);

>  	/* If unlink() succeeded unexpectedly, test file should be restored. */
>  	if (!TST_RET) {
> -		if (tc->fd) {
> -			*(tc->fd) = SAFE_OPEN(tc->filename, O_CREAT, 0600);
> -			if (tc->flag) {
> -				SAFE_IOCTL(*(tc->fd), FS_IOC_GETFLAGS, &attr);
> -				attr |= tc->flag;
> -				SAFE_IOCTL(*(tc->fd), FS_IOC_SETFLAGS, &attr);
> -			}
> -		} else {
> -			SAFE_TOUCH(tc->filename, 0600, 0);
> -		}
> +		*(tc->fd) = SAFE_CREAT(tc->filename, 0600);

FYI, when forcing NTFS, we get EINVAL, reported by Avinesh:

LTP_SINGLE_FS_TYPE=ntfs ./unlink09
tst_test.c:1120: TINFO: Mounting /dev/loop2 to /tmp/LTP_unlqPsIkB/mnt fstyp=ntfs flags=0
tst_test.c:1120: TINFO: Trying FUSE...
unlink09.c:73: TBROK: ioctl(3,((((1U) << (((0+8)+8)+14)) | ((('f')) << (0+8)) | (((2)) << 0) | ((((sizeof(long)))) << ((0+8)+8)))),...) failed: EINVAL (22)
unlink09.c:42: TWARN: ioctl(3,((((2U) << (((0+8)+8)+14)) | ((('f')) << (0+8)) | (((1)) << 0) | ((((sizeof(long)))) << ((0+8)+8)))),...) failed: EINVAL (22)
unlink09.c:49: TWARN: ioctl(3,((((1U) << (((0+8)+8)+14)) | ((('f')) << (0+8)) | (((2)) << 0) | ((((sizeof(long)))) << ((0+8)+8)))),...) failed: EINVAL (22)

I tried SAFE_OPEN with O_RDWR | O_CREAT (patch from Avinesh), but it did not help.
https://lore.kernel.org/ltp/20240603124653.31967-1-akumar@suse.de/
https://patchwork.ozlabs.org/project/ltp/patch/20240601195149.17570-1-akumar@suse.de/

It's not ENOTTY, thus it's not checked by inode attributes check.

> +		setup_inode_flag(*(tc->fd), tc->flag, 0);
>  	}
>  }

> @@ -96,7 +101,8 @@ static struct tst_test test = {
>  	.tcnt = ARRAY_SIZE(tcases),
>  	.cleanup = cleanup,
>  	.test = verify_unlink,
> -	.needs_rofs = 1,
> -	.mntpoint = DIR_EROFS,
> +	.mntpoint = MNTPOINT,
>  	.needs_root = 1,
> +	.all_filesystems = 1,
> +	.format_device = 1,

Test fails on exfat (on various kernel versions):

tst_test.c:1694: TINFO: === Testing on exfat ===
tst_test.c:1107: TINFO: Formatting /dev/loop0 with exfat opts='' extra opts=''
tst_test.c:1121: TINFO: Mounting /dev/loop0 to /tmp/LTP_unl7cHxvL/mnt fstyp=exfat flags=0
unlink09.c:69: TBROK: Inode attributes not supported by 'exfat'

i.e. different error than on ntfs, but the same as on vfat (which is also
disabled). I wonder why NTFS is different. Or is it fuse relevant?

With added exfat LGTM (I can change this before merge.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
