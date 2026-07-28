Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B78C53219
	for <ltp@archiver.kernel.org>; Tue, 28 Jul 2026 13:59:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 578D83E7495
	for <ltp@archiver.kernel.org>; Tue, 28 Jul 2026 15:59:25 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9AE6D3CD529
 for <ltp@lists.linux.it>; Tue, 28 Jul 2026 15:59:10 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 385412009A8
 for <ltp@lists.linux.it>; Tue, 28 Jul 2026 15:59:09 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 48F303E47;
 Tue, 28 Jul 2026 13:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785247144;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vaNnqlF5NQ8UPtxKOizOD1DPb+pdrO3KzZcJFxDLirE=;
 b=bajXGa/0gntRoL2E0bSFMVG22WByUnIU01yqRoyGju34F1n6ewqizCG5Mz3Tn72BdyCR0E
 ZqqIidEgyRH6lQzG0qB3qMgsvGo68MFsGJ67Oxmusg5NPB5kOhIiVSAyDP4PLgw9fknlc1
 qITwSOSkoIxcFqDVRdMymZewMTJM/tI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785247144;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vaNnqlF5NQ8UPtxKOizOD1DPb+pdrO3KzZcJFxDLirE=;
 b=pfX0Z5O5PDxg8fCDGyLRvUz0YZ7W5TmQsAZW09NmQ4IU4WXCOobhyG1wDzpdBbFKbvjCej
 6CjW+QtpAVf7FiBg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=vAyS74A7;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=x+Io3GhS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785247140;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vaNnqlF5NQ8UPtxKOizOD1DPb+pdrO3KzZcJFxDLirE=;
 b=vAyS74A76qVj4qkfcbqKswthyw2YwlTFzBsHGXvam/bVBR0utxJrLzb/JieStRQ35b++lv
 AQ14+4kXQviV+vkAQKhslq0usP0gsmHq7TJwra/2qnuWIE59dcE+2w0/yl08W39g15vyp6
 LyYpvk40N8u4gWxF3LHFP1Fsz6g53Po=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785247140;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vaNnqlF5NQ8UPtxKOizOD1DPb+pdrO3KzZcJFxDLirE=;
 b=x+Io3GhS8r1EBfSbRJfP68snr9SpzSj56jHWCxE+mhBTAE46TQxbPZxSajQwJAHbjmrt0I
 0fDJOm9oWMcYtNAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2C11C779B1;
 Tue, 28 Jul 2026 13:59:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4aduCaS1aGp5dwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 28 Jul 2026 13:59:00 +0000
Date: Tue, 28 Jul 2026 15:58:58 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20260728135858.GB1128467@pevik>
References: <20260717-fix_core_library-v1-0-c575fcbb2cb3@suse.com>
 <20260717-fix_core_library-v1-1-c575fcbb2cb3@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260717-fix_core_library-v1-1-c575fcbb2cb3@suse.com>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+]; REPLYTO_EQ_FROM(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; TO_DN_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:replyto,suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: 48F303E47
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] lib: Avoid loop_info.lo_name buffer overflow
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

> From: Andrea Cervesato <andrea.cervesato@suse.com>

> The backing file path may be longer than the fixed-size lo_name field,
> so an unbounded strcpy() can overflow the loop_info structure. Copy at
> most the field size and rely on the preceding memset() for termination.

> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  lib/tst_device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/lib/tst_device.c b/lib/tst_device.c
> index d3c53a1a18d2e4948ebff21d6d66c0ccd1590c6f..b5c3ccdb7be52ce600fbd7d7a83f6081df65d616 100644
> --- a/lib/tst_device.c
> +++ b/lib/tst_device.c
> @@ -182,7 +182,7 @@ int tst_attach_device(const char *dev, const char *file)
>  	 * LOOP_SET_FD and LOOP_SET_STATUS.
>  	 */
>  	memset(&loopinfo, 0, sizeof(loopinfo));
> -	strcpy(loopinfo.lo_name, file);
> +	strncpy(loopinfo.lo_name, file, sizeof(loopinfo.lo_name) - 1);

Reviewed-by: Petr Vorel <pvorel@suse.cz>

I suppose strncpy() is recommended as safer alternative to strcpy(),
right? Shouldn't we check for strlen(file) is not longer than
sizeof(loopinfo.lo_name) -1 while we are at it?

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
