Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA0FBC369BA
	for <ltp@archiver.kernel.org>; Wed, 16 Apr 2025 06:23:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2EA3C3CB951
	for <ltp@archiver.kernel.org>; Wed, 16 Apr 2025 08:23:19 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 753193CABE1
 for <ltp@lists.linux.it>; Wed, 16 Apr 2025 08:23:01 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 042012005F6
 for <ltp@lists.linux.it>; Wed, 16 Apr 2025 08:23:00 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9B10921162;
 Wed, 16 Apr 2025 06:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744784577;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hSV+vtY8Ku7weRo4hXIUhxbDqALauawAvw2iq7FmdFQ=;
 b=QUGxhlhuyilEhnyd65mxFxSyX8GZsR5AMODcmGga+9o4ch5XYPQPZ+Nt0DBgjxucb+huAi
 Iz8nMyZ9hENOXZM8Vha7nNR/k65IzXXtPYItW3LcnSjDZv7daCRfTQF8Yd9dhYd6HHd/o+
 P1y6b7qAd9R1OkbP/xiMJwxvCbqSNjE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744784577;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hSV+vtY8Ku7weRo4hXIUhxbDqALauawAvw2iq7FmdFQ=;
 b=F9tg3j5YN+aQrXdNe/SSZ1n4qi/7fcKokBJdJDScUc7LLgwB1BnS50KA/rbbBbMTyGU5Kp
 iQi+4wGVDUVYI3Dg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744784577;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hSV+vtY8Ku7weRo4hXIUhxbDqALauawAvw2iq7FmdFQ=;
 b=QUGxhlhuyilEhnyd65mxFxSyX8GZsR5AMODcmGga+9o4ch5XYPQPZ+Nt0DBgjxucb+huAi
 Iz8nMyZ9hENOXZM8Vha7nNR/k65IzXXtPYItW3LcnSjDZv7daCRfTQF8Yd9dhYd6HHd/o+
 P1y6b7qAd9R1OkbP/xiMJwxvCbqSNjE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744784577;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hSV+vtY8Ku7weRo4hXIUhxbDqALauawAvw2iq7FmdFQ=;
 b=F9tg3j5YN+aQrXdNe/SSZ1n4qi/7fcKokBJdJDScUc7LLgwB1BnS50KA/rbbBbMTyGU5Kp
 iQi+4wGVDUVYI3Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7BD26139A1;
 Wed, 16 Apr 2025 06:22:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0jJCHcFM/2cvOQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 16 Apr 2025 06:22:57 +0000
Date: Wed, 16 Apr 2025 08:22:55 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20250416062255.GB560513@pevik>
References: <20250407142351.25900-1-mdoucha@suse.cz>
 <20250407142351.25900-4-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250407142351.25900-4-mdoucha@suse.cz>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:replyto];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/5] KVM: Simplify reading VMX control field masks
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

...
>  	/* Configure VM execution control fields */
> -	if (kvm_rdmsr(MSR_IA32_VMX_BASIC) & IA32_VMXBASIC_USELESS_CTL_MASKS) {
> -		pinxctl = (uint32_t)kvm_rdmsr(MSR_IA32_VMX_PINX_MASK2);
> -		execctl = (uint32_t)kvm_rdmsr(MSR_IA32_VMX_EXECCTL_MASK2);
> -		exitctl = (uint32_t)kvm_rdmsr(MSR_IA32_VMX_EXITCTL_MASK2);
> -		entryctl = (uint32_t)kvm_rdmsr(MSR_IA32_VMX_ENTRYCTL_MASK2);
> -	} else {
> -		pinxctl = (uint32_t)kvm_rdmsr(MSR_IA32_VMX_PINX_MASK);
> -		execctl = (uint32_t)kvm_rdmsr(MSR_IA32_VMX_EXECCTL_MASK);
> -		exitctl = (uint32_t)kvm_rdmsr(MSR_IA32_VMX_EXITCTL_MASK);
> -		entryctl = (uint32_t)kvm_rdmsr(MSR_IA32_VMX_ENTRYCTL_MASK);

I guess you're going to use in the future MSR_IA32_VMX_PINX_MASK2 and other
deleted masks (because now they are IMHO only in the structs).

Acked-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> -	}
> +	pinxctl = (uint32_t)kvm_vmx_read_vmctl_mask(VMX_CTLMASK_PINX);
> +	execctl = (uint32_t)kvm_vmx_read_vmctl_mask(VMX_CTLMASK_EXECCTL);
> +	exitctl = (uint32_t)kvm_vmx_read_vmctl_mask(VMX_CTLMASK_EXITCTL);
> +	entryctl = (uint32_t)kvm_vmx_read_vmctl_mask(VMX_CTLMASK_ENTRYCTL);

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
