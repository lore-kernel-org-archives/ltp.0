Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BBFDC021BC
	for <ltp@archiver.kernel.org>; Mon, 24 Feb 2025 16:56:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 819C33C9A18
	for <ltp@archiver.kernel.org>; Mon, 24 Feb 2025 17:56:22 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DFCE63C9948
 for <ltp@lists.linux.it>; Mon, 24 Feb 2025 17:56:05 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6F8A61425D75
 for <ltp@lists.linux.it>; Mon, 24 Feb 2025 17:56:05 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id ADDCF1F445;
 Mon, 24 Feb 2025 16:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740416164; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hU+O56eogVrJ5kuSs0IffRUEfs2SNdX3aUxjInFHekg=;
 b=lHTRHntHjYNFZPmpsSI4nv5+c4EB3YWdtECfF0DuRxGYAXRWi1WPa8vpBlYGl2ylT3yIEK
 hPqozdd9XmIypO9pUbyNbsBogX3LU+FJeKfq0X3xp1OtLzXXYkT6vm+Qzh5RDGO1aMxgd/
 kGOkdqw8XDM2Ipv919XwnpEr6imLaik=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740416164;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hU+O56eogVrJ5kuSs0IffRUEfs2SNdX3aUxjInFHekg=;
 b=88JE4L+kGY5TP99Md2lfw7H23q/T0k865uqF2CkogrdNBKAVVK0rVILn4r2563+e+mH2ak
 heDj4yEIYMEiTLBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740416164; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hU+O56eogVrJ5kuSs0IffRUEfs2SNdX3aUxjInFHekg=;
 b=lHTRHntHjYNFZPmpsSI4nv5+c4EB3YWdtECfF0DuRxGYAXRWi1WPa8vpBlYGl2ylT3yIEK
 hPqozdd9XmIypO9pUbyNbsBogX3LU+FJeKfq0X3xp1OtLzXXYkT6vm+Qzh5RDGO1aMxgd/
 kGOkdqw8XDM2Ipv919XwnpEr6imLaik=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740416164;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hU+O56eogVrJ5kuSs0IffRUEfs2SNdX3aUxjInFHekg=;
 b=88JE4L+kGY5TP99Md2lfw7H23q/T0k865uqF2CkogrdNBKAVVK0rVILn4r2563+e+mH2ak
 heDj4yEIYMEiTLBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8F08613332;
 Mon, 24 Feb 2025 16:56:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7OPdIKSkvGfhdwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 24 Feb 2025 16:56:04 +0000
Date: Mon, 24 Feb 2025 17:56:15 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Z7ykr8it7KmHjWsY@yuki.lan>
References: <20250210-mmap_suite_refactoring-v2-0-6edea3a4363a@suse.com>
 <20250210-mmap_suite_refactoring-v2-1-6edea3a4363a@suse.com>
 <20250210094141.GA1826068@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250210094141.GA1826068@pevik>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/8] Refactor mmap03 test
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
Cc: ltp@lists.linux.it, rbm@suse.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> @Cyril? Should we keep only mips? And I strongly suspect nobody is testing LTP
> on mips, but we should probably not kill a still living arch.
> If all these archs removed whole fork could be removed.

The fact that memory mapped with PROT_EXEC is readable is an
implementation detail for an architecture and not guaranteed. So the
best result is either to expect that the child returns with 0 or dies
with SIGSEGV, either one is correct behavior.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
