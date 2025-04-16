Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDF59C369B1
	for <ltp@archiver.kernel.org>; Wed, 16 Apr 2025 07:16:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2327E3CB94F
	for <ltp@archiver.kernel.org>; Wed, 16 Apr 2025 09:16:51 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A21023C2621
 for <ltp@lists.linux.it>; Wed, 16 Apr 2025 09:16:33 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8FFF1600068
 for <ltp@lists.linux.it>; Wed, 16 Apr 2025 09:16:31 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7A999211A1;
 Wed, 16 Apr 2025 07:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744787791;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IL0bzW4q+f1hYmNyJ6+gdDE0OfIH7Co6I4BrSxEcI8g=;
 b=WUinlWrz73T0tE5khmT4iC79sd4iLTdHoGQUy2nXdloNN6qhwg/0JOnN//3wNAKsGe62/X
 /w1p4d7lLCWDJ8cKbI8nJW3TMotzCm5yHdtUSpGblUWELg8tgcIf/op2tTXHe6sUHC9T9Q
 Bg0u/p8ORsJiiu04WsftNwlDebzWwmg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744787791;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IL0bzW4q+f1hYmNyJ6+gdDE0OfIH7Co6I4BrSxEcI8g=;
 b=MfSXzaw5CU6oiEU+0kfyUZfwzVT0KADfgSiMia8umyA+ESswNelQLqWH9wjrpYoYKvTfH0
 4P2us3eP3f6TtmAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744787791;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IL0bzW4q+f1hYmNyJ6+gdDE0OfIH7Co6I4BrSxEcI8g=;
 b=WUinlWrz73T0tE5khmT4iC79sd4iLTdHoGQUy2nXdloNN6qhwg/0JOnN//3wNAKsGe62/X
 /w1p4d7lLCWDJ8cKbI8nJW3TMotzCm5yHdtUSpGblUWELg8tgcIf/op2tTXHe6sUHC9T9Q
 Bg0u/p8ORsJiiu04WsftNwlDebzWwmg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744787791;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IL0bzW4q+f1hYmNyJ6+gdDE0OfIH7Co6I4BrSxEcI8g=;
 b=MfSXzaw5CU6oiEU+0kfyUZfwzVT0KADfgSiMia8umyA+ESswNelQLqWH9wjrpYoYKvTfH0
 4P2us3eP3f6TtmAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4811313976;
 Wed, 16 Apr 2025 07:16:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1C4NDk9Z/2cGSQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 16 Apr 2025 07:16:31 +0000
Date: Wed, 16 Apr 2025 09:16:21 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>, ltp@lists.linux.it
Message-ID: <20250416071621.GA572828@pevik>
References: <20250407142351.25900-1-mdoucha@suse.cz>
 <20250407142351.25900-4-mdoucha@suse.cz>
 <20250416062255.GB560513@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250416062255.GB560513@pevik>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Martin,

> Hi Martin,

> ...
> >  	/* Configure VM execution control fields */
> > -	if (kvm_rdmsr(MSR_IA32_VMX_BASIC) & IA32_VMXBASIC_USELESS_CTL_MASKS) {
> > -		pinxctl = (uint32_t)kvm_rdmsr(MSR_IA32_VMX_PINX_MASK2);
> > -		execctl = (uint32_t)kvm_rdmsr(MSR_IA32_VMX_EXECCTL_MASK2);
> > -		exitctl = (uint32_t)kvm_rdmsr(MSR_IA32_VMX_EXITCTL_MASK2);
> > -		entryctl = (uint32_t)kvm_rdmsr(MSR_IA32_VMX_ENTRYCTL_MASK2);
> > -	} else {
> > -		pinxctl = (uint32_t)kvm_rdmsr(MSR_IA32_VMX_PINX_MASK);
> > -		execctl = (uint32_t)kvm_rdmsr(MSR_IA32_VMX_EXECCTL_MASK);
> > -		exitctl = (uint32_t)kvm_rdmsr(MSR_IA32_VMX_EXITCTL_MASK);
> > -		entryctl = (uint32_t)kvm_rdmsr(MSR_IA32_VMX_ENTRYCTL_MASK);

The rest of the patchset merged, thank you!

> I guess you're going to use in the future MSR_IA32_VMX_PINX_MASK2 and other
> deleted masks (because now they are IMHO only in the structs).

If you don't need the constants in the future, please remove it in a subsequent
patch.

Kind regards,
Petr

> Acked-by: Petr Vorel <pvorel@suse.cz>

> Kind regards,
> Petr

> > -	}
> > +	pinxctl = (uint32_t)kvm_vmx_read_vmctl_mask(VMX_CTLMASK_PINX);
> > +	execctl = (uint32_t)kvm_vmx_read_vmctl_mask(VMX_CTLMASK_EXECCTL);
> > +	exitctl = (uint32_t)kvm_vmx_read_vmctl_mask(VMX_CTLMASK_EXITCTL);
> > +	entryctl = (uint32_t)kvm_vmx_read_vmctl_mask(VMX_CTLMASK_ENTRYCTL);

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
