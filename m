Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 228A0CA0EDC
	for <ltp@archiver.kernel.org>; Thu, 14 Aug 2025 13:07:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 37F5C3CBC31
	for <ltp@archiver.kernel.org>; Thu, 14 Aug 2025 15:07:01 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1BB863CB133
 for <ltp@lists.linux.it>; Thu, 14 Aug 2025 15:06:45 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 85A1D6002C4
 for <ltp@lists.linux.it>; Thu, 14 Aug 2025 15:06:43 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 226901F458;
 Thu, 14 Aug 2025 13:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1755176803;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Bg24rUVvXSKfAY29dUSfx5/TyoWVdoZas6MBhmp8XpQ=;
 b=aoAkg2p0iPqtLTt15PMVF0ywV+J8122Ma4lN6srCZfwk7keXaUcr6ouNzn5S6VgZ2B/pOA
 jqKciCzE+mCm5j0jZpqJ20ov83K4xrcNMLwrPQ1GBDh9lc9r46GsRm8/xgm/YfKi49SCYa
 Cvu7+GEC9Yz6/JdA9+4HEclGy9soVwU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1755176803;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Bg24rUVvXSKfAY29dUSfx5/TyoWVdoZas6MBhmp8XpQ=;
 b=tGH0f9tFgQdSaSROW9lp8uGsO72lrq+CZgV2B0hKpbFw8jt4gpCrgfXKy+YOG1G1GCkdZh
 k6/MmXkxAnK3xlAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1755176803;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Bg24rUVvXSKfAY29dUSfx5/TyoWVdoZas6MBhmp8XpQ=;
 b=aoAkg2p0iPqtLTt15PMVF0ywV+J8122Ma4lN6srCZfwk7keXaUcr6ouNzn5S6VgZ2B/pOA
 jqKciCzE+mCm5j0jZpqJ20ov83K4xrcNMLwrPQ1GBDh9lc9r46GsRm8/xgm/YfKi49SCYa
 Cvu7+GEC9Yz6/JdA9+4HEclGy9soVwU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1755176803;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Bg24rUVvXSKfAY29dUSfx5/TyoWVdoZas6MBhmp8XpQ=;
 b=tGH0f9tFgQdSaSROW9lp8uGsO72lrq+CZgV2B0hKpbFw8jt4gpCrgfXKy+YOG1G1GCkdZh
 k6/MmXkxAnK3xlAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 49DC01368C;
 Thu, 14 Aug 2025 13:06:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qFBwEGDfnWg7YgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 14 Aug 2025 13:06:40 +0000
Date: Thu, 14 Aug 2025 15:06:29 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20250814130629.GA575710@pevik>
References: <20250812141709.33540-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250812141709.33540-1-liwang@redhat.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:email];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] tst_mkfs: print short hint when mkfs fails in
 device busy
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
Cc: rafael.tinoco@linaro.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li,


> During daily CI testing of LTP, we were intermittently getting EBUSY (in many
> testcases) when mkfs the /dev/loop0 device. It seemed that userspace was
> reopening the block device immediately after unmounting it. Debugging with
> bpftrace revealed that the udisks2 daemon was the culprit (probing the block
> device on every change). As this was outside the scope of the LTP code, we
> added a printout suggesting that testers stop the udisk2 service when
> encountering this failure during testing.

>   ==== setxattr01 ====
>   tst_test.c:1888: TINFO: === Testing on ext2 ===
>   tst_test.c:1217: TINFO: Formatting /dev/loop0 with ext2 opts='' extra opts='' mke2fs 1.47.1 (20-May-2024)
>   tst_test.c:1229: TINFO: Mounting /dev/loop0 to /tmp/LTP_setd24dAf/mntpoint fstyp=ext2 flags=0
>   ...
>   setxattr01.c:174: TPASS: setxattr(2) failed: EFAULT (14)
>   tst_test.c:1888: TINFO: === Testing on ext3 ===
>   tst_test.c:1217: TINFO: Formatting /dev/loop0 with ext3 opts='' extra opts='' mke2fs 1.47.1 (20-May-2024)
>   /dev/loop0 is apparently in use by the system; will not make a filesystem here!
>   tst_test.c:1217: TBROK: mkfs.ext3 failed with exit code 1

>   ==== close_range01 ====
>   tst_test.c:1888: TINFO: === Testing on ext2 ===
>   tst_test.c:1217: TINFO: Formatting /dev/loop0 with ext2 opts='' extra opts='' mke2fs 1.47.1 (20-May-2024)
>   tst_test.c:1229: TINFO: Mounting /dev/loop0 to /tmp/LTP_cloXeXI39/mnt fstyp=ext2 flags=0
>   ...
>   close_range01.c:188: TPASS: No kernel taints
>   tst_test.c:1888: TINFO: === Testing on ext3 ===
>   tst_test.c:1217: TINFO: Formatting /dev/loop0 with ext3 opts='' extra opts='' mke2fs 1.47.1 (20-May-2024)
>   /dev/loop0 is apparently in use by the system; will not make a filesystem here!
>   tst_test.c:1217: TBROK: mkfs.ext3 failed with exit code 1

> Running bpftrace in a separate terminal and also with ./close_range01
> simultaneously to get the output shows that another daemon (udisksd) is
> probing the block device on every change.

Good catch!

>   # bpftrace -e 'tracepoint:syscalls:sys_enter_openat /str(args->filename)=="/dev/loop0"/ \
>       { printf("%s pid=%d flags=0x%x %s\n", comm, pid, args->flags, str(args->filename)); }'
>   Attaching 1 probe...
>   close_range01 pid=298948 flags=0x2 /dev/loop0
>   (udev-worker) pid=298949 flags=0x288000 /dev/loop0
>   close_range01 pid=298948 flags=0x0 /dev/loop0
>   systemd-udevd pid=702 flags=0x288000 /dev/loop0
>   (udev-worker) pid=298949 flags=0x288000 /dev/loop0
>   (udev-worker) pid=298949 flags=0x280000 /dev/loop0
>   udisksd pid=87323 flags=0x0 /dev/loop0
>   (udev-worker) pid=298949 flags=0x288000 /dev/loop0
>   (udev-worker) pid=298949 flags=0x288000 /dev/loop0
>   (udev-worker) pid=298949 flags=0x280000 /dev/loop0
>   udisksd pid=87323 flags=0x0 /dev/loop0
>   close_range01 pid=298948 flags=0x241 /dev/loop0
>   systemd-udevd pid=702 flags=0x288000 /dev/loop0
>   (udev-worker) pid=298949 flags=0x288000 /dev/loop0
>   (udev-worker) pid=298949 flags=0x288000 /dev/loop0
>   mkfs.ext2 pid=298969 flags=0x80 /dev/loop0
>   mkfs.ext2 pid=298969 flags=0x0 /dev/loop0
>   mkfs.ext2 pid=298969 flags=0x0 /dev/loop0
>   mkfs.ext2 pid=298969 flags=0x0 /dev/loop0
>   mkfs.ext2 pid=298969 flags=0x80800 /dev/loop0
>   mkfs.ext2 pid=298969 flags=0x0 /dev/loop0
>   mkfs.ext2 pid=298969 flags=0x82 /dev/loop0
>   (udev-worker) pid=298949 flags=0x280000 /dev/loop0
>   udisksd pid=87323 flags=0x0 /dev/loop0
>   systemd-udevd pid=702 flags=0x288000 /dev/loop0
>   (udev-worker) pid=298949 flags=0x288000 /dev/loop0
>   (udev-worker) pid=298949 flags=0x288000 /dev/loop0
>   udisksd pid=87323 flags=0x0 /dev/loop0
>   (udev-worker) pid=298949 flags=0x280000 /dev/loop0
>   udisksd pid=87323 flags=0x0 /dev/loop0
>   udisksd pid=87323 flags=0x0 /dev/loop0        <--------
>   close_range01 pid=298948 flags=0x241 /dev/loop0
>   systemd-udevd pid=702 flags=0x288000 /dev/loop0
>   (udev-worker) pid=298949 flags=0x288000 /dev/loop0
>   (udev-worker) pid=298949 flags=0x288000 /dev/loop0
>   mkfs.ext3 pid=298977 flags=0x80 /dev/loop0
>   mkfs.ext3 pid=298977 flags=0x0 /dev/loop0
>   mkfs.ext3 pid=298977 flags=0x0 /dev/loop0
>   ...

> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>  lib/tst_mkfs.c | 4 ++++
>  1 file changed, 4 insertions(+)

> diff --git a/lib/tst_mkfs.c b/lib/tst_mkfs.c
> index 736324f04..dfec06a21 100644
> --- a/lib/tst_mkfs.c
> +++ b/lib/tst_mkfs.c
> @@ -107,6 +107,10 @@ void tst_mkfs_(const char *file, const int lineno, void (cleanup_fn)(void),
>  			"%s not found in $PATH", mkfs);
>  	break;
>  	default:
> +		tst_resm_(file, lineno, TWARN,
> +			"Check if mkfs failed with the (loop) device busy. "
> +			"Background probing (e.g., udisks2) can cause this. \n"
When 2 lines are needed, could it be without trailing space?
			"Background probing (e.g., udisks2) can cause this.\n"

nit: I don't like LTP messages are split on more lines, but this is indeed too
long.

> +			"Consider temporarily stopping udisks2 during the test.");

We already have suggestion about some process running in tst_umount()
in lib/tst_device.c:

			tst_resm(TINFO, "Likely gvfsd-trash is probing newly "
				 "mounted fs, kill it to speed up tests.");

Would you agree to have a library function which would parse
/proc/*/comm to check if particular process is running?
(I would do it as a separate effort).

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

>  		tst_brkm_(file, lineno, TBROK, cleanup_fn,
>  			"%s failed with exit code %i", mkfs, ret);
>  	}

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
