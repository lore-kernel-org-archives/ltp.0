Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8102FC10F1A
	for <ltp@archiver.kernel.org>; Tue,  7 May 2024 14:59:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A2F633CDCD5
	for <ltp@archiver.kernel.org>; Tue,  7 May 2024 16:59:54 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8E0BC3CDB74
 for <ltp@lists.linux.it>; Tue,  7 May 2024 16:59:39 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2080B204B69
 for <ltp@lists.linux.it>; Tue,  7 May 2024 16:59:38 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 69BF6340AC;
 Tue,  7 May 2024 14:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715093978;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RiFEtsKXWKidVJ1btkvQqy5wD4rZX+3crq4zLQY11OY=;
 b=A56BEdu3I8hfJ18Wnwqs+Tzl8+yOT01Kaz2tP49OS/bHdJJo0SliPUydgw06kk6n/owMCf
 QMbIANYyGUAfM2FUSrO/KpY6VuTae9BrFfxgu73gO4XUx699TMp/+a67T0k4TQqp2FpWEq
 wFTuqK9+aUxPZSEt5OD8xSI6CxY0y20=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715093978;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RiFEtsKXWKidVJ1btkvQqy5wD4rZX+3crq4zLQY11OY=;
 b=IWcn43PlX6NlYFI9HcV0UgXm1DYduX8wI2ASE4FD7HapIKxX156yNxJJXIQN+1HOxCF1eF
 frcQqtxmQly3MFBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715093978;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RiFEtsKXWKidVJ1btkvQqy5wD4rZX+3crq4zLQY11OY=;
 b=A56BEdu3I8hfJ18Wnwqs+Tzl8+yOT01Kaz2tP49OS/bHdJJo0SliPUydgw06kk6n/owMCf
 QMbIANYyGUAfM2FUSrO/KpY6VuTae9BrFfxgu73gO4XUx699TMp/+a67T0k4TQqp2FpWEq
 wFTuqK9+aUxPZSEt5OD8xSI6CxY0y20=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715093978;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RiFEtsKXWKidVJ1btkvQqy5wD4rZX+3crq4zLQY11OY=;
 b=IWcn43PlX6NlYFI9HcV0UgXm1DYduX8wI2ASE4FD7HapIKxX156yNxJJXIQN+1HOxCF1eF
 frcQqtxmQly3MFBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B9AF513A3C;
 Tue,  7 May 2024 14:59:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id nElFJNlBOmY2SgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 07 May 2024 14:59:37 +0000
Date: Tue, 7 May 2024 16:59:35 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20240507145935.GB144380@pevik>
References: <20240430122208.13043-1-mdoucha@suse.cz>
 <20240430122208.13043-10-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240430122208.13043-10-mdoucha@suse.cz>
X-Spamd-Result: default: False [-3.45 / 50.00]; BAYES_HAM(-2.95)[99.79%];
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:replyto];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 9/9] KVM: Move kvm_pagefault01 to the end of KVM
 runfile
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

> The kvm_pagefault01 test reloads the KVM module with special parameters
> which may change kernel code paths and hide open bugs from other KVM
> tests. Move the test to the end of KVM schedule to prevent interference.

Merged rebased, as we discussed at the first patch. Thanks!

On a brief look the other patches looks very well (apart from that clang issue),
but I need some time for actual review.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
