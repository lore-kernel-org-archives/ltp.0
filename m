Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8F4AC52D7C
	for <ltp@archiver.kernel.org>; Mon, 12 Aug 2024 19:16:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9AF573D2107
	for <ltp@archiver.kernel.org>; Mon, 12 Aug 2024 21:15:58 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6FE763C132A
 for <ltp@lists.linux.it>; Mon, 12 Aug 2024 21:15:39 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8B581140026C
 for <ltp@lists.linux.it>; Mon, 12 Aug 2024 21:15:35 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B854D202CD;
 Mon, 12 Aug 2024 19:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1723490134;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MHFN9TUDAnKyEqZ59BFAP0YSiSnuQC7np9EIADWwpC4=;
 b=zNWopIB+JSD+EqhqEs1LHkcJxiOjo0Evn6r8tBvU1yjFrF4TF/I2QMhfdcFRQ+PUUj2MYC
 NB4gH8+4PUXyuNkKtDoB4jmiyaS40wKbNSUiUlZ2EGGQXH4GV4UNpRRTFC4jHOp1y8EK8G
 o0dgm4NHRYfF3GBLQ89n0FZa0Igbseo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1723490134;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MHFN9TUDAnKyEqZ59BFAP0YSiSnuQC7np9EIADWwpC4=;
 b=wki5fUaK1DqwUim/J2DQvxtmOWirNUTEYeA63qHF1X93smo7i2gXoSFHMdYR1vPDJkGGkI
 bqtJaCvKSFawz0Cg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1723490134;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MHFN9TUDAnKyEqZ59BFAP0YSiSnuQC7np9EIADWwpC4=;
 b=zNWopIB+JSD+EqhqEs1LHkcJxiOjo0Evn6r8tBvU1yjFrF4TF/I2QMhfdcFRQ+PUUj2MYC
 NB4gH8+4PUXyuNkKtDoB4jmiyaS40wKbNSUiUlZ2EGGQXH4GV4UNpRRTFC4jHOp1y8EK8G
 o0dgm4NHRYfF3GBLQ89n0FZa0Igbseo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1723490134;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MHFN9TUDAnKyEqZ59BFAP0YSiSnuQC7np9EIADWwpC4=;
 b=wki5fUaK1DqwUim/J2DQvxtmOWirNUTEYeA63qHF1X93smo7i2gXoSFHMdYR1vPDJkGGkI
 bqtJaCvKSFawz0Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3DF51137BA;
 Mon, 12 Aug 2024 19:15:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id FxKPC1VfumbuZgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 12 Aug 2024 19:15:33 +0000
Date: Mon, 12 Aug 2024 21:15:23 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20240812191523.GA399875@pevik>
References: <20240801-landlock-v5-0-663d7383b335@suse.com>
 <20240801-landlock-v5-3-663d7383b335@suse.com>
 <20240808095824.GC327665@pevik> <20240809.Ohqueicih1ou@digikod.net>
 <883b07d9-f6d0-4d6e-a85e-9028b45dc485@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <883b07d9-f6d0-4d6e-a85e-9028b45dc485@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_SEVEN(0.00)[10];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[digikod.net,suse.de,lists.linux.it,google.com,linaro.org,sony.com,lists.yoctoproject.org,intel.com,gmail.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[opensuse.org:url];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 3/6] Disable kernel version check in landlock
 tests
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
Cc: Nikolai Kondrashov <spbnick@gmail.com>,
 kernel test robot <oliver.sang@intel.com>,
 =?iso-8859-2?Q?G=FCnther?= Noack <gnoack@google.com>,
 =?iso-8859-2?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>, ltp@lists.linux.it,
 automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> Hi Meckael,

> On 8/9/24 16:36, Micka=EBl Sala=FCn wrote:
> > On Thu, Aug 08, 2024 at 11:58:24AM +0200, Petr Vorel wrote:
> > > is is really helpful when landlock support has
> > > > been backported into old kernels.
> > > Great, I'm glad you removed it from all landlock tests. It really did=
 not make
> > > sense to guard correct version with 3 guards (kernel version, kernel =
config and
> > > ABI). Could you please remove also CONFIG_SECURITY_LANDLOCK=3Dy, beca=
use you
> > > check EOPNOTSUPP in verify_landlock_is_enabled().

> > > Anyway, feel free to merge these first 3 patches (ideally remove also
> > > CONFIG_SECURITY_LANDLOCK=3Dy before merge).
> > My understanding is that LTP only tests supported features to make sure
> > they work as expected, if enabled.  Is it correct?
> Yes, landlock in particular can be a backported feature, so we need to
> remove CONFIG flags and kernel version, raising an error just in case we
> have ENOSYS.
> > I'm then wondering what is the purpose of needs_kconfigs.  If there is
> > no "needed" config, does that means that Landlock tests will always run
> > and detect at run time if tests are skipped or not?  If yes, it looks
> > good to me.

> > Andrea's commit to remove needs_kconfig:
> > https://github.com/linux-test-project/ltp/commit/e7ebc637d0d99295490adf=
57660a3b3a177d65d3

> > Is there an online dashboard to see some tested kernels?
> @Petr Vorel

I suppose folks at Linaro, Nikolai (CKI) or other companies which do public
testing have some public logs.

We have openSUSE tests on 6.10.3-1 for various archs on [1] and [2]. Here is
x86_64 [3][4] and riscv64 [5] failing on landlock06.c:38: TFAIL: ioctl(dev_=
fd,
FIOASYNC, &flag) failed: ENOTTY (25).

# landlock06; echo "### TEST landlock06 COMPLETE >>> $?."
tst_buffers.c:57: TINFO: Test is using guarded buffers
tst_tmpdir.c:316: TINFO: Using /var/tmp/LTP_lan8lXtC5 as tmpdir (btrfs file=
system)
tst_device.c:96: TINFO: Found free device 0 '/dev/loop0'
tst_test.c:1807: TINFO: LTP version: 20240524
tst_test.c:1651: TINFO: Timeout per run is 0h 00m 30s
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
tst_supported_fs_types.c:169: TINFO: Skipping vfat as requested by the test
tst_supported_fs_types.c:97: TINFO: Kernel supports exfat
tst_supported_fs_types.c:62: TINFO: mkfs.exfat does exist
tst_supported_fs_types.c:132: TINFO: FUSE does support ntfs
tst_supported_fs_types.c:62: TINFO: mkfs.ntfs does exist
tst_supported_fs_types.c:97: TINFO: Kernel supports tmpfs
tst_supported_fs_types.c:49: TINFO: mkfs is not needed for tmpfs
tst_test.c:1747: TINFO: =3D=3D=3D Testing on ext2 =3D=3D=3D
tst_test.c:1111: TINFO: Formatting /dev/loop0 with ext2 opts=3D'' extra opt=
s=3D''
mke2fs 1.47.0 (5-Feb-2023)
tst_test.c:1123: TINFO: Mounting /dev/loop0 to /var/tmp/LTP_lan8lXtC5/sandb=
ox fstyp=3Dext2 flags=3D0
landlock_common.h:31: TINFO: Landlock ABI v5
landlock06.c:55: TINFO: Applying LANDLOCK_ACCESS_FS_IOCTL_DEV
landlock06.c:34: TPASS: ioctl(file_fd, FIONREAD, &sz) passed
landlock06.c:35: TPASS: ioctl(dev_fd, FIOCLEX) passed
landlock06.c:36: TPASS: ioctl(dev_fd, FIONCLEX) passed
landlock06.c:37: TPASS: ioctl(dev_fd, FIONBIO, &flag) passed
landlock06.c:38: TFAIL: ioctl(dev_fd, FIOASYNC, &flag) failed: ENOTTY (25)
tst_test.c:1747: TINFO: =3D=3D=3D Testing on ext3 =3D=3D=3D
tst_test.c:1111: TINFO: Formatting /dev/loop0 with ext3 opts=3D'' extra opt=
s=3D''
mke2fs 1.47.0 (5-Feb-2023)
tst_test.c:1123: TINFO: Mounting /dev/loop0 to /var/tmp/LTP_lan8lXtC5/sandb=
ox fstyp=3Dext3 flags=3D0
landlock_common.h:31: TINFO: Landlock ABI v5
landlock06.c:55: TINFO: Applying LANDLOCK_ACCESS_FS_IOCTL_DEV
landlock06.c:34: TPASS: ioctl(file_fd, FIONREAD, &sz) passed
landlock06.c:35: TPASS: ioctl(dev_fd, FIOCLEX) passed
landlock06.c:36: TPASS: ioctl(dev_fd, FIONCLEX) passed
landlock06.c:37: TPASS: ioctl(dev_fd, FIONBIO, &flag) passed
landlock06.c:38: TFAIL: ioctl(dev_fd, FIOASYNC, &flag) failed: ENOTTY (25)
tst_test.c:1747: TINFO: =3D=3D=3D Testing on ext4 =3D=3D=3D
tst_test.c:1111: TINFO: Formatting /dev/loop0 with ext4 opts=3D'' extra opt=
s=3D''
mke2fs 1.47.0 (5-Feb-2023)
tst_test.c:1123: TINFO: Mounting /dev/loop0 to /var/tmp/LTP_lan8lXtC5/sandb=
ox fstyp=3Dext4 flags=3D0
landlock_common.h:31: TINFO: Landlock ABI v5
landlock06.c:55: TINFO: Applying LANDLOCK_ACCESS_FS_IOCTL_DEV
landlock06.c:34: TPASS: ioctl(file_fd, FIONREAD, &sz) passed
landlock06.c:35: TPASS: ioctl(dev_fd, FIOCLEX) passed
landlock06.c:36: TPASS: ioctl(dev_fd, FIONCLEX) passed
landlock06.c:37: TPASS: ioctl(dev_fd, FIONBIO, &flag) passed
landlock06.c:38: TFAIL: ioctl(dev_fd, FIOASYNC, &flag) failed: ENOTTY (25)
tst_test.c:1747: TINFO: =3D=3D=3D Testing on xfs =3D=3D=3D
tst_test.c:1111: TINFO: Formatting /dev/loop0 with xfs opts=3D'' extra opts=
=3D''
tst_test.c:1123: TINFO: Mounting /dev/loop0 to /var/tmp/LTP_lan8lXtC5/sandb=
ox fstyp=3Dxfs flags=3D0
landlock_common.h:31: TINFO: Landlock ABI v5
landlock06.c:55: TINFO: Applying LANDLOCK_ACCESS_FS_IOCTL_DEV
landlock06.c:34: TPASS: ioctl(file_fd, FIONREAD, &sz) passed
landlock06.c:35: TPASS: ioctl(dev_fd, FIOCLEX) passed
landlock06.c:36: TPASS: ioctl(dev_fd, FIONCLEX) passed
landlock06.c:37: TPASS: ioctl(dev_fd, FIONBIO, &flag) passed
landlock06.c:38: TFAIL: ioctl(dev_fd, FIOASYNC, &flag) failed: ENOTTY (25)
tst_test.c:1747: TINFO: =3D=3D=3D Testing on btrfs =3D=3D=3D
tst_test.c:1111: TINFO: Formatting /dev/loop0 with btrfs opts=3D'' extra op=
ts=3D''
tst_test.c:1123: TINFO: Mounting /dev/loop0 to /var/tmp/LTP_lan8lXtC5/sandb=
ox fstyp=3Dbtrfs flags=3D0
landlock_common.h:31: TINFO: Landlock ABI v5
landlock06.c:55: TINFO: Applying LANDLOCK_ACCESS_FS_IOCTL_DEV
landlock06.c:34: TPASS: ioctl(file_fd, FIONREAD, &sz) passed
landlock06.c:35: TPASS: ioctl(dev_fd, FIOCLEX) passed
landlock06.c:36: TPASS: ioctl(dev_fd, FIONCLEX) passed
landlock06.c:37: TPASS: ioctl(dev_fd, FIONBIO, &flag) passed
landlock06.c:38: TFAIL: ioctl(dev_fd, FIOASYNC, &flag) failed: ENOTTY (25)
tst_test.c:1747: TINFO: =3D=3D=3D Testing on bcachefs =3D=3D=3D
tst_test.c:1111: TINFO: Formatting /dev/loop0 with bcachefs opts=3D'' extra=
 opts=3D''
tst_test.c:1123: TINFO: Mounting /dev/loop0 to /var/tmp/LTP_lan8lXtC5/sandb=
ox fstyp=3Dbcachefs flags=3D0
landlock_common.h:31: TINFO: Landlock ABI v5
landlock06.c:55: TINFO: Applying LANDLOCK_ACCESS_FS_IOCTL_DEV
landlock06.c:34: TPASS: ioctl(file_fd, FIONREAD, &sz) passed
landlock06.c:35: TPASS: ioctl(dev_fd, FIOCLEX) passed
landlock06.c:36: TPASS: ioctl(dev_fd, FIONCLEX) passed
landlock06.c:37: TPASS: ioctl(dev_fd, FIONBIO, &flag) passed
landlock06.c:38: TFAIL: ioctl(dev_fd, FIOASYNC, &flag) failed: ENOTTY (25)
tst_test.c:1747: TINFO: =3D=3D=3D Testing on exfat =3D=3D=3D
tst_test.c:1111: TINFO: Formatting /dev/loop0 with exfat opts=3D'' extra op=
ts=3D''
tst_test.c:1123: TINFO: Mounting /dev/loop0 to /var/tmp/LTP_lan8lXtC5/sandb=
ox fstyp=3Dexfat flags=3D0
landlock_common.h:31: TINFO: Landlock ABI v5
landlock06.c:55: TINFO: Applying LANDLOCK_ACCESS_FS_IOCTL_DEV
landlock06.c:34: TPASS: ioctl(file_fd, FIONREAD, &sz) passed
landlock06.c:35: TPASS: ioctl(dev_fd, FIOCLEX) passed
landlock06.c:36: TPASS: ioctl(dev_fd, FIONCLEX) passed
landlock06.c:37: TPASS: ioctl(dev_fd, FIONBIO, &flag) passed
landlock06.c:38: TFAIL: ioctl(dev_fd, FIOASYNC, &flag) failed: ENOTTY (25)
tst_test.c:1747: TINFO: =3D=3D=3D Testing on ntfs =3D=3D=3D
tst_test.c:1111: TINFO: Formatting /dev/loop0 with ntfs opts=3D'' extra opt=
s=3D''
The partition start sector was not specified for /dev/loop0 and it could no=
t be obtained automatically.  It has been set to 0.
The number of sectors per track was not specified for /dev/loop0 and it cou=
ld not be obtained automatically.  It has been set to 0.
The number of heads was not specified for /dev/loop0 and it could not be ob=
tained automatically.  It has been set to 0.
To boot from a device, Windows needs the 'partition start sector', the 'sec=
tors per track' and the 'number of heads' to be set.
Windows will not be able to boot from this device.
tst_test.c:1123: TINFO: Mounting /dev/loop0 to /var/tmp/LTP_lan8lXtC5/sandb=
ox fstyp=3Dntfs flags=3D0
tst_test.c:1123: TINFO: Trying FUSE...
landlock_common.h:31: TINFO: Landlock ABI v5
landlock06.c:55: TINFO: Applying LANDLOCK_ACCESS_FS_IOCTL_DEV
landlock06.c:34: TPASS: ioctl(file_fd, FIONREAD, &sz) passed
landlock06.c:35: TPASS: ioctl(dev_fd, FIOCLEX) passed
landlock06.c:36: TPASS: ioctl(dev_fd, FIONCLEX) passed
landlock06.c:37: TPASS: ioctl(dev_fd, FIONBIO, &flag) passed
landlock06.c:38: TFAIL: ioctl(dev_fd, FIOASYNC, &flag) failed: ENOTTY (25)
tst_test.c:1747: TINFO: =3D=3D=3D Testing on tmpfs =3D=3D=3D
tst_test.c:1111: TINFO: Skipping mkfs for TMPFS filesystem
tst_test.c:1087: TINFO: Limiting tmpfs size to 32MB
tst_test.c:1123: TINFO: Mounting ltp-tmpfs to /var/tmp/LTP_lan8lXtC5/sandbo=
x fstyp=3Dtmpfs flags=3D0
landlock_common.h:31: TINFO: Landlock ABI v5
landlock06.c:55: TINFO: Applying LANDLOCK_ACCESS_FS_IOCTL_DEV
landlock06.c:34: TPASS: ioctl(file_fd, FIONREAD, &sz) passed
landlock06.c:35: TPASS: ioctl(dev_fd, FIOCLEX) passed
landlock06.c:36: TPASS: ioctl(dev_fd, FIONCLEX) passed
landlock06.c:37: TPASS: ioctl(dev_fd, FIONBIO, &flag) passed
landlock06.c:38: TFAIL: ioctl(dev_fd, FIOASYNC, &flag) failed: ENOTTY (25)

Summary:
passed   36
failed   9
broken   0
skipped  0
warnings 0
### TEST landlock06 COMPLETE >>> 1.

dmesg [6]:

OpenQA::run_ltp.pm: Starting landlock06
[ 1050.979179][T110531] loop0: detected capacity change from 0 to 614400
[ 1050.998116][T110531] /dev/zero: Can't lookup blockdev
[ 1051.004764][T110531] /dev/zero: Can't lookup blockdev
[ 1051.010525][T110531] /dev/zero: Can't lookup blockdev
[ 1051.014325][T110531] /dev/zero: Can't lookup blockdev
[ 1051.021487][T110531] bcachefs (/dev/zero): error reading superblock: err=
or opening /dev/zero: ENOTBLK
[ 1051.022857][T110531] bcachefs: bch2_mount() error: ENOTBLK
[ 1051.058671][T110531] /dev/zero: Can't lookup blockdev
[ 1051.105329][T110531] EXT4-fs (loop0): mounting ext2 file system using th=
e ext4 subsystem
[ 1051.117949][T110531] EXT4-fs (loop0): mounted filesystem 2c8afdbf-6fa5-4=
2e8-8fd4-28954bdde347 r/w without journal. Quota mode: none.
[ 1051.127872][T110531] EXT4-fs (loop0): unmounting filesystem 2c8afdbf-6fa=
5-42e8-8fd4-28954bdde347.
[ 1051.204843][T110531] EXT4-fs (loop0): mounting ext3 file system using th=
e ext4 subsystem
[ 1051.213928][T110531] EXT4-fs (loop0): mounted filesystem d61f27f7-7dce-4=
f66-ad8e-70b4a33b9222 r/w with ordered data mode. Quota mode: none.
[ 1051.218709][T110531] EXT4-fs (loop0): unmounting filesystem d61f27f7-7dc=
e-4f66-ad8e-70b4a33b9222.
[ 1051.251190][T110531] EXT4-fs (loop0): mounted filesystem b3d3c34a-d06b-4=
950-9317-facae9d51858 r/w with ordered data mode. Quota mode: none.
[ 1051.255995][T110531] EXT4-fs (loop0): unmounting filesystem b3d3c34a-d06=
b-4950-9317-facae9d51858.
[ 1051.287117][T110531] XFS (loop0): Mounting V5 Filesystem 8b3dafa3-3d09-4=
2ad-974f-a4f6b64dbc21
[ 1051.292956][T110531] XFS (loop0): Ending clean mount
[ 1051.299264][T110531] XFS (loop0): Unmounting Filesystem 8b3dafa3-3d09-42=
ad-974f-a4f6b64dbc21
[ 1051.349548][T110531] BTRFS: device fsid 773dda9f-d706-4408-9de1-6cbf1aeb=
810c devid 1 transid 8 /dev/loop0 (7:0) scanned by landlock06 (110531)
[ 1051.356250][T110531] BTRFS info (device loop0): first mount of filesyste=
m 773dda9f-d706-4408-9de1-6cbf1aeb810c
[ 1051.360300][T110531] BTRFS info (device loop0): using crc32c (crc32c-int=
el) checksum algorithm
[ 1051.361782][T110531] BTRFS info (device loop0): using free-space-tree
[ 1051.399193][T110531] BTRFS info (device loop0): checking UUID tree
[ 1051.403606][T110531] BTRFS info (device loop0): last unmount of filesyst=
em 773dda9f-d706-4408-9de1-6cbf1aeb810c
[ 1051.470051][T110531] bcachefs (loop0): mounting version 1.7: mi_btree_bi=
tmap
[ 1051.472754][T110531] bcachefs (loop0): initializing new filesystem
[ 1051.474263][T110531] bcachefs (loop0): going read-write
[ 1051.475613][T110531] bcachefs (loop0): initializing freespace
[ 1051.511331][T110531] bcachefs (loop0): shutdown complete, journal seq 7

They are not failing on aarch64 [7] and ppc64le [8].

We have 6.11.0-rc2 build, which also fails on x86_64 for the same reason [9=
].
There is also unique bcachefs related failure (which is probably not relate=
d to
landlock):

tst_cmd.c:113: TBROK: failed to exec cmd 'mkfs.bcachefs' at tst_cmd.c:113

(also landlock04 and landlock05 fails with it).

Kind regards,
Petr

[1] https://openqa.opensuse.org/group_overview/32
[2] https://openqa.opensuse.org/group_overview/125
[3] https://openqa.opensuse.org/tests/4397937#step/landlock06/6
[4] https://openqa.opensuse.org/tests/4397937/file/serial_terminal.txt
[5] https://openqa.opensuse.org/tests/4398174#step/landlock06/6
[6] https://openqa.opensuse.org/tests/4397937/file/serial0.txt
[7] https://openqa.opensuse.org/tests/4397935#step/landlock06/8
[8] https://openqa.opensuse.org/tests/4397936#step/landlock06/8
[9] https://openqa.opensuse.org/tests/4394746#step/landlock06/8

> > > Reviewed-by: Petr Vorel <pvorel@suse.cz>

> > > Kind regards,
> > > Petr

> > > -- =

> > > Mailing list info: https://lists.linux.it/listinfo/ltp
> Regards,
> Andrea

-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
