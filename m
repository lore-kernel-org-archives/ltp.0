Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73A2CC3DA63
	for <ltp@archiver.kernel.org>; Wed, 24 Jul 2024 14:59:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 98D303D1C35
	for <ltp@archiver.kernel.org>; Wed, 24 Jul 2024 16:59:29 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C46E53D1A55
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 16:59:13 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1D55A61664C
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 16:59:12 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 57E521F7A8;
 Wed, 24 Jul 2024 14:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721833151; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fYynGlp45gAyEHPtQc7LqOwKOsGCz0nG4doh6n3eDn0=;
 b=PESCHuInidUl8WQLaoPgiuYGJ3hNYIyv3GKcdIsCREtCEv2qOpaEnNZzmN0VqlEwqo7YOV
 cK4J/OiHG3dfQ97LKRexc1UCyUq9qu2oAZic5nqxBxiW6adhFChemSXwGHs0+MwEowKCpr
 z6WLjBWDnTl/lNpx0x5a1VXHqOWwo8c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721833151;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fYynGlp45gAyEHPtQc7LqOwKOsGCz0nG4doh6n3eDn0=;
 b=HDga5K6WotMXzscLfLjej9KYmv8LGTKW+ypsQNIKFmQpJREGXWSeFcuFA4BW1lw7eXtkA2
 97TZUbsly6p+HVCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721833150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fYynGlp45gAyEHPtQc7LqOwKOsGCz0nG4doh6n3eDn0=;
 b=aXt9pVHWqQDf1mdZCllVDMLi33E7tWbb3ZfaK1O+ZyAkVUit1qS79zoWyKOUCCzrBDbMIY
 C8KSPKZxInNK30FB1UTRV+vQHs+2eS0v8kdAV+uWZ8esDg9EYVmmN+4hS1R/xwM4fKYkfo
 uSpWeZgOr0rm9v6xb2+C8uMUiaV/A8k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721833150;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fYynGlp45gAyEHPtQc7LqOwKOsGCz0nG4doh6n3eDn0=;
 b=6vq1LURnIkQu1eG1fnI9SwFYepPoatlKLEi3cIOOSyPOp97VsvG0dA7PR6PpuriwDOq0Vn
 yKQlpN5MwhCbPNAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 456921324F;
 Wed, 24 Jul 2024 14:59:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 01D+D74WoWY5LwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 24 Jul 2024 14:59:10 +0000
Date: Wed, 24 Jul 2024 16:58:37 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <ZqEWnS9zi84z2CL2@yuki>
References: <20240723-mseal-v2-0-5aa872d611bc@suse.com>
 <20240723-mseal-v2-1-5aa872d611bc@suse.com> <ZqDkjOCm2VqO2Vq_@yuki>
 <9cad4b74-5e2f-4b35-88f0-f20467a9a2d2@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9cad4b74-5e2f-4b35-88f0-f20467a9a2d2@suse.com>
X-Spamd-Result: default: False [-3.60 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 MIME_GOOD(-0.10)[text/plain]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCPT_COUNT_THREE(0.00)[3]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] Add mseal() syscall declaration
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
> I can send v3 if needed.

But that would solve only mseal() and the fhcmodat2() has the same
collision and would need a v3 that would apply on the top of mseal().
The syscall in files are unfortunatelly contetion point so I'm
suggesting to add all the definitions you are going to need in a single
patch instead.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
