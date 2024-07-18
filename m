Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B12B4C3DA60
	for <ltp@archiver.kernel.org>; Thu, 18 Jul 2024 12:43:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B2F9C3D1B10
	for <ltp@archiver.kernel.org>; Thu, 18 Jul 2024 14:43:22 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A162D3D0B1D
 for <ltp@lists.linux.it>; Thu, 18 Jul 2024 14:43:07 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id EFDC8603474
 for <ltp@lists.linux.it>; Thu, 18 Jul 2024 14:43:06 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B00551FBCD;
 Thu, 18 Jul 2024 12:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721306584;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+826BXPIZ2JzKCFjX4yV0SaoKL62FkTHRBDnKW7SHpc=;
 b=GYBpZ8M1yhSIJAraPsGGO/68W8pWGizn4ItzB4Zpy4Qh5SqLGBViN1u4FBqbS/A6pAUWUJ
 U/jPce4twAuug1YGjtmQ25ndwUy4pFxZlEtd+E/JYH3eeMGoPcSvk1bVjZhFnYzUtlEzjC
 RDoUy5jHgmxx97A9XUb5q5Pyw1eom3Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721306584;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+826BXPIZ2JzKCFjX4yV0SaoKL62FkTHRBDnKW7SHpc=;
 b=Z2hd0nzwhW29Md1LmtZrJ1fqSDakAnKyt3gA9nYIS8pnKWTnQ+5SJCwraTIUNayHYxQ/WG
 sZrzoYAUlO2KDHAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721306584;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+826BXPIZ2JzKCFjX4yV0SaoKL62FkTHRBDnKW7SHpc=;
 b=GYBpZ8M1yhSIJAraPsGGO/68W8pWGizn4ItzB4Zpy4Qh5SqLGBViN1u4FBqbS/A6pAUWUJ
 U/jPce4twAuug1YGjtmQ25ndwUy4pFxZlEtd+E/JYH3eeMGoPcSvk1bVjZhFnYzUtlEzjC
 RDoUy5jHgmxx97A9XUb5q5Pyw1eom3Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721306584;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+826BXPIZ2JzKCFjX4yV0SaoKL62FkTHRBDnKW7SHpc=;
 b=Z2hd0nzwhW29Md1LmtZrJ1fqSDakAnKyt3gA9nYIS8pnKWTnQ+5SJCwraTIUNayHYxQ/WG
 sZrzoYAUlO2KDHAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5BF13136F7;
 Thu, 18 Jul 2024 12:43:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hvjCEtgNmWbodQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 18 Jul 2024 12:43:04 +0000
Date: Thu, 18 Jul 2024 14:43:02 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240718124302.GA738326@pevik>
References: <20240716153604.22984-1-chrubis@suse.cz>
 <20240716153604.22984-2-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240716153604.22984-2-chrubis@suse.cz>
X-Spamd-Result: default: False [0.50 / 50.00]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.994]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/2] Add support for mixing C and shell code
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgYWxsLAoKb25lIG1vcmUgdGhpbmcgdG8gZml4IChvciBkaWQgSSBvdmVybG9vayB0aGUgZGlz
Y3Vzc2lvbik/Cgp0c3RfdGVzdC5jOiBJbiBmdW5jdGlvbiDigJh0c3RfcnVuX3NoZWxs4oCZOgp0
c3RfdGVzdC5jOjE5NjoyOiBlcnJvcjogdmFyaWFibGUtc2l6ZWQgb2JqZWN0IG1heSBub3QgYmUg
aW5pdGlhbGl6ZWQKICBjaGFyICphcmd2W3BhcmFtc19sZW4gKyAyXSA9IHt9OwogIF5+fn4KCkZv
dW5kIG9uIGdjYyBpbiBTTEVTIDE1LVNQNjoKZ2NjIC0tdmVyc2lvbgpnY2MgKFNVU0UgTGludXgp
IDcuNS4wCgpLaW5kIHJlZ2FyZHMsClBldHIKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6
Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
