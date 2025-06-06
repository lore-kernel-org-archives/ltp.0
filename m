Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE52C5B549
	for <ltp@archiver.kernel.org>; Fri,  6 Jun 2025 09:09:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 725A23C9B0E
	for <ltp@archiver.kernel.org>; Fri,  6 Jun 2025 11:09:25 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 81B7F3C9A68
 for <ltp@lists.linux.it>; Fri,  6 Jun 2025 11:09:09 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 91D38200067
 for <ltp@lists.linux.it>; Fri,  6 Jun 2025 11:09:08 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8C5A422875;
 Fri,  6 Jun 2025 09:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1749200947; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=puhJPv1oCTT0ZIXMlRlSoNYfXIwG93lbtufmG0W+9/g=;
 b=soJfAwTwUxvFERjG0p/lxOG7UekYw9iovMdZMgmuruCgLA+iZ+nbt1GOZhpN+H3h6BviUP
 8TxmnDZINRvfrczcPid3248FEBZ5fvAUZ0DvJ+qhMcwHtvHzys7/Mo4kSwPDquDu61M91x
 BVlIk/0T+58cosm+DQBjmUrnh3xqPE8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1749200947;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=puhJPv1oCTT0ZIXMlRlSoNYfXIwG93lbtufmG0W+9/g=;
 b=nbp/yUNbh7INYf776U6ALAzFXjNxPJO3xoj2wft/uNqAjCTPm9wuaZpjKD2SgM6Lf6vduU
 /fmGCZ9RzWqG62CQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=soJfAwTw;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="nbp/yUNb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1749200947; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=puhJPv1oCTT0ZIXMlRlSoNYfXIwG93lbtufmG0W+9/g=;
 b=soJfAwTwUxvFERjG0p/lxOG7UekYw9iovMdZMgmuruCgLA+iZ+nbt1GOZhpN+H3h6BviUP
 8TxmnDZINRvfrczcPid3248FEBZ5fvAUZ0DvJ+qhMcwHtvHzys7/Mo4kSwPDquDu61M91x
 BVlIk/0T+58cosm+DQBjmUrnh3xqPE8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1749200947;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=puhJPv1oCTT0ZIXMlRlSoNYfXIwG93lbtufmG0W+9/g=;
 b=nbp/yUNbh7INYf776U6ALAzFXjNxPJO3xoj2wft/uNqAjCTPm9wuaZpjKD2SgM6Lf6vduU
 /fmGCZ9RzWqG62CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7D15C1336F;
 Fri,  6 Jun 2025 09:09:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IRkZHjOwQmj2FAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 06 Jun 2025 09:09:07 +0000
Date: Fri, 6 Jun 2025 11:09:39 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <aEKwU5oJjaM2PJEQ@yuki.lan>
References: <20250605-lsm_fix_attr_is_overset-v2-1-dd10ddb04238@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250605-lsm_fix_attr_is_overset-v2-1-dd10ddb04238@suse.com>
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: 8C5A422875
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] lsm: fix overset attr test
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
> LSM(s) usually handle their own internal errors in a different way,
> so the right way to check if they return error, is to verify that the
> common return value is -1. This is the max we can do, since errno might
> vary according to the LSM implementation.

Is there a small set of errnos that would make sense for each failure?

We have TST_EXP_FAIL_ARR() for filesystem tests for the case where there
are a few different possible error outcomes, maybe the same approach
would work here as well.

> At the same time, overset attr test is _not_ checking if attr is
> overset, but rather checking if attr is out-of-bounds, considering OR
> operator as a valid way to generate an invalid value with
> LSM_ATTR_CURRENT. This is not correct, since any OR operation using
> LSM_ATTR_CURRENT will generate a valid value for the LSM(s) code. So we
> remove this test that doesn't make much sense at the moment and replace
> it with an "invalid attr test" instead.

That part looks good to me.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
