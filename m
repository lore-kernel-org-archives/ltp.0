Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F571C3600C
	for <ltp@archiver.kernel.org>; Tue,  8 Apr 2025 12:55:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 46CA83CB376
	for <ltp@archiver.kernel.org>; Tue,  8 Apr 2025 14:55:29 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5FDBD3CB340
 for <ltp@lists.linux.it>; Tue,  8 Apr 2025 14:55:10 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6ACDC1A00CD2
 for <ltp@lists.linux.it>; Tue,  8 Apr 2025 14:55:10 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6C1691F38E;
 Tue,  8 Apr 2025 12:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744116909;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type;
 bh=2iQkkFK7zxqp1bdCB3Wz0zn6NEvZByULgGJ/C049gkY=;
 b=eo8DjQlh6BgRjJoIES3Ax0uJjYAiiXzEY1NdEE2Wr0h/blp6sNUmzYjRZ7m7uS4+JoOguB
 CwAF/bYU/zq0qDYBWmJMvpjY/WU55a2hW76i2Qs3mUl9k7P417RqvgcXHwZlzqYVqw0mCO
 keuKU1Bn2XwO3EyMcjwsVIF+gxThghA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744116909;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type;
 bh=2iQkkFK7zxqp1bdCB3Wz0zn6NEvZByULgGJ/C049gkY=;
 b=niJ7Ivf/T1mQSRaYGgmitEi6xb/lrOilXbUU2QlVCPXMnosXTeYJRda0LboT87JrWbF+II
 H5S5M7NlYG10JXCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744116909;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type;
 bh=2iQkkFK7zxqp1bdCB3Wz0zn6NEvZByULgGJ/C049gkY=;
 b=eo8DjQlh6BgRjJoIES3Ax0uJjYAiiXzEY1NdEE2Wr0h/blp6sNUmzYjRZ7m7uS4+JoOguB
 CwAF/bYU/zq0qDYBWmJMvpjY/WU55a2hW76i2Qs3mUl9k7P417RqvgcXHwZlzqYVqw0mCO
 keuKU1Bn2XwO3EyMcjwsVIF+gxThghA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744116909;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type;
 bh=2iQkkFK7zxqp1bdCB3Wz0zn6NEvZByULgGJ/C049gkY=;
 b=niJ7Ivf/T1mQSRaYGgmitEi6xb/lrOilXbUU2QlVCPXMnosXTeYJRda0LboT87JrWbF+II
 H5S5M7NlYG10JXCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4613F13691;
 Tue,  8 Apr 2025 12:55:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QVq9D60c9WdaKAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 08 Apr 2025 12:55:09 +0000
Date: Tue, 8 Apr 2025 14:55:07 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <20250408125507.GA225750@pevik>
MIME-Version: 1.0
Content-Disposition: inline
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-0.998]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 MISSING_XM_UA(0.00)[]; FREEMAIL_TO(0.00)[gmail.com];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCPT_COUNT_THREE(0.00)[3]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] foo
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Amir, Jan,

LTP tested on btrfs on TMPDIR is skipped with TCONF:
# TMPDIR=/var/tmp ./fanotify23
tst_tmpdir.c:316: TINFO: Using /var/tmp/LTP_fanzN3sOS as tmpdir (btrfs filesystem)
tst_device.c:98: TINFO: Found free device 0 '/dev/loop0'
tst_test.c:1194: TINFO: Formatting /dev/loop0 with ext2 opts='' extra opts=''
mke2fs 1.47.0 (5-Feb-2023)
tst_test.c:1206: TINFO: Mounting /dev/loop0 to /var/tmp/LTP_fanzN3sOS/fs_mnt fstyp=ext2 flags=0
tst_test.c:1928: TINFO: LTP version: 20250130-190-g2c79e30c2c
tst_test.c:1932: TINFO: Tested kernel: 6.14.0-3.g5e7754e-default #1 SMP PREEMPT_DYNAMIC Mon Mar 31 14:34:31 UTC 2025 (5e7754e) x86_64
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:676: TINFO: CONFIG_FAULT_INJECTION kernel option detected which might slow the execution
tst_test.c:1748: TINFO: Overall timeout per run is 0h 02m 00s
fanotify23.c:233: TCONF: FAN_ATTRIB not supported on ext2 filesystem

The same is fanotify22.c
fanotify22.c:296: TCONF: FAN_FS_ERROR not supported on ext4 filesystem

They work on tmpfs on TMPDIR:

# ./fanotify23
tst_tmpdir.c:316: TINFO: Using /tmp/LTP_fanh6TUn4 as tmpdir (tmpfs filesystem)
tst_device.c:98: TINFO: Found free device 0 '/dev/loop0'
tst_test.c:1194: TINFO: Formatting /dev/loop0 with ext2 opts='' extra opts=''
mke2fs 1.47.0 (5-Feb-2023)
tst_test.c:1206: TINFO: Mounting /dev/loop0 to /tmp/LTP_fanh6TUn4/fs_mnt fstyp=ext2 flags=0
tst_test.c:1928: TINFO: LTP version: 20250130-190-g2c79e30c2c
tst_test.c:1932: TINFO: Tested kernel: 6.14.0-3.g5e7754e-default #1 SMP PREEMPT_DYNAMIC Mon Mar 31 14:34:31 UTC 2025 (5e7754e) x86_64
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:676: TINFO: CONFIG_FAULT_INJECTION kernel option detected which might slow the execution
tst_test.c:1748: TINFO: Overall timeout per run is 0h 02m 00s
fanotify23.c:109: TPASS: FAN_MARK_ADD failed with EEXIST as expected when trying to downgrade to evictable mark
fanotify23.c:72: TPASS: FAN_MARK_REMOVE failed with ENOENT as expected after empty mask
fanotify23.c:155: TPASS: Got no events as expected
fanotify23.c:72: TPASS: FAN_MARK_REMOVE failed with ENOENT as expected after drop_caches
fanotify23.c:196: TPASS: got event: mask=4
fanotify23.c:196: TPASS: got event: mask=4
fanotify23.c:56: TINFO: Umounting /tmp/LTP_fanh6TUn4/fs_mnt
fanotify23.c:57: TINFO: Mounting /dev/loop0 to /tmp/LTP_fanh6TUn4/fs_mnt fstyp=ext2 flags=0

Is there a way to avoid TCONF on btrfs?

# df -hT /var/tmp/ /tmp/
Filesystem     Type   Size  Used Avail Use% Mounted on
/dev/vda2      btrfs   28G   24G  1.6G  94% /var
tmpfs          tmpfs  1.4G   32K  1.4G   1% /tmp

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
