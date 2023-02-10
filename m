Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BECEC05027
	for <ltp@archiver.kernel.org>; Fri, 10 Feb 2023 08:22:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 321F63CC059
	for <ltp@archiver.kernel.org>; Fri, 10 Feb 2023 09:22:27 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D577F3C632B
 for <ltp@lists.linux.it>; Fri, 10 Feb 2023 09:22:15 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D63C4200240
 for <ltp@lists.linux.it>; Fri, 10 Feb 2023 09:22:14 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9641D6715B;
 Fri, 10 Feb 2023 08:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1676017332; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v+OyJPbfP2aVOEu8UK9Fr7Hi8i9KNh0/PuEKlh57bDQ=;
 b=axoKnnJ20Ript1MCG9iIbYYnvokcgqmhdlxnwKV8sv5tNx3A266Mh63RqEgOw4GHSxZfHt
 KZCP9ldoUeTQW/ZDj9qXCwqjoBdUqtv+0G/iYnpHB2FKiHzyIhUNs22KKtWIU33PVaVDDz
 4oUWEMV48yt6i/PEfvyJJLn2qglXB6o=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E03EC13588;
 Fri, 10 Feb 2023 08:22:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id IFPILLP+5WOIBwAAMHmgww
 (envelope-from <wegao@suse.com>); Fri, 10 Feb 2023 08:22:11 +0000
Date: Fri, 10 Feb 2023 03:22:08 -0500
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20230210082208.GA24174@localhost>
References: <20230129115021.25778-1-wegao@suse.com>
 <20230209131902.12260-1-wegao@suse.com> <Y+UAENJVDUSDPAay@pevik>
 <Y+UEqNtUTNaGVwXT@pevik> <Y+UItbp4v2WKZedL@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y+UItbp4v2WKZedL@yuki>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] fsconfig: New case cover CVE-2022-0185
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Feb 09, 2023 at 03:52:37PM +0100, Cyril Hrubis wrote:
> Hi!

> > Results on my machine (6.2.0-rc6)
> > 
> > tst_test.c:1634: TINFO: === Testing on ext2 ===
> > tst_test.c:1093: TINFO: Formatting /dev/loop0 with ext2 opts='' extra opts=''
> > mke2fs 1.46.5 (30-Dec-2021)
> > note ext2 is *not* using new mount API
> > fsconfig03.c:50: TPASS: fsconfig() overflow on ext2 haven't triggerred crash
> > tst_test.c:1634: TINFO: === Testing on ext3 ===
> > tst_test.c:1093: TINFO: Formatting /dev/loop0 with ext3 opts='' extra opts=''
> > mke2fs 1.46.5 (30-Dec-2021)
> > fsconfig03.c:50: TPASS: fsconfig() overflow on ext3 haven't triggerred crash
> > tst_test.c:1634: TINFO: === Testing on ext4 ===
> > tst_test.c:1093: TINFO: Formatting /dev/loop0 with ext4 opts='' extra opts=''
> > mke2fs 1.46.5 (30-Dec-2021)
> > fsconfig03.c:50: TPASS: fsconfig() overflow on ext4 haven't triggerred crash
> > tst_test.c:1634: TINFO: === Testing on xfs ===
> > tst_test.c:1093: TINFO: Formatting /dev/loop0 with xfs opts='' extra opts=''
> > fsconfig03.c:50: TPASS: fsconfig() overflow on xfs haven't triggerred crash
> > tst_test.c:1634: TINFO: === Testing on btrfs ===
> > tst_test.c:1093: TINFO: Formatting /dev/loop0 with btrfs opts='' extra opts=''
> > fsconfig03.c:44: TFAIL: fsconfig(fd, FSCONFIG_SET_STRING, "\x00", val, 0) succeeded
> > Btrfs should be investigated (IMHO btrfs is using new mount API).
> > 
> > tst_test.c:1634: TINFO: === Testing on vfat ===
> > tst_test.c:1093: TINFO: Formatting /dev/loop0 with vfat opts='' extra opts=''
> > fsconfig03.c:44: TFAIL: fsconfig(fd, FSCONFIG_SET_STRING, "\x00", val, 0) succeeded
> > 
> > tst_test.c:1634: TINFO: === Testing on exfat ===
> > tst_test.c:1093: TINFO: Formatting /dev/loop0 with exfat opts='' extra opts=''
> > fsconfig03.c:50: TPASS: fsconfig() overflow on exfat haven't triggerred crash
> > Interesting, exfat works :) It also uses new mount API.
> > 
> > tst_test.c:1634: TINFO: === Testing on ntfs ===
> > tst_test.c:1093: TINFO: Formatting /dev/loop0 with ntfs opts='' extra opts=''
> > The partition start sector was not specified for /dev/loop0 and it could not be obtained automatically.  It has been set to 0.
> > The number of sectors per track was not specified for /dev/loop0 and it could not be obtained automatically.  It has been set to 0.
> > The number of heads was not specified for /dev/loop0 and it could not be obtained automatically.  It has been set to 0.
> > To boot from a device, Windows needs the 'partition start sector', the 'sectors per track' and the 'number of heads' to be set.
> > Windows will not be able to boot from this device.
> > fsconfig03.c:29: TBROK: fsopen() failed: ENODEV (19)
> > Hm, that's strange
> 
> ENODEV means that filesystem is not compiled in kernel, that's strage,
> that would mean that you have a broken system, e.g. kernel modules that
> support these filesystems are not installed properly or something like
> that.
> 
> If you look at fs/filesystems.c the get_fs_type() function called from
> the fsopen() uses the very same array that is used by the
> /proc/filesystems we parse in LTP to get list of supported filesystems.
> 
> This is the place where you can get ENODEV:
> 
> https://elixir.bootlin.com/linux/latest/source/fs/fsopen.c#L132
> 
> And this is the place where it can fail:
> 
> https://elixir.bootlin.com/linux/latest/source/fs/filesystems.c#L261
> 
> > Due above, I suggest this:
> > 	.skip_filesystems = (const char *const []){"ntfs", "vfat", NULL},
> 

Result in my machine 6.0.0-rc5, the ntfs check no failed with ENODEV but show succeeded when do fsconfig.
I will do further check on btrfs why it show success, will notify you once i got result.


tst_test.c:1634: TINFO: === Testing on ext2 ===
tst_test.c:1093: TINFO: Formatting /dev/loop0 with ext2 opts='' extra opts=''
mke2fs 1.46.6 (1-Feb-2023)
fsconfig03.c:50: TPASS: fsconfig() overflow on ext2 haven't triggerred crash
tst_test.c:1634: TINFO: === Testing on ext3 ===
tst_test.c:1093: TINFO: Formatting /dev/loop0 with ext3 opts='' extra opts=''
mke2fs 1.46.6 (1-Feb-2023)
fsconfig03.c:50: TPASS: fsconfig() overflow on ext3 haven't triggerred crash
tst_test.c:1634: TINFO: === Testing on ext4 ===
tst_test.c:1093: TINFO: Formatting /dev/loop0 with ext4 opts='' extra opts=''
mke2fs 1.46.6 (1-Feb-2023)
fsconfig03.c:50: TPASS: fsconfig() overflow on ext4 haven't triggerred crash
tst_test.c:1634: TINFO: === Testing on btrfs ===
tst_test.c:1093: TINFO: Formatting /dev/loop0 with btrfs opts='' extra opts=''
fsconfig03.c:44: TFAIL: fsconfig(fd, FSCONFIG_SET_STRING, "\x00", val, 0) succeeded
tst_test.c:1634: TINFO: === Testing on vfat ===
tst_test.c:1093: TINFO: Formatting /dev/loop0 with vfat opts='' extra opts=''
fsconfig03.c:44: TFAIL: fsconfig(fd, FSCONFIG_SET_STRING, "\x00", val, 0) succeeded
tst_test.c:1634: TINFO: === Testing on ntfs ===
tst_test.c:1093: TINFO: Formatting /dev/loop0 with ntfs opts='' extra opts=''
Failed to set locale, using default 'C'.
The partition start sector was not specified for /dev/loop0 and it could not be obtained automatically.  It has been set to 0.
The number of sectors per track was not specified for /dev/loop0 and it could not be obtained automatically.  It has been set to 0.
The number of heads was not specified for /dev/loop0 and it could not be obtained automatically.  It has been set to 0.
To boot from a device, Windows needs the 'partition start sector', the 'sectors per track' and the 'number of heads' to be set.
Windows will not be able to boot from this device.
fsconfig03.c:44: TFAIL: fsconfig(fd, FSCONFIG_SET_STRING, "\x00", val, 0) succeeded
tst_test.c:1634: TINFO: === Testing on tmpfs ===
tst_test.c:1093: TINFO: Skipping mkfs for TMPFS filesystem

> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
