Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 408C1C25B47
	for <ltp@archiver.kernel.org>; Fri, 27 Oct 2023 17:18:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 819533CF4A6
	for <ltp@archiver.kernel.org>; Fri, 27 Oct 2023 19:18:32 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2333E3C996B
 for <ltp@lists.linux.it>; Fri, 27 Oct 2023 19:18:20 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1CCEC20096F
 for <ltp@lists.linux.it>; Fri, 27 Oct 2023 19:18:19 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 362251F8B3;
 Fri, 27 Oct 2023 17:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698427097;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+JQp5gugPmAUbb8Wz8cgpoVOeFUOZ5by7GUGtyIDq1Q=;
 b=x55Kw9wLWjrBO9ZaClkaT/yPJHcNLk9RL7OojOqtgOqI7HID2Cy9+cCevXk2H+4HSuRZrg
 x3ssJRint/DrnkPIHM5kyH+3uqGGYgre3R/WOGDbVfYKt77GcH6pFpNpM8XkYP3EBcPlOq
 Rg+Y1UnrmlOt4fCu+ojOuA+Aaqll7A4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698427097;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+JQp5gugPmAUbb8Wz8cgpoVOeFUOZ5by7GUGtyIDq1Q=;
 b=SNk1jIqKM/AzboMIjDeL6lLkMpHqIL9OnBc5DiQZpXwAd3/ATIC8OXSAlYfT7Gh0veDptY
 ft0ypp3/qj1TESCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E279E1358C;
 Fri, 27 Oct 2023 17:18:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id F61KNNjwO2WfTAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 27 Oct 2023 17:18:16 +0000
Date: Fri, 27 Oct 2023 19:18:15 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <20231027171815.GB673099@pevik>
References: <20231027093801.51947-1-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231027093801.51947-1-xuyang2018.jy@fujitsu.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-10.24 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; REPLY(-4.00)[];
 NEURAL_HAM_LONG(-3.00)[-1.000]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-2.94)[99.74%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/3] umount01: Simplify test using TST_ macros
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

Hi Xu,

[ Cc Cyril, who wrote gvfsd-trash note in 10b61174c ("syscalls: umount01: Give a
hint on failure with EBUSY") ]

While this patch looks to be OK, there is a problem when run several times
(either with -i > 1 or even just repeatedly run without -i):

./umount01 -i2 # your version
tst_device.c:96: TINFO: Found free device 2 '/dev/loop2'
tst_test.c:1105: TINFO: Formatting /dev/loop2 with ext2 opts='' extra opts=''
mke2fs 1.47.0 (5-Feb-2023)
tst_test.c:1690: TINFO: LTP version: 20230929-83-g4123555e7
tst_test.c:1574: TINFO: Timeout per run is 0h 00m 30s
umount01.c:20: TINFO: Mounting /dev/loop2 to /tmp/LTP_umoxYOalA/mntpoint fstyp=ext2 flags=0
umount01.c:25: TFAIL: umount(MNTPOINT) failed: EBUSY (16)
umount01.c:28: TINFO: umount() Failed with EBUSY possibly some daemon (gvfsd-trash) is probing newly mounted dirs
umount01.c:20: TINFO: Mounting /dev/loop2 to /tmp/LTP_umoxYOalA/mntpoint fstyp=ext2 flags=0
umount01.c:20: TBROK: mount(/dev/loop2, mntpoint, ext2, 0, (nil)) failed: EBUSY (16)

I tried to bisect and run even the several years old code (with
CFLAGS="-fcommon", so that I don't have to bother with error fixed in 9ac2ee5ac
("lib: Fix linking error multiple TCID definitions with -fno-common")) it quite
often (not always) fails:

./umount01 # 9185ace3e # (rewrite to new API)
tst_device.c:81: INFO: Found free device '/dev/loop3'
tst_test.c:754: INFO: Timeout per run is 0h 05m 00s
tst_mkfs.c:69: INFO: Formatting /dev/loop3 with ext2 opts='' extra opts=''
mke2fs 1.47.0 (5-Feb-2023)
umount01.c:42: INFO: umount() Failed with EBUSY possibly some daemon (gvfsd-trash) is probing newly mounted dirs
umount01.c:48: FAIL: umount() Failed: EBUSY
tst_device.c:277: INFO: umount('mntpoint') failed with EBUSY, try  1...
tst_device.c:281: INFO: Likely gvfsd-trash is probing newly mounted fs, kill it to speed up tests.

./umount01 # 6825c4f73 (before rewrite to new API)
umount01    0  TINFO  :  Found free device '/dev/loop2'
umount01    0  TINFO  :  Formatting /dev/loop2 with ext2 opts='' extra opts=''
mke2fs 1.47.0 (5-Feb-2023)
umount01    0  TINFO  :  umount() failed with EBUSY possibly some daemon (gvfsd-trash) is probing newly mounted dirs
umount01    1  TFAIL  :  umount01.c:68: umount(2) Failed while  unmounting mntpoint errno = 16 : Device or resource busy

The difference is, that only with your code it not only TFAIL, but also TBROK,
which leads to left mounted filesystem (which could influence other tests). I'll
try to have look next week, this should be fixed.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
