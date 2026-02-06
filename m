Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6763AEE20AA
	for <ltp@archiver.kernel.org>; Fri,  6 Feb 2026 14:34:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7F7FB3CCA9E
	for <ltp@archiver.kernel.org>; Fri,  6 Feb 2026 15:34:36 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 786313CC816
 for <ltp@lists.linux.it>; Fri,  6 Feb 2026 15:34:17 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7D8ED601DB8
 for <ltp@lists.linux.it>; Fri,  6 Feb 2026 15:34:11 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B54C45BCC9;
 Fri,  6 Feb 2026 14:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1770388450;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8UrhZG5qkFm42B2ayPaa1WVSIoK8OTLkO40O7t7ZxQg=;
 b=rAAnLd+S29utom1TgkSKKD9n1sIAFkebAuEYJfrhMGIMABAIJTmAh6kNZ86qI9ipnJKhc5
 +YbJ6dilGGG2sukD/cz+JwsODdc3hndK4ENSGUXLE3iihqrGPOx9ajYnHy3/kq7GMGd3lU
 9hAAV8JQIVhO+b1Tbex52k4J2nOF9iI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1770388450;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8UrhZG5qkFm42B2ayPaa1WVSIoK8OTLkO40O7t7ZxQg=;
 b=jESxVEnVeHSD4EIv8XEMzbvJoJvVsAyvsexGuBIA86V01xHIa7zqbXGHPnhUYwzVmNMQJC
 YstsfiLTqUvW6+Ag==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1770388450;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8UrhZG5qkFm42B2ayPaa1WVSIoK8OTLkO40O7t7ZxQg=;
 b=rAAnLd+S29utom1TgkSKKD9n1sIAFkebAuEYJfrhMGIMABAIJTmAh6kNZ86qI9ipnJKhc5
 +YbJ6dilGGG2sukD/cz+JwsODdc3hndK4ENSGUXLE3iihqrGPOx9ajYnHy3/kq7GMGd3lU
 9hAAV8JQIVhO+b1Tbex52k4J2nOF9iI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1770388450;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8UrhZG5qkFm42B2ayPaa1WVSIoK8OTLkO40O7t7ZxQg=;
 b=jESxVEnVeHSD4EIv8XEMzbvJoJvVsAyvsexGuBIA86V01xHIa7zqbXGHPnhUYwzVmNMQJC
 YstsfiLTqUvW6+Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6EFA13EA63;
 Fri,  6 Feb 2026 14:34:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cusZGOL7hWnEKAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 06 Feb 2026 14:34:10 +0000
Date: Fri, 6 Feb 2026 15:34:08 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>
Message-ID: <20260206143408.GA402479@pevik>
References: <20260206125818.319190-1-vasileios.almpanis@virtuozzo.com>
 <20260206125818.319190-2-vasileios.almpanis@virtuozzo.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260206125818.319190-2-vasileios.almpanis@virtuozzo.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] add ETH_P_CAN compat macro to LAPI headers
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

Hi Vasileios,

>  include/lapi/if_ether.h | 4 ++++
>  1 file changed, 4 insertions(+)

> diff --git a/include/lapi/if_ether.h b/include/lapi/if_ether.h
> index 536d1863a..423341c57 100644
> --- a/include/lapi/if_ether.h
> +++ b/include/lapi/if_ether.h
> @@ -16,4 +16,8 @@
>  # define ETH_P_ALL 0x0003
>  #endif

> +#ifndef ETH_P_CAN
> +# define ETH_P_CAN 0x000C
> +#endif

This is not needed, because it was added to kernel's
include/uapi/linux/if_ether.h before UAPI creation in v3.7-rc1.
And we now expect kernel >= 4.4 [1].

FYI the fallback was originally added in 2017 in
db141701dd ("Add test for CVE-2017-7308 on a raw socket's ring buffer"),
the supported systems required it back then, but now whole include/lapi/if_ether.h,
could be deleted (as an separate effort). For now it'd be enough just to ignore
this commit (not add it).

Kind regards,
Petr

[1] https://linux-test-project.readthedocs.io/en/latest/users/supported_systems.html

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
