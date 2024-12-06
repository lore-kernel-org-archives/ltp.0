Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65EB9E77173
	for <ltp@archiver.kernel.org>; Fri,  6 Dec 2024 09:03:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 710653E5C7C
	for <ltp@archiver.kernel.org>; Fri,  6 Dec 2024 10:03:19 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1C2763E5C74
 for <ltp@lists.linux.it>; Fri,  6 Dec 2024 10:03:01 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 87D391437F7B
 for <ltp@lists.linux.it>; Fri,  6 Dec 2024 10:02:54 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9129621190;
 Fri,  6 Dec 2024 09:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733475772;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1+FMuW7BMvWJy6LK2eJ37Vcwupq6RJeSTzmf0Di5Bqk=;
 b=Y1fjc25YOnqM2KoIZEWp4L9WiAkO57zZnx8LrsRHQtdI8gsjPDD5+EWJcu7j/DYxTjwck5
 rX04HujfFdD54K+5/VCmMo1b+YSzaW7ThwQRIH7syPbYvCHd1opXV4JkRKp/ZOphVbuVSI
 YdnyWfNZTFM14yNN5V0LK3+EdC3Fgpo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733475772;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1+FMuW7BMvWJy6LK2eJ37Vcwupq6RJeSTzmf0Di5Bqk=;
 b=xDOQgKXlUHJQAmmjXDAyARwY6FUJ8TekqqHIB5vm8phVws1hcGg3vGY2Y2qX7DmAbK8SGN
 MvmJrApCNaWKr0AA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733475772;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1+FMuW7BMvWJy6LK2eJ37Vcwupq6RJeSTzmf0Di5Bqk=;
 b=Y1fjc25YOnqM2KoIZEWp4L9WiAkO57zZnx8LrsRHQtdI8gsjPDD5+EWJcu7j/DYxTjwck5
 rX04HujfFdD54K+5/VCmMo1b+YSzaW7ThwQRIH7syPbYvCHd1opXV4JkRKp/ZOphVbuVSI
 YdnyWfNZTFM14yNN5V0LK3+EdC3Fgpo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733475772;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1+FMuW7BMvWJy6LK2eJ37Vcwupq6RJeSTzmf0Di5Bqk=;
 b=xDOQgKXlUHJQAmmjXDAyARwY6FUJ8TekqqHIB5vm8phVws1hcGg3vGY2Y2qX7DmAbK8SGN
 MvmJrApCNaWKr0AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7568E13647;
 Fri,  6 Dec 2024 09:02:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IDnMGry9UmdhBQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 06 Dec 2024 09:02:52 +0000
Date: Fri, 6 Dec 2024 10:02:47 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20241206090247.GA87653@pevik>
References: <20241204172312.34099-1-mdoucha@suse.cz>
 <20241204172312.34099-2-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241204172312.34099-2-mdoucha@suse.cz>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:email];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/2] Add test for data integrity over NFS
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

Hi,

> +++ b/testcases/network/nfs/nfs_stress/nfs10.sh
> @@ -0,0 +1,47 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (C) 2024 SUSE LLC <mdoucha@suse.cz>
> +#
> +# DESCRIPTION: Verify data integrity over NFS, with and without O_DIRECT
> +
> +TST_CNT=4
> +TST_SETUP="nfs10_setup"
> +TST_TESTFUNC="do_test"
> +TST_DEVICE_SIZE=1024

FYI requiring 1GB free space can break the test (even for UDP which should be
mostly skipped with TCONF due UDP being disabled on mainline kernel).
On UDP it runs quickly (< 10s), but on TCP it runs for whole timeout (~ 33 min).

This is not a new limitation in shell API, it always existed. But recent commit
8532eb2c61 ("Add support for setting loop device size in shell tests")
increased change of hitting the problem. I don't think it should block this
patchset, I'll send a patch fixing the API soon.

Kind regards,
Petr

# ./nfs10.sh -v 3 -t udp
nfs10 1 TINFO: Running: nfs10.sh -v 3 -t udp

nfs10 1 TINFO: 10.0.0.2/24 -- 10.0.0.1/24
nfs10 1 TINFO: fd00:1:1:1::2/64 -- fd00:1:1:1::1/64
nfs10 1 TINFO: Using /tmp/LTP_nfs10.XI7vLEjIkA as tmpdir (tmpfs filesystem)
tst_device.c:299: TWARN: Failed to create test_dev.img: ENOSPC (28)

Usage:
tst_device acquire [size [filename]]
tst_device release /path/to/device
tst_device clear /path/to/device

nfs10 1 TWARN: Failed to acquire device
tst_supported_fs_types.c:169: TINFO: Skipping ext2 as requested by the test
tst_supported_fs_types.c:169: TINFO: Skipping ext3 as requested by the test
tst_supported_fs_types.c:97: TINFO: Kernel supports ext4
tst_supported_fs_types.c:62: TINFO: mkfs.ext4 does exist
tst_supported_fs_types.c:97: TINFO: Kernel supports xfs
tst_supported_fs_types.c:62: TINFO: mkfs.xfs does exist
tst_supported_fs_types.c:97: TINFO: Kernel supports btrfs
tst_supported_fs_types.c:62: TINFO: mkfs.btrfs does exist
tst_supported_fs_types.c:97: TINFO: Kernel supports bcachefs
tst_supported_fs_types.c:62: TINFO: mkfs.bcachefs does exist
tst_supported_fs_types.c:169: TINFO: Skipping vfat as requested by the test
tst_supported_fs_types.c:169: TINFO: Skipping exfat as requested by the test
tst_supported_fs_types.c:169: TINFO: Skipping ntfs as requested by the test
tst_supported_fs_types.c:169: TINFO: Skipping tmpfs as requested by the test
nfs10 1 TINFO: === Testing on ext4 ===
tst_device.c:389: TWARN: Failed to clear 512k block on

Usage:
tst_device acquire [size [filename]]
tst_device release /path/to/device
tst_device clear /path/to/device

...

> +TST_TIMEOUT=660
...

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
