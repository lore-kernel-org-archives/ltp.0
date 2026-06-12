Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E21D4CD98CF
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 16:37:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 281193E6A5A
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 18:37:10 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2C0B83E5E62
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 18:36:52 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1DDEF600BA4
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 18:36:51 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 553DE77A8C;
 Fri, 12 Jun 2026 14:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1781275649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kkd7GIlC3Dt/WTz3TcUT4PnnzDQKYLVRYf4zS/I9dOQ=;
 b=TDan6/UoEJqoBqjBlzwm70o+e58JFE38gxcVUTNLjHRuSgDu6DM58b2Fid00ITTtS6utn+
 3dTKZOxr+dtdLmhfVhdFTjzdtw8fo5OE0Bueuy8wTnkOgfJNvvmh2zp6jQbf1kDhKBa43H
 c4y+uCDyI3p+E+Je6ptMz/m9ZGdJefI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1781275649;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kkd7GIlC3Dt/WTz3TcUT4PnnzDQKYLVRYf4zS/I9dOQ=;
 b=xF544P7FuZ/yNCC/0RHJOiTDa4Ys7sKKm2/nFs5eZW1xw+n69cr2M+qgrriXp34azbl1Fi
 s4wmgJcGYr8f4CDA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="TDan6/Uo";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=xF544P7F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1781275649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kkd7GIlC3Dt/WTz3TcUT4PnnzDQKYLVRYf4zS/I9dOQ=;
 b=TDan6/UoEJqoBqjBlzwm70o+e58JFE38gxcVUTNLjHRuSgDu6DM58b2Fid00ITTtS6utn+
 3dTKZOxr+dtdLmhfVhdFTjzdtw8fo5OE0Bueuy8wTnkOgfJNvvmh2zp6jQbf1kDhKBa43H
 c4y+uCDyI3p+E+Je6ptMz/m9ZGdJefI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1781275649;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kkd7GIlC3Dt/WTz3TcUT4PnnzDQKYLVRYf4zS/I9dOQ=;
 b=xF544P7FuZ/yNCC/0RHJOiTDa4Ys7sKKm2/nFs5eZW1xw+n69cr2M+qgrriXp34azbl1Fi
 s4wmgJcGYr8f4CDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3AC91779A7;
 Fri, 12 Jun 2026 14:47:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id XQM5DQAcLGoFNAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 12 Jun 2026 14:47:28 +0000
Date: Fri, 12 Jun 2026 16:47:19 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Michael Menasherov <mmenashe@redhat.com>
Message-ID: <aiwb97m9j73IQRmJ@yuki.lan>
References: <20260527092618.14824-1-mmenashe@redhat.com>
 <20260527092618.14824-2-mmenashe@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260527092618.14824-2-mmenashe@redhat.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:dkim];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 553DE77A8C
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v14 1/4] futex_wait06: Add EFAULT error coverage
 test
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
> +	bad = SAFE_MMAP(NULL, getpagesize(), PROT_READ | PROT_WRITE,
> +			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +	SAFE_MUNMAP((void *)bad, getpagesize());
> +}

I've changed the test to use the tst_get_bad_addr() library function
isntead and pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
