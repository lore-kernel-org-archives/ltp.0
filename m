Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2557ECFD65D
	for <ltp@archiver.kernel.org>; Wed,  7 Jan 2026 16:20:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C83CD3C535B
	for <ltp@archiver.kernel.org>; Wed,  7 Jan 2026 17:20:29 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 118E53C4F59
 for <ltp@lists.linux.it>; Wed,  7 Jan 2026 17:20:12 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9F13960079F
 for <ltp@lists.linux.it>; Wed,  7 Jan 2026 17:20:11 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 786975C23C;
 Wed,  7 Jan 2026 16:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1767802810;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XWd6xR80JDukzoRheenuqgYvnwM1vC3OP35oL7KMknw=;
 b=mSSrjUDU+JVbzJZ8MFM7D+H5YtcqO1qbPGNEsbTGaLH6cHd5bCzt8qusY1ZiPE8gAwNQX3
 M5cakqV3N/ZApnd1e1ZCNx9X5YUd3FSLzf4D3K+TMF3d+mc0g9KhnKU8os9CDUGZqXyTgW
 JZTR2y6YTjf8tqrJSlHP98/49y/ZRb4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1767802810;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XWd6xR80JDukzoRheenuqgYvnwM1vC3OP35oL7KMknw=;
 b=3GR3Z2CdE5DsTK33+Kx9EThCVfQahSrqMbfgHMOiY6vWlef5ia7ZYfwOWvl9drWtUuQewE
 YDEnKAo5NFY1m+AQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1767802810;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XWd6xR80JDukzoRheenuqgYvnwM1vC3OP35oL7KMknw=;
 b=mSSrjUDU+JVbzJZ8MFM7D+H5YtcqO1qbPGNEsbTGaLH6cHd5bCzt8qusY1ZiPE8gAwNQX3
 M5cakqV3N/ZApnd1e1ZCNx9X5YUd3FSLzf4D3K+TMF3d+mc0g9KhnKU8os9CDUGZqXyTgW
 JZTR2y6YTjf8tqrJSlHP98/49y/ZRb4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1767802810;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XWd6xR80JDukzoRheenuqgYvnwM1vC3OP35oL7KMknw=;
 b=3GR3Z2CdE5DsTK33+Kx9EThCVfQahSrqMbfgHMOiY6vWlef5ia7ZYfwOWvl9drWtUuQewE
 YDEnKAo5NFY1m+AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2FCD33EA63;
 Wed,  7 Jan 2026 16:20:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 540bCbqHXmkLNAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 07 Jan 2026 16:20:10 +0000
Date: Wed, 7 Jan 2026 17:20:00 +0100
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <20260107162000.GD791855@pevik>
References: <20260107155737.791588-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260107155737.791588-1-pvorel@suse.cz>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.991]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] ima_kexec.sh: Detect kernel image
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
Cc: linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

...
> +	if [ ! -f "$IMA_KEXEC_IMAGE" ]; then
> +		uname="$(uname -r)"
> +
> +		# x86_64
> +		f="/boot/vmlinuz-$uname"
> +
> +		# ppc64le, s390x
> +		if [ ! -f "$f" ]; then
> +			f="/boot/vmlinux-$uname"
> +		fi
> +
> +		# aarch64
> +		if [ ! -f "$f" ]; then
> +			f="/boot/Image-$uname"
> +		fi
> +
> +		# aarch64 often uses compression
> +		if [ ! -f "$f" ]; then
> +			f="$(ls /boot/Image-$uname.* || true)"
> +		fi
> +
> +		if [ -f "$f" ]; then
> +			IMA_KEXEC_IMAGE="$f"
> +		fi
> +	fi
> +
>  	if [ ! -f "$IMA_KEXEC_IMAGE" ]; then
>  		tst_brk TCONF "kernel image not found, specify path in \$IMA_KEXEC_IMAGE"
>  	fi

I'm sorry for the noise, I found our s390x emulation actually uses
/boot/image-$uname.  I suggest in the end to merge with following diff.

Kind regards,
Petr

+++ testcases/kernel/security/integrity/ima/tests/ima_kexec.sh
@@ -69,18 +69,16 @@ setup()
 	if [ ! -f "$IMA_KEXEC_IMAGE" ]; then
 		uname="$(uname -r)"
 
-		# x86_64
-		f="/boot/vmlinuz-$uname"
-
-		# ppc64le, s390x
-		if [ ! -f "$f" ]; then
-			f="/boot/vmlinux-$uname"
-		fi
-
-		# aarch64
-		if [ ! -f "$f" ]; then
-			f="/boot/Image-$uname"
-		fi
+		for f in \
+			/boot/vmlinuz-$uname \
+			/boot/vmlinux-$uname \
+			/boot/Image-$uname \
+			/boot/image-$uname \
+		; do
+			if [ -f "$f" ]; then
+				break
+			fi
+		done
 
 		# aarch64 often uses compression
 		if [ ! -f "$f" ]; then

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
