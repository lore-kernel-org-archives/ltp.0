Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09F8CCAC59A
	for <ltp@archiver.kernel.org>; Tue, 16 Sep 2025 11:05:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3FF3F3CDB24
	for <ltp@archiver.kernel.org>; Tue, 16 Sep 2025 13:05:08 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 148A73C1AA1
 for <ltp@lists.linux.it>; Tue, 16 Sep 2025 13:04:49 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 26FF860005F
 for <ltp@lists.linux.it>; Tue, 16 Sep 2025 13:04:48 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 02404222A4;
 Tue, 16 Sep 2025 11:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758020688; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uB3s75uIkNgs3ivEMPKxDsUxxOEwMyVjkPUAHjlB29Q=;
 b=Clk+EEY/+XyLZNpY7QrN3RIYjibUWBqNZxtXJMrDon3ieCDpqQh2JnfZKi+RKyrOU60LEG
 FP7qfvM62au2DSQ+8TmDY38UoH0sqpq5hL8XRCY+NIkmB91dtOLeohxaQuJ2gkICXzp1dD
 nnCQnXA6gr3AnOYrOomCJmGSZNiRIGo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758020688;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uB3s75uIkNgs3ivEMPKxDsUxxOEwMyVjkPUAHjlB29Q=;
 b=ytwML0GF7CjWKv4PZQYYPP8fvkQDech1EF33QYkPxi5T2wtVrgBiEgspeMXS0NG/hXFpdM
 R36MqZLTjypGkSBw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ADFGvhn8;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=xgKcjVaa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758020687; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uB3s75uIkNgs3ivEMPKxDsUxxOEwMyVjkPUAHjlB29Q=;
 b=ADFGvhn8TGyBrfikNQaf6x+czHKdB2l2gBTVPQXS6ImHtS5/3EGceVwdmS2ktyJqeoc7g2
 TT0iTTklU0jZ6mv6HZVj8bMHGSqzRqlHZFblUTVgsN39efBfKtggb9XxX2+QRjnQuv2uJT
 dNNBqDn5MDWLkytYEzLFBIoCiu1yuHI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758020687;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uB3s75uIkNgs3ivEMPKxDsUxxOEwMyVjkPUAHjlB29Q=;
 b=xgKcjVaahlY6F4xvT0zvJHVxkesQv4XnlpiukwTfXth/tfjg/hpVPAkFe35PXXcLMtKwsc
 GrgIVvYz1tcAwPAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E4C5D139CB;
 Tue, 16 Sep 2025 11:04:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id pQ+IN05EyWh3WwAAD6G6ig
 (envelope-from <jack@suse.cz>); Tue, 16 Sep 2025 11:04:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 76DECA0A56; Tue, 16 Sep 2025 13:04:42 +0200 (CEST)
Date: Tue, 16 Sep 2025 13:04:42 +0200
From: Jan Kara <jack@suse.cz>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Message-ID: <arfepejkmgi63wepbkfhl2jjbhleh5degel7i3o7htgwjsayqg@z3pjoszloxni>
References: <CA+G9fYuFdesVkgGOow7+uQpw-QA6hdqBBUye8CKMxGAiwHagOA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+G9fYuFdesVkgGOow7+uQpw-QA6hdqBBUye8CKMxGAiwHagOA@mail.gmail.com>
X-Rspamd-Queue-Id: 02404222A4
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCPT_COUNT_TWELVE(0.00)[20]; RCVD_TLS_LAST(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.it,lists.linaro.org,lists.linux.dev,kernel.org,suse.cz,arndb.de,linaro.org,zeniv.linux.org.uk,gmail.com,oracle.com,samsung.com];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.cz:+]; MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim, linaro.org:email, linaro.org:url,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo, suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] next-20250915: LTP chdir01 df01_sh stat04
 tst_device.c:97: TBROK: Could not stat loop device 0
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
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Linux Regressions <regressions@lists.linux.dev>, Arnd Bergmann <arnd@arndb.de>,
 Kanchan Joshi <joshi.k@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>,
 open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
 Ben Copeland <benjamin.copeland@linaro.org>,
 linux-block <linux-block@vger.kernel.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-fsdevel@vger.kernel.org, LTP List <ltp@lists.linux.it>,
 Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue 16-09-25 12:57:26, Naresh Kamboju wrote:
> The following LTP chdir01 df01_sh and stat04 tests failed on the rock-pi-4b
> qemu-arm64 on the Linux next-20250915 tag build.
> 
> First seen on next-20250915
> Good: next-20250912
> Bad: next-20250915
> 
> Regression Analysis:
> - New regression? yes
> - Reproducibility? yes
> 
> * rk3399-rock-pi-4b, ltp-smoke
> * qemu-arm64, ltp-smoke
> * qemu-arm64-compat, ltp-smoke
>  - chdir01
>   - df01_sh
>   - stat04
> 
> Test regression: next-20250915: LTP chdir01 df01_sh stat04
> tst_device.c:97: TBROK: Could not stat loop device 0

This is really strange. Those failing tests all start to complain that
/dev/loop0 doesn't exist (open gets ENOENT)... The fact that this is
limited to only a few archs suggests it's some race somewhere but I don't
see any relevant changes in linux-block in last three days...

								Honza

> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> ## Test log
> <8>[   53.655971] <LAVA_SIGNAL_STARTTC chdir01>
> tst_buffers.c:57: TINFO: Test is using guarded buffers
> tst_tmpdir.c:316: TINFO: Using /tmp/LTP_chdm4pHJb as tmpdir (tmpfs filesystem)
> tst_device.c:98: TINFO: Found free device 0 '/dev/loop0'
> tst_test.c:1953: TINFO: LTP version: 20250530
> tst_test.c:1956: TINFO: Tested kernel: 6.17.0-rc6-next-20250915 #1 SMP
> PREEMPT @1757983656 aarch64
> tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
> tst_kconfig.c:676: TINFO: CONFIG_TRACE_IRQFLAGS kernel option detected
> which might slow the execution
> tst_test.c:1774: TINFO: Overall timeout per run is 0h 28m 48s
> tst_supported_fs_types.c:97: TINFO: Kernel supports ext2
> tst_supported_fs_types.c:62: TINFO: mkfs.ext2 does exist
> tst_supported_fs_types.c:97: TINFO: Kernel supports ext3
> tst_supported_fs_types.c:62: TINFO: mkfs.ext3 does exist
> tst_supported_fs_types.c:97: TINFO: Kernel supports ext4
> tst_supported_fs_types.c:62: TINFO: mkfs.ext4 does exist
> tst_supported_fs_types.c:128: TINFO: Filesystem xfs is not supported
> tst_supported_fs_types.c:97: TINFO: Kernel supports btrfs
> tst_supported_fs_types.c:62: TINFO: mkfs.btrfs does exist
> tst_supported_fs_types.c:105: TINFO: Skipping bcachefs because of FUSE blacklist
> tst_supported_fs_types.c:97: TINFO: Kernel supports vfat
> tst_supported_fs_types.c:62: TINFO: mkfs.vfat does exist
> tst_supported_fs_types.c:128: TINFO: Filesystem exfat is not supported
> tst_supported_fs_types.c:132: TINFO: FUSE does support ntfs
> tst_supported_fs_types.c:62: TINFO: mkfs.ntfs does exist
> tst_supported_fs_types.c:97: TINFO: Kernel supports tmpfs
> tst_supported_fs_types.c:49: TINFO: mkfs is not needed for tmpfs
> tst_test.c:1888: TINFO: === Testing on ext2 ===
> tst_device.c:391: TWARN: Failed to clear 512k block on /dev/loop0
> tst_test.c:1217: TBROK: tst_clear_device() failed
> Summary:
> passed   0
> failed   0
> broken   1
> skipped  0
> warnings 1
> tst_device.c:283: TWARN: open(/dev/loop0) failed: ENOENT (2)
> <8>[   53.679564] <LAVA_SIGNAL_ENDTC chdir01>
> <8>[   53.708246] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=chdir01 RESULT=fail>
> 
> <8>[   53.933883] <LAVA_SIGNAL_STARTTC stat04>
> tst_buffers.c:57: TINFO: Test is using guarded buffers
> tst_tmpdir.c:316: TINFO: Using /tmp/LTP_staPDxElt as tmpdir (tmpfs filesystem)
> tst_device.c:97: TBROK: Could not stat loop device 0
> Summary:
> passed   0
> failed   0
> broken   1
> skipped  0
> warnings 0
> <8>[   53.947889] <LAVA_SIGNAL_ENDTC stat04>
> <8>[   53.974024] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=stat04 RESULT=fail>
> 
> <8>[   54.048075] <LAVA_SIGNAL_STARTTC df01_sh>
> df01 1 TINFO: Running: df01.sh
> df01 1 TINFO: Tested kernel: Linux
> runner-j2nyww-sk-project-40964107-concurrent-0
> 6.17.0-rc6-next-20250915 #1 SMP PREEMPT @1757983656 aarch64 GNU/Linux
> df01 1 TINFO: Using /tmp/LTP_df01.7pcwUXe1CN as tmpdir (tmpfs filesystem)
> tst_device.c:97: TBROK: Could not stat loop device 0
> df01 1 TBROK: Failed to acquire device
> Summary:
> passed   0
> failed   0
> broken   1
> skipped  0
> warnings 0
> <8>[   54.060936] <LAVA_SIGNAL_ENDTC df01_sh>
> <8>[   54.087630] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=df01_sh RESULT=fail>
> 
> ## Source
> * Kernel version: 6.17.0-rc6
> * Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
> * Git describe: 6.17.0-rc6-next-20250915
> * Git commit: c3067c2c38316c3ef013636c93daa285ee6aaa2e
> * Architectures: arm64
> * Toolchains: gcc-13 and gcc-8
> * Kconfigs: lkftconfigs
> 
> ## Build
> * Test log: https://qa-reports.linaro.org/api/testruns/29896973/log_file/
> * Test details:
> https://regressions.linaro.org/lkft/linux-next-master/next-20250915/ltp-smoke/stat04/
> * Test plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/32l4Vv9hKep2EcmS18u3NBtmoAm
> * Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/32l4UF8KltAzu6kUpW3hXaYRWjZ/
> * Kernel config:
> https://storage.tuxsuite.com/public/linaro/lkft/builds/32l4UF8KltAzu6kUpW3hXaYRWjZ/config
> 
> --
> Linaro LKFT
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
