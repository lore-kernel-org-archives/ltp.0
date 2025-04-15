Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA6CEC369AB
	for <ltp@archiver.kernel.org>; Tue, 15 Apr 2025 13:56:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 12B103CB8BA
	for <ltp@archiver.kernel.org>; Tue, 15 Apr 2025 15:56:17 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 57D113C2EFD
 for <ltp@lists.linux.it>; Tue, 15 Apr 2025 15:56:00 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 37C72600D6F
 for <ltp@lists.linux.it>; Tue, 15 Apr 2025 15:56:00 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A34D3210F9;
 Tue, 15 Apr 2025 13:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744725359; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2QcVNJiPSDZehsdoQkw77GAMXj4/ZXqtiIzpMKQdE3Q=;
 b=0NgxiCodnUuBTo2Nmt8yAc7SyO3rnFXV1I9DnkYmx+f9REQPC39I4mBEZGlP5rpeEpFOaB
 N3HvGmWsSq8ozIajCfos71tTkIYLKVoV2ypWTkVCAN+KkRf5k+6lAtc07e8WrIsMa5v7g8
 cG0rfGRViSaofXPX2JDINFfiu01kFhU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744725359;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2QcVNJiPSDZehsdoQkw77GAMXj4/ZXqtiIzpMKQdE3Q=;
 b=Ej0syXHw90topZVgdLdHroPsUpyqGLMNEike6hq4/hRItQLjlgcKcuTLmizibZgFQNZdJa
 bDq0BDg71PPc7UCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744725359; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2QcVNJiPSDZehsdoQkw77GAMXj4/ZXqtiIzpMKQdE3Q=;
 b=0NgxiCodnUuBTo2Nmt8yAc7SyO3rnFXV1I9DnkYmx+f9REQPC39I4mBEZGlP5rpeEpFOaB
 N3HvGmWsSq8ozIajCfos71tTkIYLKVoV2ypWTkVCAN+KkRf5k+6lAtc07e8WrIsMa5v7g8
 cG0rfGRViSaofXPX2JDINFfiu01kFhU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744725359;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2QcVNJiPSDZehsdoQkw77GAMXj4/ZXqtiIzpMKQdE3Q=;
 b=Ej0syXHw90topZVgdLdHroPsUpyqGLMNEike6hq4/hRItQLjlgcKcuTLmizibZgFQNZdJa
 bDq0BDg71PPc7UCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9DD5C13A9F;
 Tue, 15 Apr 2025 13:55:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id vPR1Jm9l/mcuMAAAD6G6ig
 (envelope-from <pvorel@suse.de>); Tue, 15 Apr 2025 13:55:59 +0000
MIME-Version: 1.0
Date: Tue, 15 Apr 2025 15:55:59 +0200
From: pvorel <pvorel@suse.de>
To: Andrea Cervesato <andrea.cervesato@suse.de>
In-Reply-To: <20250415-patchwork_ci-v6-4-81e6d4184af5@suse.com>
References: <20250415-patchwork_ci-v6-0-81e6d4184af5@suse.com>
 <20250415-patchwork_ci-v6-4-81e6d4184af5@suse.com>
User-Agent: Roundcube Webmail
Message-ID: <63a9197d069e6a7eca6dbe00b1b933c7@suse.de>
X-Sender: pvorel@suse.de
X-Spamd-Result: default: False [-8.29 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.988]; MIME_GOOD(-0.10)[text/plain];
 XM_UA_NO_VERSION(0.01)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 4/4] ci: apply patchwork series in
 ci-docker-build workflow
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Thanks for whole patchset.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
