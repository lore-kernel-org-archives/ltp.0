Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 024FECD98C5
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 12:36:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5FDC73E5DAE
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 14:36:55 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8F7803E59B9
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 14:36:37 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5E7EE60098C
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 14:36:34 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B9F0875B7B;
 Mon, 15 Jun 2026 12:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1781526993; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kRKE29/DAgdiXYAgyWqRUoFYJdY28dH13Uel+Cxfd3c=;
 b=iAOhHA3ZuSIOB40PO1PSzCJEme2paYAFmOZXI/xySpw/5StUguGSryK1ZjDt0V1wSkERz6
 GuIOjWJVcFb9Qgpy/Fd2zqT9dLNj6ZvWm/rDlgxgvMbxs/mhc8LNKfiNVl0mWl23+AA9wY
 QZEDpGiTlZPJtgkY/J3A9tKBtP5fXvs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1781526993;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kRKE29/DAgdiXYAgyWqRUoFYJdY28dH13Uel+Cxfd3c=;
 b=rk8e0S3ADlBKAz9eG6sNN+8lH9tMzCtUhoHrr1Rpri3Dy5nB3PU+2gCkG7cQ641RiUxs+S
 t0DQZaInWzOwrtCQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=iAOhHA3Z;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=rk8e0S3A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1781526993; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kRKE29/DAgdiXYAgyWqRUoFYJdY28dH13Uel+Cxfd3c=;
 b=iAOhHA3ZuSIOB40PO1PSzCJEme2paYAFmOZXI/xySpw/5StUguGSryK1ZjDt0V1wSkERz6
 GuIOjWJVcFb9Qgpy/Fd2zqT9dLNj6ZvWm/rDlgxgvMbxs/mhc8LNKfiNVl0mWl23+AA9wY
 QZEDpGiTlZPJtgkY/J3A9tKBtP5fXvs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1781526993;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kRKE29/DAgdiXYAgyWqRUoFYJdY28dH13Uel+Cxfd3c=;
 b=rk8e0S3ADlBKAz9eG6sNN+8lH9tMzCtUhoHrr1Rpri3Dy5nB3PU+2gCkG7cQ641RiUxs+S
 t0DQZaInWzOwrtCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A45F3779A7;
 Mon, 15 Jun 2026 12:36:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Hc2QJtHxL2rMewAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 15 Jun 2026 12:36:33 +0000
Date: Mon, 15 Jun 2026 14:36:34 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ai_x0tylGb7f-XHZ@yuki.lan>
References: <20260610-fix_buildsystem_modules-v1-1-7f24a774d19d@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260610-fix_buildsystem_modules-v1-1-7f24a774d19d@suse.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: B9F0875B7B
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] build: run make check on test sources in kernel
 module directories
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
> In directories that build a kernel module, module.mk set CHECK_TARGETS
> with ':=' before env_post.mk could populate it via '?=', leaving it empty
> so 'make check' never ran sparse/checkpatch on the test sources. The filter
> also used a '%.ko' pattern that never matched any 'check-<name>' entry.
> 
> Drop the broken assignment from module.mk and instead exclude the kernel
> module sources (MODULE_SOURCES) in env_post.mk once CHECK_TARGETS has been
> populated, so test sources are checked while kernel module code is skipped.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

Also I guess that we may want to run vanilla checkpatch for the module
sources, but that would require a bigger changes I suppose.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
