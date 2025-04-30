Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B35D5C369D9
	for <ltp@archiver.kernel.org>; Wed, 30 Apr 2025 11:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1746014334; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=H4Cq7mxdo97OAuPzkYCO/KP0Ks0O6BX0Pc29yXLrzm8=;
 b=BecOwrdCO9f6ISQhqzn077pBgLnkguz5FkQnMfPXLnPf7TliOORptznIVDG4UQ+EbbsDT
 Ev0rzq9mL3vT9oLavH6jKnAyu0o3kd9hIOSDGCcI8MUQ1hRv9xZS4huHB2wyotTV7bZbtKq
 jRtz2dV7lAY6+rLj3v2j8WXw5OeHz14=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BEABF3CAAF4
	for <ltp@archiver.kernel.org>; Wed, 30 Apr 2025 13:58:54 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 84CDD3C318F
 for <ltp@lists.linux.it>; Wed, 30 Apr 2025 13:58:33 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 3C3891400BDA
 for <ltp@lists.linux.it>; Wed, 30 Apr 2025 13:58:32 +0200 (CEST)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-39ac8e7688aso5227603f8f.2
 for <ltp@lists.linux.it>; Wed, 30 Apr 2025 04:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1746014311; x=1746619111; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iIjoZMtXg1+dAX4pxvOqqlkcNNx4ONRWGVmNrk24/RM=;
 b=E+abaIMwjL6oVydRvLF8znLNVQIGSwte780EDRLrzjI4uk4dFcNyiC8Lf/xTwYX/ZM
 Bghx4aJ6cH0m7c7Ro4mn0A4aNlxUgK4+NsIsBn+zNFY/JYUbwtYJcio8Dt6fs7yOctJR
 AEddlgfu1MK2EGPGC2S4Nj3QO5Nuqt33myaUhwQcbgKRvTTI0JhtJfA0q4j/5+fCx2Bb
 c8R/cgrxdV7lCdwCQXNKPSfTJ2uwRSv9WsA4VAuEdX0xTrP6lJym/MwGL8JUnZEFLprd
 VS7/5Kap8pJBUAxr7AXdFqfZACHR8AOV4ra8fZlqrvE3kid8r0Qo7S6QSv+y6yld2ku0
 eNww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746014311; x=1746619111;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iIjoZMtXg1+dAX4pxvOqqlkcNNx4ONRWGVmNrk24/RM=;
 b=F85gT1OVhAHcpMP2XSkjXj8Gpcr7isTMOryMVJGDP9ErvK1ItH0iiGBMUs+2fV3RDc
 mtbLjnnwaaiBKSdrFS59OYMCjRCJWVPqVpQACtkptUYgLqp/5MCibZTLuQCZVX1EONfX
 f/bmB5ty/jiv39oNMjfOT0bN0y1DFidUziR5N991UDgbSZfIt2QPgJ8FUC9n2Ffc03Jn
 FSlI9UtxqkcbMZGA2WhwoebR0GIPo40RldStz69bLAqxlWKK5e52kwutubvUFg3cmKer
 FqnGKc0nbtg//QQmllEqbdODKLzribF8YUvu935mp18DFjv5SP3CH8AELShXe5ksOSbI
 2Tsw==
X-Gm-Message-State: AOJu0YxFnZd08Iv3gNdxm1mUpmARZEgxBTcVv3ib6rh/a1h7bepO2O5U
 F6K0dqMZzkabrG4NQYbwc6aONxvNwlpZnH0w3lkT9Babi0sk9z+lhCS8mZSOZA==
X-Gm-Gg: ASbGncvMvDq/+Z06VPB63UaHvuYo+ulOdsQsY3Zx906BMvUqQUkoIgkjUNuRDfi9B/4
 9EJVCcI18ndAC+kWa/cS3gEI3DEBGNO0Y7vEYKPdvxuJZFE0XKCU4FvnIzKE1phmT+vWkD9qE3j
 cEqaRUUHBOeC63PbwaJyetTCvqChbjCAgUgfdNgndT9YTK1v5lKJkONxRIUcTsMOt5XlapRoDQo
 mUMc0sZJyCCizKFkDH2rczUdG9XX1s8VDONF2r3dVNNhmgH5RXLBto5wSojt9W82B2J/Sd1SggB
 PRJiaopq03effoh5GBEd12bT6JrD/BoH8eqMiia2
X-Google-Smtp-Source: AGHT+IEt16MgM3Ft7IF8OH7R+Uadcw/nblnNVGe9CliFVNDa3piqTL+3XPgkk4GnW7NRDzTNAsi9+Q==
X-Received: by 2002:a05:6000:178f:b0:3a0:8033:1e3a with SMTP id
 ffacd0b85a97d-3a08f754a7bmr2760032f8f.2.1746014311525; 
 Wed, 30 Apr 2025 04:58:31 -0700 (PDT)
Received: from MiWiFi-CR6608-srv ([202.127.77.110])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74039a94d4dsm1467537b3a.173.2025.04.30.04.58.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 04:58:30 -0700 (PDT)
Date: Wed, 30 Apr 2025 19:58:18 -0400
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <aBK5Gq73M5CL0e6J@MiWiFi-CR6608-srv>
References: <20250430192207.1089900-1-wegao@suse.com>
 <ebf36f89-da22-4c1c-a9df-116bafc39b57@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ebf36f89-da22-4c1c-a9df-116bafc39b57@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] fsconfig04.c: Use FSCONFIG_SET_FD set overlayfs
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

On Wed, Apr 30, 2025 at 10:28:02AM +0200, Andrea Cervesato wrote:
> Hi!
> 
> We miss a description for the commit.
> 
> On 4/30/25 21:22, Wei Gao via ltp wrote:
> > Signed-off-by: Wei Gao <wegao@suse.com>
> > ---
> >   runtest/syscalls                              |   1 +
> >   testcases/kernel/syscalls/fsconfig/.gitignore |   1 +
> >   .../kernel/syscalls/fsconfig/fsconfig04.c     | 132 ++++++++++++++++++
> >   3 files changed, 134 insertions(+)
> >   create mode 100644 testcases/kernel/syscalls/fsconfig/fsconfig04.c
> > 
> > diff --git a/runtest/syscalls b/runtest/syscalls
> > index e369536ea..658ab24c4 100644
> > --- a/runtest/syscalls
> > +++ b/runtest/syscalls
> > @@ -410,6 +410,7 @@ fremovexattr02 fremovexattr02
> >   fsconfig01 fsconfig01
> >   fsconfig02 fsconfig02
> >   fsconfig03 fsconfig03
> > +fsconfig04 fsconfig04
> >   fsmount01 fsmount01
> >   fsmount02 fsmount02
> > diff --git a/testcases/kernel/syscalls/fsconfig/.gitignore b/testcases/kernel/syscalls/fsconfig/.gitignore
> > index cfedae5f7..bd3754c34 100644
> > --- a/testcases/kernel/syscalls/fsconfig/.gitignore
> > +++ b/testcases/kernel/syscalls/fsconfig/.gitignore
> > @@ -1,3 +1,4 @@
> >   /fsconfig01
> >   /fsconfig02
> >   /fsconfig03
> > +/fsconfig04
> > diff --git a/testcases/kernel/syscalls/fsconfig/fsconfig04.c b/testcases/kernel/syscalls/fsconfig/fsconfig04.c
> > new file mode 100644
> > index 000000000..c77dc9e3a
> > --- /dev/null
> > +++ b/testcases/kernel/syscalls/fsconfig/fsconfig04.c
> > @@ -0,0 +1,132 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (c) 2025 Wei Gao <wegao@suse.com>
> > + *
> > + * Basic fsconfig() test include use FSCONFIG_SET_FD set overlayfs
> The description doesn't explain what test is doing. Also, we are not testing
> only overlayfs inside it due to .all_filesystems=1, so I'm a bit confused.
> > + * Refer to selftests/filesystems/overlayfs/set_layers_via_fds.c
> I checked the selftests but I don't see a 1:1 with our test. Is this a port?
> If it's not we probably don't need this comment.
The main logic is refer to TEST_F(set_layers_via_fds, set_override_creds) in kernel selftest.
> > + */
> > +
> > +#include "tst_test.h"
> > +#include "lapi/fsmount.h"
> > +#include "tst_safe_file_at.h"
> > +#include "tst_safe_stdio.h"
> > +
> > +#define MNTPOINT	"mntpoint"
> > +#define OVERLAYMNT	"set_layers_via_fds"
> > +
> > +static int fd, fd_context, fd_overlay;
> They are not initialized to -1, so we are going to fail SAFE_CLOSE inside
> cleanup function.
> Also it's better to define variables on multiple lines.
> > +
> > +static void cleanup(void)
> > +{
> > +	if (fd != -1)
> > +		SAFE_CLOSE(fd);
> > +
> > +	if (fd_context != -1)
> > +		SAFE_CLOSE(fd_context);
> > +
> > +	if (fd_overlay != -1)
> > +		SAFE_CLOSE(fd_overlay);
> > +}
> > +
> > +static void run(void)
> > +{
> > +	int fsmfd;
> > +
> > +	fd = TST_EXP_FD(fsopen(tst_device->fs_type, 0));
> > +
> > +	TST_EXP_PASS(fsconfig(fd, FSCONFIG_SET_STRING, "source", tst_device->dev, 0));
> This should be tested separately.
> > +
> > +	TST_EXP_PASS(fsconfig(fd, FSCONFIG_CMD_CREATE, NULL, NULL, 0));
> Also this.
> > +
> > +	fsmfd = TST_EXP_FD(fsmount(fd, 0, 0));
> > +
> > +	TST_EXP_PASS(mkdirat(fsmfd, "w", 0755));
> > +	TST_EXP_PASS(mkdirat(fsmfd, "u", 0755));
> > +	TST_EXP_PASS(mkdirat(fsmfd, "l1", 0755));
> > +	TST_EXP_PASS(mkdirat(fsmfd, "l2", 0755));
> > +
> > +	int layer_fds[] = { [0 ... 3] = -EBADF };
> > +
> > +	layer_fds[0] = SAFE_OPENAT(fsmfd, "w", O_DIRECTORY);
> > +	layer_fds[1] = SAFE_OPENAT(fsmfd, "u", O_DIRECTORY);
> > +	layer_fds[2] = SAFE_OPENAT(fsmfd, "l1", O_DIRECTORY);
> > +	layer_fds[3] = SAFE_OPENAT(fsmfd, "l2", O_DIRECTORY);
> > +
> > +	TST_EXP_PASS(move_mount(fsmfd, "", AT_FDCWD, MNTPOINT,
> > +			MOVE_MOUNT_F_EMPTY_PATH));
> > +
> > +	SAFE_CLOSE(fsmfd);
> This is one test case.
> > +
> > +	fd_context = TST_EXP_FD(fsopen("overlay", 0));
> > +
> > +	TST_EXP_PASS(fsconfig(fd_context, FSCONFIG_SET_FD, "workdir", NULL, layer_fds[0]));
> > +	TST_EXP_PASS(fsconfig(fd_context, FSCONFIG_SET_FD, "upperdir", NULL, layer_fds[1]));
> > +	TST_EXP_PASS(fsconfig(fd_context, FSCONFIG_SET_FD, "lowerdir+", NULL, layer_fds[2]));
> > +	TST_EXP_PASS(fsconfig(fd_context, FSCONFIG_SET_FD, "lowerdir+", NULL, layer_fds[3]));
> > +
> > +	TST_EXP_PASS(fsconfig(fd_context, FSCONFIG_CMD_CREATE, NULL, NULL, 0));
> > +
> > +	SAFE_MKDIR(OVERLAYMNT, 0555);
> > +
> > +	fd_overlay = TST_EXP_FD(fsmount(fd_context, 0, 0));
> > +	SAFE_CLOSE(fd_context);
> > +
> > +	TST_EXP_PASS(move_mount(fd_overlay, "", AT_FDCWD, OVERLAYMNT,
> > +			MOVE_MOUNT_F_EMPTY_PATH));
> > +
> > +	char line[PATH_MAX];
> > +	FILE *file;
> > +	int ret = 0;
> > +	char workdir[PATH_MAX], upperdir[PATH_MAX], lowerdir1[PATH_MAX], lowerdir2[PATH_MAX];
> > +	char *tmpdir_path = tst_tmpdir_path();
> > +
> > +	sprintf(workdir, "workdir=%s/%s/w", tmpdir_path, MNTPOINT);
> > +	sprintf(upperdir, "upperdir=%s/%s/u", tmpdir_path, MNTPOINT);
> > +	sprintf(lowerdir1, "lowerdir+=%s/%s/l1", tmpdir_path, MNTPOINT);
> > +	sprintf(lowerdir2, "lowerdir+=%s/%s/l2", tmpdir_path, MNTPOINT);
> > +
> > +	file = SAFE_FOPEN("/proc/mounts", "r");
> > +	while (fgets(line, sizeof(line), file)) {
> > +		if (strstr(line, workdir) && strstr(line, upperdir)
> > +				&& strstr(line, lowerdir1) && strstr(line, lowerdir2)) {
> > +			ret = 1;
> > +			break;
> > +		}
> > +	}
> > +
> > +	if (ret == 1)
> > +		tst_res(TPASS, "overlay mount check pass");
> > +	else
> > +		tst_res(TFAIL, "overlay mount check failed");
> > +
> > +	TST_EXP_PASS_SILENT(system("ls -l"));
> > +
> This is not needed.
> > +	char rmcmd[PATH_MAX];
> > +
> > +	sprintf(rmcmd, "rm -r ./%s/*", MNTPOINT);
> > +	TST_EXP_PASS_SILENT(system(rmcmd));
> Why we try to remove the whole mnpoint via rm command?
When you run with -i2 without above remove action you will encounter
following error, the mkdirat report EEXIST even after close fsmfd.
Maybe contain potentail bug, so i put this workaround here.

tst_test.c:1831: TINFO: === Testing on ext2 ===
tst_test.c:1170: TINFO: Formatting /dev/loop2 with ext2 opts='' extra opts=''
mke2fs 1.47.2 (1-Jan-2025)
fsconfig04.c:35: TPASS: fsopen(tst_device->fs_type, 0) returned fd 3
fsconfig04.c:37: TPASS: fsconfig(fd, FSCONFIG_SET_STRING, "source", tst_device->dev, 0) passed
fsconfig04.c:39: TPASS: fsconfig(fd, FSCONFIG_CMD_CREATE, NULL, NULL, 0) passed
fsconfig04.c:41: TPASS: fsmount(fd, 0, 0) returned fd 4
fsconfig04.c:43: TPASS: mkdirat(fsmfd, "w", 0755) passed
fsconfig04.c:44: TPASS: mkdirat(fsmfd, "u", 0755) passed
fsconfig04.c:45: TPASS: mkdirat(fsmfd, "l1", 0755) passed
fsconfig04.c:46: TPASS: mkdirat(fsmfd, "l2", 0755) passed
fsconfig04.c:55: TPASS: move_mount(fsmfd, "", AT_FDCWD, MNTPOINT, MOVE_MOUNT_F_EMPTY_PATH) passed
fsconfig04.c:60: TPASS: fsopen("overlay", 0) returned fd 4
fsconfig04.c:62: TPASS: fsconfig(fd_context, FSCONFIG_SET_FD, "workdir", NULL, layer_fds[0]) passed
fsconfig04.c:63: TPASS: fsconfig(fd_context, FSCONFIG_SET_FD, "upperdir", NULL, layer_fds[1]) passed
fsconfig04.c:64: TPASS: fsconfig(fd_context, FSCONFIG_SET_FD, "lowerdir+", NULL, layer_fds[2]) passed
fsconfig04.c:65: TPASS: fsconfig(fd_context, FSCONFIG_SET_FD, "lowerdir+", NULL, layer_fds[3]) passed
fsconfig04.c:67: TPASS: fsconfig(fd_context, FSCONFIG_CMD_CREATE, NULL, NULL, 0) passed
fsconfig04.c:71: TPASS: fsmount(fd_context, 0, 0) returned fd 9
fsconfig04.c:74: TPASS: move_mount(fd_overlay, "", AT_FDCWD, OVERLAYMNT, MOVE_MOUNT_F_EMPTY_PATH) passed
tst_buffers.c:57: TINFO: Test is using guarded buffers
fsconfig04.c:98: TPASS: overlay mount check pass
total 19794
drwxr-xr-x 7 root root      1024 Apr 30 19:43 mntpoint
drwxr-xr-x 1 root root      1024 Apr 30 19:43 set_layers_via_fds
-rw------- 1 root root 314572800 Apr 30 19:43 test_dev.img
fsconfig04.c:110: TINFO: Umounting /tmp/LTP_fscv0Sg2g/set_layers_via_fds
fsconfig04.c:119: TINFO: Umounting /tmp/LTP_fscv0Sg2g/mntpoint
fsconfig04.c:35: TPASS: fsopen(tst_device->fs_type, 0) returned fd 3
fsconfig04.c:37: TPASS: fsconfig(fd, FSCONFIG_SET_STRING, "source", tst_device->dev, 0) passed
fsconfig04.c:39: TPASS: fsconfig(fd, FSCONFIG_CMD_CREATE, NULL, NULL, 0) passed
fsconfig04.c:41: TPASS: fsmount(fd, 0, 0) returned fd 5
fsconfig04.c:43: TFAIL: mkdirat(fsmfd, "w", 0755) failed: EEXIST (17)
fsconfig04.c:44: TFAIL: mkdirat(fsmfd, "u", 0755) failed: EEXIST (17)
fsconfig04.c:45: TFAIL: mkdirat(fsmfd, "l1", 0755) failed: EEXIST (17)
fsconfig04.c:46: TFAIL: mkdirat(fsmfd, "l2", 0755) failed: EEXIST (17)
fsconfig04.c:55: TPASS: move_mount(fsmfd, "", AT_FDCWD, MNTPOINT, MOVE_MOUNT_F_EMPTY_PATH) passed
fsconfig04.c:60: TPASS: fsopen("overlay", 0) returned fd 5
fsconfig04.c:62: TPASS: fsconfig(fd_context, FSCONFIG_SET_FD, "workdir", NULL, layer_fds[0]) passed
fsconfig04.c:63: TPASS: fsconfig(fd_context, FSCONFIG_SET_FD, "upperdir", NULL, layer_fds[1]) passed
fsconfig04.c:64: TPASS: fsconfig(fd_context, FSCONFIG_SET_FD, "lowerdir+", NULL, layer_fds[2]) passed
fsconfig04.c:65: TPASS: fsconfig(fd_context, FSCONFIG_SET_FD, "lowerdir+", NULL, layer_fds[3]) passed
fsconfig04.c:67: TPASS: fsconfig(fd_context, FSCONFIG_CMD_CREATE, NULL, NULL, 0) passed
fsconfig04.c:71: TPASS: fsmount(fd_context, 0, 0) returned fd 10
fsconfig04.c:74: TPASS: move_mount(fd_overlay, "", AT_FDCWD, OVERLAYMNT, MOVE_MOUNT_F_EMPTY_PATH) passed
fsconfig04.c:98: TPASS: overlay mount check pass
total 19794



> > +
> > +	SAFE_CLOSE(fd_overlay);
> > +	SAFE_UMOUNT(OVERLAYMNT);
> > +	SAFE_RMDIR(OVERLAYMNT);
> > +
> > +	SAFE_CLOSE(fd);
> > +
> > +	for (int i = 0; i < 4; i++)
> > +		SAFE_CLOSE(layer_fds[i]);
> > +
> > +	if (tst_is_mounted_at_tmpdir(MNTPOINT)) {
> > +		SAFE_UMOUNT(MNTPOINT);
> > +	}
> > +}
> > +
> > +static struct tst_test test = {
> > +	.test_all = run,
> > +	.setup = fsopen_supported_by_kernel,
> > +	.cleanup = cleanup,
> > +	.needs_root = 1,
> > +	.format_device = 1,
> > +	.mntpoint = MNTPOINT,
> > +	.all_filesystems = 1,
> > +	.skip_filesystems = (const char *const []){"ntfs", "vfat", "exfat", NULL},
> > +};
> In general I think we are not achieving the goal given by
> https://github.com/linux-test-project/ltp/issues/1169 so this patch can't be
> considered valid. There are many issues due to the mix of different flags
> usage and the broken execution of the test as well.
> 
> The idea is to test the following flags, each one separately in order to
> verify if they are correctly working:
> 
> - FSCONFIG_SET_PATH
> - FSCONFIG_SET_BINARY
> - FSCONFIG_SET_FD
> 
> All of them should be tested with a separate test in an atomic way: we open
> a new filesystem context object using fsopen(), then we set its key/keys via
> fsconfig() using one of the flags above and we verify that they affected the
> filesystem context.
Thanks for point out, since currently i have trouble to find correct API
like fs_getconfig to check the real effect, so above heavy scenario
introduced by me :) Will rethinking how to check with simple set / get
for each cmd operation.
> 
> There are also many other flags. I suggest you to take a look at
> include/uapi/linux/mount.h in case we need to cover more of them.
Will check it.
> 
> - Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
