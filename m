Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF329C55ABF
	for <ltp@archiver.kernel.org>; Thu,  6 Aug 2026 11:52:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4533D3E4B75
	for <ltp@archiver.kernel.org>; Thu,  6 Aug 2026 13:52:30 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F03073E2BC0
 for <ltp@lists.linux.it>; Thu,  6 Aug 2026 13:52:15 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4D295100034E
 for <ltp@lists.linux.it>; Thu,  6 Aug 2026 13:52:15 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 927D87FFE0;
 Thu,  6 Aug 2026 11:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786017130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pY/wn4V6mJz0cRvwtO9oF1mjwoAYaGktD6kuD3eqOko=;
 b=i8x5/Ro4iUCX333jmn7d6u1VJWMc3xnZW+ADK3H7+gfj/EsnomDshv0VtQBQbK5Z63W+Bf
 XLxN3G7Q5fV08JXcF1dnNx6xdgvbyYWxpO4gehlLAuhBxb3vGsLIuSyQR9XgQx6ptlSA/w
 SQk9DR5EHn87Jdf61emVbRN3Oo+BRvo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786017130;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pY/wn4V6mJz0cRvwtO9oF1mjwoAYaGktD6kuD3eqOko=;
 b=F+eg1ez68U5J7kj68G7TjQ4w+B+JUS1vpSVcWxtZbcMaF3VGmLAbOj/+mHcrJo0k84zXFz
 El04153OZ3eKRoCw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="n/UDYsMC";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=e2cW8ZWV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786017126; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pY/wn4V6mJz0cRvwtO9oF1mjwoAYaGktD6kuD3eqOko=;
 b=n/UDYsMCACdnFSKN7WiTyBhC2j2gv+hbsENPOpO/pAiQTBsBWI0R8LXclPVVL48xfnyNxG
 cjvFe4/0YDP/WOB/Cqd3Yl+rWabnvWtjKR4+mwffJ3qawJItXuwOWIitaQcpnqpz61YZAh
 wxvntq2SFauSX3FfSzsocC93IGUsvT8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786017126;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pY/wn4V6mJz0cRvwtO9oF1mjwoAYaGktD6kuD3eqOko=;
 b=e2cW8ZWVsW9dcAufRVxjUx9JzGX3ZA7U9chbuQtYW3m+RnTPnmdEtrN8RUuk2HmptJjrbd
 NGkT8wQwk+O6bCCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 834BA779B6;
 Thu,  6 Aug 2026 11:52:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id nHyEH2Z1dGqzOgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 06 Aug 2026 11:52:06 +0000
Date: Thu, 6 Aug 2026 13:50:58 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <anR1Is0EQYGj6nvv@rei>
References: <20260721-rewrite_mremap_testing_suite-v1-0-ec2c3cff6ea4@suse.com>
 <20260721-rewrite_mremap_testing_suite-v1-2-ec2c3cff6ea4@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260721-rewrite_mremap_testing_suite-v1-2-ec2c3cff6ea4@suse.com>
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: 927D87FFE0
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/5] mremap02: Convert to new API
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> -	/* Set the old virtual memory address */
> -	addr = (char *)(addr + (memsize - 1));
> +	if (TST_RET_PTR != MAP_FAILED)
> +		SAFE_MUNMAP(TST_RET_PTR, new_size);

If we managed to remap the mapping the addr is no loger valid and we
will pass address that is not inside a mapping on next iteration in -i
10, I guess that we need to re-initialize page = SAFE_MMAP() and
bad_addr = page+1;


Otherwise:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
