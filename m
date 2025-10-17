Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB60BCCD199
	for <ltp@archiver.kernel.org>; Fri, 17 Oct 2025 16:20:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4D32C3CEEB9
	for <ltp@archiver.kernel.org>; Fri, 17 Oct 2025 18:20:32 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D8FB63CE6D3
 for <ltp@lists.linux.it>; Fri, 17 Oct 2025 18:20:17 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 389F11000745
 for <ltp@lists.linux.it>; Fri, 17 Oct 2025 18:20:16 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9DED521D71;
 Fri, 17 Oct 2025 16:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1760718015;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RSnDC/rz6vBYJqqan3RF8PSOFCOvXhF724CL2Xh12uc=;
 b=k8G07oFYKI1/cQVbh81suZ03yuSFbmubkuYRXFXdsuRzh9mZCfdIb1dvlEVKG3I47f2c++
 3DLUw9B9CeRuY3BTOb3CtcCigYaZeD/0lRwGhFdnGuM4Gik5/Zk+8mQzzQAoBlrP715pDW
 VYU3UUHsZsGpyhP+5/hVPQK0BX8yWAY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1760718015;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RSnDC/rz6vBYJqqan3RF8PSOFCOvXhF724CL2Xh12uc=;
 b=kRsGn4tFtCYmjr08DJ02BSxTtXZ2SGXJsNyWbR8rzSnjsLNqEUrAhv6pOmnz7oNYaHhQN2
 fTDi+c8ve8mXwFAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=k8G07oFY;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=kRsGn4tF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1760718015;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RSnDC/rz6vBYJqqan3RF8PSOFCOvXhF724CL2Xh12uc=;
 b=k8G07oFYKI1/cQVbh81suZ03yuSFbmubkuYRXFXdsuRzh9mZCfdIb1dvlEVKG3I47f2c++
 3DLUw9B9CeRuY3BTOb3CtcCigYaZeD/0lRwGhFdnGuM4Gik5/Zk+8mQzzQAoBlrP715pDW
 VYU3UUHsZsGpyhP+5/hVPQK0BX8yWAY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1760718015;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RSnDC/rz6vBYJqqan3RF8PSOFCOvXhF724CL2Xh12uc=;
 b=kRsGn4tFtCYmjr08DJ02BSxTtXZ2SGXJsNyWbR8rzSnjsLNqEUrAhv6pOmnz7oNYaHhQN2
 fTDi+c8ve8mXwFAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E3C8B136C6;
 Fri, 17 Oct 2025 16:20:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id DABVM75s8mjcRAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 17 Oct 2025 16:20:14 +0000
Date: Fri, 17 Oct 2025 18:20:13 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Ben Copeland <ben.copeland@linaro.org>
Message-ID: <20251017162013.GA351168@pevik>
References: <20251016140303.1645478-1-ben.copeland@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251016140303.1645478-1-ben.copeland@linaro.org>
X-Rspamd-Queue-Id: 9DED521D71
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCPT_COUNT_SEVEN(0.00)[8];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.cz:+]; MISSING_XM_UA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] oom03: use size_t for memory length to fix 32-bit
 overflow
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
Cc: arnd@arndb.de, lkft-triage@lists.linaro.org, ltp@lists.linux.it,
 dan.carpenter@linaro.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> The alloc_mem() function is supposed to test out of memory conditions.
> How it works is it calls mmap() on a giant chunk of memory.
> It's either LENGTH (2GB) or "TESTMEM * 2 + TST_MB" (3GB) bytes.
> This mmap() is generally supposed to succeed.  Then at the bottom of
> the alloc_mem() function when we actually try to use all the memory,
> the thread is supposed to die with a SIGKILL.

> The problem is that length is signed so on a 32-bit system it will be
> negative. That means that at the bottom of the function when we loop
> through the memory, the for loop is a no-op and there is no SIGKILL.
> Fix this by changing the type to size_t which is unsigned.

I dared to change subject to oom.h and merged.
Thanks!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
