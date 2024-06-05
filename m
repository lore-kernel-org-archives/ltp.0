Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34F02C25B76
	for <ltp@archiver.kernel.org>; Wed,  5 Jun 2024 12:28:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A68323D0993
	for <ltp@archiver.kernel.org>; Wed,  5 Jun 2024 14:28:07 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CFE0B3D096D
 for <ltp@lists.linux.it>; Wed,  5 Jun 2024 14:27:48 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9C5DC1A0118E
 for <ltp@lists.linux.it>; Wed,  5 Jun 2024 14:27:47 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AF8F421A75;
 Wed,  5 Jun 2024 12:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1717590466;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U+XCAUrlfZy6K7PS+/kmySJFBggdCM+ZdSljKcL1oIs=;
 b=MHL9hqAVQBwejZqGqX+cSsrgufDaGuwz0F3DLBRsU+GoLhL8syUVVrns1XuRp+ZxjMRR8k
 LYQbIMa+llgd0RvMmYurgeWh6g2OdEZoM3eduFxEWDJxwiRQ6TddD30FGq6yOwn4CpvC05
 wQHQsxEXafk8tVRsor20UWsJ4jE7pVA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1717590466;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U+XCAUrlfZy6K7PS+/kmySJFBggdCM+ZdSljKcL1oIs=;
 b=mHW0Zepams4oReenJ+2ATMB02oW9UPmxpi/6qYTqAbHiuEfrZb6tN8e93mbHCbl+ZDC7Zh
 nqMttUkVvKVXhoAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1717590466;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U+XCAUrlfZy6K7PS+/kmySJFBggdCM+ZdSljKcL1oIs=;
 b=MHL9hqAVQBwejZqGqX+cSsrgufDaGuwz0F3DLBRsU+GoLhL8syUVVrns1XuRp+ZxjMRR8k
 LYQbIMa+llgd0RvMmYurgeWh6g2OdEZoM3eduFxEWDJxwiRQ6TddD30FGq6yOwn4CpvC05
 wQHQsxEXafk8tVRsor20UWsJ4jE7pVA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1717590466;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U+XCAUrlfZy6K7PS+/kmySJFBggdCM+ZdSljKcL1oIs=;
 b=mHW0Zepams4oReenJ+2ATMB02oW9UPmxpi/6qYTqAbHiuEfrZb6tN8e93mbHCbl+ZDC7Zh
 nqMttUkVvKVXhoAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8280B13A24;
 Wed,  5 Jun 2024 12:27:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +rIdHsJZYGbkCQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 05 Jun 2024 12:27:46 +0000
Date: Wed, 5 Jun 2024 14:27:41 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>,
 Andrea Cervesato <andrea.cervesato@suse.de>,
 Sebastian Chlad <schlad@suse.de>, ltp@lists.linux.it,
 Avinesh Kumar <akumar@suse.de>
Message-ID: <20240605122741.GB387399@pevik>
References: <20240604-unlink09-v1-1-dfd8e3e1cb2b@suse.com>
 <20240605065755.GB348321@pevik> <20240605073806.GA355314@pevik>
 <8aef8014-e4ea-407d-9b88-423449612665@suse.cz>
 <20240605121142.GA387399@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240605121142.GA387399@pevik>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_FIVE(0.00)[6];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Fix unlink09 test
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Martin,

> Hi Martin,

> > On 05. 06. 24 9:38, Petr Vorel wrote:
> > > BTW shouldn't this test use .all_filesystems = 1 ? Or is it unlink() really VFS
> > > only code? I see some specific functions in fs/*/, e.g. btrfs_unlink() or
> > > ext4_unlink(), which are used for struct inode_operations unlink member.
> > > Then, obviously also Andrea's check would be needed (otherwise is unlikely that
> > > somebody would have TMPDIR on vfat or exfat).

> > AFAICT, .all_filesystems and .needs_rofs are mutually exclusive at the
> > moment.

Also I wonder if having functionality for .all_filesystems + .needs_rofs
wouldn't be useful. @Cyril @Martin WDYT?

Also, there is fallback when prepare_and_mount_ro_fs() fails to use block
device. Although, I don't see the read only mount flags added in this fallback,
IMHO MS_RDONLY is only in prepare_and_mount_ro_fs(), therefore the fallback is
read write and we even didn't get TWARN, just plain TINFO (it should be either
TWARN or TINFO with "WARNING:" at least).

Kind regards,
Petr

lib/tst_test.c

static void prepare_device(void)
{
	...
	if (tst_test->needs_rofs) {
		/* If we failed to mount read-only tmpfs. Fallback to
		 * using a device with read-only filesystem.
		 */
		if (prepare_and_mount_ro_fs(NULL, tst_test->mntpoint, "tmpfs")) {
			tst_res(TINFO, "Can't mount tmpfs read-only, "
				"falling back to block device...");
			tst_test->needs_device = 1;
			tst_test->format_device = 1;
		}
	}

static int prepare_and_mount_ro_fs(const char *dev, const char *mntpoint,
				   const char *fs_type)
{
	char buf[PATH_MAX];

	if (mount(dev, mntpoint, fs_type, 0, NULL)) {
		tst_res(TINFO | TERRNO, "Can't mount %s at %s (%s)",
			dev, mntpoint, fs_type);
		return 1;
	}

	mntpoint_mounted = 1;

	snprintf(buf, sizeof(buf), "%s/dir/", mntpoint);
	SAFE_MKDIR(buf, 0777);

	snprintf(buf, sizeof(buf), "%s/file", mntpoint);
	SAFE_FILE_PRINTF(buf, "file content");
	SAFE_CHMOD(buf, 0777);

	SAFE_MOUNT(dev, mntpoint, fs_type, MS_REMOUNT | MS_RDONLY, NULL);

	return 0;
}

> Good point, I completely overlook .needs_rofs. That makes things clearer.

> ATM we have 3 other tests in syscalls/unlink. Not sure if all are filesystem
> specific (I would say yes, but not sure), but at least unlink05.c (tests
> deleting with unlink()) should be tested .all_filesystems. unlink07.c and
> unlink08.c test errno.

> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
