Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10F58C021B1
	for <ltp@archiver.kernel.org>; Thu, 20 Feb 2025 18:46:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 76C283C79AA
	for <ltp@archiver.kernel.org>; Thu, 20 Feb 2025 19:46:52 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2B8153C672B
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 19:46:35 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 935AF1BC13F9
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 19:46:34 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 989792111F;
 Thu, 20 Feb 2025 18:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740077193;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ubE5nPz5YrVjZpyM1bs+U6kk3cNY8LWjMYniic4Nka4=;
 b=V6k62BEHvopS827upk8EzRNzLB/Pomrtg+hzpsJo/IPEQ0AJhzmg9A3x/kSzDHgoCQqpG7
 Gxhax2xL8fdHceW/R1gbAmk49wtZcv8zeBtnRxEGp20Ffe0ZQSJIkPJbxv+NmZxQ2IVRSs
 6s8pDBXMW/LQ3RAK19dJyYl368P2QHI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740077193;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ubE5nPz5YrVjZpyM1bs+U6kk3cNY8LWjMYniic4Nka4=;
 b=+guBz8aFMI3MgmmR+by2cxFiClZ6baNdYpJEyd42cCwmTgWdK0ygmNO74sCAqY+0rzimfn
 pZCeMPHbWiqL7OAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740077193;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ubE5nPz5YrVjZpyM1bs+U6kk3cNY8LWjMYniic4Nka4=;
 b=V6k62BEHvopS827upk8EzRNzLB/Pomrtg+hzpsJo/IPEQ0AJhzmg9A3x/kSzDHgoCQqpG7
 Gxhax2xL8fdHceW/R1gbAmk49wtZcv8zeBtnRxEGp20Ffe0ZQSJIkPJbxv+NmZxQ2IVRSs
 6s8pDBXMW/LQ3RAK19dJyYl368P2QHI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740077193;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ubE5nPz5YrVjZpyM1bs+U6kk3cNY8LWjMYniic4Nka4=;
 b=+guBz8aFMI3MgmmR+by2cxFiClZ6baNdYpJEyd42cCwmTgWdK0ygmNO74sCAqY+0rzimfn
 pZCeMPHbWiqL7OAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 686B613A42;
 Thu, 20 Feb 2025 18:46:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zgt4GIl4t2fgLgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 20 Feb 2025 18:46:33 +0000
Date: Thu, 20 Feb 2025 19:46:31 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
 ltp@lists.linux.it, Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <20250220184631.GA2713854@pevik>
References: <20250220160054.12149-1-zohar@linux.ibm.com>
 <20250220160054.12149-3-zohar@linux.ibm.com>
 <20250220181604.GA2709977@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250220181604.GA2709977@pevik>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 3/3] ima: additional ToMToU violation tests
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

Hi Mimi,

> Hi Mimi,

> > Kernel patch "ima: limit the number of ToMToU integrity violations"
> > prevents superfluous ToMToU violations.  Add corresponding LTP tests.

> > Link: https://lore.kernel.org/linux-integrity/20250219162131.416719-3-zohar@linux.ibm.com/
> > Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>

> Unfortunately tests fail on both mainline kernel and kernel with your patches.

> Any hint what could be wrong?

> Mainline kernel (on kernel with your patches it looks the same):

I'm sorry, I accidentally tested only on vanilla kernel. Rerunning tests with
updated kernel.

Is it this considered as a security feature? If yes, than failures on vanilla
kernel are ok, we just need to later add kernel hashes to let testers know about
missing backports. If it's a feature (not to be backported) we should test new
feature only on newer kernels.

Kind regards,
Petr

> ima_violations 1 TINFO: Running: ima_violations.sh
> ima_violations 1 TINFO: Tested kernel: Linux ts 6.13.0-2.g0127a37-default #1 SMP PREEMPT_DYNAMIC Thu Jan 23 11:21:55 UTC 2025 (0127a37) x86_64 x86_64 x86_64 GNU/Linux
> ima_violations 1 TINFO: Using /tmp/LTP_ima_violations.cKm34XVZk2 as tmpdir (tmpfs filesystem)
> tst_device.c:99: TINFO: Found free device 0 '/dev/loop0'
> ima_violations 1 TINFO: Formatting ext3 with opts='/dev/loop0'
> ima_violations 1 TINFO: Mounting device: mount -t ext3 /dev/loop0 /tmp/LTP_ima_violations.cKm34XVZk2/mntpoint
> ima_violations 1 TINFO: timeout per run is 0h 5m 0s
> ima_violations 1 TINFO: IMA kernel config:
> ima_violations 1 TINFO: CONFIG_IMA=y
> ima_violations 1 TINFO: CONFIG_IMA_MEASURE_PCR_IDX=10
> ima_violations 1 TINFO: CONFIG_IMA_LSM_RULES=y
> ima_violations 1 TINFO: CONFIG_IMA_NG_TEMPLATE=y
> ima_violations 1 TINFO: CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
> ima_violations 1 TINFO: CONFIG_IMA_DEFAULT_HASH_SHA256=y
> ima_violations 1 TINFO: CONFIG_IMA_DEFAULT_HASH="sha256"
> ima_violations 1 TINFO: CONFIG_IMA_READ_POLICY=y
> ima_violations 1 TINFO: CONFIG_IMA_APPRAISE=y
> ima_violations 1 TINFO: CONFIG_IMA_ARCH_POLICY=y
> ima_violations 1 TINFO: CONFIG_IMA_APPRAISE_BOOTPARAM=y
> ima_violations 1 TINFO: CONFIG_IMA_APPRAISE_MODSIG=y
> ima_violations 1 TINFO: CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=y
> ima_violations 1 TINFO: CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=y
> ima_violations 1 TINFO: CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT=y
> ima_violations 1 TINFO: CONFIG_IMA_DISABLE_HTABLE=y
> ima_violations 1 TINFO: /proc/cmdline: BOOT_IMAGE=/boot/vmlinuz-6.13.0-2.g0127a37-default root=UUID=e36b2366-1af2-4408-903c-1fca82c60f4c splash=silent video=1024x768 plymouth.ignore-serial-consoles console=ttyS0 console=tty kernel.softlockup_panic=1 resume=/dev/disk/by-uuid/c3b865f9-5d5b-410e-a6d1-9ebcf721584c mitigations=auto security=apparmor ignore_loglevel
> ima_violations 1 TINFO: $TMPDIR is on tmpfs => run on loop device
> ima_violations 1 TINFO: test requires IMA policy:
> measure func=FILE_CHECK mask=^MAY_READ euid=0
> measure func=FILE_CHECK mask=^MAY_READ uid=0
> ima_violations 1 TINFO: SUT has required policy content
> ima_violations 1 TINFO: using log /var/log/audit/audit.log
> ima_violations 1 TINFO: verify open writers violation
> ima_violations 1 TFAIL: open_writers too many violations added
> ima_violations 2 TINFO: verify ToMToU violation
> ima_violations 2 TFAIL: ToMToU too many violations added
> ima_violations 3 TINFO: verify open_writers using mmapped files
> tst_test.c:1900: TINFO: LTP version: 20250130-22-gcd2215702f
> tst_test.c:1904: TINFO: Tested kernel: 6.13.0-2.g0127a37-default #1 SMP PREEMPT_DYNAMIC Thu Jan 23 11:21:55 UTC 2025 (0127a37) x86_64
> tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
> tst_kconfig.c:676: TINFO: CONFIG_FAULT_INJECTION kernel option detected which might slow the execution
> tst_test.c:1722: TINFO: Overall timeout per run is 0h 02m 00s
> ima_mmap.c:38: TINFO: sleep 3s
> ima_violations 3 TFAIL: open_writers too many violations added
> ima_mmap.c:41: TPASS: test completed

> Summary:
> passed   1
> failed   0
> broken   0
> skipped  0
> warnings 0
> ima_violations 4 TINFO: verify limiting single open writer violation
> ima_violations 4 TFAIL: open_writers too many violations added
> ima_violations 5 TINFO: verify limiting multiple open writers violations
> ima_violations 5 TFAIL: open_writers too many violations added
> ima_violations 6 TINFO: verify new open writer causes additional violation
> ima_violations 6 TFAIL: open_writers too many violations added
> ima_violations 7 TINFO: verify limiting single open reader ToMToU violations
> ima_violations 7 TFAIL: ToMToU too many violations added
> ima_violations 8 TINFO: verify new open reader causes additional ToMToU violation
> ima_violations 8 TFAIL: ToMToU too many violations added

> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
