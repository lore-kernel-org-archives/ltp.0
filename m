Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4000C83F1A
	for <ltp@archiver.kernel.org>; Wed, 23 Jul 2025 19:17:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8E82E3CCD7B
	for <ltp@archiver.kernel.org>; Wed, 23 Jul 2025 21:17:00 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1C0A23CC33C
 for <ltp@lists.linux.it>; Wed, 23 Jul 2025 21:16:44 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A985E1400756
 for <ltp@lists.linux.it>; Wed, 23 Jul 2025 21:16:43 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C5EE91F78C;
 Wed, 23 Jul 2025 19:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1753298202;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lHXoS2XIlSzns1GB8DfI6auFWykNjNe2C35dWB646kU=;
 b=YtFyr+rxOlMAiKC8QV1r2f53ypz/cx2CKT00hcaEq4jOmTKhHlGGjZMOka80CD+nauFvZ0
 hImGEFbOX2FvUntx2fjrG1n8Kf2FfNoxuJQN7pqCdzsdJkefRsPYyw5zlRird8xpcWs/6J
 JBoeqA6g5pjWh1Gb+dXswPXgYYZ8HDw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1753298202;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lHXoS2XIlSzns1GB8DfI6auFWykNjNe2C35dWB646kU=;
 b=xfblZiwHUbyunLjcYQtjODRtGAL1of8zdltVQ03Mwx0DH0hKvaZptvRCTMvHyx+sKBEx4j
 OvnzoaK3S1TTiOAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1753298202;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lHXoS2XIlSzns1GB8DfI6auFWykNjNe2C35dWB646kU=;
 b=YtFyr+rxOlMAiKC8QV1r2f53ypz/cx2CKT00hcaEq4jOmTKhHlGGjZMOka80CD+nauFvZ0
 hImGEFbOX2FvUntx2fjrG1n8Kf2FfNoxuJQN7pqCdzsdJkefRsPYyw5zlRird8xpcWs/6J
 JBoeqA6g5pjWh1Gb+dXswPXgYYZ8HDw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1753298202;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lHXoS2XIlSzns1GB8DfI6auFWykNjNe2C35dWB646kU=;
 b=xfblZiwHUbyunLjcYQtjODRtGAL1of8zdltVQ03Mwx0DH0hKvaZptvRCTMvHyx+sKBEx4j
 OvnzoaK3S1TTiOAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AC46413AF2;
 Wed, 23 Jul 2025 19:16:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id R8E1KBo1gWg5AgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 23 Jul 2025 19:16:42 +0000
Date: Wed, 23 Jul 2025 21:16:41 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <20250723191641.GB162896@pevik>
References: <20250723005117.4282-1-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250723005117.4282-1-yangtiezhu@loongson.cn>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; TO_DN_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] ltp_block_dev: Check HAVE_LINUX_GENHD_H to
 include genhd.h
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Tiezhu,

> After the LTP commit d4dd360b05f8 ("device-drivers/acpi/ltp_acpi_cmds:
> Fix build errors"), HAVE_LINUX_GENHD_H is defined to 1 if you have the
> <linux/genhd.h> header file.

> The macro definition DISK_NAME_LEN may be completely removed, so it is
> better to use #ifdef HAVE_LINUX_GENHD_H to include genhd.h.

Merged with slightly reworded commit message.
Thank you!

> Suggested-by: Petr Vorel <pvorel@suse.cz>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
> v2: Add Suggested-by tag

Thanks for sending v2. That was not needed, I could have added Suggested-by:
myself before merge, but I thought this module was unused and you plan to send
v2 with its removal (but you meant test_genhd.c).

Kind regards,
Petr

> +++ b/testcases/kernel/device-drivers/block/block_dev_kernel/ltp_block_dev.c
> @@ -13,7 +13,7 @@
>  #include <linux/device.h>
>  #include <linux/fs.h>
>  #include <linux/blkdev.h>
> -#ifndef DISK_NAME_LEN
> +#ifdef HAVE_LINUX_GENHD_H
>  # include <linux/genhd.h>
>  #endif

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
