Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5423EC25B74
	for <ltp@archiver.kernel.org>; Mon, 27 May 2024 22:36:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D21F53D04B8
	for <ltp@archiver.kernel.org>; Tue, 28 May 2024 00:36:13 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A9D8D3C286E
 for <ltp@lists.linux.it>; Tue, 28 May 2024 00:35:58 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 23D4420032E
 for <ltp@lists.linux.it>; Tue, 28 May 2024 00:35:57 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 15E17222A8;
 Mon, 27 May 2024 22:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716849357;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8K3W5eiSVFTTpPNPH3VhI9F7fDWH3waqnT+WSOryBws=;
 b=oIWNrlkZMCakvoyEgZTU8FsgQ6wTzKXyQIRRoHy7HgAqLytClYuXSDZ5eMso3pLe8p8us+
 B03xYRCCz5cyIhca83AStYafRUi59TwD7lfpb+/Nro/yGHy7SrvMjXcoTwQkECyijO8q9O
 ts8n5lt17CsiQ8uz0Mp2khFRIL7eZhE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716849357;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8K3W5eiSVFTTpPNPH3VhI9F7fDWH3waqnT+WSOryBws=;
 b=REyWxdrzy8Y7urnMKFKNP7GnfMXt0qyVbO0Y0Zcl3HTXaj+AQKhhx5uAQEErHoQDls4wmd
 yUaxAMX22cU6J1Bw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716849357;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8K3W5eiSVFTTpPNPH3VhI9F7fDWH3waqnT+WSOryBws=;
 b=oIWNrlkZMCakvoyEgZTU8FsgQ6wTzKXyQIRRoHy7HgAqLytClYuXSDZ5eMso3pLe8p8us+
 B03xYRCCz5cyIhca83AStYafRUi59TwD7lfpb+/Nro/yGHy7SrvMjXcoTwQkECyijO8q9O
 ts8n5lt17CsiQ8uz0Mp2khFRIL7eZhE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716849357;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8K3W5eiSVFTTpPNPH3VhI9F7fDWH3waqnT+WSOryBws=;
 b=REyWxdrzy8Y7urnMKFKNP7GnfMXt0qyVbO0Y0Zcl3HTXaj+AQKhhx5uAQEErHoQDls4wmd
 yUaxAMX22cU6J1Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DBE2913A6B;
 Mon, 27 May 2024 22:35:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WamxMswKVWZ5HwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 27 May 2024 22:35:56 +0000
Date: Tue, 28 May 2024 00:35:51 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20240527223551.GA374567@pevik>
References: <20240527135718.29451-1-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240527135718.29451-1-mdoucha@suse.cz>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] kvm_pagefault01: Do not write into tdp_mmu sysfile
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

Hi Martin,

> The tdp_mmu sysfile was made read-only in kernel v6.3. Do not modify
> it but only reload vendor KVM modules if needed. Some kernel versions
> before v6.3 have writable tdp_mmu sysfile which appears to be
> independent from vendor KVM module settings. Print a warning about
> false negatives if tdp_mmu appears enabled after reloading KVM
> modules. It is unclear if that state may impact bug reproducibility.

Good catch.

...
>  static void disable_tdp(void)
>  {
> -	if (!access(TDP_MMU_SYSFILE, F_OK)) {
> -		/* FIXME: Is setting tdp_mmu=0 sufficient to disable TDP? */
> -		return;
> -	}
> -
>  	if (read_bool_sys_param(TDP_AMD_SYSFILE) > 0)
>  		reload_module("kvm_amd", "npt=0");

>  	if (read_bool_sys_param(TDP_INTEL_SYSFILE) > 0)
>  		reload_module("kvm_intel", "ept=0");
> +
> +	if (read_bool_sys_param(TDP_MMU_SYSFILE) > 0)
> +		tst_res(TINFO, "tdp_mmu is enabled, beware of false negatives");

Wouldn't it be better to add "WARNING:" to make it more visible?
		tst_res(TINFO, "WARNING: tdp_mmu is enabled, beware of false negatives");

(if you agree, I can change it before merge)

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
