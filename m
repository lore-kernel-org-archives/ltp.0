Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A210FC3600C
	for <ltp@archiver.kernel.org>; Tue,  8 Apr 2025 13:00:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1A6CD3CB3AA
	for <ltp@archiver.kernel.org>; Tue,  8 Apr 2025 15:00:29 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4BE823C02B3
 for <ltp@lists.linux.it>; Tue,  8 Apr 2025 15:00:10 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1B5C2600290
 for <ltp@lists.linux.it>; Tue,  8 Apr 2025 15:00:09 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 924612116E;
 Tue,  8 Apr 2025 13:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744117208;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hu7v92iVW/WPY3mstwEMvffvwevOdfs9KCKPEJNWCkM=;
 b=gfBbIaOvj4/+juA1/mGR+ZFLwr+n03oDgxaDKDcMvdzBd1IL4c4Z+6LVJMxmCPb8Xv1cIE
 efB/hTz46gsdbv88Wo+4uBIb/ETqqYbXTZra+gnp/RLY+5WbfPFpIMu1xgz/vmNUHSQKVV
 O9ClqURW9iteG0jADZTeMdXxEYHRPBM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744117208;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hu7v92iVW/WPY3mstwEMvffvwevOdfs9KCKPEJNWCkM=;
 b=QNYQN6CkqNy/PDOL4FVOmI1Nfq30BGGT8VEgk5TF/PZLjz8wgb3iqCMUvxQGUfEh0/RoqP
 /6BUD35fWl5SYlCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744117208;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hu7v92iVW/WPY3mstwEMvffvwevOdfs9KCKPEJNWCkM=;
 b=gfBbIaOvj4/+juA1/mGR+ZFLwr+n03oDgxaDKDcMvdzBd1IL4c4Z+6LVJMxmCPb8Xv1cIE
 efB/hTz46gsdbv88Wo+4uBIb/ETqqYbXTZra+gnp/RLY+5WbfPFpIMu1xgz/vmNUHSQKVV
 O9ClqURW9iteG0jADZTeMdXxEYHRPBM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744117208;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hu7v92iVW/WPY3mstwEMvffvwevOdfs9KCKPEJNWCkM=;
 b=QNYQN6CkqNy/PDOL4FVOmI1Nfq30BGGT8VEgk5TF/PZLjz8wgb3iqCMUvxQGUfEh0/RoqP
 /6BUD35fWl5SYlCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7C2EF13691;
 Tue,  8 Apr 2025 13:00:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iPJjHdgd9Wf/KQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 08 Apr 2025 13:00:08 +0000
Date: Tue, 8 Apr 2025 15:00:03 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
 ltp@lists.linux.it
Message-ID: <20250408130003.GB225750@pevik>
References: <20250408125507.GA225750@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250408125507.GA225750@pevik>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-0.998]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FREEMAIL_TO(0.00)[gmail.com,suse.cz,lists.linux.it];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC] fanotify: avoid TCONF on btrfs on TMPDIR
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

Hi Amir, Jan,

The subject was supposed to be "fanotify: avoid TCONF on btrfs on TMPDIR".

Kind regards,
Petr

> LTP tested on btrfs on TMPDIR is skipped with TCONF:
> # TMPDIR=/var/tmp ./fanotify23
> tst_tmpdir.c:316: TINFO: Using /var/tmp/LTP_fanzN3sOS as tmpdir (btrfs filesystem)
> tst_device.c:98: TINFO: Found free device 0 '/dev/loop0'
> tst_test.c:1194: TINFO: Formatting /dev/loop0 with ext2 opts='' extra opts=''
> mke2fs 1.47.0 (5-Feb-2023)
> tst_test.c:1206: TINFO: Mounting /dev/loop0 to /var/tmp/LTP_fanzN3sOS/fs_mnt fstyp=ext2 flags=0
> tst_test.c:1928: TINFO: LTP version: 20250130-190-g2c79e30c2c
> tst_test.c:1932: TINFO: Tested kernel: 6.14.0-3.g5e7754e-default #1 SMP PREEMPT_DYNAMIC Mon Mar 31 14:34:31 UTC 2025 (5e7754e) x86_64
> tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
> tst_kconfig.c:676: TINFO: CONFIG_FAULT_INJECTION kernel option detected which might slow the execution
> tst_test.c:1748: TINFO: Overall timeout per run is 0h 02m 00s
> fanotify23.c:233: TCONF: FAN_ATTRIB not supported on ext2 filesystem

> The same is fanotify22.c
> fanotify22.c:296: TCONF: FAN_FS_ERROR not supported on ext4 filesystem

> They work on tmpfs on TMPDIR:

> # ./fanotify23
> tst_tmpdir.c:316: TINFO: Using /tmp/LTP_fanh6TUn4 as tmpdir (tmpfs filesystem)
> tst_device.c:98: TINFO: Found free device 0 '/dev/loop0'
> tst_test.c:1194: TINFO: Formatting /dev/loop0 with ext2 opts='' extra opts=''
> mke2fs 1.47.0 (5-Feb-2023)
> tst_test.c:1206: TINFO: Mounting /dev/loop0 to /tmp/LTP_fanh6TUn4/fs_mnt fstyp=ext2 flags=0
> tst_test.c:1928: TINFO: LTP version: 20250130-190-g2c79e30c2c
> tst_test.c:1932: TINFO: Tested kernel: 6.14.0-3.g5e7754e-default #1 SMP PREEMPT_DYNAMIC Mon Mar 31 14:34:31 UTC 2025 (5e7754e) x86_64
> tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
> tst_kconfig.c:676: TINFO: CONFIG_FAULT_INJECTION kernel option detected which might slow the execution
> tst_test.c:1748: TINFO: Overall timeout per run is 0h 02m 00s
> fanotify23.c:109: TPASS: FAN_MARK_ADD failed with EEXIST as expected when trying to downgrade to evictable mark
> fanotify23.c:72: TPASS: FAN_MARK_REMOVE failed with ENOENT as expected after empty mask
> fanotify23.c:155: TPASS: Got no events as expected
> fanotify23.c:72: TPASS: FAN_MARK_REMOVE failed with ENOENT as expected after drop_caches
> fanotify23.c:196: TPASS: got event: mask=4
> fanotify23.c:196: TPASS: got event: mask=4
> fanotify23.c:56: TINFO: Umounting /tmp/LTP_fanh6TUn4/fs_mnt
> fanotify23.c:57: TINFO: Mounting /dev/loop0 to /tmp/LTP_fanh6TUn4/fs_mnt fstyp=ext2 flags=0

> Is there a way to avoid TCONF on btrfs?

> # df -hT /var/tmp/ /tmp/
> Filesystem     Type   Size  Used Avail Use% Mounted on
> /dev/vda2      btrfs   28G   24G  1.6G  94% /var
> tmpfs          tmpfs  1.4G   32K  1.4G   1% /tmp

> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
