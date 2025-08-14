Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E889CA0ED1
	for <ltp@archiver.kernel.org>; Thu, 14 Aug 2025 04:35:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A44683CBAF5
	for <ltp@archiver.kernel.org>; Thu, 14 Aug 2025 06:35:45 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 292663C018D
 for <ltp@lists.linux.it>; Thu, 14 Aug 2025 06:35:29 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 01EBA600733
 for <ltp@lists.linux.it>; Thu, 14 Aug 2025 06:35:28 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8F7001F7C7;
 Thu, 14 Aug 2025 04:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1755146126;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k8jg9jj19dEsMJKIKSklzz68abJsQQuw81F4ldHYkxU=;
 b=gMuRYhWNsRuD1omk07SS0m6xE44/MG1czbTCQeBgJL1LJ0CQasGg5trJ4YufOjj2LKoTgQ
 M1DKAFRihdtc5ouwftg8+Uf1PyIxo7RUZzWo7lg7wglyHM6obyZZ7wxLRBgzPcTxZb1mbp
 oCrLcybE9kNZbmSrQGdF56nSgV0LAFI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1755146126;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k8jg9jj19dEsMJKIKSklzz68abJsQQuw81F4ldHYkxU=;
 b=/h9sec/tQu+T4phrBJqmqxXNxVAMpc6RBoIkglu0QHbJpfYl7/PovwKIGYALE/CfcXc0RA
 DHWwmifnejR+80DA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1755146125;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k8jg9jj19dEsMJKIKSklzz68abJsQQuw81F4ldHYkxU=;
 b=sITlGcqQsveCV3HqZBvCdH2CfV71lWZhdwGz22hlAUVbUctMaMR1Pr3AxK2DB+wEMlKOCE
 Rb/qmmEkrRq7dYNzdyBw1yBDzcZK4CJ7QUvbVI7FlV8qpTu15ZAp5bYjEBDzoWnT8ZRf3X
 1nMH1C1xr44pz9qsqezZ+3GoY0vIBko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1755146125;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k8jg9jj19dEsMJKIKSklzz68abJsQQuw81F4ldHYkxU=;
 b=1RX8UgO27heCRAEU2PDZVr0/6EkvJTBoDhBJNjqMwf5O6rzIUoPRdeJUB8GHG93ezPonSK
 xDjf4ilJcqSPqVDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7AF171368C;
 Thu, 14 Aug 2025 04:35:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zkX/HI1nnWjITwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 14 Aug 2025 04:35:25 +0000
Date: Thu, 14 Aug 2025 06:35:20 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>, ltp@lists.linux.it
Message-ID: <20250814043520.GB916683@pevik>
References: <20250718-doc_kvm_tests-v1-1-47519ff26d62@suse.com>
 <20250730170913.GB673913@pevik> <20250812045518.GA797597@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250812045518.GA797597@pevik>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCPT_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] doc: add kvm tests documentation
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

Hi Andrea,

> Hi Andrea,

> could you please merge your docs? I'll do suggested fixes afterwards.
> Because currently we have KVM doc just an empty file:

> https://linux-test-project.readthedocs.io/en/latest/developers/api_kvm_tests.html

> And we cannot expect users would find doc/old/ content.

I dared to merge your patchset. I'll implement my suggestions.
Thanks!

Kind regards,
Petr

> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
