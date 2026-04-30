Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E94FBCD13DA
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 15:46:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5E53C3E6C9F
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 17:46:48 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 07ACC3E200D
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 17:46:30 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 79E2960014D
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 17:46:30 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 202666A7CE;
 Thu, 30 Apr 2026 15:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777563989; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ztxqicIAZvD5hNr9cekM4QNn/kixtY6+p+PX91YVzM4=;
 b=XW7X0iT0Ms/QMdfWb2MGXltYIr2Y2qdcabRdx+zieef+SFiJ4ZR+9VNb+GFi8BrovFpkzg
 hrrZ6OOns4xUrpdaE7eyW5VheR2NfoczPdRrsCG4Fhiaf9skommlLSMEYGJDecDRAq5cnU
 PawQ10jusWkDWwzagcUvNgmBKL12n8g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777563989;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ztxqicIAZvD5hNr9cekM4QNn/kixtY6+p+PX91YVzM4=;
 b=vucU8ub82elz9e2ypQT8x53v2u/v9+u+5x4bIVimja73ttWKMFyjDg4OOuW8TP09GQQMwg
 QxeaGmsXrq7Xq9DA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777563989; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ztxqicIAZvD5hNr9cekM4QNn/kixtY6+p+PX91YVzM4=;
 b=XW7X0iT0Ms/QMdfWb2MGXltYIr2Y2qdcabRdx+zieef+SFiJ4ZR+9VNb+GFi8BrovFpkzg
 hrrZ6OOns4xUrpdaE7eyW5VheR2NfoczPdRrsCG4Fhiaf9skommlLSMEYGJDecDRAq5cnU
 PawQ10jusWkDWwzagcUvNgmBKL12n8g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777563989;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ztxqicIAZvD5hNr9cekM4QNn/kixtY6+p+PX91YVzM4=;
 b=vucU8ub82elz9e2ypQT8x53v2u/v9+u+5x4bIVimja73ttWKMFyjDg4OOuW8TP09GQQMwg
 QxeaGmsXrq7Xq9DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0FEFA593B0;
 Thu, 30 Apr 2026 15:46:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id LK7UAlV582mnPwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 30 Apr 2026 15:46:29 +0000
Date: Thu, 30 Apr 2026 17:46:25 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <afN5UVfVzGB9l29L@yuki.lan>
References: <20260430-cve-2026-31431-v2-0-1136c09ca67b@suse.com>
 <20260430-cve-2026-31431-v2-2-1136c09ca67b@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260430-cve-2026-31431-v2-2-1136c09ca67b@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] cve-2026-31431: Add page cache corruption
 reproducer
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
> +	TEST(splice(file_fd, &off_in, pipefd[1], NULL, OVERWRITE_SIZE, 0));
> +	if (TST_RET < 0)
> +		tst_brk(TBROK | TTERRNO, "splice(file -> pipe)");
> +
> +	TEST(splice(pipefd[0], NULL, reqfd, NULL, OVERWRITE_SIZE, 0));
> +	if (TST_RET < 0)
> +		tst_brk(TBROK | TTERRNO, "splice(pipe -> AF_ALG)");

I guess that we should add SAFE_SPLICE() but we can as well do that on
the top of this patch.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
