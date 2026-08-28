Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E26B6C61DCB
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 13:39:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 357413E9A6E
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 15:39:51 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9C4F93C0E10
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 15:39:33 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9AC1820007B
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 15:39:32 +0200 (CEST)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-482fc3327fdso337358f8f.2
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 06:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787924372; x=1788529172; darn=lists.linux.it;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YR1y999JbnlkcKke8NjUlz1/oaThubAGYcCrn+dsyDs=;
 b=oXLzc3JyOZFSUhBGeY/tXlYuw6hAEJN1DPg4GKf6B1Vlt8MOvHtwNq+PxjfSjrBWTw
 fixKTKFyuzHY719/U0RYKOo5Lry35+Wo3IbELeETZXw2HUcJJh4ijY8fMaCgaZ0UEzJE
 hVusHya6LZp+dVuiGpNEcJh24MZ6bu+ThLDT6kzZoOBiMi2m63t2qGePeOfXFRh62Qko
 6VxW40GIsadYxKWmyhtOyyK9CxKoYYOozh8cJZNW813u5/8Ipaz6HOth1seI7Bur5usi
 Dj9p0ILZguDYAkH5ZSBV18aT0BbIJV4uEEUe5UsaBEFIjvISKWigkdkJ7Cwf3tzGHgtA
 SStw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787924372; x=1788529172;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YR1y999JbnlkcKke8NjUlz1/oaThubAGYcCrn+dsyDs=;
 b=YFlJZn3RwBXNVvIdkxS3NMfTxd8e5GuojzPRl5I4n9zHq1RgEj7Nblip2qi/4GT2MQ
 iOQjRFBiv032ejLmAaR/mW3nqYgGeIh5+D9lJwVOVTLSZDDiRvwcSUMnA7iN5qOoubo4
 SG4BUQiHeYCVk140XlLBvcoOOqhLLAZkncIrxmZ4OXNftoKwq0DEFEi9eP7zR29iUny4
 ivsEVYjlUJxU8pgl9QwEAlWIoeECoGzC4o+w2Tqa/Q6TNuW12oEfat+fgRrIz2n0Fhdq
 oV4UMY3YLeH01VijvI6ycT87Z+a9Dlho5o8DieGeCrmWZBkfglhOsMJGUi9MW/8aXfDd
 FHyA==
X-Forwarded-Encrypted: i=1;
 AHgh+RobNnRyIYp1BvcY0QvjsjCZ34oGm9gD2GG5uWxcqEVxtl30WVCdys4Z+TsMVuSxCTunOtc=@lists.linux.it
X-Gm-Message-State: AFuF++l6SL3JW9fIDoomkDWcHCMvqNbcPU3dqfWLUYpP8dP7w0Yi5/Ak
 maBKXW4deK4piy/97hAua/3l1l6nxrv13UqvumJ6iT/6fSDjsSqO2pEn
X-Gm-Gg: AR+sD11wFgMgiw2xNQkbaB9tGoWy+RjPLLrY0lgXeJ1Bm+8rttZE2m68Kb4X0CmZb4w
 wuinZIqBJ+t1HX8jhr58Lj9CsTgeCK3sEHP146f8Bx3xJl/d8Ka0MZzZpPOOWtRmZQDpuLLpmhB
 Z1dsnI+TBilxzhYyn7EhhLkSAQgsUnsWzPYUugY881Grm2nTTvBm3eM7/SvPkGxUv/Fy3msLtna
 06bh7uCN0QlGpUqIvtok/OXjCrerDAwAF91k4voaHxn7nF9aywYg7H+LouzUN4TC0t2jC2v5diM
 qHVDw+fBIuMHvJNKiI5J96TZwS57yw1AP1EKoQ1nvA9BNAxaYG8wUMSyT1WUfFzmMSUcrremV8A
 2gprSVHhQpaVjBTeJEF5a89R3mJF+eYdNC+LUNeG1OJM6UfEZ6M0/G3I5s9m4fIctibTK3sZl4a
 HR1L65gFx3qahCP3yCr8NGpYAJsKibY4HcyD1zGP/18OHK8lq/zYk5tV6+6DK/wGozQP/Y7BAxT
 iSBTGOgjyuFKw==
X-Received: by 2002:a05:6000:4715:b0:47f:c648:e265 with SMTP id
 ffacd0b85a97d-482f79bf064mr12569612f8f.17.1787924371667; 
 Fri, 28 Aug 2026 06:39:31 -0700 (PDT)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbb2794dsm4250162f8f.25.2026.08.28.06.39.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 06:39:31 -0700 (PDT)
Date: Fri, 28 Aug 2026 15:39:30 +0200
From: Amir Goldstein <amir73il@gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <apGPksbQajf2vVJF@amir-ThinkPad-T480>
References: <20260616210448.12175-1-anonymemeow@gmail.com>
 <20260616210448.12175-3-anonymemeow@gmail.com>
 <20260825103609.GA56957@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260825103609.GA56957@pevik>
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/5] fanotify21: Stop relying on exited child
 for pidfd error
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
Cc: jack@suse.cz, ltp@lists.linux.it, AnonymeMeow <anonymemeow@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Aug 25, 2026 at 12:36:09PM +0200, Petr Vorel wrote:
> Hi all,
> 
> > fanotify21 used to verify the pidfd error case by generating an event
> > from a child process and reading the event after the child had exited.
> > This is no longer a stable way to trigger a pidfd error, because newer
> > kernels can report pidfds for exited event processes.
> 
> > Read the event from a child process in a descendant PID namespace
> > instead. The reader cannot get the pidfd in the parent PID namespace
> > from fanotify, so pidfd creation will fail and the test can verify
> > FAN_NOPIDFD, or -ESRCH with FAN_REPORT_FD_ERROR.
> 
> > Signed-off-by: AnonymeMeow <anonymemeow@gmail.com>
> > Reviewed-by: Jan Kara <jack@suse.cz>
> > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> 
> ...
> >  	/*
> > -	 * Generate the event in either self or a child process. Event
> > -	 * generation in a child process is done so that the FAN_NOPIDFD case
> > -	 * can be verified.
> > +	 * Read the event in either self or a child process in a descendant
> > +	 * PID namespace. A reader in a descendant PID namespace cannot obtain
> > +	 * the pidfd of the event process in the parent PID namespace so that
> > +	 * the FAN_NOPIDFD case can be verified.
> >  	 */
> > -	if (tc->fork)
> > -		do_fork();
> > -	else
> > -		generate_event();
> > +	if (tc->want_pidfd_err && (reader_pid = SAFE_CLONE(&clone_args))) {
> nit: although I'd write it this way as well, checkpatch does not like this
> effective way :) (do not use assignment in if condition).
> 
> > +		SAFE_WAITPID(reader_pid, &reader_exit_status, 0);
> > +		if (!WIFEXITED(reader_exit_status) || WEXITSTATUS(reader_exit_status))
> > +			tst_brk(TBROK, "reader process exited incorrectly");
> 
> nit: And the above should be probably replaced with tst_reap_children().
> 
> But because I should have merged this long time ago to prevent false positive on
> 7.2, merging it now. Cleanup can be done later (together with using designated
> initializers).
> 
> Merged the rest of the patch, thank you!
> 

Hi Petr,

Sorry I did not have time to investigate and need to leave now
just wanted to let you know that test ends with failure exit code.
and does not seem to run with pretty recent rc7 kernel.

Is that expected?
Maybe it's something in my own test env.

Thanks,
Amir.

root@kvm-xfstests:~/ltp# ./fanotify/fanotify20 || echo FAIL
tst_tmpdir.c:308: TINFO: Using /tmp/LTP_fanTTAwH1 as tmpdir (tmpfs filesystem)
tst_kconfig.c:90: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:756: TINFO: CONFIG_PROVE_LOCKING kernel option detected which might slow the execution
tst_device.c:103: TINFO:[  787.367492] loop0: detected capacity change from 0 to 614400
 Found free device 0 '/dev/loop0'
tst_test.c:2048: TINFO: LTP version: 20260529-243-g9118a480c
tst_tes[  787.391529] /dev/zero: Can't lookup blockdev
t.c:2051: TINFO: Tested kernel: 7.2.0-rc7-xfstests-00008-g55d5763db1de #2982 SMP PREEMPT_DYNAMIC Thu Aug 27 12:04:04 CEST 2026 x86_64
tst_test.c:1876: TINFO: Overall timeout per run is 0h 02m 00s
tst_supported_fs_types.c:108: TINFO: Kernel supports ext2
tst_supported_fs_types.c:67: TINFO: mkfs.ext2 does exist
[  787.418143] /dev/zero: Can't lookup blockdev
tst_supported_fs_types.c:108: TINFO: Kernel supports ext3
tst_supported_fs_types.c:67: TINFO: mkfs.ext3 does exist
[  787.443657] /dev/zero: Can't lookup blockdev
tst_supported_fs_types.c:108: TINFO: Kernel supports ext4
tst_supported_fs_types.c:67: TINFO: m[  787.467489] /dev/zero: Can't lookup blockdev
kfs.ext4 does exist
tst_supported_fs_types.c:108: TINFO: Kernel supports xfs
tst_supported_fs_types.c:67: TINFO: mkfs.xfs does exist
tst_supported_fs_types.c:108: TINFO: Kernel supports btrfs
tst_supported_fs_types.c:67: TINFO: mkfs.btrfs does exist
tst_supported_fs_types.c:117: TINFO: Skipping bcachefs because of FUSE blacklist
[  787.521515] /dev/zero: Can't lookup blockdev
tst_supported_fs_types.c:108: TINFO: Kernel supports vfat
tst_supported_fs_types.c:67: TINFO: mkfs.vfat does exist
tst_supported_fs_types.c:140: TINFO: Filesystem exfat is not supported
tst_supported_fs_types.c:144: TINFO: FUSE does support ntfs
tst_supported_fs_types.c:63: TINFO: mkfs.ntfs does not exist
[  787.576420] /dev/zero: Can't lookup blockdev
tst_supported_fs_types.c:108: TINFO: Kernel supports ntfs3
tst_supported_fs_types.c:63: TINFO: mkfs.ntfs does not exist
tst_supported_fs_types.c:108: TINFO: Kernel supports tmpfs
tst_supported_fs_types.c:51: TINFO: mkfs is not needed for tmpfs
tst_test.c:1986: TINFO: === Testing on ext2 ===
fanotify20.c:51: TCONF: FAN_REPORT_PIDFD | FAN_REPORT_TID is supported since v7.2
tst_test.c:1986: TINFO: === Testing on ext3 ===
fanotify20.c:51: TCONF: FAN_REPORT_PIDFD | FAN_REPORT_TID is supported since v7.2
tst_test.c:1986: TINFO: === Testing on ext4 ===
fanotify20.c:51: TCONF: FAN_REPORT_PIDFD | FAN_REPORT_TID is supported since v7.2
tst_test.c:1986: TINFO: === Testing on xfs ===
fanotify20.c:51: TCONF: FAN_REPORT_PIDFD | FAN_REPORT_TID is supported since v7.2
tst_test.c:1986: TINFO: === Testing on btrfs ===
fanotify20.c:51: TCONF: FAN_REPORT_PIDFD | FAN_REPORT_TID is supported since v7.2
tst_test.c:1986: TINFO: === Testing on vfat ===
fanotify20.c:51: TCONF: FAN_REPORT_PIDFD | FAN_REPORT_TID is supported since v7.2
tst_test.c:1986: TINFO: === Testing on tmpfs ===
fanotify20.c:51: TCONF: FAN_REPORT_PIDFD | FAN_REPORT_TID is supported since v7.2

Summary:
passed   0
failed   0
broken   0
skipped  7
warnings 0

FAIL


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
