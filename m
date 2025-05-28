Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE46FC3ABB2
	for <ltp@archiver.kernel.org>; Wed, 28 May 2025 13:19:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 71F813C7706
	for <ltp@archiver.kernel.org>; Wed, 28 May 2025 15:19:48 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F2EE73C1CBE
 for <ltp@lists.linux.it>; Wed, 28 May 2025 15:19:32 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0107214010D5
 for <ltp@lists.linux.it>; Wed, 28 May 2025 15:19:31 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 823721F79C;
 Wed, 28 May 2025 13:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1748438370; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hReEEcmaeKDogFbH3W3iCODtjGUsdEwQqUINVjKR6jc=;
 b=nqMPT3gZY2MWqieQExjv0Y5UbwnlETlECP55dXSSDc7Lp1gnNRHLU3tRyIaEs2jsPtUQm8
 bLCyVaIwJu+Km1I3GfUYDxkP7iJJc6S3d5e34j1dxwlwmlnlyE5xymapT/ZnZd9GZA0x7l
 Datme1bCtq/NJSODc3J17/gi5XqpVSc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1748438370;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hReEEcmaeKDogFbH3W3iCODtjGUsdEwQqUINVjKR6jc=;
 b=yasUTgnGCFeilaAUa+QLWtBvNsGmzGx1YvhCinNm0D2pIvIh7ItHWp99MGJvJ5XiC0HNlT
 eSSCS+9k8i+YnGDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1748438370; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hReEEcmaeKDogFbH3W3iCODtjGUsdEwQqUINVjKR6jc=;
 b=nqMPT3gZY2MWqieQExjv0Y5UbwnlETlECP55dXSSDc7Lp1gnNRHLU3tRyIaEs2jsPtUQm8
 bLCyVaIwJu+Km1I3GfUYDxkP7iJJc6S3d5e34j1dxwlwmlnlyE5xymapT/ZnZd9GZA0x7l
 Datme1bCtq/NJSODc3J17/gi5XqpVSc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1748438370;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hReEEcmaeKDogFbH3W3iCODtjGUsdEwQqUINVjKR6jc=;
 b=yasUTgnGCFeilaAUa+QLWtBvNsGmzGx1YvhCinNm0D2pIvIh7ItHWp99MGJvJ5XiC0HNlT
 eSSCS+9k8i+YnGDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 72EF0136E3;
 Wed, 28 May 2025 13:19:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eMFvG2INN2hUNwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 28 May 2025 13:19:30 +0000
Date: Wed, 28 May 2025 15:19:54 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <aDcNer6dHSI2bveR@yuki.lan>
References: <20250527094415.4760-1-andrea.cervesato@suse.de>
 <CAEemH2eGQP6k1cSDH42c=ZXLHtXdekDh5H_nWSr0o1_=j1i8ug@mail.gmail.com>
 <81a131e7-acef-4aa4-b1f2-97dc30c45983@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <81a131e7-acef-4aa4-b1f2-97dc30c45983@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] kirk: version 2.1
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
> thanks! I guess we can add it to the kirk project under "tools" folder.
> Feel free to send a PR in the kirk project.

So are we going to wait for the PR to get merged before we update the
submodule or do we merge this patch? I'm fine with either one, but I
have to tag the release on Friday.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
