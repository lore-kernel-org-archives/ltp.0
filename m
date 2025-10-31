Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FF90CCF9FF
	for <ltp@archiver.kernel.org>; Fri, 31 Oct 2025 09:14:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C4FDC3CC8F1
	for <ltp@archiver.kernel.org>; Fri, 31 Oct 2025 10:14:19 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 39FA83CA9AF
 for <ltp@lists.linux.it>; Fri, 31 Oct 2025 10:14:02 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8C448600D52
 for <ltp@lists.linux.it>; Fri, 31 Oct 2025 10:14:01 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4389A227ED;
 Fri, 31 Oct 2025 09:14:00 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2D56713393;
 Fri, 31 Oct 2025 09:14:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id fokICth9BGmoTAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 31 Oct 2025 09:14:00 +0000
Date: Fri, 31 Oct 2025 10:13:58 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20251031091358.GA804220@pevik>
References: <20250529105156.2564268-1-wegao@suse.com>
 <20250924084223.20597-1-wegao@suse.com>
 <20251030201734.GC753947@pevik>
 <aQRYS25XIjU6TfNY@autotest-wegao.qe.prg2.suse.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aQRYS25XIjU6TfNY@autotest-wegao.qe.prg2.suse.org>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 4389A227ED
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] tst_filesystems01.c: Add test for .filesystems
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

...
> > Alpine: e2fsprogs-extra
> > Debian, openSUSE, Fedora (hopefully): e2fsprogs
> when i add following diff another CI error triggered on alpine, it
> seems /dev/not mounted.
> further check.

> diff --git a/ci/alpine.sh b/ci/alpine.sh
> index f3a1bf528..254f4aaec 100755
> --- a/ci/alpine.sh
> +++ b/ci/alpine.sh
> @@ -25,7 +25,6 @@ apk add \
>         musl-dev \
>         numactl-dev \
>         openssl-dev \
> -       e2fsprogs-extra \
>         pkgconfig

> https://github.com/coolgw/ltp/actions/runs/18960845023/job/54148138737

> 2025-10-31T02:50:14.5257746Z runtest TINFO: * shell/tst_format_device.sh
> 2025-10-31T02:50:14.5260052Z tst_format_device 1 TINFO: Running: tst_format_device.sh
> 2025-10-31T02:50:14.5268691Z tst_format_device 1 TINFO: Tested kernel: Linux 0ba9f024d6b7 6.11.0-1018-azure #18~24.04.1-Ubuntu SMP Sat Jun 28 04:46:03 UTC 2025 x86_64 Linux
> 2025-10-31T02:50:14.5329045Z tst_format_device 1 TINFO: Using /tmp/LTP_tst_format_device.XXXXOajpgN as tmpdir (UNKNOWN filesystem)
> 2025-10-31T02:50:14.5352954Z tst_device.c:98: TINFO: Found free device 0 '/dev/loop0'
> 2025-10-31T02:50:14.5491591Z tst_format_device 1 TINFO: Formatting ext2 with opts='-b 1024 /dev/loop0 5m'
> 2025-10-31T02:50:14.5555250Z tst_format_device 1 TINFO: timeout per run is 0h 5m 0s
> 2025-10-31T02:50:14.5571366Z tst_format_device 1 TPASS: device formatted
> 2025-10-31T02:50:14.5594507Z df: /dev/loop0: can't find mount point  <<
> 2025-10-31T02:50:14.5598211Z tst_format_device 2 TFAIL: df /dev/loop0 | grep -q /dev failed unexpectedly
> 2025-10-31T02:50:14.6127085Z tst_format_device 3 TINFO: AppArmor enabled, this may affect test results
> 2025-10-31T02:50:14.6128036Z tst_format_device 3 TINFO: it can be disabled with TST_DISABLE_APPARMOR=1 (requires super/root)
> 2025-10-31T02:50:14.6128824Z tst_format_device 3 TINFO: loaded AppArmor profiles: none

Strange, because previous shell/tst_mount_device.sh works:
runtest TINFO: * shell/tst_mount_device.sh
tst_mount_device 1 TINFO: Running: tst_mount_device.sh
tst_mount_device 1 TINFO: Tested kernel: Linux 0ba9f024d6b7 6.11.0-1018-azure #18~24.04.1-Ubuntu SMP Sat Jun 28 04:46:03 UTC 2025 x86_64 Linux
tst_mount_device 1 TINFO: Using /tmp/LTP_tst_mount_device.XXXXmbKhac as tmpdir (UNKNOWN filesystem)
tst_device.c:98: TINFO: Found free device 0 '/dev/loop0'
tst_mount_device 1 TINFO: Formatting ext4 with opts='/dev/loop0'
tst_mount_device 1 TINFO: Mounting device: mount -t ext4 /dev/loop0 /tmp/LTP_tst_mount_device.XXXXmbKhac/mntpoint
tst_mount_device 1 TINFO: timeout per run is 0h 5m 0s
tst_mount_device 1 TPASS: cd /tmp/LTP_tst_mount_device.XXXXmbKhac/mntpoint passed as expected

Kind regards,
Petr

> > Kind regards,
> > Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
