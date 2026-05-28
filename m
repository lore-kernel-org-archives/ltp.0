Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1B25CD4F54
	for <ltp@archiver.kernel.org>; Thu, 28 May 2026 13:05:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3AEF13D000B
	for <ltp@archiver.kernel.org>; Thu, 28 May 2026 15:05:36 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C38A73CDEF2
 for <ltp@lists.linux.it>; Thu, 28 May 2026 15:05:19 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3D1701A00EFE
 for <ltp@lists.linux.it>; Thu, 28 May 2026 15:05:18 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 78D1C66DBE;
 Thu, 28 May 2026 13:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1779973512;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nvHncrn/JDvc1rNAT0mCnOZ4OvvNBJrczqRTh1/5zfg=;
 b=jmYYC21PuIfOArRsVIcWkxPrC1laGDO3X9SeqeimsPsgXzhuN0gpIzu0NN3pzRO4uNyOFN
 kjzOkjIme+fm648mqfQV/u057lTN/QrL57zfU9ZVBYJIxI+acj1qKOvX9Zb8PZ1ZVaRZhp
 u7xrPSopGw5yBWVQb5vgBuC5JdOzky8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1779973512;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nvHncrn/JDvc1rNAT0mCnOZ4OvvNBJrczqRTh1/5zfg=;
 b=xuK0b4iRxR1edlAsyZPq6d3uqzIqi1dKllmNouaqniVMuWZEGhSOZSaupQ79xL6ILIaGbO
 +DA5XiE2nJmTY4Cg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1779973512;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nvHncrn/JDvc1rNAT0mCnOZ4OvvNBJrczqRTh1/5zfg=;
 b=jmYYC21PuIfOArRsVIcWkxPrC1laGDO3X9SeqeimsPsgXzhuN0gpIzu0NN3pzRO4uNyOFN
 kjzOkjIme+fm648mqfQV/u057lTN/QrL57zfU9ZVBYJIxI+acj1qKOvX9Zb8PZ1ZVaRZhp
 u7xrPSopGw5yBWVQb5vgBuC5JdOzky8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1779973512;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nvHncrn/JDvc1rNAT0mCnOZ4OvvNBJrczqRTh1/5zfg=;
 b=xuK0b4iRxR1edlAsyZPq6d3uqzIqi1dKllmNouaqniVMuWZEGhSOZSaupQ79xL6ILIaGbO
 +DA5XiE2nJmTY4Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4152E5ADCE;
 Thu, 28 May 2026 13:05:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id J+MVDog9GGp4JgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 28 May 2026 13:05:12 +0000
Date: Thu, 28 May 2026 15:05:10 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260528130510.GA407918@pevik>
References: <20260528102757.398375-1-pvorel@suse.cz>
 <ahgtlv9bJDOnN9xI@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ahgtlv9bJDOnN9xI@yuki.lan>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] checkpatch: Disable more kernel specific
 checks
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

Hi Cyril, Andrea,

thanks for your ack, merged.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
