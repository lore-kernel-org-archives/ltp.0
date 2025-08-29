Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5090DCA0FF7
	for <ltp@archiver.kernel.org>; Fri, 29 Aug 2025 10:23:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CC6613CD151
	for <ltp@archiver.kernel.org>; Fri, 29 Aug 2025 12:23:13 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0CA993C64AD
 for <ltp@lists.linux.it>; Fri, 29 Aug 2025 12:22:59 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id AC9CC20092F
 for <ltp@lists.linux.it>; Fri, 29 Aug 2025 12:22:58 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F27635C072
 for <ltp@lists.linux.it>; Fri, 29 Aug 2025 10:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1756462978; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8RzufxUJLqXkRSYkNelRO3OCFhvjNkzsH1xLyoeDogA=;
 b=gRDcE21OC4Y5rMZjSw0LYf9437D4hqVfqMTLLzR94wuCFGixh7VPpkuBylSh4ZVkHpjJbs
 0W8LXwYZ37moboWv+bFd/szjj023GdSF3UI7/LIQJpdWLa/QNDy4VBvNIYxS3/f5/Dyl7x
 C00gHtVXxTDoZKOU/kaqcVg41SAf9ek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1756462978;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8RzufxUJLqXkRSYkNelRO3OCFhvjNkzsH1xLyoeDogA=;
 b=HkZhbqH3hSVOzecwhIZ3uKOgy99CAP+5DBJ76bOAGaceMAGSoOea2BCPr2Ec0EuCB7FHoY
 vzcFPbEBmzkGPzBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1756462977; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8RzufxUJLqXkRSYkNelRO3OCFhvjNkzsH1xLyoeDogA=;
 b=Z1c5e05pbyTIu6jTboN6IiPFSo337//2nD6zoA/Nx/Den2Kko6kHPLmTzDOj+gvct+mrOl
 q75ftucee4komouM1+aMHugYRwyKe57kGyGe+mz1EW/Z9nqZaxdLXpzQuJcn2PY9wWPI7e
 UOJe+AWuvXCt/qU7wfiiIPBo/K6MCOI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1756462977;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8RzufxUJLqXkRSYkNelRO3OCFhvjNkzsH1xLyoeDogA=;
 b=Ve4lAzybPR+WmPQi0FhRvFqWU+w60ynj7kNkOIoZmSNUFwa4qjnC01f3VhUzJocOkCL0uN
 OM4et1cDaZcAhkDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CFD2313A3E
 for <ltp@lists.linux.it>; Fri, 29 Aug 2025 10:22:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id XDvTMYF/sWj1RAAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Fri, 29 Aug 2025 10:22:57 +0000
Date: Fri, 29 Aug 2025 12:23:25 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Message-ID: <aLF_nbfCZ151UVWv@yuki.lan>
References: <20250630153205.19017-1-chrubis@suse.cz>
 <aGPg2tAoKpyyCTpK@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aGPg2tAoKpyyCTpK@yuki.lan>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] lib: Add is_fuse flag to SAFE_MOUNT() and
 tst_device
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> FYI the CI fails here because it needs to be applied over the first
> patch for SAFE_MOUNT(). I should have probably send the changes as a
> single patcheset.

Ping. Can anyone have a look please?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
