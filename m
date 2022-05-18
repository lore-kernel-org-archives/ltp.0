Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76DD7C433F5
	for <ltp@archiver.kernel.org>; Wed, 18 May 2022 08:51:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CC0BC3CAABD
	for <ltp@archiver.kernel.org>; Wed, 18 May 2022 10:51:04 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3D52C3C076F
 for <ltp@lists.linux.it>; Wed, 18 May 2022 10:50:55 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 95B7910009EF
 for <ltp@lists.linux.it>; Wed, 18 May 2022 10:50:54 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B11871F983;
 Wed, 18 May 2022 08:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1652863853;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=33MFFbGwDM75Pvx3WBkEupmMFRH//mP2RyusC8U5ThI=;
 b=c65xh7JwsWyNnWnwhjgArEcza0UnYDiqxDxk9QcDLJ3Xtb4zQvoKLq/kUgnzHkpsAlJqme
 A1I807kMq0bPnNE7btsUOZNpkEt97vKlYXKMR19lIceTyj+kKcc64ftQwx9elZjhSVbM0V
 od2Cdm1Wti0XR0mZSdkdgk9GyMNJAUY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1652863853;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=33MFFbGwDM75Pvx3WBkEupmMFRH//mP2RyusC8U5ThI=;
 b=shRFe6NgrTQSWz8hT/sefq6UVU3ehPb+DpOlu9y5VAKwKPoAo4IBzz81d49QyL1vpq2tM8
 78pc+iSRcmluBMCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7C88613A6D;
 Wed, 18 May 2022 08:50:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id hJLJHG2zhGKGdwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 18 May 2022 08:50:53 +0000
Date: Wed, 18 May 2022 10:50:51 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Chen Hanxiao <chenhx.fnst@fujitsu.com>
Message-ID: <YoSzazXY+BRhAPmc@pevik>
References: <20220428104642.110-1-chenhx.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220428104642.110-1-chenhx.fnst@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] syscalls/mount_setattr01: Add basic functional
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

Hi Chen, Dai,

...
> +static void setup(void)
> +{
> +	fsopen_supported_by_kernel();
> +	struct stat st = {0};
> +
> +	if (stat(OT_MNTPOINT, &st) == -1)
> +		SAFE_MKDIR(OT_MNTPOINT, 0777);
> +}
> +
> +static void run(unsigned int n)
> +{
> +	struct tcase *tc = &tcases[n];
> +	struct mount_attr attr = {
> +		.attr_set = tc->mount_attrs,
> +	};
> +	struct statvfs buf;
> +
> +	TST_EXP_FD_SILENT(open_tree(AT_FDCWD, MNTPOINT, AT_EMPTY_PATH |
> +		AT_SYMLINK_NOFOLLOW | OPEN_TREE_CLOEXEC | OPEN_TREE_CLONE));
> +	if (!TST_PASS)
> +		return;
> +
> +	otfd = (int)TST_RET;
> +
> +	TST_EXP_PASS_SILENT(mount_setattr(otfd, "", AT_EMPTY_PATH, &attr, sizeof(attr)),
> +		"%s set", tc->name);
> +	if (!TST_PASS)
> +		goto out1;
> +
> +	TST_EXP_PASS_SILENT(move_mount(otfd, "", AT_FDCWD, OT_MNTPOINT, MOVE_MOUNT_F_EMPTY_PATH));
> +	if (!TST_PASS)
> +		goto out1;
> +	mount_flag = 1;
> +	SAFE_CLOSE(otfd);
> +
> +	TST_EXP_PASS_SILENT(statvfs(OT_MNTPOINT, &buf), "statvfs sucess");
> +	if (!TST_PASS)
> +		goto out2;
> +
> +	if (buf.f_flag & tc->expect_attrs)
> +		tst_res(TPASS, "%s is actually set as expected", tc->name);
> +	else
> +		tst_res(TFAIL, "%s is not actually set as expected", tc->name);
> +
> +	goto out2;
> +
> +out1:
> +	SAFE_CLOSE(otfd);
> +out2:
> +	mount_flag = 0;
> +	SAFE_UMOUNT(OT_MNTPOINT);
mount_flag needs to be checked before otherwise if it fails on:
TST_EXP_PASS_SILENT(mount_setattr(otfd, "", AT_EMPTY_PATH, &attr, sizeof(attr)),
		"%s set", tc->name);

It tries to umount() not yet mounted filesystem:

mount_setattr01.c:109: TPASS: MOUNT_ATTR_RDONLY is actually set as expected
mount_setattr01.c:109: TPASS: MOUNT_ATTR_NOSUID is actually set as expected
mount_setattr01.c:109: TPASS: MOUNT_ATTR_NODEV is actually set as expected
mount_setattr01.c:109: TPASS: MOUNT_ATTR_NOEXEC is actually set as expected
mount_setattr01.c:93: TFAIL: MOUNT_ATTR_NOSYMFOLLOW set failed: EINVAL (22)
tst_device.c:394: TWARN: umount('ot_mntpoint') failed with EINVAL
mount_setattr01.c:119: TBROK: umount(ot_mntpoint) failed: EINVAL (22)

Because we mount later than opening otfd with open_tree() but need to close otfd
before umount() we cannot depend only on labels.

Thus I suggest to have this cleanup code:

out1:
	SAFE_CLOSE(otfd);
out2:
	if (mount_flag)
		SAFE_UMOUNT(OT_MNTPOINT);

	mount_flag = 0;

If Cyril is ok with this I'd merge it before release.
(I tested it on various systems, found only this issue.)

Kind regards,
Petr

+++ testcases/kernel/syscalls/mount_setattr/mount_setattr01.c
@@ -115,8 +115,10 @@ static void run(unsigned int n)
 out1:
 	SAFE_CLOSE(otfd);
 out2:
+	if (mount_flag)
+		SAFE_UMOUNT(OT_MNTPOINT);
+
 	mount_flag = 0;
-	SAFE_UMOUNT(OT_MNTPOINT);
 }
 
 static struct tst_test test = {

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
