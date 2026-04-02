Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08AA5D6AB17
	for <ltp@archiver.kernel.org>; Thu,  2 Apr 2026 21:26:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9AE003E4E96
	for <ltp@archiver.kernel.org>; Thu,  2 Apr 2026 23:26:54 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9F0313E2F53
 for <ltp@lists.linux.it>; Thu,  2 Apr 2026 23:26:34 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 845091400758
 for <ltp@lists.linux.it>; Thu,  2 Apr 2026 23:26:32 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A57B34D309;
 Thu,  2 Apr 2026 21:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775165186;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EyGwyAgL7mk3sv84CPDlfjwZd9kgzppaDft6OVmSD2Q=;
 b=pO4tj6fg85Cn5fctV3MaWrJh/lseuokn1kysYzX4OjXVluHJOuLIkq+jeYVifTVrJ6Ed4x
 ooeO3dRiGTyvDWZ9NCNPyDr71L9Etmsn42BR2LN64ndA7/To0b4IXLJ7yxaqg6twcmi+7J
 x8nc9ZtupmLE0cugGWpj8DhvVK6Ydrw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775165186;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EyGwyAgL7mk3sv84CPDlfjwZd9kgzppaDft6OVmSD2Q=;
 b=YU+IldsTtCtHtUC+dXya42qdsmBhhuLyIMCxag1lXe8gDFBMKMUqcwdmPPTPC6QWBPNK9/
 rl8XwlghYR2LOEBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775165186;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EyGwyAgL7mk3sv84CPDlfjwZd9kgzppaDft6OVmSD2Q=;
 b=pO4tj6fg85Cn5fctV3MaWrJh/lseuokn1kysYzX4OjXVluHJOuLIkq+jeYVifTVrJ6Ed4x
 ooeO3dRiGTyvDWZ9NCNPyDr71L9Etmsn42BR2LN64ndA7/To0b4IXLJ7yxaqg6twcmi+7J
 x8nc9ZtupmLE0cugGWpj8DhvVK6Ydrw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775165186;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EyGwyAgL7mk3sv84CPDlfjwZd9kgzppaDft6OVmSD2Q=;
 b=YU+IldsTtCtHtUC+dXya42qdsmBhhuLyIMCxag1lXe8gDFBMKMUqcwdmPPTPC6QWBPNK9/
 rl8XwlghYR2LOEBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3981A4A0B0;
 Thu,  2 Apr 2026 21:26:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id efx4DALfzmn4OQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 02 Apr 2026 21:26:26 +0000
Date: Thu, 2 Apr 2026 23:26:20 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260402212620.GA225068@pevik>
References: <20260402121356.31266-1-chrubis@suse.cz>
 <20260402121356.31266-4-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260402121356.31266-4-chrubis@suse.cz>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 03/17] lib: tst_kernel: Add
 tst_check_module_driver()
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

Hi Cyril,

> This function allows us to check for presence of drivers build as
s/build/built/
> modules.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  include/tst_kernel.h | 10 ++++++++++
>  lib/tst_kernel.c     | 12 +++++++-----
>  2 files changed, 17 insertions(+), 5 deletions(-)

> diff --git a/include/tst_kernel.h b/include/tst_kernel.h
> index 63ecb19a4..d5a4a9625 100644
> --- a/include/tst_kernel.h
> +++ b/include/tst_kernel.h
> @@ -45,6 +45,16 @@ bool tst_abi_bits(int abi);
>   */
>  int tst_check_builtin_driver(const char *driver);

> +/**
> + * tst_check_module_driver() - Check if the kernel module is present.
> + *
> + * @driver: the name of the driver.
> + *
> + * Return: 0 if module driver is present or -1 when driver is missing or config file not
> + * available. On Android *always* 0 (always expect the module is present).

nit: "the driver" vs. "the module". We have kernel modules which are builtin or
compiled as modules. The older two functions say "the driver", but they are also
modules (although builtin), maybe worth to change it.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
