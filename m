Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13AC7C4707B
	for <ltp@archiver.kernel.org>; Thu, 18 Jan 2024 12:14:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 891E23CEFD1
	for <ltp@archiver.kernel.org>; Thu, 18 Jan 2024 13:14:43 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BF2713C1D32
 for <ltp@lists.linux.it>; Thu, 18 Jan 2024 13:14:28 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0A95D600973
 for <ltp@lists.linux.it>; Thu, 18 Jan 2024 13:14:27 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9B0DD21F32;
 Thu, 18 Jan 2024 12:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705580066; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ot22z46vNzJoJXaggFLFKJKo6rbXb2ux/DRpEpdMMek=;
 b=Gqb0RrDhvoLG26oBhwfJBycOUO0Y5rvXkxjbbvg55uTR+TQesp2p2n3dcoyQUhC137vahm
 JLjFYTcArmQtIqulyQsux9+IA4QPoEjbqGiH9jNSGOYZuIk0bBCGHDL3MF+mDnJHZWwfjI
 1esf2kghKq2X6lE3gAEYDFYgEqYEit4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705580066;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ot22z46vNzJoJXaggFLFKJKo6rbXb2ux/DRpEpdMMek=;
 b=qSNPaf6XJybutiwGnxj9SXUAMU4RCcU2ysTEf1gFkTY/OgHY+NWnpvuOH3dJkbfUjnVwOj
 IeBmjeX2cpipczDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705580066; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ot22z46vNzJoJXaggFLFKJKo6rbXb2ux/DRpEpdMMek=;
 b=Gqb0RrDhvoLG26oBhwfJBycOUO0Y5rvXkxjbbvg55uTR+TQesp2p2n3dcoyQUhC137vahm
 JLjFYTcArmQtIqulyQsux9+IA4QPoEjbqGiH9jNSGOYZuIk0bBCGHDL3MF+mDnJHZWwfjI
 1esf2kghKq2X6lE3gAEYDFYgEqYEit4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705580066;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ot22z46vNzJoJXaggFLFKJKo6rbXb2ux/DRpEpdMMek=;
 b=qSNPaf6XJybutiwGnxj9SXUAMU4RCcU2ysTEf1gFkTY/OgHY+NWnpvuOH3dJkbfUjnVwOj
 IeBmjeX2cpipczDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7E2371387C;
 Thu, 18 Jan 2024 12:14:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KOuFHSIWqWW7bQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 18 Jan 2024 12:14:26 +0000
Date: Thu, 18 Jan 2024 13:14:31 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZakWJ0ZqrLWTQFty@yuki>
References: <20240111094530.1893262-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240111094530.1893262-1-pvorel@suse.cz>
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Gqb0RrDh;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=qSNPaf6X
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.01 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[30.80%]
X-Rspamd-Queue-Id: 9B0DD21F32
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] keyctl05: Add modprobe dns_resolver
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
> This avoids TCONF when module not loaded:
> keyctl05.c:99: TCONF: kernel doesn't support key type 'dns_resolver'
> 
> There is no way to trigger module loading automatically.

I just checked the kernel add_key() syscall and indeed there is no way
the sycall would load a module, all it does is to loop over already
registered kernel key types.

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Hi,
> 
> a candidate to merge before release (simple enough).
> 
> I'll try to send a patchset for .modprobe_module before the release, but
> I suppose we should merge it after the release anyway. That's why I
> added this simple patch. And therefore I don't bother with 'modprobe -r',
> neither with requiring modprobe (will be in .modprobe_module).

Sounds like a plan. Let's go for this workaround before the release
then.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

>  testcases/kernel/syscalls/keyctl/keyctl05.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/syscalls/keyctl/keyctl05.c b/testcases/kernel/syscalls/keyctl/keyctl05.c
> index f0e09fe5d..a79a5763b 100644
> --- a/testcases/kernel/syscalls/keyctl/keyctl05.c
> +++ b/testcases/kernel/syscalls/keyctl/keyctl05.c
> @@ -34,6 +34,8 @@
>  #include "tst_test.h"
>  #include "lapi/keyctl.h"
>  
> +#define MODULE "dns_resolver"
> +
>  /*
>   * A valid payload for the "asymmetric" key type.  This is an x509 certificate
>   * in DER format, generated using:
> @@ -193,6 +195,9 @@ static void test_update_setperm_race(void)
>  
>  static void setup(void)
>  {
> +	/* There is no way to trigger automatic dns_resolver module loading. */
> +	tst_cmd((const char*[]){"modprobe", MODULE, NULL}, NULL, NULL, 0);
> +
>  	fips_enabled = tst_fips_enabled();
>  }
>  
> @@ -213,7 +218,7 @@ static void do_test(unsigned int i)
>  					 x509_cert, sizeof(x509_cert));
>  		break;
>  	case 1:
> -		test_update_nonupdatable("dns_resolver", dns_res_payload,
> +		test_update_nonupdatable(MODULE, dns_res_payload,
>  			sizeof(dns_res_payload));
>  		break;
>  	case 2:
> -- 
> 2.43.0
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
