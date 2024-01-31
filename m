Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AE4CC47DB3
	for <ltp@archiver.kernel.org>; Wed, 31 Jan 2024 18:53:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5EB5C3CF925
	for <ltp@archiver.kernel.org>; Wed, 31 Jan 2024 19:53:32 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2DB613CB13B
 for <ltp@lists.linux.it>; Wed, 31 Jan 2024 19:53:18 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7CF7D1400DA2
 for <ltp@lists.linux.it>; Wed, 31 Jan 2024 19:53:16 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D8FB121BBE;
 Wed, 31 Jan 2024 18:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706727196;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jqb4WFIbydRY+lA6EJ7wLE6SNVLxNGM6uU13ehkfipA=;
 b=L8Kvua+Ktu0M0NdDXqPB5zqQU4te9/LANzYAqhBznDCFsDFmc4V0d1isuRxF4zSfT7wYMI
 DUQzVq+sw0qHYblFDcbZNjz2UVtMjTJgMNwzS4RpS84bRWxoXMZrAlcYU8ISWYLbvFNohK
 Ud0/lzwssuXAPhDsCQ8cK2vDD6aD+L4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706727196;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jqb4WFIbydRY+lA6EJ7wLE6SNVLxNGM6uU13ehkfipA=;
 b=bh1BH8nPSt8wjYZFfM2aWQ2JdHTC4SHOsZxjnP91IqBpoog4iAtsxiKqzhuVl7CVKALOS5
 2j3dH7yagfelrJCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706727195;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jqb4WFIbydRY+lA6EJ7wLE6SNVLxNGM6uU13ehkfipA=;
 b=YWOkpolnbYlbNoYOrTK26hUj+BqLlqOWok9Byxfxau8ud/V1NPYhfxPKWl0tV/dScWIw3Q
 2KM7wj3zgnwQtz0oV6w4gLDFyjplbHG60wcDet3DR5aLLoPJdi2Oqdx6u4b5LRg7MD2xSd
 NkYG2dPJ2MDbHJMe4iCjZ+2MayyK/fU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706727195;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jqb4WFIbydRY+lA6EJ7wLE6SNVLxNGM6uU13ehkfipA=;
 b=8sN+Ebz+HLY0Kw5jjT4VLPKfwB3sAKSf85CGK6h/s+FVRIcse+DhIev+wKJMo9kMDWGtpw
 0VMGHUmMyvvFakBg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 92B5A132FA;
 Wed, 31 Jan 2024 18:53:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id wusnIRuXumX1KwAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Wed, 31 Jan 2024 18:53:15 +0000
Date: Wed, 31 Jan 2024 19:53:10 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>, ltp@lists.linux.it
Message-ID: <20240131185310.GA30901@pevik>
References: <20240131102514.2739270-1-liwang@redhat.com>
 <20240131102514.2739270-8-liwang@redhat.com>
 <20240131173840.GA18869@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240131173840.GA18869@pevik>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-2.30 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Patch v6 7/8] swapon/off: enable all_filesystem in swap
 test
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

Hi Li,

First, I suppose you wait for Cyril, otherwise I would be for merging up to
previous commit ("libswap: customize swapfile size").

I found a problem in this commit. It looks like this patch breaks testing on
TMPDIR on tmpfs on Tumbleweed kernel 6.8.0-rc1-2.gf4ba5db-default:

TMPDIR=/tmp LTP_SINGLE_FS_TYPE=ntfs ./swapoff01
tst_test.c:1701: TINFO: === Testing on ntfs ===
tst_test.c:1117: TINFO: Formatting /dev/loop0 with ntfs opts='' extra opts=''
The partition start sector was not specified for /dev/loop0 and it could not be obtained automatically.  It has been set to 0.
The number of sectors per track was not specified for /dev/loop0 and it could not be obtained automatically.  It has been set to 0.
The number of heads was not specified for /dev/loop0 and it could not be obtained automatically.  It has been set to 0.
To boot from a device, Windows needs the 'partition start sector', the 'sectors per track' and the 'number of heads' to be set.
Windows will not be able to boot from this device.
tst_test.c:1131: TINFO: Mounting /dev/loop0 to /tmp/LTP_swawDOaMz/mntpoint fstyp=ntfs flags=0
tst_test.c:1131: TINFO: Trying FUSE...
tst_ioctl.c:26: TINFO: FIBMAP ioctl is supported
libswap.c:144: TBROK: Insufficient disk space to create swap file

df -hT /tmp/
Filesystem     Type   Size  Used Avail Use% Mounted on
tmpfs          tmpfs  717M     0  717M   0% /tmp

Test works on 6.6.x stable kernel, but that's due bigger tmpfs.
Could we at least TCONF (see below)?

I also wonder if we could make whole disk size a bit smaller.
The default 300 MB is not enough for XFS, right? But why 512 MB?
On6.8.0-rc1-2.gf4ba5db-default 350 MB is enough to test everything:

...
tst_test.c:1701: TINFO: === Testing on ntfs ===
tst_test.c:1117: TINFO: Formatting /dev/loop0 with ntfs opts='' extra opts=''
The partition start sector was not specified for /dev/loop0 and it could not be obtained automatically.  It has been set to 0.
The number of sectors per track was not specified for /dev/loop0 and it could not be obtained automatically.  It has been set to 0.
The number of heads was not specified for /dev/loop0 and it could not be obtained automatically.  It has been set to 0.
To boot from a device, Windows needs the 'partition start sector', the 'sectors per track' and the 'number of heads' to be set.
Windows will not be able to boot from this device.
tst_test.c:1131: TINFO: Mounting /dev/loop0 to /tmp/LTP_swaWEYzzv/mntpoint fstyp=ntfs flags=0
tst_test.c:1131: TINFO: Trying FUSE...
tst_ioctl.c:26: TINFO: FIBMAP ioctl is supported
swapoff01.c:39: TPASS: Succeeded to turn off swapfile
tst_test.c:1701: TINFO: === Testing on tmpfs ===
tst_test.c:1117: TINFO: Skipping mkfs for TMPFS filesystem
tst_test.c:1098: TINFO: Limiting tmpfs size to 512MB
tst_test.c:1131: TINFO: Mounting ltp-tmpfs to /tmp/LTP_swaWEYzzv/mntpoint fstyp=tmpfs flags=0
tst_ioctl.c:21: TINFO: FIBMAP ioctl is NOT supported: EINVAL (22)
libswap.c:198: TCONF: Swapfile on tmpfs not implemented

Summary:
passed   8
failed   0
broken   0
skipped  1
warnings 0

Kind regards,
Petr

diff --git a/testcases/kernel/syscalls/swapoff/swapoff01.c b/testcases/kernel/syscalls/swapoff/swapoff01.c
index af2a759cb..bde59df77 100644
--- a/testcases/kernel/syscalls/swapoff/swapoff01.c
+++ b/testcases/kernel/syscalls/swapoff/swapoff01.c
@@ -45,8 +45,7 @@ static void setup(void)
 	is_swap_supported(TEST_FILE);

 	if (!tst_fs_has_free(".", 64, TST_MB))
-		tst_brk(TBROK,
-			"Insufficient disk space to create swap file");
+		tst_brk(TCONF, "Insufficient disk space to create swap file");

 	if (make_swapfile(SWAP_FILE, 65536, 1))
 		tst_brk(TBROK, "Failed to create file for swap");

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
