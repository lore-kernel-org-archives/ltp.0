Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1D68D5CCAF
	for <ltp@archiver.kernel.org>; Wed, 30 Oct 2024 13:47:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0FDFA3CAFBF
	for <ltp@archiver.kernel.org>; Wed, 30 Oct 2024 14:47:33 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ABBA33CAF32
 for <ltp@lists.linux.it>; Wed, 30 Oct 2024 14:47:17 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0FEA0641114
 for <ltp@lists.linux.it>; Wed, 30 Oct 2024 14:47:16 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3ACCA1F7DD;
 Wed, 30 Oct 2024 13:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730296035; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fFV0Qv5CZwKOQIsx1XoQRsOWBwHGhYa7G8471hyDnDE=;
 b=Pty+kAEFz1G8LmmDZyq7/aYOIRpqAm67SNG25COCenPPx3oif1z9i8jaacn+WxiazPpOsH
 /2G5YJEHwmOg6wLjVxuSJ9VsHxDZmc+O5ZnXaqNZQ56T8HWTi0RI+lsECawYEzqW9RercQ
 BrgCW45OcFUh61lAfaUuob0yx3NzsJo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730296035;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fFV0Qv5CZwKOQIsx1XoQRsOWBwHGhYa7G8471hyDnDE=;
 b=fjqJalawJNgzDdfDj3Rd+MhaA3XVR14zs8JJwLF3zDDBHmnp5IcfgJv0/04exBF2mEd7uK
 ZUSytjH9VNSwJBAg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Pty+kAEF;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=fjqJalaw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730296035; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fFV0Qv5CZwKOQIsx1XoQRsOWBwHGhYa7G8471hyDnDE=;
 b=Pty+kAEFz1G8LmmDZyq7/aYOIRpqAm67SNG25COCenPPx3oif1z9i8jaacn+WxiazPpOsH
 /2G5YJEHwmOg6wLjVxuSJ9VsHxDZmc+O5ZnXaqNZQ56T8HWTi0RI+lsECawYEzqW9RercQ
 BrgCW45OcFUh61lAfaUuob0yx3NzsJo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730296035;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fFV0Qv5CZwKOQIsx1XoQRsOWBwHGhYa7G8471hyDnDE=;
 b=fjqJalawJNgzDdfDj3Rd+MhaA3XVR14zs8JJwLF3zDDBHmnp5IcfgJv0/04exBF2mEd7uK
 ZUSytjH9VNSwJBAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 27BA713AD9;
 Wed, 30 Oct 2024 13:47:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hsKOCOM4ImeVdwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 30 Oct 2024 13:47:15 +0000
Date: Wed, 30 Oct 2024 14:47:04 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ZyI42B6qhZCf0Qwo@yuki.lan>
References: <20241030-generate_syscalls-v5-0-eed6a87dc787@suse.com>
 <20241030-generate_syscalls-v5-1-eed6a87dc787@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241030-generate_syscalls-v5-1-eed6a87dc787@suse.com>
X-Rspamd-Queue-Id: 3ACCA1F7DD
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:dkim];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 1/3] Refactor regen.sh script to generate
 syscalls
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> +(
> +	echo
> +	echo "/* Common stubs */"
> +	while IFS= read -r arch; do
> +		while IFS= read -r line; do
> +			set -- ${line}
> +			syscall_nr="__NR_$1"
> +			shift
> +
> +			echo "# ifndef ${syscall_nr}"
> +			echo "#  define ${syscall_nr} __LTP__NR_INVALID_SYSCALL"
> +			echo "# endif"
> +		done <"${SCRIPT_DIR}/${arch}.in"
> +	done <${SUPPORTED_ARCH}
> +	echo "#endif"
> +) >>${SYSCALLS_FILE}

This will generate multiple fallback definitions, one per architecture
for common syscall, there was a good reason why these files were parsed
by awk with sort -u

> -echo "#define __LTP__NR_INVALID_SYSCALL -1" >> "${output_pid}"
> -for nr in $(awk '{print $1}' "${srcdir}/"*.in | sort -u) ; do

This is the important part that IMHO should stay.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
