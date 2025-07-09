Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6624DC83F03
	for <ltp@archiver.kernel.org>; Wed,  9 Jul 2025 14:29:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9CBE33CAD60
	for <ltp@archiver.kernel.org>; Wed,  9 Jul 2025 16:29:34 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A55F03C8C3D
 for <ltp@lists.linux.it>; Wed,  9 Jul 2025 16:29:17 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 40196609251
 for <ltp@lists.linux.it>; Wed,  9 Jul 2025 16:29:16 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C473621189;
 Wed,  9 Jul 2025 14:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1752071355; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UqiWEM1o0u2Nn/d0a4qko+Jn+tbGFGDbhIZDSNz/6n8=;
 b=BEdzVAqiGNoN1DAq9Kgegkmsla9miXfVcgACh3YVZq/f+8xJOH2LxQacod3z+FDpcJrt3T
 HEaeEIyY0Ib4B8agvk+xhvg8mAN65DcQ9mnrd9YShtFHi0htTgVpFQszJHkGeKi33Re68x
 C3Fc7q+lVfByb3xQQz57/+BC0qnyI/I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1752071355;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UqiWEM1o0u2Nn/d0a4qko+Jn+tbGFGDbhIZDSNz/6n8=;
 b=X49ZjMB4CZ77m+YAbwXQAzQoxjmA/4nPYpNZbVZj+v00Sud9TauyXSDlqFxV/dqGx0cTBg
 bJFrmSnowHkKUhCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1752071355; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UqiWEM1o0u2Nn/d0a4qko+Jn+tbGFGDbhIZDSNz/6n8=;
 b=BEdzVAqiGNoN1DAq9Kgegkmsla9miXfVcgACh3YVZq/f+8xJOH2LxQacod3z+FDpcJrt3T
 HEaeEIyY0Ib4B8agvk+xhvg8mAN65DcQ9mnrd9YShtFHi0htTgVpFQszJHkGeKi33Re68x
 C3Fc7q+lVfByb3xQQz57/+BC0qnyI/I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1752071355;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UqiWEM1o0u2Nn/d0a4qko+Jn+tbGFGDbhIZDSNz/6n8=;
 b=X49ZjMB4CZ77m+YAbwXQAzQoxjmA/4nPYpNZbVZj+v00Sud9TauyXSDlqFxV/dqGx0cTBg
 bJFrmSnowHkKUhCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B1C5613757;
 Wed,  9 Jul 2025 14:29:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id fco3Krt8bmgUbwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 09 Jul 2025 14:29:15 +0000
Date: Wed, 9 Jul 2025 16:29:46 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <aG582lBkqZkluIO5@yuki.lan>
References: <20250708-new-munmap04-v4-1-884f774179b1@suse.com>
 <ee61b370-13cd-4467-80d1-c38645592e69@suse.com>
 <DB6NP2I9LBC5.3PSVD9Z735NLY@suse.com>
 <a2c5a454-38fb-4d2c-b9f5-ae6e58615875@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a2c5a454-38fb-4d2c-b9f5-ae6e58615875@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] syscalls: munmap: Add munmap04 to check ENOMEM
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
Cc: Linux Test Project <ltp@lists.linux.it>,
 Ricardo =?iso-8859-1?Q?B=2E_Marli=E8re?= <rbm@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> The alternative is to set the value and using tst_test.save_restore

Yes please, that's what the save_restore is for.

Setting ithe max_map_count to reasonable value shoudl work for
everything, e.g. 65536 should be large enough for the system and
reasonable for the test as well.

AFAIK the value we have on tumbleweed was adjusted just because of Steam
and the rest of the system works fine with much smaller value.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
